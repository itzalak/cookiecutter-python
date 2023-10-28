import argparse
import sys

from version import __version__

def main():
    """Console script for {{cookiecutter.project_slug}}."""
    parser = argparse.ArgumentParser()
    parser.add_argument('_', nargs='*')
    args = parser.parse_args()

    print("Arguments: " + str(args._))
    print(f"Version: {__version__}")
    print("Replace this message by some code!")
    return 0


if __name__ == "__main__":
   sys.exit(main())
