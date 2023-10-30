# Makefile

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
