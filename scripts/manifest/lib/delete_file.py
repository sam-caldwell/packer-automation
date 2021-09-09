#!/usr/bin/env python3
"""
# scripts/manifest/lib/delete_file.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# safely delete file from disk
#
"""
from os import unlink
from os.path import exists
from .pretty_print import p_print


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
