-- Focused strict-API regression test for Discover's minimum API and
-- handling of malformed persisted wish-list entries.
local function fail(message)
    error(message, 2)
end

return function(assert_eq, assert_true)
    local saved_plugin = _G.plugin
    local h = {
        storage_values = { wishlist = "malformed-wishlist" },
        icon_copies = {},
        list_items = {},
        shown_lists = {},
        settings_screens = {},
        events = {},
        text_inputs = {},
        toasts = {},
        intervals = {},
        next_interval = 0,
    }

    local storage = {}
    local full_wishlist = { version = 1, entries = {} }
    for i = 1, 1000 do
        full_wishlist.entries[i] = { id = "id:" .. i, artist = "Artist", album = "Album " .. i, added_at = i }
    end
    function storage.get(key, default)
        local value = h.storage_values[key]
        if value == nil then return default end
        return value
    end
    function storage.set(key, value)
        if key == "wishlist" and h.fail_wishlist_set then return false, "storage quota exceeded" end
        if key == "matched_releases" and h.fail_feed_cache then return false, "storage quota exceeded" end
        h.storage_values[key] = value
        return true
    end
    function storage.delete(key) h.storage_values[key] = nil end

    local api = {
        define = function(def)
            assert_eq(def.id, "com.buymyhubs.discover", "stable Discover plugin id")
            assert_eq(def.api_min, 14, "Discover declares the minimum API for wrapped settings lists")
            assert_eq(def.version, "1.0.1", "Discover publishes the review fixes as a new version")
        end,
        has_capability = function(name)
            return name == "ui.list" or name == "ui.settings" or name == "ui.settings_list_wrap"
                or name == "library.paged" or name == "network.http.async" or name == "data.json"
                or name == "storage.namespaced"
        end,
        set_icon = function(dest, source)
            h.icon_copies[#h.icon_copies + 1] = { dest = dest, source = source }
        end,
        sd_root = function() return "/not-mounted/discover-test" end,
        json_decode = function(text)
            if text == "malformed-wishlist" then
                -- This has an id, which the old validator accepted, but lacks
                -- artist/album and crashed when the Wish List screen rendered.
                return { version = 1, entries = { { id = "mbid:test" } } }
            end
            if text == "search-results" then
                return { ["release-groups"] = {
                    { title = "Owned Album", id = "owned-id", ["artist-credit"] = {
                        { name = "Artist", artist = { id = "artist-id" } },
                    } },
                } }
            end
            if text == "scalar-options" then return true end
            if text == "full-wishlist" then return full_wishlist end
            return nil, "invalid json"
        end,
        json_encode = function()
            if h.fail_wishlist_encode then return nil, "encode failed" end
            return "{}"
        end,
        show_toast = function(message) h.toasts[#h.toasts + 1] = message end,
        show_list = function(title, labels, on_select)
            h.shown_lists[#h.shown_lists + 1] = { title = title, labels = labels, on_select = on_select }
        end,
        show_settings_list = function(title, items)
            h.settings_screens[#h.settings_screens + 1] = { title = title, items = items }
        end,
        show_text_input = function(title, _, _, callback)
            h.text_inputs[#h.text_inputs + 1] = { title = title, callback = callback }
        end,
        register_list_item = function(list_id, label, callback, options)
            h.list_items[#h.list_items + 1] = {
                list_id = list_id, label = label, callback = callback, options = options,
            }
        end,
        on = function(name, callback)
            h.events[name] = callback
        end,
        library_get_artists = function(offset)
            if offset == 0 then return { { name = "Artist", count = 201 } } end
            return {}
        end,
        library_get_albums = function(offset)
            if offset == 0 then
                local page = {}
                for i = 1, 200 do page[i] = { name = "Other Album " .. i } end
                return page, 201
            end
            if offset == 200 then return { { name = "Owned Album" } }, 201 end
            return {}, 201
        end,
        library_get_songs = function() return {}, 0 end,
        library_song_count = function() return 0 end,
        http_request = function(options, callback)
            if options.url:find("fresh%-releases") then
                callback(200, '{"releases":[]}', nil, {})
            else
                callback(200, "search-results", nil, {})
            end
            return {}, nil
        end,
        set_interval = function(seconds, callback)
            h.next_interval = h.next_interval + 1
            h.intervals[h.next_interval] = { seconds = seconds, callback = callback, active = true, fired = false }
            return h.next_interval
        end,
        clear_interval = function(handle)
            if h.intervals[handle] then h.intervals[handle].active = false end
        end,
    }
    api.storage = storage

    setmetatable(api, { __index = function(_, key)
        return fail("Discover called an API absent from the strict mock: plugin." .. tostring(key))
    end })
    _G.plugin = api

    local chunk, err = loadfile("plugins/Discover/Discover.lua")
    assert_true(chunk ~= nil, "Discover source compiles")
    local ok, run_err = pcall(chunk)
    assert_true(ok, "Discover loads against its declared API: " .. tostring(run_err))

    assert_eq(#h.list_items, 1, "one native list entry is registered")
    assert_eq(h.list_items[1].list_id, "music_library", "uses a documented music library list")
    assert_eq(#h.icon_copies, 5, "all bundled row icons are installed into the theme icon namespace")
    for _, copy in ipairs(h.icon_copies) do
        assert_true(copy.dest:match("^Discover/[a-z_]+%.png$") ~= nil, "icon destination is namespaced")
        assert_true(copy.source:match("^/not%-mounted/discover%-test/%.plugins/Discover/") ~= nil,
            "icon source matches the store-installed plugin bundle")
    end

    h.list_items[1].callback()
    local menu = h.shown_lists[#h.shown_lists]
    assert_eq(menu.title, "Discover", "Discover main menu opens")
    menu.on_select(2)
    local wishlist = h.shown_lists[#h.shown_lists]
    assert_eq(wishlist.title, "Wish List", "malformed stored entries do not prevent opening the wish list")
    assert_eq(wishlist.labels[1], "Nothing here yet", "malformed entry is discarded instead of crashing row formatting")

    menu.on_select(5)
    h.text_inputs[#h.text_inputs].callback("album query")
    local album_results = h.shown_lists[#h.shown_lists]
    assert_eq(album_results.labels[1].icon, "Discover/owned.png",
        "owned-album checks page past the first 200 library albums")

    h.storage_values.options = "scalar-options"
    menu.on_select(7)
    assert_eq(h.settings_screens[#h.settings_screens].title, "Options",
        "scalar persisted options are safely replaced by defaults")

    h.storage_values.wishlist = "full-wishlist"
    h.storage_values.last_song_count = "0"
    h.storage_values.last_scan_at = tostring(os.time())
    menu.on_select(6)
    h.text_inputs[#h.text_inputs].callback("Artist")
    h.text_inputs[#h.text_inputs].callback("Overflow Album")
    assert_true(h.toasts[#h.toasts]:find("1000 items", 1, true) ~= nil,
        "wish list capacity is enforced before a 1001st entry can be saved")
    assert_eq(h.storage_values.wishlist, "full-wishlist", "capacity rejection preserves the stored wish list")

    h.storage_values.wishlist = nil
    h.fail_wishlist_encode = true
    menu.on_select(6)
    h.text_inputs[#h.text_inputs].callback("Artist")
    h.text_inputs[#h.text_inputs].callback("New Album")
    assert_true(h.toasts[#h.toasts]:find("couldn't save wish list", 1, true) ~= nil,
        "JSON encoding failure is reported instead of claiming the item was added")
    assert_eq(h.storage_values.wishlist, nil, "failed JSON encoding preserves the previous wish list value")

    h.fail_wishlist_encode = false
    h.fail_wishlist_set = true
    menu.on_select(6)
    h.text_inputs[#h.text_inputs].callback("Artist")
    h.text_inputs[#h.text_inputs].callback("New Album")
    assert_true(h.toasts[#h.toasts]:find("couldn't save wish list", 1, true) ~= nil,
        "failed primary storage write is reported instead of claiming the item was added")
    assert_eq(h.storage_values.wishlist, nil, "failed primary storage write preserves the previous wish list value")

    h.fail_wishlist_set = false
    h.fail_feed_cache = true
    menu.on_select(1)
    h.settings_screens[#h.settings_screens].items[1].on_select()
    local callbacks = 0
    while true do
        local pending
        for _, interval in ipairs(h.intervals) do
            if interval.active and not interval.fired then
                pending = interval
                break
            end
        end
        if not pending then break end
        pending.fired = true
        callbacks = callbacks + 1
        assert_true(callbacks < 100, "feed scan advances through scheduled callbacks")
        pending.callback()
    end
    assert_eq(h.storage_values.feed_covered_to, nil,
        "failed release-feed cache write does not mark the date range as covered")
    assert_eq(h.storage_values.last_feed_fetch_at, nil,
        "failed release-feed cache write does not mark the feed as refreshed")
    _G.plugin = saved_plugin
end
