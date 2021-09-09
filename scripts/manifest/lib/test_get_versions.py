import unittest
from .get_versions import get_versions


class TestGetVersions(unittest.TestCase):
    """
        Test get_versions() function
    """

    def setUp(self) -> None:
        """

        """
        pass

    def test_download_content_hash(self):
        """

        """
        p0 = ["all"]
        p1 = ["a", "b", "c", "d", "e"]
        p2 = p0 + p1
        assert p2 == get_versions(p1), \
            "Expected version to be prepended with 'all'"
        assert p2[0] == 'all', \
            "Expected first element of list to be 'all'"

    def tearDown(self) -> None:
        """

        """
        pass
