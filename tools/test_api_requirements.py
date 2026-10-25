#!/usr/bin/env python3
"""Regression tests for the plugin catalog's supported API range."""

import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("build_index", ROOT / "tools" / "build_index.py")
build_index = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(build_index)


class ApiRequirementsTest(unittest.TestCase):
    def build_fixture(self, api_min):
        with tempfile.TemporaryDirectory() as temp:
            plugins_dir = Path(temp) / "plugins"
            folder = plugins_dir / "Fixture"
            folder.mkdir(parents=True)
            (folder / "Fixture.lua").write_text(
                "plugin.define({ id = 'test.fixture', name = 'Fixture', "
                f"version = '1.0', api_min = {api_min} }})\n",
                encoding="utf-8",
            )
            (folder / "store.json").write_text(
                json.dumps({"description": "API fixture", "category": "Tools"}),
                encoding="utf-8",
            )
            with patch.object(build_index, "PLUGINS_DIR", str(plugins_dir)):
                return build_index.build("fixture")

    def test_supported_api_boundaries_are_accepted(self):
        for api_min in (1, 16, 17):
            with self.subTest(api_min=api_min):
                index, _, _, _ = self.build_fixture(api_min)
                self.assertEqual(index["plugins"][0]["api_min"], api_min)

    def test_out_of_range_api_minima_are_rejected(self):
        for api_min in (0, 18, 19):
            with self.subTest(api_min=api_min):
                with self.assertRaisesRegex(
                    build_index.BuildError,
                    "api_min must be at least 1" if api_min == 0 else "exceeds supported API version 17",
                ):
                    self.build_fixture(api_min)


if __name__ == "__main__":
    unittest.main()
