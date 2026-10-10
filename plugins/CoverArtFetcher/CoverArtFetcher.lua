plugin.define({
    id = "example.cover_art_fetcher",
    name = "Cover Art Fetcher",
    version = "1.1.3",
    api_min = 16,
})

-- Fills a missing album-title.jpg sidecar from MusicBrainz + Cover Art Archive.
-- Prefers the 500px JPEG front thumbnail. Never overwrites an existing
-- album-title.jpg. Embedded artwork is not exposed in the Lua API, so a folder
-- whose files already have pictures in tags may still get a sidecar.
-- A separate, confirmed repair renames shared generic cover/folder images
-- that hide the current album's art; it never runs automatically.

local USER_AGENT = "CompasPlayer-CoverArtFetcher/1.0 (https://github.com/Starnished66/compas-player)"
local STATE_PATH = plugin.sd_root() .. "/.plugins/.cover_art_fetcher_state"
local MB_INTERVAL = 1
local MAX_JSON = 262144
local MAX_IMAGE_BYTES = 2 * 1024 * 1024
local IMAGE_TOTAL_TIMEOUT_MS = 90000
local MAX_REDIRECTS = 5
local SONG_PAGE = 50
local MAX_LIBRARY_SCAN = 100000
local MAX_PATH = 4095
local MAX_FILENAME = 255 - #".jpg.compas-fetch" - #".part.XXXXXX"
local MAX_FAIL_KEYS = 40
local FAIL_COOLDOWN = 6 * 60 * 60
local MB_RESULT_LIMIT = 25
local JSON_LIMITS = { max_input_bytes = MAX_JSON, max_nesting = 16, max_entries = 8000 }
-- The native refresh accepts one start per plugin per minute and refuses
-- while library work runs. Saves inside that window share one retry.
local REFRESH_SPACING = 61
local REFRESH_BUSY_RETRY = 15
local REFRESH_MAX_ATTEMPTS = 40
-- Names the native lookup tries for generic folder art, in its order.
local GENERIC_NAMES = { "cover.jpeg", "cover.jpg", "cover.png", "cover.bmp", "folder.jpg", "folder.jpeg", "folder.png" }
local ALBUM_EXTS = { "jpeg", "jpg", "png", "bmp" }
local BACKUP_SUFFIX = ".compas-backup"
local MAX_BACKUP_SLOTS = 9
local REPAIR_MAX_IDENTITIES = 64
local REPAIR_DIRS_PER_IDENTITY = 4
local MAX_LIST_LABEL = 500

local state = { auto = false }
local mb_next_ok = 0
local queue = {}
local busy = false
local pending_dest = {}
local generation = 0
local fail_memory = {}
local last_auto_key = nil
local active_job = nil
local MANUAL_REFRESH_SECONDS = 25
local refresh = { pending = false, next_at = 0, attempts = 0 }

local function trim(s)
    return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function lower(s)
    return trim(s):lower()
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

local function lucene_escape(value)
    return (tostring(value):gsub("([%+%-&|!%(%)%{%}%[%]%^\"~%*:?\\/])", "\\%1"))
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

local function file_exists(path)
    if not path then return false end
    local f = io.open(path, "rb")
    if not f then return false end
    f:close()
    return true
end

