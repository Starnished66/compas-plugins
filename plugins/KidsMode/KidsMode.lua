plugin.define({ id = "example.kidsmode", name = "Kids Mode", version = "3.1.0", api_min = 16 })

-- Kids Mode narrows navigation. It does not lock the device: playback
-- controls and Now Playing remain available, and hidden controls are not
-- switched off.

local CONFIG_KEY = "settings_v1"
local HOME_KEYS = {
    { key = "music", label = "Music" },
    { key = "stream_media", label = "Stream Media" },
    { key = "wireless", label = "Wireless" },
    { key = "books", label = "Books" },
    { key = "settings", label = "Settings" },
    { key = "dac", label = "More" },
    { key = "subsonic", label = "Subsonic" },
}
local MUSIC_KEYS = {
    { key = "files", label = "Files" },
    { key = "artists", label = "Artists" },
    { key = "albums", label = "Albums" },
    { key = "album_artist", label = "Album Artist" },
    { key = "genres", label = "Genres" },
    { key = "all_songs", label = "All Songs" },
    { key = "playlists", label = "Playlists" },
}
local SHORTCUT_KEYS = {
    { key = "sound", label = "Sound" },
    { key = "playback", label = "Playback" },
    { key = "library", label = "Library" },
}
local DRAWER_KEYS = {
    { key = "wifi", label = "Wi-Fi" },
    { key = "bluetooth", label = "Bluetooth" },
    { key = "sleep", label = "Sleep timer" },
    { key = "crossfade", label = "Crossfade" },
    { key = "airplay", label = "AirPlay" },
    { key = "dlna", label = "DLNA" },
    { key = "gapless", label = "Gapless" },
    { key = "remote_control", label = "Remote control" },
    { key = "car_mode", label = "Car mode" },
    { key = "plugins", label = "Plugin toggles" },
}

local function defaults()
    return {
        enabled = false,
        home = { "music", "books" },
        home_order = { "music", "stream_media", "wireless", "books", "settings", "dac", "subsonic" },
        music = { "files", "artists", "albums", "album_artist", "genres", "all_songs", "playlists" },
        music_order = { "files", "artists", "albums", "album_artist", "genres", "all_songs", "playlists" },
        shortcuts = {},
        shortcuts_order = { "sound", "playback", "library" },
        drawer_enabled = false,
        drawer_eq_visible = true,
        drawer_volume_visible = true,
        drawer = { "wifi", "bluetooth", "sleep", "crossfade", "airplay", "dlna", "gapless",
            "remote_control", "car_mode", "plugins" },
        drawer_order = { "wifi", "bluetooth", "sleep", "crossfade", "airplay", "dlna", "gapless",
            "remote_control", "car_mode", "plugins" },
    }
end

