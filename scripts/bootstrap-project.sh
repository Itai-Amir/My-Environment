#!/bin/bash
# Copy the My-Environment templates into a target project
set -e
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/project"
  exit 1
fi
TARGET=$1
echo "Bootstrapping project at $TARGET"
mkdir -p "$TARGET/.vscode"
cp -a "$(dirname "$0")/../.vscode/settings.json" "$TARGET/.vscode/"
cp -a "$(dirname "$0")/../.vscode/extensions.json" "$TARGET/.vscode/"
cp -a "$(dirname "$0")/../COPILOT_INSTRUCTIONS.md" "$TARGET/"
mkdir -p "$TARGET/dotfiles"
cp -a "$(dirname "$0")/../dotfiles/.zshrc.local" "$TARGET/dotfiles/"
cp -a "$(dirname "$0")/../.github/workflows/ci-template.yml" "$TARGET/.github/workflows/ci.yml" || true
echo "Bootstrap complete. Review files in $TARGET before committing."
