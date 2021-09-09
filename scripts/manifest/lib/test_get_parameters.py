import unittest
from .get_parameters import get_parameters


class TestGetParameters(unittest.TestCase):
    """
        test get_parameters() function
    """

    def setUp(self) -> None:
        """

        """
        pass

    def test_download_content_hash(self):
        """

        """
        p1 = ["all"]
        p2 = p1 + ["a", "b", "c", "d", "e"]
        assert p2[1:] == get_parameters("all", p2), \
            "Expected 'all' to return list of all options...minus 'all'"
        assert "all" not in p2, \
            f"expect that 'all' will not be in parameters: {p2}"
        assert ["a"] == get_parameters("a", p2), \
            f"Expected ['a'] parameters where 'a' is " \
            f"passed as an input:{get_parameters('a', p2)}"

    def tearDown(self) -> None:
        """

        """
        pass
