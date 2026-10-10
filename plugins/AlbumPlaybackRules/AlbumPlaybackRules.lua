plugin.define({
    id = "org.compas.album_playback_rules",
    name = "Album Playback Rules",
    version = "1.1",
    api_min = 16,
})

-- Per-Album Playback Rules:
-- Customizes playback settings (gapless, crossfade, ReplayGain, play order) per album.
-- Identifies albums by Artist + Album compound key to handle album name collisions.
-- Matches currently playing track metadata tags (Artist + Album) regardless of queue type.
-- Player API provides no queue introspection: plugin cannot detect full-album queues vs
-- single-track queues, and cannot retroactively change ReplayGain for the first track.
-- ReplayGain mode changes take effect on the next track transition.
-- Snapshots native playback settings when an album session begins.
-- Applies edited rules to active sessions in-flight while preserving original baseline.
-- Transitions to Default restore the original owned baseline value immediately.
-- Applies ONLY changed values (apply_changed_only) because native setters persist.
-- Handles bidirectional coupling between gapless and crossfade:
--   - set_gapless(false) clears crossfade
--   - set_crossfade(true) enables gapless
-- Records actual post-apply changed pair and restores coupled pair ONLY when both
-- current values still match the owned pair, preserving manual user overrides to either field.
-- Discloses that native settings persist in firmware preferences (not transient).

local CONFIG_PATH = plugin.sd_root() .. "/.plugins/album_playback_rules_config.json"
local MAX_UI_ROWS = 500

local config = {
    enabled = false,
    rules = {} -- map of [lower_artist .. "\t" .. lower_album] = rule_table
}

local active_session = nil

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

local function make_album_key(artist, album)
    if not artist or not album then return nil end
    local a = artist:gsub("^%s+", ""):gsub("%s+$", ""):lower()
    local b = album:gsub("^%s+", ""):gsub("%s+$", ""):lower()
    if a == "" or b == "" then return nil end
    return a .. "\t" .. b
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
    if type(data.rules) == "table" then
        config.rules = {}
        local count = 0
        for k, v in pairs(data.rules) do
            if count >= MAX_UI_ROWS then break end
            if type(v) == "table" and type(v.artist) == "string" and #v.artist > 0 and #v.artist <= 256
               and type(v.album) == "string" and #v.album > 0 and #v.album <= 256 then
                local rule_key = make_album_key(v.artist, v.album)
                if rule_key then
                    local cf = nil
                    if type(v.crossfade) == "boolean" then cf = v.crossfade end
                    local gl = nil
                    if type(v.gapless) == "boolean" then gl = v.gapless end

                    -- Normalize contradictory rule: gapless=false and crossfade=true cannot coexist natively
                    if gl == false and cf == true then
                        cf = false
                    end

                    local rg = nil
                    if v.replaygain == "off" or v.replaygain == "track" or v.replaygain == "album" then
                        rg = v.replaygain
                    end

                    local pm = nil
                    if v.play_mode == "sequential" or v.play_mode == "repeat_all"
                       or v.play_mode == "repeat_one" or v.play_mode == "shuffle" then
                        pm = v.play_mode
                    end

                    config.rules[rule_key] = {
                        artist = v.artist,
                        album = v.album,
                        crossfade = cf,
                        gapless = gl,
                        replaygain = rg,
                        play_mode = pm,
                    }
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

local function get_current_track_identity()
    local path = plugin.get_current_track_path and plugin.get_current_track_path()
    local artist, album = nil, nil
    if path and plugin.has_capability and plugin.has_capability("library.track_metadata") and plugin.get_track_metadata then
        local meta = plugin.get_track_metadata(path)
        if meta then
            if meta.album_artist and meta.album_artist ~= "" then
                artist = meta.album_artist
            elseif meta.artist and meta.artist ~= "" then
                artist = meta.artist
            end
            if meta.album and meta.album ~= "" then
                album = meta.album
            end
        end
    end

    if (not artist or artist == "" or not album or album == "") and plugin.get_now_playing then
        local _, np_artist, np_album = plugin.get_now_playing()
        if not artist or artist == "" then artist = np_artist end
        if not album or album == "" then album = np_album end
    end

    if artist and artist ~= "" and album and album ~= "" then
        return artist, album
    end
    return nil, nil
