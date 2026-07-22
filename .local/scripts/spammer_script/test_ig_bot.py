import unittest

from ig_bot import is_related


class FootballDetectionTests(unittest.TestCase):
    def test_accepts_explicit_football_content(self):
        captions = (
            "Messi scores in the World Cup final",
            "Ballon d'Or highlights",
            "Copa America final",
            "Premier League matchday",
            "Lamine Yamal at Barca",
            "Inter Miami training",
            "⚽ golazo",
            "Penalty kick save by the goalkeeper",
        )

        for caption in captions:
            with self.subTest(caption=caption):
                self.assertTrue(is_related(caption))

    def test_rejects_generic_words_and_numbers(self):
        captions = (
            "The aura of this restaurant is everything",
            "This magic trick will blow your mind",
            "My daughter turned 19 today",
            "80s music hits different",
            "Best bench press form for beginners",
            "Oh my God this makeup tutorial is amazing",
            "My ankle surgery recovery day 5",
            "Saudi Arabia travel vlog",
            "Beautiful sunset over the coast",
        )

        for caption in captions:
            with self.subTest(caption=caption):
                self.assertFalse(is_related(caption))

    def test_requires_complete_terms(self):
        captions = (
            "2019 highlights from the concert",
            "Benchmark results are finally finished",
            "A magician performs a new trick",
            "Messi_fan username without a caption",
        )

        for caption in captions:
            with self.subTest(caption=caption):
                self.assertFalse(is_related(caption))

    def test_handles_empty_and_case_variants(self):
        self.assertFalse(is_related(None))
        self.assertFalse(is_related(""))
        self.assertTrue(is_related("MESSI"))
        self.assertTrue(is_related("#PREMIER LEAGUE"))


if __name__ == "__main__":
    unittest.main()
