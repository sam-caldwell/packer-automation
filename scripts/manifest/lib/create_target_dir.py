#!/usr/bin/env python3
"""
# scripts/manifest/lib/create_target_dir.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# create a target directory (recursively)
#
"""
from os import makedirs
from os.path import exists
from os.path import dirname


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
