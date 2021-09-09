#!/usr/bin/env python3
"""
# scripts/manifest/lib/pretty_print.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# pretty print functions for nice output.
#
"""


def p_print(n: int, m: str) -> None:
    """
        pretty print messages with an indent of n chars.
    :param n: int (indent)
    :param m: str (message)
    :return: None
    """
    print(f"{' ' * n}: {m}")