end

local function restore_session(session)
    if not session or not session.applied then return end

    -- 1. Restore play_mode if owned
    if session.applied.play_mode ~= nil and plugin.get_play_mode and plugin.set_play_mode then
        local cur = plugin.get_play_mode()
        if cur == session.applied.play_mode then
            if session.baseline.play_mode ~= nil and session.baseline.play_mode ~= cur then
                plugin.set_play_mode(session.baseline.play_mode)
            end
        end
    end

    -- 2. Restore replaygain if owned
    if session.applied.replaygain ~= nil and plugin.get_replaygain_mode and plugin.set_replaygain_mode then
        local cur = plugin.get_replaygain_mode()
        if cur == session.applied.replaygain then
            if session.baseline.replaygain ~= nil and session.baseline.replaygain ~= cur then
                plugin.set_replaygain_mode(session.baseline.replaygain)
            end
        end
    end

    -- 3. Restore coupled gapless and crossfade pair
    local can_settings = plugin.has_capability and plugin.has_capability("playback.settings")
    if can_settings and session.applied.coupled_pair and plugin.get_gapless and plugin.set_gapless and plugin.get_crossfade and plugin.set_crossfade then
        local cur_gapless = plugin.get_gapless()
        local cur_crossfade = plugin.get_crossfade()

        -- Restore coupled pair ONLY when BOTH current values still match the owned pair!
        -- If user manually modified either field, do NOT clobber the user's manual override.
        if cur_gapless == session.applied.gapless and cur_crossfade == session.applied.crossfade then
            -- Restore in proper order respecting bidirectional coupling:
            if session.baseline.gapless == false then
                -- Disabling gapless also clears crossfade natively
                plugin.set_gapless(false)
            elseif session.baseline.crossfade == true then
                -- Enabling crossfade also enables gapless natively
                plugin.set_crossfade(true)
            else
                -- baseline is gapless=true and crossfade=false:
                plugin.set_crossfade(false)
                plugin.set_gapless(true)
            end
        end
    end
end

