import unittest
from apps.utility.pdf import Sample


class SampleTest(unittest.TestCase):

    def test_x(self):
        self.assertEqual(2, Sample().add(1, 1))
