#!/usr/bin/env python3
"""
# scripts/manifest/lib/error.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# Standardized fatal error function.
#
"""


def fatal(m: str, e: int = 1) -> None:
    """
        Print fatal error message then exit with the given exit code.
        :param m: str (message)
        :param e: int (exit code)
        :return: None
    """
    print(f"{m}")
    exit(e)
