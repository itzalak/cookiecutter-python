# Makefile

checkmark=\xE2\x9C\x94  # Unicode character representation
warning=\xE2\x9A\xA0  # Unicode character representation

define warn
	@tput bold
	@tput setaf 3
	@printf "${warning}${1}\n"
	@tput sgr0
endef

define log
	@tput bold
	@tput setaf 6
	@printf "${checkmark}${1}\n"
	@tput sgr0
endef

.DEFAULT_GOAL := help
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VENV := .venv

###############################################################################
# Default
###############################################################################

.PHONY: help
help:
	@echo "\n|> Directory: ${ROOT_DIR}"
	@echo "|> OS: ${OS}"
	@echo "|> Available targets:\n"
	@make -qpRr | egrep -e '^[a-z].*:$$' | sed -e 's~:~~g' | sort

.PHONY: all
all: clean poetry-install pre-commit
	@$(call warn, init config)

.PHONY: test
test: poetry-test

.PHONY: clean
clean: python-delete-venv

###############################################################################
# Poetry setup and help
###############################################################################

.PHONY: poetry-setup
poetry-setup: poetry-local-venv python-delete-venv poetry-install

.PHONY: poetry-setup
poetry-install:
	@$(call warn, create and install poetry dependencies)
	poetry install
	@$(call log, create and install poetry dependencies)

python-delete-venv:
	@$(call warn, delete existent virtualenv)
	rm -rf $(VENV)
	rm -rf venv
	@$(call log, delete existent virtualenv)

poetry-local-venv:
	@$(call warn, setting virtualenv location to project)
	poetry config virtualenvs.in-project true
	@$(call log, virtualenv set to project location)

poetry-get-env:
	poetry env info --path

poetry-update:
	@$(call warn, update poetry dependencies)
	poetry update
	@$(call log, poetry dependencies update)

poetry-test:
	@$(call warn, run tests with poetry)
	poetry run pytest
	@$(call log, tests done)

###############################################################################
# Pre commit
###############################################################################

pre-commit: pre-commit-setup pre-commit-update

pre-commit-setup:
	@$(call warn, install pre-commit dependencies)
	pre-commit install
	@$(call log, install pre-commit dependencies)

pre-commit-update:
	@$(call warn, update pre-commit dependencies)
	pre-commit autoupdate
	@$(call log, update pre-commit dependencies)

###############################################################################
# Commitizen
###############################################################################

bump:
	@$(call warn, bump version of commitizen)
	cz bump
	@$(call log, Dont forget to push the tags)
	@$(call log, git push --tags)
