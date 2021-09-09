#!/usr/bin/env python3
"""
# scripts/manifest/lib/hasher.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# hash a binary file and verify it matches expected hash string.
#
"""
import hashlib
from .error import fatal
from .pretty_print import p_print

SUPPORTED_HASH_ALGORITHMS = {
    "md5": hashlib.md5,
    "sha1": hashlib.sha1,
    "sha256": hashlib.sha256,
    "sha512": hashlib.sha512
}


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
        fatal(f"unknown or unsupported algorithm: "
              f"{alg} on {filename}", 1)

    hash_alg = SUPPORTED_HASH_ALGORITHMS.get(alg, bad_hash)
    this_hash = file_hasher(hash_alg, filename).strip().lower()
    p_print(10, f"hashes: {this_hash} == {expected_hash}")
    return this_hash == expected_hash.strip().lower()
