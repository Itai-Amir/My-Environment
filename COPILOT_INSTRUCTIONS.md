Copilot instructions for My-Environment

- Default interpreter: pyenv-managed Python. Use ${env:HOME}/.pyenv/shims/python as the workspace interpreter.
- Prefer small, test-covered functions and use `pytest` for testing.
- Recommended venv location: `.venv` in the workspace root.
- For CI, prefer self-hosted runner labels: `self-hosted`, `mac-local`.
- If a new runner is required, run `scripts/bootstrap-runner.sh` and follow prompts.
- Add any project-specific notes to the project's root-level README.
