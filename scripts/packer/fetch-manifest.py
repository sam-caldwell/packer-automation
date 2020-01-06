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


def get_hash_validation_cmd(alg: str, filename: str) -> list:
    """
        return the
    :param alg: str
    :param filename: str
    :return: list
    """
    if alg == 'md5':
        return ["/sbin/md5", filename, "|", "/usr/bin/awk", "'{print $4}'"]
    elif alg == 'sha1':
        return ["shasum", "-a", "1", filename, "|", "awk", "'{print $1}'"]
    elif alg == 'sha256':
        return ["shasum", "-a", "256", filename, "|", "awk", "'{print $1}'"]
    elif alg == 'sha512':
        return ["shasum", "-a", "512", filename, "|", "awk", "'{print $1}'"]
    else:
        print(f"unknown or unsupported algorithm: {alg} on {filename}")
        exit(1)


def verify_file_hash(filename: str, expected_hash: str, alg: str,
                     verify: bool = False) -> None:
    """
        Verify the filename has the expected hash.

        :param filename: str
        :param expected_hash: str
        :param alg: str
        :param verify: bool
        :return: None
    """
    if verify:
        if alg == 'md5':
            f = ["/sbin/md5", filename], 3
        elif alg == 'sha1':
            f = ["shasum", "-a", "1", filename], 0
        elif alg == 'sha256':
            f = ["shasum", "-a", "256", filename], 0
        elif alg == 'sha512':
            f = ["shasum", "-a", "512", filename], 0
        else:
            print(f"unknown or unsupported algorithm: {alg} on {filename}")
            exit(1)

        print("computing actual hash...")
        with Popen(f[0], stdout=PIPE) as p:
            p.wait()
            print("evaluating results.")
            actual = p.stdout.read() \
                .decode(encoding='utf-8') \
                .strip(' ') \
                .split(' ')[f[1]]
            if expected_hash.strip() != actual.strip():
                print(f"Hash mismatch  : {filename}")
                print(f"\tactual_hash  : {actual}")
                print(f"\texpected_hash: {expected_hash}")
                exit(1)
            else:
                print("hash verified.")
    else:
        print(f"{filename} hash not verified.")


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
        filename = join(target_dir, group_name) + ".iso"
        verify_hash = data.get("verify_hash") or False
        if verify_hash:
            print("verify_hash: true")
            alg, file_hash = data["alg"], data["hash"]
        else:
            print("verify_hash: false")
            alg, file_hash = "", ""

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
                verify_file_hash(
                    expected_hash=file_hash,
                    alg=alg,
                    filename=filename,
                    verify=verify_hash)
                continue

        cmd = ["/usr/bin/curl", "--fail", "--create-dir", "--output",
               filename, url]

        print(f"download command: {' '.join(cmd)}\nDownloading...")
        with Popen(cmd, stdout=PIPE) as curl_proc:
            print(f"{curl_proc.stdout.read()}")
        print("...done.")

        if exists(filename):

            print(f"{filename} downloaded successfully.")
            verify_file_hash(
                expected_hash=file_hash,
                alg=alg,
                filename=filename,
                verify=verify_hash)

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
