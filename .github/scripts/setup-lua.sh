#!/bin/sh
# Builds luac from the same Lua release the player vendors (5.5.1), so a
# plugin that compiles here also compiles on the device.
set -eu
LUA=lua-5.5.1
SHA256=1c4b4068d67061f2a2231ad2b5422e77acea1487ea9890f6320af614f4373dce
cd "${RUNNER_TEMP:-/tmp}"
curl -fsSLO "https://www.lua.org/ftp/$LUA.tar.gz"
echo "$SHA256  $LUA.tar.gz" | sha256sum -c -
tar xzf "$LUA.tar.gz"
make -C "$LUA" linux >/dev/null
echo "$PWD/$LUA/src" >> "${GITHUB_PATH:-/dev/null}"
