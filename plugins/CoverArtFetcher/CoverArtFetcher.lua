plugin.define({
    id = "example.cover_art_fetcher",
    name = "Cover Art Fetcher",
    version = "1.1.2",
    api_min = 16,
})

-- Fills a missing album-title.jpg sidecar from MusicBrainz + Cover Art Archive.
-- Prefers the 500px JPEG front thumbnail. Never overwrites an existing
-- album-title.jpg. Embedded artwork is not exposed in the Lua API, so a folder
-- whose files already have pictures in tags may still get a sidecar.

local USER_AGENT = "CompasPlayer-CoverArtFetcher/1.0 (https://github.com/Starnished66/compas-player)"
local STATE_PATH = plugin.sd_root() .. "/.plugins/.cover_art_fetcher_state"
local MB_INTERVAL = 1
local MAX_JSON = 262144
local MAX_IMAGE_BYTES = 2 * 1024 * 1024
local MAX_REDIRECTS = 5
local SONG_PAGE = 50
local MAX_LIBRARY_SCAN = 100000
local MAX_PATH = 4095
local MAX_FILENAME = 255 - #".jpg.compas-fetch" - #".part.XXXXXX"
local MAX_FAIL_KEYS = 40
local FAIL_COOLDOWN = 6 * 60 * 60

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

local function sanitized_album_name(album)
    local name = trim(album):gsub('"', "'"):gsub('[%*/:<>?\\|]', "_")
    local generic = lower(name)
    if name:find("[%c]") or generic:match("%.[0-9]+x[0-9]+$") then return nil end
    if name == "" or name == "." or name == ".." or #name > MAX_FILENAME
        or generic == "cover" or generic == "folder" or generic == "artist" then return nil end
    return name
end

