plugin.define({
    id = "example.extended_sleep_timer",
    name = "Extended Sleep Timer",
    version = "1.2.0",
    api_min = 16,
})

-- An extended, plugin-owned sleep timer with an optional bedtime fade-out.
-- Duration and fade preferences persist; the countdown resets when the
-- player restarts, matching the native sleep timer behavior.

local STATE_PATH = plugin.sd_root() .. "/.plugins/.extended_sleep_timer_state"
local MIN_MINUTES = 15
local MAX_MINUTES = 180
local MIN_FADE_MINUTES = 1
local MAX_FADE_MINUTES = 30

local duration_minutes = 60
local fade_enabled = false
local fade_minutes = 15
local armed = false
local deadline = 0
local timer_handle = nil

local fade_in_progress = false
local captured_volume = nil
local last_applied_volume = nil
local fade_cancelled_manual = false

local function is_finite_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function clamp_duration(value)
    local n = tonumber(value)
    if not is_finite_number(n) then return 60 end
    n = math.floor(n)
    if n < MIN_MINUTES then return MIN_MINUTES end
    if n > MAX_MINUTES then return MAX_MINUTES end
    return n
end

local function clamp_fade(value)
    local n = tonumber(value)
    if not is_finite_number(n) then return 15 end
    n = math.floor(n)
    if n < MIN_FADE_MINUTES then return MIN_FADE_MINUTES end
    if n > MAX_FADE_MINUTES then return MAX_FADE_MINUTES end
    return n
end

local function is_fade_supported()
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
    -- 1. Check for modern transactional versioned JSON blob.
    -- All fields must be valid and complete before preferring it over legacy SD fallback.
    if plugin.storage and plugin.storage.get then
        local content = nil
        pcall(function() content = plugin.storage.get("config") end)
        if content and content ~= "" and #content <= 4096 then
            local data = decode_json(content)
            if type(data) == "table"
                and data.version == 1
                and is_finite_number(tonumber(data.duration_minutes))
                and type(data.fade_enabled) == "boolean"
                and is_finite_number(tonumber(data.fade_minutes)) then
                duration_minutes = clamp_duration(data.duration_minutes)
                fade_enabled = data.fade_enabled
                fade_minutes = clamp_fade(data.fade_minutes)
                return
            end
        end
    end

    -- 2. If no complete valid JSON blob exists, check SD read-only migration fallback
    local sd_found = false
    pcall(function()
        local f = io.open(STATE_PATH, "r")
        if not f then return end
        local line_dur = f:read("*l")
        local line_fade_en = f:read("*l")
        local line_fade_min = f:read("*l")
        f:close()
        if line_dur and line_dur ~= "" then
            duration_minutes = clamp_duration(line_dur)
            sd_found = true
        end
        if line_fade_en and line_fade_en ~= "" then
            fade_enabled = (line_fade_en == "1" or line_fade_en == "true")
        else
            fade_enabled = false
        end
        if line_fade_min and line_fade_min ~= "" then
            fade_minutes = clamp_fade(line_fade_min)
        else
            fade_minutes = 15
        end
    end)
    if sd_found then return end

    -- 3. If neither blob nor SD file exists, check legacy unversioned storage key
    if plugin.storage and plugin.storage.get then
        pcall(function()
            local s_dur = plugin.storage.get("duration_minutes")
            if s_dur and s_dur ~= "" then
                duration_minutes = clamp_duration(s_dur)
            end
        end)
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
            duration_minutes = duration_minutes,
            fade_enabled = fade_enabled,
            fade_minutes = fade_minutes,
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

    -- Clean up legacy individual keys so they cannot mask future state
    if plugin.storage.delete then
        pcall(function()
            plugin.storage.delete("duration_minutes")
            plugin.storage.delete("fade_enabled")
            plugin.storage.delete("fade_minutes")
        end)
    end
    return true
end

local function format_duration(minutes)
    local hours = math.floor(minutes / 60)
    local remainder = minutes % 60
    if hours == 0 then return string.format("%d min", remainder) end
    if remainder == 0 then return string.format("%d hr", hours) end
    return string.format("%d hr %d min", hours, remainder)
