-- Characterize Jellyfin's actual browse pagination and show_list replacement options.
local storage_values = {
    user_id = "fixture-user",
    server_url = "http://fixture.invalid",
    server_kind = "jellyfin",
    page_size = "25",
    verify_tls = "1",
    servers = "[]",
}
local pending_data
local requests = 0
local next_handle = 0
local current_handle
local nav_pushes = 0
local replacements = 0
local rendered = {}
local defer_http = false
local pending_http = {}
local capabilities = {
    ["playback.remote"] = true,
    ["playback.remote_resolve"] = true,
    ["ui.list_update"] = true,
    ["ui.list_showing"] = true,
    ["ui.list_scroll_reset"] = true,
}
local plugin = {
    define = function(definition) assert(definition.api_min == 17 and definition.version == "1.2.1") end,
    has_capability = function(name) return capabilities[name] == true end,
    storage = {
        get = function(key, default)
            local value = storage_values[key]
            if value == nil then return default end
            return value
        end,
        set = function(key, value) storage_values[key] = value; return true end,
        delete = function(key) storage_values[key] = nil end,
    },
    secrets = {
        get = function(key) if key == "access_token" then return "fixture-token" end end,
        set = function() return true end,
        delete = function() end,
    },
    json_decode = function(body) assert(body == "fixture-json"); return pending_data end,
    json_encode = function() return "[]" end,
    md5 = function(value) return "fixture-md5-" .. value end,
    cancel = function() end,
    show_toast = function(message) error("unexpected toast: " .. tostring(message)) end,
    register_stream_media_tile = function() end,
    on = function() end,
    http_request = function(options, callback)
        requests = requests + 1
        local start_index = tonumber(options.url:match("[?&]StartIndex=(%d+)") or "0")
        local items = {}
        for i = 1, math.min(25, math.max(0, 60 - start_index)) do
            local index = start_index + i
            items[i] = {
                Id = "track-" .. index,
                Type = "Audio",
                Name = "Track " .. index,
                Artists = { { Name = "Artist" } },
                ParentIndexNumber = 1,
                IndexNumber = index,
            }
        end
        local response = { Items = items, TotalRecordCount = 60 }
        if defer_http then
            pending_http[#pending_http + 1] = { callback = callback, response = response, start_index = start_index }
        else
            pending_data = response
            callback(200, "fixture-json", nil, {})
        end
        return requests
    end,
    show_list = function(title, items, on_select, options)
        if options and options.replace then
            assert(options.replace == current_handle, "replacement must reuse the visible handle")
            replacements = replacements + 1
        else
            nav_pushes = nav_pushes + 1
        end
        next_handle = next_handle + 1
        current_handle = next_handle
        rendered[#rendered + 1] = {
            title = title,
            items = items,
            on_select = on_select,
            options = options,
            handle = current_handle,
        }
        return current_handle
    end,
    is_list_showing = function(handle) return handle == current_handle end,
}
local env = setmetatable({
    plugin = plugin,
    COMPAS_PLUGIN_TEST = true,
    rawget = rawget,
    _G = false,
}, { __index = _G })
env._G = env
assert(loadfile("plugins/JellyfinEmby/JellyfinEmby.lua", "t", env))()
local api = assert(env.COMPAS_PLUGIN_UNDER_TEST)

local function run_pages(view, expected_title_change, initial_reset)
    local before = #rendered
    api.execute_view(view)
    assert(#rendered == before + 1)
    local first = rendered[#rendered]
    if initial_reset then
        assert(first.options and first.options.replace and first.options.reset_scroll == true, "changed initial view resets replaced list")
    else
        assert(first.options == nil, "first view opens a fresh list")
    end
    assert(first.items[#first.items] == "Next page", "first page has a Next page action")

    first.on_select(#first.items)
    local second = rendered[#rendered]
    assert(second.handle ~= first.handle)
    assert(second.options and second.options.replace == first.handle)
    assert(second.options.reset_scroll == true, "changed logical page resets scroll")
    if expected_title_change then
        assert(second.title ~= first.title, "song page title includes its range")
    else
        assert(second.title == first.title, "album track pages keep the album title")
    end

    api.execute_view(view)
    local refreshed = rendered[#rendered]
    assert(refreshed.title == second.title)
    assert(refreshed.options and refreshed.options.replace == second.handle)
    assert(refreshed.options.reset_scroll == nil, "same-view refresh preserves scroll")
end

run_pages({ type = "songs", library = { Id = "library-1" }, start_index = 0 }, true)
run_pages({ type = "album_tracks", library = { Id = "library-1" }, album = { Id = "album-1", Name = "Same Album" }, start_index = 0 }, false, true)
assert(nav_pushes == 1, "page replacements must not push navigation screens")
assert(replacements == 5 and requests == 6)
print("Jellyfin pagination scroll reset: song/album pages reset; same-view refresh preserves; no extra navigation pushes")

local function finish_http(index)
    local request = table.remove(pending_http, index)
    assert(request, "expected deferred HTTP request")
    pending_data = request.response
    request.callback(200, "fixture-json", nil, {})
    return request
end

local function begin_race()
    defer_http = true
    local view = { type = "songs", library = { Id = "library-1" }, start_index = 0 }
    api.execute_view(view)
    assert(#pending_http == 1 and pending_http[1].start_index == 0)
    finish_http(1)
    local page_one = rendered[#rendered]
    assert(page_one.title == "Songs (1-25 / 60)")
    page_one.on_select(#page_one.items)
    assert(#pending_http == 1 and pending_http[1].start_index == 25)
    finish_http(1)
    local page_two = rendered[#rendered]
    assert(page_two.title == "Songs (26-50 / 60)")
    return view, page_two
end

local function verify_previous_next_order(finish_b_first)
    local view, page_two = begin_race()
    local rendered_before = #rendered
    page_two.on_select(2) -- Previous page: request A for start index 0.
    assert(#pending_http == 1 and pending_http[1].start_index == 0)
    page_two.on_select(#page_two.items) -- Next from displayed page 2: request B for start index 50.
    assert(#pending_http == 2 and pending_http[2].start_index == 50)
    if finish_b_first then
        finish_http(2)
        assert(#rendered == rendered_before + 1)
        finish_http(1)
    else
        finish_http(1)
        assert(#rendered == rendered_before)
        finish_http(1)
    end
    assert(#rendered == rendered_before + 1, "only latest foreground request may render")
    local page_three = rendered[#rendered]
    assert(page_three.title == "Songs (51-60 / 60)")
    assert(#page_three.items == 12, "last page contains only its 10 remaining songs")
    assert(page_three.options and page_three.options.reset_scroll == true,
        "the latest changed page resets scroll")

    -- The key belongs to the request snapshot, even if the caller later mutates
    -- the same view table while the response is pending.
    api.execute_view(view)
    assert(#pending_http == 1 and pending_http[1].start_index == 50)
    view.start_index = 25
    finish_http(1)
    local refresh = rendered[#rendered]
    assert(refresh.title == page_three.title)
    assert(refresh.options and refresh.options.reset_scroll == nil,
        "same-page refresh preserves scroll using its captured view key")
    defer_http = false
end

verify_previous_next_order(false)
verify_previous_next_order(true)
assert(#pending_http == 0)
print("Jellyfin deferred browse requests: stale Previous response discarded in both completion orders; latest bounded final page renders")
