#!/usr/bin/env python3

import os
import shutil

PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)


def remove_file(filepath: str) -> None:
    os.remove(os.path.join(PROJECT_DIRECTORY, filepath))


def remove_dir(filepath: str) -> None:
    shutil.rmtree(os.path.join(PROJECT_DIRECTORY, filepath))


if __name__ == "__main__":
    if "{{cookiecutter.release_please}}" != "y":
        remove_file(".github/workflows/release-please.yaml")
    else:
        remove_file(".cz.toml")
        remove_file(".github/workflows/bumpversion.yaml")
