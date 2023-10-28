#!/usr/bin/env python3

import os
import shutil

PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)

if "{{cookiecutter.gh_actions}}" != "y":
    print(f"Project directory: {PROJECT_DIRECTORY}")
    shutil.rmtree(os.path.join(PROJECT_DIRECTORY, ".github"))
