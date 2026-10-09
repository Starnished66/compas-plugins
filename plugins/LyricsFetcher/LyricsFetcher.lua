plugin.define({
    id = "example.lyrics_fetcher",
    name = "Lyrics Fetcher",
    version = "1.0.0",
    api_min = 15,
})

-- Fetches synced LRC lyrics from LRCLIB (no API key) for local tracks that
-- have no sidecar. Native lyrics_load_sidecar() swaps the audio filename's
-- extension for ".lrc" in the same folder; this plugin writes only that path.
-- Existing .lrc files are never replaced. Embedded tag lyrics are not
-- exposed to Lua, so they cannot be detected here.

local USER_AGENT = "CompasPlayer-LyricsFetcher/1.0 (https://github.com/Starnished66/compas-player)"
local STATE_PATH = plugin.sd_root() .. "/.plugins/.lyrics_fetcher_state"
local MAX_LRC_BYTES = 512 * 1024
local BACKOFF_SEC = 2
local MAX_RETRIES = 1

local state = { auto = false }
local pending = {} -- dest_path -> { gen = n, path = audio_path }
local generation = 0
local retry_at = 0
local retry_job = nil
local last_auto_toast_at = 0

local function trim(s)
    return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function load_state()
    local f = io.open(STATE_PATH, "r")
    if not f then return end
    local line = f:read("*l")
    f:close()
    state.auto = line == "1"
end

local function save_state()
    local tmp = STATE_PATH .. ".tmp"
    local f = io.open(tmp, "w")
    if not f then return end
    f:write(state.auto and "1" or "0", "\n")
    f:close()
    os.remove(STATE_PATH)
    os.rename(tmp, STATE_PATH)
end

local function url_encode(value)
    return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function header(headers, name)
    if type(headers) ~= "table" then return nil end
    local want = name:lower()
    for k, v in pairs(headers) do
        if type(k) == "string" and k:lower() == want then return v end
    end
    return nil
end

local function is_absolute_local_path(path)
    return type(path) == "string" and path:sub(1, 1) == "/" and not path:find("://", 1, true)
end

-- Same rule as lyrics_load_sidecar(): strip the last "." after the last "/",
-- then append ".lrc". A file with no extension gets ".lrc" appended.
local function sidecar_path(audio_path)
    if not is_absolute_local_path(audio_path) then return nil end
    local slash = audio_path:match("^.*()/")
    local base = audio_path
    local dir = ""
    if slash then
        dir = audio_path:sub(1, slash)
        base = audio_path:sub(slash + 1)
    end
    local dot = base:match("^.*()%.")
    if dot and dot > 1 then
        base = base:sub(1, dot - 1)
    end
    if base == "" then return nil end
    return dir .. base .. ".lrc"
end

local function file_exists(path)
    if not path then return false end
    local f = io.open(path, "rb")
    if not f then return false end
    f:close()
    return true
end

local function has_sync_line(text)
    if type(text) ~= "string" or text == "" then return false end
    return text:find("%[%d+:%d+") ~= nil
end

local function notify(message, is_auto)
    if is_auto then
        local now = os.time()
        if now - last_auto_toast_at < 30 then return end
        last_auto_toast_at = now
        return
    end
    plugin.show_toast(message)
end

local function atomic_write_lrc(dest, text)
    if file_exists(dest) then return false, "exists" end
    if type(text) ~= "string" or #text == 0 or #text > MAX_LRC_BYTES then
        return false, "invalid"
    end
    if not has_sync_line(text) then return false, "no-sync" end
    local tmp = dest .. ".compas-fetch"
    os.remove(tmp)
    local f = io.open(tmp, "wb")
    if not f then return false, "write" end
    local ok, err = f:write(text)
    local closed = f:close()
    if not ok or not closed then
        os.remove(tmp)
        return false, err or "write"
    end
    if file_exists(dest) then
        os.remove(tmp)
        return false, "exists"
    end
    if not os.rename(tmp, dest) then
        os.remove(tmp)
        return false, "rename"
    end
    return true
end

local function current_local_track()
    local path = plugin.get_current_track_path()
    if not is_absolute_local_path(path) then return nil end
    local title, artist, album, duration = plugin.get_now_playing()
    title, artist, album = trim(title), trim(artist), trim(album)
    if title == "" or artist == "" then return nil end
    duration = tonumber(duration) or 0
    return {
        path = path,
        title = title,
        artist = artist,
        album = album,
        duration = duration,
        dest = sidecar_path(path),
    }
end

local function extract_synced(record)
    if type(record) ~= "table" then return nil, "no-json" end
    if record.instrumental == true then return nil, "instrumental" end
    local synced = record.syncedLyrics
    if type(synced) ~= "string" or trim(synced) == "" then return nil, "no-sync" end
    if not has_sync_line(synced) then return nil, "no-sync" end
    return synced
end

local function build_url(track)
    local q = "track_name=" .. url_encode(track.title) .. "&artist_name=" .. url_encode(track.artist)
    if track.album ~= "" then
        q = q .. "&album_name=" .. url_encode(track.album)
    end
    local dur = math.floor(track.duration + 0.5)
    if dur >= 1 and dur <= 3600 then
        q = q .. "&duration=" .. tostring(dur)
    end
    return "https://lrclib.net/api/get?" .. q