end

local function format_remaining(seconds)
    seconds = math.max(0, math.floor(seconds))
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor(seconds / 60) % 60
    local secs = seconds % 60
    if hours > 0 then return string.format("%d:%02d:%02d", hours, minutes, secs) end
    return string.format("%d:%02d", minutes, secs)
end

local function remaining_seconds()
    if not armed then return 0 end
    return math.max(0, deadline - os.time())
end

local function clear_timer()
    if timer_handle then
        plugin.clear_interval(timer_handle)
        timer_handle = nil
    end
end

local tick

local function ensure_timer()
    if timer_handle then return true end
    local ok, handle = pcall(plugin.set_interval, 1, tick)
    if ok and handle then
        timer_handle = handle
        return true
    end
    return false
end

tick = function()
    if not armed then
        clear_timer()
        return
    end

    local rem = remaining_seconds()
    if rem <= 0 then
        armed = false
        deadline = 0
        clear_timer()
        fade_in_progress = false
        captured_volume = nil
        last_applied_volume = nil
        fade_cancelled_manual = false
        plugin.stop()
        plugin.show_toast("Sleep timer finished")
        return
    end

    -- Bedtime fade-out: active only when enabled, supported, and not cancelled by manual volume change
    if fade_enabled and is_fade_supported() and not fade_cancelled_manual then
        local effective_fade_mins = math.min(fade_minutes, duration_minutes)
        local fade_sec = effective_fade_mins * 60
        if rem <= fade_sec then
            local cur = plugin.get_volume()
            if not fade_in_progress then
                -- Capture starting volume once when fade window begins
                fade_in_progress = true
                captured_volume = cur
                last_applied_volume = cur
            else
                -- Detect manual volume adjustment
                if cur ~= last_applied_volume then
                    -- Manual change cancels fading for this countdown; timer still stops at deadline
                    fade_cancelled_manual = true
                    fade_in_progress = false
                    return
                end
            end

            -- Proper remaining-time ratio fade down from captured_volume to 0
            local raw = math.floor(captured_volume * (rem / fade_sec))
            local target = math.min(last_applied_volume, raw)
            if target < cur then
                last_applied_volume = target
                plugin.set_volume(target, { silent = true, persist = false })
            end
        end
    end
end

local function set_armed(value)
    if value then
        deadline = os.time() + duration_minutes * 60
        fade_in_progress = false
        captured_volume = nil
        last_applied_volume = nil
        fade_cancelled_manual = false

        if not ensure_timer() then
            armed = false
            deadline = 0
            plugin.show_toast("Could not arm sleep timer: all timer slots busy")
            return false
        end

        armed = true
        plugin.show_toast("Sleep timer set for " .. format_duration(duration_minutes))
    else
        local had_fade = fade_in_progress or fade_cancelled_manual
        armed = false
        deadline = 0
        clear_timer()
        fade_in_progress = false
        captured_volume = nil
        last_applied_volume = nil
        fade_cancelled_manual = false

        if had_fade then
            plugin.show_toast("Sleep timer cancelled. Volume stays at its current level; adjust manually.")
        else
            plugin.show_toast("Extended sleep timer cancelled")
        end
    end
    return true
end

local function show_status()
    if not armed then
        plugin.show_toast("Extended sleep timer is off")
        return
    end
    local rem = remaining_seconds()
    if fade_cancelled_manual then
        plugin.show_toast("Remaining: " .. format_remaining(rem) .. " (fade cancelled by volume change)")
    elseif fade_in_progress then
        plugin.show_toast("Remaining: " .. format_remaining(rem) .. " (fading out)")
    else
        plugin.show_toast("Time remaining: " .. format_remaining(rem))
    end
end

