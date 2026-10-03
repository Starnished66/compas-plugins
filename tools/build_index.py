#!/usr/bin/env python3
"""Builds the Plugin Store index and release assets.

Every folder under plugins/ is one plugin: plugins/<Name>/<Name>.lua plus
store.json and any extra files store.json lists. id, name, version and
api_min come from the plugin's own plugin.define() call, so they cannot
drift from what the player loads.

  tools/build_index.py --check            validate only (CI on every push)
  tools/build_index.py --tag v2026.09.27  write dist/ for a release

dist/ holds every file under a flat, unique asset name (GitHub release
assets have no folders), index.json and SHA256SUMS. The player reads
index.json from the latest release and downloads each asset from the same
tag, verifying its size and SHA-256 before it replaces anything.
"""

import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import tempfile
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PLUGINS_DIR = os.path.join(ROOT, "plugins")

SCHEMA = 1
# Kept well inside what the player accepts, so a release can never be
# rejected on the device for size alone.
MAX_FILE_BYTES = 1024 * 1024
MAX_INDEX_BYTES = 256 * 1024
MAX_PLUGINS = 200
MAX_FILES_PER_PLUGIN = 32  # the script included, as the player allows
MAX_PREVIEW_BYTES = 65536
MAX_PREVIEW_WIDTH = 240
MAX_PREVIEW_HEIGHT = 400

# Used with fullmatch and re.ASCII so they mean what the player checks: a
# plain "$" would allow a trailing newline and "\d" any Unicode digit.
TAG_RE = re.compile(r"[A-Za-z0-9._-]{1,63}", re.ASCII)
ID_RE = re.compile(r"[a-z0-9][a-z0-9_.-]{0,62}", re.ASCII)
VERSION_RE = re.compile(r"[0-9]+(\.[0-9]+){0,3}", re.ASCII)
ASSET_RE = re.compile(r"[A-Za-z0-9._-]+", re.ASCII)
DEST_CHARS_RE = re.compile(r"[A-Za-z0-9._ /-]+", re.ASCII)
CATEGORIES = ("Listening", "Reading", "Audio", "Customization", "Tools", "Experimental", "Developer")


class BuildError(Exception):
    pass


# Runs the plugin under Lua 5.5 with a stand-in plugin table and captures
# the table given to plugin.define(), so comments, strings and repeated keys
# mean exactly what they mean on the player. Everything else the script does
# before define() gets harmless answers; nothing runs after it.
DEFINE_PROBE = r"""
local path, out_path = arg[1], arg[2]
-- Values are written the moment define() runs, to a file of their own (the
-- plugin may print), then the process ends, so no pcall or later code can
-- change or hide them.
local function report(def)
    local out = assert(io.open(out_path, "wb"))
    if type(def) == "table" then
        for _, key in ipairs({ "id", "name", "version", "api_min" }) do
            local value = def[key]
            if key == "api_min" then
                -- The player reads it with luaL_optinteger: 1.0 counts as 1.
                local int = math.tointeger(value)
                if int then out:write(key, "\t", tostring(int), "\n") end
            elseif type(value) == "string" then
                out:write(key, "\t", #value, "\t", value, "\n")
            end
        end
    end
    out:close()
    os.exit(type(def) == "table" and 0 or 3, true)
end
local function answer() return nil end
local stub = setmetatable({}, { __index = function(_, key)
    if key == "define" then
        return report
    elseif key == "api_version" then
        return function() return math.maxinteger end
    elseif key == "has_capability" then
        return function() return true end
    elseif key == "storage" or key == "secrets" then
        return setmetatable({}, { __index = function() return answer end })
    end
    return answer
end })
local env = setmetatable({ plugin = stub, print = answer }, { __index = _G })
local chunk, err = loadfile(path, "t", env)
if not chunk then io.stderr:write(err, "\n") os.exit(2) end
local ok, run_err = pcall(chunk)
io.stderr:write(ok and "no plugin.define() call" or tostring(run_err), "\n")
os.exit(2)
"""


