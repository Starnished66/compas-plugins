# Compás Plugins

Plugins for [Compás](https://github.com/Starnished66/compas-player), the music player firmware for HiBy R1 and R3 Pro II. The **Plugin Store** (Settings > System > Plugin Manager) installs and updates plugins from the latest release. Player layouts have their own download page under **Settings > Display > Player Layout > Layout > Download**.

## Installing by hand

Download the files of a plugin from the [latest release](https://github.com/Starnished66/compas-plugins/releases/latest), or from `plugins/<Name>/` in this repository, and copy them to the SD card:

- `<Name>.lua` goes in the `.plugins` folder.
- Extra files go where the plugin's `store.json` says (`dest`). For example, `NetRadio` reads its stations from `Radio.txt` at the root of the card, and `Themes` reads `.theme` files from the `Themes` folder.

Then open Settings > Plugin Manager and choose Refresh Plugins.

## AutoEQ profiles

Open **Settings > Sound > Equalizer > Profiles > Download profiles** to reach AutoEQ, search for your headphone model, and choose **Download profile**. The plugin uses [AutoEQ's recommended catalog](https://github.com/jaakkopasanen/AutoEq/tree/master/results) and saves compatible profiles in the SD card's `PEQ_Profiles` folder. Load a downloaded profile from **Settings > Sound > Equalizer > Profiles**; downloading does not change the active EQ.

The catalog is cached for offline searches. Downloads and catalog refreshes need a network connection. Existing profiles can be replaced explicitly or saved as another copy; incompatible profiles are rejected without changing saved files.

## Lyrics, covers and album shuffle

Lyrics Fetcher, Cover Art Fetcher and Album Shuffle support Plugin API 15. Fetchers offer manual lookup and optional automatic mode; Album Shuffle plays whole albums in track order. See [usage and compatibility](docs/MusicPlugins.md).

## ListenBrainz and Net Radio

Both use Plugin API 15, the API in Compás v1.0.1. No newer plugin API is required.

**ListenBrainz Scrobbler** is under Settings > Playback & Controls. Turn on **Enabled** and enter a ListenBrainz user token. The token stays in the plugin secret store. A listen is kept on the device before it is sent, up to 40 records or 32 KiB. Past that, or if the save fails, the listens already stored stay and the new one is not added. Paused time and time skipped by seeking do not count. Tracks under 30 seconds and streams with no duration are skipped. Logging out or changing the token clears the previous account's queue. A rejected token stops new sends and keeps the saved listens.

**Net Radio** is one Stream Media tile for both saved stations and Radio Browser search. Open **Saved stations** to play the `Radio.txt` queue, or **Search stations** to find and save direct MP3, FLAC, or ADTS AAC/AAC+ streams. Favorites append to the same `Name | http(s)://direct-stream` file; existing bytes are preserved, and stations remain available offline (playback needs a network connection). Existing users of the separate Radio Browser plugin should disable it in Plugin Manager or remove `.plugins/RadioBrowser.lua`, then refresh plugins. Keep `Radio.txt` so saved stations remain available. Live ICY or ID3 titles are not shown by the player.

## Kids Mode and Discover

**Kids Mode** is under Settings > System > Additional Tools. It simplifies Home
to Music, Books and a Parent Mode tile. The initial parent PIN is `1234`; change
it in the plugin settings. The Quick Drawer and its settings shortcuts remain
accessible, so this is a simpler Home screen rather than a full device lock.

**Discover** is under Settings > Music Library. It finds releases and similar
artists through MusicBrainz and ListenBrainz, compares releases with your local
library, and maintains a wish list with an optional SD card backup. Online lookup
requires Wi-Fi; saved wish-list entries remain available offline. Both plugins
work on API 15 firmware.

## Player layouts

Download and install Default Waveform Player, Gallery Waveform Player, Hiby's Player, Hiby's Graph Player, Gallery Player, Panorama Player, Vinyl Player, or Orbit Player from **Settings > Display > Player Layout > Layout > Download**, then choose the layout in **Settings > Display > Player Layout > Layout**. Layout downloads install the plugin and its display assets. Each package includes layouts for the supported display sizes and requires Plugin API 15 or newer, which guarantees the current XML player-layout features and board-size variant discovery; all designs support tap-to-open lyrics, and Default Waveform, Gallery Waveform, Hibys Graph, Panorama, and Vinyl use waveform seeking.

- **Default Waveform Player** keeps the familiar Default layout and adds waveform bars.
- **Gallery Waveform Player** adds an envelope waveform to Gallery while preserving its artwork and lyrics transitions.
- **Hiby's Player** brings the familiar HiBy-style Now Playing layout to Compás.
- **Hiby's Graph Player** adds a filled-envelope waveform seek bar to the HiBy-style player.
- **Gallery Player** adds frosted artwork, tap-to-open lyrics, and standard playback controls.
- **Panorama Player** combines full-width artwork, a smooth cover fade, animated lyrics, and rounded waveform bars.
- **Vinyl Player** uses a record-inspired layout with an envelope waveform seek bar.
- **Orbit Player** uses circular artwork and a circular seek bar.

## v1.1 plugins (API 16)

These sources are held with `publish: false` until the v1.1 release. Manual
installation requires firmware with API 16 and the corresponding native
capabilities.

| Plugin | Where to open it | Behavior |
| --- | --- | --- |
| Track Inspector | Settings > Playback & Controls | Source codec and format, output route, DSP assessment, and bounded local file header inspection. Unknown information remains unknown; the assessment does not certify a DAC's output. |
| Extended Sleep Timer | Settings > Power | Optional gradual fade before stopping playback. Fade writes neither remembered volume nor firmware settings. Finishing or cancelling leaves the current volume in place. |
| Volume Limiter | Settings > Sound | Quietly pulls software volume down to a configured ceiling. Volume events arrive at the firmware's notification cadence. |
| AutoEQ Context | Settings > Sound | Selects local `.peq` profiles by folder, artist, or genre. Applies and restores runtime EQ without saving each track change. |
| Output-Aware Sound | Settings > Sound | Selects a local `.peq` profile for wired, USB DAC, or Bluetooth output, including codec-specific Bluetooth rules. |
| Album Playback Rules | Settings > Playback & Controls | Overrides crossfade, gapless, ReplayGain mode, and playback order by album tags. Native playback settings persist; ReplayGain changes take effect on the next track. |
| A-B Repeat | Settings > Playback & Controls | Decoder-frame loops for finite local FLAC, WAV, AIFF, and CAF up to 16-bit, at normal speed with crossfade off. |
| ABX Blind Test | Settings > Playback & Controls | Randomized hidden-X comparisons and scores. File comparisons require matched playable frame counts, sample rates, and channels; EQ comparisons cannot guarantee click-free coefficient changes. |
| Jellyfin & Emby | Stream Media | Authenticated music library browsing and direct playback. Seeking depends on a supported finite source and the active native decoder. |

Automatic EQ tools preserve later manual changes. If another tool changes EQ,
automation suspends rather than continually overwriting it; use the plugin's
reclaim control to resume. Profiles live in the SD card's `PEQ_Profiles` folder.

The host tests exercise plugin callbacks and failure paths against API mocks.
They do not replace verification on a device or against a live media server.

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
- Audiobooks, Podcasts, and MSEB are present in source and checked in CI, but remain unpublished while they require API 16.
- `keep: true` marks a file the user edits, such as a station list. The store installs it when it is missing and never overwrites or deletes it.

## Adding or updating a plugin

1. Put the plugin in `plugins/<Name>/<Name>.lua` with a `plugin.define()` call, and add `store.json`.
2. Raise `version` in `plugin.define()` whenever the plugin changes. The store offers an update only when the version is higher than the installed one.
3. Set `api_min` to the plugin API version the plugin really needs. The store will not install a plugin on firmware older than that.
4. Never change a published plugin's `id`. The store tracks installs by it, and the player keeps each plugin's saved settings under it.
5. Check locally: `python3 -m pip install Pillow==12.3.0 && python3 tools/build_index.py --check`. It runs each plugin under Lua 5.5 to read its `plugin.define()`, so it also needs the `lua` interpreter on the PATH (or its path in the `LUA` environment variable).

## Releasing

Push a tag named `v` followed by the date, for example:

```
git tag v2026.09.27
git push origin v2026.09.27
```

The Release workflow compiles every plugin with Lua 5.5.1 (the version the player runs), builds `index.json`, and publishes its assets. Plugin files are downloadable install assets; optional preview images are separate release assets and are never installed. The newest release is what the Plugin Store offers.

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

A plugin may set `"preview": "preview.png"` (or a JPEG path) in `store.json`. The source stays in the repository; the builder accepts PNG/JPEG screenshots up to 8 MiB and 4096×4096 pixels, then creates aspect-preserving baseline JPEGs capped at 217×325 and 144×216 pixels. It does not crop or enlarge small sources. The plugin record's `preview` object describes the largest variant and its optional `variants` array describes smaller ones; the player selects the largest image that fits its card. Each entry includes the release asset name, SHA-256, size, width, and height. Generated files use deterministic `<Plugin>--preview-<width>x<height>.jpg` names and publish separately from install files, without a `dest` or entry in `files`; they do not affect installed files or install size. The builder uses Pillow 12.3.0 in CI and release jobs.

## License

GPL-3.0, the same as Compás. See [LICENSE](LICENSE).
