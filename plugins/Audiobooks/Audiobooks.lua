plugin.define({ id = "example.audiobooks", name = "Audiobooks", version = "3.6.0", api_min = 16 })

-- Audiobooks live under <SD>/Audiobooks as Title/files, Title/CD1/files,
-- Author/Title/files, Author/Series/Title/files, with optional disc folders,
-- or loose one-file books. Authors and Series shelves use these folder names.
-- Progress, bookmarks, notes, chapter jumps, finished state, and a sleep
-- timer are per book. Optional time skipping applies to both physical and
-- Now Playing Next/Previous. Progress remains per file.
-- Files over 2 GiB have no chapters.

local ROOT = plugin.sd_root() .. "/Audiobooks"
local STATE_PATH = plugin.sd_root() .. "/.plugins/.audiobooks_state_v3"
local OLD_STATE_PATH = plugin.sd_root() .. "/.plugins/.audiobooks_state_v2"
local SETTINGS_PATH = plugin.sd_root() .. "/.plugins/.audiobooks_settings"
local ICON_ROOT = plugin.sd_root() .. "/.plugin-assets/Audiobooks/"
local ICON_BOOK, ICON_PLAY, ICON_CHAPTERS = ICON_ROOT .. "audiobooks.png", ICON_ROOT .. "play.png", ICON_ROOT .. "chapters.png"
local ICON_BOOKMARK, ICON_BOOKMARKS = ICON_ROOT .. "bookmark.png", ICON_ROOT .. "bookmarks.png"
local ICON_HISTORY, ICON_SETTINGS = ICON_ROOT .. "history.png", ICON_ROOT .. "settings.png"
local ICON_SLEEP, ICON_FINISHED, ICON_REFRESH = ICON_ROOT .. "sleep.png", ICON_ROOT .. "finished.png", ICON_ROOT .. "refresh.png"
local ICON_LIBRARY, ICON_NEW, ICON_IN_PROGRESS = ICON_ROOT .. "library.png", ICON_ROOT .. "new.png", ICON_ROOT .. "in_progress.png"
local AUDIO = {
    mp3 = true,
    m4a = true,
    m4b = true,
    flac = true,
    ogg = true,
    opus = true,
    wav = true,
    aac = true,
    aif = true,
    aiff = true,
    ape = true,
    wma = true,
}
local MAX_ROWS, MAX_BOOK_FILES, MAX_ENTRIES = 500, 500, 2000
local state, books, book_by_key = {}, nil, {}
local file_cache, chapter_cache = {}, {}
local file_cache_order, chapter_cache_order = {}, {}
local saved_books_hydrated = false
local pending_seek, history_dirty, state_dirty = nil, false, false
local last_saved_position, ticks = -1, 0
local sleep_timer, sleep_chapter, sleep_book = nil, nil, nil
local warned_mode = false
local warned_state_full = false
local warned_scan_limit = false
local active_book_key
local open_guard, last_seen, idle_flush_pending, sleep_pause = nil, nil, nil, nil
local last_terminal_flush
local bookmark_serial = 0 -- session identities, so a stale row never acts on another bookmark
local open_book, open_library, open_legacy_library, remember_book
local atomic_write
local skip_by_30 = false
local playback_speed = 1.0
local speed_retry_pending = false
local SPEEDS = { 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0 }
local function speed_supported()
    return plugin.has_capability and plugin.has_capability("playback.speed")
        and type(plugin.set_playback_speed) == "function"
end
local function apply_speed(value)
    if not speed_supported() then return value == 1.0 end
    local ok, accepted = pcall(plugin.set_playback_speed, ROOT, value)
    return ok and accepted == true