def read_define(lua_path):
    """Returns id, name, version and api_min from the plugin's plugin.define()."""
    lua = os.environ.get("LUA", "lua")
    out_fd, out_path = tempfile.mkstemp(suffix=".define")
    os.close(out_fd)
    try:
        try:
            result = subprocess.run([lua, "-", lua_path, out_path], input=DEFINE_PROBE.encode("utf-8"),
                                    capture_output=True, timeout=10)
        except FileNotFoundError:
            raise BuildError("Lua 5.5 interpreter not found (set LUA or put lua on PATH)")
        except subprocess.TimeoutExpired:
            raise BuildError(f"{lua_path}: reading plugin.define() took too long")
        with open(out_path, "rb") as f:
            out = f.read().decode("utf-8")
    finally:
        os.unlink(out_path)
    if result.returncode == 3:
        raise BuildError(f"{lua_path}: plugin.define() needs a table")
    if result.returncode != 0:
        raise BuildError(f"{lua_path}: {result.stderr.decode('utf-8', 'replace').strip()}")
    fields, pos = {}, 0
    while pos < len(out):
        key_end = out.index("\t", pos)
        key = out[pos:key_end]
        if key == "api_min":
            line_end = out.index("\n", key_end)
            fields[key] = int(out[key_end + 1:line_end])
            pos = line_end + 1
        else:
            len_end = out.index("\t", key_end + 1)
            length = int(out[key_end + 1:len_end])
            # The length counts bytes, as Lua's # does.
            raw = out[len_end + 1:].encode("utf-8")[:length].decode("utf-8")
            fields[key] = raw
            pos = len_end + 1 + len(raw) + 1
    return fields


def check_dest(dest, where):
    """A destination is a plain relative path on the SD card."""
    if not isinstance(dest, str) or not dest or not DEST_CHARS_RE.fullmatch(dest) or len(dest) > 255:
        raise BuildError(f"{where}: dest {dest!r} must be a relative path of plain characters")
    parts = dest.split("/")
    if dest.startswith("/") or any(p in ("", ".", "..") for p in parts):
        raise BuildError(f"{where}: dest {dest!r} must be a normalized relative path")
    # The player compares these without case, and keeps its own dot files
    # (the store record, the disabled list) directly in .plugins.
    if (parts[0].lower() == ".compas" or dest.lower().endswith(".upt")
            or (parts[0].lower() == ".plugins" and len(parts) > 1 and parts[1].startswith("."))):
        raise BuildError(f"{where}: dest {dest!r} is reserved for the player")
    return dest


def sha256_of(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(65536), b""):
            h.update(chunk)
    return h.hexdigest()


def baseline_jpeg_dimensions(path, where):
    """Read dimensions from a baseline JPEG without optional image libraries."""
    with open(path, "rb") as f:
        data = f.read()
    if len(data) < 4 or data[:2] != b"\xff\xd8" or data[-2:] != b"\xff\xd9":
        raise BuildError(f"{where}: preview must be a baseline JPEG")
    pos = 2
    dimensions = None
    while pos < len(data):
        if data[pos] != 0xFF:
            raise BuildError(f"{where}: malformed JPEG marker")
        while pos < len(data) and data[pos] == 0xFF:
            pos += 1
        if pos >= len(data):
            break
        marker = data[pos]
        pos += 1
        if marker == 0xD9:
            break
        if marker in (0xD8, *range(0xD0, 0xD8), 0x01):
            continue
        if pos + 2 > len(data):
            break
        segment_size = int.from_bytes(data[pos:pos + 2], "big")
        if segment_size < 2 or pos + segment_size > len(data):
            raise BuildError(f"{where}: malformed JPEG segment")
        if marker == 0xC0:
            if dimensions is not None:
                raise BuildError(f"{where}: preview JPEG has multiple frames")
            if segment_size < 8:
                raise BuildError(f"{where}: malformed baseline JPEG frame")
            payload = data[pos + 2:pos + segment_size]
            precision = payload[0]
            height = int.from_bytes(payload[1:3], "big")
            width = int.from_bytes(payload[3:5], "big")
            components = payload[5]
            if (precision != 8 or components not in (1, 3)
                    or segment_size != 8 + 3 * components):
                raise BuildError(f"{where}: preview must use an 8-bit grayscale or three-component baseline frame")
            if not width or not height:
                raise BuildError(f"{where}: preview JPEG dimensions must be positive")
            dimensions = width, height
        elif 0xC0 <= marker <= 0xCF and marker not in (0xC4, 0xC8, 0xCC):
            raise BuildError(f"{where}: preview must use baseline JPEG encoding")
        if marker == 0xDA:
            if dimensions is None:
                raise BuildError(f"{where}: preview JPEG scan appears before its baseline frame")
            if segment_size < 6:
                raise BuildError(f"{where}: malformed JPEG scan")
            return dimensions
        pos += segment_size
    raise BuildError(f"{where}: preview must be a valid baseline JPEG")