local function apply_rule_to_session(session, rule)
    local can_settings = plugin.has_capability and plugin.has_capability("playback.settings")
    local baseline = session.baseline
    local applied = session.applied

    -- 1. Play mode
    if plugin.get_play_mode and plugin.set_play_mode then
        local target_pm = rule.play_mode
        if target_pm == nil then
            -- Transition to Default: restore original baseline value immediately if still owned
            if applied.play_mode ~= nil then
                local cur_pm = plugin.get_play_mode()
                if cur_pm == applied.play_mode then
                    if baseline.play_mode ~= nil and baseline.play_mode ~= cur_pm then
                        plugin.set_play_mode(baseline.play_mode)
                    end
                end
                applied.play_mode = nil
            end
        else
            -- Explicit play mode target
            -- If already applied this target, rule didn't change play_mode:
            -- avoid flash writes and do not override manual user changes!
            if applied.play_mode ~= target_pm then
                local cur_pm = plugin.get_play_mode()
                if cur_pm ~= target_pm then
                    plugin.set_play_mode(target_pm)
                end
                applied.play_mode = target_pm
            end
        end
    end

    -- 2. ReplayGain (takes effect on next track transition)
    if can_settings and plugin.get_replaygain_mode and plugin.set_replaygain_mode then
        local target_rg = rule.replaygain
        if target_rg == nil then
            -- Transition to Default: restore original baseline value immediately if still owned
            if applied.replaygain ~= nil then
                local cur_rg = plugin.get_replaygain_mode()
                if cur_rg == applied.replaygain then
                    if baseline.replaygain ~= nil and baseline.replaygain ~= cur_rg then
                        plugin.set_replaygain_mode(baseline.replaygain)
                    end
                end
                applied.replaygain = nil
            end
        else
            -- Explicit ReplayGain target
            if applied.replaygain ~= target_rg then
                local cur_rg = plugin.get_replaygain_mode()
                if cur_rg ~= target_rg then
                    plugin.set_replaygain_mode(target_rg)
                end
                applied.replaygain = target_rg
            end
        end
    end

    -- 3. Gapless and Crossfade (coupled pair)
    if can_settings and plugin.get_gapless and plugin.set_gapless and plugin.get_crossfade and plugin.set_crossfade then
        local rule_gl = rule.gapless
        local rule_cf = rule.crossfade
        -- Normalize contradictory rule: gapless=false and crossfade=true cannot coexist natively
        if rule_gl == false and rule_cf == true then
            rule_cf = false
        end

        local rule_gl_changed = (applied.rule_gapless ~= rule_gl)
        local rule_cf_changed = (applied.rule_crossfade ~= rule_cf)

        if rule_gl_changed or rule_cf_changed then
            if rule_gl == nil and rule_cf == nil then
                -- Both transitioned to Default: restore original baseline values immediately if still owned
                if applied.coupled_pair then
                    local cur_gl = plugin.get_gapless()
                    local cur_cf = plugin.get_crossfade()
                    if cur_gl == applied.gapless and cur_cf == applied.crossfade then
                        if baseline.gapless == false then
                            if cur_gl ~= false then plugin.set_gapless(false) end
                        elseif baseline.crossfade == true then
                            if cur_cf ~= true then plugin.set_crossfade(true) end
                        else
                            if cur_cf ~= false then plugin.set_crossfade(false) end
                            if plugin.get_gapless() ~= true then plugin.set_gapless(true) end
                        end
                    end
                    applied.coupled_pair = nil
                    applied.gapless = nil
                    applied.crossfade = nil
                end
                applied.rule_gapless = nil
                applied.rule_crossfade = nil
            else
                local cur_gl = plugin.get_gapless()
                local cur_cf = plugin.get_crossfade()

                -- Target values: if a field is nil, target is its original baseline value
                local target_gl = baseline.gapless
                if rule_gl ~= nil then target_gl = rule_gl end
                local target_cf = baseline.crossfade
                if rule_cf ~= nil then target_cf = rule_cf end
                if target_gl == false and target_cf == true then
                    target_cf = false
                end

                -- Apply in proper order respecting firmware bidirectional coupling,
                -- avoiding flash writes if already matching target
                if target_gl == false then
                    if cur_gl ~= false then
                        plugin.set_gapless(false)
                    end
                elseif target_cf == true then
                    if cur_cf ~= true then
                        plugin.set_crossfade(true)
                    end
                else
                    -- target_gl == true and target_cf == false
                    if cur_cf ~= false then
                        plugin.set_crossfade(false)
                    end
                    if plugin.get_gapless() ~= true then
                        plugin.set_gapless(true)
                    end
                end

                local post_gl = plugin.get_gapless()
                local post_cf = plugin.get_crossfade()
                applied.gapless = post_gl
                applied.crossfade = post_cf
                applied.rule_gapless = rule_gl
                applied.rule_crossfade = rule_cf

                if post_gl ~= baseline.gapless or post_cf ~= baseline.crossfade then
                    applied.coupled_pair = true
                else
                    applied.coupled_pair = nil
                end
            end
        end
    end
end

local function start_new_session(rule, artist, album, key)
    local can_settings = plugin.has_capability and plugin.has_capability("playback.settings")
    local baseline = {
        gapless = nil,
        crossfade = nil,
        replaygain = nil,
        play_mode = nil,
    }
    if can_settings and plugin.get_gapless then
        baseline.gapless = plugin.get_gapless()
    end
    if can_settings and plugin.get_crossfade then
        baseline.crossfade = plugin.get_crossfade()
    end
    if can_settings and plugin.get_replaygain_mode then
        baseline.replaygain = plugin.get_replaygain_mode()
    end
    if plugin.get_play_mode then
        baseline.play_mode = plugin.get_play_mode()
    end

    local session = {
        artist = artist,
        album = album,
        key = key,
        baseline = baseline,
        applied = {},
    }
    active_session = session
    apply_rule_to_session(session, rule)
end

