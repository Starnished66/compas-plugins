# Action Deck Player

An install-by-hand example for XML player layouts and plugin-owned player
actions. **Stage** is a dark editorial cover-and-transport layout with artist,
album, and custom track menus. It includes 480×800, 480×720, and 320×480
versions.

## Install

Copy these files to the SD card, preserving the paths:

```text
.plugins/ActionDeckPlayer.lua
.plugins/ActionDeckPlayer/player_layouts/stage.xml
.plugins/ActionDeckPlayer/player_layouts/stage@480x720.xml
.plugins/ActionDeckPlayer/player_layouts/stage@320x480.xml
```

Refresh plugins. The plugin registers both designs in **Settings → Display →
Player Layout → Layout** but does not activate it. Choose Stage there, or
use its Action Deck row in Display to apply it for the current session. The
restore row returns to the saved player-layout preference when supported.

## Try the interactions

- Tap the displayed artist or album to open a plugin menu with the current
  metadata and file path, plus play/pause, next, and previous actions.
- Tap **MENU** for the current-track menu.
- Open Lyrics to confirm the layout retains normal lyrics behavior.
- Reload plugins while Stage is active to verify unavailable plugin actions
  become inert safely.

The menus use only existing plugin APIs and report the actual current path;
they do not claim to browse an artist or album library.