def load_plugin(folder):
    base = os.path.join(PLUGINS_DIR, folder)
    lua_name = folder + ".lua"
    lua_path = os.path.join(base, lua_name)
    if not os.path.isfile(lua_path):
        raise BuildError(f"plugins/{folder}: missing {lua_name}")
    store_path = os.path.join(base, "store.json")
    if not os.path.isfile(store_path):
        raise BuildError(f"plugins/{folder}: missing store.json")
    with open(store_path, encoding="utf-8") as f:
        store = json.load(f)

    define = read_define(lua_path)
    for key in ("id", "name", "version", "api_min"):
        if key not in define:
            raise BuildError(f"plugins/{folder}/{lua_name}: plugin.define() has no {key}")
    if not ID_RE.fullmatch(define["id"]):
        raise BuildError(f"plugins/{folder}: id {define['id']!r} must be lowercase letters, digits, '.', '_' or '-'")
    if not VERSION_RE.fullmatch(define["version"]):
        raise BuildError(f"plugins/{folder}: version {define['version']!r} must be dotted numbers, e.g. 1.2")
    if not 1 <= define["api_min"] <= 0xFFFFFFFF:
        raise BuildError(f"plugins/{folder}: api_min must be at least 1")
    if len(define["version"]) > 31:
        raise BuildError(f"plugins/{folder}: version {define['version']!r} is too long")

    description = store.get("description", "")
    if not isinstance(description, str) or not description.strip():
        raise BuildError(f"plugins/{folder}/store.json: description is required")
    # The player rejects the whole index over any field past these byte
    # limits (or with control characters), so a release must never carry one.
    author = store.get("author", "")
    for label, value, limit in (("name", define["name"], 64), ("description", description.strip(), 400),
                                ("author", author, 64)):
        if not isinstance(value, str) or len(value.encode("utf-8")) > limit or (label == "name" and not value):
            raise BuildError(f"plugins/{folder}: {label} must be text of at most {limit} bytes")
        if any(ord(c) < 32 or ord(c) == 127 for c in value):
            raise BuildError(f"plugins/{folder}: {label} must not contain control characters")
    category = store.get("category", "Tools")
    if category not in CATEGORIES:
        raise BuildError(f"plugins/{folder}/store.json: category must be one of {', '.join(CATEGORIES)}")

    entries = [{"src": lua_name, "dest": ".plugins/" + lua_name}]
    for extra in store.get("files", []):
        if not isinstance(extra, dict) or "src" not in extra or "dest" not in extra:
            raise BuildError(f"plugins/{folder}/store.json: every file needs src and dest")
        # The player takes a .lua file directly in .plugins as the plugin's
        # script and accepts exactly one per plugin.
        dest = extra["dest"] if isinstance(extra["dest"], str) else ""
        dparts = dest.split("/")
        # Compared without case: on the FAT card ".PLUGINS" is the same folder.
        if len(dparts) == 2 and dparts[0].lower() == ".plugins" and dparts[1].lower().endswith(".lua"):
            raise BuildError(f"plugins/{folder}/store.json: {dest} would be a second plugin script")
        entries.append(extra)
    if len(entries) > MAX_FILES_PER_PLUGIN:
        raise BuildError(f"plugins/{folder}: {len(entries)} files, over the {MAX_FILES_PER_PLUGIN} file limit")

    files = []
    for entry in entries:
        src = entry["src"]
        where = f"plugins/{folder}/{src}"
        src_path = os.path.normpath(os.path.join(base, src))
        if os.path.commonpath([src_path, base]) != base or not os.path.isfile(src_path):
            raise BuildError(f"{where}: file not found inside the plugin folder")
        size = os.path.getsize(src_path)
        if size == 0:
            raise BuildError(f"{where}: empty file; the player refuses empty assets")
        if size > MAX_FILE_BYTES:
            raise BuildError(f"{where}: {size} bytes, over the {MAX_FILE_BYTES} byte limit")
        asset = folder + "--" + src.replace("/", "--")
        if not ASSET_RE.fullmatch(asset) or len(asset) > 127:
            raise BuildError(f"{where}: asset name {asset!r} has characters GitHub would rename")
        item = {
            "asset": asset,
            "dest": check_dest(entry["dest"], where),
            "sha256": sha256_of(src_path),
            "size": size,
        }
        if entry.get("keep"):
            # User-editable data: installed when missing, never overwritten
            # or removed by an update or uninstall.
            item["keep"] = True
        files.append((item, src_path))

    preview = None
    preview_source = None
    preview_src = store.get("preview")
    if preview_src is not None:
        where = f"plugins/{folder}/{preview_src}"
        if (not isinstance(preview_src, str) or not preview_src or preview_src.startswith("/")
                or "\\" in preview_src or any(part in ("", ".", "..") for part in preview_src.split("/"))
                or not ASSET_RE.fullmatch(preview_src.replace("/", "--"))):
            raise BuildError(f"plugins/{folder}/store.json: preview must be a normalized relative file path")
        preview_source = os.path.normpath(os.path.join(base, preview_src))
        real_base = os.path.realpath(base)
        real_source = os.path.realpath(preview_source)
        if (os.path.commonpath([preview_source, base]) != base
                or os.path.commonpath([real_source, real_base]) != real_base
                or not os.path.isfile(preview_source)):
            raise BuildError(f"{where}: preview file not found inside the plugin folder")
        preview_size = os.path.getsize(preview_source)
        if not preview_size or preview_size > MAX_PREVIEW_BYTES:
            raise BuildError(f"{where}: preview must be 1 to {MAX_PREVIEW_BYTES} bytes")
        width, height = baseline_jpeg_dimensions(preview_source, where)
        if width > MAX_PREVIEW_WIDTH or height > MAX_PREVIEW_HEIGHT:
            raise BuildError(f"{where}: preview dimensions {width}x{height} exceed {MAX_PREVIEW_WIDTH}x{MAX_PREVIEW_HEIGHT}")
        preview_asset = folder + "--" + preview_src.replace("/", "--")
        if not ASSET_RE.fullmatch(preview_asset) or len(preview_asset) > 127:
            raise BuildError(f"{where}: asset name {preview_asset!r} has characters GitHub would rename")
        preview = {
            "asset": preview_asset,
            "sha256": sha256_of(preview_source),
            "size": preview_size,
            "width": width,
            "height": height,
        }

    publish = store.get("publish", True)
    if not isinstance(publish, bool):
        raise BuildError(f"plugins/{folder}/store.json: publish must be true or false")

    plugin = {
        "publish": publish,
        "id": define["id"],
        "name": define["name"],
        "version": define["version"],
        "api_min": define["api_min"],
        "description": description.strip(),
        "category": category,
        "author": store.get("author", ""),
        "size": sum(item["size"] for item, _ in files),
        "files": [item for item, _ in files],
    }
    if preview is not None:
        plugin["preview"] = preview
    return plugin, files, (preview["asset"], preview_source) if preview is not None else None


