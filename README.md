# Compás Plugins

Plugins for [Compás](https://github.com/Starnished66/compas-player), the music player firmware for HiBy R1 and R3 Pro II. They are published here, and the player's **Plugin Store** (Settings > Plugin Manager) installs and updates them from the latest release.

## Installing by hand

Download the files of a plugin from the [latest release](https://github.com/Starnished66/compas-plugins/releases/latest), or from `plugins/<Name>/` in this repository, and copy them to the SD card:

- `<Name>.lua` goes in the `.plugins` folder.
- Extra files go where the plugin's `store.json` says (`dest`). For example, `NetRadio` reads its stations from `Radio.txt` at the root of the card, and `Themes` reads `.theme` files from the `Themes` folder.

Then open Settings > Plugin Manager and choose Refresh Plugins.

## AutoEQ profiles

Open **Settings > Sound > Equalizer > Profiles > Download profiles** to reach AutoEQ, search for your headphone model, and choose **Download profile**. The plugin uses [AutoEQ's recommended catalog](https://github.com/jaakkopasanen/AutoEq/tree/master/results) and saves compatible profiles in the SD card's `PEQ_Profiles` folder. Load a downloaded profile from **Settings > Sound > Equalizer > Profiles**; downloading does not change the active EQ.

The catalog is cached for offline searches. Downloads and catalog refreshes need a network connection. Existing profiles can be replaced explicitly or saved as another copy; incompatible profiles are rejected without changing saved files.

## Gallery Player layout

**Gallery Player** adds a Gallery-style Now Playing screen with frosted artwork, tap-to-open lyrics, and the standard playback controls. Install it from the Plugin Store, then choose it from Settings > Display > Player Layout > Layout, or use its Gallery Player row to apply it for the current session. It requires a recent daily build with XML player-layout lyrics support (Plugin API 14). The package includes 320×480, 480×720, and default-size layouts; the plugin prepares the two board-specific variants locally when that capability is available.

## Layout

```
plugins/
  NetRadio/
    NetRadio.lua      the plugin; id, name, version and api_min come from its plugin.define()
    store.json        store description, category, author and extra files
    Radio.txt         an extra file listed in store.json
```

`store.json`:

```json
{
  "description": "Internet radio stations from the Radio.txt file on the SD card, in Stream Media.",
  "category": "Listening",
  "author": "Compás",
  "files": [
    { "src": "Radio.txt", "dest": "Radio.txt", "keep": true }
  ]
}
```

- `description` is required. Keep it to one or two short sentences; it is shown on the player.
- `category` is one of `Listening`, `Reading`, `Audio`, `Customization`, `Tools`, `Experimental`, `Developer`.
- `files` lists extra files. `src` is relative to the plugin folder, `dest` is relative to the SD card root. The `.lua` file itself always goes to `.plugins/<Name>.lua` and is not listed.
- `publish: false` holds a plugin back: it is still checked, but left out of releases until it is ready.
- `keep: true` marks a file the user edits, such as a station list. The store installs it when it is missing and never overwrites or deletes it.

## Adding or updating a plugin

1. Put the plugin in `plugins/<Name>/<Name>.lua` with a `plugin.define()` call, and add `store.json`.
2. Raise `version` in `plugin.define()` whenever the plugin changes. The store offers an update only when the version is higher than the installed one.
3. Set `api_min` to the plugin API version the plugin really needs. The store will not install a plugin on firmware older than that.
4. Never change a published plugin's `id`. The store tracks installs by it, and the player keeps each plugin's saved settings under it.
5. Check locally: `python3 tools/build_index.py --check`. It runs each plugin under Lua 5.5 to read its `plugin.define()`, so it needs the `lua` interpreter on the PATH (or its path in the `LUA` environment variable).

## Releasing

Push a tag named `v` followed by the date, for example:

```
git tag v2026.09.27
git push origin v2026.09.27
```

The Release workflow compiles every plugin with Lua 5.5.1 (the version the player runs), builds `index.json`, and publishes a release with every file. The newest release is what the Plugin Store offers.

## index.json

Built by `tools/build_index.py`; the player reads it from `https://github.com/Starnished66/compas-plugins/releases/latest/download/index.json`.

```json
{
 "schema": 1,
 "tag": "v2026.09.27",
 "plugins": [
  {
   "id": "example.net_radio",
   "name": "Net Radio",
   "version": "1.3",
   "api_min": 1,
   "description": "…",
   "category": "Listening",
   "author": "Compás",
   "size": 3124,
   "files": [
    { "asset": "NetRadio--NetRadio.lua", "dest": ".plugins/NetRadio.lua", "sha256": "…", "size": 2224 },
    { "asset": "NetRadio--Radio.txt", "dest": "Radio.txt", "sha256": "…", "size": 900, "keep": true }
   ]
  }
 ]
}
```

Each file is downloaded from `https://github.com/Starnished66/compas-plugins/releases/download/<tag>/<asset>`, and its size and SHA-256 are checked before it replaces anything on the card. Destinations are plain relative paths; nothing may be written to `.compas/` or as a firmware image.

## License

GPL-3.0, the same as Compás. See [LICENSE](LICENSE).
