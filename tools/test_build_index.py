import hashlib
import json
import os
import pathlib
import subprocess
import tempfile
import unittest

from PIL import Image

import sys
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1] / "tools"))
import build_index


class PreviewGenerationTests(unittest.TestCase):
    def make_image(self, path, size, color=(40, 90, 130), format="PNG"):
        Image.new("RGB", size, color).save(path, format=format)
        return path

    def test_portrait_and_landscape_fit_without_crop_or_stretch(self):
        with tempfile.TemporaryDirectory() as temp:
            portrait = self.make_image(os.path.join(temp, "portrait.png"), (480, 800))
            first, second = build_index.make_preview_variants(portrait, "portrait", "Portrait")
            self.assertEqual((first["width"], first["height"]), (195, 325))
            self.assertEqual((second["width"], second["height"]), (130, 216))

            landscape = self.make_image(os.path.join(temp, "landscape.png"), (800, 400))
            first, second = build_index.make_preview_variants(landscape, "landscape", "Landscape")
            self.assertEqual((first["width"], first["height"]), (217, 109))
            self.assertEqual((second["width"], second["height"]), (144, 72))

    def test_small_source_is_never_upscaled(self):
        with tempfile.TemporaryDirectory() as temp:
            source = self.make_image(os.path.join(temp, "small.png"), (100, 50))
            variants = build_index.make_preview_variants(source, "small", "Small")
            self.assertEqual([(v["width"], v["height"]) for v in variants], [(100, 50)])

    def test_invalid_and_oversized_sources_are_rejected(self):
        with tempfile.TemporaryDirectory() as temp:
            invalid = os.path.join(temp, "invalid.png")
            pathlib.Path(invalid).write_bytes(b"not an image")
            with self.assertRaises(build_index.BuildError):
                build_index.make_preview_variants(invalid, "invalid", "Invalid")

            oversized = self.make_image(os.path.join(temp, "oversized.png"), (4097, 1))
            with self.assertRaisesRegex(build_index.BuildError, "source dimensions"):
                build_index.make_preview_variants(oversized, "oversized", "Oversized")

            oversized_bytes = os.path.join(temp, "oversized-bytes.png")
            pathlib.Path(oversized_bytes).write_bytes(b"x" * (build_index.MAX_PREVIEW_SOURCE_BYTES + 1))
            with self.assertRaisesRegex(build_index.BuildError, "preview source must be"):
                build_index.make_preview_variants(oversized_bytes, "oversized-bytes", "OversizedBytes")

    def test_output_is_deterministic_and_has_valid_baseline_metadata(self):
        with tempfile.TemporaryDirectory() as temp:
            source = self.make_image(os.path.join(temp, "input.png"), (480, 800))
            first = build_index.make_preview_variants(source, "input", "Input")
            second = build_index.make_preview_variants(source, "input", "Input")
            self.assertEqual(first, second)
            for variant in first:
                data = variant["data"]
                self.assertLessEqual(len(data), build_index.MAX_PREVIEW_BYTES)
                self.assertEqual(variant["size"], len(data))
                self.assertEqual(variant["sha256"], hashlib.sha256(data).hexdigest())
                self.assertEqual(build_index.baseline_jpeg_dimensions(data, "generated"),
                                 (variant["width"], variant["height"]))

    def test_default_and_variant_have_distinct_assets_and_metadata(self):
        with tempfile.TemporaryDirectory() as temp:
            source = self.make_image(os.path.join(temp, "input.png"), (480, 800))
            variants = build_index.make_preview_variants(source, "input", "Input")
            self.assertEqual(variants[0]["asset"], "Input--preview-217x325.jpg")
            self.assertEqual(variants[1]["asset"], "Input--preview-144x216.jpg")
            self.assertNotEqual(variants[0]["asset"], variants[1]["asset"])
            self.assertNotEqual(variants[0]["sha256"], variants[1]["sha256"])

    def test_check_and_release_assets_match_index(self):
        repo = pathlib.Path(__file__).resolve().parents[1]
        builder = repo / "tools" / "build_index.py"
        with tempfile.TemporaryDirectory() as temp:
            output = pathlib.Path(temp) / "dist"
            env = os.environ.copy()
            check = subprocess.run([sys.executable, str(builder), "--check", "--out", str(output)],
                                   cwd=repo, env=env, capture_output=True, text=True)
            self.assertEqual(check.returncode, 0, check.stderr)
            self.assertFalse(output.exists(), "--check must not create release output")

            release = subprocess.run([sys.executable, str(builder), "--tag", "test", "--out", str(output)],
                                     cwd=repo, env=env, capture_output=True, text=True)
            self.assertEqual(release.returncode, 0, release.stderr)
            index = json.loads((output / "index.json").read_text())
            sums = {name: digest for digest, name in
                    (line.split("  ", 1) for line in (output / "SHA256SUMS").read_text().splitlines())}
            for plugin in index["plugins"]:
                preview = plugin.get("preview")
                if not preview:
                    continue
                entries = [preview, *preview.get("variants", [])]
                self.assertLessEqual(preview["width"], 217)
                self.assertLessEqual(preview["height"], 325)
                for entry in entries:
                    data = (output / entry["asset"]).read_bytes()
                    self.assertEqual(len(data), entry["size"])
                    self.assertEqual(hashlib.sha256(data).hexdigest(), entry["sha256"])
                    self.assertEqual(sums[entry["asset"]], entry["sha256"])
                    self.assertEqual(build_index.baseline_jpeg_dimensions(data, entry["asset"]),
                                     (entry["width"], entry["height"]))


if __name__ == "__main__":
    unittest.main()
