# Music plugins

The music plugins listed here are published for Compás v1.1. Lyrics Fetcher, Cover Art Fetcher, AutoEQ, Podcasts, Audiobooks, and MSEB require **Plugin API 16**; Album Shuffle, ListenBrainz Scrobbler, and Net Radio support API 15. Install them through Plugin Manager or copy the published plugin files to the SD card's `.plugins` folder and refresh plugins. Radio Browser remains deprecated and unpublished because its search feature is part of Net Radio.

| Plugin | Location | Behavior |
| --- | --- | --- |
| Lyrics Fetcher | Settings > Library | Fetch synced lyrics for the current local track from LRCLIB, saving a missing `.lrc` beside the track. Automatic fetching is off by default. |
| Cover Art Fetcher | Settings > Library | Match the current album on MusicBrainz and download a small front-cover JPEG from the Cover Art Archive as `<album title>.jpg` beside the track. Automatic fetching is off by default. |
| Album Shuffle | Settings > Playback & Controls | Start while playback mode is **sequential**. Plays a random whole album in track order, then another at the natural end or when Next is pressed at the queue boundary. Explicit Stop or selecting an unrelated track ends the session. |
| ListenBrainz Scrobbler | Settings > Playback & Controls | Opt-in scrobble with a ListenBrainz user token. The token is kept in plugin secrets. Qualified listens are stored before they are sent. |
| Net Radio | Stream Media | Play saved stations from `Radio.txt` or search Radio Browser and save direct streams as favorites. |
| AutoEQ | Settings > Sound > Equalizer > Profiles > Download profiles | Search the recommended headphone catalog and download compatible parametric EQ profiles. |
| Podcasts | Stream Media | Search and subscribe, download episodes, and resume playback. File Manager opens the podcast storage folder. Version 1.6.0. |
| Audiobooks | Books | Browse audiobook files, resume playback, manage bookmarks and chapters, and use the sleep timer. File Manager opens audiobook folders. Version 3.6.0. |
| MSEB | Settings > Sound | Mood-based tone tuning on top of the parametric EQ, with backup and restore. |

### API 16 behavior

Lyrics Fetcher 1.1.0, Cover Art Fetcher 1.1.1, and AutoEQ 1.1.0 are published API16 packages. Manual lookup/download operations show dismissible progress cards; automatic fetches stay quiet. Cover and podcast downloads show a percentage only when the native download API reports a known byte total. HTTP lookup, profile download, unknown totals, and other phases remain indeterminate; no estimated percentages are shown. Dismissing a card stops asynchronous updates from reopening it, while an intentional repeated manual action can reopen an existing operation when that plugin supports joining it.

Fetchers preserve existing sidecars and use verified HTTPS. No API key is needed. Album matching uses album artist where available, including compilation albums. Lyrics are looked up using title, artist, album and duration. Automatic lookups send those tags to the relevant service.

Cover Art Fetcher saves album-specific sidecars because a generic `cover.jpg` also applies to other albums in a shared folder or to albums below that folder. Album names use the player's filename substitutions. It refuses ambiguous filenames, generic artwork/cache names, and tracks whose indexed tags do not match playback. Two bounded, paged library checks keep only one page in memory; libraries over 100,000 tracks are refused. Automatic mode checks each new album/folder once, rather than rescanning on every track.

Existing images, including `cover.jpg` written by earlier versions, are preserved. Fetch the affected albums again to add their individual sidecars; these take precedence over generic folder artwork when no track-specific sidecar is present. The old generic file can still affect albums that have not been fetched. Inspect it before removing it with File Manager, then update the music database. Embedded artwork remains unavailable to Lua.

Newly saved lyrics are loaded when the track is played again; fetching does not restart playback.

API 15 does not expose embedded lyrics or embedded artwork to Lua. These plugins check sidecar files; a track with embedded lyrics or artwork may still receive a missing sidecar. Album Shuffle cannot set native playback mode, so the user selects sequential mode before starting.

## ListenBrainz Scrobbler

Settings > Playback & Controls > **ListenBrainz Scrobbler**. Requires Plugin API 15.

Turn on **Enabled**, then enter a ListenBrainz user token. The field is masked. The token is stored with `plugin.secrets` and is not written into ordinary plugin storage, toasts, or request URLs. Validation is an HTTPS GET to `https://api.listenbrainz.org/1/validate-token`. A response can be HTTP 200 with `valid` false; that token is not saved.

