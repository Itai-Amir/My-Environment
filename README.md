My-Environment

This repository contains a small scaffold to make VS Code + Copilot pick up your local Python environment (pyenv), standardize project workspace settings, and bootstrap a local GitHub Actions runner on a Mac.

Files:
- `.vscode/settings.json` — workspace settings to prefer pyenv shims and configure analysis paths.
- `.vscode/extensions.json` — recommended extensions.
- `COPILOT_INSTRUCTIONS.md` — guidance Copilot will use when you open this repo.
- `dotfiles/.zshrc.local` — pyenv snippet to source from your shell.
- `scripts/bootstrap-project.sh` — copies template files into a target project.
- `scripts/bootstrap-runner.sh` — interactive script to register and start a local self-hosted runner.
- `.github/workflows/ci-template.yml` — example CI workflow template to copy into new repos.

See the `scripts/` folder for usage notes.
