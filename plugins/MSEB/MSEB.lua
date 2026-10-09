plugin.define({ id = "example.mseb", name = "MSEB", version = "1.4", api_min = 16 })

-- Mood-based tone tuning on this app's 10-band parametric EQ
-- (src/audio/peq.c). Adds an MSEB row under Settings -> Music Settings ->
-- Audio. Sound Stage uses the reusable stereo-width API:
-- stereo width is a normalized mid/side matrix saved in the same profile.
-- It is not crossfeed, delay, or convolution; Impulse remains tonal EQ.
--
-- Seven controls are in both curves: Sound Temperature, Bass Extension,
-- Bass Texture, Note Thickness, Vocal Position, Female Vocal, and Air.
-- curve=legacy is the 1.1 mapping, including Instrument Presence, Bass
-- Bite, and Treble Bite. curve=new replaces those three with this plugin's
-- own Sibilance LF / HF peaks and a wide 7.5 kHz level called Impulse.
-- That level is not attack processing. A file with no curve marker is
-- legacy, so opening or upgrading does not retune an existing user. A
-- missing state file starts on curve=new. Switching is a confirmed action.
local OLD_FREQS = { 31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 }
local OLD_Q     = { 0.2, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.2 }
local NEW_FREQS = { 31, 62, 125, 250, 500, 1000, 7500, 5800, 9200, 16000 }
local NEW_Q     = { 0.2, 0.7, 0.7, 0.7, 0.7, 0.7, 0.4, 1.0, 1.0, 0.2 }
local BAND_TYPE  = { "low_shelf", "peaking", "peaking", "peaking", "peaking",
                      "peaking", "peaking", "peaking", "peaking", "high_shelf" }

-- Each axis is -100..100. `contrib` is the PEQ band (1-based, matching
-- plugin.eq_set_band()) and the dB at full deflection. `mode` nil means the
-- axis is in both curves. Only band 1 and band 10 are shared by two live
-- axes. Contributions to one band are summed, then clamped to ±12 dB.
local AXES = {
    { key = "sound_stage", contrib = {} },
    { key = "temperature",  contrib = { { band = 1, db = 3 }, { band = 10, db = -4 } } },
    { key = "bass_ext",     contrib = { { band = 1, db = 6 } } },
    { key = "bass_texture", contrib = { { band = 2, db = 5 } } },
    { key = "thickness",    contrib = { { band = 4, db = 5 } } },
    { key = "vocal_pos",    contrib = { { band = 5, db = 5 } } },
    { key = "female_vocal", contrib = { { band = 6, db = 4 } } },
    { key = "air",          contrib = { { band = 10, db = 5 } } },
    { key = "instruments",  mode = "legacy", contrib = { { band = 3, db = 3 }, { band = 7, db = 4 } } },
    { key = "bass_bite",    mode = "legacy", contrib = { { band = 8, db = 4 } } },
    { key = "treble_bite",  mode = "legacy", contrib = { { band = 9, db = 4 } } },
    { key = "sibilance_lf", mode = "new",    contrib = { { band = 8, db = 4 } } },
    { key = "sibilance_hf", mode = "new",    contrib = { { band = 9, db = 4 } } },
    { key = "impulse_tone", mode = "new",    contrib = { { band = 7, db = 3 } } },
}

local PLUGIN_DIR = plugin.sd_root() .. "/.plugins"
local STATE_PATH = PLUGIN_DIR .. "/.mseb_state"
-- Snapshot of whatever manual PEQ curve was live right before MSEB was
-- first enabled -- see set_enabled() below. Written/read only via
-- plugin.eq_save_profile()/eq_load_profile(), never parsed here directly.
local BACKUP_PATH = PLUGIN_DIR .. "/.mseb_pre_backup.peq"
local PROFILE_PATH = PLUGIN_DIR .. "/.mseb_active.peq"
-- Loudness Boost (PlaybackExtras) also snapshots and restores the whole EQ.
-- Its backup exists exactly while it is on, and two independent snapshots
-- cannot be restored in any order, so MSEB refuses to turn on beside it.
local OTHER_EQ_OWNER_BACKUP = PLUGIN_DIR .. "/.playback_extras_backup.peq"

