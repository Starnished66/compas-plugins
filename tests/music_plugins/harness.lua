-- Host-side mock of the Compás plugin API for loading plugins_examples/*.lua.
-- Not shipped to the device.

local harness = {}

local function json_error(msg, i)
    error(msg .. " at " .. tostring(i), 2)
end

local function decode_json(text)
    if type(text) ~= "string" then return nil, "not a string" end
    local i = 1
    local n = #text
    local parse_value

    local function skip()
        while i <= n and text:sub(i, i):match("%s") do i = i + 1 end
    end

    local function parse_string()
        if text:sub(i, i) ~= '"' then json_error("string", i) end
        i = i + 1
        local out = {}
        while i <= n do
            local c = text:sub(i, i)
            if c == '"' then
                i = i + 1
                return table.concat(out)
            elseif c == "\\" then
                local e = text:sub(i + 1, i + 1)
                local map = { ['"'] = '"', ["\\"] = "\\", ["/"] = "/", b = "\b", f = "\f", n = "\n", r = "\r", t = "\t" }
                if e == "u" then
                    local hex = text:sub(i + 2, i + 5)
                    out[#out + 1] = utf8.char(tonumber(hex, 16) or 0)
                    i = i + 6
                else
                    out[#out + 1] = map[e] or e
                    i = i + 2
                end
            else
                out[#out + 1] = c
                i = i + 1
            end
        end
        json_error("unterminated string", i)
    end

    local function parse_number()
        local s, e = text:find("^-?%d+%.?%d*[eE]?[%+%-]?%d*", i)
        if not s then json_error("number", i) end
        local num = tonumber(text:sub(s, e))
        i = e + 1
        return num
    end

    local function parse_array()
        i = i + 1
        local arr = {}
        skip()
        if text:sub(i, i) == "]" then i = i + 1 return arr end
        while true do
            arr[#arr + 1] = parse_value()
            skip()
            local c = text:sub(i, i)
            if c == "]" then i = i + 1 return arr end
            if c ~= "," then json_error("array", i) end
            i = i + 1
            skip()
        end
    end

    local function parse_object()
        i = i + 1
        local obj = {}
        skip()
        if text:sub(i, i) == "}" then i = i + 1 return obj end
        while true do
            skip()
            local key = parse_string()
            skip()
            if text:sub(i, i) ~= ":" then json_error("colon", i) end
            i = i + 1
            obj[key] = parse_value()
            skip()
            local c = text:sub(i, i)
            if c == "}" then i = i + 1 return obj end
            if c ~= "," then json_error("object", i) end
            i = i + 1
        end
    end

    parse_value = function()
        skip()
        local c = text:sub(i, i)
        if c == '"' then return parse_string() end
        if c == "{" then return parse_object() end
        if c == "[" then return parse_array() end
        if c == "t" and text:sub(i, i + 3) == "true" then i = i + 4 return true end
        if c == "f" and text:sub(i, i + 4) == "false" then i = i + 5 return false end
        if c == "n" and text:sub(i, i + 3) == "null" then i = i + 4 return nil end
        if c == "-" or c:match("%d") then return parse_number() end
        json_error("value", i)
    end

    local ok, value = pcall(parse_value)
    if not ok then return nil, value end
    return value
end

function harness.new(opts)
    opts = opts or {}
    local sd = opts.sd_root
    local self = {
        sd_root_path = sd,
        toasts = {},
        toast_durations = {},
        progress_cards = {},
        progress_events = {},
        active_progress = nil,
        next_progress_handle = 1,
        download_progress = {},
        active_downloads = {},
        http_calls = {},
        json_decode_calls = {},
        downloads = {},
        play_lists = {},
        events = {},
        intervals = {},
        list_items = {},
        settings_screens = {},
        capabilities = {
            ["network.http.async"] = true,
            ["network.http.download"] = true,
            ["network.http.download_progress"] = opts.api_version == 16,
            ["data.json"] = true,
            ["library.paged"] = true,
            ["library.refresh"] = true,
            ["ui.progress"] = opts.api_version == 16,
        },
        now_playing = { nil, nil, nil, 0 },
        current_path = nil,
        play_mode = "sequential",
        playing = false,
        paused = false,
        albums = {},
        songs = {},
        album_tracks = {},
        deferred = {},
        next_handle = 1,
        library_refresh_count = 0,
        http_impl = opts.http_impl,
        download_impl = opts.download_impl,
    }

    local plugin = {}

    function plugin.define(def)
        assert(def.api_min == (opts.api_version or 15), "Music plugin API version mismatch")
    end
    function plugin.sd_root() return self.sd_root_path end
    function plugin.has_capability(name) return self.capabilities[name] == true end
    function plugin.show_toast(msg, duration_ms)
        self.toasts[#self.toasts + 1] = msg
        self.toast_durations[#self.toasts] = duration_ms or 5000
    end
    function plugin.get_now_playing()
        local t = self.now_playing
        if t[1] == nil then return nil end
        return t[1], t[2], t[3], t[4]
    end
    function plugin.get_current_track_path() return self.current_path end
    function plugin.get_play_mode() return self.play_mode end
    function plugin.is_playing() return self.playing end
    function plugin.is_paused() return self.paused end
    function plugin.json_decode(text, limits)
        self.json_decode_calls[#self.json_decode_calls + 1] = { text = text, limits = limits }
        return decode_json(text)
    end
    function plugin.refresh_library()
        self.library_refresh_count = self.library_refresh_count + 1
        return true, "started"
    end
    function plugin.play_list(paths, start_index)
        local copy = {}
        for i, p in ipairs(paths or {}) do copy[i] = p end
        self.play_lists[#self.play_lists + 1] = { paths = copy, start_index = start_index or 1 }
        if copy[start_index or 1] then
            self.current_path = copy[start_index or 1]
            self.playing = true
        end
    end
    function plugin.library_get_albums(offset, limit)
        offset = offset or 0
        limit = limit or 200
        local out = {}
        for i = offset + 1, math.min(offset + limit, #self.albums) do
            out[#out + 1] = self.albums[i]
        end
        return out
    end
    function plugin.library_get_song(id)
        return self.songs[id]
    end
    function plugin.library_get_songs(offset, limit, filters)
        offset = offset or 0
        limit = limit or 200
        local all = {}
        for _, song in pairs(self.songs) do
            local ok = true
            if filters then
                if filters.artist and song.artist ~= filters.artist then ok = false end
                if filters.album_artist and song.album_artist ~= filters.album_artist then ok = false end
                if filters.album and song.album ~= filters.album then ok = false end
            end
            if ok then all[#all + 1] = song end
        end
        table.sort(all, function(a, b)
            return (a.id or 0) < (b.id or 0)
        end)
        local out = {}
        for i = offset + 1, math.min(offset + limit, #all) do
            out[#out + 1] = all[i]
        end
        return out, #all
    end
    function plugin.get_album_tracks(artist, album)
        local key = artist .. "\t" .. album
        return self.album_tracks[key]
    end
    function plugin.on(event, cb)
        self.events[event] = self.events[event] or {}
        self.events[event][#self.events[event] + 1] = cb
    end
    function plugin.set_interval(seconds, cb)
        local id = #self.intervals + 1
        self.intervals[id] = { seconds = seconds, cb = cb }
        return id
    end
    function plugin.show_progress(title, message, fraction)
        local handle = self.next_progress_handle
        self.next_progress_handle = handle + 1
        local card = { handle = handle, title = title, message = message, fraction = fraction }
        self.progress_cards[handle] = card
        self.active_progress = handle
        self.progress_events[#self.progress_events + 1] = {
            action = "show", handle = handle, title = title, message = message, fraction = fraction,
        }
        return handle
    end
    function plugin.update_progress(handle, message, fraction)
        if self.active_progress ~= handle then return false end
        local card = self.progress_cards[handle]
        if not card then return false end
        card.message, card.fraction = message, fraction
        self.progress_events[#self.progress_events + 1] = {
            action = "update", handle = handle, title = card.title, message = message, fraction = fraction,
        }
        return true
    end
    function plugin.close_progress(handle)
        if self.active_progress ~= handle then return false end
        self.progress_events[#self.progress_events + 1] = { action = "close", handle = handle }
        self.active_progress = nil
        return true
    end
    function plugin.get_download_progress(handle)
        if not self.active_downloads[handle] then return nil end
        local value = self.download_progress[handle]
        if not value then return nil end
        return { downloaded = value.downloaded, total = value.total }
    end
    function plugin.register_list_item(list_id, label, on_open)
        self.list_items[#self.list_items + 1] = { list_id = list_id, label = label, on_open = on_open }
    end
    function plugin.show_settings_list(title, items)
        self.settings_screens[#self.settings_screens + 1] = { title = title, items = items }
    end
    function plugin.show_list(title, items, on_select)
        return 1
    end
    function plugin.cancel(_) return true end

    function plugin.http_request(options, callback)
        self.http_calls[#self.http_calls + 1] = options
        local handle = self.next_handle
        self.next_handle = self.next_handle + 1
        local function deliver()
            if self.http_impl then
                local status, body, err, headers = self.http_impl(options)
                callback(status, body, err, headers)
            else
                callback(nil, nil, "network error", nil)
            end
        end
        if opts.defer_http then
            self.deferred[#self.deferred + 1] = deliver
        else
            deliver()
        end
        return handle
    end

    function plugin.download_file_async(url, dest, verify_tls, callback)
        if type(verify_tls) == "function" then
            callback = verify_tls
            verify_tls = true
        end
        local download = { url = url, dest = dest, verify_tls = verify_tls }
        self.downloads[#self.downloads + 1] = download
        local handle = self.next_handle
        self.next_handle = self.next_handle + 1
        download.handle = handle
        self.active_downloads[handle] = true
        if opts.download_progress_fixture then
            self.download_progress[handle] = opts.download_progress_fixture
        end
        local function deliver()
            if self.download_impl then
                local path, err = self.download_impl(url, dest, verify_tls)
                callback(path, err)
            else
                callback(nil, "download failed")
            end
            self.active_downloads[handle] = nil
        end
        if opts.defer_http then
            self.deferred[#self.deferred + 1] = deliver
        else
            deliver()
        end
        return handle
    end

    if opts.api_version ~= 16 then
        plugin.show_progress = nil
        plugin.update_progress = nil
        plugin.close_progress = nil
        plugin.get_download_progress = nil
    end
    self.plugin = require(opts.api_version == 16 and "api16_surface" or "api15_surface")(plugin)

    function self.emit(event, ...)
        for _, cb in ipairs(self.events[event] or {}) do
            cb(...)
        end
    end

    function self.flush()
        local guard = 0
        while #self.deferred > 0 do
            guard = guard + 1
            if guard > 50 then error("deferred HTTP did not drain") end
            local batch = self.deferred
            self.deferred = {}
            for _, fn in ipairs(batch) do fn() end
        end
    end

    function self.flush_one_batch()
        local batch = self.deferred
        self.deferred = {}
        for _, fn in ipairs(batch) do fn() end
    end

    function self.tick_intervals()
        for _, t in ipairs(self.intervals) do t.cb() end
    end

    function self.dismiss_progress()
        self.active_progress = nil
    end

    function self.set_download_progress(handle, downloaded, total)
        self.download_progress[handle] = { downloaded = downloaded, total = total or 0 }
    end

    function self.load(plugin_path)
        _G.COMPAS_PLUGIN_TEST = true
        local env = {
            plugin = plugin,
            COMPAS_PLUGIN_TEST = true,
            io = io,
            os = os,
            math = math,
            string = string,
            table = table,
            utf8 = utf8,
            tonumber = tonumber,
            tostring = tostring,
            type = type,
            pairs = pairs,
            ipairs = ipairs,
            pcall = pcall,
            error = error,
            select = select,
            assert = assert,
            print = print,
            rawget = rawget,
            _G = _G,
        }
        setmetatable(env, { __index = _G })
        local chunk, err = loadfile(plugin_path, "t", env)
        if not chunk then error(err) end
        chunk()
        self.under_test = env.COMPAS_PLUGIN_UNDER_TEST or _G.COMPAS_PLUGIN_UNDER_TEST
        _G.COMPAS_PLUGIN_UNDER_TEST = nil
        _G.COMPAS_PLUGIN_TEST = nil
        return self.under_test
    end

    return self
end

harness.decode_json = decode_json
return harness
