plugin.define({ id = "example.net_radio", name = "Net Radio", version = "1.4", api_min = 1 })

-- Net Radio reads its stations from Radio.txt at the root of the SD card:
--
--   Station Name | http://example.com/direct-stream.mp3
--
-- Blank lines and lines beginning with # are ignored. A line containing
-- only an http(s) URL is also accepted; the URL is then used as its label.
-- The file is read again every time the tile is opened, so station changes
-- do not require restarting the player or reloading the plugin.
--
-- Current stream limitations:
--   * Streams may serve MP3, FLAC, or ADTS-framed AAC/AAC+ audio.
--   * Streams cannot seek and do not auto-reconnect after a connection loss.
--   * ICY/stream metadata is not displayed; Radio.txt supplies the title.

local RADIO_FILE = plugin.sd_root() .. "/Radio.txt"
local THEME_ICON_ROOT = "/usr/resource/litegui/theme2/"
local MAX_FILE_BYTES, MAX_LINE_BYTES, MAX_STATIONS = 65536, 1024, 500

-- Absolute theme2 paths are supported for show_list() row icons and keep the
-- station rows aligned with the native wireless submenu artwork.
local function themed_item(label, icon)
    return { label = label, icon = THEME_ICON_ROOT .. icon }
end

local function trim(value)
    return (value:gsub("^%s+", ""):gsub("%s+$", ""))
end

-- Reads at most MAX_FILE_BYTES and keeps at most MAX_STATIONS (the most
-- show_list() and play_list() accept). Anything past a bound is left out and
-- reported, rather than refusing the whole list.
local function load_stations()
    local file = io.open(RADIO_FILE, "r")
    if not file then
        return nil
    end

    local body = file:read(MAX_FILE_BYTES + 1) or ""
    file:close()
    local truncated = false
    if #body > MAX_FILE_BYTES then
        -- Drop the partial last line.
        body = body:sub(1, MAX_FILE_BYTES):match("^(.*)\n") or ""
        truncated = true
    end

    local labels, urls = {}, {}
    for line in (body .. "\n"):gmatch("(.-)\n") do
        if #line > MAX_LINE_BYTES then
            truncated = true
        else
            -- Lua 5.4 treats a generic-for control variable as const. Normalize
            -- into a separate local instead of assigning back into `line`.
            local text = trim(line:gsub("\r$", ""))
            if text ~= "" and text:sub(1, 1) ~= "#" then
                local name, url = text:match("^(.-)%s*|%s*(https?://.+)$")
                if not url and text:match("^https?://") then
                    name, url = text, text
                end

                if url and #urls >= MAX_STATIONS then
                    -- Only a station that really would be left out counts.
                    truncated = true
                    break
                end
                if url then
                    name, url = trim(name), trim(url)
                    if name == "" then name = url end
                    labels[#labels + 1] = name
                    urls[#urls + 1] = url
                end
            end
        end
    end
    if #urls == 0 then
        return nil
    end
    return { labels = labels, urls = urls }, truncated
end

local function open_stations()
    local stations, truncated = load_stations()
    if not stations then
        plugin.show_toast("Could not load stations. Check Radio.txt on the SD card.")
        return
    end

    local items = {}
    for i, label in ipairs(stations.labels) do
        items[i] = themed_item(label, "wireless/list_airplay.png")
    end

    plugin.show_list("Net Radio", items, function(index)
        plugin.play_list(stations.urls, index)
    end)
    if truncated then
        plugin.show_toast("Some stations could not be listed")
    end
end

plugin.register_stream_media_tile("Net Radio", open_stations, "wireless/list_airplay.png")
