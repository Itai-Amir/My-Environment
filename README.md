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

Onboarding — Quick Start (new project)
-------------------------------------

Follow these steps to bootstrap a new project on your machine so VS Code and Copilot immediately pick up your environment and CI expectations.

1) Clone your new project (or create a new folder):

	```bash
	git clone git@github.com:YourUser/your-new-project.git
	cd your-new-project
	```

2) Copy the common workspace settings and Copilot instruction file from this template:

	```bash
	# from where you cloned My-Environment
	cp -r ~/Projects/My-Environment/.vscode ./
	cp ~/Projects/My-Environment/COPILOT_INSTRUCTIONS.md ./
	mkdir -p .github/workflows
	cp ~/Projects/My-Environment/.github/workflows/ci-template.yml .github/workflows/ci.yml
	mkdir -p dotfiles
	cp ~/Projects/My-Environment/dotfiles/.zshrc.local dotfiles/
	```

3) (Optional) Pin the pyenv Python version for the project:

	```bash
	# set the version you want, e.g. 3.11.4
	echo "3.11.4" > .python-version
	```

4) Install or activate your venv locally (optional but recommended):

	```bash
	python3 -m venv .venv
	source .venv/bin/activate
	pip install --upgrade pip pytest pytest-cov
	```

5) Run tests locally to verify environment is correct:

	```bash
	pytest tests
	```

6) If you want CI to use a local self-hosted runner on your Mac:

	- Install the GitHub Runner for your repo or organization (see `scripts/bootstrap-runner.sh` in this repo). This script uses the `gh` CLI to generate a registration token and register the runner.
	- The runner will be registered with labels `self-hosted` and `mac-local`. The provided CI template uses those labels.

	```bash
	# from this template repo
	~/Projects/My-Environment/scripts/bootstrap-runner.sh
	```

7) Commit and push the copied files to your new project:

	```bash
	git add .vscode COPILOT_INSTRUCTIONS.md .github dotfiles .python-version
	git commit -m "chore: add project workspace template and CI"
	git push origin main
	```

8) Open the project in VS Code. The workspace settings will point VS Code to your pyenv shims; Copilot will read `COPILOT_INSTRUCTIONS.md` for contextual guidance.

Notes and tips
--------------
- If you prefer, use `scripts/bootstrap-project.sh /path/to/project` from this template to copy files automatically.
- For organization-level runners (shared across projects), register the runner at the organization level instead of per-repo.
- Keep secrets in GitHub Secrets, not in repository files.

If you want, I can also add a Makefile or convenience `apply-template.sh` to automate steps 2–4. Reply "Automate" and I'll add it.
