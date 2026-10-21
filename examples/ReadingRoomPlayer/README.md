# Reading Room Player

Reading Room Player is an example plugin for a quieter, book-focused Now Playing screen. It demonstrates an XML layout, named player actions, and optional session layout ownership when playback enters a chosen folder. It does not modify the separate Audiobooks plugin.

Audiobooks and Podcasts now also carry their own bundled copies of this layout and its icons. Their native bundles reuse each plugin's saved speed preferences. This standalone example is optional; disable it when using those bundles to avoid competing automatic selections.

## Install

Copy `ReadingRoomPlayer.lua` to `<SD card>/.plugins/ReadingRoomPlayer.lua`, then copy the whole `player_layouts` directory, including its shared `reading_room/` icon folder, to `<SD card>/.plugins/ReadingRoomPlayer/player_layouts/`. Refresh plugins in the player. **Reading Room · Paper** then appears in **Settings → Display → Player Layout**; loading this plugin only registers it and does not apply it.

Choose **Reading Room · Paper** in the display settings, or use its Reading Room row to apply it for the current session. **Use for Audiobooks folder** starts disabled to preserve its existing preference; **Use for Podcasts folder** starts enabled. Each option can be toggled independently. Enabled folders apply the layout when a track starts anywhere below the SD card's exact `Audiobooks/` or `Podcasts/` directory; enabling an option while a matching track is already playing applies immediately. When a track starts outside enabled folders, or inside a folder whose option is disabled, the plugin asks the owner-scoped layout restore API to return to the preferred layout. Pausing does not trigger a restore. If the user has selected another layout, that choice remains in place. Turning an option off restores the preferred layout only when playback is currently in that folder.

The folder hook demonstrates how folder-based auto-layout can coexist with the real Audiobooks and Podcasts plugins; this example does not edit or configure either production plugin. The main transport has custom 15-second rewind/forward controls around play; the lower row has previous/next track controls and a **Speed** button. Speed choices open directly and changes are scoped to whichever supported folder contains the current track. Tapping the album opens a small book menu with current track information and a return-to-preferred-layout action. No shuffle control, chapter bookmarks, or chapter-aware seeking are provided.

The XML files include a 480×800 layout and `@480x720` / `@320x480` variants. Lyrics are disabled, the album label opens the Reading Room menu, and the author label has no automatic library action. This example requires plugin API 17; older firmware rejects it before loading.

The layout uses a dark charcoal background, light controls, and open-arrow 15-second skip icons. The larger cover and lower control rows use the available screen height while keeping the gesture area clear.
