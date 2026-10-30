plugin.define({
    id = "example.lyrics_fetcher",
    name = "Lyrics Fetcher",
    version = "1.4.0",
    api_min = 17,
})

-- Fetches synced LRC lyrics from LRCLIB (no API key) for local tracks.
-- Native lyrics_load_sidecar() swaps the audio filename's extension for
-- ".lrc" in the same folder and reads only that path; this plugin writes
-- only that sidecar. A sidecar that already has timestamps is left alone.
-- An unsynchronized .lrc is renamed to .compas-backup (or -2..-9) before
-- the synced file is written, matching Cover Art Fetcher's unread backup
-- suffix. filename_sync.lrc is not a native lookup name. Embedded tag
-- lyrics are not exposed to Lua, so they cannot be detected here.

local USER_AGENT = "CompasPlayer-LyricsFetcher/1.4 (https://github.com/Starnished66/compas-player)"
local STATE_PATH = plugin.sd_root() .. "/.plugins/.lyrics_fetcher_state"
local MAX_LRC_BYTES = 512 * 1024
local MAX_PATH_BYTES = 4095
local MAX_FILENAME_BYTES = 255
local MAX_METADATA_BYTES = 128
local MAX_URL_BYTES = 2047
local TEMP_SUFFIX = ".compas-fetch"
local BACKUP_SUFFIX = ".compas-backup"
local MAX_BACKUP_SLOTS = 9
-- Longest extra name this plugin appends: ".compas-backup-9".
local MAX_SIDECAR_EXTRA = math.max(#TEMP_SUFFIX, #BACKUP_SUFFIX + 2)
local QUEUE_PATH = plugin.sd_root() .. "/.plugins/.lyrics_fetcher_pending"
local QUEUE_MAX_ENTRIES = 500
local QUEUE_MAX_BYTES = 2 * 1024 * 1024
local RETRY_BASE_SEC = 60
local RETRY_JITTER_SEC = 5

local state = { auto = false }
local in_flight = nil -- the sole native HTTP request/retry owner
local generation = 0
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

-- True when inner is a complete native [mm:ss] / [mm:ss.xx] timestamp:
-- digits, colon, digits, and an optional fraction of digits only. Trailing
-- junk such as [12:34broken] does not count (native requires the whole
-- bracket contents to be consumed).
local function is_timestamp_inner(inner)
    if type(inner) ~= "string" or inner == "" then return false end
    local minutes, rest = inner:match("^(%d+):(.*)$")
    if not minutes or rest == nil then return false end
    if rest:match("^%d+$") then return true end
    local seconds, frac = rest:match("^(%d+)%.(%d+)$")
    return seconds ~= nil and frac ~= nil
end

local function line_has_leading_timestamp(line)
    if type(line) ~= "string" or line == "" then return false end
    if line:sub(-1) == "\r" then line = line:sub(1, -2) end
    local i = 1
    local found = false
    while line:sub(i, i) == "[" do
        local close = line:find("]", i, true)
        if not close then break end
        local inner = line:sub(i + 1, close - 1)
        local lower = inner:lower()
        if inner:sub(1, 1):match("%d") and is_timestamp_inner(inner) then
            found = true
            i = close + 1
        elseif lower:sub(1, 7) == "offset:" then
            i = close + 1
        elseif inner:match("^[A-Za-z][A-Za-z]?[A-Za-z]?[A-Za-z]?[A-Za-z]?[A-Za-z]?:") then
            i = close + 1
        else
            break
        end
    end
    return found
end

-- Native lyrics_parse_buffer() is sync-only: a line counts only when it
-- has at least one complete leading timestamp tag. Metadata ([ti:], [ar:],
-- 1-6 letters then ':') and [offset:] are skipped. A UTF-8 BOM at the
-- start of the file is ignored. A timestamp inside ordinary text, or a
-- malformed bracket, does not make the sidecar synchronized.
local function has_sync_line(text)
    if type(text) ~= "string" or text == "" then return false end
    if text:sub(1, 3) == "\239\187\191" then text = text:sub(4) end
    for line in (text .. "\n"):gmatch("(.-)\n") do
        if line_has_leading_timestamp(line) then return true end
    end
    return false
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

local function read_sidecar(path)
    if not path then return nil, "missing" end
    local f, _, code = io.open(path, "rb")
    if not f then
        -- ENOENT is absence; any other open error must block a replace.
        if code == 2 then return nil, "missing" end
        return nil, "unreadable"
    end
    local text, read_err = f:read(MAX_LRC_BYTES + 1)
    local closed = f:close()
    if not closed then return nil, "unreadable" end
    if text == nil then
        if read_err then return nil, "unreadable" end
        text = ""
    end
    if type(text) ~= "string" then return nil, "unreadable" end
    if #text > MAX_LRC_BYTES then return nil, "too-large" end
    return text, "ok"
end

local function sidecar_kind(text)
    if type(text) ~= "string" then return "missing" end
    if has_sync_line(text) then return "synced" end
    return "unsynced"
end

local function snapshot_sidecar(path)
    local text, status = read_sidecar(path)
    if status == "missing" then return { kind = "missing" } end
    if status ~= "ok" then return { kind = "blocked", reason = status } end
    return { kind = sidecar_kind(text), text = text }
end

local function snapshot_allows_fetch(snap)
    return snap ~= nil and (snap.kind == "missing" or snap.kind == "unsynced")
end

local function snapshot_still_valid(path, snap)
    if not snap or not snapshot_allows_fetch(snap) then return false end
    local now = snapshot_sidecar(path)
    if snap.kind == "missing" then return now.kind == "missing" end
    return now.kind == "unsynced" and now.text == snap.text
end

-- First free unread backup name; an existing backup is never reused.
local function backup_path(path)
    for slot = 1, MAX_BACKUP_SLOTS do
        local candidate = path .. BACKUP_SUFFIX .. (slot == 1 and "" or ("-" .. slot))
        if #candidate > MAX_PATH_BYTES then return nil end
        local basename = candidate:match("([^/]+)$")
        if not basename or #basename > MAX_FILENAME_BYTES then return nil end
        if not file_exists(candidate) then return candidate end
    end
    return nil
end

local function write_temp_lrc(tmp, text)
    os.remove(tmp)
    local f = io.open(tmp, "wb")
    if not f then return false, "write" end
    local ok, err = f:write(text)
    local closed = f:close()
    if not ok or not closed then
        os.remove(tmp)
        return false, err or "write"
    end
    return true
end

-- Writes synced lyrics to the native sidecar path. Missing dest is created.
-- An unsynchronized dest matching snap is renamed to .compas-backup first.
-- Synchronized dest, a changed dest, or a path/content race is refused.
-- If the final rename fails after backup, the unsynchronized file is restored.
local function install_synced_lrc(dest, text, snap)
    if type(text) ~= "string" or #text == 0 or #text > MAX_LRC_BYTES then
        return false, "invalid"
    end
    if not has_sync_line(text) then return false, "no-sync" end
    if not snapshot_still_valid(dest, snap) then
        local now = snapshot_sidecar(dest)
        if now.kind == "synced" then return false, "exists" end
        return false, "stale"
    end
    local tmp = dest .. TEMP_SUFFIX
    local wrote, write_err = write_temp_lrc(tmp, text)
    if not wrote then return false, write_err end
    if not snapshot_still_valid(dest, snap) then
        os.remove(tmp)
        local now = snapshot_sidecar(dest)
        if now.kind == "synced" then return false, "exists" end
        return false, "stale"
    end
    if snap.kind == "unsynced" then
        local backup = backup_path(dest)
        if not backup or file_exists(backup) then
            os.remove(tmp)
            return false, "backup"
        end
        if not os.rename(dest, backup) or file_exists(dest) or not file_exists(backup) then
            os.remove(tmp)
            return false, "backup"
        end
        if not os.rename(tmp, dest) or not file_exists(dest) then
            os.rename(backup, dest)
            os.remove(tmp)
            return false, "rename"
        end
        return true
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

local function atomic_write_lrc(dest, text)
    return install_synced_lrc(dest, text, snapshot_sidecar(dest))
end

local function refresh_current_lyrics_display(track_path)
    if type(track_path) ~= "string" or track_path == "" then return false end
    local ok, refreshed = pcall(plugin.refresh_lyrics, track_path)
    return ok == true and refreshed == true
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
    return basename ~= nil and #basename + MAX_SIDECAR_EXTRA <= MAX_FILENAME_BYTES and
        #dest + MAX_SIDECAR_EXTRA <= MAX_PATH_BYTES
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
        duration = duration > 3600 and 0 or math.max(0, duration),
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
local pending = {}
local request_order = 0
local next_drain_at = 0
local queue_paused_until = 0
local rate_limited_until = 0
local network_backoff_until = 0
local network_failures = 0
local queue_corrupt = false

local function safe_number(n, min, max)
    n = tonumber(n)
    if not n or n ~= n or n == math.huge or n == -math.huge or n < min or n > max then return nil end
    return n
end

local function field_escape(s)
    return (tostring(s or ""):gsub("([^%w%-%.%_%~])", function(c) return string.format("%%%02X", string.byte(c)) end))
end
local function field_unescape(s)
    if type(s) ~= "string" or s:gsub("%%[%x][%x]", ""):find("%", 1, true) then return nil end
    local bad = false
    local out = s:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    if out:find("[%z\1-\8\11\12\14-\31\127]") then bad = true end
    if bad then return nil end
    return out
end
local function serialize_queue(items)
    if #items > QUEUE_MAX_ENTRIES then return nil end
    local lines = { "LFQ1\t" .. string.format("%.0f", math.ceil(rate_limited_until)) }
    for _, e in ipairs(items) do
        lines[#lines + 1] = table.concat({ tostring(e.order), tostring(e.requested), tostring(e.retry_at or 0),
            field_escape(e.path), field_escape(e.title), field_escape(e.artist), field_escape(e.album), tostring(e.duration or 0), e.settled and "1" or "0", tostring(e.attempts or 0) }, "\t")
    end
    local data = table.concat(lines, "\n") .. (#lines > 0 and "\n" or "")
    if #data > QUEUE_MAX_BYTES then return nil end
    return data
end
local function persist_queue(items)
    local data = serialize_queue(items)
    if not data then return false end
    local tmp = QUEUE_PATH .. ".tmp"
    local f = io.open(tmp, "wb")
    if not f then return false end
    local ok = f:write(data)
    local closed = f:close()
    if not ok or not closed then os.remove(tmp); return false end
    if not os.rename(tmp, QUEUE_PATH) then os.remove(tmp); return false end
    return true
end
local function valid_queue_entry(fields)
    local order = safe_number(fields[1], 1, 9e15)
    local requested = safe_number(fields[2], 1, 9e15)
    local retry_at = safe_number(fields[3], 0, 9e15)
    local path, title, artist, album = field_unescape(fields[4]), field_unescape(fields[5]), field_unescape(fields[6]), field_unescape(fields[7])
    local duration = safe_number(fields[8], 0, 3600)
    local attempts = safe_number(fields[10], 0, 30)
    if not attempts or attempts % 1 ~= 0 then return nil end
    local settled = fields[9] == "1"
    if fields[9] ~= "1" and fields[9] ~= "0" then return nil end
    if not order or not requested or not retry_at or not path or not title or not artist or not album or not duration then return nil end
    if #path > MAX_PATH_BYTES or #title > MAX_METADATA_BYTES or #artist > MAX_METADATA_BYTES or #album > MAX_METADATA_BYTES then return nil end
    if not is_absolute_local_path(path) or not path_is_bounded_under_root(path) or trim(title) == "" or trim(artist) == "" then return nil end
    local dest = sidecar_path(path)
    if not destination_is_bounded(dest) then return nil end
    return { order=order, requested=requested, retry_at=retry_at, path=path, title=trim(title), artist=trim(artist), album=trim(album), duration=duration, dest=dest, settled=settled, attempts=attempts }
end
local function load_queue()
    local f, _, code = io.open(QUEUE_PATH, "rb")
    if not f then
        if code == 2 then pending = {}; queue_corrupt = false; return true end
        queue_corrupt = true
        return false
    end
    local data, read_err = f:read(QUEUE_MAX_BYTES + 1)
    local closed = f:close()
    if read_err or not closed then queue_corrupt = true; return false end
    if type(data) ~= "string" or #data > QUEUE_MAX_BYTES then queue_corrupt = true; return false end
    local loaded, seen = {}, {}
    local header_line, rest = data:match("^([^\n]*)\n(.*)$")
    local persisted_rate = header_line and header_line:match("^LFQ1\t([%d%.]+)$")
    persisted_rate = safe_number(persisted_rate, 0, 9e15)
    if not persisted_rate then queue_corrupt = true; return false end
    rate_limited_until = math.max(rate_limited_until, persisted_rate)
    for line in (rest .. "\n"):gmatch("(.-)\n") do
        if line ~= "" then
            local fields = {}
            for part in (line .. "\t"):gmatch("(.-)\t") do
                if #fields == 10 then queue_corrupt = true; return false end
                fields[#fields + 1] = part
            end
            if #fields ~= 10 then queue_corrupt = true; return false end
            local e = valid_queue_entry(fields)
            if not e or seen[e.dest] or #loaded >= QUEUE_MAX_ENTRIES then queue_corrupt = true; return false end
            seen[e.dest] = true; loaded[#loaded + 1] = e
            request_order = math.max(request_order, e.order)
        end
    end
    pending = loaded
    queue_corrupt = false
    return true
end
local function replace_queue(items)
    if not persist_queue(items) then return false end
    pending = items
    return true
end
local function remove_entry(entry)
    local next_items = {}
    for _, e in ipairs(pending) do if e ~= entry then next_items[#next_items + 1] = e end end
    local ok = replace_queue(next_items)
    if not ok then entry.settled = true; queue_paused_until = os.time() + RETRY_BASE_SEC end
    return ok
end
local function enqueue_track(track, manual)
    track.dest = track.dest or sidecar_path(track.path)
    if not destination_is_bounded(track.dest) then if manual then plugin.show_toast("Track path is not supported") end; return false end
    if queue_corrupt then if manual then plugin.show_toast("Pending lyrics queue could not be read") end; return false end
    local snap = snapshot_sidecar(track.dest)
    if snap.kind == "synced" then if manual then plugin.show_toast("Lyrics already present") end; return false end
    if snap.kind == "blocked" then if manual then plugin.show_toast("Could not read existing lyrics") end; return false end
    for _, entry in ipairs(pending) do
        if entry.dest == track.dest then
            if manual then
                local old_order, old_retry, old_attempts, old_manual, old_settled = entry.order, entry.retry_at, entry.attempts, entry.manual, entry.settled
                request_order = request_order + 1
                entry.order, entry.retry_at, entry.attempts, entry.manual, entry.settled = request_order, 0, 0, true, false
                if not persist_queue(pending) then
                    entry.order, entry.retry_at, entry.attempts, entry.manual, entry.settled = old_order, old_retry, old_attempts, old_manual, old_settled
                    plugin.show_toast("Could not update pending lyrics request")
                    return false
                end
                network_backoff_until, network_failures, next_drain_at = 0, 0, 0
                if in_flight and in_flight.entry == entry then
                    in_flight.manual_requested = true
                    show_progress(in_flight, in_flight.stage or "Looking up lyrics…", nil, true)
                end
            end
            return true
        end
    end
    if #pending >= QUEUE_MAX_ENTRIES then if manual then plugin.show_toast("Pending lyrics queue is full") end; return false end
    request_order = request_order + 1
    local duration = math.max(0, tonumber(track.duration) or 0)
    if duration > 3600 then duration = 0 end
    local e = valid_queue_entry({tostring(request_order), tostring(os.time()), "0",
        field_escape(track.path), field_escape(track.title), field_escape(track.artist),
        field_escape(track.album or ""), tostring(duration), "0", "0"})
    if not e then
        if manual then plugin.show_toast("Track tags or path are not supported") end
        return false
    end
    e.manual = manual
    local items = {}; for _, old in ipairs(pending) do items[#items + 1] = old end; items[#items + 1] = e
    if not replace_queue(items) then if manual then plugin.show_toast("Could not save pending lyrics request") end; return false end
    return true
end
local function queue_count() return #pending end
local function is_online()
    if plugin.has_capability("network.status") and type(plugin.network_status) == "function" then
        local ok, st = pcall(plugin.network_status)
        if ok and type(st) == "table" then return st.wifi_enabled ~= false and st.connected ~= false end
    end
    return true
end
local function retry_after_seconds(value)
    local seconds = tonumber(value)
    if seconds and seconds == seconds and seconds > 0 and seconds < math.huge then return math.min(seconds, 24 * 60 * 60) end
    if type(value) ~= "string" then return nil end
    local day, mon, year, hour, minute, second = value:match("%a+, (%d%d) (%a+) (%d%d%d%d) (%d%d):(%d%d):(%d%d) GMT")
    local months = {Jan=1,Feb=2,Mar=3,Apr=4,May=5,Jun=6,Jul=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12}
    if not day or not months[mon] then return nil end
    local ok, utc = pcall(os.time, {year=tonumber(year),month=months[mon],day=tonumber(day),hour=tonumber(hour),min=tonumber(minute),sec=tonumber(second),isdst=false})
    if not ok or type(utc) ~= "number" then return nil end
    local offset = os.difftime(os.time(os.date("!*t", utc)), utc)
    return math.min(24 * 60 * 60, math.max(0, utc - offset - os.time()))
end
local function retry_delay(entry, headers)
    local delay = math.min(3600, RETRY_BASE_SEC * 2 ^ math.min((entry.attempts or 1) - 1, 6))
    local ra = retry_after_seconds(header(headers, "Retry-After"))
    if ra and ra > 0 then delay = math.max(delay, ra) end
    return delay + math.random() * RETRY_JITTER_SEC
end
local function defer_entry(entry, headers, status)
    entry.attempts = math.min(30, (entry.attempts or 0) + 1)
    entry.retry_at = os.time() + retry_delay(entry, headers)
    entry.manual = false
    if status == 429 or retry_after_seconds(header(headers, "Retry-After")) then
        rate_limited_until = math.max(rate_limited_until, entry.retry_at)
        for _, other in ipairs(pending) do other.retry_at = math.max(other.retry_at, rate_limited_until) end
    end
    if not persist_queue(pending) then queue_paused_until = os.time() + RETRY_BASE_SEC end
    next_drain_at = os.time() + 1
end
local function job_track(entry)
    return { path=entry.path, title=entry.title, artist=entry.artist, album=entry.album, duration=entry.duration, dest=entry.dest }
end

local function clear_in_flight(job)
    if in_flight == job then in_flight = nil end
end

drain_queue = function()
    if queue_corrupt then return end
    if in_flight or os.time() < next_drain_at or os.time() < queue_paused_until or os.time() < rate_limited_until or os.time() < network_backoff_until then return end
    if not is_online() then return end
    for _, entry in ipairs(pending) do
        if entry.settled then
            local keep = {}; for _, other in ipairs(pending) do if not other.settled then keep[#keep + 1] = other end end
            if not replace_queue(keep) then queue_paused_until = os.time() + RETRY_BASE_SEC; return end
            break
        end
    end
    table.sort(pending, function(a,b) return a.order > b.order end)
    for _, entry in ipairs(pending) do
        if entry.retry_at <= os.time() then
            local track = job_track(entry)
            local snap = snapshot_sidecar(track.dest)
            if snap.kind == "synced" then
                remove_entry(entry)
                return
            elseif snap.kind == "blocked" then
                entry.retry_at = os.time() + RETRY_BASE_SEC
                if not persist_queue(pending) then queue_paused_until = entry.retry_at end
                return
            else
                start_http(track, entry)
                return
            end
        end
    end
end

local function queue_failure(job, headers, status, network_failure)
    local entry = job.entry
    if entry.manual then notify_job(job, "Lyrics request queued for retry") end
    close_progress(job)
    clear_in_flight(job)
    defer_entry(entry, headers, status)
    if network_failure then
        network_failures = math.min(7, network_failures + 1)
        network_backoff_until = os.time() + math.min(3600, RETRY_BASE_SEC * 2 ^ (network_failures - 1))
    end
end

start_http = function(track, entry)

    local snap = snapshot_sidecar(track.dest)
    if snap.kind == "synced" then
        remove_entry(entry)
        return false
    end
    if snap.kind == "blocked" then
        defer_entry(entry)
        return false
    end
    local url = build_url(track)
    if not url then defer_entry(entry); return false end
    generation = generation + 1
    local gen = generation
    local is_auto = not entry.manual
    local job = { path=track.path, dest=track.dest, is_auto=is_auto, entry=entry, manual_requested=entry.manual == true }
    job.gen, job.track, job.snapshot = gen, track, snap
    job.stage = "Looking up lyrics…"
    in_flight = job
    show_progress(job, job.stage, nil, false)
    local ok, handle = pcall(plugin.http_request, {
        url=url, method="GET", headers={ ["User-Agent"]=USER_AGENT }, verify_tls=true,
        max_response_bytes=MAX_LRC_BYTES, connect_timeout_ms=10000, read_timeout_ms=15000, total_timeout_ms=30000, redirect_limit=3,
    }, function(status, body, err, headers) finish_fetch(track, is_auto, gen, status, body, err, headers) end)
    if not ok or not handle then
        queue_failure(job, nil, nil, true)
        return false
    end
    return true
end

finish_fetch = function(track, is_auto, gen, status, body, err, headers)
    local job = in_flight
    if not job or job.gen ~= gen then return end
    local entry = job.entry
    local function terminal()
        clear_in_flight(job)
        remove_entry(entry); next_drain_at = os.time() + 1
    end
    local transient = err ~= nil or status == 429 or status == 408 or status == 425 or status == 401 or status == 403
        or (status and status >= 500 and status <= 599)
    if err == "response_too_large" then close_progress(job); notify_job(job, "Lyrics response was too large"); terminal(); return end
    if transient then queue_failure(job, headers, status, true); return end
    network_failures, network_backoff_until = 0, 0
    local snap = snapshot_sidecar(track.dest)
    if snap.kind == "blocked" then queue_failure(job); return end
    if not snapshot_still_valid(track.dest, job.snapshot) then
        if snap.kind == "synced" then close_progress(job); terminal()
        else queue_failure(job) end
        return
    end
    if status == 404 then close_progress(job); notify_job(job, "No synced lyrics found"); terminal(); return end
    if status ~= 200 or type(body) ~= "string" or #body > MAX_LRC_BYTES then
        close_progress(job); notify_job(job, "Lyrics fetch failed (HTTP " .. tostring(status) .. ")"); terminal(); return
    end
    local decoded, record = pcall(plugin.json_decode, body, { max_input_bytes=MAX_LRC_BYTES, max_nesting=8, max_entries=64 })
    if not decoded or not record then close_progress(job); notify_job(job, "Lyrics response was not JSON"); terminal(); return end
    local lrc, why = extract_synced(record)
    if not lrc then close_progress(job); notify_job(job, why == "instrumental" and "Track is instrumental" or "No synced lyrics in result"); terminal(); return end
    if not snapshot_still_valid(track.dest, job.snapshot) then close_progress(job); queue_failure(job); return end
    local ok, write_err = install_synced_lrc(track.dest, lrc, job.snapshot)
    close_progress(job)
    if ok then
        notify_job(job, "Saved lyrics")
        if plugin.get_current_track_path() == track.path then refresh_current_lyrics_display(track.path) end
        terminal()
    elseif write_err == "exists" then terminal()
    else queue_failure(job) end
end

local function fetch_current(is_auto)
    if not plugin.has_capability("network.http.async") or not plugin.has_capability("data.json") then
        if not is_auto then plugin.show_toast("This player cannot fetch lyrics") end; return
    end
    local track = current_local_track()
    if not track then notify("Play a local track with title and artist tags", is_auto); return end
    if not enqueue_track(track, not is_auto) then return end
    if not is_auto then
        for _, e in ipairs(pending) do if e.dest == track.dest then e.manual = true end end
        if not is_online() then plugin.show_toast("Lyrics request added to pending queue") end
    end
    drain_queue()
    if not is_auto then
        for _, entry in ipairs(pending) do
            if entry.dest == track.dest and (not in_flight or in_flight.entry ~= entry) then
                if not is_online() or os.time() < rate_limited_until or os.time() < network_backoff_until
                    or os.time() < queue_paused_until or entry.retry_at > os.time() then entry.manual = false end
            end
        end
    end
end

-- Keep entry identities: an in-flight response owns the same entry that
-- it must retire after completion, even if Retry is tapped meanwhile.
local function retry_pending()
    if queue_corrupt and not load_queue() then
        plugin.show_toast("Pending lyrics queue could not be read")
        return false
    end
    local previous = {}
    for i, entry in ipairs(pending) do
        previous[i] = entry.retry_at
        entry.retry_at = 0
    end
    if not persist_queue(pending) then
        for i, entry in ipairs(pending) do entry.retry_at = previous[i] end
        plugin.show_toast("Could not update pending queue")
        return false
    end
    next_drain_at, network_backoff_until, network_failures = 0, 0, 0
    drain_queue()
    return true
end

local function clear_pending()
    if not persist_queue({}) then return false end
    generation = generation + 1
    if in_flight then close_progress(in_flight); in_flight = nil end
    pending = {}; next_drain_at = 0; queue_paused_until = 0; queue_corrupt = false
    network_backoff_until, network_failures = 0, 0
    return true
end

plugin.on("track_started", function(_, _, _, _, provider)
    if state.auto and not (provider and provider ~= "") then fetch_current(true) end
end)

plugin.set_interval(1, function() drain_queue() end)
if plugin.has_capability("network.status") and type(plugin.network_status) == "function" then
    pcall(plugin.on, "network_changed", function(info)
        if type(info) == "table" and info.connected then
            network_backoff_until, network_failures = 0, 0
        end
        next_drain_at = 0
        drain_queue()
    end)
end
if not load_queue() then plugin.show_toast("Pending lyrics queue could not be read; check Lyrics Fetcher settings") end
drain_queue()

local function open_about()
    plugin.show_list("About Lyrics Fetcher", {
        "Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key.",
        "Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player.",
        "Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced.",
        "Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar.",
        "Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them.",
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
            type = "row",
            label = "Pending lyrics requests: " .. (queue_corrupt and "unavailable" or tostring(queue_count())),
            on_select = function()
                plugin.show_list("Pending lyrics", {
                    "Retry pending downloads", "Clear pending queue",
                }, function(index)
                    if index == 1 then
                        retry_pending()
                    elseif index == 2 then
                        plugin.show_list("Clear pending queue?", {"Keep queue", "Clear queue"}, function(choice)
                            if choice == 2 and not clear_pending() then
                                plugin.show_toast("Could not clear pending queue")
                            end
                        end)
                    end
                end)
            end,
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
-- Older firmware keeps Settings > Library until it supports player menu rows.
if plugin.has_capability("ui.player_menu") then
    plugin.register_list_item("player", "Lyrics Fetcher", function()
        fetch_current(false)
    end)
end

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        sidecar_path = sidecar_path,
        is_absolute_local_path = is_absolute_local_path,
        extract_synced = extract_synced,
        has_sync_line = has_sync_line,
        sidecar_kind = sidecar_kind,
        read_sidecar = read_sidecar,
        snapshot_sidecar = snapshot_sidecar,
        snapshot_allows_fetch = snapshot_allows_fetch,
        snapshot_still_valid = snapshot_still_valid,
        backup_path = backup_path,
        install_synced_lrc = install_synced_lrc,
        atomic_write_lrc = atomic_write_lrc,
        refresh_current_lyrics_display = refresh_current_lyrics_display,
        build_url = build_url,
        enqueue_track = enqueue_track,
        drain_queue = drain_queue,
        get_pending = function() return pending end,
        persist_queue = persist_queue,
        load_queue = load_queue,
        clear_pending = clear_pending,
        retry_pending = retry_pending,
        fetch_current = fetch_current,
        get_queue_state = function() return in_flight, nil end,
        state = state,
        BACKUP_SUFFIX = BACKUP_SUFFIX,
        TEMP_SUFFIX = TEMP_SUFFIX,
    }
end
