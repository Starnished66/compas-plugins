plugin.define({
    id = "org.compas.autoeq_context",
    name = "AutoEQ Context",
    version = "1.1",
    api_min = 16,
})

-- AutoEQ by Context:
-- Automatically applies PEQ profiles based on folder, artist, or genre context.
-- Uses transient profile application (persist = false) to prevent flash writes on track changes.
-- Deterministic precedence: Folder (longest prefix) > Artist > Genre > Default profile.
--
-- EQ Ownership Policy:
-- - Detached snapshot of last applied EQ state is maintained with 1e-6 precision.
-- - Before automatic transition, current EQ is compared to last applied state.
-- - If state differs, automatic writes suspend immediately until re-enabled/reclaimed.
-- - Baseline EQ is restored on leaving matched context or on disable if still owned.
-- - Baseline EQ is preserved across rule/profile edits while owned.

local CONFIG_PATH = plugin.sd_root() .. "/.plugins/autoeq_context_config.json"
local PROFILES_DIR = plugin.sd_root() .. "/PEQ_Profiles"
local MAX_UI_ROWS = 500
local EPSILON = 1e-6

local config = {
    enabled = false,
    default_profile = "",
    rules = {
        folder = {}, -- array of { folder = "/path", profile = "name.peq" }
        artist = {}, -- map of [lower_artist] = "name.peq"
        genre = {},  -- map of [lower_genre] = "name.peq"
    }
}

local baseline_state = nil
local last_applied_state = nil
local is_suspended = false
local suspension_reason = nil
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

local function normalize_folder(f)
    if not f or f == "" then return "" end
    f = f:gsub("\\", "/")
    f = f:gsub("/+$", "")
    return f
end

local function folder_matches_track(folder_rule, track_path)
    if not folder_rule or folder_rule == "" or not track_path or track_path == "" then
        return false
    end
    folder_rule = normalize_folder(folder_rule)
    track_path = track_path:gsub("\\", "/")
    local f_len = #folder_rule
    local t_len = #track_path
    if t_len < f_len then return false end

    if string.lower(track_path:sub(1, f_len)) ~= string.lower(folder_rule) then
        return false
    end

    if t_len == f_len then return true end
    local next_char = track_path:sub(f_len + 1, f_len + 1)
    return next_char == "/"
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
    if type(data.default_profile) == "string" and (data.default_profile == "" or is_valid_profile_name(data.default_profile)) then
        config.default_profile = data.default_profile
    end
    if type(data.rules) == "table" then
        if type(data.rules.folder) == "table" then
            config.rules.folder = {}
            for _, r in ipairs(data.rules.folder) do
                if #config.rules.folder >= MAX_UI_ROWS then break end
                if type(r) == "table" and type(r.folder) == "string" and #r.folder > 0 and #r.folder <= 512
                   and is_valid_profile_name(r.profile) then
                    config.rules.folder[#config.rules.folder + 1] = {
                        folder = normalize_folder(r.folder),
                        profile = r.profile
                    }
                end
            end
        end
        if type(data.rules.artist) == "table" then
            config.rules.artist = {}
            local count = 0
            for k, v in pairs(data.rules.artist) do
                if count >= MAX_UI_ROWS then break end
                if type(k) == "string" and #k > 0 and #k <= 256 and is_valid_profile_name(v) then
                    config.rules.artist[string.lower(k)] = v
                    count = count + 1
                end
            end
        end
        if type(data.rules.genre) == "table" then
            config.rules.genre = {}
            local count = 0
            for k, v in pairs(data.rules.genre) do
                if count >= MAX_UI_ROWS then break end
                if type(k) == "string" and #k > 0 and #k <= 256 and is_valid_profile_name(v) then
                    config.rules.genre[string.lower(k)] = v
                    count = count + 1
                end
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

