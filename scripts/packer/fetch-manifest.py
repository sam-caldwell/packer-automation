#!/usr/bin/env python3
"""
# fetch-manifest.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# This script will read a given manifest YAML file download the artifacts to
# a given asset caching directory and verify their md5 or sha1 hash.
"""
import yaml
import shutil
import hashlib
import urllib.request
from time import time
from sys import exit
from os import unlink
from os import makedirs
from os.path import join
from os.path import exists
from os.path import dirname
from argparse import Namespace
from argparse import ArgumentParser

PROGRAM_DESCRIPTION = """
This script will read a given manifest YAML file download the artifacts to
a given asset caching directory and verify their md5 or sha1 hash.
"""

DEFAULT_MANIFEST = join(
    dirname(
        dirname(
            dirname(__file__))),
    "assets",
    "manifest.yml")

SUPPORTED_HASH_ALGORITHMS = {
    "md5": hashlib.md5,
    "sha1": hashlib.sha1,
    "sha256": hashlib.sha256,
    "sha512": hashlib.sha512
}


def get_args() -> Namespace:
    """
        Parse cli arguments.

        :return: argparse.Namespace
    """
    parser = ArgumentParser(description=PROGRAM_DESCRIPTION)
    parser.add_argument(
        "--manifest",
        dest="manifest",
        type=str,
        default=DEFAULT_MANIFEST,
        required=True,
        help="Manifest path/filename")
    parser.add_argument(
        "--asset_cache_dir",
        dest="asset_cache_dir",
        type=str,
        required=False,
        default=dirname(DEFAULT_MANIFEST),
        help="Optional asset cache directory.")
    parser.add_argument(
        "--force",
        dest="force",
        default=False,
        action='store_true',
        help="Use force on download (deletes if it exists.")
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


def fatal_error(m: str, e: int = 1) -> None:
    """
        Print fatal error message then exit with the given exit code.
        :param m: str (message)
        :param e: int (exit code)
        :return: None
    """
    print(f"{m}")
    exit(e)


def url_string(s: str) -> bool:
    """
        Verify the given string (s) is a URL.

        :param s: string
        :return: bool
    """
    # ToDo: Verify url pattern
    return type(s) is str


def hash_string(s: str) -> bool:
    """
        Verify the manifest hash string for a given artifact.

        :param s: str
        :return: bool
    """
    # ToDo: verify hash pattern
    return type(s) is str


def alg_string(s: str) -> bool:
    """
        Verify the manifest alg parameter (which
        will determine which hashing algorithm
        is used).

        :param s: str
        :return: bool
    """
    return type(s) is str and (
            s in [k for k, _ in SUPPORTED_HASH_ALGORITHMS.items()]
    )


def verify_hash_bool(b: bool) -> bool:
    """
        Verify the manifest verify_hash flag (boolean)

        :param b:
        :return:
    """
    return type(b) is bool


def download_bool(b: bool) -> bool:
    """
        Verify the manifest download flag (boolean)

        :param b: bool
        :return: bool
    """
    return type(b) is bool


def get_parameters(item: str, block: list) -> list:
    """
        evaluate a class of items to download and
        return the list of actual objects to download.

        :return: list
    """
    if item == "all":
        return block[1:]
    else:
        return [item]


def get_versions(inp_block: dict) -> list:
    """
        evaluate a dictionary and return a list of the keys.

        :param inp_block: dict
        :return: list
    """
    return ["all"] + [k for k, _ in inp_block.items()]


def download_file(download_url: str, file_name: str) -> bool:
    """
        Download the artifact at `download_url` as `file_name`.

        :param download_url: str
        :param file_name: str
        :return: bool (error state)
    """
    try:
        with urllib.request.urlopen(download_url) as response:
            with open(file_name, 'wb') as out_file:
                shutil.copyfileobj(response, out_file)
        return exists(file_name)
    except Exception as ex:
        fatal_error(f"Error downloading file: {ex}", 10)


def read_manifest(manifest_file: str) -> dict:
    """
        Read the yaml manifest and return parsed
        dict content.

        :param manifest_file: str
        :return: dict
    """
    with open(manifest_file, 'r') as f:
        yaml_data = yaml.load(f, Loader=yaml.FullLoader)
        return yaml_data


def create_target_dir(file_name: str) -> bool:
    """
        Create directory path string and the underlying directory if it
        does not exist and return the full string.

        :param file_name: str
        :return: bool
    """
    target_dir = dirname(file_name)
    if not exists(target_dir):
        makedirs(target_dir)
    return exists(target_dir)


