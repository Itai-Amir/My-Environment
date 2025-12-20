#!/bin/bash
# Interactive script to register and start a GitHub Actions runner for a repo
set -e
if ! command -v gh >/dev/null 2>&1; then
  echo "Please install GitHub CLI (gh) and authenticate first: https://cli.github.com/"
  exit 1
fi
read -p "Enter target repo (owner/repo): " REPO
TOKEN=$(gh api -XPOST /repos/$REPO/actions/runners/registration-token -q .token)
if [ -z "$TOKEN" ]; then
  echo "Failed to obtain registration token. Check permissions."
  exit 1
fi
RUNNER_DIR=~/actions-runners/$(echo $REPO | sed 's/\//_/g')
mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"
# Download runner (macOS arm64 example)
LATEST=$(gh api repos/actions/runner/releases/latest --jq '.tag_name')
ARCHIVE_URL="https://github.com/actions/runner/releases/latest/download/actions-runner-osx-arm64.tar.gz"
curl -L -o actions-runner.tar.gz "$ARCHIVE_URL"
tar xzf actions-runner.tar.gz
./config.sh --url https://github.com/$REPO --token "$TOKEN" --name "$(hostname)-$USER" --labels self-hosted,mac-local --work _work
cat > run-with-pyenv.sh <<'EOF'
#!/bin/bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)" 2>/dev/null || true
fi
cd "$(dirname "$0")"
exec ./svc.sh run
EOF
chmod +x run-with-pyenv.sh
./svc.sh install || true
./svc.sh start || true

echo "Runner registered and started in $RUNNER_DIR"
