import unittest
from shutil import rmtree
from os.path import exists
from os.path import dirname
from .create_target_dir import create_target_dir


class TestCreateTargetDir(unittest.TestCase):
    """
        test create_target() function
    """
    new_dir = "testing_directory/a/b/c/d/e/f.txt"

    def setup(self):
        """
            Make sure our test directory does not exist.
        """
        if exists(self.new_dir.split("/")[0]):
            rmtree(self.new_dir.split("/")[0])

    def test_happy(self):
        """
            Create a test directory then delete the same.
        """
        create_target_dir(self.new_dir)
        assert exists(dirname(self.new_dir)), "failed to create directory"

    def tearDown(self):
        """
            Delete our test artifact(s)
        """
        if exists(self.new_dir.split("/")[0]):
            rmtree(self.new_dir.split("/")[0])