def file_hasher(hash_alg: callable, fname: str) -> str:
    """
        Given a hash function and file name, perform the hash operation
        and return the resulting hash string.

        :param hash_alg: object
        :param fname: str
        :return: str
    """
    buf_size = 1048576  # 1MB chunks
    hasher = hash_alg()
    with open(fname, 'rb') as f:
        while True:
            data = f.read(buf_size)
            if not data:
                break
            hasher.update(data)
    return hasher.hexdigest()


def verify_file_hash(filename: str, expected_hash: str, alg: str,
                     verify: bool = False) -> bool:
    """
        Verify the filename has the expected hash.

        :param filename: str
        :param expected_hash: str
        :param alg: str
        :param verify: bool
        :return: bool
    """

    def bad_hash():
        fatal_error(f"unknown or unsupported algorithm: "
                    f"{alg} on {filename}", 1)

    hash_alg = SUPPORTED_HASH_ALGORITHMS.get(alg, bad_hash)
    this_hash = file_hasher(hash_alg, filename).strip().lower()
    p_print(10, f"hashes: {this_hash} == {expected_hash}")
    return this_hash == expected_hash.strip().lower()


def delete_file(file_name: str, force: bool = False) -> None:
    """
        Delete a given file.
        :param file_name: str
        :param force: bool
        :return: None
    """
    if force and exists(file_name):
        p_print(8, f"File exists.  Deleting (--force detected): {file_name}")
        unlink(file_name)
        if exists(file_name):
            p_print(8, f"Check permissions.  Failed to delete {file_name}")
            exit(1)


def p_print(n: int, m: str) -> None:
    """
        pretty print messages with an indent of n chars.
    :param n: int (indent)
    :param m: str (message)
    :return: None
    """
    print(f"{' ' * n}: {m}")


def download_assets(manifest_file: str, asset_cache_dir: str,
                    force: bool = False) -> None:
    """
        Download iso images and packages to the asset_cache_dir directory.

        :param manifest_file: str
        :param asset_cache_dir: str
        :param force: bool
        :return: None
    """
    manifest = read_manifest(manifest_file)
    for section, section_block in manifest.items():
        p_print(0, f"Section: {section}")
        for arch, arch_block in section_block.items():
            p_print(2, f"Arch: {arch}")
            for opsys, opsys_block in arch_block.items():
                p_print(4, f"Opsys: {opsys}")
                for version, block in opsys_block.items():
                    p_print(6, f"Version: {version}")
                    target_dir = join(asset_cache_dir, section, arch, opsys)
                    file_name = join(target_dir, f"{version}.iso")
                    alg = block.get("alg", False)
                    file_hash = block.get("hash", False)
                    p_print(8, f"Download: Starting ({file_name})")
                    if block.get("download"):
                        url = block.get("url")
                        create_target_dir(file_name=file_name)
                        delete_file(file_name, force)
                        if exists(file_name):
                            p_print(8, f"Download: exists (verifying) "
                                       f"({file_name})")
                            if verify_file_hash(expected_hash=file_hash,
                                                alg=alg,
                                                filename=file_name):
                                p_print(8, f"Download: skipped (exists) "
                                           f"({file_name}) (verified)")
                                continue
                            else:
                                p_print(8, "Existing file failed integrity "
                                           "check...deleting to download "
                                           "again.")
                                delete_file(file_name=file_name, force=True)
                        start_time = time()
                        p_print(8, f"Downloading ({file_name}) "
                                   f"(time: {start_time})")
                        if not download_file(url, file_name):
                            fatal_error(f"Download failed.  "
                                        f"File: {file_name}")
                        stop_time = time()
                        p_print(8, f"Download: complete ({file_name}) "
                                   f"(time elapsed: "
                                   f"{stop_time - start_time})")
                        if block.get("verify_hash", False):
                            p_print(8, f"Download: verifying "
                                       f"({file_name})")
                            verify_file_hash(expected_hash=file_hash,
                                             alg=alg,
                                             filename=file_name)
                        else:
                            p_print(8, f"Download: "
                                       f"verification disabled "
                                       f"({file_name})")
                    else:
                        p_print(8, f"Download: disabled ({file_name})")


def summary(args: Namespace) -> None:
    """
        print a pretty summary

        :param args: Namespace
        :return: None
    """
    print(f"\tManifest file:   {args.manifest}")
    print(f"\tAsset Cache Dir: {args.asset_cache_dir}\n")


def main() -> int:
    """
        Main function.
        :return: int (exit code)
    """
    try:
        print("Starting fetch-manifest.py to download assets.")
        args = get_args()
        summary(args)
        download_assets(manifest_file=args.manifest,
                        asset_cache_dir=args.asset_cache_dir,
                        force=args.force)
        summary(args)
    except KeyboardInterrupt:
        return 0
    except Exception as ex:
        print(f"Fatal Error: {ex}")
        return 1


if __name__ == "__main__":
    exit(main())
