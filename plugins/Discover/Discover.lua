local PLUGIN_VERSION = "1.0.1"
local WISHLIST_FORMAT_VERSION = 1

plugin.define({
    id = "com.buymyhubs.discover",
    name = "Discover",
    version = PLUGIN_VERSION,
    api_min = 14
})

local REQUIRED_CAPS = {
    "ui.list", "ui.settings", "ui.settings_list_wrap",
    "library.paged", "network.http.async", "data.json",
    "storage.namespaced",
}

for _, cap in ipairs(REQUIRED_CAPS) do
    if not plugin.has_capability(cap) then
        return
    end
end

-- text helpers

local function trim(s)
    return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function normalize_name(s)
    if not s then return "" end
    s = s:lower()
    s = s:gsub("^the%s+", "")
    s = s:gsub("%sfeat%.?.*$", "")
    s = s:gsub("%sfeaturing.*$", "")
    s = s:gsub("%sft%.?%s.*$", "")
    s = s:gsub("[^%w%s]", "")
    s = s:gsub("%s+", " ")
    return trim(s)
end

-- drops trailing (...) and [...] groups
local function normalize_album_title(s)
    if not s then return "" end
    local prev
    repeat
        prev = s
        s = s:gsub("%s*%b()%s*$", "")
        s = s:gsub("%s*%b[]%s*$", "")
    until s == prev
    return normalize_name(s)
end

local function json_dump(value)
    local text, err = plugin.json_encode(value, { max_output_bytes = 262144 })
    if type(text) ~= "string" then return nil, err or "couldn't encode JSON" end
    return text
end

local function storage_json_set(key, value)
    local text, encode_err = json_dump(value)
    if not text then return false, encode_err end
    local ok, storage_err = plugin.storage.set(key, text)
    if not ok then return false, storage_err or "plugin storage is full or unavailable" end
    return true
end

local function json_load(text, default)
    if not text or text == "" then return default end
    local value, err = plugin.json_decode(text, { max_input_bytes = 524288 })
    if not value or (default ~= nil and type(value) ~= type(default)) then return default end
    return value
end

-- network helpers

-- no api for wifi state, so map connection errors to a readable message
local CONNECTION_ERRORS = {
    dns_failure = true, connect_failed = true, connect_timeout = true, timeout = true,
}

local function friendly_request_error(err)
    if CONNECTION_ERRORS[err] then
        return "No internet connection -- check Wi-Fi and try again"
    end
    return "Request failed (" .. tostring(err) .. ")"
end

-- slow requests get a toast so the ui doesn't look frozen
local function loading_toast(message)
    plugin.show_toast(message, 4000)
end

-- runs fn after a delay, or right away if no timer is available
local function delayed(seconds, fn)
    local handle
    local ok, result = pcall(plugin.set_interval, seconds, function()
        if handle then
            plugin.clear_interval(handle)
            handle = nil
        end
        fn()
    end)
    if ok then
        handle = result
    else
        fn()
    end
end

-- musicbrainz/listenbrainz return 503 when busy; retry only those, spaced out
local MAX_RETRIES = 3
local RETRY_DELAY_SECONDS = 2

local function request_with_retry(options, on_done, attempt)
    attempt = attempt or 0
    local handle, start_err = plugin.http_request(options, function(status, body, req_err, headers)
        if status == 503 and attempt < MAX_RETRIES then
            plugin.show_toast(("Discover: server busy, retrying (%d/%d)..."):format(attempt + 1, MAX_RETRIES), 3000)
            delayed(RETRY_DELAY_SECONDS, function()
                request_with_retry(options, on_done, attempt + 1)
            end)
            return
        end
        on_done(status, body, req_err, headers)
    end)
    if not handle then
        on_done(nil, nil, tostring(start_err), nil)
    end
end

local function friendly_status_error(status)
    if status == 503 then
        return "server is busy right now -- try again in a minute"
    end
    return "request failed (HTTP " .. tostring(status) .. ")"
end

-- options

local SECONDARY_TYPE_OPTIONS = {
    { key = "Live", label = "Include Live albums" },
    { key = "Demo", label = "Include Demos" },
    { key = "Mixtape/Street", label = "Include Mixtapes" },
    { key = "Compilation", label = "Include Compilations" },
    { key = "Soundtrack", label = "Include Soundtracks" },
    { key = "Remix", label = "Include Remixes" },
    { key = "DJ-mix", label = "Include DJ mixes" },
    { key = "Interview", label = "Include Interviews" },
    { key = "Spokenword", label = "Include Spoken word" },
    { key = "Audiobook", label = "Include Audiobooks" },
    { key = "Audio drama", label = "Include Audio dramas" },
    { key = "Field recording", label = "Include Field recordings" },
    { key = "Broadcast", label = "Include Broadcasts" },
}

local DEFAULT_SECONDARY_ON = {}

local OPTIONS_KEY = "options"

local function load_options()
    local saved = json_load(plugin.storage.get(OPTIONS_KEY), {})
    if type(saved) ~= "table" then saved = {} end
    local opts = {}
    for _, t in ipairs(SECONDARY_TYPE_OPTIONS) do
        if type(saved[t.key]) == "boolean" then
            opts[t.key] = saved[t.key]
        else
            opts[t.key] = DEFAULT_SECONDARY_ON[t.key] or false
        end
    end
    return opts
end

local function save_option(key, value)
    local saved = json_load(plugin.storage.get(OPTIONS_KEY), {})
    if type(saved) ~= "table" then saved = {} end
    saved[key] = value and true or false
    return storage_json_set(OPTIONS_KEY, saved)
end

local function release_types_allowed(secondary_types, opts)
    for _, t in ipairs(secondary_types or {}) do
        if opts[t] == false then return false end
    end
    return true
end

-- icons and artist filtering

local ICON_MENU = "Discover/discover.png"
local ICON_BLANK = "Discover/blank.png"
local ICON_OWNED = "Discover/owned.png"
local ICON_WISH = "Discover/wish.png"
local ICON_OWNED_WISH = "Discover/owned_wish.png"

-- Store assets live beside the plugin script, while UI icons resolve under
-- the theme root. Copy the bundled images into the plugin icon namespace at
-- load time so the paths used by list rows can resolve.
local function install_icon(name)
    pcall(plugin.set_icon, "Discover/" .. name, plugin.sd_root() .. "/.plugins/Discover/" .. name)
end

install_icon("discover.png")
install_icon("blank.png")
install_icon("owned.png")
install_icon("wish.png")
install_icon("owned_wish.png")

local function marker_icon(owned, wished)
    if owned and wished then return ICON_OWNED_WISH end
    if owned then return ICON_OWNED end
    if wished then return ICON_WISH end
    return ICON_BLANK
end

-- could become a table of excluded mbids/names if more artists are reported
local VARIOUS_ARTISTS_MBID = "89ad4ac3-39f7-470e-963a-56509c546377"
local VARIOUS_ARTISTS_NAMES = { ["various artists"] = true, ["various"] = true }

local function is_various_artists(artist_name, artist_mbids)
    for _, id in ipairs(artist_mbids or {}) do
        if id == VARIOUS_ARTISTS_MBID then return true end
    end
    return VARIOUS_ARTISTS_NAMES[normalize_name(artist_name)] == true
end

-- wish list storage
-- entries mean "want it" and are removed once owned; each caches its musicbrainz detail
-- plugin.storage is the primary copy, mirrored to <sd>/.plugins/Discover/wishlist.json
-- internal missing/unparseable: restore from sd. sd mtime newer than recorded: pull (merge if dirty)
-- mtime unreadable: push only. "newer" uses our recorded mtime, not the clock; older files are ignored
-- mirror is only touched while the card is mounted and not exported over usb

local MIRROR_FILE_NAME = "wishlist.json"
local USB_STORAGE_LUN_FILE = "/sys/kernel/config/usb_gadget/android0/functions/mass_storage.0/lun.0/file"

local function mirror_dir() return plugin.sd_root() .. "/.plugins/Discover" end
local function mirror_path() return mirror_dir() .. "/" .. MIRROR_FILE_NAME end

