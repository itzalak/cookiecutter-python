# Makefile

VENV = .venv

# Poetry configuration
install: poetry-local-venv python-delete-venv poetry-install

poetry-install:
	@echo "creating venv and installing dependencies"
	poetry install

python-delete-venv:
	@echo "removing existent virtualenv"
	rm -rf $(VENV)
	rm -rf venv

poetry-local-venv:
	@echo "setting virtualenv location to project"
	poetry config virtualenvs.in-project true

poetry-get-env:
	poetry env info --path

poetry-update:
	poetry update

poetry-test:
	poetry run pytest

# Pre commit
pre-commit: setup-pre-commit update-pre-commit

setup-pre-commit:
	pre-commit install

update-pre-commit:
	pre-commit autoupdate

# Commitizen bump helper
bump:
	cz bump
	git push --follow-tags
