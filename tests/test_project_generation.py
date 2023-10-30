""" Tests for project generation with cookiecutter """

import os
from contextlib import contextmanager


@contextmanager
def run_within_dir(path: str):
    oldpwd = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(oldpwd)


def test_bake_project(cookies):
    result = cookies.bake(extra_context={"project_name": "my-project"})

    assert result.exit_code == 0
    assert result.exception is None
    assert result.project_path.name == "my-project"
    assert result.project_path.is_dir()


def test_not_release_please(cookies, tmp_path):
    """Test that the release please file is not created when release_please = n"""
    with run_within_dir(tmp_path):
        result = cookies.bake(extra_context={"release_please": "n"})
        assert result.exit_code == 0
        assert not os.path.isfile(
            f"{result.project_path}/.github/workflows/release-please.yaml"
        )
        assert os.path.isfile(
            f"{result.project_path}/.github/workflows/bumpversion.yaml"
        )
        assert os.path.isfile(f"{result.project_path}/.cz.toml")


def test_not_bumpversion(cookies, tmp_path):
    """Test that the bump version files is not created when release_please = y"""
    with run_within_dir(tmp_path):
        result = cookies.bake(extra_context={"release_please": "y"})
        assert result.exit_code == 0
        assert os.path.isfile(
            f"{result.project_path}/.github/workflows/release-please.yaml"
        )
        assert not os.path.isfile(
            f"{result.project_path}/.github/workflows/bumpversion.yaml"
        )
        assert not os.path.isfile(f"{result.project_path}/.cz.toml")
