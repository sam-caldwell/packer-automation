import unittest
from os import mkdir
from shutil import rmtree
from os.path import exists
from .delete_file import delete_file


class TestDeleteFile(unittest.TestCase):
    """
        test delete_file() function.
    """
    new_dir = "./testing_directory"
    test_file = f"{new_dir}/file_to_delete.txt"

    def test_happy(self):
        """
            Create a test directory then delete the same.
        """
        if exists(self.new_dir):
            rmtree(self.new_dir)
        mkdir(self.new_dir)
        assert exists(self.new_dir), "failed to create testing directory"

        with open(self.test_file, 'w') as f:
            f.write("test")

        assert exists(self.test_file), \
            f"test file does not exist (expected):{self.test_file}"

        delete_file(self.test_file)

        assert exists(self.test_file), \
            f"test file should still exist " \
            f"(no force used):{self.test_file}"

        delete_file(self.test_file, force=False)

        assert exists(self.test_file), \
            f"test file should still exist " \
            f"(force specifically not used):{self.test_file}"

        delete_file(self.test_file, force=True)

        assert not exists(self.test_file), \
            "test file exists (should have been deleted)."

    def tearDown(self):
        """
            Delete our test artifact(s)
        """
        if exists(self.new_dir):
            rmtree(self.new_dir)
