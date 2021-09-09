#!/usr/bin/env python3
"""
# scripts/manifest/lib/get_versions.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# get the versions list
#
"""


def get_versions(inp_block: dict) -> list:
    """
        evaluate a dictionary and return a list of the keys.

        :param inp_block: dict
        :return: list
    """
    return ["all"] + [k for k, _ in inp_block.items()]
