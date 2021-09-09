import hashlib
import unittest
from os import unlink
from os.path import exists
from subprocess import run
from .download_file import download_file

proto = "http"
ip = "127.0.0.1"
port = "8080"
image = "test_web_server:local"
dockerfile = "scripts/manifest/lib/test_webserver.docker"
container_name = "TestDownloadFile".lower()
hash_file = "/tmp/test_download_content.hash"
data_name = "/tmp/test_download_content.dat"


def shell_exec(cmd: list) -> bool:
    """
        Exec a shell command and return a boolean based on exit code."
        :param cmd: str
        :return: bool
    """
    result = run(cmd)
    return result.returncode == 0


class TestDownloadFile(unittest.TestCase):
    """
        test download_file() function
    """

    def setUp(self) -> None:
        """


        """
        cmd = ["docker", "build",
               "-f", dockerfile,
               "--tag", image, "."]
        assert shell_exec(cmd), f"web server test failed to build: {cmd}"

        cmd = ["docker", "run", "-d",
               "--publish", f"{port}:{port}",
               "--name", container_name, image]
        assert shell_exec(cmd), f"web server test failed to start: {cmd}"

        cmd = ["/usr/bin/curl", f"{proto}://{ip}:{port}/content.hash"]
        assert shell_exec(cmd), f"web server test failed: {cmd}"

    def test_download_content_hash(self):
        """

        """

        hash_url = f"{proto}://{ip}:{port}/content.hash"
        data_url = f"{proto}://{ip}:{port}/content.dat"
        download_file(download_url=data_url, file_name=data_name)
        download_file(download_url=hash_url, file_name=hash_file)
        with open(hash_file, 'r') as f:
            actual_hash = f.read().strip().lower()
            buf_size = 1048576  # 1MB chunks
            sha256 = hashlib.sha256()
            with open(data_name, 'rb') as d:
                while True:
                    data = d.read(buf_size)
                    if not data:
                        break
                    sha256.update(data)
            expected_hash = sha256.hexdigest().strip().lower()
            assert actual_hash == expected_hash, \
                "Actual does not match expected hash for data signal"

    def tearDown(self) -> None:
        """

        """
        cmd = ["docker", "kill", container_name]
        assert shell_exec(cmd), f"web server test failed to start: {cmd}"

        cmd = ["docker", "rm", container_name]
        assert shell_exec(cmd), f"web server test failed to start: {cmd}"

        if exists(hash_file):
            unlink(hash_file)
        if exists(data_name):
            unlink(data_name)