def build(tag):
    if not TAG_RE.fullmatch(tag):
        raise BuildError(f"tag {tag!r} must be 1 to 63 letters, digits, '.', '_' or '-'")
    folders = sorted(d for d in os.listdir(PLUGINS_DIR) if os.path.isdir(os.path.join(PLUGINS_DIR, d)))
    if not folders:
        raise BuildError("plugins/ is empty")
    if len(folders) > MAX_PLUGINS:
        raise BuildError(f"{len(folders)} plugins, over the {MAX_PLUGINS} limit")
    plugins, sources, held = [], [], []
    ids, dests, assets = {}, {}, set()
    for folder in folders:
        plugin, files, preview_source = load_plugin(folder)
        if plugin["id"] in ids:
            raise BuildError(f"plugins/{folder}: id {plugin['id']} is also used by plugins/{ids[plugin['id']]}")
        ids[plugin["id"]] = folder
        plugin_sources = []
        for item, src_path in files:
            key = item["dest"].lower()
            if key in dests:
                raise BuildError(f"plugins/{folder}: dest {item['dest']} is also installed by plugins/{dests[key]}")
            # A file cannot also be the folder of another file.
            for other, owner in dests.items():
                if other.startswith(key + "/") or key.startswith(other + "/"):
                    raise BuildError(f"plugins/{folder}: dest {item['dest']} and {other} (plugins/{owner}) "
                                     "would need the same path as both a file and a folder")
            dests[key] = folder
            if item["asset"] in assets:
                raise BuildError(f"plugins/{folder}: two files would both be released as {item['asset']}")
            assets.add(item["asset"])
            plugin_sources.append((item["asset"], src_path))
        if preview_source:
            preview_asset, preview_path = preview_source
            if preview_asset in assets:
                raise BuildError(f"plugins/{folder}: two files would both be released as {preview_asset}")
            assets.add(preview_asset)
            plugin_sources.append((preview_asset, preview_path))
        # Held plugins ("publish": false) are validated but not released.
        if plugin.pop("publish"):
            plugins.append(plugin)
            sources.extend(plugin_sources)
        else:
            held.append(folder)

    index = {"schema": SCHEMA, "tag": tag, "plugins": plugins}
    data = json.dumps(index, indent=1, ensure_ascii=False, sort_keys=False).encode("utf-8") + b"\n"
    if len(data) > MAX_INDEX_BYTES:
        raise BuildError(f"index.json is {len(data)} bytes, over the {MAX_INDEX_BYTES} byte limit")
    return index, data, sources, held


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--tag", default="dev", help="release tag the assets are published under")
    parser.add_argument("--out", default=os.path.join(ROOT, "dist"), help="output folder")
    parser.add_argument("--check", action="store_true", help="validate only, write nothing")
    args = parser.parse_args()

    try:
        index, data, sources, held = build(args.tag)
    except (BuildError, json.JSONDecodeError) as e:
        print(f"error: {e}", file=sys.stderr)
        return 1

    if args.check:
        print(f"ok: {len(index['plugins'])} plugins, {len(sources)} files, index {len(data)} bytes"
              + (f", held: {', '.join(held)}" if held else ""))
        return 0

    if os.path.exists(args.out):
        shutil.rmtree(args.out)
    os.makedirs(args.out)
    sums = []
    for asset, src_path in sources:
        shutil.copyfile(src_path, os.path.join(args.out, asset))
    with open(os.path.join(args.out, "index.json"), "wb") as f:
        f.write(data)
    for name in sorted(os.listdir(args.out)):
        sums.append(f"{sha256_of(os.path.join(args.out, name))}  {name}")
    with open(os.path.join(args.out, "SHA256SUMS"), "w") as f:
        f.write("\n".join(sums) + "\n")
    print(f"wrote {args.out}: {len(index['plugins'])} plugins, {len(sources)} files, tag {args.tag}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