-- Resolve matching profile deterministically:
-- 1. Folder rule (longest prefix)
-- 2. Artist rule
-- 3. Genre rule
-- 4. Default fallback profile
local function resolve_profile_for_track(track_path)
    if not track_path or track_path == "" then
        return nil, "unresolved"
    end

    -- 1. Folder match: longest prefix
    local best_rule = nil
    local best_len = -1
    for _, r in ipairs(config.rules.folder) do
        if folder_matches_track(r.folder, track_path) then
            local norm = normalize_folder(r.folder)
            if #norm > best_len then
                best_len = #norm
                best_rule = r
            end
        end
    end
    if best_rule and is_valid_profile_name(best_rule.profile) then
        return best_rule.profile, "folder"
    end

    -- Metadata retrieval
    local meta = nil
    if plugin.has_capability and plugin.has_capability("library.track_metadata") and plugin.get_track_metadata then
        meta = plugin.get_track_metadata(track_path)
    end

    -- 2. Artist match
    local artist = nil
    if meta and meta.artist and meta.artist ~= "" then
        artist = meta.artist
    elseif plugin.get_now_playing then
        local _, np_artist = plugin.get_now_playing()
        if np_artist and np_artist ~= "" then artist = np_artist end
    end
    if artist then
        local prof = config.rules.artist[string.lower(artist)]
        if prof and is_valid_profile_name(prof) then
            return prof, "artist"
        end
    end

    -- 3. Genre match: nil or empty means unavailable
    local genre = meta and meta.genre
    if genre and genre ~= "" then
        local prof = config.rules.genre[string.lower(genre)]
        if prof and is_valid_profile_name(prof) then
            return prof, "genre"
        end
    end

    -- 4. Default profile
    if config.default_profile and is_valid_profile_name(config.default_profile) then
        return config.default_profile, "default"
    end

    return nil, "none"
end

local function apply_target_profile(profile_name)
    if not is_valid_profile_name(profile_name) then return false end
    local full_path = PROFILES_DIR .. "/" .. profile_name
    if not (plugin.has_capability and plugin.has_capability("audio.peq.transient") and plugin.eq_apply_profile) then
        return false
    end
    return plugin.eq_apply_profile(full_path, { persist = false })
end

local function evaluate_current_track()
    if not config.enabled then return end
    if is_suspended then return end

    local track_path = plugin.get_current_track_path and plugin.get_current_track_path()
    local target_profile, match_type = resolve_profile_for_track(track_path)

    if not target_profile or target_profile == "" then
        -- Unmatched, tagless, remote, or unresolved track:
        -- If we previously applied a transient profile, restore the runtime baseline!
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
            last_profile_succeeded = false
        end
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

    -- Cache successful context, retry failed profile
    if target_profile == last_applied_profile and last_profile_succeeded then
        return
    end

    local ok = apply_target_profile(target_profile)
    if ok then
        last_applied_profile = target_profile
        last_profile_succeeded = true
        if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
            last_applied_state = plugin.get_eq_state()
        end
    else
        last_applied_profile = target_profile
        last_profile_succeeded = false -- Ensures retry on next track
    end
end

local function grant_control(is_reclaiming)
    is_suspended = false
    suspension_reason = nil
    last_applied_profile = nil
    last_profile_succeeded = false

    if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
        local current_eq = plugin.get_eq_state()
        -- Recapture baseline only if we have no baseline, or if explicitly reclaiming after manual/external modification
        if baseline_state == nil or is_reclaiming or (last_applied_state and not eq_states_equal(current_eq, last_applied_state)) then
            baseline_state = current_eq
        end
        last_applied_state = plugin.get_eq_state()
    end
    evaluate_current_track()
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

