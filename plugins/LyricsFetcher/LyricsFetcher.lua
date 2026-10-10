plugin.define({
    id = "example.lyrics_fetcher",
    name = "Lyrics Fetcher",
    version = "1.1.2",
    api_min = 16,
})

-- Fetches synced LRC lyrics from LRCLIB (no API key) for local tracks that
-- have no sidecar. Native lyrics_load_sidecar() swaps the audio filename's
-- extension for ".lrc" in the same folder; this plugin writes only that path.
-- Existing .lrc files are never replaced. Embedded tag lyrics are not
-- exposed to Lua, so they cannot be detected here.

local USER_AGENT = "CompasPlayer-LyricsFetcher/1.0 (https://github.com/Starnished66/compas-player)"
local STATE_PATH = plugin.sd_root() .. "/.plugins/.lyrics_fetcher_state"
local MAX_LRC_BYTES = 512 * 1024
local MAX_PATH_BYTES = 4095
local MAX_FILENAME_BYTES = 255
local MAX_METADATA_BYTES = 128
local MAX_URL_BYTES = 2047
local TEMP_SUFFIX = ".compas-fetch"
local BACKOFF_SEC = 2
local MAX_RETRIES = 1

local state = { auto = false }
local in_flight = nil -- the sole native HTTP request/retry owner
local queued = nil -- latest requested current-track job
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
    local line = f:read(2)
    f:close()
    state.auto = line == "1" or line == "1\n"
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

local function show_progress(job, message, fraction, reopen)
    if not job or not job.manual_requested or not plugin.has_capability("ui.progress") then return false end
    if job.progress_handle and plugin.update_progress(job.progress_handle, message, fraction) then return true end
    if job.progress_handle then job.progress_handle = nil end
    if job.progress_attempted and not reopen then return false end
    job.progress_attempted = true
    job.progress_handle = plugin.show_progress("Fetching lyrics", message, fraction)
    return job.progress_handle ~= nil
end

local function close_progress(job)
    if job and job.progress_handle then
        plugin.close_progress(job.progress_handle)
        job.progress_handle = nil
    end
end

local function notify_job(job, message)
    if not job or not job.manual_requested then return end
    plugin.show_toast(message)
end

local function atomic_write_lrc(dest, text)
    if file_exists(dest) then return false, "exists" end
    if type(text) ~= "string" or #text == 0 or #text > MAX_LRC_BYTES then
        return false, "invalid"
    end
    if not has_sync_line(text) then return false, "no-sync" end
    local tmp = dest .. TEMP_SUFFIX
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

