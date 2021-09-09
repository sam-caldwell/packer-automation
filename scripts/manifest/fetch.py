#!/usr/bin/env python3
"""
# scripts/manifest/fetch.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# This script will read a given manifest YAML file download the artifacts to
# a given asset caching directory and verify their md5 or sha1 hash.
"""

from time import time
from sys import exit
from os.path import join
import lib.error as error
from os.path import exists
from os.path import dirname
from argparse import Namespace
from argparse import ArgumentParser
from lib.pretty_print import p_print
from lib.delete_file import delete_file
from lib.hasher import verify_file_hash
from lib.download_file import download_file
from lib.create_target_dir import create_target_dir

from lib.read_manifest import read_manifest

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


def fetch(manifest_file: str, asset_cache_dir: str,
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
                    url = block.get("url")
                    file_name = join(
                        target_dir,
                        block.get("file",
                                  f"{url.split('/')[-1].lower()}"))
                    alg = block.get("alg", "none")
                    verify_hash = block.get("verify_hash", False)
                    file_hash = block.get("hash", False)
                    p_print(8, f"Download: Starting ({file_name})")
                    if block.get("download"):
                        create_target_dir(file_name=file_name)
                        delete_file(file_name, force)
                        if exists(file_name):
                            p_print(8, f"Download: exists (verifying) "
                                       f"({file_name})")
                            if verify_hash and verify_file_hash(
                                    expected_hash=file_hash,
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
                            error.fatal(f"Download failed.  "
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


if __name__ == "__main__":
    try:
        p_print(0, "Starting fetch-manifest.py to download assets.")
        args = get_args()
        fetch(manifest_file=args.manifest,
              asset_cache_dir=args.asset_cache_dir,
              force=args.force)
        p_print(0, f"\tManifest file:   {args.manifest}")
        p_print(0, f"\tAsset Cache Dir: {args.asset_cache_dir}\n")

    except KeyboardInterrupt:
        exit(0)
    except Exception as ex:
        error.fatal(f"Fatal Error: {ex}")
