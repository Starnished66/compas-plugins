plugin.define({
    id = "org.compas.output_aware_sound",
    name = "Output-Aware Sound",
    version = "1.1",
    api_min = 16,
})

-- Output-Aware Sound:
-- Automatically applies PEQ profiles when output route or Bluetooth codec changes.
-- Maps wired, USB DAC, and Bluetooth (per codec with explicit unknown/default fallbacks).
-- Applies profiles transiently ({ persist = false }) without writing to flash.
-- Gain/preamp is bundled within the .peq file; does not call eq_set_preamp.
-- Does not perform automatic volume jumps to ensure hearing safety.
-- Does not claim bit-perfect output (Bluetooth and USB conversions are hardware-dependent).
--
-- EQ Ownership Policy:
-- - Maintains a detached get_eq_state snapshot of the last applied state with 1e-6 precision.
-- - Before an automatic transition, compares current EQ state to the last applied state.
-- - If state differs, automatic writes suspend immediately until re-enabled/reclaimed.
-- - Baseline EQ is restored on leaving mapped route or on disable if still owned.
-- - Baseline EQ is preserved across profile edits while owned.

local CONFIG_PATH = plugin.sd_root() .. "/.plugins/output_aware_sound_config.json"
local PROFILES_DIR = plugin.sd_root() .. "/PEQ_Profiles"
local MAX_UI_ROWS = 500
local EPSILON = 1e-6

local config = {
    enabled = false,
    routes = {
        ["wired"] = "",
        ["usb_dac"] = "",
        ["bluetooth:ldac"] = "",
        ["bluetooth:aptx"] = "",
        ["bluetooth:aac"] = "",
        ["bluetooth:sbc"] = "",
        ["bluetooth:default"] = "",
        ["bluetooth:unknown"] = "",
    }
}

local baseline_state = nil
local last_applied_state = nil
local is_suspended = false
local suspension_reason = nil
local last_applied_key = nil
local last_applied_profile = nil
local last_profile_succeeded = false

local function is_valid_profile_name(name)
    if type(name) ~= "string" or #name == 0 or #name > 128 then return false end
    if name:find("[/\\]") or name:find("%.%.") then return false end
    if not name:lower():match("%.peq$") then return false end
    return true
end

local function num_eq(a, b)
    if not a and not b then return true end
    if not a or not b then return false end
    if a ~= a or b ~= b then return false end -- reject NaN
    if a == math.huge or a == -math.huge or b == math.huge or b == -math.huge then return false end
    return math.abs(a - b) <= EPSILON
end

local function eq_states_equal(a, b)
    if a == b then return true end
    if not a or not b then return false end
    if a.bypass ~= b.bypass then return false end
    if not num_eq(a.preamp_db, b.preamp_db) then return false end
    if not num_eq(a.stereo_width, b.stereo_width) then return false end
    if not a.bands or not b.bands then return a.bands == b.bands end
    if #a.bands ~= #b.bands then return false end
    for i = 1, #a.bands do
        local b1 = a.bands[i]
        local b2 = b.bands[i]
        if not b1 or not b2 then return false end
        if b1.enabled ~= b2.enabled then return false end
        if b1.type ~= b2.type then return false end
        if not num_eq(b1.freq_hz, b2.freq_hz) then return false end
        if not num_eq(b1.gain_db, b2.gain_db) then return false end
        if not num_eq(b1.q, b2.q) then return false end
    end
    return true
end

local function json_encode(val)
    if not (plugin.has_capability and plugin.has_capability("data.json") and plugin.json_encode) then return nil end
    local ok, res = pcall(plugin.json_encode, val)
    if ok and type(res) == "string" then return res end
    return nil
end

local function json_decode(text)
    if not (plugin.has_capability and plugin.has_capability("data.json") and plugin.json_decode) then return nil end
    local ok, res = pcall(plugin.json_decode, text)
    if ok and type(res) == "table" then return res end
    return nil
end

local function load_config()
    local content = nil
    if plugin.has_capability and plugin.has_capability("storage.namespaced") and plugin.storage and plugin.storage.get then
        content = plugin.storage.get("config")
    end
    if not content or content == "" then
        local f = io.open(CONFIG_PATH, "r")
        if f then
            content = f:read(65536)
            f:close()
        end
    end
    if not content or content == "" or #content > 65536 then return end
    local data = json_decode(content)
    if type(data) ~= "table" then return end
    if type(data.enabled) == "boolean" then config.enabled = data.enabled end
    if type(data.routes) == "table" then
        for k, v in pairs(data.routes) do
            if type(k) == "string" and (type(v) == "string" and (v == "" or is_valid_profile_name(v))) then
                config.routes[k] = v
            end
        end
    end
end

local function save_config()
    local encoded = json_encode(config)
    if not encoded or #encoded > 65536 then
        if plugin.show_toast then plugin.show_toast("Failed to encode configuration") end
        return false
    end

    -- Sole authoritative namespaced storage writer
    if plugin.has_capability and plugin.has_capability("storage.namespaced") and plugin.storage and plugin.storage.set then
        local saved = plugin.storage.set("config", encoded)
        if saved then
            return true
        end
        if plugin.show_toast then
            plugin.show_toast("Failed to save settings to storage; changes are live for this session only")
        end
        return false
    end

    if plugin.show_toast then
        plugin.show_toast("Storage unavailable; changes are live for this session only")
    end
    return false