end

local finish_fetch

local function start_http(track, is_auto, attempt)
    local dest = track.dest
    if not dest then return end
    if pending[dest] then return end
    if file_exists(dest) then
        notify("Lyrics already present", is_auto)
        return
    end

    generation = generation + 1
    local gen = generation
    pending[dest] = { gen = gen, path = track.path, dest = dest }

    local handle, start_err = plugin.http_request({
        url = build_url(track),
        method = "GET",
        headers = { ["User-Agent"] = USER_AGENT },
        verify_tls = true,
        max_response_bytes = MAX_LRC_BYTES,
        connect_timeout_ms = 10000,
        read_timeout_ms = 15000,
        total_timeout_ms = 30000,
        redirect_limit = 3,
    }, function(status, body, err, headers)
        finish_fetch(track, is_auto, attempt, gen, status, body, err, headers)
    end)

    if not handle then
        pending[dest] = nil
        notify("Could not start lyrics request: " .. (start_err or "unknown error"), is_auto)
    end
end

finish_fetch = function(track, is_auto, attempt, gen, status, body, err, headers)
    local dest = track.dest
    local job = pending[dest]
    if not job or job.gen ~= gen then return end

    local function retryable()
        if attempt >= MAX_RETRIES then return false end
        if err == "timeout" or err == "connect_timeout" or err == "connect_failed" then return true end
        if status == 429 or status == 503 then return true end
        return false
    end

    if retryable() then
        pending[dest] = nil
        local wait = BACKOFF_SEC
        local ra = tonumber(header(headers, "Retry-After"))
        if ra and ra > 0 then wait = math.min(30, math.max(1, math.floor(ra))) end
        retry_job = { track = track, is_auto = is_auto, attempt = attempt + 1 }
        retry_at = os.time() + wait
        return
    end

    pending[dest] = nil

    if plugin.get_current_track_path() ~= track.path then return end
    if file_exists(dest) then return end

    if err then
        notify("Lyrics fetch failed: " .. err, is_auto)
        return
    end
    if status == 404 then
        notify("No synced lyrics found", is_auto)
        return
    end
    if status ~= 200 or type(body) ~= "string" then
        notify("Lyrics fetch failed (HTTP " .. tostring(status) .. ")", is_auto)
        return
    end

    local record = plugin.json_decode(body)
    if not record then
        notify("Lyrics response was not JSON", is_auto)
        return
    end
    local lrc, why = extract_synced(record)
    if not lrc then
        if why == "instrumental" then
            notify("Track is instrumental", is_auto)
        else
            notify("No synced lyrics in result", is_auto)
        end
        return
    end

    local ok, write_err = atomic_write_lrc(dest, lrc)
    if ok then
        notify("Saved lyrics", is_auto)
    elseif write_err == "exists" then
        notify("Lyrics already present", is_auto)
    else
        notify("Could not save lyrics", is_auto)
    end
end

local function fetch_current(is_auto)
    if not plugin.has_capability("network.http.async") or not plugin.has_capability("data.json") then
        if not is_auto then plugin.show_toast("This player cannot fetch lyrics") end
        return
    end
    local track = current_local_track()
    if not track then
        notify("Play a local track with title and artist tags", is_auto)
        return
    end
    if not track.dest then
        notify("Cannot write lyrics for this path", is_auto)
        return
    end
    start_http(track, is_auto and true or false, 0)
end

plugin.on("track_started", function(_, _, _, _, provider)
    retry_job = nil
    if not state.auto then return end
    if provider and provider ~= "" then return end
    fetch_current(true)
end)

plugin.set_interval(1, function()
    if not retry_job then return end
    if os.time() < retry_at then return end
    local job = retry_job
    retry_job = nil
    if plugin.get_current_track_path() ~= job.track.path then return end
    start_http(job.track, job.is_auto, job.attempt)
end)

local function open_about()
    plugin.show_list("About Lyrics Fetcher", {
        "Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key.",
        "Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player.",
        "Never overwrites an existing .lrc. Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar.",
        "Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped.",
    }, function() end)
end

local function open_settings()
    plugin.show_settings_list("Lyrics Fetcher", {
        {
            type = "row",
            label = "Fetch lyrics for current track",
            on_select = function() fetch_current(false) end,
        },
        {
            type = "toggle",
            label = "Automatic fetch",
            value = state.auto,
            on_change = function(on)
                state.auto = on
                save_state()
            end,
        },
        {
            type = "row",
            label = "How it works",
            on_select = open_about,
        },
    })
end

load_state()
plugin.register_list_item("music_library", "Lyrics Fetcher", open_settings)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        sidecar_path = sidecar_path,
        is_absolute_local_path = is_absolute_local_path,
        extract_synced = extract_synced,
        has_sync_line = has_sync_line,
        atomic_write_lrc = atomic_write_lrc,
        build_url = build_url,
        fetch_current = fetch_current,
        pending = pending,
        state = state,
    }
end