local function open_folder_rules()
    local rows = {
        {
            type = "row",
            label = "+ Add Folder Rule...",
            on_select = function()
                plugin.show_text_input("Folder Path", "/Music/", false, function(folder_path)
                    folder_path = normalize_folder(folder_path)
                    if folder_path ~= "" then
                        show_profile_picker("Select Profile for Folder", "", function(prof)
                            if prof ~= "" and is_valid_profile_name(prof) then
                                config.rules.folder[#config.rules.folder + 1] = { folder = folder_path, profile = prof }
                                save_config()
                                if config.enabled and not is_suspended then evaluate_current_track() end
                                open_folder_rules()
                            end
                        end)
                    end
                end)
            end
        }
    }
    local limit = math.min(#config.rules.folder, MAX_UI_ROWS - 1)
    for i = 1, limit do
        local r = config.rules.folder[i]
        local idx = i
        rows[#rows + 1] = {
            type = "row",
            label = r.folder .. " -> " .. r.profile,
            on_select = function()
                plugin.show_list("Rule: " .. r.folder, { "Change Profile", "Delete Rule" }, function(action_idx)
                    if action_idx == 1 then
                        show_profile_picker("New Profile", r.profile, function(new_prof)
                            if new_prof ~= "" and is_valid_profile_name(new_prof) then
                                config.rules.folder[idx].profile = new_prof
                            else
                                table.remove(config.rules.folder, idx)
                            end
                            save_config()
                            if config.enabled and not is_suspended then evaluate_current_track() end
                            open_folder_rules()
                        end)
                    elseif action_idx == 2 then
                        table.remove(config.rules.folder, idx)
                        save_config()
                        if config.enabled and not is_suspended then evaluate_current_track() end
                        open_folder_rules()
                    end
                end)
            end
        }
    end
    plugin.show_settings_list("Folder Rules", rows, { update = true })
end

local function open_artist_rules()
    local rows = {
        {
            type = "row",
            label = "+ Add Artist Rule...",
            on_select = function()
                plugin.show_text_input("Artist Name", "", false, function(artist_name)
                    local key = artist_name:gsub("^%s+", ""):gsub("%s+$", "")
                    if key ~= "" then
                        show_profile_picker("Select Profile for Artist", "", function(prof)
                            if prof ~= "" and is_valid_profile_name(prof) then
                                config.rules.artist[string.lower(key)] = prof
                                save_config()
                                if config.enabled and not is_suspended then evaluate_current_track() end
                                open_artist_rules()
                            end
                        end)
                    end
                end)
            end
        }
    }
    local keys = {}
    for k in pairs(config.rules.artist) do keys[#keys + 1] = k end
    table.sort(keys)
    local limit = math.min(#keys, MAX_UI_ROWS - 1)
    for i = 1, limit do
        local k = keys[i]
        local prof = config.rules.artist[k]
        rows[#rows + 1] = {
            type = "row",
            label = k .. " -> " .. prof,
            on_select = function()
                plugin.show_list("Artist: " .. k, { "Change Profile", "Delete Rule" }, function(action_idx)
                    if action_idx == 1 then
                        show_profile_picker("New Profile", prof, function(new_prof)
                            if new_prof ~= "" and is_valid_profile_name(new_prof) then
                                config.rules.artist[k] = new_prof
                            else
                                config.rules.artist[k] = nil
                            end
                            save_config()
                            if config.enabled and not is_suspended then evaluate_current_track() end
                            open_artist_rules()
                        end)
                    elseif action_idx == 2 then
                        config.rules.artist[k] = nil
                        save_config()
                        if config.enabled and not is_suspended then evaluate_current_track() end
                        open_artist_rules()
                    end
                end)
            end
        }
    end
    plugin.show_settings_list("Artist Rules", rows, { update = true })
end

local function open_genre_rules()
    local rows = {
        {
            type = "row",
            label = "+ Add Genre Rule...",
            on_select = function()
                plugin.show_text_input("Genre Name", "", false, function(genre_name)
                    local key = genre_name:gsub("^%s+", ""):gsub("%s+$", "")
                    if key ~= "" then
                        show_profile_picker("Select Profile for Genre", "", function(prof)
                            if prof ~= "" and is_valid_profile_name(prof) then
                                config.rules.genre[string.lower(key)] = prof
                                save_config()
                                if config.enabled and not is_suspended then evaluate_current_track() end
                                open_genre_rules()
                            end
                        end)
                    end
                end)
            end
        }
    }
    local keys = {}
    for k in pairs(config.rules.genre) do keys[#keys + 1] = k end
    table.sort(keys)
    local limit = math.min(#keys, MAX_UI_ROWS - 1)
    for i = 1, limit do
        local k = keys[i]
        local prof = config.rules.genre[k]
        rows[#rows + 1] = {
            type = "row",
            label = k .. " -> " .. prof,
            on_select = function()
                plugin.show_list("Genre: " .. k, { "Change Profile", "Delete Rule" }, function(action_idx)
                    if action_idx == 1 then
                        show_profile_picker("New Profile", prof, function(new_prof)
                            if new_prof ~= "" and is_valid_profile_name(new_prof) then
                                config.rules.genre[k] = new_prof
                            else
                                config.rules.genre[k] = nil
                            end
                            save_config()
                            if config.enabled and not is_suspended then evaluate_current_track() end
                            open_genre_rules()
                        end)
                    elseif action_idx == 2 then
                        config.rules.genre[k] = nil
                        save_config()
                        if config.enabled and not is_suspended then evaluate_current_track() end
                        open_genre_rules()
                    end
                end)
            end
        }
    end
    plugin.show_settings_list("Genre Rules", rows, { update = true })
end

local function show_precedence_info()
    local text = "AutoEQ Context Rules Precedence:\n\n"
        .. "1. Folder (longest path prefix boundary match)\n"
        .. "2. Artist (exact match from metadata)\n"
        .. "3. Genre (exact match from get_track_metadata)\n"
        .. "4. Default Profile (fallback)\n\n"
        .. "Profiles are applied transiently (persist = false).\n"
        .. "If an unmapped or tagless track plays, owned baseline is restored.\n"
        .. "If EQ state is modified externally (manual EQ or Output-Aware Sound), "
        .. "automation suspends until re-enabled to prevent fighting."
    if plugin.show_text_view then
        plugin.show_text_view("Priority & Precedence", text)
    elseif plugin.show_toast then
        plugin.show_toast("Precedence: Folder > Artist > Genre > Default")
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

    local artist_count = 0
    for _ in pairs(config.rules.artist) do artist_count = artist_count + 1 end
    local genre_count = 0
    for _ in pairs(config.rules.genre) do genre_count = genre_count + 1 end

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
                    if plugin.show_toast then plugin.show_toast("AutoEQ Context reclaimed") end
                    open_main_settings()
                end
            end
        },
        {
            type = "row",
            label = "Folder Rules (" .. #config.rules.folder .. ")",
            on_select = open_folder_rules
        },
        {
            type = "row",
            label = "Artist Rules (" .. artist_count .. ")",
            on_select = open_artist_rules
        },
        {
            type = "row",
            label = "Genre Rules (" .. genre_count .. ")",
            on_select = open_genre_rules
        },
        {
            type = "row",
            label = "Default Profile: " .. (config.default_profile ~= "" and config.default_profile or "None"),
            on_select = function()
                show_profile_picker("Select Default Profile", config.default_profile, function(prof)
                    if prof == "" or is_valid_profile_name(prof) then
                        config.default_profile = prof
                        save_config()
                        if config.enabled and not is_suspended then evaluate_current_track() end
                        open_main_settings()
                    end
                end)
            end
        },
        {
            type = "row",
            label = "Priority & Precedence Info",
            on_select = show_precedence_info
        }
    }
    plugin.show_settings_list("AutoEQ Context", rows, { update = true })
end

-- Initialize
load_config()
plugin.register_list_item("music_audio", "AutoEQ Context", open_main_settings)

plugin.on("track_started", function()
    evaluate_current_track()
end)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        config = config,
        load_config = load_config,
        save_config = save_config,
        folder_matches_track = folder_matches_track,
        resolve_profile_for_track = resolve_profile_for_track,
        evaluate_current_track = evaluate_current_track,
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
                last_applied_profile = last_applied_profile,
                last_succeeded = last_profile_succeeded,
                last_applied_state = last_applied_state,
                baseline_state = baseline_state,
            }
        end,
        set_suspended = function(s, r) is_suspended = s; suspension_reason = r end,
    }
end