local function file_size(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local size = f:seek("end")
    f:close()
    return size
end

local function album_dir(path)
    if not is_absolute_local_path(path) then return nil end
    local slash = path:match("^.*()/")
    if not slash or slash < 2 then return nil end
    return path:sub(1, slash - 1)
end

-- The player's own filename substitutions, applied to the raw tag exactly as
-- the native lookup does (no trimming).
local function native_album_name(album)
    if type(album) ~= "string" or album == "" then return nil end
    return (album:gsub('"', "'"):gsub('[%*/:<>?\\|]', "_"))
end

-- Takes the raw indexed album tag. The native lookup does not trim, so a tag
-- with outer spaces would get a sidecar it never opens; refuse it instead.
local function sanitized_album_name(album)
    if type(album) ~= "string" then return nil, "unsafe-name" end
    if album ~= trim(album) then return nil, "untrimmed-album" end
    local name = native_album_name(album)
    if not name then return nil, "unsafe-name" end
    local generic = lower(name)
    if name:find("[%c]") or generic:match("%.[0-9]+x[0-9]+$") then return nil, "unsafe-name" end
    if name == "." or name == ".." or #name > MAX_FILENAME
        or generic == "cover" or generic == "folder" or generic == "artist" then return nil, "unsafe-name" end
    return name
end

local function cover_path(dir, album)
    local name, reason = sanitized_album_name(album)
    if not dir or not name then return nil, reason or "unsafe-name" end
    local path = dir .. "/" .. name .. ".jpg"
    if #path + #".compas-fetch.part.XXXXXX" > MAX_PATH then return nil, "unsafe-name" end
    return path
end

local function album_key(artist, album, dir)
    return lower(artist) .. "\t" .. lower(album) .. "\t" .. tostring(dir or "")
end

local function failed_recently(key)
    local t = fail_memory[key]
    return t and (os.time() - t) < FAIL_COOLDOWN
end

local function remember_fail(key)
    fail_memory[key] = os.time()
    local n = 0
    for _ in pairs(fail_memory) do n = n + 1 end
    if n <= MAX_FAIL_KEYS then return end
    local oldest_k, oldest_t
    for k, t in pairs(fail_memory) do
        if not oldest_t or t < oldest_t then
            oldest_k, oldest_t = k, t
        end
    end
    if oldest_k then fail_memory[oldest_k] = nil end
end

local function notify(message, is_auto)
    if is_auto then return end
    plugin.show_toast(message)
end

-- Bounded decode; a malformed or oversized body is treated like no data.
-- Size and type are checked here too, not only by the request limit.
local function decode_json(body)
    if type(body) ~= "string" or body == "" or #body > MAX_JSON then return nil end
    local ok, value = pcall(plugin.json_decode, body, JSON_LIMITS)
    if not ok or type(value) ~= "table" then return nil end
    return value
end

-- One coalesced library refresh. The native call is rate limited and may be
-- busy; retry from the interval until it starts or the attempts run out.
local function try_refresh()
    if not refresh.pending or os.time() < refresh.next_at then return end
    refresh.attempts = refresh.attempts + 1
    local ok, started, reason = pcall(plugin.refresh_library)
    if ok and started ~= false then
        refresh.pending = false
        refresh.next_at = os.time() + REFRESH_SPACING
        return
    end
    if not ok or refresh.attempts >= REFRESH_MAX_ATTEMPTS
        or (reason ~= "rate_limited" and reason ~= "already_running") then
        refresh.pending = false
        return
    end
    refresh.next_at = os.time() + (reason == "rate_limited" and REFRESH_SPACING or REFRESH_BUSY_RETRY)
end

local function request_refresh()
    refresh.pending = true
    refresh.attempts = 0
    try_refresh()
end

local function progress_available()
    return plugin.has_capability("ui.progress")
end

local function open_job_progress(job, message, fraction)
    if not job or (job.is_auto and not job.manual_requested) or not progress_available() then return false end
    if job.progress_handle and plugin.update_progress(job.progress_handle, message, fraction) then
        return true
    end
    job.progress_handle = nil
    job.progress_attempted = true
    job.progress_handle = plugin.show_progress("Fetching cover art", message, fraction)
    return job.progress_handle ~= nil
end

local function update_job_progress(job, message, fraction)
    if not job or (job.is_auto and not job.manual_requested) or not progress_available() then return false end
    if job.progress_handle and plugin.update_progress(job.progress_handle, message, fraction) then
        return true
    end
    job.progress_handle = nil
    if not job.progress_attempted then
        job.progress_attempted = true
        job.progress_handle = plugin.show_progress("Fetching cover art", message, fraction)
        return job.progress_handle ~= nil
    end
    return false
end

local function close_job_progress(job)
    if job and job.progress_handle then
        plugin.close_progress(job.progress_handle)
        job.progress_handle = nil
    end
end

local function notify_job(job, message)
    if not job or (job.is_auto and not job.manual_requested) then return end
    plugin.show_toast(message)
end

local function set_stage(job, stage)
    if not job then return end
    job.stage = stage
    job.next_status_refresh = os.time() + MANUAL_REFRESH_SECONDS
    update_job_progress(job, stage, nil)
end

local function active_status(job)
    local stage = job and job.stage or "Cover fetch in progress"
    return "Cover fetch already in progress — " .. stage
end

local function artist_credit_name(release)
    local credit = release["artist-credit"]
    if type(credit) ~= "table" then return "" end
    local parts = {}
    for i = 1, #credit do
        local item = credit[i]
        if type(item) == "table" then
            local name = item.name
            if type(name) ~= "string" or name == "" then
                local artist = item.artist
                if type(artist) == "table" then name = artist.name end
            end
            parts[#parts + 1] = tostring(name or "")
            if type(item.joinphrase) == "string" then
                parts[#parts + 1] = item.joinphrase
            end
        end
    end
    return trim(table.concat(parts))
end

local function names_equal(a, b)
    return lower(a) ~= "" and lower(a) == lower(b)
end

-- Keep only releases whose title and artist credit match the tags. Shared
-- album titles by other artists are dropped rather than guessed.
local function is_mbid(id)
    return type(id) == "string" and #id == 36
        and id:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
end

-- The search is over release groups, so editions of one album collapse into
-- one row. Keep only groups whose title and artist credit match the tags.
-- Exactly one group must remain, and the reply must be the complete result
-- set: a truncated page could hide a second album with the same title.
local function pick_release_group(payload, artist, album, album_artist)
    if type(payload) ~= "table" or type(payload["release-groups"]) ~= "table" then return nil, "no-match" end
    local groups = payload["release-groups"]
    local count, offset = payload.count, payload.offset
    if type(count) ~= "number" or count ~= #groups then return nil, "incomplete" end
    if offset ~= nil and offset ~= 0 then return nil, "incomplete" end

    local want_artist = album_artist ~= "" and album_artist or artist
    local match_id, credit_seen
    for i = 1, #groups do
        local group = groups[i]
        if type(group) == "table" and names_equal(group.title, album) then
            local credit = artist_credit_name(group)
            if names_equal(credit, want_artist) or names_equal(credit, artist) then
                -- A matching row without a usable id is ambiguous, not skippable.
                if not is_mbid(group.id) then return nil, "no-match" end
                if match_id and group.id ~= match_id then return nil, "no-match" end
                if credit_seen and lower(credit) ~= credit_seen then return nil, "no-match" end
                match_id, credit_seen = group.id, lower(credit)
            end
        end
    end
    if not match_id then return nil, "no-match" end
    return match_id
end

-- Sized thumbnails only, never the unsized original in img.image. Numeric
-- keys come first; older images list only the documented aliases "large"
-- (500px) and "small" (250px), accepted only when the URL names that size.
local THUMBNAIL_KEYS = {
    { key = "500" }, { key = 500 }, { key = "250" }, { key = 250 },
    { key = "large", suffix = "%-500%.jpg$" }, { key = "small", suffix = "%-250%.jpg$" },
}

local function thumbnail_url(listing)
    if type(listing) ~= "table" or type(listing.images) ~= "table" then return nil end
    for i = 1, #listing.images do
        local img = listing.images[i]
        if type(img) == "table" and img.front == true and type(img.thumbnails) == "table" then
            for _, choice in ipairs(THUMBNAIL_KEYS) do
                local url = img.thumbnails[choice.key]
                if type(url) == "string" and url:match("^https?://") and url ~= img.image
                    and (not choice.suffix or url:match(choice.suffix)) then
                    return url
                end
            end
        end
    end
    return nil
end

local function to_https(url)
    if type(url) ~= "string" then return nil end
    if url:match("^http://") then
        return "https://" .. url:sub(8)
    end
    if url:match("^https://") then return url end
    return nil
end

local function resolve_reference(base, location)
    local ref = trim(location):gsub("#.*$", "")
    if ref == "" then return nil end
    if ref:match("^https://") then return ref end
    if ref:match("^http://") then return "https://" .. ref:sub(8) end
    if ref:match("^[%a][%w+.-]*:") then return nil end
    local scheme, host, path = tostring(base or ""):match("^(https)://([^/?#]+)([^?#]*)")
    if not scheme then
        local http_host, http_path
        http_host, http_path = tostring(base or ""):match("^http://([^/?#]+)([^?#]*)")
        if not http_host then return nil end
        scheme, host, path = "https", http_host, http_path
    end
    if ref:sub(1, 2) == "//" then
        return "https:" .. ref
    end
    if path == "" then path = "/" end
    if ref:sub(1, 1) == "/" then
        return scheme .. "://" .. host .. ref
    end
    local dir = path:match("^.*/") or "/"
    return scheme .. "://" .. host .. dir .. ref
end

local function is_redirect(status)
    return status == 301 or status == 302 or status == 303 or status == 307 or status == 308
end

local function http_json(url, redirect_limit, callback)
    return plugin.http_request({
        url = url,
        method = "GET",
        headers = {
            ["User-Agent"] = USER_AGENT,
            ["Accept"] = "application/json",
        },
        verify_tls = true,
        max_response_bytes = MAX_JSON,
        connect_timeout_ms = 10000,
        read_timeout_ms = 15000,
        total_timeout_ms = 30000,
        redirect_limit = redirect_limit or 5,
    }, callback)
end

local function path_is_under_root(path, root)
    if not is_absolute_local_path(path) or path:find("%z") or path:find("//", 1, true) then return false end
    root = tostring(root or ""):gsub("/+$", "")
    if root == "" or path:sub(1, #root + 1) ~= root .. "/" then return false end
    for component in path:gmatch("[^/]+") do
        if component == "." or component == ".." then return false end
    end
    return true
end

local function directories_overlap(a, b)
    if a == b or a:sub(1, #b + 1) == b .. "/" or b:sub(1, #a + 1) == a .. "/" then return true end
    -- Native artwork lookup also falls back between sibling disc folders.
    local function disc_parent(dir)
        local parent, name = dir:match("^(.*)/([^/]+)$")
        name = (name or ""):lower()
        if name:match("^cd[ _%.%-]*%d+$") or name:match("^disc[ _%.%-]*%d+$")
            or name:match("^disk[ _%.%-]*%d+$") then return parent end
    end
    local parent = disc_parent(a)
    return parent ~= nil and parent == disc_parent(b)
end

-- One bounded, paged pass over the indexed library; memory stays constant.
local function scan_library(visitor)
    local offset, expected_total = 0, nil
    while true do
        local songs, total = plugin.library_get_songs(offset, SONG_PAGE)
        if type(songs) ~= "table" or type(total) ~= "number" or total < 0 or total % 1 ~= 0 then
            return false, "scan-failed"
        end
        if total > MAX_LIBRARY_SCAN then return false, "scan-limit" end
        if expected_total and total ~= expected_total then return false, "scan-failed" end
        expected_total = total
        if #songs > math.min(SONG_PAGE, total - offset) then return false, "scan-failed" end
        if offset < total and (#songs == 0 or #songs < math.min(SONG_PAGE, total - offset)) then
            return false, "scan-failed"
        end
        if #songs == 0 then return true end
        for i = 1, #songs do
            if type(songs[i]) ~= "table" or type(songs[i].path) ~= "string" then
                return false, "scan-failed"
            end
            local keep_going, reason = visitor(songs[i])
            if keep_going == false then return false, reason end
        end
        offset = offset + #songs
        if offset >= total then return true end
        if offset >= MAX_LIBRARY_SCAN then return false, "scan-limit" end
    end
end

local function protected_scan(visitor)
    local ok, err = pcall(function()
        local complete, reason = scan_library(visitor)
        if not complete then error(reason, 0) end
    end)
    if ok then return true end
    return false, type(err) == "string" and err or "scan-failed"
end

-- Scan the whole indexed library so title filenames cannot shadow another
-- album's sidecar in this directory or an ancestor/child directory.
local function inspect_library(path, now_artist, now_album)
    local current_dir = album_dir(path)

    local found
    local ok, scan_err = protected_scan(function(song)
        if song.path == path then
            if found or type(song.album) ~= "string" or not names_equal(song.artist, now_artist)
                or not names_equal(song.album, now_album)
                or trim(song.artist) == "" or trim(song.album) == "" then
                return false, "metadata-mismatch"
            end
            found = { path = song.path, artist = trim(song.artist), album = trim(song.album),
                raw_album = song.album, album_artist = trim(song.album_artist or "") }
        end
    end)
    if not ok then return nil, scan_err end
    if not found then return nil, "not-indexed" end
    local current_name, name_err = sanitized_album_name(found.raw_album)
    if not current_name then return nil, name_err end

    local current_effective = trim(found.album_artist or "")
    if current_effective == "" then current_effective = trim(found.artist) end
    local conflict, track_conflict = false, false
    ok, scan_err = protected_scan(function(song)
        local song_dir = path_is_under_root(song.path, plugin.sd_root()) and album_dir(song.path) or nil
        if song_dir and directories_overlap(current_dir, song_dir) then
            local song_name = sanitized_album_name(song.album)
            local effective = trim(song.album_artist or "")
            if effective == "" then effective = trim(song.artist) end
            if song_name and lower(song_name) == lower(current_name)
                and (lower(effective) ~= lower(current_effective) or not names_equal(song.album, found.album)) then
                conflict = true
            end
            if song_dir == current_dir then
                local stem = tostring(song.path):match("([^/]+)%.[^%.]+$")
                if stem and lower(stem) == lower(current_name) then
                    local same_album = names_equal(song.album, found.album) and lower(effective) == lower(current_effective)
                    if not same_album then track_conflict = true end
                end
            end
        end
    end)
    if not ok then return nil, scan_err end
    if track_conflict then return nil, "track-name-collision" end
    if conflict then return nil, "title-collision" end
    return found
end

local function current_album()
    local path = plugin.get_current_track_path()
    if not path_is_under_root(path, plugin.sd_root()) then return nil end
    local _, artist, album = plugin.get_now_playing()
    artist, album = trim(artist), trim(album)
    if artist == "" or album == "" then return nil end
    local dir = album_dir(path)
    if not dir then return nil end
    local song, err = inspect_library(path, artist, album)
    if not song then return nil, err end
    if plugin.get_current_track_path() ~= path then return nil, "track-changed" end
    artist, album = trim(song.artist), trim(song.album)
    local album_artist = trim(song.album_artist or "")
    local dest, dest_err = cover_path(dir, song.raw_album)
    if not dest then return nil, dest_err end
    return {
        artist = artist,
        album = album,
        album_artist = album_artist,
        dir = dir,
        dest = dest,
        path = path,
        key = album_key(artist, album, dir),
    }
end

local pump_queue, run_job

local function finish_job(job, ok, message)
    pending_dest[job.dest] = nil
    busy = false
    if active_job == job then active_job = nil end
    close_job_progress(job)
    if ok then
        request_refresh()
        notify_job(job, "Saved " .. job.dest:match("([^/]+)$"))
    else
        if message == "no-art" or message == "no-match" or message == "incomplete" or message == "offline" then
            remember_fail(job.key)
        end
        if message == "no-match" then
            notify_job(job, "Could not match this album conservatively")
        elseif message == "incomplete" then
            notify_job(job, "Too many MusicBrainz matches to choose safely")
        elseif message == "no-art" then
            notify_job(job, "No cover art for this release")
        elseif message == "exists" then
            notify_job(job, job.dest:match("([^/]+)$") .. " already present")
        elseif message == "offline" then
            notify_job(job, "Cover fetch failed (network)")
        elseif message then
            notify_job(job, message)
        end
    end
    pump_queue()
end

local function promote_cover(job, staging, gen)
    if pending_dest[job.dest] ~= gen then
        os.remove(staging)
        return
    end
    if file_exists(job.dest) then
        os.remove(staging)
        finish_job(job, false, "exists")
        return
    end
    local f = io.open(staging, "rb")
    if not f then
        finish_job(job, false, "offline")
        return
    end
    local magic = f:read(3)
    f:close()
    local size = file_size(staging)
    if not size or size > MAX_IMAGE_BYTES then
        os.remove(staging)
        finish_job(job, false, "no-art")
        return
    end
    if not magic or magic:byte(1) ~= 0xFF or magic:byte(2) ~= 0xD8 then
        os.remove(staging)
        finish_job(job, false, "no-art")
        return
    end
    if not os.rename(staging, job.dest) then
        os.remove(staging)
        finish_job(job, false, "Could not save album sidecar")
        return
    end
    finish_job(job, true)
end

-- Writes the already size-capped response body to the staging file, then
-- hands it to the guarded promotion (magic, size, no-overwrite rename).
local function save_image(job, body, gen)
    if pending_dest[job.dest] ~= gen then return end
    if type(body) ~= "string" or body == "" or #body > MAX_IMAGE_BYTES then
        finish_job(job, false, "no-art")
        return
    end
    set_stage(job, "Saving cover…")
    local staging = job.dest .. ".compas-fetch"
    os.remove(staging)
    local f = io.open(staging, "wb")
    if not f then
        finish_job(job, false, "Could not save album sidecar")
        return
    end
    local wrote = f:write(body)
    local closed = f:close()
    if not wrote or not closed then
        os.remove(staging)
        finish_job(job, false, "Could not save album sidecar")
        return
    end
    promote_cover(job, staging, gen)
end

-- The thumbnail is fetched with an ordinary GET whose response the native
-- client caps at MAX_IMAGE_BYTES, so the transfer is bounded even without a
-- Content-Length and nothing needs cancelling. CAA answers with redirects to
-- archive.org; each hop is followed here, HTTPS only, at most MAX_REDIRECTS.
local function fetch_image(job, thumb_url, gen)
    set_stage(job, "Downloading cover…")
    local seen = {}
    local redirects = 0

    local function hop(url)
        if pending_dest[job.dest] ~= gen then return end
        url = to_https(url)
        if not url then
            finish_job(job, false, "no-art")
            return
        end
        if seen[url] then
            finish_job(job, false, "no-art")
            return
        end
        seen[url] = true

        local handle, err = plugin.http_request({
            url = url,
            method = "GET",
            headers = { ["User-Agent"] = USER_AGENT, ["Accept"] = "image/jpeg" },
            verify_tls = true,
            max_response_bytes = MAX_IMAGE_BYTES,
            connect_timeout_ms = 10000,
            read_timeout_ms = 15000,
            -- A 500px JPEG from archive.org can need more than 30 s on a slow
            -- link; the native ceiling for this field is five minutes.
            total_timeout_ms = IMAGE_TOTAL_TIMEOUT_MS,
            redirect_limit = 0,
        }, function(status, body, req_err, headers)
            if pending_dest[job.dest] ~= gen then return end
            if req_err then
                finish_job(job, false, req_err == "response_too_large" and "no-art" or "offline")
                return
            end
            if is_redirect(status) then
                if redirects >= MAX_REDIRECTS then
                    finish_job(job, false, "no-art")
                    return
                end
                redirects = redirects + 1
                local next_url = resolve_reference(url, header(headers, "Location"))
                if not next_url then
                    finish_job(job, false, "no-art")
                    return
                end
                hop(next_url)
                return
            end
            if status == 200 then
                save_image(job, body, gen)
                return
            end
            finish_job(job, false, "no-art")
        end)
        if not handle then
            finish_job(job, false, "offline")
        end
    end

    hop(thumb_url)
end

local function fetch_caa(job, group_id, gen)
    set_stage(job, "Checking Cover Art Archive…")
    -- The release-group listing shows the group's chosen front cover.
    local url = "https://coverartarchive.org/release-group/" .. group_id .. "/"
    local handle, err = http_json(url, 5, function(status, body, req_err)
        if pending_dest[job.dest] ~= gen then return end
        if req_err or status ~= 200 or type(body) ~= "string" then
            finish_job(job, false, (req_err and "offline") or "no-art")
            return
        end
        local listing = decode_json(body)
        local thumb = to_https(thumbnail_url(listing))
        if not thumb then
            finish_job(job, false, "no-art")
            return
        end
        fetch_image(job, thumb, gen)
    end)
    if not handle then
        finish_job(job, false, "offline")
    end
end

run_job = function(job)
    if file_exists(job.dest) then
        busy = false
        if active_job == job then active_job = nil end
        close_job_progress(job)
        notify_job(job, job.dest:match("([^/]+)$") .. " already present")
        pump_queue()
        return
    end
    generation = generation + 1
    local gen = generation
    active_job = job
    pending_dest[job.dest] = gen
    mb_next_ok = os.time() + MB_INTERVAL

    local artist_q = lucene_escape(job.album_artist ~= "" and job.album_artist or job.artist)
    local album_q = lucene_escape(job.album)
    local query = string.format('releasegroup:"%s" AND artist:"%s"', album_q, artist_q)
    local url = "https://musicbrainz.org/ws/2/release-group/?query=" .. url_encode(query)
        .. "&fmt=json&limit=" .. MB_RESULT_LIMIT .. "&offset=0"

    set_stage(job, "Looking up MusicBrainz…")
    local handle, err = http_json(url, 3, function(status, body, req_err)
        if pending_dest[job.dest] ~= gen then return end
        if not req_err and (status == 503 or status == 429) then
            -- Rate limited: transient, so not remembered as a failure.
            finish_job(job, false, "MusicBrainz is busy; try again later")
            return
        end
        if req_err or status ~= 200 or type(body) ~= "string" then
            finish_job(job, false, "offline")
            return
        end
        local payload = decode_json(body)
        local group_id, reason = pick_release_group(payload, job.artist, job.album, job.album_artist)
        if not group_id then
            finish_job(job, false, reason == "incomplete" and "incomplete" or "no-match")
            return
        end
        fetch_caa(job, group_id, gen)
    end)
    if not handle then
        finish_job(job, false, "offline")
    end
end

pump_queue = function()
    if busy then return end
    if #queue == 0 then return end
    if os.time() < mb_next_ok then return end
    local job = table.remove(queue, 1)
    if pending_dest[job.dest] then
        pump_queue()
        return
    end
    if file_exists(job.dest) then
        close_job_progress(job)
        notify_job(job, job.dest:match("([^/]+)$") .. " already present")
        pump_queue()
        return
    end
    busy = true
    active_job = job
    run_job(job)
end

local function enqueue(job)
    if not job or not job.dest then return end
    if file_exists(job.dest) then
        notify_job(job, job.dest:match("([^/]+)$") .. " already present")
        return
    end
    if failed_recently(job.key) and job.is_auto then return end
    if pending_dest[job.dest] then
        if not job.is_auto and active_job and active_job.dest == job.dest then
            local was_manual = active_job.manual_requested
            active_job.manual_requested = true
            if was_manual then
                open_job_progress(active_job, active_status(active_job), nil)
            else
                open_job_progress(active_job, active_job.stage or "Cover fetch in progress", nil)
            end
        end
        return
    end
    for _, queued in ipairs(queue) do
        if queued.dest == job.dest then
            if not job.is_auto then
                if queued.manual_requested then
                    local active_visible = false
                    if active_job and active_job.manual_requested and active_job.progress_handle then
                        active_visible = plugin.update_progress(
                            active_job.progress_handle, active_job.stage or "Cover fetch in progress", nil)
                        if not active_visible then active_job.progress_handle = nil end
                    end
                    if not active_visible then
                        open_job_progress(queued, queued.stage or "Cover fetch queued", nil)
                    end
                    plugin.show_toast("Cover fetch already queued")
                else
                    queued.manual_requested = true
                    set_stage(queued, "Cover fetch queued")
                end
            end
            return
        end
    end
    queue[#queue + 1] = job
    if not job.is_auto and (busy or os.time() < mb_next_ok) then
        job.stage = "Cover fetch queued"
        job.next_status_refresh = os.time() + MANUAL_REFRESH_SECONDS
        if not (active_job and active_job.manual_requested) then
            update_job_progress(job, job.stage, nil)
        else
            plugin.show_toast(job.stage)
        end
    end
    pump_queue()
end

local function fetch_current(is_auto)
    if not plugin.has_capability("network.http.async")
        or not plugin.has_capability("data.json") then
        if not is_auto then plugin.show_toast("This player cannot fetch cover art") end
        return
    end
    if is_auto then
        local path = plugin.get_current_track_path()
        local _, artist, album = plugin.get_now_playing()
        local quick_key = album_key(artist, album, album_dir(path))
        if last_auto_key == quick_key then return end
        last_auto_key = quick_key
    end
    local job, err = current_album()
    if not job then
        if err == "untrimmed-album" then
            notify("Album tag has leading or trailing spaces; cover not saved", is_auto)
        else
            notify("Could not identify this indexed album safely", is_auto)
        end
        return
    end
    job.is_auto = is_auto and true or false
    job.manual_requested = not job.is_auto
    enqueue(job)
end

-- ---- Shared generic artwork repair ----
-- The native lookup tries <album>.*, then cover.* and folder.* in the track's
-- folder, then the same names one folder up. Earlier releases of this plugin
-- wrote cover.jpg, which then showed for every album sharing that folder.
-- This repair only lists generic files that the current album would reach
-- before any album-specific file and that another indexed album also reaches.
-- Nothing changes until the user confirms; files are renamed, not deleted.

local function sd_root_dir()
    return (tostring(plugin.sd_root() or ""):gsub("/+$", ""))
end

local function parent_dir(dir)
    local parent = type(dir) == "string" and dir:match("^(.+)/[^/]+$") or nil
    if not parent or parent == "" then return nil end
    return parent
end

-- A folder whose generic art may be repaired: strictly below the SD root.
local function repair_folder_allowed(dir, root)
    return type(dir) == "string" and dir ~= root and path_is_under_root(dir, root)
end

local function regular_file(path)
    local f = io.open(path, "rb")
    if not f then return false end
    local _, err = f:read(0)
    f:close()
    return err == nil
end

local function album_sidecar_exists(dir, raw_album)
    local name = native_album_name(raw_album)
    if not name then return false end
    for _, ext in ipairs(ALBUM_EXTS) do
        if file_exists(dir .. "/" .. name .. "." .. ext) then return true end
    end
    return false
end

local function generic_files(dir)
    local found = {}
    for _, name in ipairs(GENERIC_NAMES) do
        local path = dir .. "/" .. name
        if regular_file(path) then found[#found + 1] = path end
    end
    return found
end

-- True when an album whose tracks sit in song_dir reaches folder's generic art.
local function reaches_generic(song_dir, raw_album, folder)
    if song_dir == folder then return not album_sidecar_exists(folder, raw_album) end
    if parent_dir(song_dir) ~= folder then return false end
    if album_sidecar_exists(song_dir, raw_album) or #generic_files(song_dir) > 0 then return false end
    return not album_sidecar_exists(folder, raw_album)
end

local function identity_of(song)
    local effective = song.album_artist
    if type(effective) ~= "string" or effective == "" then effective = song.artist end
    return string.lower(song.album) .. "\t" .. string.lower(tostring(effective or ""))
end

local function add_identity(set, key, raw_album, song_dir)
    local entry = set.identities[key]
    if not entry then
        if set.count >= REPAIR_MAX_IDENTITIES then return end
        entry = { raw_album = raw_album, dirs = {} }
        set.identities[key] = entry
        set.count = set.count + 1
    end
    if #entry.dirs >= REPAIR_DIRS_PER_IDENTITY then return end
    for _, d in ipairs(entry.dirs) do
        if d == song_dir then return end
    end
    entry.dirs[#entry.dirs + 1] = song_dir
end

local function shared_with_other_album(set, folder, current_key)
    for key, entry in pairs(set.identities) do
        if key ~= current_key then
            for _, d in ipairs(entry.dirs) do
                if reaches_generic(d, entry.raw_album, folder) then return true end
            end
        end
    end
    return false
end

local function backup_path(path)
    for slot = 1, MAX_BACKUP_SLOTS do
        local candidate = path .. BACKUP_SUFFIX .. (slot == 1 and "" or ("-" .. slot))
        if #candidate > MAX_PATH then return nil end
        if not file_exists(candidate) then return candidate end
    end
    return nil
end

-- Builds an immutable list of { path, backup } for the current track.
local function build_repair_plan()
    local root = sd_root_dir()
    local path = plugin.get_current_track_path()
    if not path_is_under_root(path, root) then return nil, "not-local" end
    local dir = album_dir(path)
    if not repair_folder_allowed(dir, root) then return nil, "root-folder" end
    local _, now_artist, now_album = plugin.get_now_playing()
    local parent = parent_dir(dir)
    if not repair_folder_allowed(parent, root) then parent = nil end

    local current
    local sets = { [dir] = { identities = {}, count = 0 } }
    if parent then sets[parent] = { identities = {}, count = 0 } end
    local ok, err = protected_scan(function(song)
        if type(song.album) ~= "string" or song.album == "" then return end
        if not path_is_under_root(song.path, root) then return end
        local song_dir = album_dir(song.path)
        if not song_dir then return end
        if song.path == path then
            if current or not names_equal(song.artist, now_artist) or not names_equal(song.album, now_album) then
                return false, "metadata-mismatch"
            end
            current = song
        end
        local key = identity_of(song)
        local up = parent_dir(song_dir)
        for folder, set in pairs(sets) do
            if song_dir == folder or up == folder then add_identity(set, key, song.album, song_dir) end
        end
    end)
    if not ok then return nil, err end
    if not current then return nil, "not-indexed" end
    if plugin.get_current_track_path() ~= path then return nil, "track-changed" end

    local current_key = identity_of(current)
    local plan = { track_path = path, files = {}, skipped = 0 }
    local folders = { dir }
    if parent then folders[2] = parent end
    for _, folder in ipairs(folders) do
        -- The album's own sidecar ends the native search before generic art.
        if album_sidecar_exists(folder, current.album) then break end
        local generics = generic_files(folder)
        if #generics > 0 then
            -- Generic art only this album reaches is its own; leave it.
            if not shared_with_other_album(sets[folder], folder, current_key) then break end
            -- An album titled "Cover" or "Folder" owns that file as its
            -- album-specific sidecar; never offer it.
            local owned = {}
            for _, entry in pairs(sets[folder].identities) do
                local name = native_album_name(entry.raw_album)
                if name then owned[name:lower()] = true end
            end
            for _, file in ipairs(generics) do
                local stem = file:match("([^/]+)%.[^%./]+$")
                local backup = backup_path(file)
                if owned[(stem or ""):lower()] then
                    plan.skipped = plan.skipped + 1
                elseif backup and #file <= MAX_LIST_LABEL then
                    plan.files[#plan.files + 1] = { path = file, backup = backup }
                else
                    plan.skipped = plan.skipped + 1
                end
            end
        end
    end
    return plan
end

local function apply_repair_plan(plan)
    if plan.applied then return 0, 0 end
    plan.applied = true
    local root = sd_root_dir()
    local renamed, failed = 0, 0
    for _, item in ipairs(plan.files) do
        local ok = path_is_under_root(item.path, root) and path_is_under_root(item.backup, root)
            and regular_file(item.path) and not file_exists(item.backup)
            and os.rename(item.path, item.backup)
        if ok and file_exists(item.backup) and not file_exists(item.path) then
            renamed = renamed + 1
        else
            failed = failed + 1
        end
    end
    if renamed > 0 then request_refresh() end
    return renamed, failed
end

local REPAIR_REASONS = {
    ["not-local"] = "Play a local track first",
    ["root-folder"] = "Tracks at the top of the card are not repaired",
    ["not-indexed"] = "Update the music database, then try again",
    ["metadata-mismatch"] = "Could not identify this indexed album safely",
    ["track-changed"] = "The track changed; try again",
    ["scan-limit"] = "Library is too large to check safely",
}

local function open_generic_repair()
    local plan, err = build_repair_plan()
    if not plan then
        plugin.show_toast(REPAIR_REASONS[err] or "Could not check folder artwork")
        return
    end
    if #plan.files == 0 then
        if plan.skipped > 0 then
            plugin.show_toast("Shared artwork found, but no safe backup name is free")
        else
            plugin.show_toast("No shared generic artwork affects this album")
        end
        return
    end
    local items = {}
    for _, item in ipairs(plan.files) do
        items[#items + 1] = { label = item.path, wrap = true }
    end
    local confirm_index = #items + 1
    local plural = #plan.files == 1 and "" or "s"
    items[confirm_index] = "Rename " .. #plan.files .. " file" .. plural .. " to " .. BACKUP_SUFFIX
    items[confirm_index + 1] = "Cancel"
    plugin.show_list("Shared folder artwork", items, function(index)
        if index == confirm_index then
            if plan.applied then return end
            local renamed, failed = apply_repair_plan(plan)
            if failed > 0 then
                plugin.show_toast("Renamed " .. renamed .. ", could not rename " .. failed)
            else
                plugin.show_toast("Renamed " .. renamed .. ". Use Reload cover if old artwork still shows")
            end
        elseif index == confirm_index + 1 and not plan.applied then
            plan.applied = true
            plugin.show_toast("No files changed")
        end
    end)
end

plugin.on("track_started", function(_, _, _, _, provider)
    if not state.auto then return end
    if provider and provider ~= "" then return end
    fetch_current(true)
end)

plugin.set_interval(1, function()
    local visible_job = active_job and active_job.manual_requested and active_job or nil
    if not visible_job then
        for _, queued in ipairs(queue) do
            if queued.manual_requested then
                visible_job = queued
                break
            end
        end
    end
    if visible_job and visible_job.stage
        and os.time() >= (visible_job.next_status_refresh or 0) then
        visible_job.next_status_refresh = os.time() + MANUAL_REFRESH_SECONDS
        update_job_progress(visible_job, visible_job.stage, nil)
    end
    try_refresh()
    if not busy then pump_queue() end
end)

local function open_about()
    plugin.show_list("About Cover Art Fetcher", {
        "Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track.",
        "Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists.",
        "The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar.",
        "A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm.",
        "Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second.",
    }, function() end)
end

local function open_settings()
    plugin.show_settings_list("Cover Art Fetcher", {
        {
            type = "row",
            label = "Fetch cover for current album",
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
            label = "Repair shared folder artwork",
            on_select = open_generic_repair,
        },
        {
            type = "row",
            label = "How it works",
            on_select = open_about,
        },
    })
end

load_state()
plugin.register_list_item("music_library", "Cover Art Fetcher", open_settings)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        pick_release_group = pick_release_group,
        thumbnail_url = thumbnail_url,
        to_https = to_https,
        resolve_reference = resolve_reference,
        fetch_image = fetch_image,
        album_dir = album_dir,
        cover_path = cover_path,
        current_album = current_album,
        is_absolute_local_path = is_absolute_local_path,
        fetch_current = fetch_current,
        enqueue = enqueue,
        pending_dest = pending_dest,
        queue = queue,
        fail_memory = fail_memory,
        remember_fail = remember_fail,
        failed_recently = failed_recently,
        state = state,
        promote_cover = promote_cover,
        open_generic_repair = open_generic_repair,
        build_repair_plan = build_repair_plan,
        refresh = refresh,
        MAX_IMAGE_BYTES = MAX_IMAGE_BYTES,
    }
end
