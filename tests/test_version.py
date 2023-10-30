from pathlib import Path
import toml


def test_version():
    with Path("pyproject.toml").open(encoding="utf8") as toml_file:
        pyproject_toml = toml.load(toml_file)

    poetry_version = pyproject_toml["tool"]["poetry"]["version"]
    commitizen_version = pyproject_toml["tool"]["commitizen"]["version"]
    assert poetry_version
    assert commitizen_version
    assert f"v{commitizen_version}" == poetry_version
