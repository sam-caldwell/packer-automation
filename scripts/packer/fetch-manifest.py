#!/usr/bin/env python3
#
# fetch-manifest.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# This script will read a given manifest YAML file download the artifacts to
# a given asset caching directory and verify their md5 or sha1 hash.
#
import yaml
from sys import exit
from os.path import exists
from os.path import dirname
from os.path import abspath
from argparse import Namespace
from argparse import ArgumentParser

PROGRAM_DESCRIPTION = """
This script will read a given manifest YAML file download the artifacts to 
a given asset caching directory and verify their md5 or sha1 hash.
"""


def get_args() -> Namespace:
    """
        Parse cli arguments.

        :return: argparse.Namespace
    """
    parser = ArgumentParser(description=PROGRAM_DESCRIPTION)
    parser.add_argument(
        "--type",
        dest="type",
        choices=["iso", "windows", "linux/deb",
                 "linux/rpm", "linux/src", "macos"],
        required=True,
        help="Asset class (group) to be downloaded.  This is a section "
             "within the manifest yaml file."
    )
    parser.add_argument(
        "--manifest",
        dest="manifest",
        type=str,
        required=True,
        help="Manifest path/filename"
    )
    args = parser.parse_args()
    if not exists(args.manifest):
        print(f"Manifest file not found: '{args.manifest}'")
        exit(1)
    return args


def read_manifest(manifest_file: str, section: str) -> dict:
    """
        Read the yaml manifest and return the section (dict) provided.

        :param manifest_file: str
        :param section: str
        :return: dict
    """
    with open(manifest_file, 'r') as f:
        yaml_data = yaml.safe_load_all(f)
        return {
            "data": yaml_data[section]
        }


def main() -> None:
    """
        Main function.
        :return: None
    """
    args = get_args()
    manifest = read_manifest(args.manifest, args.type)


if __name__ == "__main__":
    main()