local function open_about()
    local about_lines = {
        "Stops playback when the countdown reaches zero.",
        "Choose any duration from 15 minutes to 3 hours.",
        "Changing duration while armed restarts the countdown.",
        "The countdown resets when the player restarts.",
    }
    if is_fade_supported() then
        about_lines[#about_lines + 1] = "Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."
        about_lines[#about_lines + 1] = "Manual volume adjustment during fade cancels fading for this countdown."
        about_lines[#about_lines + 1] = "When finished or cancelled, volume stays at its current level; adjust manually."
    else
        about_lines[#about_lines + 1] = "Bedtime Fade-out unavailable: player lacks silent/transient volume."
    end
    plugin.show_list("About Extended Timer", about_lines, function() end)
end

local function open_settings()
    local items = {
        {
            type = "toggle",
            label = "Timer Enabled",
            value = armed,
            on_change = set_armed,
        },
        {
            type = "slider",
            label = "Duration (minutes)",
            min = MIN_MINUTES,
            max = MAX_MINUTES,
            value = duration_minutes,
            on_change = function(value)
                duration_minutes = clamp_duration(value)
                local saved = save_state()
                if armed then
                    deadline = os.time() + duration_minutes * 60
                    fade_in_progress = false
                    captured_volume = nil
                    last_applied_volume = nil
                    fade_cancelled_manual = false
                    if saved then
                        plugin.show_toast("Timer restarted: " .. format_duration(duration_minutes))
                    else
                        plugin.show_toast("Timer restarted: " .. format_duration(duration_minutes) .. " for this session only (storage failed)")
                    end
                else
                    if saved then
                        plugin.show_toast("Duration: " .. format_duration(duration_minutes))
                    else
                        plugin.show_toast("Duration: " .. format_duration(duration_minutes) .. " for this session only (storage failed)")
                    end
                end
            end,
        },
    }

    if is_fade_supported() then
        items[#items + 1] = {
            type = "toggle",
            label = "Bedtime Fade-out",
            value = fade_enabled,
            on_change = function(value)
                fade_enabled = (value == true)
                local saved = save_state()
                if not fade_enabled and fade_in_progress then
                    fade_in_progress = false
                    captured_volume = nil
                    last_applied_volume = nil
                    if saved then
                        plugin.show_toast("Bedtime fade disabled. Volume stays at its current level; adjust manually.")
                    else
                        plugin.show_toast("Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually.")
                    end
                else
                    local status = fade_enabled and "Bedtime fade enabled" or "Bedtime fade disabled"
                    if saved then
                        plugin.show_toast(status)
                    else
                        plugin.show_toast(status .. " for this session only (storage failed)")
                    end
                end
            end,
        }
        items[#items + 1] = {
            type = "slider",
            label = "Fade Duration (minutes)",
            min = MIN_FADE_MINUTES,
            max = MAX_FADE_MINUTES,
            value = fade_minutes,
            on_change = function(value)
                fade_minutes = clamp_fade(value)
                local saved = save_state()
                if saved then
                    plugin.show_toast("Fade duration: " .. fade_minutes .. " min")
                else
                    plugin.show_toast("Fade duration: " .. fade_minutes .. " min for this session only (storage failed)")
                end
            end,
        }
    else
        items[#items + 1] = {
            type = "row",
            label = "Bedtime Fade-out: Unsupported",
            on_select = function()
                plugin.show_toast("Bedtime fade requires silent and transient volume support")
            end,
        }
    end

    items[#items + 1] = {
        type = "row",
        label = "Show Time Remaining",
        on_select = show_status,
    }
    items[#items + 1] = {
        type = "row",
        label = "How It Works",
        on_select = open_about,
    }

    plugin.show_settings_list("Extended Sleep Timer", items)
end

load_state()

plugin.register_list_item("music_timers", "Extended Sleep Timer", open_settings)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        open_settings = open_settings,
        set_armed = set_armed,
        tick = tick,
        is_armed = function() return armed end,
        get_deadline = function() return deadline end,
        get_duration_minutes = function() return duration_minutes end,
        get_fade_minutes = function() return fade_minutes end,
        is_fade_enabled = function() return fade_enabled end,
        is_fade_in_progress = function() return fade_in_progress end,
        is_fade_cancelled_manual = function() return fade_cancelled_manual end,
        get_captured_volume = function() return captured_volume end,
        has_timer = function() return timer_handle ~= nil end,
        save_state = save_state,
        load_state = load_state,
    }
end
