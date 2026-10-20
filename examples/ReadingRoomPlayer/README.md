# Reading Room Player

Reading Room Player is an example plugin for a quieter, book-focused Now Playing screen. It demonstrates an XML layout, named player actions, and optional session layout ownership when playback enters a chosen folder. It does not modify the separate Audiobooks plugin.

## Install

Copy `ReadingRoomPlayer.lua` to `<SD card>/.plugins/ReadingRoomPlayer.lua`, then copy the whole `player_layouts` directory, including its shared `reading_room/` icon folder, to `<SD card>/.plugins/ReadingRoomPlayer/player_layouts/`. Refresh plugins in the player. **Reading Room · Paper** then appears in **Settings → Display → Player Layout**; loading this plugin only registers it and does not apply it.

Choose **Reading Room · Paper** in the display settings, or use its Reading Room row to apply it for the current session. The **Use for Audiobooks folder** option starts disabled. Turn it on to apply the Reading Room layout when a track starts inside the SD card's exact `Audiobooks/` folder; enabling it while an audiobook is already playing applies immediately. When a track starts elsewhere, the plugin asks the owner-scoped layout restore API to return to the preferred layout. Pausing does not trigger a restore. If the user has selected another layout, that choice remains in place. Turning the option off also asks the owner-scoped API to restore the preferred layout.

The folder hook demonstrates how the real Audiobooks plugin could reuse an owner-scoped layout hook; this example does not edit or configure that production plugin. The main transport has custom 15-second rewind/forward controls around play; the lower row has previous/next track controls and a **Speed** button. Speed choices open directly and changes are scoped to the Audiobooks directory. Tapping the album opens a small book menu with current track information and a return-to-preferred-layout action. No shuffle control, chapter bookmarks, or chapter-aware seeking are provided.

The XML files include a 480×800 layout and `@480x720` / `@320x480` variants. Lyrics are disabled, the album label opens the Reading Room menu, and the author label has no automatic library action. This example requires player action and owner-scoped layout restore capabilities so its controls and folder hook are available only on compatible player builds.

The layout uses a dark charcoal background, light controls, and open-arrow 15-second skip icons. The larger cover and lower control rows use the available screen height while keeping the gesture area clear.
