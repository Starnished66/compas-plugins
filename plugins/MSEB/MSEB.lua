plugin.define({ id = "example.mseb", name = "MSEB", version = "1.1", api_min = 13 })

-- "MSEB" -- an intuitive, mood-based tone-tuning screen on top of this
-- app's own 10-band parametric EQ (src/audio/peq.c), adds an "MSEB" row to
-- Settings -> Music Settings -> Audio (plugin.register_list_item(), same
-- hook SoundProfiles.lua already uses for its own row).
--
-- Modeled after the stock HiBy R1 firmware's own "MSEB" (MageSound 8-Ball)
-- feature, reverse-engineered from a decompile of the stock binary: that
-- process recovered the real list and order of its 10 named tuning sliders
-- (confirmed directly in the stock binary's own strings), but NOT the actual
-- frequency/gain mapping formulas -- no such formulas exist anywhere in the
-- decompiled material or the raw strings, only unconfirmed prose guesses.
-- So the 10 axis names/order below are the real, recovered shape of the
-- feature; the mapping onto our own PEQ bands is this plugin's own original
-- design, tuned by ear, not a port of the real firmware's DSP.
--
-- Persists like every other example plugin in this folder: plain files
-- under .plugins/, re-applied at the top of this script on every boot (see
-- SoundProfiles.lua's own header comment for why).

-- Matches peq.c's own set_defaults() exactly (ISO-standard 10-band layout,
-- band 0 a low shelf, band 9 a high shelf, the rest peaking bells) -- same
-- tables SoundProfiles.lua already declares for the same reason.
local BAND_FREQS = { 31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 }
local BAND_Q     = { 0.2, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.2 }
local BAND_TYPE  = { "low_shelf", "peaking", "peaking", "peaking", "peaking",
                      "peaking", "peaking", "peaking", "peaking", "high_shelf" }

-- Each axis is -100..100. `contrib` lists which PEQ band(s) (1-based, matching
-- plugin.eq_set_band()'s own convention) it drives and by how much at full
-- deflection. Only band 1 and band 10 are shared by two axes each (Sound
-- Temperature is a deliberate whole-spectrum tilt, so it shares both end
-- shelves with the dedicated Bass Extension/Air controls) -- every other
-- band belongs to exactly one axis. Shared bands get their contributions
-- summed when the complete profile is built, not overwritten.
local AXES = {
    { key = "temperature",  label = "Sound Temperature",  contrib = { { band = 1, db = 3 }, { band = 10, db = -4 } } },
    { key = "bass_ext",     label = "Bass Extension",     contrib = { { band = 1, db = 6 } } },
    { key = "bass_texture", label = "Bass Texture",       contrib = { { band = 2, db = 5 } } },
    { key = "thickness",    label = "Note Thickness",     contrib = { { band = 4, db = 5 } } },
    { key = "vocal_pos",    label = "Vocal Position",     contrib = { { band = 5, db = 5 } } },
    { key = "female_vocal", label = "Female Vocal",       contrib = { { band = 6, db = 4 } } },
    { key = "instruments",  label = "Instrument Presence", contrib = { { band = 3, db = 3 }, { band = 7, db = 4 } } },
    { key = "bass_bite",    label = "Bass Bite",          contrib = { { band = 8, db = 4 } } },
    { key = "treble_bite",  label = "Treble Bite",        contrib = { { band = 9, db = 4 } } },
    { key = "air",          label = "Air",                contrib = { { band = 10, db = 5 } } },
}

local function axis_by_key(key)
    for _, a in ipairs(AXES) do
        if a.key == key then return a end
    end
    return nil
end

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

local values = {}
for _, a in ipairs(AXES) do values[a.key] = 0 end
local enabled = false

do
    local kv, found = read_kv_file(STATE_PATH)
    if found then
        enabled = (kv.enabled == "1")
        for _, a in ipairs(AXES) do
            if kv[a.key] then values[a.key] = tonumber(kv[a.key]) or 0 end
        end
    end
end

local function write_state()
    local temp_path = STATE_PATH .. ".tmp"
    local f = io.open(temp_path, "w")
    if not f then return false end
    local ok = f:write("enabled=" .. (enabled and "1" or "0") .. "\n")
    for _, a in ipairs(AXES) do
        if ok then ok = f:write(a.key .. "=" .. tostring(values[a.key]) .. "\n") end
    end
    local closed = f:close()
    if not ok or not closed then
        os.remove(temp_path)
        return false
    end
    return os.rename(temp_path, STATE_PATH)
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

local function apply_profile()
    local f = io.open(PROFILE_PATH .. ".tmp", "w")
    if not f then return false end
    local ok = f:write("bypass=0\npreamp=" .. backup_preamp() .. "\n")
    local gains = {}
    for _, axis in ipairs(AXES) do
        for _, c in ipairs(axis.contrib) do
            gains[c.band] = (gains[c.band] or 0) + (values[axis.key] / 100.0) * c.db
        end
    end
    for i = 1, 10 do
        local gain = math.max(-12, math.min(12, gains[i] or 0))
        local band_type = (BAND_TYPE[i] == "low_shelf") and 1 or (BAND_TYPE[i] == "high_shelf") and 2 or 0
        if ok then
            ok = f:write(string.format("band%d_freq=%.2f\nband%d_gain=%.2f\nband%d_q=%.3f\nband%d_type=%d\nband%d_enabled=%d\n",
                i - 1, BAND_FREQS[i], i - 1, gain, i - 1, BAND_Q[i], i - 1, band_type, i - 1, gain ~= 0 and 1 or 0))
        end
    end
    local closed = f:close()
    if not ok or not closed or not os.rename(PROFILE_PATH .. ".tmp", PROFILE_PATH) then
        os.remove(PROFILE_PATH .. ".tmp")
        return false
    end
    return plugin.eq_load_profile(PROFILE_PATH)
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

local function reset_defaults()
    local previous = {}
    for _, a in ipairs(AXES) do previous[a.key] = values[a.key] end
    for _, a in ipairs(AXES) do values[a.key] = 0 end
    if enabled and not apply_profile() then
        for _, a in ipairs(AXES) do values[a.key] = previous[a.key] end
        return false
    end
    if not write_state() then
        for _, a in ipairs(AXES) do values[a.key] = previous[a.key] end
        if enabled then apply_profile() end
        return false
    end
    return true
end

local function save_slot(n)
    local path = slot_path(n)
    local temp_path = path .. ".tmp"
    local f = io.open(temp_path, "w")
    if not f then return false end
    local ok = true
    for _, a in ipairs(AXES) do
        if ok then ok = f:write(a.key .. "=" .. tostring(values[a.key]) .. "\n") end
    end
    local closed = f:close()
    if not ok or not closed or not os.rename(temp_path, path) then
        os.remove(temp_path)
        return false
    end
    return true
end

-- Slots store the 10 raw axis values, not the derived PEQ curve, so a later
-- tweak to the mapping table above still re-derives correctly from an old
-- saved slot instead of freezing whatever the mapping happened to produce
-- at save time.
local function load_slot(n)
    local kv, found = read_kv_file(slot_path(n))
    if not found then
        plugin.show_toast("Slot is empty")
        return
    end
    local previous = {}
    for _, a in ipairs(AXES) do
        previous[a.key] = values[a.key]
        if kv[a.key] then values[a.key] = tonumber(kv[a.key]) or 0 end
    end
    if enabled and not apply_profile() then
        for _, a in ipairs(AXES) do values[a.key] = previous[a.key] end
        plugin.show_toast("Could not load slot. Try again.")
        return
    end
    if not write_state() then
        for _, a in ipairs(AXES) do values[a.key] = previous[a.key] end
        if enabled then apply_profile() end
        plugin.show_toast("Could not load slot. Try again.")
        return
    end
    plugin.show_toast("Slot loaded")
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

local function open_group(title, entries)
    local rows = {}
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
                values[key] = v
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

-- Grouped into 3 sub-screens (3/4/3 sliders) rather than one 10-slider
-- screen: plugin.show_settings_list() silently drops any slider past
-- PLUGIN_SETTINGS_LIST_MAX_SLIDERS (4) in a single call.
plugin.register_list_item("music_audio", "MSEB", function()
    plugin.show_settings_list("MSEB", {
        {
            type = "toggle",
            label = "Enabled",
            value = enabled,
            on_change = function(v)
                local ok, reason = set_enabled(v)
                if not ok then
                    plugin.show_toast(reason or "Could not change MSEB. Try again.")
                end
                -- The quick drawer tile reads this state rather than being
                -- pushed to, so keep the two in step when it changes here.
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
            label = "Vocals & Instruments",
            on_select = function()
                open_group("Vocals & Instruments", {
                    { "thickness", "Note Thickness" },
                    { "vocal_pos", "Vocal Position" },
                    { "female_vocal", "Female Vocal" },
                    { "instruments", "Instrument Presence" },
                })
            end,
        },
        {
            type = "row",
            label = "Treble & Air",
            on_select = function()
                open_group("Treble & Air", {
                    { "bass_bite", "Bass Bite" },
                    { "treble_bite", "Treble Bite" },
                    { "air", "Air" },
                })
            end,
        },
        {
            type = "row",
            label = "Reset to Defaults",
            on_select = function()
                if reset_defaults() then
                    plugin.show_toast("MSEB reset")
                else
                    plugin.show_toast("Could not reset MSEB. Try again.")
                end
            end,
        },
        {
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
        },
        {
            type = "row",
            label = "Load from Slot",
            on_select = function()
                plugin.show_list("Load from Slot", { "Slot 1", "Slot 2", "Slot 3" }, function(index)
                    load_slot(index)
                end)
            end,
        },
    })
end)

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
    })
end
