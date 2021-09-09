#!/usr/bin/env python3
"""
# scripts/manifest/lib/verify_input.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# input verification functions.
#
"""

from .hasher import SUPPORTED_HASH_ALGORITHMS


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
