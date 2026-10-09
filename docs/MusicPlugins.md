# Music plugins

These plugins require **Plugin API 15** and are compatible with Compás v1.0.1. Copy the Lua file to the SD card's `.plugins` folder and refresh plugins.

| Plugin | Location | Behavior |
| --- | --- | --- |
| Lyrics Fetcher | Settings > Library | Fetch synced lyrics for the current local track from LRCLIB, saving a missing `.lrc` beside the track. Automatic fetching is off by default. |
| Cover Art Fetcher | Settings > Library | Match the current album on MusicBrainz and download a small front-cover JPEG from the Cover Art Archive as `cover.jpg`. Automatic fetching is off by default. |
| Album Shuffle | Settings > Playback & Controls | Start while playback mode is **sequential**. Plays a random whole album in track order, then another at the natural end or when Next is pressed at the queue boundary. Explicit Stop or selecting an unrelated track ends the session. |

Fetchers preserve existing sidecars and use verified HTTPS. No API key is needed. Album matching uses album artist where available, including compilation albums. Lyrics are looked up using title, artist, album and duration. Automatic lookups send those tags to the relevant service.

Newly saved lyrics are loaded when the track is played again; fetching does not restart playback.

API 15 does not expose embedded lyrics or embedded artwork to Lua. These plugins check sidecar files; a track with embedded lyrics or artwork may still receive a missing sidecar. Album Shuffle cannot set native playback mode, so the user selects sequential mode before starting.

## API compatibility review

Checked against the registered Lua bindings and event handlers in the released [Compás v1.0.1 source](https://github.com/Starnished66/compas-player/tree/e2a029f8e99a67300c6bce635d381d8a0bfd9ed2). Its plugin API version is 15.

- Lyrics Fetcher uses asynchronous HTTP, JSON decoding, the current track metadata, intervals and standard sandboxed file operations.
- Cover Art Fetcher uses asynchronous HTTP including HEAD, response headers, TLS, file downloads, paged library metadata and library refresh. The API 15 HTTP implementation skips response bodies for HEAD.
- Album Shuffle uses paged album/song lookup, album track lists, list playback, current path/mode, playback state and the `track_started`, `stopped`, and `queue_exhausted` events. Natural completion uses two idle polls because `queue_exhausted` covers boundary navigation.

No API 16 functions or native code changes are required. None of these plugins is deferred for v1.1.

## Validation

From the repository root, run `lua tests/music_plugins/run.lua` with Lua 5.5.1, then `python3 tools/build_index.py --check`. The mocked API tests cover lookup failures, sidecar preservation, asynchronous callbacks, cover redirects, compilation albums and album continuation. They do not claim an end-to-end network or device playback test.