local function valid_order(value, choices)
    if type(value) ~= "table" then return nil end
    local allowed, seen, result = {}, {}, {}
    for _, item in ipairs(choices) do allowed[item.key] = true end
    for _, key in ipairs(value) do
        if type(key) ~= "string" or not allowed[key] or seen[key] then return nil end
        seen[key] = true
        result[#result + 1] = key
    end
    return result
end

local function complete_order(value, visible_order, choices)
    local full = valid_order(value, choices)
    if full and #full == #choices then return full end

    local result, seen = {}, {}
    local visible = valid_order(visible_order, choices) or {}
    for _, key in ipairs(visible) do
        result[#result + 1] = key
        seen[key] = true
    end
    for _, item in ipairs(choices) do
        if not seen[item.key] then result[#result + 1] = item.key end
    end
    return result
end

local function normalize(raw, legacy_enabled)
    local cfg = defaults()
    if type(raw) ~= "table" then
        cfg.enabled = legacy_enabled
        return cfg
    end
    cfg.enabled = raw.enabled == true
    cfg.home = valid_order(raw.home, HOME_KEYS) or cfg.home
    cfg.home_order = complete_order(raw.home_order, cfg.home, HOME_KEYS)
    cfg.music = valid_order(raw.music, MUSIC_KEYS) or cfg.music
    cfg.music_order = complete_order(raw.music_order, cfg.music, MUSIC_KEYS)
    cfg.shortcuts = valid_order(raw.shortcuts, SHORTCUT_KEYS) or cfg.shortcuts
    cfg.shortcuts_order = complete_order(raw.shortcuts_order, cfg.shortcuts, SHORTCUT_KEYS)
    cfg.drawer_enabled = raw.drawer_enabled == true
    if type(raw.drawer_eq_visible) == "boolean" then cfg.drawer_eq_visible = raw.drawer_eq_visible end
    if type(raw.drawer_volume_visible) == "boolean" then cfg.drawer_volume_visible = raw.drawer_volume_visible end
    cfg.drawer = valid_order(raw.drawer, DRAWER_KEYS) or cfg.drawer
    cfg.drawer_order = complete_order(raw.drawer_order, cfg.drawer, DRAWER_KEYS)
    return cfg
end

local function read_config()
    local raw = plugin.storage.get(CONFIG_KEY)
    local legacy_enabled = plugin.storage.get("enabled", "0") == "1"
    if not raw or raw == "" then return normalize(nil, legacy_enabled) end
    local decoded = select(1, plugin.json_decode(raw))
    if type(decoded) ~= "table" then
        local cfg = defaults()
        cfg.enabled = true
        plugin.show_toast("Kids Mode settings could not be read; safe restrictions are active")
        return cfg
    end
    return normalize(decoded, legacy_enabled)
end

local config = read_config()
local pin = plugin.secrets.get("pin") or "1234"

local function clone_config(source)
    local out = {
        enabled = source.enabled,
        home = {}, home_order = {}, music = {}, music_order = {},
        shortcuts = {}, shortcuts_order = {}, drawer = {}, drawer_order = {},
        drawer_enabled = source.drawer_enabled,
        drawer_eq_visible = source.drawer_eq_visible,
        drawer_volume_visible = source.drawer_volume_visible,
    }
    for _, key in ipairs(source.home) do out.home[#out.home + 1] = key end
    for _, key in ipairs(source.home_order) do out.home_order[#out.home_order + 1] = key end
    for _, key in ipairs(source.music) do out.music[#out.music + 1] = key end
    for _, key in ipairs(source.music_order) do out.music_order[#out.music_order + 1] = key end
    for _, key in ipairs(source.shortcuts) do out.shortcuts[#out.shortcuts + 1] = key end
    for _, key in ipairs(source.shortcuts_order) do out.shortcuts_order[#out.shortcuts_order + 1] = key end
    for _, key in ipairs(source.drawer) do out.drawer[#out.drawer + 1] = key end
    for _, key in ipairs(source.drawer_order) do out.drawer_order[#out.drawer_order + 1] = key end
    return out
end

local function save_config(candidate)
    local ok_encode, encoded = pcall(plugin.json_encode, candidate)
    if not ok_encode or type(encoded) ~= "string" then
        plugin.show_toast("Unable to encode Kids Mode settings")
        return false
    end
    local ok_save, saved = pcall(plugin.storage.set, CONFIG_KEY, encoded)
    if not ok_save or saved ~= true then
        plugin.show_toast("Unable to save Kids Mode settings")
        return false
    end
    config = candidate
    -- settings_v1 is now authoritative. Remove the compatibility flag so a
    -- later downgrade does not resurrect an old enabled state.
    pcall(plugin.storage.delete, "enabled")
    return true
end

local function set_config_field(field, value)
    local candidate = clone_config(config)
    candidate[field] = value
    return save_config(candidate)
end

local function set_order_config(field, order_field, visible_order, full_order)
    local candidate = clone_config(config)
    candidate[field] = visible_order
    candidate[order_field] = full_order
    return save_config(candidate)
end

local function apply_layout()
    if not config.enabled then return end

    local home_order = {}
    for _, key in ipairs(config.home) do home_order[#home_order + 1] = key end
    -- Recovery is deliberately outside the editable list and always last.
    home_order[#home_order + 1] = "kids_parent"
    if plugin.has_capability("ui.home_layout") then
        plugin.set_home_layout({
            { key = "kids_parent", bg_color = 0x3a3a3a, text_color = 0xcccccc, radius = 24,
                text_size = "small" },
        }, { mode = #home_order > 6 and "list" or "tile", tile_gap = 24, order = home_order })
    else
        plugin.show_toast("This player cannot customize Home")
    end

    if plugin.has_capability("ui.music_layout") then
        plugin.set_music_layout({ order = config.music, toolbar = config.shortcuts })
    else
        plugin.show_toast("This player cannot customize Music menus")
    end

    if plugin.has_capability("ui.quick_drawer_layout") then
        plugin.set_quick_drawer_layout({
            enabled = config.drawer_enabled,
            order = config.drawer,
            eq_visible = config.drawer_eq_visible,
            volume_visible = config.drawer_volume_visible,
        })
    else
        plugin.show_toast("This player cannot customize the Quick Drawer")
    end
end

local request_text_input

local function show_settings()
    local function editor_row(label, items, field, order_field)
        return { type = "row", label = label, on_select = function()
            if not plugin.has_capability("ui.order_editor")
                    or type(plugin.show_order_editor) ~= "function" then
                plugin.show_toast("Update Compás to edit item order")
                return
            end
            local ordered = {}
            local enabled_keys = {}
            for _, key in ipairs(config[field]) do enabled_keys[key] = true end
            local item_by_key = {}
            for _, item in ipairs(items) do item_by_key[item.key] = item end
            -- Keep the complete order, including hidden entries, so a drag
            -- remains in place when an item is hidden and later restored.
            for _, key in ipairs(config[order_field]) do
                local item = item_by_key[key]
                if item then
                    ordered[#ordered + 1] = { key = item.key, label = item.label,
                        visible = enabled_keys[item.key] == true }
                end
            end
            local ok, err = pcall(plugin.show_order_editor, label, ordered, function(changed)
                if type(changed) ~= "table" then return end
                local next_order, next_visible, seen = {}, {}, {}
                for _, entry in ipairs(changed) do
                    if type(entry) ~= "table" or type(entry.key) ~= "string"
                            or type(entry.visible) ~= "boolean" or seen[entry.key] then
                        plugin.show_toast("Invalid item order")
                        return
                    end
                    seen[entry.key] = true
                    next_order[#next_order + 1] = entry.key
                    if entry.visible then next_visible[#next_visible + 1] = entry.key end
                end
                -- Reject partial or foreign editor responses before saving.
                if #changed ~= #items then
                    plugin.show_toast("Invalid item order")
                    return
                end
                for _, item in ipairs(items) do
                    if not seen[item.key] then
                        plugin.show_toast("Invalid item order")
                        return
                    end
                end
                if not set_order_config(field, order_field, next_visible, next_order) then
                    plugin.show_toast("Close and reopen this editor to discard the unsaved change")
                end
            end)
            if not ok then
                local message = tostring(err or "")
                if message:find("already open", 1, true) then
                    plugin.show_toast("Close the current item editor before opening another")
                else
                    plugin.show_toast("Unable to open this item editor")
                end
            end
        end }
    end

    plugin.show_settings_list("Kids Mode", {
        { type = "toggle", label = "Enable Kids Mode", value = config.enabled, on_change = function(value)
            local candidate = clone_config(config)
            candidate.enabled = value
            if save_config(candidate) then plugin.reload_ui() end
        end },
        editor_row("Home items", HOME_KEYS, "home", "home_order"),
        editor_row("Music menus", MUSIC_KEYS, "music", "music_order"),
        editor_row("Music shortcuts", SHORTCUT_KEYS, "shortcuts", "shortcuts_order"),
        { type = "toggle", label = "Quick Drawer", value = config.drawer_enabled, on_change = function(value)
            set_config_field("drawer_enabled", value)
        end },
        { type = "toggle", label = "Drawer EQ access", value = config.drawer_eq_visible, on_change = function(value)
            set_config_field("drawer_eq_visible", value)
        end },
        { type = "toggle", label = "Drawer volume access", value = config.drawer_volume_visible, on_change = function(value)
            set_config_field("drawer_volume_visible", value)
        end },
        editor_row("Drawer items", DRAWER_KEYS, "drawer", "drawer_order"),
        { type = "row", label = "Change Parent PIN", on_select = function()
            request_text_input("New Parent PIN (4+ digits)", function(text)
                if text == nil then return end
                if not text:match("^%d%d%d%d+$") then
                    plugin.show_toast("PIN must be at least 4 digits")
                    return
                end
                local ok, saved = pcall(plugin.secrets.set, "pin", text)
                if ok and saved == true then
                    pin = text
                    plugin.show_toast("PIN updated")
                else
                    plugin.show_toast("Unable to save PIN")
                end
            end)
        end },
        { type = "row", label = "Apply saved changes and reload UI", on_select = function()
            plugin.reload_ui()
        end },
        { type = "row", label = "About Kids Mode", on_select = function()
            plugin.show_list("Kids Mode limits", {
                "Kids Mode controls navigation only.",
                "Playback buttons and Now Playing remain available.",
                "Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers.",
            }, function() end)
        end },
    })
end

local function show_parent_menu()
    plugin.show_list("Parent Mode", { "Disable Kids Mode", "Configure restrictions" }, function(index)
        if index == 1 then
            local candidate = clone_config(config)
            candidate.enabled = false
            if save_config(candidate) then plugin.reload_ui() end
        elseif index == 2 then
            show_settings()
        end
    end)
end

request_text_input = function(title, on_submit)
    local ok, opened, reason = pcall(plugin.show_text_input, title, "", true, on_submit)
    if not ok or opened ~= true then
        if reason == "text input busy" then
            plugin.show_toast("Close the current text entry before entering a PIN")
        else
            plugin.show_toast("Unable to open PIN entry")
        end
    end
end

local function prompt_parent_pin()
    request_text_input("Parent PIN", function(text)
        if text == nil then return end
        if text == pin then
            show_parent_menu()
        else
            plugin.show_toast("Incorrect PIN")
        end
    end)
end

plugin.register_home_tile("kids_parent", "Parent Mode", prompt_parent_pin, "launcher/sys_set.png")

plugin.register_list_item("settings", "Kids Mode", function()
    if config.enabled then prompt_parent_pin() else show_settings() end
end)

apply_layout()
