# Reading Room Player

Reading Room Player is an example plugin for a quieter, book-focused Now Playing screen. It demonstrates an XML layout, named player actions, and automatic session layout ownership when playback enters a chosen folder. It does not modify the separate Audiobooks plugin.

Audiobooks and Podcasts now also carry their own bundled copies of this layout and its icons. Their native bundles reuse each plugin's saved speed preferences. Use this standalone example for development without the native bundles, since both sets apply automatically to matching playback.

## Install

Copy `ReadingRoomPlayer.lua` to `<SD card>/.plugins/ReadingRoomPlayer.lua`, then copy the whole `player_layouts` directory, including its shared `reading_room/` icon folder, to `<SD card>/.plugins/ReadingRoomPlayer/player_layouts/`. Refresh plugins in the player. **Reading Room · Paper** is registered as a player layout and applies automatically when playback starts below the SD card's `Audiobooks/` or `Podcasts/` directory.

When a track starts outside those folders, the plugin asks the owner-scoped layout restore API to return to the preferred layout. Pausing does not trigger a restore. If the user has selected another layout, that choice remains in place.

The folder hook demonstrates how automatic folder-based layout works; this example does not configure either production plugin. The main transport has custom 15-second rewind/forward controls around play; the lower row has previous/next track controls and a **Speed** button. Speed choices open directly and changes are scoped to whichever supported folder contains the current track. Tapping the album opens a small book menu with current track information. No shuffle control, chapter bookmarks, or chapter-aware seeking are provided.

The XML files include a 480×800 layout and `@480x720` / `@320x480` variants. Lyrics are disabled, the album label opens the Reading Room menu, and the author label has no automatic library action. This example requires plugin API 17; older firmware rejects it before loading.

The layout uses a dark charcoal background, light controls, and open-arrow 15-second skip icons. The larger cover and lower control rows use the available screen height while keeping the gesture area clear.