local function slot_path(n)
    return PLUGIN_DIR .. "/.mseb_slot" .. n
end

-- Reads a plain key=value\n file into a table via repeated single-line
-- reads (same io pattern SoundProfiles.lua's own read_state() uses) --
-- deliberately not f:lines(), to stay within the exact io usage already
-- demonstrated as safe in this plugin sandbox.
local function read_kv_file(path)
    local out = {}
    local f = io.open(path, "r")
    if not f then return out, false end
    local line = f:read("*l")
    while line do
        local k, v = line:match("^([%w_]+)=(.-)$")
        if k then out[k] = v end
        line = f:read("*l")
    end
    f:close()
    return out, true
end

local function file_exists(path)
    local f = io.open(path, "r")
    if f then f:close() return true end
    return false
end

-- Sliders are -100..100. Non-numeric, NaN, and infinity become 0 so a
-- corrupt line cannot push a band gain outside the clamp below.
local function clamp_axis(raw)
    local v = tonumber(raw)
    if type(v) ~= "number" or v ~= v or v == math.huge or v == -math.huge then
        return 0
    end
    if v < -100 then return -100 end
    if v > 100 then return 100 end
    return v
end

local values = {}
for _, a in ipairs(AXES) do values[a.key] = 0 end
local enabled = false
-- Missing state is a new install. An existing file without curve= is 1.1.
local curve = "new"

local function curve_from_marker(marker)
    if marker == "new" then return "new" end
    return "legacy"
end

local function axis_in_curve(axis, which)
    return axis.mode == nil or axis.mode == which
end

do
    local kv, found = read_kv_file(STATE_PATH)
    if found then
        enabled = (kv.enabled == "1")
        curve = curve_from_marker(kv.curve)
        for _, a in ipairs(AXES) do
            if not axis_in_curve(a, curve) then
                values[a.key] = 0
            elseif kv[a.key] then
                values[a.key] = clamp_axis(kv[a.key])
            end
        end
    end
end

local function write_kv_file(path, include_enabled)
    local temp_path = path .. ".tmp"
    local f = io.open(temp_path, "w")
    if not f then return false end
    local ok = true
    ok = f:write("curve=" .. curve .. "\n")
    if ok and include_enabled then
        ok = f:write("enabled=" .. (enabled and "1" or "0") .. "\n")
    end
    for _, a in ipairs(AXES) do
        if ok and axis_in_curve(a, curve) then
            ok = f:write(a.key .. "=" .. tostring(values[a.key]) .. "\n")
        end
    end
    local closed = f:close()
    if not ok or not closed then
        os.remove(temp_path)
        return false
    end
    if not os.rename(temp_path, path) then
        os.remove(temp_path)
        return false
    end
    return true
end

local function write_state()
    return write_kv_file(STATE_PATH, true)
end

-- Builds a complete MSEB profile before loading it, so each change results
-- in one native profile load rather than a save for every EQ field.
-- MSEB owns the bands while active; the preamp stays the user's own, read
-- from the backup taken when MSEB was switched on.
local function backup_preamp()
    local f = io.open(BACKUP_PATH, "r")
    if not f then return "0.00" end
    local preamp = "0.00"
    for line in f:lines() do
        local value = line:match("^preamp=([%-%d%.]+)$")
        if value then
            preamp = value
            break
        end
    end
    f:close()
    return preamp
end

local function read_whole(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local text = f:read("*a")
    f:close()
    return text
end

local function write_whole(path, text)
    if text == nil then return true end
    local f = io.open(path, "w")
    if not f then return false end
    local ok = f:write(text)
    local closed = f:close()
    return ok and closed
end

local function apply_profile()
    local temp_path = PROFILE_PATH .. ".tmp"
    local f = io.open(temp_path, "w")
    if not f then return false end
    local width = 1.0 + values.sound_stage / 100.0
    local ok = f:write("bypass=0\npreamp=" .. backup_preamp() .. "\nstereo_width=" .. string.format("%.6f", width) .. "\n")
    local freqs = (curve == "legacy") and OLD_FREQS or NEW_FREQS
    local qs = (curve == "legacy") and OLD_Q or NEW_Q
    local gains = {}
    for _, axis in ipairs(AXES) do
        if axis_in_curve(axis, curve) then
            for _, c in ipairs(axis.contrib) do
                gains[c.band] = (gains[c.band] or 0) + (values[axis.key] / 100.0) * c.db
            end
        end
    end
    for i = 1, 10 do
        local gain = math.max(-12, math.min(12, gains[i] or 0))
        local band_type = (BAND_TYPE[i] == "low_shelf") and 1 or (BAND_TYPE[i] == "high_shelf") and 2 or 0
        if ok then
            ok = f:write(string.format("band%d_freq=%.2f\nband%d_gain=%.2f\nband%d_q=%.3f\nband%d_type=%d\nband%d_enabled=%d\n",
                i - 1, freqs[i], i - 1, gain, i - 1, qs[i], i - 1, band_type, i - 1, gain ~= 0 and 1 or 0))
        end
    end
    local closed = f:close()
    if not ok or not closed or not os.rename(temp_path, PROFILE_PATH) then
        os.remove(temp_path)
        return false
    end
    if not plugin.eq_load_profile(PROFILE_PATH) then
        return false
    end
    return true
end

local function set_enabled(new_enabled)
    if new_enabled == enabled then return true end
    if new_enabled then
        if file_exists(OTHER_EQ_OWNER_BACKUP) then
            return false, "Turn off Loudness Boost first"
        end
        -- A backup left by a restore that failed still holds the user's EQ
        -- from before MSEB; keep it rather than snapshot the MSEB curve.
        if not file_exists(BACKUP_PATH) and not plugin.eq_save_profile(BACKUP_PATH) then return false end
        if not apply_profile() then return false end
        enabled = true
        if not write_state() then
            plugin.eq_load_profile(BACKUP_PATH)
            enabled = false
            return false
        end
    else
        if not file_exists(BACKUP_PATH) or not plugin.eq_load_profile(BACKUP_PATH) then return false end
        enabled = false
        if not write_state() then
            enabled = true
            apply_profile()
            return false
        end
        os.remove(BACKUP_PATH)
    end
    return true
end

local function snapshot_values()
    local previous = {}
    for _, a in ipairs(AXES) do previous[a.key] = values[a.key] end
    return previous
end

local function restore_values(previous)
    for _, a in ipairs(AXES) do values[a.key] = previous[a.key] end
end

local function reset_defaults()
    local previous = snapshot_values()
    for _, a in ipairs(AXES) do values[a.key] = 0 end
    if enabled and not apply_profile() then
        restore_values(previous)
        return false
    end
    if not write_state() then
        restore_values(previous)
        if enabled then apply_profile() end
        return false
    end
    return true
end

local function save_slot(n)
    return write_kv_file(slot_path(n), false)
end

-- An unmarked slot is a 1.1 preset: legacy curve, and every axis the slot
-- does not name (including sibilance) becomes 0. curve=new loads only the
-- new axes and clears the 1.1-only ones. Mode, values, and the live EQ
-- roll back together if the profile or the state file fails.
local function load_slot(n)
    local kv, found = read_kv_file(slot_path(n))
    if not found then
        plugin.show_toast("Slot is empty")
        return
    end
    local previous = snapshot_values()
    local previous_curve = curve
    local previous_profile = read_whole(PROFILE_PATH)
    local next_curve = curve_from_marker(kv.curve)
    curve = next_curve
    for _, a in ipairs(AXES) do
        if axis_in_curve(a, next_curve) then
            values[a.key] = kv[a.key] and clamp_axis(kv[a.key]) or 0
        else
            values[a.key] = 0
        end
    end
    if enabled and not apply_profile() then
        curve = previous_curve
        restore_values(previous)
        write_whole(PROFILE_PATH, previous_profile)
        plugin.show_toast("Could not load slot. Try again.")
        return
    end
    if not write_state() then
        curve = previous_curve
        restore_values(previous)
        if enabled then apply_profile() end
        plugin.show_toast("Could not load slot. Try again.")
        return
    end
    plugin.show_toast("Slot loaded")
end

local function convert_to_new()
    if curve == "new" then return true end
    local previous = snapshot_values()
    local previous_curve = curve
    local previous_profile = read_whole(PROFILE_PATH)
    curve = "new"
    for _, a in ipairs(AXES) do
        if a.mode == "new" then values[a.key] = 0 end
    end
    if enabled and not apply_profile() then
        curve = previous_curve
        restore_values(previous)
        write_whole(PROFILE_PATH, previous_profile)
        return false
    end
    if not write_state() then
        curve = previous_curve
        restore_values(previous)
        if enabled then apply_profile() end
        return false
    end
    for _, a in ipairs(AXES) do
        if a.mode == "legacy" then values[a.key] = 0 end
    end
    return true
end

if enabled then
    if file_exists(BACKUP_PATH) and file_exists(OTHER_EQ_OWNER_BACKUP) then
        -- Both on is only possible with files left by older versions; step
        -- aside and give the user back the EQ saved before MSEB.
        local restored = plugin.eq_load_profile(BACKUP_PATH)
        enabled = false
        if write_state() and restored then os.remove(BACKUP_PATH) end
    elseif file_exists(BACKUP_PATH) then
        if not apply_profile() then
            local restored = plugin.eq_load_profile(BACKUP_PATH)
            enabled = false
            -- Keep the backup until the user's EQ is really back.
            if write_state() and restored then os.remove(BACKUP_PATH) end
        end
    else
        enabled = false
        write_state()
    end
end

local function open_group(title, entries, note)
    local rows = {}
    if note then
        table.insert(rows, {
            type = "row",
            label = note,
            wrap = true,
            on_select = function()
                plugin.show_toast(note == "Stereo width" and "Negative narrows, positive widens with lower center level. Mono input is unchanged." or "Impulse shapes the 7.5 kHz region; it does not change attack time.")
            end,
        })
    end
    for _, e in ipairs(entries) do
        local key, label = e[1], e[2]
        table.insert(rows, {
            type = "slider",
            label = label,
            min = -100,
            max = 100,
            value = values[key],
            on_change = function(v)
                local previous = values[key]
                values[key] = clamp_axis(v)
                if enabled and not apply_profile() then
                    values[key] = previous
                    plugin.show_toast("Could not apply changes. Try again.")
                    return
                end
                if not write_state() then
                    values[key] = previous
                    if enabled then apply_profile() end
                    plugin.show_toast("Could not save changes. Try again.")
                end
            end,
        })
    end
    plugin.show_settings_list(title, rows)
end

-- At most four sliders per screen: show_settings_list() drops any slider
-- past PLUGIN_SETTINGS_LIST_MAX_SLIDERS (4). Labels stay short so the
-- native settings rows fit the 320-wide board as well as the larger ones;
-- the note row uses wrap instead of a fixed width.
local function open_settings()
    local rows = {
        {
            type = "toggle",
            label = "Enabled",
            value = enabled,
            on_change = function(v)
                local ok, reason = set_enabled(v)
                if not ok then
                    plugin.show_toast(reason or "Could not change MSEB. Try again.")
                end
                if plugin.has_capability("ui.quick_toggle") then
                    plugin.set_quick_toggle("mseb", enabled)
                end
            end,
        },
        {
            type = "row",
            label = "Bass & Warmth",
            on_select = function()
                open_group("Bass & Warmth", {
                    { "temperature", "Sound Temperature" },
                    { "bass_ext", "Bass Extension" },
                    { "bass_texture", "Bass Texture" },
                })
            end,
        },
        {
            type = "row",
            label = "Vocals",
            on_select = function()
                if curve == "legacy" then
                    open_group("Vocals & Instruments", {
                        { "thickness", "Note Thickness" },
                        { "vocal_pos", "Vocal Position" },
                        { "female_vocal", "Female Vocal" },
                        { "instruments", "Instrument Presence" },
                    })
                else
                    open_group("Vocals", {
                        { "thickness", "Note Thickness" },
                        { "vocal_pos", "Vocal Position" },
                        { "female_vocal", "Female Vocal" },
                    })
                end
            end,
        },
        {
            type = "row",
            label = "Treble",
            on_select = function()
                if curve == "legacy" then
                    open_group("Treble & Air", {
                        { "bass_bite", "Bass Bite" },
                        { "treble_bite", "Treble Bite" },
                        { "air", "Air" },
                    })
                else
                    open_group("Treble", {
                        { "sibilance_lf", "Sibilance LF" },
                        { "sibilance_hf", "Sibilance HF" },
                        { "impulse_tone", "Impulse (7.5 kHz)" },
                        { "air", "Air" },
                    }, "Impulse is tonal EQ")
                end
            end,
        },
    }
    table.insert(rows, {
        type = "row",
        label = "Sound Stage",
        on_select = function()
            open_group("Sound Stage", { { "sound_stage", "Sound Stage" } }, "Stereo width")
        end,
    })
    if curve == "legacy" then
        table.insert(rows, {
            type = "row",
            label = "Switching replaces Instrument Presence, Bass Bite, and Treble Bite.",
            wrap = true,
            on_select = function()
                plugin.show_list("Replace custom axes?", { "Switch", "Cancel" }, function(index)
                    if index ~= 1 then
                        plugin.show_toast("Kept current controls")
                        return
                    end
                    if convert_to_new() then
                        plugin.show_toast("Custom axes replaced")
                    else
                        plugin.show_toast("Could not switch controls. Try again.")
                    end
                end)
            end,
        })
    end
    table.insert(rows, {
        type = "row",
        label = "Reset to Defaults",
        on_select = function()
            if reset_defaults() then
                plugin.show_toast("MSEB reset")
            else
                plugin.show_toast("Could not reset MSEB. Try again.")
            end
        end,
    })
    table.insert(rows, {
        type = "row",
        label = "Save to Slot",
        on_select = function()
            plugin.show_list("Save to Slot", { "Slot 1", "Slot 2", "Slot 3" }, function(index)
                if save_slot(index) then
                    plugin.show_toast("Saved to slot")
                else
                    plugin.show_toast("Could not save slot. Try again.")
                end
            end)
        end,
    })
    table.insert(rows, {
        type = "row",
        label = "Load from Slot",
        on_select = function()
            plugin.show_list("Load from Slot", { "Slot 1", "Slot 2", "Slot 3" }, function(index)
                load_slot(index)
            end)
        end,
    })
    plugin.show_settings_list("MSEB", rows)
end

plugin.register_list_item("music_audio", "MSEB", open_settings, { group = "effects" })

-- Quick drawer tile, mirroring the "Enabled" row above. Gated on the
-- capability rather than api_min so this plugin still loads on an older
-- player build that has no quick-toggle support -- it just doesn't get a
-- tile there. Same reasoning GainMode.lua documents for its own gating.
if plugin.has_capability("ui.quick_toggle") then
    plugin.register_quick_toggle("mseb", "MSEB", function(on)
        local ok, reason = set_enabled(on)
        if not ok then
            plugin.show_toast(reason or "Could not change MSEB. Try again.")
            plugin.set_quick_toggle("mseb", enabled)
        end
    end, {
        icon = "pull_down/mseb.png",
        value = enabled,
        on_hold = open_settings,
    })
end
