-- Host regression for Cover Art Fetcher receipt history pagination.
-- Run: lua tools/test_cover_art_history_scroll.lua

local script_dir = (arg and arg[0] or "tools/test_cover_art_history_scroll.lua"):match("^(.*)/[^/]*$") or "."
local PLUGIN = script_dir .. "/../plugins/CoverArtFetcher/CoverArtFetcher.lua"
local HEADER = "CAF-RECEIPT 1"
local PAGE = 20

local function encode_receipt(id)
    local album = "Fixture Album " .. id
    local fields = {
        id = tostring(id), state = "saved",
        dest = "/fixture-root/music/" .. album .. ".jpg",
        size = "1234", md5 = "0123456789abcdef0123456789abcdef",
        album = album, artist = "Fixture Artist", created = tostring(1700000000 + id),
        saved_at = tostring(1700000000 + id),
    }
    local lines = { HEADER }
    for _, key in ipairs({ "id", "state", "dest", "size", "md5", "album", "artist", "created", "saved_at" }) do
        lines[#lines + 1] = key .. "\t" .. fields[key]
    end
    return table.concat(lines, "\n")
end

local function run_case(reset_capability)
    local stored, keys = {}, {}
    for id = 1, PAGE + 3 do
        local key = "rcpt." .. id
        keys[#keys + 1] = key
        stored[key] = encode_receipt(id)
    end

    local caps = {
        ["storage.namespaced"] = true,
        ["crypto.md5"] = true,
        ["ui.list_scroll_reset"] = reset_capability,
    }
    local state = { rows = {}, renders = {}, toasts = {}, next_handle = 0,
        nav_pushes = 0, replacements = 0 }
    local plugin = {
        define = function(info) state.definition = info end,
        sd_root = function() return "/fixture-root" end,
        has_capability = function(name) return caps[name] == true end,
        on = function() end,
        set_interval = function() end,
        register_list_item = function(list, label, callback)
            state.rows[#state.rows + 1] = { list = list, label = label, callback = callback }
        end,
        show_toast = function(message) state.toasts[#state.toasts + 1] = message end,
        show_settings_list = function() end,
        show_list = function(title, items, callback, options)
            if options and options.replace then
                assert(options.replace == state.current_handle, "pagination must replace current history handle")
                state.replacements = state.replacements + 1
            else
                state.nav_pushes = state.nav_pushes + 1
            end
            state.next_handle = state.next_handle + 1
            state.current_handle = state.next_handle
            state.renders[#state.renders + 1] = {
                title = title, items = items, callback = callback,
                options = options, handle = state.current_handle,
            }
            return state.current_handle
        end,
        storage = {
            list = function(prefix)
                assert(prefix == "rcpt.")
                return keys
            end,
            get = function(key) return stored[key] end,
            set = function(key, value) stored[key] = value; return true end,
            delete = function(key) stored[key] = nil end,
        },
    }
    local env = setmetatable({ plugin = plugin, COMPAS_PLUGIN_TEST = true }, { __index = _G })
    env._G = env
    local chunk, err = loadfile(PLUGIN, "t", env)
    assert(chunk, err)
    chunk()
    local api = assert(env.COMPAS_PLUGIN_UNDER_TEST)
    assert(api.receipts()[PAGE + 3], "startup must decode mocked persisted receipts")

    api.open_history(1)
    local first = state.renders[#state.renders]
    assert(first.title == "Downloaded covers 1/2")
    assert(#first.items == PAGE + 1 and first.items[#first.items] == "Older")
    first.callback(#first.items)

    local second = state.renders[#state.renders]
    assert(second.title == "Downloaded covers 2/2")
    assert(second.options and second.options.replace == first.handle)
    if reset_capability then
        assert(second.options.reset_scroll == true, "Older page resets scroll when capability is present")
    else
        assert(second.options.reset_scroll == nil, "Older page omits unsupported reset option")
    end
    assert(second.items[#second.items] == "Newer")

    -- Index one is a real persisted receipt on page two, not a pagination row.
    local before_receipt = #state.renders
    second.callback(1)
    assert(#state.renders == before_receipt + 1)
    local detail = state.renders[#state.renders]
    assert(detail.title == "Downloaded cover")
    assert(detail.items[2].label:find("Fixture Album 3", 1, true), "receipt row opens its own record")
    assert(detail.options == nil, "receipt detail is a new screen, not another history page")

    -- Reopen history, then verify the Newer row also replaces the same handle.
    api.open_history(2)
    local page_two = state.renders[#state.renders]
    local before_newer = #state.renders
    page_two.callback(#page_two.items)
    local page_one_again = state.renders[#state.renders]
    assert(#state.renders == before_newer + 1)
    assert(page_one_again.title == "Downloaded covers 1/2")
    assert(page_one_again.options and page_one_again.options.replace == page_two.handle)
    if reset_capability then
        assert(page_one_again.options.reset_scroll == true, "Newer page resets scroll when capability is present")
    else
        assert(page_one_again.options.reset_scroll == nil, "Newer page omits unsupported reset option")
    end
    assert(state.nav_pushes == 3, "initial history, receipt detail, and reopened history push screens")
    assert(state.replacements == 2, "Older and Newer each replace the same visible history slot")
end

run_case(true)
run_case(false)
print("CoverArtFetcher history pagination: Older/Newer replace in place, capability-gated reset, receipt rows open details")