local function evaluate_playback()
    if not config.enabled then return end

    local artist, album = get_current_track_identity()
    if not artist or not album then
        if active_session then
            restore_session(active_session)
            active_session = nil
        end
        return
    end

    local key = make_album_key(artist, album)

    -- If left previous album session for a different album, restore it
    if active_session and active_session.key ~= key then
        restore_session(active_session)
        active_session = nil
    end

    local rule = config.rules[key]
    if not rule then
        -- No rule configured for this album
        if active_session then
            restore_session(active_session)
            active_session = nil
        end
        return
    end

    if active_session and active_session.key == key then
        -- Same album session: apply any in-flight rule edits to active session
        -- (preserves ORIGINAL baseline across edits, applies changed only)
        apply_rule_to_session(active_session, rule)
    else
        -- Start new album session: capture initial baseline and apply rule
        start_new_session(rule, artist, album, key)
    end
end

-- UI
local open_main_settings
local open_edit_rule

local function show_precedence_and_replaygain_info()
    local text = "Per-Album Playback Rules Information:\n\n"
        .. "• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n"
        .. "• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n"
        .. "• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n"
        .. "• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n"
        .. "• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."
    if plugin.show_text_view then
        plugin.show_text_view("Album Rules Policy", text)
    elseif plugin.show_toast then
        plugin.show_toast("Matches track tags; ReplayGain takes effect next track")
    end
end

open_edit_rule = function(key)
    local rule = config.rules[key]
    if not rule then return end

    local function cf_label()
        if rule.crossfade == nil then return "Crossfade: Default"
        elseif rule.crossfade then return "Crossfade: Enabled"
        else return "Crossfade: Disabled" end
    end

    local function gapless_label()
        if rule.gapless == nil then return "Gapless: Default"
        elseif rule.gapless then return "Gapless: Enabled"
        else return "Gapless: Disabled" end
    end

    local function rg_label()
        if rule.replaygain == nil then return "ReplayGain: Default"
        else return "ReplayGain: " .. rule.replaygain end
    end

    local function pm_label()
        if rule.play_mode == nil then return "Play Order: Default"
        else return "Play Order: " .. rule.play_mode end
    end

    local rows = {
        {
            type = "row",
            label = "Album: " .. rule.album,
            on_select = function() end
        },
        {
            type = "row",
            label = "Artist: " .. rule.artist,
            on_select = function() end
        },
        {
            type = "row",
            label = cf_label(),
            on_select = function()
                if rule.crossfade == nil then
                    rule.crossfade = true
                    rule.gapless = true -- crossfade=true requires gapless=true natively
                elseif rule.crossfade == true then
                    rule.crossfade = false
                else
                    rule.crossfade = nil
                end
                save_config()
                if config.enabled and active_session and active_session.key == key then
                    evaluate_playback()
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = gapless_label(),
            on_select = function()
                if rule.gapless == nil then
                    rule.gapless = true
                elseif rule.gapless == true then
                    rule.gapless = false
                    rule.crossfade = false -- gapless=false forces crossfade=false natively
                else
                    rule.gapless = nil
                end
                save_config()
                if config.enabled and active_session and active_session.key == key then
                    evaluate_playback()
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = rg_label(),
            on_select = function()
                local modes = { "off", "track", "album" }
                local cur_idx = 0
                for i, m in ipairs(modes) do
                    if rule.replaygain == m then cur_idx = i break end
                end
                if cur_idx == 0 then rule.replaygain = "album"
                elseif cur_idx == 3 then rule.replaygain = "track"
                elseif cur_idx == 2 then rule.replaygain = "off"
                else rule.replaygain = nil end
                save_config()
                if config.enabled and active_session and active_session.key == key then
                    evaluate_playback()
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = pm_label(),
            on_select = function()
                local modes = { "sequential", "repeat_all", "repeat_one", "shuffle" }
                local cur_idx = 0
                for i, m in ipairs(modes) do
                    if rule.play_mode == m then cur_idx = i break end
                end
                if cur_idx == 0 then rule.play_mode = "sequential"
                elseif cur_idx == 1 then rule.play_mode = "repeat_all"
                elseif cur_idx == 2 then rule.play_mode = "repeat_one"
                elseif cur_idx == 3 then rule.play_mode = "shuffle"
                else rule.play_mode = nil end
                save_config()
                if config.enabled and active_session and active_session.key == key then
                    evaluate_playback()
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = "Delete Rule",
            on_select = function()
                config.rules[key] = nil
                save_config()
                if active_session and active_session.key == key then
                    restore_session(active_session)
                    active_session = nil
                end
                open_main_settings()
            end
        }
    }
    plugin.show_settings_list("Edit Album Rule", rows, { update = true })