end

local function list_available_profiles()
    local profiles = {}
    if not plugin.list_dir then return profiles end
    local entries = plugin.list_dir(PROFILES_DIR)
    if not entries then return profiles end
    for _, ent in ipairs(entries) do
        if not ent.dir and ent.name and is_valid_profile_name(ent.name) then
            profiles[#profiles + 1] = ent.name
        end
    end
    table.sort(profiles)
    return profiles
end

local function resolve_route_key(snapshot)
    if not snapshot then return "unknown" end
    local r = snapshot.route
    if (not r or r == "inactive" or r == "unknown") and snapshot.requested_route then
        r = snapshot.requested_route
    end
    if r == "wired" then
        return "wired"
    elseif r == "usb_dac" then
        return "usb_dac"
    elseif r == "bluetooth" then
        local codec = snapshot.bluetooth_codec
        if codec and codec ~= "" then
            return "bluetooth:" .. string.lower(codec)
        else
            return "bluetooth:unknown"
        end
    end
    return "unknown"
end

local function resolve_profile_for_route_key(route_key)
    if not route_key or route_key == "unknown" then return nil end
    local prof = config.routes[route_key]
    if prof and is_valid_profile_name(prof) then return prof end

    if route_key:sub(1, 10) == "bluetooth:" then
        local def = config.routes["bluetooth:default"]
        if def and is_valid_profile_name(def) then return def end
    end
    return nil
end

local function apply_target_profile(profile_name)
    if not is_valid_profile_name(profile_name) then return false end
    local full_path = PROFILES_DIR .. "/" .. profile_name
    if not (plugin.has_capability and plugin.has_capability("audio.peq.transient") and plugin.eq_apply_profile) then
        return false
    end
    return plugin.eq_apply_profile(full_path, { persist = false })
end

local function handle_output_snapshot(snapshot)
    if not config.enabled then return end
    if is_suspended then return end

    local route_key = resolve_route_key(snapshot)
    local target_profile = resolve_profile_for_route_key(route_key)

    if not target_profile or target_profile == "" then
        -- Route has no profile mapped: restore runtime baseline if previously applied!
        if last_applied_profile ~= nil then
            if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
                local current_eq = plugin.get_eq_state()
                if last_applied_state and not eq_states_equal(current_eq, last_applied_state) then
                    is_suspended = true
                    suspension_reason = "Manual or external EQ change detected"
                    return -- do NOT clobber user's manual change
                end
            end
            if baseline_state and plugin.has_capability and plugin.has_capability("audio.peq.state")
               and plugin.eq_apply_state then
                plugin.eq_apply_state(baseline_state, { persist = false })
                if plugin.get_eq_state then last_applied_state = plugin.get_eq_state() end
            end
            last_applied_profile = nil
            last_applied_key = route_key
            last_profile_succeeded = false
        end
        return
    end

    -- Deduplication: if route key and target profile haven't changed and last attempt succeeded, skip
    if route_key == last_applied_key and target_profile == last_applied_profile and last_profile_succeeded then
        return
    end

    -- Verify EQ ownership against last applied snapshot
    if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
        local current_eq = plugin.get_eq_state()
        if last_applied_state and not eq_states_equal(current_eq, last_applied_state) then
            is_suspended = true
            suspension_reason = "Manual or external EQ change detected"
            return -- Suspend automatic writes; do NOT write to EQ!
        end
    end

    local ok = apply_target_profile(target_profile)
    last_applied_key = route_key
    last_applied_profile = target_profile
    if ok then
        last_profile_succeeded = true
        if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
            last_applied_state = plugin.get_eq_state()
        end
    else
        last_profile_succeeded = false -- Retry on next transition
    end
end

local function evaluate_current_output()
    if not (plugin.has_capability and plugin.has_capability("playback.output_info") and plugin.get_output_info) then
        return
    end
    local info = plugin.get_output_info()
    if info then
        handle_output_snapshot(info)
    end
end

local function grant_control(is_reclaiming)
    is_suspended = false
    suspension_reason = nil
    last_applied_key = nil
    last_applied_profile = nil
    last_profile_succeeded = false

    if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
        local current_eq = plugin.get_eq_state()
        if baseline_state == nil or is_reclaiming or (last_applied_state and not eq_states_equal(current_eq, last_applied_state)) then
            baseline_state = current_eq
        end
        last_applied_state = plugin.get_eq_state()
    end
    evaluate_current_output()
end

local function release_control()
    if baseline_state and plugin.has_capability and plugin.has_capability("audio.peq.state")
       and plugin.get_eq_state and plugin.eq_apply_state then
        local current_eq = plugin.get_eq_state()
        if last_applied_state and eq_states_equal(current_eq, last_applied_state) then
            -- Still owned: restore baseline without persisting to flash
            plugin.eq_apply_state(baseline_state, { persist = false })
        end
    end
    baseline_state = nil
    last_applied_state = nil
    is_suspended = false
    suspension_reason = nil
    last_applied_key = nil
    last_applied_profile = nil
    last_profile_succeeded = false
end

-- UI
local open_main_settings

local function show_profile_picker(title, current_val, on_picked)
    local all_profiles = list_available_profiles()
    local items = { "(None / Clear)" }
    for i = 1, math.min(#all_profiles, MAX_UI_ROWS - 1) do
        items[#items + 1] = all_profiles[i]
    end
    plugin.show_list(title, items, function(idx)
        if idx == 1 then
            on_picked("")
        else
            on_picked(items[idx])
        end
    end)
end

local function show_precedence_and_safety_info()
    local text = "Output-Aware Sound Guidelines:\n\n"
        .. "• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, "
        .. "Output-Aware automation suspends immediately to prevent fighting.\n"
        .. "• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n"
        .. "• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n"
        .. "• Hearing Safety: Does not adjust volume automatically.\n"
        .. "• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n"
        .. "• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."
    if plugin.show_text_view then
        plugin.show_text_view("Sound & Safety Policy", text)
    elseif plugin.show_toast then
        plugin.show_toast("Transient PEQ per route; safe volume, non-bitperfect")
    end
end

open_main_settings = function()
    local status_text
    if not config.enabled then
        status_text = "Disabled"
    elseif is_suspended then
        status_text = "Suspended (" .. (suspension_reason or "External change") .. ")"
    else
        status_text = "Active" .. (last_applied_profile and (": " .. last_applied_profile) or "")
    end

    local current_route_desc = last_applied_key or "Detecting..."

    local route_rows = {
        { key = "wired", label = "Wired Headphones" },
        { key = "usb_dac", label = "USB DAC" },
        { key = "bluetooth:ldac", label = "Bluetooth (LDAC)" },
        { key = "bluetooth:aptx", label = "Bluetooth (aptX)" },
        { key = "bluetooth:aac", label = "Bluetooth (AAC)" },
        { key = "bluetooth:sbc", label = "Bluetooth (SBC)" },
        { key = "bluetooth:default", label = "Bluetooth (Default Fallback)" },
        { key = "bluetooth:unknown", label = "Bluetooth (Unknown Codec)" },
    }

    local rows = {
        {
            type = "toggle",
            label = "Enabled",
            value = config.enabled,
            on_change = function(new_val)
                config.enabled = new_val
                save_config()
                if new_val then
                    grant_control(false)
                else
                    release_control()
                end
                open_main_settings()
            end
        },
        {
            type = "row",
            label = "Status: " .. status_text,
            on_select = function()
                if is_suspended then
                    grant_control(true)
                    if plugin.show_toast then plugin.show_toast("Output-Aware Sound reclaimed") end
                    open_main_settings()
                end
            end
        },
        {
            type = "row",
            label = "Current Route: " .. current_route_desc,
            on_select = function()
                evaluate_current_output()
                open_main_settings()
            end
        }
    }

    for _, item in ipairs(route_rows) do
        local rkey = item.key
        local rlabel = item.label
        local prof = config.routes[rkey] or ""
        rows[#rows + 1] = {
            type = "row",
            label = rlabel .. ": " .. (prof ~= "" and prof or "None"),
            on_select = function()
                show_profile_picker("Profile for " .. rlabel, prof, function(chosen)
                    if chosen == "" or is_valid_profile_name(chosen) then
                        config.routes[rkey] = chosen
                        save_config()
                        if config.enabled and not is_suspended then
                            evaluate_current_output()
                        end
                        open_main_settings()
                    end
                end)
            end
        }
    end

    rows[#rows + 1] = {
        type = "row",
        label = "Policy & Safety Info",
        on_select = show_precedence_and_safety_info
    }

    plugin.show_settings_list("Output-Aware Sound", rows, { update = true })
end

-- Initialize
load_config()
plugin.register_list_item("music_audio", "Output-Aware Sound", open_main_settings)

plugin.on("output_changed", function(current, previous)
    handle_output_snapshot(current)
end)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        config = config,
        load_config = load_config,
        save_config = save_config,
        resolve_route_key = resolve_route_key,
        resolve_profile_for_route_key = resolve_profile_for_route_key,
        handle_output_snapshot = handle_output_snapshot,
        evaluate_current_output = evaluate_current_output,
        grant_control = grant_control,
        release_control = release_control,
        eq_states_equal = eq_states_equal,
        is_valid_profile_name = is_valid_profile_name,
        open_main_settings = open_main_settings,
        get_status = function()
            return {
                enabled = config.enabled,
                suspended = is_suspended,
                reason = suspension_reason,
                last_applied_key = last_applied_key,
                last_applied_profile = last_applied_profile,
                last_succeeded = last_profile_succeeded,
                last_applied_state = last_applied_state,
                baseline_state = baseline_state,
            }
        end,
        set_suspended = function(s, r) is_suspended = s; suspension_reason = r end,
    }
end