local function path_is_bounded_under_root(path)
    if type(path) ~= "string" or #path == 0 or #path > MAX_PATH_BYTES or path:find("\0", 1, true) then return false end
    if path:find("//", 1, true) or path:match("/%.%.?/") or path:match("/%.%.?$") then return false end
    local root = plugin.sd_root()
    if type(root) ~= "string" or root == "" or root:find("\0", 1, true) or root:find("//", 1, true) then return false end
    if root ~= "/" then
        root = root:gsub("/+$", "")
        if path == root or path:sub(1, #root + 1) ~= root .. "/" then return false end
    elseif path:sub(1, 2) == "//" then
        return false
    end
    return true
end

local function destination_is_bounded(dest)
    if not path_is_bounded_under_root(dest) then return false end
    local basename = dest:match("([^/]+)$")
    return basename ~= nil and #basename + #TEMP_SUFFIX <= MAX_FILENAME_BYTES and
        #dest + #TEMP_SUFFIX <= MAX_PATH_BYTES
end

local function current_local_track()
    local path = plugin.get_current_track_path()
    if not is_absolute_local_path(path) then return nil end
    local title, artist, album, duration = plugin.get_now_playing()
    if type(title) ~= "string" or type(artist) ~= "string" or (album ~= nil and type(album) ~= "string") then return nil end
    if #title > MAX_METADATA_BYTES or #artist > MAX_METADATA_BYTES or (album and #album > MAX_METADATA_BYTES) then return nil end
    if plugin.get_current_track_path() ~= path then return nil end
    title, artist, album = trim(title), trim(artist), trim(album)
    if title == "" or artist == "" then return nil end
    if not path_is_bounded_under_root(path) then return nil end
    duration = tonumber(duration) or 0
    if duration ~= duration or duration == math.huge or duration == -math.huge then duration = 0 end
    local dest = sidecar_path(path)
    if not destination_is_bounded(dest) then return nil end
    return {
        path = path,
        title = title,
        artist = artist,
        album = album,
        duration = duration,
        dest = dest,
    }
end

local function extract_synced(record)
    if type(record) ~= "table" then return nil, "no-json" end
    if record.instrumental == true then return nil, "instrumental" end
    local synced = record.syncedLyrics
    if type(synced) ~= "string" or #synced == 0 or #synced > MAX_LRC_BYTES then return nil, "no-sync" end
    if trim(synced) == "" then return nil, "no-sync" end
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
    local url = "https://lrclib.net/api/get?" .. q
    if #url > MAX_URL_BYTES then return nil end
    return url
end

local finish_fetch
local drain_queue
local start_http

local function clear_in_flight(job)
    if in_flight == job then in_flight = nil end
end

drain_queue = function()
    if in_flight or not queued then return end
    local job = queued
    queued = nil
    if plugin.get_current_track_path() ~= job.track.path then
        close_progress(job)
        return
    end
    start_http(job.track, job.is_auto, job.attempt or 0, job)
end

local function queue_or_start(track, is_auto, progress_job)
    if in_flight then
        if in_flight.path == track.path and in_flight.dest == track.dest then
            if not is_auto then
                in_flight.manual_requested = true
                show_progress(in_flight, in_flight.stage or "Looking up lyrics…", nil, true)
            end
            return
        end
        if queued and queued.path == track.path and queued.dest == track.dest then
            if not is_auto then
                queued.is_auto = false
                queued.manual_requested = true
                show_progress(queued, queued.stage or "Queued for lyrics lookup…", nil, true)
            end
            return
        end
        if queued then close_progress(queued) end
        if in_flight.path ~= track.path then
            close_progress(in_flight)
            in_flight.manual_requested = false
        end
        queued = progress_job or { path = track.path, dest = track.dest, manual_requested = not is_auto }
        queued.track, queued.is_auto, queued.attempt = track, is_auto, 0
        queued.stage = "Queued for lyrics lookup…"
        if not is_auto then show_progress(queued, queued.stage, nil, false) end
        return
    end
    start_http(track, is_auto, 0, progress_job)
end

start_http = function(track, is_auto, attempt, progress_job)
    local dest = track.dest
    if file_exists(dest) then close_progress(progress_job); notify("Lyrics already present", is_auto); return false end
    local url = build_url(track)
    if not url then close_progress(progress_job); notify("Lyrics request is too long", is_auto); return false end
    generation = generation + 1
    local gen = generation
    local job = progress_job or { path = track.path, dest = dest, is_auto = is_auto }
    job.gen, job.path, job.dest = gen, track.path, dest
    job.track, job.is_auto, job.attempt = track, is_auto, attempt
    if not progress_job then job.manual_requested = not is_auto end
    job.stage = attempt > 0 and "Retrying lyrics lookup…" or "Looking up lyrics…"
    in_flight = job
    show_progress(job, job.stage, nil, false)
    local ok, handle, start_err = pcall(plugin.http_request, {
        url = url, method = "GET", headers = { ["User-Agent"] = USER_AGENT }, verify_tls = true,
        max_response_bytes = MAX_LRC_BYTES, connect_timeout_ms = 10000, read_timeout_ms = 15000,
        total_timeout_ms = 30000, redirect_limit = 3,
    }, function(status, body, err, headers)
        finish_fetch(track, is_auto, attempt, gen, status, body, err, headers)
    end)
    if not ok or not handle then
        clear_in_flight(job)
        close_progress(job)
        notify_job(job, "Could not start lyrics request: " .. tostring(ok and start_err or handle))
        drain_queue()
        return false
    end
    return true
end

finish_fetch = function(track, is_auto, attempt, gen, status, body, err, headers)
    local job = in_flight
    if not job or job.gen ~= gen then return end
    local function done()
        clear_in_flight(job)
        drain_queue()
    end
    if plugin.get_current_track_path() ~= track.path then
        retry_job = nil
        close_progress(job)
        done()
        return
    end
    local retryable = attempt < MAX_RETRIES and
        (err == "timeout" or err == "connect_timeout" or err == "connect_failed" or status == 429 or status == 503)
    if retryable then
        local wait = BACKOFF_SEC
        local ra = tonumber(header(headers, "Retry-After"))
        if ra and ra > 0 then wait = math.min(30, math.max(1, math.floor(ra))) end
        job.stage = "Retrying lyrics lookup…"
        show_progress(job, job.stage, nil, false)
        retry_job = { track = track, is_auto = is_auto, attempt = attempt + 1, progress_job = job }
        retry_at = os.time() + wait
        return
    end
    retry_job = nil
    if plugin.get_current_track_path() ~= track.path or file_exists(track.dest) then
        close_progress(job); done(); return
    end
    if err then
        close_progress(job); notify_job(job, "Lyrics fetch failed: " .. err); done(); return
    end
    if status == 404 then
        close_progress(job); notify_job(job, "No synced lyrics found"); done(); return
    end
    if status ~= 200 or type(body) ~= "string" or #body > MAX_LRC_BYTES then
        close_progress(job); notify_job(job, "Lyrics fetch failed (HTTP " .. tostring(status) .. ")"); done(); return
    end
    local decoded, record = pcall(plugin.json_decode, body, { max_input_bytes = MAX_LRC_BYTES, max_nesting = 8, max_entries = 64 })
    if not decoded or not record then
        close_progress(job); notify_job(job, "Lyrics response was not JSON"); done(); return
    end
    local lrc, why = extract_synced(record)
    if not lrc then
        close_progress(job)
        notify_job(job, why == "instrumental" and "Track is instrumental" or "No synced lyrics in result")
        done(); return
    end
    job.stage = "Saving lyrics…"
    show_progress(job, job.stage, nil, false)
    local ok, write_err = atomic_write_lrc(track.dest, lrc)
    close_progress(job)
    if ok then notify_job(job, "Saved lyrics")
    elseif write_err == "exists" then notify_job(job, "Lyrics already present")
    else notify_job(job, "Could not save lyrics") end
    done()
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
    if retry_job and retry_job.track.path == track.path then
        if not is_auto then
            retry_job.is_auto = false
            if retry_job.progress_job then
                retry_job.progress_job.manual_requested = true
                show_progress(retry_job.progress_job, retry_job.progress_job.stage or "Retrying lyrics lookup…", nil, true)
            end
        end
        return
    elseif retry_job then
        close_progress(retry_job.progress_job)
        retry_job = nil
        clear_in_flight(in_flight)
        drain_queue()
    end
    queue_or_start(track, is_auto and true or false)
end

plugin.on("track_started", function(_, _, _, _, provider)
    local path = plugin.get_current_track_path()
    if in_flight and in_flight.path ~= path then
        close_progress(in_flight)
        in_flight.manual_requested = false
    end
    if retry_job and retry_job.track.path ~= path then
        close_progress(retry_job.progress_job)
        clear_in_flight(in_flight)
        retry_job = nil
    end
    if queued and queued.track.path ~= path then
        close_progress(queued)
        queued = nil
    end
    if not state.auto or (provider and provider ~= "") then return end
    fetch_current(true)
end)

plugin.set_interval(1, function()
    if retry_job and os.time() >= retry_at then
        local retry = retry_job
        retry_job = nil
        if plugin.get_current_track_path() ~= retry.track.path then
            close_progress(retry.progress_job)
            clear_in_flight(in_flight)
            drain_queue()
        else
            clear_in_flight(in_flight)
            start_http(retry.track, retry.is_auto, retry.attempt, retry.progress_job)
        end
    end
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
        get_queue_state = function() return in_flight, queued end,
        state = state,
    }
end
