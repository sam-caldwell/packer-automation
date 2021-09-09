#!/usr/bin/env python3
"""
# scripts/manifest/lib/get_parameters.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# get the parameter list
#
"""


def get_parameters(item: str, block: list) -> list:
    """
        evaluate a class of items to download and
        return the list of actual objects to download.

        :return: list
    """
    if item == "all":
        block.remove("all")
        return block
    else:
        return [item]