end

open_main_settings = function()
    local rule_count = 0
    for _ in pairs(config.rules) do rule_count = rule_count + 1 end

    local current_desc = "None"
    if active_session and active_session.artist and active_session.album then
        current_desc = active_session.artist .. " — " .. active_session.album
    end

    local rows = {
        {
            type = "toggle",
            label = "Enabled",
            value = config.enabled,
            on_change = function(new_val)
                config.enabled = new_val
                save_config()
                if new_val then
                    evaluate_playback()
                else
                    if active_session then
                        restore_session(active_session)
                        active_session = nil
                    end
                end
                open_main_settings()
            end
        },
        {
            type = "row",
            label = "Active Session: " .. current_desc,
            on_select = function() end
        },
        {
            type = "row",
            label = "Add Rule for Current Album...",
            on_select = function()
                local artist, album = get_current_track_identity()
                if not artist or not album then
                    if plugin.show_toast then plugin.show_toast("No album currently playing") end
                    return
                end
                local key = make_album_key(artist, album)
                if not config.rules[key] then
                    config.rules[key] = {
                        artist = artist,
                        album = album,
                        gapless = true,
                        crossfade = false,
                        replaygain = "album",
                        play_mode = "sequential",
                    }
                    save_config()
                    if config.enabled then evaluate_playback() end
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = "Add Rule Manually...",
            on_select = function()
                plugin.show_text_input("Artist Name", "", false, function(artist_name)
                    if not artist_name or artist_name:gsub("%s+", "") == "" then return end
                    plugin.show_text_input("Album Name", "", false, function(album_name)
                        if not album_name or album_name:gsub("%s+", "") == "" then return end
                        local key = make_album_key(artist_name, album_name)
                        if key then
                            if not config.rules[key] then
                                config.rules[key] = {
                                    artist = artist_name,
                                    album = album_name,
                                    gapless = true,
                                    crossfade = false,
                                    replaygain = "album",
                                    play_mode = "sequential",
                                }
                                save_config()
                                if config.enabled then evaluate_playback() end
                            end
                            open_edit_rule(key)
                        end
                    end)
                end)
            end
        },
        {
            type = "row",
            label = "Persistence & ReplayGain Info",
            on_select = show_precedence_and_replaygain_info
        }
    }

    local rule_keys = {}
    for k in pairs(config.rules) do rule_keys[#rule_keys + 1] = k end
    table.sort(rule_keys)
    local limit = math.min(#rule_keys, MAX_UI_ROWS - #rows)
    for i = 1, limit do
        local rk = rule_keys[i]
        local r = config.rules[rk]
        rows[#rows + 1] = {
            type = "row",
            label = r.artist .. " — " .. r.album,
            on_select = function()
                open_edit_rule(rk)
            end
        }
    end

    plugin.show_settings_list("Album Playback Rules", rows, { update = true })
end

-- Initialize
load_config()
plugin.register_list_item("playback", "Album Playback Rules", open_main_settings)

plugin.on("track_started", function()
    evaluate_playback()
end)

plugin.on("stopped", function()
    if active_session then
        restore_session(active_session)
        active_session = nil
    end
end)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        config = config,
        load_config = load_config,
        save_config = save_config,
        make_album_key = make_album_key,
        get_current_track_identity = get_current_track_identity,
        evaluate_playback = evaluate_playback,
        restore_session = restore_session,
        apply_album_rules = start_new_session,
        apply_rule_to_session = apply_rule_to_session,
        start_new_session = start_new_session,
        open_main_settings = open_main_settings,
        open_edit_rule = open_edit_rule,
        get_active_session = function() return active_session end,
        set_active_session = function(s) active_session = s end,
    }
end
