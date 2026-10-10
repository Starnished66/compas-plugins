#!/bin/sh
set -eu
repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
player_root=${COMPAS_PLAYER_ROOT:-"$repo_root/../compas-player"}
lua_bin=${LUA55_STANDALONE:-"$player_root/build_test/lua55-standalone/lua"}
exec "$lua_bin" "$repo_root/scripts/test_kids_mode.lua" "$repo_root/plugins/KidsMode/KidsMode.lua"
