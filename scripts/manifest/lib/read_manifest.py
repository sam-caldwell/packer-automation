#!/usr/bin/env python3
"""
# scripts/manifest/lib/read_manifest.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# read the yaml manifest file.
#
"""

import yaml


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
