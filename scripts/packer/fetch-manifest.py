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
from os import mkdir
from os import unlink
from os.path import join
from os.path import exists
from os.path import dirname
from subprocess import PIPE
from subprocess import Popen
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

    parser.add_argument(
        "--asset_cache_dir",
        dest="asset_cache_dir",
        type=str,
        required=False,
        default=None,
        help="Optional asset cache directory."
    )

    parser.add_argument(
        "--force",
        dest="force",
        default=False,
        action='store_true',
        help="Use force on download (deletes if it exists."
    )

    args = parser.parse_args()

    if not exists(args.manifest):
        print(f"Manifest file not found: '{args.manifest}'")
        exit(1)

    if args.asset_cache_dir is None:
        args.asset_cache_dir = dirname(args.manifest)

    if not exists(args.asset_cache_dir):
        print(f"Asset cache directory not found: {args.asset_cache_dir}")
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
        yaml_data = yaml.load(f, Loader=yaml.FullLoader)
        if section not in yaml_data:
            print(f"ERROR: Section ({section}) not found in manifest.")
            exit(1)
        return yaml_data[section]


def create_target_dir(base_dir: str, asset_dir: str) -> str:
    """
        Create directory path string and the underlying directory if it
        does not exist and return the full string.
        :param base_dir: str
        :param asset_dir: str
        :return: str
    """
    target_dir = join(base_dir, asset_dir)
    if not exists(target_dir):
        mkdir(target_dir)
    return target_dir


def verify_file_hash(file_hash: str, alg: str, filename: str) -> None:
    """
        Verify the filename has the expected hash.

        :param file_hash: str
        :param alg: str
        :param filename: str
        :return: None
    """
    pass


def download_assets(manifest: dict, asset_cache_dir: str, asset_type: str,
                    force: bool = False) -> None:
    """
        Down iso images to the asset_cache_dir directory.

        :param manifest: dict
        :param asset_cache_dir: str
        :param asset_type: str
        :param force: bool (do we download if the file already exists?)
        :return: None
    """
    target_dir = create_target_dir(asset_cache_dir, asset_type)
    print(f"manifest_size: {len(manifest)}")

    for group_name, data in manifest.items():
        if not data["download"]:
            print(f"{group_name} skipped (download == false)")
            continue

        print(f"Loading group: {group_name}")
        url = data["url"]
        file_hash = data["hash"]
        alg = data["alg"]

        filename = join(target_dir, group_name) + ".iso"

        if exists(filename):

            if force:
                print(f"{filename} exists.  But --force requires delete "
                      f"and download of the asset..")
                unlink(filename)
                if exists(filename):
                    print(f"Check permissions.  Failed to delete {filename}")
                    exit(1)
            else:
                print(f"{filename} exists.  not downloading.")
                continue

        cmd = ["/usr/bin/curl", "--fail", "--create-dir", "--output",
               filename, url]

        print(f"download command: {' '.join(cmd)}\nDownloading...")
        with Popen(cmd, stdout=PIPE) as curl_proc:
            print(f"{curl_proc.stdout.read()}")
        print("...done.")

        if exists(filename):

            print(f"{filename} downloaded successfully.")
            verify_file_hash(file_hash, alg, filename)

        else:

            print(f"{filename} download failed.")
            exit(1)


def main() -> None:
    """
        Main function.
        :return: None
    """
    print("Starting fetch-manifest.py to download assets.")

    args = get_args()

    print(f"\tManifest file:   {args.manifest}")
    print(f"\tAsset type:      {args.type}")
    print(f"\tAsset Cache Dir: {args.asset_cache_dir}\n")

    manifest = read_manifest(args.manifest, args.type)

    download_assets(manifest,
                    asset_cache_dir=args.asset_cache_dir,
                    asset_type=args.type,
                    force=args.force
                    )


if __name__ == "__main__":
    main()