A listen is sent only when the track is at least 30 seconds and has been heard for half its length or 4 minutes, whichever is less. Pauses and forward seeks do not count. Tracks with no duration, including live radio, are skipped. Each track is submitted at most once. `playing_now` is advisory and has no `listened_at`. The stored listen uses the time playback started.

The offline queue holds at most **40 records or 32 KiB**. A qualified listen is written before it is submitted and is removed only after ListenBrainz accepts it. When the queue is full, or the write fails, the records already saved stay and the new listen cannot be added. Network errors, HTTP 429, and HTTP 5xx retry with backoff. A numeric `Retry-After` waits from 1 to 3600 seconds. HTTP 401 stops new attempts and keeps the saved listens. Logging out, or saving a different token, deletes the previous account's queue so those listens are not sent to anyone else. If the token cannot be saved or removed, the signed-in account and its queue stay as they are.

## Net Radio

Stream Media > **Net Radio**. Requires Plugin API 15. The root menu opens **Saved stations** first and **Search stations** second. Saved station playback queues valid URLs in displayed order and starts at the selected station. Invalid or overlong entries stay in `Radio.txt` and are excluded from playback. If the file is missing or has no stations, choose **Check again** after adding or correcting it.

Search by station name. Each request asks for 20 stations, skips broken entries, and fails over across a few HTTPS Radio Browser backends. Playable results are direct MP3, FLAC, or ADTS AAC/AAC+ URLs. FLAC and AAC get a local `#.flac`, `#.aac`, or `#.aacp` hint, which is not sent to the server. The player also treats `Content-Type: audio/aac` or `audio/aacp` as ADTS AAC/AAC+. HLS, playlist files, and other codecs are not passed to the player. A stream URL, including its hint, has to fit in 511 bytes.

**Save favorite** appends one `Name | http(s)://direct-stream` line to `Radio.txt` on the SD card. Existing bytes, comments, and custom lines are left in place, including a file that does not end with a newline. The same stream is not added twice, even when it sits past the 500 lines the saved list can show. Favorites can be opened without a directory lookup; playback still requires a network connection. Search results show the station name from the directory. The player does not show ICY or ID3 titles from a live stream, and Plugin API 15 does not give those titles to Lua. Users with the older separate Radio Browser plugin should disable it in Plugin Manager or remove `.plugins/RadioBrowser.lua`, then refresh plugins; keep `Radio.txt`.

## API compatibility review

Checked against the registered Lua bindings and event handlers in the released [Compás v1.0.1 source](https://github.com/Starnished66/compas-player/tree/e2a029f8e99a67300c6bce635d381d8a0bfd9ed2). Its plugin API version is 15.

- The released Compás v1.0.1 packages used API15 functions. The v1.1 Lyrics Fetcher and Cover Art Fetcher packages use API16 progress-card support; Cover Art Fetcher also reads native download byte progress when available.
- Album Shuffle uses paged album/song lookup, album track lists, list playback, current path/mode, playback state and the `track_started`, `stopped`, and `queue_exhausted` events. Natural completion uses two idle polls because `queue_exhausted` covers boundary navigation.
- ListenBrainz Scrobbler uses `plugin.secrets`, `plugin.storage`, async HTTPS with request headers, TLS, timeouts and the response-header table, JSON, playback events, position, and a one-second-or-slower interval. All of those are in API 15.
- Net Radio uses the stream-media tile, async HTTPS, JSON, `plugin.play_list`, and normal file reads and appends. AAC and AAC+ use the existing `#.aac` / `#.aacp` hints and `audio/aac` content type. No API 16 function and no native change is required.

The API16 packages require Compás v1.1 or newer. Radio Browser remains `publish:false`; use Net Radio for station search and keep `Radio.txt` for saved stations.

## Validation

From the repository root, with Lua 5.5.1, run `lua tests/music_plugins/run.lua` and `lua tests/service_plugins/run.lua`, then `python3 tools/build_index.py --check`. The mocked API tests cover lookup failures, sidecar preservation, asynchronous callbacks, cover redirects, compilation albums, album continuation, ListenBrainz token and queue behavior, and Net Radio search, playback, and `Radio.txt` favorites. They do not claim an end-to-end network or device playback test.