local function cover_path(dir, album)
    local name = sanitized_album_name(album)
    if not dir or not name then return nil end
    local path = dir .. "/" .. name .. ".jpg"
    if #path + #".compas-fetch.part.XXXXXX" > MAX_PATH then return nil end
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
local function pick_release(payload, artist, album, album_artist)
    if type(payload) ~= "table" or type(payload.releases) ~= "table" then return nil end
    local want_artist = album_artist ~= "" and album_artist or artist
    local exact = {}
    for i = 1, #payload.releases do
        local rel = payload.releases[i]
        if type(rel) == "table" and type(rel.id) == "string" and names_equal(rel.title, album) then
            local credit = artist_credit_name(rel)
            if names_equal(credit, want_artist) or names_equal(credit, artist) then
                exact[#exact + 1] = rel
            end
        end
    end
    if #exact == 0 then return nil end

    local credits = {}
    for _, rel in ipairs(exact) do
        credits[lower(artist_credit_name(rel))] = true
    end
    local distinct = 0
    for _ in pairs(credits) do distinct = distinct + 1 end
    if distinct > 1 then return nil end

    local best, best_rank
    for _, rel in ipairs(exact) do
        local caa = rel["cover-art-archive"]
        local has_front = type(caa) == "table" and (caa.front == true or caa.front == "true")
        local official = lower(rel.status or "") == "official"
        local score = tonumber(rel.score) or 0
        local rank = (has_front and 1000 or 0) + (official and 100 or 0) + score
        if not best or rank > best_rank then
            best, best_rank = rel, rank
        end
    end
    if not best then return nil end
    if type(best["cover-art-archive"]) == "table" and best["cover-art-archive"].front == false
        and (tonumber(best["cover-art-archive"].count) or 0) == 0 then
        return nil
    end
    return best.id
end

local function thumbnail_url(listing)
    if type(listing) ~= "table" or type(listing.images) ~= "table" then return nil end
    for i = 1, #listing.images do
        local img = listing.images[i]
        if type(img) == "table" and img.front == true and type(img.thumbnails) == "table" then
            local url = img.thumbnails["500"] or img.thumbnails[500]
                or img.thumbnails["250"] or img.thumbnails[250]
            if type(url) == "string" and url:match("^https?://") then
                return url
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

local function parse_content_length(headers)
    local raw = header(headers, "Content-Length")
    if not raw then return nil end
    return tonumber((tostring(raw):match("%d+")))
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

-- Scan the whole indexed library so title filenames cannot shadow another
-- album's sidecar in this directory or an ancestor/child directory.
local function inspect_library(path, now_artist, now_album)
    local current_name = sanitized_album_name(now_album)
    if not current_name then return nil, "unsafe-name" end
    local current_dir = album_dir(path)

    -- Two bounded passes keep memory constant even for a large music library.
    local function scan(visitor)
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

    local found
    local ok, scan_err = pcall(function()
        local complete, reason = scan(function(song)
            if song.path == path then
                if found or not names_equal(song.artist, now_artist) or not names_equal(song.album, now_album)
                    or trim(song.artist) == "" or trim(song.album) == "" then
                    return false, "metadata-mismatch"
                end
                found = { path = song.path, artist = trim(song.artist), album = trim(song.album),
                    album_artist = trim(song.album_artist or "") }
            end
        end)
        if not complete then error(reason) end
    end)
    if not ok then return nil, scan_err end
    if not found then return nil, "not-indexed" end

    local current_effective = trim(found.album_artist or "")
    if current_effective == "" then current_effective = trim(found.artist) end
    local conflict, track_conflict = false, false
    ok, scan_err = pcall(function()
        local complete, reason = scan(function(song)
            local song_dir = type(song.path) == "string" and path_is_under_root(song.path, plugin.sd_root())
                and album_dir(song.path) or nil
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
        if not complete then error(reason) end
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
    local dest = cover_path(dir, album)
    if not dest then return nil, "unsafe-name" end
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
        plugin.refresh_library()
        notify_job(job, "Saved " .. job.dest:match("([^/]+)$"))
    else
        if message == "no-art" or message == "no-match" or message == "offline" then
            remember_fail(job.key)
        end
        if message == "no-match" then
            notify_job(job, "Could not match this album conservatively")
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

local function download_image(job, image_url, gen)
    set_stage(job, "Downloading and saving cover…")
    local staging = job.dest .. ".compas-fetch"
    os.remove(staging)
    pending_dest[job.dest] = gen
    local handle, err = plugin.download_file_async(image_url, staging, true, function(path, dl_err)
        if pending_dest[job.dest] ~= gen then
            if path then os.remove(path) end
            os.remove(staging)
            return
        end
        if dl_err or not path then
            os.remove(staging)
            finish_job(job, false, "offline")
            return
        end
        promote_cover(job, path, gen)
    end)
    job.download_handle = handle
    if not handle then
        os.remove(staging)
        finish_job(job, false, "offline")
        return
    end
end

local function resolve_and_download(job, thumb_url, gen)
    -- download_file_async does not follow redirects. CAA may 307, chain, or
    -- already point at a 200 archive.org thumbnail. Probe with HEAD only.
    set_stage(job, "Resolving cover image…")
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
            method = "HEAD",
            headers = { ["User-Agent"] = USER_AGENT },
            verify_tls = true,
            max_response_bytes = 1024,
            connect_timeout_ms = 10000,
            read_timeout_ms = 15000,
            total_timeout_ms = 30000,
            redirect_limit = 0,
        }, function(status, _, req_err, headers)
            if pending_dest[job.dest] ~= gen then return end
            if req_err then
                finish_job(job, false, "offline")
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
                local length = parse_content_length(headers)
                if length and length > MAX_IMAGE_BYTES then
                    finish_job(job, false, "no-art")
                    return
                end
                download_image(job, url, gen)
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

local function fetch_caa(job, mbid, gen)
    set_stage(job, "Checking Cover Art Archive…")
    local url = "https://coverartarchive.org/release/" .. mbid .. "/"
    local handle, err = http_json(url, 5, function(status, body, req_err)
        if pending_dest[job.dest] ~= gen then return end
        if req_err or status ~= 200 or type(body) ~= "string" then
            finish_job(job, false, (req_err and "offline") or "no-art")
            return
        end
        local listing = plugin.json_decode(body)
        local thumb = to_https(thumbnail_url(listing))
        if not thumb then
            finish_job(job, false, "no-art")
            return
        end
        resolve_and_download(job, thumb, gen)
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
    local query = string.format('release:"%s" AND artist:"%s"', album_q, artist_q)
    local url = "https://musicbrainz.org/ws/2/release/?query=" .. url_encode(query)
        .. "&fmt=json&limit=8"

    set_stage(job, "Looking up MusicBrainz…")
    local handle, err = http_json(url, 3, function(status, body, req_err)
        if pending_dest[job.dest] ~= gen then return end
        if req_err or status ~= 200 or type(body) ~= "string" then
            finish_job(job, false, "offline")
            return
        end
        local payload = plugin.json_decode(body)
        local mbid = pick_release(payload, job.artist, job.album, job.album_artist)
        if not mbid then
            finish_job(job, false, "no-match")
            return
        end
        fetch_caa(job, mbid, gen)
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
        or not plugin.has_capability("network.http.download")
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
    local job = current_album()
    if not job then
        notify("Could not identify this indexed album safely", is_auto)
        return
    end
    job.is_auto = is_auto and true or false
    job.manual_requested = not job.is_auto
    enqueue(job)
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
    local download_job = active_job
    if download_job and download_job.manual_requested and download_job.download_handle
        and plugin.has_capability("network.http.download_progress") then
        local progress = plugin.get_download_progress(download_job.download_handle)
        if type(progress) == "table" then
            local total = tonumber(progress.total) or 0
            local downloaded = tonumber(progress.downloaded) or 0
            local fraction = total > 0 and math.max(0, math.min(1, downloaded / total)) or nil
            update_job_progress(download_job, "Downloading and saving cover…", fraction)
        end
    end
    if not busy then pump_queue() end
end)

local function open_about()
    plugin.show_list("About Cover Art Fetcher", {
        "Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track.",
        "Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists.",
        "The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar.",
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
            label = "How it works",
            on_select = open_about,
        },
    })
end

load_state()
plugin.register_list_item("music_library", "Cover Art Fetcher", open_settings)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        pick_release = pick_release,
        thumbnail_url = thumbnail_url,
        to_https = to_https,
        resolve_reference = resolve_reference,
        resolve_and_download = resolve_and_download,
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
        MAX_IMAGE_BYTES = MAX_IMAGE_BYTES,
    }
end