local function read_text_file(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local data = f:read("*a")
    f:close()
    return data
end

local function read_limited_text_file(path, max_bytes)
    local f = io.open(path, "rb")
    if not f then return nil end
    local data = f:read(max_bytes + 1)
    f:close()
    if not data or #data > max_bytes then return nil end
    return data
end

local function file_exists(path)
    local f = io.open(path, "rb")
    if f then
        f:close()
        return true
    end
    return false
end

-- compares the last two path parts since /data is a symlink and /proc/mounts shows the real path
local function sd_mounted()
    local mounts = read_text_file("/proc/mounts")
    if not mounts then return false end -- can't verify, so skip writes
    local root = plugin.sd_root()
    local tail = root:match("[^/]+/[^/]+$") or root
    for mount_point in mounts:gmatch("%S+%s+(%S+)%s") do
        if mount_point:sub(-#tail) == tail then return true end
    end
    return false
end

-- the host owns the card while it's exported as usb storage
local function usb_storage_active()
    local lun = read_text_file(USB_STORAGE_LUN_FILE)
    return lun ~= nil and trim(lun) ~= ""
end

local function mirror_writable()
    return sd_mounted() and not usb_storage_active()
end

local function valid_wishlist(value)
    if type(value) ~= "table" then return false end
    local count = #value
    for key in pairs(value) do
        if type(key) ~= "number" or key < 1 or key > count or key % 1 ~= 0 then return false end
    end
    if count > 1000 then return false end
    for _, e in ipairs(value) do
        if type(e) ~= "table" or type(e.id) ~= "string" or e.id == ""
            or type(e.artist) ~= "string" or e.artist == ""
            or type(e.album) ~= "string" or e.album == ""
            or #e.id > 2048 or #e.artist > 1024 or #e.album > 1024 then
            return false
        end
        if (e.added_at ~= nil and type(e.added_at) ~= "number")
            or (e.year ~= nil and type(e.year) ~= "string")
            or (e.release_group_mbid ~= nil and type(e.release_group_mbid) ~= "string")
            or (e.release_type ~= nil and type(e.release_type) ~= "string")
            or (e.source ~= nil and type(e.source) ~= "string")
            or (e.cached_info ~= nil and type(e.cached_info) ~= "table") then
            return false
        end
        if type(e.cached_info) == "table" then
            local info = e.cached_info
            if (info.disambiguation ~= nil and type(info.disambiguation) ~= "string")
                or (info.rating_value ~= nil and type(info.rating_value) ~= "number")
                or (info.rating_votes ~= nil and type(info.rating_votes) ~= "number")
                or (info.artist_mbid ~= nil and type(info.artist_mbid) ~= "string")
                or (info.genres ~= nil and type(info.genres) ~= "table") then
                return false
            end
            for _, genre in ipairs(info.genres or {}) do
                if type(genre) ~= "string" then return false end
            end
        end
    end
    return true
end

-- saved format: { version, plugin_version, saved_at, entries }; a bare array loads as version 0
-- returns entries, version; or nil + "unreadable" / "newer" (written by a newer format, left alone)
local function decode_wishlist_text(text)
    if not text or text == "" then return nil, "unreadable" end
    local value = plugin.json_decode(text, { max_input_bytes = 524288 })
    if type(value) ~= "table" then return nil, "unreadable" end

    local entries, version
    if value.entries ~= nil or value.version ~= nil then
        version = tonumber(value.version)
        if not version then return nil, "unreadable" end
        if version > WISHLIST_FORMAT_VERSION then return nil, "newer" end
        entries = value.entries or {}
    else
        entries, version = value, 0
    end

    if not valid_wishlist(entries) then return nil, "unreadable" end
    return entries, version
end

local function wishlist_envelope(list)
    return {
        version = WISHLIST_FORMAT_VERSION,
        plugin_version = PLUGIN_VERSION,
        saved_at = os.time(),
        entries = list,
    }
end

local function mirror_mtime()
    if not mirror_writable() then return nil end
    for _, e in ipairs(plugin.list_dir(mirror_dir()) or {}) do
        if e.name == MIRROR_FILE_NAME and not e.dir then return e.modified end
    end
    return nil
end

local function read_mirror()
    if not mirror_writable() then return nil, "SD card not available" end
    local text = read_limited_text_file(mirror_path(), 524288)
    if not text then return nil, "no SD copy found" end
    local list, why = decode_wishlist_text(text)
    if not list then
        if why == "newer" then return nil, "SD copy is from a newer Discover -- update the plugin" end
        return nil, "SD copy can't be read"
    end
    return list
end

local function record_mirror_mtime()
    local mt = mirror_mtime()
    if mt then
        plugin.storage.set("wishlist_mirror_mtime", tostring(mt))
    else
        plugin.storage.delete("wishlist_mirror_mtime")
    end
end

-- writes via temp file + rename, keeping the old one as .bak
local function write_mirror(list)
    if not mirror_writable() then return false, "SD card not available" end
    plugin.mkdir(mirror_dir())

    local path = mirror_path()
    local tmp, bak = path .. ".tmp", path .. ".bak"
    local f, open_err = io.open(tmp, "wb")
    if not f then return false, tostring(open_err) end

    local text, encode_err = json_dump(wishlist_envelope(list))
    if not text then
        f:close()
        os.remove(tmp)
        return false, encode_err
    end
    local wrote, write_err = f:write(text)
    local closed, close_err = f:close()
    if not wrote or not closed then
        os.remove(tmp)
        return false, tostring(write_err or close_err or "couldn't write the SD copy")
    end

    if file_exists(path) then
        os.remove(bak)
        os.rename(path, bak)
    end
    local renamed = os.rename(tmp, path)
    if not renamed then
        if file_exists(bak) and not file_exists(path) then os.rename(bak, path) end
        os.remove(tmp)
        return false, "couldn't finish the SD copy"
    end

    record_mirror_mtime()
    plugin.storage.set("wishlist_mirror_dirty", "0")
    return true
end

-- returns list, status (ok/missing/corrupt), raw text if corrupt, format version if ok
local function read_internal_wishlist()
    local raw = plugin.storage.get("wishlist")
    if raw == nil then return nil, "missing" end
    local list, version = decode_wishlist_text(raw)
    if list then return list, "ok", nil, version end
    return nil, "corrupt", raw
end

local function merge_wishlists(a, b)
    local out, seen = {}, {}
    for _, list in ipairs({ a, b }) do
        for _, e in ipairs(list) do
            if not seen[e.id] then
                seen[e.id] = true
                out[#out + 1] = e
            end
        end
    end
    return out
end

local function save_wishlist(list)
    if not valid_wishlist(list) then
        return false, "wish list is invalid or has reached its 1000-item limit"
    end
    local stored, storage_err = storage_json_set("wishlist", wishlist_envelope(list))
    if not stored then return false, storage_err end
    local mirrored = write_mirror(list)
    if not mirrored then plugin.storage.set("wishlist_mirror_dirty", "1") end
    return true
end

local function sync_wishlist_mirror()
    local internal, status, raw, internal_version = read_internal_wishlist()

    if status == "corrupt" then
        plugin.storage.set("wishlist_corrupt", raw) -- keep the bad data
        local mirrored = read_mirror()
        if mirrored then
            local stored = storage_json_set("wishlist", wishlist_envelope(mirrored))
            if not stored then return "restore_failed" end
            record_mirror_mtime()
            plugin.show_toast("Discover: wish list restored from your SD copy")
            return "restored_corrupt"
        end
        return "corrupt_no_mirror"
    end

    if status == "missing" then
        local mirrored = read_mirror()
        if mirrored then
            local stored = storage_json_set("wishlist", wishlist_envelope(mirrored))
            if not stored then return "restore_failed" end
            record_mirror_mtime()
            return "restored_missing"
        end
        return "nothing"
    end

    local upgraded = internal_version ~= WISHLIST_FORMAT_VERSION
    if upgraded then
        local stored = storage_json_set("wishlist", wishlist_envelope(internal))
        if not stored then return "upgrade_failed" end
    end

    if not mirror_writable() then return "sd_unavailable" end

    local dirty = plugin.storage.get("wishlist_mirror_dirty", "0") == "1"
    if not file_exists(mirror_path()) then
        write_mirror(internal)
        return "mirror_created"
    end

    local mt = mirror_mtime()
    if mt == nil then
        if dirty or upgraded then write_mirror(internal) end
        return "no_mtime"
    end

    local recorded = tonumber(plugin.storage.get("wishlist_mirror_mtime", ""))
    if recorded == nil then
        write_mirror(internal)
        return "adopted"
    end

    if mt > recorded then
        local mirrored, why = read_mirror()
        if not mirrored then
            if why and why:find("newer Discover") then plugin.show_toast("Discover: " .. why) end
            return "mirror_unreadable"
        end
        if dirty then
            local saved = save_wishlist(merge_wishlists(internal, mirrored))
            if not saved then return "merge_failed" end
            plugin.show_toast("Discover: wish list merged with your SD copy")
            return "merged"
        end
        local stored = storage_json_set("wishlist", wishlist_envelope(mirrored))
        if not stored then return "pull_failed" end
        record_mirror_mtime()
        plugin.show_toast(("Discover: wish list updated from SD copy (%d)"):format(#mirrored))
        return "pulled"
    end

    if dirty or upgraded then
        write_mirror(internal)
        return "pushed"
    end
    return "in_sync"
end

local function load_wishlist()
    local list, status = read_internal_wishlist()
    if status == "ok" then return list end

    sync_wishlist_mirror()
    list, status = read_internal_wishlist()
    if status == "ok" then return list end
    return {}
end

local function make_entry_id(artist, album, release_group_mbid)
    if release_group_mbid and release_group_mbid ~= "" then
        return "mbid:" .. release_group_mbid
    end
    return "na:" .. normalize_name(artist) .. "|" .. normalize_album_title(album)
end

local function find_wishlist_entry(id)
    for _, e in ipairs(load_wishlist()) do
        if e.id == id then return e end
    end
    return nil
end

local function is_on_wishlist(id)
    return find_wishlist_entry(id) ~= nil
end

-- newest first, ties keep stored order
local function wishlist_display_order(list)
    local indexed = {}
    for i, e in ipairs(list) do
        indexed[i] = { e = e, i = i }
    end

    table.sort(indexed, function(a, b)
        local ta, tb = a.e.added_at or 0, b.e.added_at or 0
        if ta ~= tb then return ta > tb end
        return a.i < b.i
    end)

    local out = {}
    for i, item in ipairs(indexed) do
        out[i] = item.e
    end
    return out
end

local function wishlist_checker()
    local ids = {}
    for _, e in ipairs(load_wishlist()) do
        ids[e.id] = true
    end
    return function(artist, title, mbid)
        if mbid and ids[make_entry_id(artist, title, mbid)] then return true end
        return ids[make_entry_id(artist, title, nil)] == true
    end
end

local function add_wishlist_entry(artist, album, year, release_group_mbid, release_type, source, cached_info)
    if #artist > 1024 or #album > 1024 then
        return nil, nil, "artist and album names must be 1024 bytes or fewer"
    end
    local id = make_entry_id(artist, album, release_group_mbid)
    if #id > 2048 then return nil, nil, "wish list ID is too long" end
    local wishlist = load_wishlist()
    if #wishlist >= 1000 then return nil, id, "wish list can contain up to 1000 items" end
    for _, e in ipairs(wishlist) do
        if e.id == id then return false, id end
    end

    table.insert(wishlist, 1, {
        id = id,
        artist = artist,
        album = album,
        year = year,
        release_group_mbid = release_group_mbid,
        release_type = release_type,
        source = source,
        added_at = os.time(),
        cached_info = cached_info,
    })
    local saved, err = save_wishlist(wishlist)
    if not saved then return nil, id, err end
    return true, id
end

local function remove_wishlist_entries(id_set)
    local wishlist = load_wishlist()
    local remaining, removed = {}, 0
    for _, e in ipairs(wishlist) do
        if id_set[e.id] then
            removed = removed + 1
        else
            table.insert(remaining, e)
        end
    end
    if removed > 0 then
        local saved, err = save_wishlist(remaining)
        if not saved then return 0, err end
    end
    return removed
end

local function remove_wishlist_entry(id)
    local removed, err = remove_wishlist_entries({ [id] = true })
    if err then return nil, err end
    return removed > 0
end

-- library lookups

-- normalized artist name -> name as spelled in the library
local function build_artist_index()
    local index = {}
    local offset = 0
    while true do
        local groups = plugin.library_get_artists(offset, 200)
        if not groups or #groups == 0 then break end
        for _, g in ipairs(groups) do
            local key = normalize_name(g.name)
            if key ~= "" and not index[key] then
                index[key] = g.name
            end
        end
        if #groups < 200 then break end
        offset = offset + 200
    end
    return index
end

local function build_owned_album_set(library_artist)
    local owned = {}
    if not library_artist then return owned end
    local offset = 0
    while true do
        local albums = plugin.library_get_albums(offset, 200, library_artist)
        if not albums or #albums == 0 then break end
        for _, a in ipairs(albums) do
            owned[normalize_album_title(a.name)] = true
        end
        if #albums < 200 then break end
        offset = offset + 200
    end
    return owned
end

-- returns fn(artist, title) -> owned; reads artists once and each artist's albums at most once
local function owned_checker()
    local index = build_artist_index()
    local cache = {}
    return function(artist, title)
        local library_artist = index[normalize_name(artist)]
        if not library_artist then return false end
        if not cache[library_artist] then
            cache[library_artist] = build_owned_album_set(library_artist)
        end
        return cache[library_artist][normalize_album_title(title)] == true
    end
end

-- auto check-off
-- exact matches are removed; loose matches wait in a possible-matches list for confirmation

local LAST_SONG_COUNT_KEY = "last_song_count"
local LAST_SCAN_AT_KEY = "last_scan_at"
local POSSIBLE_MATCHES_KEY = "possible_matches"
local SCAN_MAX_AGE_SECONDS = 24 * 3600

local function load_possible_matches()
    return json_load(plugin.storage.get(POSSIBLE_MATCHES_KEY), {})
end

local function save_possible_matches(list)
    return storage_json_set(POSSIBLE_MATCHES_KEY, list)
end

-- skipping or repeating a scan is harmless, matching is rederived each time
local scan_running = false

local function run_autocheck_scan()
    if scan_running then return end
    scan_running = true

    local wishlist = load_wishlist()
    if #wishlist == 0 then
        scan_running = false
        return
    end

    local artist_index = build_artist_index()
    local possible = load_possible_matches()
    local changed = false
    local to_remove, removed_count = {}, 0

    for _, entry in ipairs(wishlist) do
        local matched = false
        local norm_artist = normalize_name(entry.artist)
        local library_artist = artist_index[norm_artist]

        if library_artist then
            local owned = build_owned_album_set(library_artist)
            if owned[normalize_album_title(entry.album)] then
                matched = true
            end
        end

        if matched then
            to_remove[entry.id] = true
            removed_count = removed_count + 1
            changed = true
        else
            -- loose fallback: find songs by album title, then check the artist loosely
            local songs = plugin.library_get_songs(0, 20, { album = entry.album })
            if songs and #songs > 0 then
                local song_artist_norm = normalize_name(songs[1].artist)
                local loose = song_artist_norm ~= "" and norm_artist ~= "" and
                    (song_artist_norm:find(norm_artist, 1, true) or
                     norm_artist:find(song_artist_norm, 1, true))
                if loose then
                    local already = false
                    for _, p in ipairs(possible) do
                        if p.id == entry.id then
                            already = true
                            break
                        end
                    end
                    if not already then
                        table.insert(possible, entry)
                        changed = true
                    end
                end
            end
        end
    end

    if removed_count > 0 then
        local removed, remove_err = remove_wishlist_entries(to_remove)
        if remove_err then
            scan_running = false
            plugin.show_toast("Discover: couldn't save wish list (" .. tostring(remove_err) .. ")")
            return
        end
        removed_count = removed
    end

    if changed then
        local saved, save_err = save_possible_matches(possible)
        if not saved then
            scan_running = false
            plugin.show_toast("Discover: couldn't save match confirmations (" .. tostring(save_err) .. ")")
            return
        end
        if removed_count > 0 then
            plugin.show_toast(("Discover: removed %d item%s you already have"):format(
                removed_count, removed_count == 1 and "" or "s"))
        end
    end

    plugin.storage.set(LAST_SCAN_AT_KEY, tostring(os.time()))
    scan_running = false
end

local function maybe_run_autocheck()
    local last_count = tonumber(plugin.storage.get(LAST_SONG_COUNT_KEY, "-1")) or -1
    local current_count = plugin.library_song_count()
    local last_scan = tonumber(plugin.storage.get(LAST_SCAN_AT_KEY, "0")) or 0
    local age = os.time() - last_scan

    if current_count ~= last_count or age > SCAN_MAX_AGE_SECONDS then
        plugin.storage.set(LAST_SONG_COUNT_KEY, tostring(current_count))
        run_autocheck_scan()
    end
end

-- fresh releases feed: last FEED_PAST_DAYS and next FEED_FUTURE_DAYS, matched against library artists
-- the feed can't filter by artist and caps a window at 90 days, so windows are fetched one at a time
-- past windows are small to stay under the 2 mb response cap; oversized windows are split in half
-- only days since the last check are refetched, older matches are kept
-- scanning splits the body with plain string search and only decodes releases by library artists
-- falls back to a char-by-char scanner if the feed layout changes

local USER_AGENT = "Discover-CompasPlugin/" .. PLUGIN_VERSION .. " " ..
    "( https://github.com/Starnished66/compas-player )"

local FEED_BASE_URL = "https://api.listenbrainz.org/1/explore/fresh-releases/"
local FEED_PAST_DAYS = 90
local FEED_FUTURE_DAYS = 365
local FEED_API_MAX_DAYS = 90            -- api max window
local FEED_API_MIN_DAYS = 1             -- api min window (400 below it)
local FEED_PAST_WINDOW_DAYS = 10        -- days per past request, ~1.5 mb
local FEED_RESCAN_OVERLAP_DAYS = 3      -- recheck recent days for late additions
local FEED_MAX_RESPONSE_BYTES = 2097152
local FEED_MAX_AGE_SECONDS = 7 * 24 * 3600
local FEED_REQUEST_GAP_SECONDS = 1      -- gap between requests
local FEED_MAX_STORED_BYTES = 240000    -- storage values max out at 256 kb

-- scan slices are time-limited: the device is slow and a slice counts against the 2s lua budget
local TICK_TIME_BUDGET_SECONDS = 0.5    -- margin under the 2s limit
local TIME_CHECK_INTERVAL = 500         -- chars between clock checks (slow)
local OBJECTS_PER_TIME_CHECK = 50       -- releases between clock checks (fast)

local LAST_FEED_FETCH_KEY = "last_feed_fetch_at"
local FEED_COVERED_TO_KEY = "feed_covered_to"
local MATCHED_RELEASES_KEY = "matched_releases"
local LAST_SCAN_DIAGNOSTICS_KEY = "last_scan_diagnostics"

local function load_matched_releases()
    return json_load(plugin.storage.get(MATCHED_RELEASES_KEY), {})
end

-- dates are YYYY-MM-DD strings (sort as text); noon avoids dst date shifts
local function date_to_time(date_str)
    local y, m, d = tostring(date_str):match("^(%d%d%d%d)-(%d%d)-(%d%d)$")
    if not y then return nil end
    return os.time({ year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = 12 })
end

local function time_to_date(t)
    return os.date("%Y-%m-%d", t)
end

local function add_days(date_str, n)
    return time_to_date(date_to_time(date_str) + n * 86400)
end

local function days_between(a, b)
    return math.floor((date_to_time(b) - date_to_time(a)) / 86400 + 0.5)
end

-- past window covers date-days..date, future covers date..date+days (inclusive)
-- returns windows, rescan_from, earliest
local function plan_feed_windows(today, covered_to)
    local earliest = add_days(today, -FEED_PAST_DAYS)
    local rescan_from = earliest

    -- a future covered-to date means the clock was wrong (no battery-backed clock), so ignore it
    if covered_to and covered_to > today then covered_to = nil end
    if covered_to and covered_to > earliest then
        rescan_from = add_days(covered_to, -FEED_RESCAN_OVERLAP_DAYS)
        if rescan_from < earliest then rescan_from = earliest end
    end

    local windows = {}
    local end_date = today
    while end_date >= rescan_from do
        local span = math.min(FEED_PAST_WINDOW_DAYS, days_between(rescan_from, end_date) + 1)
        -- api refuses days=0, so a lone day is asked for as two and trimmed later
        local days = math.max(FEED_API_MIN_DAYS, span - 1)
        windows[#windows + 1] = { release_date = end_date, days = days, past = true, future = false }
        end_date = add_days(end_date, -span)
    end

    local last_future = add_days(today, FEED_FUTURE_DAYS)
    local start = today
    while start <= last_future do
        local days = math.max(FEED_API_MIN_DAYS, math.min(FEED_API_MAX_DAYS, days_between(start, last_future)))
        windows[#windows + 1] = { release_date = start, days = days, past = false, future = true }
        start = add_days(start, days + 1)
    end

    return windows, rescan_from, earliest
end

-- halves an oversized window; nil if a half would be under 2 days (days=0 is refused)
local function split_window(w)
    local n = w.days + 1
    if n < 4 then return nil end
    local n1 = math.ceil(n / 2)
    if w.past then
        return { release_date = w.release_date, days = n1 - 1, past = true, future = false },
               { release_date = add_days(w.release_date, -n1), days = n - n1 - 1, past = true, future = false }
    end
    return { release_date = w.release_date, days = n1 - 1, past = false, future = true },
           { release_date = add_days(w.release_date, n1), days = n - n1 - 1, past = false, future = true }
end

local function window_url(w)
    return ("%s?release_date=%s&days=%d&past=%s&future=%s&sort=release_date"):format(
        FEED_BASE_URL, w.release_date, w.days, tostring(w.past), tostring(w.future))
end

-- byte range of the releases array body; must stay a c-speed match, a lua char loop blew the 2s budget
local function find_releases_array_body(body)
    local _, bracket_pos = body:find('"releases"%s*:%s*%[')
    if not bracket_pos then return nil end
    local last_close = body:match(".*()%]")
    if not last_close or last_close <= bracket_pos then return nil end
    return bracket_pos + 1, last_close - 1
end

-- feed refresh state

local feed_job = nil -- current refresh, nil when idle
local feed_timer = nil
local run_next_feed_window -- forward decl

local function stop_feed_timer()
    if feed_timer then
        plugin.clear_interval(feed_timer)
        feed_timer = nil
    end
end

local function abort_feed_job(message)
    stop_feed_timer()
    feed_job = nil
    plugin.show_toast("Discover: " .. message)
end

local function finish_feed_job()
    local job = feed_job
    stop_feed_timer()
    feed_job = nil

    -- windows can overshoot the range by a day, so drop anything outside it
    local first_day = add_days(job.today, -FEED_PAST_DAYS)
    local last_day = add_days(job.today, FEED_FUTURE_DAYS)
    local function in_range(r)
        local d = r.release_date or ""
        return d >= first_day and d <= last_day
    end

    local combined = {}
    for _, r in ipairs(job.retained) do
        if in_range(r) then combined[#combined + 1] = r end
    end
    for _, r in ipairs(job.found) do
        if in_range(r) then combined[#combined + 1] = r end
    end
    table.sort(combined, function(a, b) return (a.release_date or "") < (b.release_date or "") end)

    -- stay under the storage limit by dropping the oldest first
    local text = json_dump(combined)
    while (not text or #text > FEED_MAX_STORED_BYTES) and #combined > 0 do
        for _ = 1, math.max(1, math.floor(#combined * 0.1)) do
            table.remove(combined, 1)
        end
        text = json_dump(combined)
    end

    if not text then
        plugin.show_toast("Discover: couldn't save the release feed")
        return
    end
    local saved, save_err = plugin.storage.set(MATCHED_RELEASES_KEY, text)
    if not saved then
        plugin.show_toast("Discover: couldn't save the release feed (" .. tostring(save_err) .. ")")
        return
    end
    plugin.storage.set(FEED_COVERED_TO_KEY, job.today)
    plugin.storage.set(LAST_FEED_FETCH_KEY, tostring(os.time()))

    -- diagnostics help explain a surprising "no matches"
    plugin.storage.set(LAST_SCAN_DIAGNOSTICS_KEY, json_dump({
        scanned = job.scanned,
        empty_windows = job.empty_windows,
        decode_failures = job.decode_failures,
        library_artist_count = job.library_artist_count,
        requests = job.requests,
    }))

    local upcoming = 0
    for _, r in ipairs(combined) do
        if (r.release_date or "") >= job.today then upcoming = upcoming + 1 end
    end
    plugin.show_toast(("Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"):format(
        #combined, upcoming), 6000)
end

-- reads the artist from raw text first so non-library releases are never decoded
local NAME_PATTERN = '^{"artist_credit_name":"([^"\\]*)"'

local function process_release_object(job, obj)
    job.scanned = job.scanned + 1

    local raw_name = obj:match(NAME_PATTERN)
    if raw_name and (not job.artist_index[normalize_name(raw_name)] or is_various_artists(raw_name, nil)) then
        return
    end

    local rel = plugin.json_decode(obj, { max_input_bytes = 65536 })
    if type(rel) ~= "table" then
        job.decode_failures = job.decode_failures + 1
        return
    end
    if type(rel.artist_credit_name) ~= "string" or type(rel.release_name) ~= "string"
        or type(rel.release_date) ~= "string"
        or (rel.artist_mbids ~= nil and type(rel.artist_mbids) ~= "table") then
        job.decode_failures = job.decode_failures + 1
        return
    end
    if not job.artist_index[normalize_name(rel.artist_credit_name)] then return end
    if is_various_artists(rel.artist_credit_name, rel.artist_mbids) then return end

    local key = rel.release_group_mbid or rel.release_mbid
    if key then
        if job.seen[key] then return end
        job.seen[key] = true
    end

    job.found[#job.found + 1] = {
        artist = rel.artist_credit_name,
        album = rel.release_name,
        release_date = rel.release_date,
        release_group_mbid = rel.release_group_mbid,
        release_group_primary_type = rel.release_group_primary_type,
        release_group_secondary_type = rel.release_group_secondary_type,
        artist_mbid = rel.artist_mbids and rel.artist_mbids[1],
    }
end

-- an empty window comes back as http 500 with this body, not an empty list
-- a bodyless 500 is only forgiven for future windows; a failing past window stops the run
local EMPTY_WINDOW_ERROR = "Server failed to get latest release"

local function is_empty_window_response(status, body, w)
    if status ~= 500 then return false end
    if type(body) == "string" and body:find(EMPTY_WINDOW_ERROR, 1, true) then return true end
    return w.future and (body == nil or body == "")
end

local function window_scan_done(job)
    job.scan = nil
    delayed(FEED_REQUEST_GAP_SECONDS, function()
        if feed_job == job then run_next_feed_window() end
    end)
end

local OBJECT_PREFIX = '{"artist_credit_name":'
local OBJECT_SEPARATOR = ',{"artist_credit_name":'

-- one time-limited slice of the current window
local function scan_tick()
    local job = feed_job
    if not job or not job.scan then return end

    local sc = job.scan
    local body, stop = sc.body, sc.stop
    local tick_start = os.clock()

    if sc.mode == "fast" then
        local done = 0
        while sc.pos <= stop do
            local sep = body:find(OBJECT_SEPARATOR, sc.pos + 1, true)
            local obj_end = sep and (sep - 1) or stop
            if obj_end > stop then obj_end = stop end

            process_release_object(job, body:sub(sc.pos, obj_end))
            sc.pos = sep and (sep + 1) or (stop + 1)

            done = done + 1
            if done % OBJECTS_PER_TIME_CHECK == 0 and os.clock() - tick_start > TICK_TIME_BUDGET_SECONDS then
                break
            end
        end
    else
        -- fallback: track string/brace state char by char
        local i, since_check = sc.pos, 0
        while i <= stop do
            since_check = since_check + 1
            if since_check >= TIME_CHECK_INTERVAL then
                since_check = 0
                if os.clock() - tick_start > TICK_TIME_BUDGET_SECONDS then break end
            end

            local c = body:sub(i, i)
            if sc.in_string then
                if sc.escape then
                    sc.escape = false
                elseif c == "\\" then
                    sc.escape = true
                elseif c == '"' then
                    sc.in_string = false
                end
            elseif c == '"' then
                sc.in_string = true
            elseif c == "{" then
                if sc.depth == 0 then sc.obj_start = i end
                sc.depth = sc.depth + 1
            elseif c == "}" then
                sc.depth = sc.depth - 1
                if sc.depth == 0 and sc.obj_start then
                    process_release_object(job, body:sub(sc.obj_start, i))
                    sc.obj_start = nil
                end
            end
            i = i + 1
        end
        sc.pos = i
    end

    if sc.pos > stop then window_scan_done(job) end
end

local function start_window_scan(job, body)
    local start_pos, stop_pos = find_releases_array_body(body)
    if not start_pos then
        abort_feed_job("couldn't read the releases feed")
        return
    end

    local first = (start_pos <= stop_pos) and body:find("{", start_pos, true) or nil
    if not first or first > stop_pos then
        window_scan_done(job) -- empty window
        return
    end

    local sc = { body = body, stop = stop_pos }
    if body:sub(first, first + #OBJECT_PREFIX - 1) == OBJECT_PREFIX then
        sc.mode, sc.pos = "fast", first
    else
        sc.mode, sc.pos = "slow", start_pos
        sc.depth, sc.in_string, sc.escape, sc.obj_start = 0, false, false, nil
    end
    job.scan = sc
end

run_next_feed_window = function()
    local job = feed_job
    if not job then return end

    job.index = job.index + 1
    local w = job.windows[job.index]
    if not w then
        finish_feed_job()
        return
    end

    loading_toast(("Discover: checking releases (%d of %d)..."):format(job.index, #job.windows))
    job.requests = job.requests + 1

    request_with_retry({
        url = window_url(w),
        headers = { ["User-Agent"] = USER_AGENT },
        max_response_bytes = FEED_MAX_RESPONSE_BYTES,
        connect_timeout_ms = 10000,
        read_timeout_ms = 20000,
        total_timeout_ms = 30000,
    }, function(status, body, req_err, headers)
        if feed_job ~= job then return end -- aborted meanwhile

        if req_err == "response_too_large" then
            local a, b = split_window(w)
            if a then
                table.remove(job.windows, job.index)
                table.insert(job.windows, job.index, a)
                table.insert(job.windows, job.index + 1, b)
                job.index = job.index - 1
                run_next_feed_window()
                return
            end
        end

        if req_err then
            abort_feed_job(friendly_request_error(req_err))
            return
        end

        if is_empty_window_response(status, body, w) then
            job.empty_windows = job.empty_windows + 1
            window_scan_done(job)
            return
        end

        if status ~= 200 then
            abort_feed_job(friendly_status_error(status))
            return
        end

        start_window_scan(job, body)
    end)
end

local function fetch_feed(force)
    if feed_job then
        plugin.show_toast("Discover: already checking for new releases")
        return
    end

    local last_fetch = tonumber(plugin.storage.get(LAST_FEED_FETCH_KEY, "0")) or 0
    if not force and os.time() - last_fetch < FEED_MAX_AGE_SECONDS then
        plugin.show_toast("Discover: already up to date this week")
        return
    end

    local today = time_to_date(os.time())
    local covered_to = plugin.storage.get(FEED_COVERED_TO_KEY)
    if covered_to and not date_to_time(covered_to) then covered_to = nil end
    local windows, rescan_from, earliest = plan_feed_windows(today, covered_to)

    local artist_index = build_artist_index()
    local library_artist_count = 0
    for _ in pairs(artist_index) do
        library_artist_count = library_artist_count + 1
    end

    -- matches older than the rescan span are kept as is
    local retained, seen = {}, {}
    for _, r in ipairs(load_matched_releases()) do
        local d = r.release_date or ""
        if d < rescan_from and d >= earliest then
            retained[#retained + 1] = r
            if r.release_group_mbid then seen[r.release_group_mbid] = true end
        end
    end

    -- set_interval throws when the global 8-timer cap is hit; guard it or the callback dies silently
    local ok, result = pcall(plugin.set_interval, 1, scan_tick)
    if not ok then
        plugin.show_toast("Discover: couldn't start scanning (" .. tostring(result) .. ")")
        return
    end
    feed_timer = result

    feed_job = {
        windows = windows, index = 0, requests = 0, found = {}, seen = seen, retained = retained,
        artist_index = artist_index, library_artist_count = library_artist_count,
        scanned = 0, decode_failures = 0, empty_windows = 0, today = today, rescan_from = rescan_from,
    }
    loading_toast(covered_to and "Discover: checking for new releases..."
        or ("Discover: checking for new releases (first run: %d requests, a few minutes)..."):format(#windows))
    run_next_feed_window()
end

-- musicbrainz lookups and pages
-- every request comes from an explicit user action, never keystrokes or background (1 req/sec etiquette)
-- artist and album search stay separate: release-group search scores on title only

local MB_MAX_RESPONSE_BYTES = 1048576 -- ~5 kb per result observed
local SIMILAR_ARTISTS_ALGORITHM = "session_based_days_9000_session_300_contribution_5_threshold_15_limit_50_skip_30"
local RELEASE_TYPES = { "Albums", "EPs", "Singles" }
local RELEASE_TYPE_QUERY = { Albums = "album", EPs = "ep", Singles = "single" }

local function url_encode(s)
    return (s:gsub("([^%w%-%.%_%~])", function(c)
        return ("%%%02X"):format(c:byte())
    end))
end

local function mb_request(url, callback)
    request_with_retry({
        url = url,
        headers = { ["User-Agent"] = USER_AGENT },
        max_response_bytes = MB_MAX_RESPONSE_BYTES,
        connect_timeout_ms = 10000,
        read_timeout_ms = 15000,
        total_timeout_ms = 20000,
    }, function(status, body, req_err, headers)
        if req_err then
            callback(nil, friendly_request_error(req_err))
            return
        end
        if status ~= 200 then
            callback(nil, friendly_status_error(status))
            return
        end

        local data = plugin.json_decode(body, { max_input_bytes = MB_MAX_RESPONSE_BYTES })
        if type(data) ~= "table" then
            callback(nil, "couldn't read the response")
            return
        end
        callback(data, nil)
    end)
end

-- genres come unsorted, so sort by vote count here
local function top_genres(genres, n)
    if type(genres) ~= "table" or #genres == 0 then return {} end

    local sorted = {}
    for _, g in ipairs(genres) do
        if type(g) == "table" and type(g.name) == "string" then
            table.insert(sorted, g)
        end
    end
    table.sort(sorted, function(a, b) return (a.count or 0) > (b.count or 0) end)

    local out = {}
    for i = 1, math.min(n or 3, #sorted) do
        out[i] = sorted[i].name
    end
    return out
end

local function year_of(date_str)
    if date_str and #date_str >= 4 then return date_str:sub(1, 4) end
    return nil
end

-- album page
-- opened live (fetches detail) or from a wish list entry's cached_info (no network)

-- defined further down
local show_artist_page
local open_artist_by_name

-- entry_id is the stored id when opened from a wish list entry, so hand-edited ids still work
local function render_album_page(artist, album, year, release_group_mbid, release_type, info, artist_mbid, entry_id)
    local id = entry_id or make_entry_id(artist, album, release_group_mbid)
    artist_mbid = artist_mbid or (info and info.artist_mbid)
    local on_wishlist = is_on_wishlist(id)

    local rows = {
        { type = "toggle", label = "On Wish List", value = on_wishlist, icon = ICON_WISH,
            on_change = function(checked)
                if checked then
                    local added, _, err = add_wishlist_entry(
                        artist, album, year, release_group_mbid, release_type, "album_page", info)
                    if added then
                        plugin.show_toast("Added to wish list")
                    elseif added == nil then
                        plugin.show_toast("Discover: couldn't save wish list (" .. tostring(err) .. ")")
                    end
                else
                    local removed, err = remove_wishlist_entry(id)
                    if err then
                        plugin.show_toast("Discover: couldn't save wish list (" .. tostring(err) .. ")")
                    else
                        plugin.show_toast("Removed from wish list")
                    end
                end
            end },
        { type = "row", label = "Artist: " .. artist, wrap = true,
            on_select = function()
                if artist_mbid then
                    show_artist_page(artist_mbid, artist)
                else
                    open_artist_by_name(artist)
                end
            end },
        { type = "row", label = "Type: " .. (release_type or "?"), on_select = function() end },
    }

    if owned_checker()(artist, album) then
        table.insert(rows, 2, { type = "row", label = "In your library", icon = ICON_OWNED,
            on_select = function() end })
    end
    if year then
        rows[#rows + 1] = { type = "row", label = "Released: " .. year, on_select = function() end }
    end
    if info and info.disambiguation and info.disambiguation ~= "" then
        rows[#rows + 1] = { type = "row", label = info.disambiguation, wrap = true, on_select = function() end }
    end
    if info and info.rating_value then
        rows[#rows + 1] = { type = "row",
            label = ("Rating: %.1f (%d votes)"):format(info.rating_value, info.rating_votes or 0),
            on_select = function() end }
    end
    if info and info.genres and #info.genres > 0 then
        rows[#rows + 1] = { type = "row", label = "Genres: " .. table.concat(info.genres, ", "),
            wrap = true, on_select = function() end }
    end

    plugin.show_settings_list(album, rows)
end

-- fetches fresh release-group detail, for anything not on the wish list
local function show_album_page_live(artist, album, release_group_mbid, release_type, year, artist_mbid)
    if not release_group_mbid then
        render_album_page(artist, album, year, nil, release_type, nil, artist_mbid)
        return
    end

    local url = ("https://musicbrainz.org/ws/2/release-group/%s?fmt=json&inc=genres+ratings+artist-credits")
        :format(url_encode(release_group_mbid))
    loading_toast("Discover: loading " .. album .. "...")

    mb_request(url, function(data, err)
        local info = nil
        if data then
            info = {
                disambiguation = data.disambiguation,
                rating_value = data.rating and data.rating.value,
                rating_votes = data.rating and data.rating["votes-count"],
                genres = top_genres(data.genres, 3),
                artist_mbid = (data["artist-credit"] and data["artist-credit"][1]
                    and data["artist-credit"][1].artist and data["artist-credit"][1].artist.id)
                    or artist_mbid,
            }
        elseif err then
            plugin.show_toast("Discover: " .. err .. " (showing basic info)")
        end
        render_album_page(artist, album, year, release_group_mbid, release_type, info, artist_mbid)
    end)
end

-- renders from cached_info, no network
local function show_album_page_cached(entry)
    render_album_page(entry.artist, entry.album, entry.year, entry.release_group_mbid,
        entry.release_type, entry.cached_info, nil, entry.id)
end

-- artist page

-- musicbrainz caps pages at 100, so page up to a limit; if a later page fails, show what loaded
local MAX_BROWSE_RELEASES = 300
local BROWSE_PAGE_SIZE = 100
local BROWSE_PAGE_DELAY_SECONDS = 1.2

local function fetch_release_groups(artist_mbid, type_query, on_done)
    local all, seen = {}, {}

    local function fetch_page(offset)
        local url = ("https://musicbrainz.org/ws/2/release-group?artist=%s&fmt=json&limit=%d&offset=%d&type=%s")
            :format(url_encode(artist_mbid), BROWSE_PAGE_SIZE, offset, type_query)

        mb_request(url, function(data, err)
            if err then
                if #all > 0 then on_done(all, nil) else on_done(nil, err) end
                return
            end

            local groups = type(data["release-groups"]) == "table" and data["release-groups"] or {}
            for _, rg in ipairs(groups) do
                if type(rg) == "table" and type(rg.id) == "string" and not seen[rg.id] then
                    seen[rg.id] = true
                    all[#all + 1] = rg
                end
            end

            local next_offset = offset + #groups
            local total = data["release-group-count"] or next_offset
            if #groups > 0 and next_offset < total and next_offset < MAX_BROWSE_RELEASES then
                delayed(BROWSE_PAGE_DELAY_SECONDS, function() fetch_page(next_offset) end)
            else
                on_done(all, nil)
            end
        end)
    end

    fetch_page(0)
end

local function release_label(rg)
    local y = year_of(rg["first-release-date"]) or "?"
    local label = ("%s (%s)"):format(rg.title or "?", y)
    local secondary = rg["secondary-types"]
    if secondary and #secondary > 0 then
        label = label .. " [" .. table.concat(secondary, ", ") .. "]"
    end
    return label
end

local function show_release_type_list(artist_mbid, artist_name, type_label)
    local type_query = RELEASE_TYPE_QUERY[type_label]
    loading_toast(("Discover: loading %s by %s..."):format(type_label:lower(), artist_name))

    fetch_release_groups(artist_mbid, type_query, function(groups, err)
        if err then
            plugin.show_toast("Discover: " .. err)
            return
        end

        local opts = load_options()
        local releases = {}
        for _, rg in ipairs(groups) do
            if release_types_allowed(rg["secondary-types"], opts) then
                table.insert(releases, rg)
            end
        end

        if #releases == 0 then
            if #groups > 0 then
                plugin.show_toast(("Discover: %d %s hidden by your Options"):format(#groups, type_label:lower()))
            else
                plugin.show_toast(("Discover: no %s found for %s"):format(type_label:lower(), artist_name))
            end
            return
        end

        table.sort(releases, function(a, b)
            return (a["first-release-date"] or "0000") > (b["first-release-date"] or "0000")
        end)

        local is_owned = owned_checker()
        local is_wished = wishlist_checker()

        local labels = {}
        for i, rg in ipairs(releases) do
            if i > 500 then break end
            labels[i] = {
                label = release_label(rg), wrap = true,
                icon = marker_icon(is_owned(artist_name, rg.title or ""),
                                   is_wished(artist_name, rg.title or "", rg.id)),
            }
        end

        plugin.show_list(artist_name .. " - " .. type_label, labels, function(index)
            local rg = releases[index]
            if not rg then return end
            show_album_page_live(artist_name, rg.title or "?", rg.id,
                rg["primary-type"] or type_label:sub(1, -2), year_of(rg["first-release-date"]), artist_mbid)
        end)
    end)
end

local function show_similar_artists(seed_mbid, seed_name)
    local url = ("https://labs.api.listenbrainz.org/similar-artists/json?artist_mbids=%s&algorithm=%s")
        :format(url_encode(seed_mbid), SIMILAR_ARTISTS_ALGORITHM)
    loading_toast("Discover: finding artists similar to " .. seed_name .. "...")

    request_with_retry({
        url = url,
        headers = { ["User-Agent"] = USER_AGENT },
        max_response_bytes = MB_MAX_RESPONSE_BYTES,
        connect_timeout_ms = 10000,
        read_timeout_ms = 15000,
        total_timeout_ms = 20000,
    }, function(status, body, req_err, headers)
        if req_err then
            plugin.show_toast("Discover: " .. friendly_request_error(req_err))
            return
        end
        if status ~= 200 then
            plugin.show_toast("Discover: " .. friendly_status_error(status))
            return
        end

        local similar = plugin.json_decode(body, { max_input_bytes = MB_MAX_RESPONSE_BYTES })
        if type(similar) ~= "table" or #similar == 0 then
            plugin.show_toast("Discover: no recommendations found for " .. seed_name)
            return
        end

        local labels = {}
        for i, a in ipairs(similar) do
            if i > 50 then break end
            if type(a) == "table" and type(a.name) == "string" then
                local comment = type(a.comment) == "string" and a.comment or nil
                labels[#labels + 1] = { label = (comment and comment ~= "") and
                    (a.name .. " (" .. comment .. ")") or a.name, wrap = true }
            end
        end

        plugin.show_list("Similar to " .. seed_name, labels, function(index)
            local a = similar[index]
            if not a then return end
            show_artist_page(a.artist_mbid, a.name)
        end)
    end)
end

show_artist_page = function(artist_mbid, artist_name)
    local url = ("https://musicbrainz.org/ws/2/artist/%s?fmt=json&inc=genres+ratings")
        :format(url_encode(artist_mbid))
    loading_toast("Discover: loading " .. artist_name .. "...")

    mb_request(url, function(data, err)
        local rows = {}

        if data then
            local pieces = {}
            if data.type and data.type ~= "" then table.insert(pieces, data.type) end
            if data.country and data.country ~= "" then table.insert(pieces, data.country) end

            local life = data["life-span"]
            if life and life.begin then
                local span = life.begin
                if life.ended and life["end"] then
                    span = span .. "-" .. life["end"]
                elseif not life.ended then
                    span = span .. "-present"
                end
                table.insert(pieces, span)
            end

            if #pieces > 0 then
                rows[#rows + 1] = { type = "row", label = table.concat(pieces, " | "), wrap = true,
                    on_select = function() end }
            end
            if data.disambiguation and data.disambiguation ~= "" then
                rows[#rows + 1] = { type = "row", label = data.disambiguation, wrap = true,
                    on_select = function() end }
            end
            if data.rating and data.rating.value then
                rows[#rows + 1] = { type = "row",
                    label = ("Rating: %.1f (%d votes)"):format(data.rating.value, data.rating["votes-count"] or 0),
                    on_select = function() end }
            end

            local genres = top_genres(data.genres, 3)
            if #genres > 0 then
                rows[#rows + 1] = { type = "row", label = "Genres: " .. table.concat(genres, ", "),
                    wrap = true, on_select = function() end }
            end
        elseif err then
            rows[#rows + 1] = { type = "row", label = err, wrap = true, on_select = function() end }
        end

        for _, type_label in ipairs(RELEASE_TYPES) do
            rows[#rows + 1] = { type = "row", label = type_label,
                on_select = function() show_release_type_list(artist_mbid, artist_name, type_label) end }
        end

        rows[#rows + 1] = { type = "row", label = "Find Similar Artists",
            on_select = function() show_similar_artists(artist_mbid, artist_name) end }

        plugin.show_settings_list(artist_name, rows)
    end)
end

local function resolve_artist_mbid(name, callback)
    if #name > 512 then
        callback(nil, "artist name is too long to search")
        return
    end
    local url = "https://musicbrainz.org/ws/2/artist/?fmt=json&limit=1&query=" .. url_encode(name)
    mb_request(url, function(data, err)
        if err then
            callback(nil, err)
            return
        end

        local artists = data["artists"]
        if type(artists) ~= "table" or type(artists[1]) ~= "table" or type(artists[1].id) ~= "string"
            or type(artists[1].name) ~= "string" then
            callback(nil, "couldn't identify \"" .. name .. "\" on MusicBrainz")
            return
        end
        callback(artists[1], nil)
    end)
end

-- opens an artist page from just a name: one search, top hit
open_artist_by_name = function(name)
    loading_toast("Discover: looking up " .. name .. "...")
    resolve_artist_mbid(name, function(artist, err)
        if err then
            plugin.show_toast("Discover: " .. err)
            return
        end
        show_artist_page(artist.id, artist.name)
    end)
end

-- search and browse screens

local function search_artist(query)
    query = trim(query)
    if query == "" then return end
    if #query > 512 then
        plugin.show_toast("Discover: search text must be 512 bytes or fewer")
        return
    end

    local url = "https://musicbrainz.org/ws/2/artist/?fmt=json&limit=15&query=" .. url_encode(query)
    loading_toast("Discover: searching artists...")

    mb_request(url, function(data, err)
        if err then
            plugin.show_toast("Discover: " .. err)
            return
        end

        local artists = data["artists"]
        if type(artists) ~= "table" or #artists == 0 then
            plugin.show_toast("Discover: no artists found for \"" .. query .. "\"")
            return
        end

        local labels = {}
        for i, a in ipairs(artists) do
            if type(a) == "table" and type(a.name) == "string" then
                local disambig = type(a.disambiguation) == "string" and a.disambiguation or nil
                labels[#labels + 1] = { label = (disambig and disambig ~= "") and
                    (a.name .. " (" .. disambig .. ")") or a.name, wrap = true }
            end
        end

        plugin.show_list("Artist Results", labels, function(index)
            local a = artists[index]
            if not a then return end
            show_artist_page(a.id, a.name)
        end)
    end)
end

local function format_album_search_result_label(rg)
    local artist = (rg["artist-credit"] and rg["artist-credit"][1] and rg["artist-credit"][1].name) or "?"
    local year = year_of(rg["first-release-date"])
    local kind = rg["primary-type"] or ""
    if year then
        return ("%s - %s (%s) [%s]"):format(artist, rg.title or "?", year, kind)
    end
    return ("%s - %s [%s]"):format(artist, rg.title or "?", kind)
end

local function search_album(query)
    query = trim(query)
    if query == "" then return end
    if #query > 512 then
        plugin.show_toast("Discover: search text must be 512 bytes or fewer")
        return
    end

    local url = "https://musicbrainz.org/ws/2/release-group/?fmt=json&limit=15&query=" .. url_encode(query)
    loading_toast("Discover: searching albums...")

    mb_request(url, function(data, err)
        if err then
            plugin.show_toast("Discover: " .. err)
            return
        end

        local groups = data["release-groups"]
        if type(groups) ~= "table" or #groups == 0 then
            plugin.show_toast("Discover: no albums found for \"" .. query .. "\"")
            return
        end

        local is_owned = owned_checker()
        local is_wished = wishlist_checker()

        local labels = {}
        for i, rg in ipairs(groups) do
            if type(rg) == "table" and type(rg.title) == "string" then
                local credit = rg["artist-credit"]
                local first_credit = type(credit) == "table" and credit[1] or nil
                local artist = type(first_credit) == "table" and type(first_credit.name) == "string"
                    and first_credit.name or ""
                labels[#labels + 1] = {
                    label = format_album_search_result_label(rg), wrap = true,
                    icon = marker_icon(is_owned(artist, rg.title), is_wished(artist, rg.title, rg.id)),
                }
            end
        end

        plugin.show_list("Album Results", labels, function(index)
            local rg = groups[index]
            if not rg then return end
            local artist = (rg["artist-credit"] and rg["artist-credit"][1] and rg["artist-credit"][1].name) or query
            local credit = rg["artist-credit"] and rg["artist-credit"][1]
            show_album_page_live(artist, rg.title or query, rg.id, rg["primary-type"],
                year_of(rg["first-release-date"]), credit and credit.artist and credit.artist.id)
        end)
    end)
end

local function show_search_artist()
    plugin.show_text_input("Search artist", "", false, search_artist)
end

local function show_search_album()
    plugin.show_text_input("Search album", "", false, search_album)
end

local function show_my_artists()
    local artists = {}
    local offset = 0
    while #artists < 500 do
        local page = plugin.library_get_artists(offset, 200)
        if not page or #page == 0 then break end
        for _, g in ipairs(page) do
            table.insert(artists, g)
        end
        if #page < 200 then break end
        offset = offset + 200
    end

    if #artists == 0 then
        plugin.show_toast("Discover: no library artists found")
        return
    end

    local labels = {}
    for i, g in ipairs(artists) do
        if i > 500 then break end
        labels[i] = g.name
    end

    plugin.show_list("My Artists", labels, function(index)
        local name = artists[index] and artists[index].name
        if not name then return end
        open_artist_by_name(name)
    end)
end

-- new & upcoming

local function format_release_label(r)
    local date = r.release_date or ""
    local tag = r.release_group_secondary_type and (" [" .. r.release_group_secondary_type .. "]") or ""
    return ("%s - %s (%s)%s"):format(r.artist, r.album, date, tag)
end

-- upcoming (soonest first) / released (newest first), filtered by options; various artists dropped
-- returns upcoming, released, hidden_by_options
local function partition_feed(opts)
    local today = time_to_date(os.time())
    local upcoming, released, hidden = {}, {}, 0

    for _, r in ipairs(load_matched_releases()) do
        if is_various_artists(r.artist, nil) then
            -- dropped without counting as hidden
        elseif not release_types_allowed({ r.release_group_secondary_type }, opts) then
            hidden = hidden + 1
        elseif (r.release_date or "") >= today then
            upcoming[#upcoming + 1] = r
        else
            released[#released + 1] = r
        end
    end

    table.sort(upcoming, function(a, b) return (a.release_date or "") < (b.release_date or "") end)
    table.sort(released, function(a, b) return (a.release_date or "") > (b.release_date or "") end)
    return upcoming, released, hidden
end

local MAX_FEED_LIST_ROWS = 500 -- show_list limit

local function show_feed_list(kind)
    local upcoming, released = partition_feed(load_options())
    local source = kind == "upcoming" and upcoming or released
    if #source == 0 then
        plugin.show_toast(("Discover: no %s releases to show"):format(kind))
        return
    end

    local is_owned = owned_checker()
    local is_wished = wishlist_checker()

    local labels, shown = {}, {}
    for i, r in ipairs(source) do
        if i > MAX_FEED_LIST_ROWS then break end
        shown[i] = r
        labels[i] = {
            label = format_release_label(r), wrap = true,
            icon = marker_icon(is_owned(r.artist, r.album), is_wished(r.artist, r.album, r.release_group_mbid)),
        }
    end

    local title = kind == "upcoming" and "Upcoming" or ("Released (last " .. FEED_PAST_DAYS .. " days)")
    plugin.show_list(title, labels, function(index)
        local r = shown[index]
        if not r then return end
        show_album_page_live(r.artist, r.album, r.release_group_mbid,
            r.release_group_primary_type, year_of(r.release_date), r.artist_mbid)
    end)
end

local function build_new_and_upcoming_rows()
    local upcoming, released, hidden = partition_feed(load_options())
    local last_fetch = tonumber(plugin.storage.get(LAST_FEED_FETCH_KEY, "0")) or 0

    local status
    if feed_job then
        status = ("Checking releases (%d of %d)..."):format(math.max(feed_job.index, 1), #feed_job.windows)
    elseif last_fetch > 0 then
        status = "Last checked " .. os.date("%Y-%m-%d %H:%M", last_fetch) .. " -- tap to check again"
    else
        status = "Check for new releases now"
    end

    local rows = {
        { type = "row", icon = ICON_BLANK, wrap = true, label = status,
          on_select = function() fetch_feed(true) end },
        { type = "row", icon = ICON_BLANK,
          label = ("Upcoming, next %d months (%d)"):format(math.floor(FEED_FUTURE_DAYS / 30.4 + 0.5), #upcoming),
          on_select = function() show_feed_list("upcoming") end },
        { type = "row", icon = ICON_BLANK,
          label = ("Released, last %d days (%d)"):format(FEED_PAST_DAYS, #released),
          on_select = function() show_feed_list("released") end },
    }

    if hidden > 0 then
        rows[#rows + 1] = { type = "row", icon = ICON_BLANK, wrap = true, on_select = function() end,
            label = ("%d more hidden by your Options"):format(hidden) }
    end

    if #upcoming == 0 and #released == 0 and hidden == 0 then
        local diag = json_load(plugin.storage.get(LAST_SCAN_DIAGNOSTICS_KEY), nil)
        if diag then
            rows[#rows + 1] = { type = "row", icon = ICON_BLANK, wrap = true, on_select = function() end,
                label = ("No matches (scanned %d releases against %d of your artists)")
                    :format(diag.scanned, diag.library_artist_count) }
        end
    end

    return rows
end

local function show_new_and_upcoming()
    plugin.show_settings_list("New & Upcoming", build_new_and_upcoming_rows())
end

-- wish list screens

local function show_add_by_hand()
    plugin.show_text_input("Artist", "", false, function(artist)
        artist = trim(artist)
        if artist == "" then return end

        plugin.show_text_input("Album", "", false, function(album)
            album = trim(album)
            if album == "" then return end

            local added, _, err = add_wishlist_entry(artist, album, nil, nil, nil, "manual", nil)
            if added then
                plugin.show_toast("Added to wish list")
            elseif added == nil then
                plugin.show_toast("Discover: couldn't save wish list (" .. tostring(err) .. ")")
            else
                plugin.show_toast("Already on your wish list")
            end
        end)
    end)
end

local function show_wish_list()
    pcall(sync_wishlist_mirror)
    maybe_run_autocheck()

    local wishlist = wishlist_display_order(load_wishlist())
    local possible = load_possible_matches()
    local labels = {}

    if #possible > 0 then
        labels[#labels + 1] = ("%d possible match%s to confirm"):format(
            #possible, #possible == 1 and "" or "es")
    end

    local first_wishlist_index = #labels + 1
    for i, e in ipairs(wishlist) do
        if i > 490 then break end
        labels[#labels + 1] = ("%s - %s"):format(e.artist, e.album)
    end

    if #wishlist == 0 and #possible == 0 then
        plugin.show_list("Wish List", { "Nothing here yet" }, function() end)
        return
    end

    plugin.show_list("Wish List", labels, function(index)
        if #possible > 0 and index == 1 then
            local confirm_rows = {}
            for _, e in ipairs(possible) do
                confirm_rows[#confirm_rows + 1] = { type = "toggle",
                    label = ("%s - %s"):format(e.artist, e.album), wrap = true, value = false,
                    on_change = function(checked)
                        if not checked then return end

                        local removed, err = remove_wishlist_entry(e.id)
                        if not removed then
                            plugin.show_toast("Discover: couldn't save wish list (" .. tostring(err) .. ")")
                            return
                        end

                        local remaining = {}
                        for _, p in ipairs(possible) do
                            if p.id ~= e.id then table.insert(remaining, p) end
                        end
                        possible = remaining

                        local saved, save_err = save_possible_matches(possible)
                        if not saved then
                            plugin.show_toast("Discover: couldn't save confirmations (" .. tostring(save_err) .. ")")
                            return
                        end
                        plugin.show_toast("Removed from wish list")
                    end,
                }
            end

            if #confirm_rows == 0 then
                confirm_rows[1] = { type = "row", label = "Nothing to confirm", on_select = function() end }
            end
            plugin.show_settings_list("Confirm Matches", confirm_rows)
            return
        end

        local wishlist_index = index - (first_wishlist_index - 1)
        local entry = wishlist[wishlist_index]
        if entry then
            show_album_page_cached(entry)
        end
    end)
end

-- options screen

local function mirror_status_text()
    if not mirror_writable() then return "waiting for the SD card" end
    if plugin.storage.get("wishlist_mirror_dirty", "0") == "1" then return "changes not copied yet" end
    if not file_exists(mirror_path()) then return "not created yet" end
    return "in sync"
end

-- explicit restore, since auto sync only pulls newer files; old list kept as wishlist_before_restore
local function show_restore_confirm()
    local mirrored, err = read_mirror()
    if not mirrored then
        plugin.show_toast("Discover: " .. err)
        return
    end

    plugin.show_list("Restore wish list", {
        ("Replace my wish list with the SD copy (%d album%s)"):format(#mirrored, #mirrored == 1 and "" or "s"),
        "Cancel",
    }, function(index)
        if index ~= 1 then return end

        local current = plugin.storage.get("wishlist")
        if current then
            local backed_up, backup_err = plugin.storage.set("wishlist_before_restore", current)
            if not backed_up then
                plugin.show_toast("Discover: couldn't back up the current wish list (" .. tostring(backup_err) .. ")")
                return
            end
        end

        local stored, store_err = storage_json_set("wishlist", wishlist_envelope(mirrored))
        if not stored then
            plugin.show_toast("Discover: couldn't restore wish list (" .. tostring(store_err) .. ")")
            return
        end
        record_mirror_mtime()
        local clean = plugin.storage.set("wishlist_mirror_dirty", "0")
        if not clean then
            plugin.show_toast("Discover: restored the list, but couldn't update SD sync status")
            return
        end
        plugin.show_toast(("Discover: restored %d from the SD copy"):format(#mirrored))
    end)
end

local function show_options()
    local opts = load_options()
    local rows = {
        -- first row shows which plugin copy loaded (pushed files need a plugin refresh or restart)
        { type = "row", icon = ICON_MENU, on_select = function() end,
          label = ("Discover v%s -- @buymyhubs"):format(PLUGIN_VERSION) },
    }

    for _, t in ipairs(SECONDARY_TYPE_OPTIONS) do
        rows[#rows + 1] = {
            type = "toggle", label = t.label, value = opts[t.key],
            on_change = function(checked)
                local saved, err = save_option(t.key, checked)
                if not saved then plugin.show_toast("Discover: couldn't save Options (" .. tostring(err) .. ")") end
            end,
        }
    end

    rows[#rows + 1] = { type = "row", icon = ICON_BLANK, wrap = true, on_select = function() end,
        label = "Wish list SD copy: " .. mirror_status_text() }
    rows[#rows + 1] = { type = "row", icon = ICON_BLANK, label = "Back up wish list to SD now",
        on_select = function()
            local ok, err = write_mirror(load_wishlist())
            plugin.show_toast(ok and "Discover: wish list copied to the SD card"
                or ("Discover: " .. tostring(err)))
        end }
    rows[#rows + 1] = { type = "row", icon = ICON_BLANK, label = "Restore wish list from SD copy",
        on_select = show_restore_confirm }

    plugin.show_settings_list("Options", rows)
end

-- main menu and registration

local function show_discover_menu()
    plugin.show_list("Discover", {
        "New & Upcoming",
        "Wish List",
        "My Artists",
        "Search Artist",
        "Search Album",
        "Add By Hand",
        "Options",
    }, function(index)
        if index == 1 then show_new_and_upcoming()
        elseif index == 2 then show_wish_list()
        elseif index == 3 then show_my_artists()
        elseif index == 4 then show_search_artist()
        elseif index == 5 then show_search_album()
        elseif index == 6 then show_add_by_hand()
        elseif index == 7 then show_options()
        end
    end)
end

-- Music Library is the supported Settings list for music library tools.
local menu_options = { icon = ICON_MENU }
plugin.register_list_item("music_library", "Discover", show_discover_menu, menu_options)

-- events
-- these trigger the auto check-off; the wish list screen also runs it on open

plugin.on("screen_woke", function()
    pcall(sync_wishlist_mirror)
    maybe_run_autocheck()
end)

plugin.on("system_resumed", function()
    pcall(sync_wishlist_mirror)
    maybe_run_autocheck()
end)

pcall(sync_wishlist_mirror)