end
local function current_audiobook_path()
    local path = plugin.get_current_track_path()
    return type(path) == "string" and path:sub(1, #ROOT + 1) == ROOT .. "/" and path or nil
end
local function speed_waiting_for_resume(path)
    return (pending_seek and pending_seek.path == path) or (open_guard and open_guard.path == path)
end

local function read_settings()
    local f = io.open(SETTINGS_PATH, "r")
    if not f then
        return
    end
    for _ = 1, 16 do
        local line = f:read("*l")
        if not line then break end
        if line == "skip_by_30\t1" then skip_by_30 = true end
        local value = tonumber(line:match("^playback_speed\t([%d%.]+)$"))
        for _, speed in ipairs(SPEEDS) do
            if value == speed then playback_speed = value end
        end
    end
    f:close()
end

local function save_settings()
    return atomic_write(SETTINGS_PATH, function(f)
        f:write("skip_by_30\t", skip_by_30 and "1" or "0", "\n")
        f:write("playback_speed\t", tostring(playback_speed), "\n")
    end)
end

local function set_transport_skip(enabled)
    if not (plugin.has_capability and plugin.has_capability("playback.transport_skip")) then
        return false
    end
    if type(plugin.set_transport_skip) ~= "function" then
        return false
    end
    local ok = pcall(plugin.set_transport_skip, ROOT, enabled and 30 or 0)
    return ok
end

local open_settings
open_settings = function(update_existing)
    local available = plugin.has_capability and plugin.has_capability("playback.transport_skip")
    local rows = {
        {
            type = "toggle", label = "Skip by 30 seconds", value = skip_by_30,
            icon = ICON_SETTINGS, text_size = "medium",
            on_change = function(value)
                if not available then
                    plugin.show_toast("30 second skip requires a newer player")
                    return
                end
                local previous = skip_by_30
                skip_by_30 = value == true
                if not set_transport_skip(skip_by_30) then
                    skip_by_30 = previous
                    plugin.show_toast("Could not apply transport skip setting")
                    return
                end
                if not save_settings() then
                    skip_by_30 = previous
                    set_transport_skip(skip_by_30)
                    plugin.show_toast("Could not save transport skip setting")
                    return
                end
            end,
        },
    }
    rows[#rows + 1] = {
        type = "row", label = "Playback speed: " .. tostring(playback_speed) .. "x",
        icon = ICON_SETTINGS, text_size = "medium",
        on_select = function()
            if not speed_supported() then
                plugin.show_toast("Playback speed requires a newer player")
                return
            end
            local choices = {}
            for _, value in ipairs(SPEEDS) do
                choices[#choices + 1] = tostring(value) .. "x"
            end
            plugin.show_list("Playback speed", choices, function(index)
                local speed = SPEEDS[index]
                if not speed then return end
                local active_path = current_audiobook_path()
                local defer_until_ready = active_path and speed_waiting_for_resume(active_path)
                local previous = playback_speed
                if active_path and not defer_until_ready and not apply_speed(speed) then
                    plugin.show_toast("Speed is unavailable for this audio format")
                    return
                end
                playback_speed = speed
                if not save_settings() then
                    playback_speed = previous
                    if active_path then
                        speed_retry_pending = defer_until_ready or not apply_speed(previous)
                    else
                        speed_retry_pending = true
                    end
                    plugin.show_toast("Could not save playback speed")
                    return
                end
                speed_retry_pending = active_path == nil or defer_until_ready == true
                -- Keep the speed chooser in front; refresh the covered parent
                -- in place so Back returns to the updated label. `show_list`
                -- has its own screen pool, separate from the two native
                -- settings-list slots this flow already uses.
                open_settings(true)
                plugin.show_toast("Playback speed set to " .. tostring(speed) .. "x")
            end)
        end,
    }
    plugin.show_settings_list("Audiobooks settings", rows,
        update_existing and { update = true } or nil)
end

local function cap(s, n)
    s = tostring(s or "")
    if #s > n then
        return s:sub(1, n)
    end
    return s
end

local function finite(n, lo, hi)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge and n >= lo and n <= hi
end

local function encode(s)
    return (
        tostring(s or ""):gsub("([^%w%._%- ])", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
    )
end

local function decode(s)
    return ((s or ""):gsub("%%(%x%x)", function(h)
        return string.char(tonumber(h, 16))
    end))
end

local function split_tabs(s)
    local out = {}
    for part in (s .. "\t"):gmatch("(.-)\t") do
        out[#out + 1] = part
    end
    return out
end

atomic_write = function(path, writer)
    local f = io.open(path .. ".tmp", "w")
    if not f then
        return false
    end
    local checked = {
        write = function(_, ...)
            local ok, err = f:write(...)
            if not ok then
                error(err or "write failed")
            end
        end,
    }
    local ok = pcall(writer, checked)
    local closed = f:close()
    if not ok or not closed then
        os.remove(path .. ".tmp")
        return false
    end
    if os.rename(path .. ".tmp", path) then
        return true
    end
    os.remove(path .. ".tmp")
    return false
end

local function time_label(value)
    value = math.max(0, math.floor(value or 0))
    local h, m, s = math.floor(value / 3600), math.floor(value / 60) % 60, value % 60
    return string.format("%d:%02d:%02d", h, m, s)
end

local function natural_key(s)
    local out, i = {}, 1
    s = tostring(s or ""):lower()
    while i <= #s do
        local a, b = s:find("%d+", i)
        if a == i then
            local digits = s:sub(a, b):gsub("^0+", "")
            if digits == "" then
                digits = "0"
            end
            out[#out + 1] = string.format("#%08d:%s", #digits, digits)
            i = b + 1
        else
            local stop = a and a - 1 or #s
            out[#out + 1] = "$" .. s:sub(i, stop)
            i = stop + 1
        end
    end
    return table.concat(out)
end

local function natural_less(a, b)
    local an, bn = a.name or a, b.name or b
    local ak, bk = natural_key(an), natural_key(bn)
    return ak == bk and an:lower() < bn:lower() or ak < bk
end

local function extension(name)
    local ext = tostring(name or ""):match("%.([%w]+)$")
    return ext and ext:lower() or ""
end

local function is_audio(name)
    return AUDIO[extension(name)] == true
end

local function safe_dir(path)
    local ok, entries = pcall(plugin.list_dir, path)
    if not ok or type(entries) ~= "table" then
        return {}
    end
    local out, n, cut = {}, 0, false
    for _, entry in ipairs(entries) do
        n = n + 1
        if n > MAX_ENTRIES then
            cut = true
            break
        end
        if type(entry) == "table" and type(entry.name) == "string" and #entry.name <= 255 then
            out[#out + 1] = { name = entry.name, dir = entry.dir == true }
        end
    end
    table.sort(out, natural_less)
    return out, cut
end

local function valid_path_piece(s)
    return type(s) == "string"
        and s ~= ""
        and s ~= "."
        and s ~= ".."
        and #s <= 255
        and not s:find("[%z\1-\31\127]")
        and not s:find("/", 1, true)
        and not s:find("\\", 1, true)
end

-- Saved book keys and file names are relative to Audiobooks. Validate every
-- component before joining persisted data to ROOT; state files are user data.
local function valid_relative_path(path)
    if type(path) ~= "string" or path == "" or #path > 512 or path:sub(1, 1) == "/" then
        return false
    end
    local count = 0
    for part in path:gmatch("[^/]+") do
        if not valid_path_piece(part) then
            return false
        end
        count = count + 1
    end
    return count > 0 and path:sub(-1) ~= "/" and not path:find("//", 1, true)
end

local function path_parts(path)
    local parts = {}
    if not valid_relative_path(path) then
        return nil
    end
    for part in path:gmatch("[^/]+") do
        parts[#parts + 1] = part
    end
    return parts
end

local function read_state_file(path, importing)
    local f = io.open(path, "r")
    if not f then
        return false
    end
    local records, record_count = {}, 0
    local raw = f:read(2097152) or ""
    f:close()
    local pos, lines = 1, 0
    while pos <= #raw and lines < 20000 do
        local ending = raw:find("\n", pos, true)
        if not ending then
            break
        end
        local line = raw:sub(pos, ending - 1)
        pos, lines = ending + 1, lines + 1
        if #line <= 4096 then
            local p = split_tabs(line)
            local key = decode(p[2] or "")
            local kind = p[1]
            -- A record (and its lists) is created only once a line has been
            -- fully validated, and books are capped, so a junk file cannot
            -- fill memory.
            local function record_for()
                local s = records[key]
                if not s and record_count < 5000 then
                    s = {}
                    records[key] = s
                    record_count = record_count + 1
                end
                return s
            end
            local file = decode(p[3] or "")
            local valid_key = #key <= 512 and key ~= "" and #file <= 512
            if valid_key and kind == "P" and #p >= 7 then
                local position, duration, last = tonumber(p[4]), tonumber(p[5]), tonumber(p[7])
                if
                    finite(position, 0, 10000000)
                    and finite(duration, 0, 10000000)
                    and finite(last, 0, 20000000000)
                then
                    local s = record_for()
                    if s then
                        s.file, s.position, s.duration = file, position, duration
                        s.finished, s.last_played = p[6] == "1", last
                        s.finished_manual = not importing and p[8] == "1" or false
                        s.direct_only = not importing and p[9] == "1" or false
                    end
                end
            elseif valid_key and kind == "B" and #p >= 5 then
                local position = tonumber(p[4])
                if finite(position, 0, 10000000) then
                    local s = record_for()
                    if s then
                        s.bookmarks = s.bookmarks or {}
                        if #s.bookmarks < 50 then
                            s.bookmarks[#s.bookmarks + 1] = {
                                file = file,
                                position = position,
                                note = importing and "" or cap(decode(p[5]), 120),
                            }
                        end
                    end
                end
            elseif valid_key and kind == "H" and not importing and #p >= 4 then
                local position = tonumber(p[4])
                if finite(position, 0, 10000000) then
                    local s = record_for()
                    if s then
                        s.history = s.history or {}
                        if #s.history < 5 then
                            s.history[#s.history + 1] = { file = file, position = position }
                        end
                    end
                end
            end
        end
    end
    if importing then
        for key, s in pairs(records) do
            local target = state[key] or {}
            target.bookmarks = target.bookmarks or {}
            if not target.file and s.file then
                target.file, target.position, target.duration = s.file, s.position, s.duration
                target.finished, target.last_played = s.finished, s.last_played
            end
            for _, b in ipairs(s.bookmarks or {}) do
                if #target.bookmarks < 50 then
                    target.bookmarks[#target.bookmarks + 1] = b
                end
            end
            state[key] = target
        end
    else
        state = records
    end
    return true
end

-- The writer keeps to the reader's limits (2 MiB, 20,000 lines), so the
-- state file is always read back whole. Progress lines come first and are
-- never dropped: if they alone would not fit, the save fails and the old
-- file stays. History and bookmarks of the most recently played books
-- follow, and only what would not fit is dropped.
local STATE_MAX_BYTES, STATE_MAX_LINES = 2097152 - 8192, 20000 - 10

local function save_state()
    local keys = {}
    for key in pairs(state) do
        keys[#keys + 1] = key
    end
    table.sort(keys, function(a, b)
        return (state[a].last_played or 0) > (state[b].last_played or 0)
    end)
    -- What was actually written, so memory can be trimmed to match the file
    -- when the size limit dropped history or bookmarks.
    local kept_history, kept_marks, dropped_marks = {}, {}, false
    local ok = atomic_write(STATE_PATH, function(f)
        local bytes, lines = 0, 0
        local function line(required, ...)
            local text = table.concat({ ... }, "\t") .. "\n"
            if lines >= STATE_MAX_LINES or bytes + #text > STATE_MAX_BYTES then
                if required then
                    error("progress does not fit the state file")
                end
                return false
            end
            f:write(text)
            bytes, lines = bytes + #text, lines + 1
            return true
        end
        for _, key in ipairs(keys) do
            local s = state[key]
            line(
                true,
                "P",
                encode(key),
                encode(s.file or ""),
                tostring(math.floor(s.position or 0)),
                tostring(math.floor(s.duration or 0)),
                s.finished and "1" or "0",
                tostring(math.floor(s.last_played or 0)),
                s.finished_manual and "1" or "0",
                s.direct_only and "1" or "0"
            )
        end
        for _, key in ipairs(keys) do
            local s = state[key]
            local history, kept = s.history or {}, {}
            for i = math.max(1, #history - 4), #history do
                local h = history[i]
                if line(false, "H", encode(key), encode(h.file), tostring(math.floor(h.position))) then
                    kept[#kept + 1] = h
                end
            end
            kept_history[key] = kept
        end
        for _, key in ipairs(keys) do
            local s = state[key]
            local marks, kept = s.bookmarks or {}, {}
            for i = math.max(1, #marks - 49), #marks do
                local b = marks[i]
                if
                    line(
                        false,
                        "B",
                        encode(key),
                        encode(b.file),
                        tostring(math.floor(b.position)),
                        encode(b.note or "")
                    )
                then
                    kept[#kept + 1] = b
                else
                    dropped_marks = true
                end
            end
            kept_marks[key] = kept
        end
    end)
    if ok then
        for key, s in pairs(state) do
            if s.history then
                s.history = kept_history[key] or {}
            end
            if s.bookmarks then
                s.bookmarks = kept_marks[key] or {}
            end
        end
        if dropped_marks and not warned_state_full then
            warned_state_full = true
            plugin.show_toast("Too many bookmarks to save; some were removed")
        end
    end
    state_dirty = not ok
    return ok
end

local function ensure_state(key)
    local s = state[key]
    if not s then
        s = { bookmarks = {}, history = {} }
        state[key] = s
    end
    s.bookmarks, s.history = s.bookmarks or {}, s.history or {}
    return s
end

local function ensure_root()
    pcall(plugin.mkdir, ROOT)
    local f = io.open(ROOT .. "/database.ignore", "r")
    if f then
        f:close()
        return
    end
    f = io.open(ROOT .. "/database.ignore", "w")
    if f then
        f:close()
    end
end

local function contains_audio(dir, depth, budget)
    if depth > 2 or budget.n <= 0 then
        return false
    end
    for _, e in ipairs(safe_dir(dir)) do
        budget.n = budget.n - 1
        if budget.n < 0 then
            return false
        end
        if not e.dir and is_audio(e.name) then
            return true
        end
        if e.dir and depth < 2 and contains_audio(dir .. "/" .. e.name, depth + 1, budget) then
            return true
        end
    end
    return false
end

local function direct_audio_count(dir)
    local count = 0
    for _, e in ipairs(safe_dir(dir)) do
        if not e.dir and is_audio(e.name) then
            count = count + 1
        end
    end
    return count
end

-- "CD1", "Disc 2", "disk_03", "DVD-1", "Part 2", or a bare number; not a
-- title that merely starts with those letters ("Discworld").
local function is_disc_name(name)
    local lower = name:lower()
    if lower:match("^%d+$") then
        return true
    end
    for _, prefix in ipairs({ "cd", "disc", "disk", "dvd", "part" }) do
        if lower:sub(1, #prefix) == prefix then
            local rest = lower:sub(#prefix + 1)
            if rest:match("^[%s%-_%.]*%d+$") or rest:match("^[%s%-_%.]*%d+[%s%-_%.]") then
                return true
            end
        end
    end
    return false
end

-- Folder shelves recognize Author/Book and Author/Series/Book. Disc folders
-- stay chapters of a book. Progress keys remain relative paths; legacy saved
-- collections are retained instead of splitting or rewriting their state.
local function scan_library()
    ensure_root()
    local result, budget, partial = {}, 10000, false
    local directories = {}
    local function entries(dir)
        if directories[dir] then return directories[dir] end
        if budget <= 0 then partial = true; return {} end
        local found, cut = safe_dir(dir)
        local kept = {}
        for _, entry in ipairs(found) do
            if budget <= 0 then partial = true; break end
            budget = budget - 1
            kept[#kept + 1] = entry
        end
        partial = partial or cut
        directories[dir] = kept
        return kept
    end
    local function has_audio(dir, depth)
        for _, entry in ipairs(entries(dir)) do
            if not entry.dir and is_audio(entry.name) then return true end
            if entry.dir and depth > 0 and has_audio(dir .. "/" .. entry.name, depth - 1) then return true end
        end
        return false
    end
    local function is_book(dir)
        for _, entry in ipairs(entries(dir)) do
            if not entry.dir and is_audio(entry.name) then return true end
            if entry.dir and is_disc_name(entry.name) and has_audio(dir .. "/" .. entry.name, 1) then return true end
        end
        return false
    end
    local function add(key, title, author, series, loose)
        if #result >= 5000 then partial = true; return end
        result[#result + 1] = { key = key, title = title, author = author or "", series = series or "",
            dir = loose and ROOT or ROOT .. "/" .. key, loose = loose, single = loose }
    end
    for _, root in ipairs(entries(ROOT)) do
        if not root.dir then
            if is_audio(root.name) then add(root.name, root.name:gsub("%.[^%.]+$", ""), "", "", true) end
        else
            local dir = ROOT .. "/" .. root.name
            if is_book(dir) then
                add(root.name, root.name)
            else
                for _, child in ipairs(entries(dir)) do
                    if child.dir then
                        local key = root.name .. "/" .. child.name
                        local path = ROOT .. "/" .. key
                        if is_book(path) then
                            add(key, child.name, root.name)
                        else
                            local saved = state[key]
                            if saved and (saved.file or saved.finished or #(saved.bookmarks or {}) > 0
                                or #(saved.history or {}) > 0) and has_audio(path, 2) then
                                -- Old releases treated this whole series as one book.
                                add(key, child.name .. " (saved collection)", root.name, child.name)
                            end
                            for _, book in ipairs(entries(path)) do
                                if book.dir and has_audio(path .. "/" .. book.name, 2) then
                                    add(key .. "/" .. book.name, book.name, root.name, child.name)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    table.sort(result, function(a, b) return natural_less(a.title, b.title) end)
    books, book_by_key = result, {}
    for _, book in ipairs(result) do book_by_key[book.key] = book end
    saved_books_hydrated = false
    if partial and not warned_scan_limit then
        warned_scan_limit = true
        plugin.show_toast("Library scan limit reached; Browse folders shows more")
    end
end

-- Share the player's bounded image worker with EPUB; show our icon until ready.
local COVER_CACHE = plugin.sd_root() .. "/.plugins/.audiobooks_covers"
local cover_jobs, cover_pending, cover_failed = {}, {}, {}
local cover_running = false
local function cover_exists(path)
    local f = io.open(path, "rb")
    if not f then return false end
    f:close()
    return true
end
local function service_covers()
    if cover_running or #cover_jobs == 0 then return end
    local job = cover_jobs[1]
    local ok, started, reason = pcall(plugin.image_thumbnail_async, job.source, job.dest, 96, 96,
        function(path, err)
            cover_running = false
            cover_pending[job.source] = nil
            if not path and err ~= "busy" and err ~= "nomem" then cover_failed[job.source] = true end
        end)
    if ok and started then
        cover_running = true
        table.remove(cover_jobs, 1)
    elseif not ok or reason ~= "busy" then
        table.remove(cover_jobs, 1)
        cover_pending[job.source] = nil
        if not ok or reason ~= "nomem" then cover_failed[job.source] = true end
    end
end

local function cover_for(book)
    if book.loose then
        return ICON_BOOK
    end
    local ok, entries = pcall(plugin.list_dir, book.dir)
    if not ok or type(entries) ~= "table" then
        return ICON_BOOK
    end
    local names = {}
    for i = 1, math.min(#entries, 200) do
        local e = entries[i]
        if type(e) == "table" and type(e.name) == "string" then
            names[e.name:lower()] = e
        end
    end
    for _, name in ipairs({ "cover.jpg", "cover.png", "folder.jpg", "folder.png" }) do
        if names[name] then
            local entry = names[name]
            local source = book.dir .. "/" .. entry.name
            if type(plugin.image_thumbnail_async) ~= "function" or type(plugin.md5) ~= "function" then
                return source
            end
            local dest = COVER_CACHE .. "/" .. plugin.md5(source .. "\n" .. tostring(entry.size or "") .. "\n" .. tostring(entry.modified or "")) .. ".bin"
            if cover_exists(dest) then return dest end
            if not cover_pending[source] and not cover_failed[source] and #cover_jobs < 64
                and plugin.mkdir(COVER_CACHE) then
                cover_pending[source] = true
                cover_jobs[#cover_jobs + 1] = { source = source, dest = dest }
                service_covers()
            end
            return ICON_BOOK
        end
    end
    return ICON_BOOK
end

local function scan_book(book, quiet)
    local files, inspected, cut = {}, 0, false
    local function walk(dir, depth, prefix)
        if depth > 2 then
            return
        end
        for _, e in ipairs(safe_dir(dir)) do
            inspected = inspected + 1
            if inspected > MAX_ENTRIES then
                cut = true
                return
            end
            local rel = prefix == "" and e.name or (prefix .. "/" .. e.name)
            if e.dir then
                if not book.direct_only and depth < 2 then
                    walk(dir .. "/" .. e.name, depth + 1, rel)
                end
            elseif is_audio(e.name) then
                files[#files + 1] = { name = rel, path = dir .. "/" .. e.name }
            end
            if cut then
                return
            end
        end
    end
    if book.loose then
        local rel = book.file_rel or book.key
        if valid_relative_path(rel) then
            files[1] = { name = rel, path = ROOT .. "/" .. rel }
        end
    else
        walk(book.dir, 0, "")
    end
    table.sort(files, natural_less)
    if #files > MAX_BOOK_FILES then
        cut = true
        for i = #files, MAX_BOOK_FILES + 1, -1 do
            files[i] = nil
        end
    end
    if cut and not quiet then
        plugin.show_toast("Some files could not be listed")
    end
    return files
end

-- File lists of books used this session (cleared by Rescan). quiet scans
-- come from the progress tick and must not toast.
-- A few books' file lists stay cached; older ones are dropped.
local FILE_CACHE_BOOKS, CHAPTER_CACHE_FILES = 4, 8
local function remember(cache, order, limit, key, value)
    for i, k in ipairs(order) do
        if k == key then
            table.remove(order, i)
            break
        end
    end
    cache[key] = value
    order[#order + 1] = key
    while #order > limit do
        cache[table.remove(order, 1)] = nil
    end
end

local function get_files(book, quiet)
    local files = file_cache[book.key]
    if not files then
        files = scan_book(book, quiet)
    end
    remember(file_cache, file_cache_order, FILE_CACHE_BOOKS, book.key, files)
    return files
end

local function path_for(book, rel)
    for _, f in ipairs(get_files(book)) do
        if f.name == rel then
            return f.path
        end
    end
end

local function file_size(path)
    local f = io.open(path, "rb")
    if not f then
        return 0
    end
    local size = f:seek("end") or 0
    f:close()
    return size
end

local function be(data, pos, count)
    if pos < 1 or count < 1 or pos + count - 1 > #data then
        return nil
    end
    local n = 0
    for i = pos, pos + count - 1 do
        n = n * 256 + data:byte(i)
    end
    return n
end

local function syncsafe(data, pos)
    local a, b, c, d = data:byte(pos, pos + 3)
    if not d or a >= 128 or b >= 128 or c >= 128 or d >= 128 then
        return nil
    end
    return ((a * 128 + b) * 128 + c) * 128 + d
end

local function utf8_char(n)
    if not n or n < 0 or n > 1114111 or (n >= 55296 and n <= 57343) then
        return ""
    end
    if n < 128 then
        return string.char(n)
    end
    if n < 2048 then
        return string.char(192 + math.floor(n / 64), 128 + n % 64)
    end
    if n < 65536 then
        return string.char(224 + math.floor(n / 4096), 128 + math.floor(n / 64) % 64, 128 + n % 64)
    end
    return string.char(
        240 + math.floor(n / 262144),
        128 + math.floor(n / 4096) % 64,
        128 + math.floor(n / 64) % 64,
        128 + n % 64
    )
end

local function decode_text(data)
    if #data > 4096 then
        return ""
    end
    local enc = data:byte(1) or 255
    local text = data:sub(2)
    -- Single-byte encodings end at their first NUL (a plain find, linear on
    -- any input, unlike trimming with a pattern).
    if enc == 3 or enc == 0 then
        local nul = text:find("\0", 1, true)
        if nul then
            text = text:sub(1, nul - 1)
        end
    end
    if enc == 3 then
        return cap(text, 160)
    end
    if enc == 0 then
        local out = {}
        for i = 1, math.min(#text, 160) do
            out[#out + 1] = utf8_char(text:byte(i))
        end
        return cap(table.concat(out), 160)
    end
    local little = enc == 1 and text:byte(1) == 255 and text:byte(2) == 254
    local start = enc == 1 and (text:byte(1) == 254 and 3 or (text:byte(1) == 255 and 3 or 1)) or 1
    if enc == 2 or enc == 1 then
        local out, i = {}, start
        while i + 1 <= #text do
            local a, b = text:byte(i, i + 1)
            local n = little and (b * 256 + a) or (a * 256 + b)
            i = i + 2
            if n == 0 then
                break
            end
            if n >= 55296 and n <= 56319 and i + 1 <= #text then
                local c, d = text:byte(i, i + 1)
                local low = little and (d * 256 + c) or (c * 256 + d)
                if low >= 56320 and low <= 57343 then
                    n = 65536 + (n - 55296) * 1024 + low - 56320
                    i = i + 2
                end
            end
            out[#out + 1] = utf8_char(n)
        end
        return cap(table.concat(out), 160)
    end
    return ""
end

local function parse_id3(path, size)
    if size > 2147483647 then
        return {}
    end
    local f = io.open(path, "rb")
    if not f then
        return {}
    end
    local head = f:read(10)
    if not head or #head < 10 or head:sub(1, 3) ~= "ID3" then
        f:close()
        return {}
    end
    local version, flags, tag_size = head:byte(4), head:byte(6), syncsafe(head, 7)
    -- Large artwork makes a tag big; frames are seek-skipped, so only the
    -- bytes actually read are bounded (below), not the tag size.
    if not tag_size or tag_size + 10 > size or (version ~= 3 and version ~= 4) then
        f:close()
        return {}
    end
    -- A v2.3 tag unsynchronised as a whole cannot be walked frame by frame.
    if version == 3 and flags % 256 >= 128 then
        f:close()
        return {}
    end
    local pos, finish, loops, bytes, chapters = 11, 10 + tag_size, 0, 10, {}
    local tag_unsync = version == 4 and flags % 256 >= 128
    if math.floor(flags / 64) % 2 == 1 then
        -- Extended header: v2.4 gives a syncsafe size including itself, v2.3
        -- a plain size excluding its own four bytes.
        local ext = f:read(4)
        local ext_size = ext and #ext == 4 and (version == 4 and syncsafe(ext, 1) or be(ext, 1, 4))
        if not ext_size then
            f:close()
            return {}
        end
        pos = pos + (version == 4 and ext_size or ext_size + 4)
        bytes = bytes + 4
    end
    while pos + 9 <= finish and loops < 20000 and bytes < 131072 do
        loops = loops + 1
        if not f:seek("set", pos - 1) then
            break
        end
        local fh = f:read(10)
        if not fh or #fh < 10 then
            break
        end
        bytes = bytes + 10
        local id = fh:sub(1, 4)
        if id == "\0\0\0\0" then
            break
        end
        local len = version == 4 and syncsafe(fh, 5) or be(fh, 5, 4)
        if not len or len < 0 or pos + 10 + len - 1 > finish then
            break
        end
        -- v2.4 frame flags: compressed or encrypted frames are skipped; a data
        -- length indicator is dropped, and unsynchronisation (per frame, or
        -- for the whole tag) is undone before the payload is read.
        local frame_flags = fh:byte(10) or 0
        local unreadable = version == 4 and math.floor(frame_flags / 4) % 4 ~= 0
        if id == "CHAP" and len <= 8192 and not unreadable then
            local payload = f:read(len)
            bytes = bytes + len
            local complete = payload and #payload == len
            if complete and version == 4 then
                if frame_flags % 2 == 1 then
                    payload = payload:sub(5)
                end
                if tag_unsync or math.floor(frame_flags / 2) % 2 == 1 then
                    payload = payload:gsub("\255%z", "\255")
                end
            end
            if complete then
                local z = payload:find("\0", 1, true)
                if z and z + 16 <= #payload then
                    local start = be(payload, z + 1, 4)
                    local chapter = { start = start / 1000, title = "" }
                    local sub = z + 17
                    while sub + 9 <= #payload do
                        local sid = payload:sub(sub, sub + 3)
                        local slen = version == 4 and syncsafe(payload, sub + 4) or be(payload, sub + 4, 4)
                        if not slen or slen <= 0 or sub + 10 + slen - 1 > #payload then
                            break
                        end
                        if sid == "TIT2" then
                            chapter.title = decode_text(payload:sub(sub + 10, sub + 9 + slen))
                            break
                        end
                        sub = sub + 10 + slen
                    end
                    if finite(chapter.start, 0, 10000000) then
                        chapters[#chapters + 1] = chapter
                    end
                end
            end
            pos = pos + 10 + len
        else
            pos = pos + 10 + len
        end
    end
    f:close()
    table.sort(chapters, function(a, b)
        return a.start < b.start
    end)
    for i, c in ipairs(chapters) do
        if c.title == "" then
            c.title = "Chapter " .. i
        end
    end
    return chapters
end

-- Whether a cue sheet's FILE line names this audio file: resolved against
-- the cue's folder (so "CD1/part.mp3" works from the book folder), or by
-- bare name.
local function cue_refers(cuepath, name, audio_path)
    local ref = name:gsub("\\", "/"):gsub("^%./", "")
    local cue_dir = cuepath:match("^(.*)/") or ""
    local full = ref:sub(1, 1) == "/" and ref or (cue_dir .. "/" .. ref)
    if full:lower() == audio_path:lower() then
        return true
    end
    return not ref:find("/", 1, true) and ref:lower() == (audio_path:match("([^/]+)$") or ""):lower()
end

local function parse_cue(path, book, audio_path)
    -- The same-named sidecar first, then any other cue sheet in the folder
    -- (a loose book's folder is the library root); each is only used if a
    -- FILE line names this audio file.
    local candidates, seen = {}, {}
    local function add(candidate)
        if not seen[candidate] and #candidates < 8 then
            seen[candidate] = true
            candidates[#candidates + 1] = candidate
        end
    end
    add((path:gsub("%.[^%.]+$", ".cue")))
    local dir = book.loose and ROOT or book.dir
    for _, e in ipairs(safe_dir(dir)) do
        if not e.dir and e.name:lower():match("%.cue$") then
            add(dir .. "/" .. e.name)
        end
    end
    for _, cuepath in ipairs(candidates) do
        local f = io.open(cuepath, "r")
        if f then
            local body = f:read(32768) or ""
            f:close()
            local selected, title, entries, track_title = false, nil, {}, nil
            local pos = 1
            while pos <= #body do
                local e = body:find("\n", pos, true) or (#body + 1)
                local line = body:sub(pos, e - 1):gsub("\r$", "")
                local fname = line:match('^%s*FILE%s+"([^"]+)"') or line:match("^%s*FILE%s+(%S+)")
                if fname then
                    selected = cue_refers(cuepath, fname, audio_path)
                end
                local tn = line:match("^%s*TRACK%s+%d+%s+%S+")
                if tn then
                    track_title = nil
                end
                local quoted = line:match('^%s*TITLE%s+"(.*)"')
                if quoted then
                    track_title = quoted
                end
                local mm, ss, ff = line:match("^%s*INDEX%s+01%s+(%d%d?%d?%d?):(%d%d):(%d%d)")
                if mm and (tonumber(ss) >= 60 or tonumber(ff) >= 75) then
                    mm = nil
                end
                if selected and mm then
                    local start = (tonumber(mm) * 60 + tonumber(ss)) + tonumber(ff) / 75
                    entries[#entries + 1] =
                        { start = start, title = track_title or ("Chapter " .. (#entries + 1)) }
                end
                pos = e + 1
            end
            if #entries > 0 then
                return entries
            end
        end
    end
    return nil
end

local function parse_chpl(data)
    if #data < 9 then
        return {}
    end
    -- Version 1 has four reserved bytes before the count; version 0 has none.
    local base = data:byte(1) == 1 and 9 or 5
    local count = data:byte(base) or 0
    local chapters, pos = {}, base + 1
    for i = 1, count do
        if pos + 8 > #data then
            return {}
        end
        local high, low = be(data, pos, 4), be(data, pos + 4, 4)
        if high > 2147483647 then
            return {}
        end
        local start = (high * 4294967296 + low) / 10000000
        local length = data:byte(pos + 8)
        pos = pos + 9
        if not length or pos + length - 1 > #data then
            return {}
        end
        chapters[#chapters + 1] = { start = start, title = cap(data:sub(pos, pos + length - 1), 160) }
        pos = pos + length
    end
    return chapters
end

-- MP4/M4B chapters by walking box headers with seeks. The moov box of a
-- long audiobook holds megabytes of audio sample tables, so it is never
-- read whole: containers are descended header by header, and only small
-- leaf boxes that matter (chpl, tkhd, tref, mdhd and the chapter track's
-- sample tables) are read.
local MP4_CONTAINERS =
    { moov = true, trak = true, mdia = true, minf = true, stbl = true, udta = true, tref = true }
local MP4_TABLES = { stts = true, stsz = true, stco = true, co64 = true, stsc = true }

local function parse_mp4(path, size)
    if size > 2147483647 then
        return {}
    end
    local f = io.open(path, "rb")
    if not f then
        return {}
    end
    local total, steps = 0, 0
    local function read_at(at, len)
        if len < 0 or len > 65536 or at < 0 or at + len > size or total + len > 524288 then
            return nil
        end
        if not f:seek("set", at) then
            return nil
        end
        local data = f:read(len)
        if data then
            total = total + #data
        end
        return data
    end
    -- Box header at `at` within [at, limit): kind, payload start, box end.
    local function header(at, limit)
        local h = read_at(at, 8)
        if not h or #h < 8 then
            return nil
        end
        local len, kind, head = be(h, 1, 4), h:sub(5, 8), 8
        if len == 1 then
            local large = read_at(at + 8, 8)
            if not large or be(large, 1, 4) ~= 0 then
                return nil
            end
            len, head = be(large, 5, 4), 16
        elseif len == 0 then
            len = limit - at
        end
        if not len or len < head or at + len > limit then
            return nil
        end
        return kind, at + head, at + len
    end
    -- Visits the children of [first, last), calling visit(kind, payload, finish).
    local function walk(first, last, visit)
        local at = first
        while at + 8 <= last do
            steps = steps + 1
            if steps > 20000 then
                return
            end
            local kind, payload, finish = header(at, last)
            if not kind then
                return
            end
            visit(kind, payload, finish)
            at = finish
        end
    end
    local moov
    walk(0, size, function(kind, payload, finish)
        if kind == "moov" and not moov then
            moov = { payload, finish }
        end
    end)
    if not moov then
        f:close()
        return {}
    end
    local chpl, tracks, chap_refs = nil, {}, {}
    local function leaf(kind, payload, finish)
        return read_at(payload, math.min(finish - payload, 65536))
    end
    walk(moov[1], moov[2], function(kind, payload, finish)
        if kind == "udta" then
            walk(payload, finish, function(k, p, e)
                if k == "chpl" and not chpl then
                    chpl = leaf(k, p, e)
                end
            end)
        elseif kind == "trak" then
            local track = {}
            local function visit(k, p, e)
                if k == "stbl" then
                    -- Sample tables are read later, only for the chapter track.
                    track.stbl = { p, e }
                elseif MP4_CONTAINERS[k] then
                    walk(p, e, visit)
                elseif k == "tkhd" then
                    local data = leaf(k, p, e)
                    if data then
                        track.id = be(data, (data:byte(1) == 1) and 21 or 13, 4)
                    end
                elseif k == "chap" then
                    local data = leaf(k, p, e)
                    for q = 1, (data and #data or 0) - 3, 4 do
                        chap_refs[be(data, q, 4)] = true
                    end
                elseif k == "mdhd" then
                    local data = leaf(k, p, e)
                    if data then
                        track.scale = be(data, (data:byte(1) == 1) and 21 or 13, 4)
                    end
                end
            end
            walk(payload, finish, visit)
            tracks[#tracks + 1] = track
        end
    end)
    local chapters = {}
    if chpl and #chpl >= 9 then
        chapters = parse_chpl(chpl)
    end
    local target
    for _, track in ipairs(tracks) do
        if track.id and chap_refs[track.id] and track.stbl then
            target = track
            break
        end
    end
    if #chapters == 0 and target and target.scale and target.scale > 0 then
        local tables = {}
        walk(target.stbl[1], target.stbl[2], function(k, p, e)
            if MP4_TABLES[k] then
                tables[k] = leaf(k, p, e)
            end
        end)
        local sizes, durations, offsets, runs = {}, {}, {}, {}
        local stsz, stts, stsc = tables.stsz, tables.stts, tables.stsc
        local chunk_table, width = tables.stco or tables.co64, tables.stco and 4 or 8
        if stsz and #stsz >= 12 then
            local fixed, count = be(stsz, 5, 4), be(stsz, 9, 4)
            if count and count <= 1000 then
                for i = 1, count do
                    sizes[i] = (fixed and fixed > 0) and fixed or be(stsz, 9 + i * 4, 4)
                    if not sizes[i] then
                        sizes = {}
                        break
                    end
                end
            end
        end
        if stts and #stts >= 8 then
            local count, sample = be(stts, 5, 4) or 0, 1
            for i = 1, math.min(count, 1000) do
                local n, delta = be(stts, 9 + (i - 1) * 8, 4), be(stts, 13 + (i - 1) * 8, 4)
                if not n or not delta or sample + n > 1001 then
                    break
                end
                for _ = 1, n do
                    durations[sample] = delta
                    sample = sample + 1
                end
            end
        end
        if chunk_table and #chunk_table >= 8 then
            local count = be(chunk_table, 5, 4) or 0
            for i = 1, math.min(count, 1000) do
                local at = 9 + (i - 1) * width
                offsets[i] = width == 4 and be(chunk_table, at, 4)
                    or (be(chunk_table, at, 4) == 0 and be(chunk_table, at + 4, 4) or nil)
                if not offsets[i] then
                    break
                end
            end
        end
        if stsc and #stsc >= 8 then
            local count = be(stsc, 5, 4) or 0
            for i = 1, math.min(count, 1000) do
                local at = 9 + (i - 1) * 12
                runs[i] = { first = be(stsc, at, 4), each = be(stsc, at + 4, 4) }
                if not runs[i].first or not runs[i].each then
                    runs[i] = nil
                    break
                end
            end
        end
        if #sizes > 0 and #durations >= #sizes and #offsets > 0 and #runs > 0 then
            local sample, time, run = 1, 0, 1
            for chunk_index, chunk_offset in ipairs(offsets) do
                while runs[run + 1] and runs[run + 1].first <= chunk_index do
                    run = run + 1
                end
                local each = runs[run].each
                if each < 1 or each > 1000 then
                    break
                end
                local off = chunk_offset
                for _ = 1, each do
                    if sample > #sizes or #chapters >= 1000 then
                        break
                    end
                    local len_data = read_at(off, 2)
                    local len = len_data and be(len_data, 1, 2)
                    if len and len > 0 and len <= 4096 and len + 2 <= sizes[sample] then
                        local title = read_at(off + 2, len)
                        if title and #title == len then
                            chapters[#chapters + 1] = { start = time / target.scale, title = cap(title, 160) }
                        end
                    end
                    off = off + sizes[sample]
                    time = time + durations[sample]
                    sample = sample + 1
                end
                if sample > #sizes then
                    break
                end
            end
        end
    end
    f:close()
    table.sort(chapters, function(a, b)
        return a.start < b.start
    end)
    for i, c in ipairs(chapters) do
        if c.title == "" then
            c.title = "Chapter " .. i
        end
    end
    return chapters
end

local function chapter_list(book, file)
    local size = file_size(file.path)
    if size <= 0 or size > 2147483647 then
        return {}
    end
    local cache_key = book.key .. "\0" .. file.name .. "\0" .. size
    if chapter_cache[cache_key] then
        return chapter_cache[cache_key]
    end
    local ext = extension(file.name)
    local chapters = {}
    local ok = pcall(function()
        if ext == "mp3" then
            chapters = parse_id3(file.path, size)
        elseif ext == "m4b" or ext == "m4a" then
            chapters = parse_mp4(file.path, size)
        end
        local cue = parse_cue(file.path, book, file.path)
        if cue and #cue > 0 then
            chapters = cue
        end
    end)
    if not ok then
        chapters = {}
    end
    table.sort(chapters, function(a, b)
        return a.start < b.start
    end)
    local out = {}
    for i, c in ipairs(chapters) do
        if finite(c.start, 0, 10000000) then
            out[#out + 1] =
                { start = c.start, title = cap(c.title ~= "" and c.title or ("Chapter " .. i), 160) }
        end
    end
    -- Kept for the session only: parsing is cheap, and cached lists in the
    -- state file would crowd out progress in its bounded read.
    remember(chapter_cache, chapter_cache_order, CHAPTER_CACHE_FILES, cache_key, out)
    return out
end

local function current_for_book(book)
    local path = plugin.get_current_track_path()
    if not path then
        return nil
    end
    for _, f in ipairs(get_files(book)) do
        if f.path == path then
            return f
        end
    end
end

local function push_history(book, file, position)
    if not file or not finite(position, 0, 10000000) then
        return
    end
    local s = ensure_state(book.key)
    s.history[#s.history + 1] = { file = file.name, position = position }
    while #s.history > 5 do
        table.remove(s.history, 1)
    end
end

local function begin_seek(path, target, key, rel)
    target = math.max(0, math.floor(target or 0))
    pending_seek = { path = path, position = target, tries = 0, seeked = false, book_key = key, file = rel }
    last_seen = nil -- an older sample must not be checkpointed over this jump
end

-- True when the player's counters describe `path`: no resume seek or track
-- change is waiting to be confirmed for it.
local function counters_trusted(path)
    return not (pending_seek and pending_seek.path == path) and not (open_guard and open_guard.path == path)
end

-- The duration of `path` once the counters describe it, else nil.
local function trusted_duration(path)
    if not counters_trusted(path) then
        return nil
    end
    local duration = plugin.get_duration()
    return duration > 0 and duration or nil
end

-- The position of `path` as far as it can be trusted: a pending seek's
-- target, nothing while a track change is unconfirmed (the counters may
-- still be the previous track's), else the player's position.
local function trusted_position(path)
    if pending_seek and pending_seek.path == path then
        return pending_seek.position
    end
    if open_guard and open_guard.path == path then
        return nil
    end
    return plugin.get_position()
end

local function start_book(book, rel, position, record_jump)
    remember_book(book)
    local files = get_files(book)
    if #files == 0 then
        plugin.show_toast("No audio files in " .. cap(book.title, 100))
        return
    end
    local idx
    for i, f in ipairs(files) do
        if f.name == rel then
            idx = i
            break
        end
    end
    if not idx then
        -- A saved chapter file that is gone: its offset belongs to nothing.
        if rel and rel ~= "" then
            plugin.show_toast("Chapter file not found; starting from the beginning")
        end
        idx, position = 1, 0
    end
    local s = ensure_state(book.key)
    if record_jump then
        local current = current_for_book(book)
        if current then
            push_history(book, current, trusted_position(current.path))
        end
    end
    local target = files[idx].path
    -- Even a start at 0 goes through the pending seek: until it is
    -- confirmed, position and duration can still be the previous track's.
    begin_seek(target, position or 0, book.key, files[idx].name)
    -- The requested spot is the book's position until the seek confirms it.
    if s.file ~= files[idx].name then
        s.duration = 0
    end
    s.file, s.position, s.last_played = files[idx].name, math.max(0, position or 0), os.time()
    s.direct_only = book.direct_only == true
    if s.finished then
        s.finished = false
    end
    s.finished_manual = false
    state_dirty = true
    if not save_state() then
        plugin.show_toast("Playback started; state could not be saved")
    end
    if not warned_mode then
        local mode = plugin.get_play_mode()
        if mode == "shuffle" or mode == "repeat_one" then
            plugin.show_toast("Audiobooks play best in sequential mode")
            warned_mode = true
        end
    end
    plugin.play_list(
        (function()
            local p = {}
            for i, f in ipairs(files) do
                p[i] = f.path
            end
            return p
        end)(),
        idx
    )
end

local function resume_book(book)
    local s = ensure_state(book.key)
    local target = math.max(0, s.position or 0)
    if os.time() - (s.last_played or 0) > 60 then
        target = math.max(0, target - 15)
    end
    start_book(book, s.file, target, true)
end

local function book_progress(book)
    local s = state[book.key]
    if not s then
        return ""
    end
    if s.finished then
        return "Finished"
    end
    if s.file and s.file ~= "" then
        local position, duration = s.position or 0, s.duration or 0
        return duration > 0 and ("Current file: " .. math.floor(position / duration * 100) .. "%")
            or ("Current file position: " .. time_label(position))
    end
    return ""
end

local function book_list_label(book)
    local metadata = {}
    local author = book.author or ""
    if author ~= "" then metadata[#metadata + 1] = author end
    if book.series and book.series ~= "" then metadata[#metadata + 1] = book.series end
    local progress = book_progress(book)
    if progress ~= "" then metadata[#metadata + 1] = progress end
    return book.title .. (#metadata > 0 and ("\n" .. table.concat(metadata, " · ")) or "")
end

local function list_row(label, icon)
    local wrap = plugin.has_capability and plugin.has_capability("ui.list_wrap")
    return { label = cap(label, wrap and 511 or 159), icon = icon, wrap = wrap == true }
end

remember_book = function(book)
    local previous = book_by_key[book.key]
    if previous and (previous.dir ~= book.dir or previous.loose ~= book.loose
        or previous.direct_only ~= book.direct_only or previous.file_rel ~= book.file_rel) then
        file_cache[book.key], chapter_cache[book.key] = nil, nil
        for _, order in ipairs({ file_cache_order, chapter_cache_order }) do
            for i = #order, 1, -1 do
                if order[i] == book.key then table.remove(order, i) end
            end
        end
    end
    book_by_key[book.key] = book
    return book
end

local function folder_book(relative, direct_only)
    local parts = path_parts(relative)
    if not parts then
        return nil
    end
    local book = {
        key = relative,
        title = parts[#parts],
        author = #parts > 1 and parts[1] or "",
        dir = ROOT .. "/" .. relative,
        direct_only = direct_only == true,
    }
    if #parts >= 3 then
        book.series = parts[2]
    end
    return remember_book(book)
end

local function file_book(relative)
    if not valid_relative_path(relative) or not is_audio(relative) then
        return nil
    end
    local parts = path_parts(relative)
    local filename = parts[#parts]
    return remember_book({
        key = relative,
        file_rel = relative,
        title = filename:gsub("%.[^%.]+$", ""),
        author = #parts > 1 and parts[1] or "",
        dir = ROOT,
        loose = true,
        single = true,
    })
end

local function open_audiobooks_folder(folder)
    if not (plugin.has_capability and plugin.has_capability("ui.file_manager")) then
        plugin.show_toast("File Manager is not supported on this device")
        return
    end
    folder = folder or ROOT
    pcall(plugin.mkdir, ROOT)
    local ok, res, err = pcall(plugin.open_file_manager, folder)
    if not ok then
        plugin.show_toast("Could not open File Manager")
        return
    end
    if not res then
        plugin.show_toast(err or "Could not open folder in File Manager")
    end
end

local function split_group(title, group)
    if #group <= MAX_ROWS then
        local rows = {}
        for i, b in ipairs(group) do
            local label = book_list_label(b)
            rows[i] = list_row(label, cover_for(b))
        end
        plugin.show_list(title, rows, function(i)
            local chosen = group[i]
            if chosen then
                open_book(chosen)
            end
        end)
        return
    end
    local letters, keys = {}, {}
    for _, b in ipairs(group) do
        local first = b.title:sub(1, 1):upper()
        if not first:match("^[A-Z0-9]$") then
            first = "#"
        end
        if not letters[first] then
            letters[first] = {}
            keys[#keys + 1] = first
        end
        letters[first][#letters[first] + 1] = b
    end
    table.sort(keys)
    local page_groups, rows = {}, {}
    for _, key in ipairs(keys) do
        local group = letters[key]
        if #group <= MAX_ROWS then
            rows[#rows + 1] = list_row(key .. " (" .. #group .. ")", ICON_LIBRARY)
            page_groups[#page_groups + 1] = { title = title .. " / " .. key, books = group }
        else
            local part = 0
            for first = 1, #group, MAX_ROWS do
                part = part + 1
                local slice = {}
                for j = first, math.min(first + MAX_ROWS - 1, #group) do
                    slice[#slice + 1] = group[j]
                end
                rows[#rows + 1] = list_row(key .. " " .. part .. " (" .. #slice .. ")", ICON_LIBRARY)
                page_groups[#page_groups + 1] =
                    { title = title .. " / " .. key .. " " .. part, books = slice }
            end
        end
    end
    plugin.show_list(title, rows, function(i)
        local group = page_groups[i]
        if group then
            split_group(group.title, group.books)
        end
    end)
end

-- Keep these on plain-list screens: Home and Book controls already use the
-- two settings-screen slots. Numbered ranges also bound large author lists.
local function open_shelves(field, title)
    if not books then scan_library() end
    local groups, keys = {}, {}
    for _, book in ipairs(books) do
        local name = book[field] or ""
        if name ~= "" then
            local key = field == "series" and (book.author .. " / " .. name) or name
            if not groups[key] then groups[key] = {}; keys[#keys + 1] = key end
            groups[key][#groups[key] + 1] = book
        end
    end
    table.sort(keys, natural_less)
    if #keys == 0 then plugin.show_toast("No " .. title:lower() .. " folders found"); return end
    local shelves = {}
    for _, key in ipairs(keys) do
        local group = groups[key]
        for first = 1, #group, MAX_ROWS do
            local slice = {}
            for i = first, math.min(#group, first + MAX_ROWS - 1) do slice[#slice + 1] = group[i] end
            shelves[#shelves + 1] = { label = key .. (#group > MAX_ROWS and (" · part " .. math.ceil(first / MAX_ROWS)) or ""), books = slice }
        end
    end
    local function show_page(first)
        local rows, actions = {}, {}
        for i = first, math.min(#shelves, first + MAX_ROWS - 1) do
            local shelf = shelves[i]
            rows[#rows + 1] = list_row(shelf.label .. " (" .. #shelf.books .. ")", ICON_LIBRARY)
            actions[#actions + 1] = function() split_group(shelf.label, shelf.books) end
        end
        plugin.show_list(title, rows, function(i) if actions[i] then actions[i]() end end)
    end
    if #shelves <= MAX_ROWS then show_page(1); return end
    local rows, starts = {}, {}
    for first = 1, #shelves, MAX_ROWS do
        starts[#starts + 1] = first
        rows[#rows + 1] = list_row(shelves[first].label .. " to " .. shelves[math.min(#shelves, first + MAX_ROWS - 1)].label, ICON_LIBRARY)
    end
    plugin.show_list(title, rows, function(i) if starts[i] then show_page(starts[i]) end end)
end

local function group_for(kind)
    local out = {}
    for _, b in ipairs(books or {}) do
        local s = state[b.key]
        if kind == "progress" and s and not s.finished and s.file and s.file ~= "" then
            out[#out + 1] = b
        elseif kind == "new" and (not s or (not s.finished and (not s.file or s.file == ""))) then
            out[#out + 1] = b
        elseif kind == "finished" and s and s.finished then
            out[#out + 1] = b
        end
    end
    return out
end

local function book_from_saved_state(key, saved)
    if not valid_relative_path(key) or type(saved) ~= "table"
        or not valid_relative_path(saved.file) or not is_audio(saved.file) then
        return nil
    end
    if saved.file == key and is_audio(key) then
        return file_book(key)
    end
    -- New browser folders persist their flat-folder mode explicitly; older
    -- progress records default to the legacy bounded subfolder scan.
    return folder_book(key, saved.direct_only == true)
end

local function saved_file_exists(key, relative)
    -- Checking the saved track directly avoids scanning the library or even
    -- walking the book folder just to decide whether a Continue row is valid.
    local path = relative == key and is_audio(key)
        and (ROOT .. "/" .. relative) or (ROOT .. "/" .. key .. "/" .. relative)
    local ok, f = pcall(io.open, path, "rb")
    if not ok or not f then
        return false
    end
    f:close()
    return true
end

local function saved_progress_candidates()
    local out = {}
    -- Keep this metadata-only: the state reader caps it at 5000 records, and
    -- checking media availability is deferred to the small visible page.
    for key, saved in pairs(state) do
        if type(saved) == "table" and not saved.finished
            and type(saved.file) == "string" and saved.file ~= ""
            and valid_relative_path(key) and valid_relative_path(saved.file) and is_audio(saved.file) then
            out[#out + 1] = { key = key, saved = saved, last_played = tonumber(saved.last_played) or 0 }
        end
    end
    table.sort(out, function(a, b)
        if a.last_played ~= b.last_played then
            return a.last_played > b.last_played
        end
        return a.key < b.key
    end)
    return out
end

local function available_saved_book(candidate)
    if not candidate or not saved_file_exists(candidate.key, candidate.saved.file) then
        return nil
    end
    return book_from_saved_state(candidate.key, candidate.saved)
end

local function hydrate_saved_books()
    if saved_books_hydrated then
        return
    end
    for key, saved in pairs(state) do
        if not book_by_key[key] then
            book_from_saved_state(key, saved)
        end
    end
    saved_books_hydrated = true
end

local CONTINUE_PAGE_SIZE = 17

local function open_continue_list(page)
    local entries = saved_progress_candidates()
    local page_count = math.max(1, math.ceil(#entries / CONTINUE_PAGE_SIZE))
    page = math.max(1, math.min(page_count, math.floor(tonumber(page) or 1)))
    local first = (page - 1) * CONTINUE_PAGE_SIZE + 1
    local last = math.min(#entries, first + CONTINUE_PAGE_SIZE - 1)
    local rows = {}
    local settings_wrap = plugin.has_capability and plugin.has_capability("ui.settings_list_wrap")
    local function add_row(label, icon, action, wrap)
        local limit = wrap and settings_wrap and 511 or 95
        rows[#rows + 1] = {
            type = "row", label = cap(label, limit), icon = icon, text_size = "medium",
            wrap = wrap == true and settings_wrap == true, on_select = action,
        }
    end
    add_row("Continue listening · " .. #entries .. " saved books · " .. page .. "/" .. page_count,
        ICON_IN_PROGRESS, function() end, true)
    if page > 1 then
        add_row("Previous page", ICON_LIBRARY, function() open_continue_list(page - 1) end)
    end
    local available = 0
    for i = first, last do
        local candidate = entries[i]
        local book = available_saved_book(candidate)
        if book then
            available = available + 1
            local label = book_list_label(book)
            add_row(label, ICON_BOOK, function() resume_book(book) end, true)
        end
    end
    if page < page_count then
        add_row("Next page", ICON_LIBRARY, function() open_continue_list(page + 1) end)
    end
    if available == 0 then
        add_row("No available books on this page", ICON_BOOK, function() end)
    end
    plugin.show_settings_list("Continue listening", rows, { update = true })
end

local function open_library()
    local saved_books = saved_progress_candidates()
    local recent
    for i = 1, math.min(#saved_books, CONTINUE_PAGE_SIZE) do
        recent = available_saved_book(saved_books[i])
        if recent then break end
    end
    local rows = {}
    local settings_wrap = plugin.has_capability and plugin.has_capability("ui.settings_list_wrap")
    local function add_row(label, icon, action, wrap)
        local limit = (wrap and settings_wrap) and 511 or 159
        rows[#rows + 1] = {
            type = "row", label = cap(label, limit), icon = icon, text_size = "medium",
            wrap = wrap and settings_wrap == true or false, on_select = action,
        }
    end
    if recent then
        local continuation = {}
        local author = recent.author or ""
        if author ~= "" then continuation[#continuation + 1] = author end
        local progress = book_progress(recent)
        if progress ~= "" then continuation[#continuation + 1] = progress end
        local label = "Continue listening: " .. recent.title
            .. (#continuation > 0 and ("\n" .. table.concat(continuation, " · ")) or "")
        add_row(label, ICON_BOOK, function() resume_book(recent) end, true)
    end
    local continue_count = #saved_books
    if continue_count > 0 then
        add_row("Continue listening · " .. continue_count .. " saved books", ICON_IN_PROGRESS,
            function() open_continue_list(1) end)
    end
    add_row("Browse folders", ICON_LIBRARY, function() open_audiobooks_folder(ROOT) end)
    add_row("All audiobooks · scan library", ICON_LIBRARY, open_legacy_library)
    add_row("Authors", ICON_LIBRARY, function() open_shelves("author", "Authors") end)
    add_row("Series", ICON_LIBRARY, function() open_shelves("series", "Series") end)
    add_row("Settings", ICON_SETTINGS, open_settings)
    plugin.show_settings_list("Audiobooks", rows)
end

open_legacy_library = function()
    if not books then
        scan_library()
    end
    local rows = {}
    local settings_wrap = plugin.has_capability and plugin.has_capability("ui.settings_list_wrap")
    local function add_row(label, icon, action, wrap)
        local limit = (wrap and settings_wrap) and 511 or 159
        rows[#rows + 1] = {
            type = "row", label = cap(label, limit), icon = icon, text_size = "medium",
            wrap = wrap and settings_wrap == true or false, on_select = action,
        }
    end
    local saved_progress = saved_progress_candidates()
    local recent
    for i = 1, math.min(#saved_progress, CONTINUE_PAGE_SIZE) do
        recent = available_saved_book(saved_progress[i])
        if recent then break end
    end
    if recent then
        local continuation = {}
        local author = recent.author or ""
        if author ~= "" then continuation[#continuation + 1] = author end
        local progress = book_progress(recent)
        if progress ~= "" then continuation[#continuation + 1] = progress end
        local label = "Continue listening: " .. recent.title
            .. (#continuation > 0 and ("\n" .. table.concat(continuation, " · ")) or "")
        add_row(label, cover_for(recent), function() resume_book(recent) end, true)
    end
    local continue_count = #saved_progress
    if continue_count > 0 then
        add_row("Continue listening · " .. continue_count .. " saved books", ICON_IN_PROGRESS,
            function() open_continue_list(1) end)
    end
    add_row("Browse folders", ICON_LIBRARY, function() open_audiobooks_folder(ROOT) end)
    add_row("All audiobooks (" .. #books .. ")", ICON_LIBRARY, function()
        split_group("All audiobooks", books)
    end)
    add_row("Authors", ICON_LIBRARY, function() open_shelves("author", "Authors") end)
    add_row("Series", ICON_LIBRARY, function() open_shelves("series", "Series") end)
    add_row("Settings", ICON_SETTINGS, open_settings)
    for _, spec in ipairs({
        { "In progress", "progress", ICON_IN_PROGRESS },
        { "Not started", "new", ICON_NEW },
        { "Finished", "finished", ICON_FINISHED },
    }) do
        local group = group_for(spec[2])
        if #group > 0 then
            add_row(spec[1] .. " (" .. #group .. ")", spec[3], function()
                split_group(spec[1], group_for(spec[2]))
            end)
        end
    end
    if #books == 0 then
        plugin.show_toast("Add files to Audiobooks on your SD card, then refresh.")
    end
    add_row("Refresh library", ICON_REFRESH, function()
        books, file_cache, chapter_cache = nil, {}, {}
        file_cache_order, chapter_cache_order = {}, {}
        scan_library()
        if #books == 0 then
            plugin.show_toast("Add files to Audiobooks on your SD card, then refresh.")
        else
            plugin.show_toast("Library refreshed.")
        end
        open_legacy_library()
    end)
    plugin.show_settings_list("Audiobooks", rows, { update = true })
end

local function chapters_for_book(book)
    local files, all = get_files(book), {}
    if #files == 1 then
        local chapters = chapter_list(book, files[1])
        if #chapters > 0 then
            for i, c in ipairs(chapters) do
                all[#all + 1] = { file = files[1], name = c.title, start = c.start, chapter_index = i }
            end
            return all, true
        end
    end
    for _, f in ipairs(files) do
        all[#all + 1] = { file = f, name = f.name, start = 0 }
    end
    return all, false
end

local function open_chapters(book)
    local chapters, embedded = chapters_for_book(book)
    if #chapters == 0 then
        plugin.show_toast("No chapters found")
        return
    end
    local current = current_for_book(book)
    -- The chapter holding the playback position: the last one starting at or
    -- before it.
    local playing_index
    if current and embedded then
        local position = plugin.get_position()
        for i, c in ipairs(chapters) do
            if c.start <= position + 0.5 then
                playing_index = i
            end
        end
    end
    local function play_chapter(c)
        -- Playback may have changed since the list was built.
        local now = current_for_book(book)
        local loaded = now and (plugin.is_playing() or plugin.is_paused())
        if embedded and loaded and now.path == c.file.path then
            push_history(book, now, trusted_position(now.path))
            -- An explicit chapter start reopens a finished book, as start_book does.
            local st = ensure_state(book.key)
            st.finished, st.finished_manual = false, false
            if not save_state() then
                plugin.show_toast("Position history could not be saved")
            end
            begin_seek(c.file.path, c.start, book.key, c.file.name)
            plugin.seek(c.start)
            -- Choosing a chapter means listening to it, as starting a file does.
            if plugin.is_paused() then
                plugin.toggle_pause()
            end
        else
            start_book(book, c.file.name, c.start, true)
        end
    end
    local function show_range(first, last, title)
        local rows = {}
        for i = first, last do
            local c = chapters[i]
            local playing = current and current.path == c.file.path and ((not embedded) or i == playing_index)
            rows[#rows + 1] = list_row(
                (playing and "> " or "") .. c.name .. (embedded and ("  " .. time_label(c.start)) or ""),
                ICON_CHAPTERS
            )
        end
        plugin.show_list(title, rows, function(i)
            local c = chapters[first + i - 1]
            if c and first + i - 1 <= last then
                play_chapter(c)
            end
        end)
    end
    if #chapters <= MAX_ROWS then
        show_range(1, #chapters, "Chapters")
        return
    end
    local parts = {}
    for first = 1, #chapters, MAX_ROWS do
        parts[#parts + 1] = { first, math.min(first + MAX_ROWS - 1, #chapters) }
    end
    local labels = {}
    for i, part in ipairs(parts) do
        labels[i] = list_row("Chapters " .. part[1] .. "-" .. part[2], ICON_CHAPTERS)
    end
    plugin.show_list("Chapters", labels, function(i)
        local part = parts[i]
        if part then
            show_range(part[1], part[2], labels[i].label)
        end
    end)
end

local function bookmark_index(book, id)
    for i, b in ipairs(ensure_state(book.key).bookmarks) do
        if b.id == id then
            return i, b
        end
    end
end

local function add_bookmark(book)
    local file = current_for_book(book)
    local pos
    if file then
        pos = trusted_position(file.path)
        if not pos then
            plugin.show_toast("The file is still opening; try again")
            return
        end
    else
        local saved = ensure_state(book.key)
        if saved.file then
            for _, candidate in ipairs(get_files(book)) do
                if candidate.name == saved.file then
                    file, pos = candidate, saved.position or 0
                    break
                end
            end
        end
    end
    if not file then
        plugin.show_toast("Play this book before adding a bookmark")
        return
    end
    local s = ensure_state(book.key)
    bookmark_serial = bookmark_serial + 1
    s.bookmarks[#s.bookmarks + 1] = { file = file.name, position = pos, note = "", id = bookmark_serial }
    while #s.bookmarks > 50 do
        table.remove(s.bookmarks, 1)
    end
    if not save_state() then
        plugin.show_toast("Bookmark could not be saved")
    end
    local new_id = bookmark_serial
    local function store(note)
        -- By identity: the new bookmark may have been trimmed by the size
        -- limit, and another one can share its file and position.
        local _, target = bookmark_index(book, new_id)
        if not target then
            plugin.show_toast("That bookmark could not be kept")
            return
        end
        target.note = cap(note, 120)
        if not save_state() then
            plugin.show_toast("Bookmark note could not be saved")
        else
            plugin.show_toast("Bookmark added")
        end
    end
    local opened = plugin.show_text_input("Bookmark note (optional)", nil, false, function(note)
        store(note)
    end)
    if opened == false then
        plugin.show_toast("Text input busy")
    end
    -- The empty bookmark is already durable if Back closes the singleton keypad.
end

local function open_bookmarks(book)
    local marks = ensure_state(book.key).bookmarks
    if #marks == 0 then
        plugin.show_toast("No bookmarks")
        return
    end
    local rows, ids = {}, {}
    for i = #marks, 1, -1 do
        local b = marks[i]
        if not b.id then
            bookmark_serial = bookmark_serial + 1
            b.id = bookmark_serial
        end
        rows[#rows + 1] = list_row(((b.note ~= "" and b.note) or b.file) .. " @ " .. time_label(b.position), ICON_BOOKMARK)
        ids[#ids + 1] = b.id
    end
    plugin.show_list("Bookmarks", rows, function(index)
        local id = ids[index]
        if not id or not bookmark_index(book, id) then
            plugin.show_toast("That bookmark is gone")
            return
        end
        plugin.show_list("Bookmark", { list_row("Play from here", ICON_PLAY), list_row("Delete", ICON_BOOKMARK) }, function(action)
            local at, current = bookmark_index(book, id)
            if not at then
                plugin.show_toast("That bookmark is gone")
                return
            end
            if action == 1 then
                start_book(book, current.file, current.position, true)
            else
                table.remove(ensure_state(book.key).bookmarks, at)
                if save_state() then
                    plugin.show_toast("Bookmark deleted")
                else
                    plugin.show_toast("Could not save bookmark deletion")
                end
            end
        end)
    end)
end

local function undo_jump(book)
    local s = ensure_state(book.key)
    local h = table.remove(s.history)
    if not h then
        return
    end
    local path = path_for(book, h.file)
    if path then
        start_book(book, h.file, h.position, false)
    elseif not save_state() then
        plugin.show_toast("Position history could not be saved")
    end
end

local function sleep_menu(book)
    local choices = { "15 minutes", "30 minutes", "45 minutes", "60 minutes", "90 minutes", "End of this chapter", "Off" }
    local choice_rows = {}
    for i, label in ipairs(choices) do
        choice_rows[i] = list_row(label, i == 6 and ICON_CHAPTERS or ICON_SLEEP)
    end
    plugin.show_list("Sleep timer", choice_rows, function(i)
        sleep_book, sleep_timer, sleep_chapter, sleep_pause = book.key, nil, nil, nil
        if i <= 5 then
            sleep_timer = { remaining = ({ 900, 1800, 2700, 3600, 5400 })[i] }
        elseif i == 6 then
            local file = current_for_book(book)
            if file then
                local files = get_files(book)
                local index
                for j, f in ipairs(files) do
                    if f.path == file.path then
                        index = j
                    end
                end
                if index and #files > 1 then
                    sleep_chapter = { file = file.path, multi = true }
                else
                    local chapters = chapter_list(book, file)
                    local position = counters_trusted(file.path) and plugin.get_position() or nil
                    if not position then
                        plugin.show_toast("The file is still opening; try again")
                        sleep_book = nil
                        return
                    end
                    for j, c in ipairs(chapters) do
                        if
                            c.start <= position and (not chapters[j + 1] or chapters[j + 1].start > position)
                        then
                            local ending = chapters[j + 1] and chapters[j + 1].start
                                or trusted_duration(file.path)
                                or 0
                            sleep_chapter = { file = file.path, end_at = ending > 0 and ending or nil }
                            break
                        end
                    end
                    if not sleep_chapter then
                        local duration = trusted_duration(file.path)
                        if duration then
                            sleep_chapter = { file = file.path, end_at = duration }
                        end
                    end
                end
            end
        end
        plugin.show_toast("Sleep timer: " .. choices[i])
    end)
end

open_book = function(book)
    remember_book(book)
    local s = ensure_state(book.key)
    local rows = {}
    local settings_wrap = plugin.has_capability and plugin.has_capability("ui.settings_list_wrap")
    local function add_row(label, icon, action, wrap)
        rows[#rows + 1] = {
            type = "row", label = cap(label, wrap and settings_wrap and 511 or 159),
            icon = icon, text_size = "medium", wrap = wrap and settings_wrap == true or false, on_select = action,
        }
    end
    local heading = book.title .. (book.author ~= "" and ("\n" .. book.author) or "")
    add_row("Open folder in File Manager", ICON_LIBRARY, function()
        open_audiobooks_folder(book.dir or ROOT)
    end)
    add_row(heading, cover_for(book), function() end, true)
    if book.initial_file then
        add_row("Play selected file", ICON_PLAY, function()
            local files = get_files(book)
            for _, file in ipairs(files) do
                if file.name == book.initial_file then
                    start_book(book, book.initial_file, 0, true)
                    return
                end
            end
            plugin.show_toast("Selected file is no longer available")
        end)
    end
    local can_resume = s.file and s.file ~= "" and not s.finished
    add_row(can_resume and "Resume listening" or "Start listening", ICON_PLAY, function()
        local current = ensure_state(book.key)
        if current.finished then
            local files = get_files(book)
            if files[1] then start_book(book, files[1].name, 0, false) end
        elseif current.file and current.file ~= "" then
            resume_book(book)
        else
            local files = get_files(book)
            local first = book.initial_file
            local found = false
            if first then
                for _, file in ipairs(files) do
                    if file.name == first then found = true break end
                end
            end
            start_book(book, found and first or (files[1] and files[1].name), 0, false)
        end
    end)
    local loaded = current_for_book(book) ~= nil and (plugin.is_playing() or plugin.is_paused())
    if loaded then
        add_row("Play / Pause", ICON_PLAY, function()
            if current_for_book(book) then plugin.toggle_pause() end
        end)
    end
    add_row("Chapters", ICON_CHAPTERS, function() open_chapters(book) end)
    add_row("Add bookmark", ICON_BOOKMARK, function() add_bookmark(book) end)
    add_row("Bookmarks", ICON_BOOKMARKS, function() open_bookmarks(book) end)
    if #s.history > 0 then
        add_row("Return to previous position", ICON_HISTORY, function()
            if #ensure_state(book.key).history > 0 then undo_jump(book) end
        end)
    end
    add_row("Sleep timer", ICON_SLEEP, function() sleep_menu(book) end)
    rows[#rows + 1] = {
        type = "toggle", label = "Mark as finished", value = s.finished == true,
        icon = ICON_FINISHED, text_size = "medium", on_change = function(value)
            local now = ensure_state(book.key)
            now.finished, now.finished_manual = value == true, true
            if not save_state() then plugin.show_toast("Finished state could not be saved") end
        end,
    }
    plugin.show_settings_list("Book controls", rows)
end

local function service_seek()
    if not pending_seek then
        return
    end
    local q = pending_seek
    q.tries = q.tries + 1
    if q.tries > 15 then
        pending_seek = nil
        return
    end
    if plugin.get_current_track_path() ~= q.path or plugin.get_duration() <= 0 then
        return
    end
    local position = plugin.get_position()
    if q.seeked and position >= q.position - 3 and position <= q.position + 30 then
        pending_seek = nil
        last_saved_position = -1
        if q.book_key and q.file then
            local s = ensure_state(q.book_key)
            s.file, s.position, s.duration, s.last_played = q.file, position, plugin.get_duration(), os.time()
            if not save_state() then
                plugin.show_toast("Resume position could not be saved")
            end
        end
        state_dirty = true
        return
    end
    plugin.seek(q.position)
    q.seeked = true
end

-- The book and file a playing path belongs to, or nil.
local function book_for_path(path)
    if not path or path:sub(1, #ROOT + 1) ~= ROOT .. "/" then
        return nil
    end
    local function match(book)
        if book.loose then
            local file_path = book.file_rel and (ROOT .. "/" .. book.file_rel) or (ROOT .. "/" .. book.key)
            if path == file_path then
                return { name = book.file_rel or book.key, path = path }, #file_path
            end
            return nil
        end
        local prefix = book.dir .. "/"
        if path:sub(1, #prefix) == prefix then
            local rel = path:sub(#prefix + 1)
            if valid_relative_path(rel) and is_audio(rel)
                and (not book.direct_only or not rel:find("/", 1, true)) then
                return { name = rel, path = path }, #prefix
            end
        end
    end

    hydrate_saved_books()
    -- An explicitly opened legacy collection owns its entire queue. A deeper
    -- shelf book must not silently steal that collection's progress/bookmarks.
    local active = active_book_key and book_by_key[active_book_key]
    if active then
        local file = match(active)
        if file then return active, file end
    end
    local best_book, best_file, best_length
    for _, book in pairs(book_by_key) do
        local file, length = match(book)
        if file and (not best_length or length > best_length) then
            best_book, best_file, best_length = book, file, length
        end
    end
    if best_book then
        return best_book, best_file
    end

    -- If not yet in book_by_key (e.g. played via native File Manager without
    -- prior library scan or saved state), derive the book from the file path.
    local rel = path:sub(#ROOT + 2)
    if valid_relative_path(rel) and is_audio(rel) then
        local parts = path_parts(rel)
        if parts then
            if #parts == 1 then
                best_book = file_book(rel)
                if best_book then
                    best_file = { name = rel, path = path }
                end
            else
                local parent_idx = #parts - 1
                if parent_idx > 1 and is_disc_name(parts[parent_idx]) then
                    parent_idx = parent_idx - 1
                end
                local book_rel = table.concat(parts, "/", 1, parent_idx)
                best_book = folder_book(book_rel, false)
                if best_book then
                    local prefix = best_book.dir .. "/"
                    if path:sub(1, #prefix) == prefix then
                        local file_rel = path:sub(#prefix + 1)
                        if valid_relative_path(file_rel) and is_audio(file_rel) then
                            best_file = { name = file_rel, path = path }
                        end
                    end
                end
            end
        end
    end
    return best_book, best_file
end

-- Stores a position for the book file; marks the book finished near the end
-- of its last file unless the user set the flag by hand.
local function record_position(book, file, pos, dur, terminal)
    local s = ensure_state(book.key)
    s.file, s.position, s.duration, s.last_played = file.name, pos, dur, os.time()
    if not s.finished and not s.finished_manual then
        local files = get_files(book, true)
        if
            files[#files]
            and files[#files].path == file.path
            and dur > 0
            and terminal ~= "manual_stop"
            and terminal ~= "paused"
            and (terminal == "natural_eof"
                or (terminal == nil and ((dur > 30 and pos >= dur - 30) or pos / dur >= 0.97)))
        then
            s.finished = true
        end
    end
    last_saved_position = pos
    state_dirty = true
    save_state()
end

local function flush_terminal(book, file, pos, dur, terminal)
    local previous = last_terminal_flush
    if previous and previous.path == file.path and previous.terminal == terminal
        and previous.pos == pos and previous.dur == dur then
        return
    end
    last_terminal_flush = { path = file.path, terminal = terminal, pos = pos, dur = dur }
    record_position(book, file, pos, dur, terminal)
end

local function progress_save(force, terminal_override)
    local path = plugin.get_current_track_path()
    local book, file = book_for_path(path)
    if force and not book and not path and last_seen then
        path, book, file = last_seen.file.path, last_seen.book, last_seen.file
    end
    if not book or (pending_seek and pending_seek.path == path) then
        return
    end
    -- Independent legacy getters can still describe the old track after a
    -- change. A coherent exact-path snapshot already carries that guarantee.
    local has_progress = plugin.has_capability and plugin.has_capability("playback.progress")
    if not has_progress and open_guard and open_guard.path == path then
        return
    end
    local pos, dur, terminal
    if has_progress then
        local ok, sample = pcall(plugin.get_playback_progress, path)
        if ok and type(sample) == "table" and finite(sample.position, 0, 10000000)
            and finite(sample.duration, 0, 10000000) and sample.duration > 0 then
            pos, dur, terminal = sample.position, sample.duration, sample.terminal
            if terminal ~= "active" and terminal ~= "natural_eof" and terminal ~= "manual_stop" then
                return
            end
            if force and sample.terminal == "active" and (sample.paused or terminal_override) then
                terminal = terminal_override or "paused"
            end
            if not force and (not sample.playing or sample.paused or terminal ~= "active") then
                return
            end
        elseif force and last_seen and (not path or path == last_seen.file.path) then
            -- A pause/stop may race the terminal snapshot. Only the last
            -- coherent active sample for this same path is safe to flush.
            pos, dur, terminal = last_seen.pos, last_seen.dur, "manual_stop"
            book, file = last_seen.book, last_seen.file
        else
            return
        end
    else
        if not force and (not plugin.is_playing() or plugin.is_paused()) then
            return
        end
        pos, dur = plugin.get_position(), plugin.get_duration()
        terminal = terminal_override
    end
    if not finite(pos, 0, 10000000) or not finite(dur, 0, 10000000) then
        return
    end
    if not force and math.abs(pos - last_saved_position) < 1 then
        return
    end
    if terminal == "manual_stop" then
        flush_terminal(book, file, pos, dur, terminal)
    else
        record_position(book, file, pos, dur, terminal)
    end
end

local function matches_previous_track(path, previous, pos, dur)
    return previous and previous.file.path ~= path
        and finite(pos, 0, 10000000) and finite(dur, 0, 10000000)
        and math.abs(pos - previous.pos) < 1.5
        and math.abs(dur - previous.dur) < 1.5
end

-- The firmware sends no "stopped" at the natural end of a queue: the last
-- position seen while playing is checkpointed when playback goes idle.
local function track_playback()
    local path = plugin.get_current_track_path()
    if plugin.has_capability and plugin.has_capability("playback.progress") then
        if not path then
            if last_seen then
                record_position(last_seen.book, last_seen.file, last_seen.pos, last_seen.dur, "manual_stop")
                last_seen, idle_flush_pending = nil, nil
            end
            return
        end
        if pending_seek and pending_seek.path == path then return end
        local ok, sample = pcall(plugin.get_playback_progress, path)
        if not ok or type(sample) ~= "table"
            or not finite(sample.position, 0, 10000000)
            or not finite(sample.duration, 0, 10000000) or sample.duration <= 0 then
            return
        end
        local book, file = book_for_path(path)
        if not book or not file then return end
        if sample.terminal == "active" then
            if sample.playing and not sample.paused then
                last_terminal_flush = nil
                last_seen = { book = book, file = file, pos = sample.position, dur = sample.duration }
            elseif sample.paused or not sample.playing then
                flush_terminal(book, file, sample.position, sample.duration, "paused")
            end
        elseif sample.terminal == "natural_eof" or sample.terminal == "manual_stop" then
            flush_terminal(book, file, sample.position, sample.duration, sample.terminal)
            last_seen, idle_flush_pending = nil, nil
        end
        return
    end

    local playing = plugin.is_playing()
    local paused = plugin.is_paused()
    if playing and not paused then
        local guarded = (pending_seek and pending_seek.path == path)
            or (open_guard and open_guard.path == path)
        local book, file = book_for_path(path)
        if book and not guarded then
            local pos, dur = plugin.get_position(), plugin.get_duration()
            if finite(pos, 0, 10000000) and finite(dur, 0, 10000000) then
                last_seen = { book = book, file = file, pos = pos, dur = dur }
            end
        end
    elseif not playing and not paused then
        local path = plugin.get_current_track_path()
        local pending = idle_flush_pending
        if pending and path == pending.path and counters_trusted(path) then
            local pos, dur = plugin.get_position(), plugin.get_duration()
            if finite(pos, 0, 10000000) and finite(dur, 0, 10000000) and dur > 0
                and not matches_previous_track(path, pending.previous_seen, pos, dur) then
                record_position(pending.book, pending.file, pos, dur)
                idle_flush_pending = nil
                last_seen = nil
                return
            end
        end
        local seen = last_seen
        if seen and (path == nil or path == seen.file.path) then
            record_position(seen.book, seen.file, seen.pos, seen.dur)
            last_seen = nil
            idle_flush_pending = nil
        elseif pending and path ~= pending.path then
            idle_flush_pending = nil
        end
    end
end

-- Confirms a track change once the counters describe the new track.
local function service_open_guard()
    if not open_guard then
        return
    end
    open_guard.tries = open_guard.tries + 1
    if open_guard.tries > 15 or plugin.get_current_track_path() ~= open_guard.path then
        open_guard = nil
        return
    end
    if plugin.has_capability and plugin.has_capability("playback.progress") then
        local ok, sample = pcall(plugin.get_playback_progress, open_guard.path)
        if ok and type(sample) == "table" and sample.terminal then
            open_guard = nil
            last_saved_position = -1
        end
        return
    end
    local position, duration = plugin.get_position(), plugin.get_duration()
    -- The track-start notification can precede the audio thread's counter
    -- update. If the values still match the last sample from a different
    -- file, keep waiting instead of saving that old position under this path.
    local same_as_previous = matches_previous_track(open_guard.path, open_guard.previous_seen, position, duration)
    if open_guard.tries >= 2 and duration > 0 and position <= 30 and not same_as_previous then
        open_guard = nil
        last_saved_position = -1
    end
end

local function service_playback_speed()
    if not speed_retry_pending then return end
    if not speed_supported() then return end
    local path = current_audiobook_path()
    if not path then return end
    if speed_waiting_for_resume(path) then return end
    speed_retry_pending = not apply_speed(playback_speed)
end

local function handle_sleep_tick()
    if not sleep_book then
        return
    end
    if not plugin.get_current_track_path() or (not plugin.is_playing() and not plugin.is_paused()) then
        sleep_book, sleep_timer, sleep_chapter = nil, nil, nil
        return
    end
    if sleep_timer then
        sleep_timer.remaining = sleep_timer.remaining - 1
        if sleep_timer.remaining <= 0 then
            sleep_book, sleep_timer = nil, nil
            plugin.stop()
        end
    elseif sleep_chapter then
        local path = plugin.get_current_track_path()
        local book = book_by_key[sleep_book]
        local different_in_book = sleep_chapter.multi
            and path
            and path ~= sleep_chapter.file
            and book
            and (
                (book.loose and path == ROOT .. "/" .. book.key)
                or (not book.loose and path:sub(1, #book.dir + 1) == book.dir .. "/")
            )
        if different_in_book then
            sleep_pause = { tries = 0, path = path }
            sleep_book, sleep_chapter = nil, nil
        elseif
            sleep_chapter.end_at
            and path == sleep_chapter.file
            and counters_trusted(path)
            and (
                plugin.get_position() >= sleep_chapter.end_at
                or (
                    sleep_chapter.last_pos
                    and sleep_chapter.last_pos >= sleep_chapter.end_at - 10
                    and plugin.get_position() + 5 < sleep_chapter.last_pos
                )
            )
        then
            if plugin.is_playing() and not plugin.is_paused() then
                plugin.toggle_pause()
            end
            sleep_book, sleep_chapter = nil, nil
        end
        -- The last trusted position, so a Repeat restart of the same file
        -- after the chapter end is recognised.
        if sleep_chapter and path == sleep_chapter.file and counters_trusted(path) then
            sleep_chapter.last_pos = plugin.get_position()
        end
    end
end

local function handle_track_started()
    last_terminal_flush = nil
    speed_retry_pending = true
    local previous_seen = last_seen
    last_saved_position = -1
    last_seen = nil
    local started = plugin.get_current_track_path()
    -- A pause meant for another track never applies to this one.
    if sleep_pause and sleep_pause.path ~= started then
        sleep_pause = nil
    end
    local path = plugin.get_current_track_path()
    if pending_seek and pending_seek.path == path and pending_seek.book_key then
        active_book_key = pending_seek.book_key
    elseif not path or path:sub(1, #ROOT + 1) ~= ROOT .. "/" then
        active_book_key = nil
    end
    if pending_seek and pending_seek.path ~= path then
        pending_seek = nil
    end
    local book = sleep_book and book_by_key[sleep_book]
    local in_sleep_book = book
        and path
        and (
            (book.loose and path == ROOT .. "/" .. book.key)
            or (not book.loose and path:sub(1, #book.dir + 1) == book.dir .. "/")
        )
    if sleep_book and not in_sleep_book then
        sleep_book, sleep_timer, sleep_chapter = nil, nil, nil
    end
    local different_in_book = sleep_chapter
        and sleep_chapter.multi
        and book
        and path
        and path ~= sleep_chapter.file
        and (
            (book.loose and path == ROOT .. "/" .. book.key)
            or (not book.loose and path:sub(1, #book.dir + 1) == book.dir .. "/")
        )
    -- A single-file book restarted by Repeat: the same path starts again
    -- after the chapter end was reached.
    local wrapped = sleep_chapter
        and sleep_chapter.end_at
        and path == sleep_chapter.file
        and (sleep_chapter.last_pos or 0) >= sleep_chapter.end_at - 10
    if different_in_book or wrapped then
        -- The next file may not be playing yet; the tick pauses it once it is.
        sleep_pause = { tries = 0, path = path }
        sleep_book, sleep_chapter = nil, nil
    end
    -- Track position/duration may still describe the previous file here.
    local ours, file = book_for_path(path)
    if ours and file and not (pending_seek and pending_seek.path == path) then
        open_guard = { path = path, tries = 0, previous_seen = previous_seen }
        idle_flush_pending = { path = path, book = ours, file = file, previous_seen = previous_seen }
    else
        open_guard = nil
        idle_flush_pending = nil
    end
    if path and current_audiobook_path() == path and speed_retry_pending and not speed_waiting_for_resume(path) then
        speed_retry_pending = not apply_speed(playback_speed)
    end
end

local function service_sleep_pause()
    if not sleep_pause then
        return
    end
    sleep_pause.tries = sleep_pause.tries + 1
    if plugin.get_current_track_path() ~= sleep_pause.path then
        sleep_pause = nil
    elseif plugin.is_playing() and not plugin.is_paused() then
        plugin.toggle_pause()
        sleep_pause = nil
    elseif plugin.is_paused() or sleep_pause.tries > 10 then
        sleep_pause = nil
    end
end

ensure_root()
read_settings()
set_transport_skip(skip_by_30)
if not read_state_file(STATE_PATH, false) then
    if read_state_file(OLD_STATE_PATH, true) then
        state_dirty = true
        save_state()
    end
end
speed_retry_pending = true

plugin.on("track_started", handle_track_started)
plugin.on("paused", function()
    progress_save(true, "paused")
    last_seen = nil
end)
plugin.on("stopped", function()
    idle_flush_pending = nil
    progress_save(true, "manual_stop")
    active_book_key = nil
    last_seen = nil
    sleep_pause = nil
    sleep_book, sleep_timer, sleep_chapter = nil, nil, nil
end)
plugin.set_interval(1, function()
    ticks = ticks + 1
    service_covers()
    service_seek()
    service_open_guard()
    service_playback_speed()
    service_sleep_pause()
    handle_sleep_tick()
    track_playback()
    if ticks % 10 == 0 then
        progress_save(false)
        if state_dirty then
            save_state()
        end
    end
end)

plugin.register_list_item("books", "Audiobooks", open_library, { icon = ICON_BOOK })
