plugin.define({
    id = "compas.volume_limiter",
    name = "Volume Limiter",
    version = "1.1.0",
    api_min = 16,
})

-- Sets a software maximum volume ceiling and quietly clamps playback volume
-- without intrusive popups or saving transient overshoots to flash.

local DEFAULT_MAX_VOLUME = 70
local enabled = false
local max_volume = DEFAULT_MAX_VOLUME
local in_clamp = false

local function is_finite_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function clamp_volume_setting(value)
    local n = tonumber(value)
    if not is_finite_number(n) then return DEFAULT_MAX_VOLUME end
    n = math.floor(n)
    if n < 0 then return 0 end
    if n > 100 then return 100 end
    return n
end

local function is_supported()
    return plugin.has_capability("playback.silent_volume")
        and plugin.has_capability("playback.transient_volume")
end

local function decode_json(text)
    if type(text) ~= "string" or #text > 4096 then return nil end
    if not plugin.json_decode then return nil end
    local ok, res = pcall(plugin.json_decode, text)
    if ok and type(res) == "table" then return res end
    return nil
end

local function load_state()
    if not (plugin.storage and plugin.storage.get) then return end
    local content = nil
    pcall(function()
        content = plugin.storage.get("config")
    end)
    if not content or content == "" or #content > 4096 then return end
    local data = decode_json(content)
    if type(data) == "table"
        and data.version == 1
        and type(data.enabled) == "boolean"
        and is_finite_number(tonumber(data.max_volume)) then
        enabled = data.enabled
        max_volume = clamp_volume_setting(data.max_volume)
    end
end

local function save_state()
    if not (plugin.storage and plugin.storage.set) then
        return false
    end
    local encoded = nil
    if plugin.json_encode then
        local ok, res = pcall(plugin.json_encode, {
            version = 1,
            enabled = enabled,
            max_volume = max_volume,
        })
        if ok and type(res) == "string" then
            encoded = res
        end
    end
    if not encoded then return false end
    local ok, err = plugin.storage.set("config", encoded)
    if not ok then
        return false
    end
    return true
end

local function apply_clamp(target_percent)
    if in_clamp then return end
    if not is_supported() then return end
    -- Another volume tool may already have lowered a coalesced notification's
    -- value. A ceiling must never raise the current live volume.
    local live = plugin.get_volume()
    if not is_finite_number(live) or live <= target_percent then return end
    in_clamp = true
    pcall(function()
        -- Silent and transient: avoids screen popup and avoids flash writes on repeated overshoots
        plugin.set_volume(target_percent, { silent = true, persist = false })
    end)
    in_clamp = false
end

local function check_and_clamp(current_percent)
    if not enabled then return end
    local cur = current_percent
    if cur == nil then
        cur = plugin.get_volume()
    end
    if cur and is_finite_number(cur) and cur > max_volume then
        apply_clamp(max_volume)
    end
end

local function set_enabled(value)
    enabled = (value == true)
    local saved = save_state()
    if enabled then
        check_and_clamp()
        if saved then
            plugin.show_toast("Volume Limiter enabled (cap " .. max_volume .. "%)")
        else
            plugin.show_toast("Volume Limiter enabled (cap " .. max_volume .. "%) for this session only (storage failed)")
        end
    else
        if saved then
            plugin.show_toast("Volume Limiter disabled")
        else
            plugin.show_toast("Volume Limiter disabled for this session only (storage failed)")
        end
    end
end

local function set_max_volume(value)
    max_volume = clamp_volume_setting(value)
    local saved = save_state()
    if enabled then
        check_and_clamp()
    end
    if saved then
        plugin.show_toast("Volume cap: " .. max_volume .. "%")
    else
        plugin.show_toast("Volume cap: " .. max_volume .. "% for this session only (storage failed)")
    end
end

-- volume_changed callback: native events are coalesced at 500ms intervals
plugin.on("volume_changed", function(percent)
    if in_clamp then return end
    if not enabled then return end
    if type(percent) ~= "number" or not is_finite_number(percent) then return end
    if percent > max_volume then
        apply_clamp(max_volume)
    end
end)

local function open_about()
    local about_lines = {
        "Sets a software maximum volume ceiling.",
        "Quietly clamps volume changes that exceed the cap without flash wear.",
        "Volume notifications are coalesced at 500ms intervals natively.",
        "Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees.",
    }
    plugin.show_list("About Volume Limiter", about_lines, function() end)
end

local function open_settings()
    local items = {}
    if is_supported() then
        items[#items + 1] = {
            type = "toggle",
            label = "Limiter Enabled",
            value = enabled,
            on_change = set_enabled,
        }
        items[#items + 1] = {
            type = "slider",
            label = "Maximum Volume",
            min = 0,
            max = 100,
            value = max_volume,
            on_change = set_max_volume,
        }
    else
        items[#items + 1] = {
            type = "row",
            label = "Volume Limiter: Unsupported",
            on_select = function()
                plugin.show_toast("Limiter requires silent and transient volume support")
            end,
        }
    end
    items[#items + 1] = {
        type = "row",
        label = "About Volume Limiter",
        on_select = open_about,
    }
    plugin.show_settings_list("Volume Limiter", items)
end

load_state()
-- Firmware restores startup volume before loading plugins; enforce the saved
-- ceiling before the initial native volume-event baseline is captured.
check_and_clamp()

plugin.register_list_item("music_audio", "Volume Limiter", open_settings)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        open_settings = open_settings,
        set_enabled = set_enabled,
        set_max_volume = set_max_volume,
        is_enabled = function() return enabled end,
        get_max_volume = function() return max_volume end,
        check_and_clamp = check_and_clamp,
        apply_clamp = apply_clamp,
        is_in_clamp = function() return in_clamp end,
        save_state = save_state,
        load_state = load_state,
    }
end
