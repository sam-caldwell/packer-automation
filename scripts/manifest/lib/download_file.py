#!/usr/bin/env python3
"""
# scripts/manifest/lib/download_file.py
# (c) 2020 Sam Caldwell.  See LICENSE.txt.
#
# download a binary file over http/https from a given url
#
"""
from urllib.request import urlopen
from shutil import copyfileobj
from os.path import exists
from .error import fatal


def download_file(download_url: str, file_name: str) -> bool:
    """
        Download the artifact at `download_url` as `file_name`.

        :param download_url: str
        :param file_name: str
        :return: bool (error state)
    """
    try:
        with urlopen(download_url) as response:
            with open(file_name, 'wb') as out_file:
                copyfileobj(response, out_file)
        return exists(file_name)
    except Exception as ex:
        fatal(f"Error downloading file: {ex}", 10)
