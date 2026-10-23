plugin.define({ id = "example.mseb", name = "MSEB", version = "1.6.1", api_min = 16 })

local modern_mseb_ui = plugin.has_capability("ui.settings_list_10_sliders")
    and plugin.has_capability("audio.mseb.stock")
    and plugin.mseb_apply_state and plugin.get_mseb_state

-- Mood-based tone tuning for firmware's native 13-filter stock MSEB engine.
-- This release requires native stock MSEB and the ten-slider settings UI.
-- Legacy saved curves require an explicit conversion before editing.
-- The plugin appears under Settings -> Sound. Sound Stage holds Stereo Width,
-- a normalized mid/side matrix saved in MSEB state (or the fallback PEQ
-- profile). Crossfeed remains separate in the native Sound settings; it is
-- read from the live EQ so tone and width changes leave it unchanged.
-- Presets (slots) hold tone and width only.
-- On stock-MSEB builds Impulse is a tonal presence control. Legacy PEQ
-- fallback maps it to a broad 7.5 kHz EQ level; neither path changes attack.
--
-- The current stock curve exposes ten controls. curve=legacy is the earlier
-- 1.1 mapping, including Instrument Presence, Bass Bite, and Treble Bite;
-- the explicit conversion replaces those three with Sibilance LF / HF and
-- Impulse controls.
-- A file with no curve marker is legacy, so opening or upgrading does not
-- retune an existing user. A missing state file starts on curve=new.
-- Switching is a confirmed action.
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

-- Crossfeed angles the player accepts (peq.c). Index 1 is no delay.
local CROSSFEED_ANGLES = { 0, 30, 45, 60, 90 }

local PLUGIN_DIR = plugin.sd_root() .. "/.plugins"
local STATE_PATH = PLUGIN_DIR .. "/.mseb_state"
local PRESET_LIMIT = 20
local PRESET_NAME_MAX = 64
local RANGE_VALUES = { 20, 40, 100 }
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

local function named_preset_path(n)
    return PLUGIN_DIR .. "/.mseb_preset" .. tostring(n)
end

-- Reads a plain key=value\n file into a table via repeated single-line
-- reads (same io pattern SoundProfiles.lua's own read_state() uses) --
-- deliberately not f:lines(), to stay within the exact io usage already
-- demonstrated as safe in this plugin sandbox.
local function read_kv_file(path)
    local out, raw_lines = {}, {}
    local f = io.open(path, "r")
    if not f then return out, false, nil end
    local line = f:read("*l")
    while line do
        raw_lines[#raw_lines + 1] = line .. "\n"
        local k, v = line:match("^([%w_]+)=(.-)$")
        if k then out[k] = v end
        line = f:read("*l")
    end
    f:close()
    return out, true, table.concat(raw_lines)
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
    if v < -100 then v = -100 end
    if v > 100 then v = 100 end
    if v < 0 then return math.ceil(v - 0.5) end
    return math.floor(v + 0.5)
end

local values = {}
for _, a in ipairs(AXES) do values[a.key] = 0 end
local enabled = false
local manual_backup_restored = false
local axis_range = 100
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
        local saved_range = tonumber(kv.range)
        if saved_range == 20 or saved_range == 40 or saved_range == 100 then axis_range = saved_range end
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
        if ok then ok = f:write("range=" .. tostring(axis_range) .. "\n") end
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

local function write_whole(path, text)
    if text == nil then return true end
    local f = io.open(path, "w")
    if not f then return false end
    local ok = f:write(text)
    local closed = f:close()
    return ok and closed
end

local function write_atomic(path, text)
    local temp_path = path .. ".tmp"
    if not write_whole(temp_path, text) then
        os.remove(temp_path)
        return false
    end
    if not os.rename(temp_path, path) then
        os.remove(temp_path)
        return false
    end
    return true
end

local function angle_index(angle)
    for i, a in ipairs(CROSSFEED_ANGLES) do
        if a == angle then return i end
    end
    return nil
end

-- Detached snapshot of the live EQ, or nil on builds without the snapshot
-- API. Every crossfeed build has it, so a non-nil live crossfeed implies a
-- snapshot.
local function live_snapshot()
    if not plugin.has_capability("audio.peq.state") or not plugin.get_eq_state then return nil end
    return plugin.get_eq_state()
end

-- Applies a snapshot from live_snapshot() through the native validator. The
-- native side raises on refusal instead of returning false, so the call is
-- wrapped. Applying saves the whole EQ unless persist is false, as used by
-- rollback paths.
local function apply_snapshot(snapshot, persist)
    if not snapshot then return false end
    local opts = nil
    if persist == false then opts = { persist = false } end
    local ok, applied = pcall(plugin.eq_apply_state, snapshot, opts)
    return ok and applied == true
end

local function native_mseb()
    return plugin.has_capability("audio.mseb.stock") and plugin.mseb_apply_state
        and plugin.get_mseb_state
end

local function native_state(on)
    return {
        enabled = on,
        temperature = values.temperature, bass_ext = values.bass_ext,
        bass_texture = values.bass_texture, thickness = values.thickness,
        vocal_pos = values.vocal_pos, female_vocal = values.female_vocal,
        sibilance_lf = values.sibilance_lf, sibilance_hf = values.sibilance_hf,
        impulse_tone = values.impulse_tone, air = values.air,
        width = 1.0 + values.sound_stage / 100.0,
    }
end

local function apply_native(on)
    if not native_mseb() then return true end
    local ok, result = pcall(plugin.mseb_apply_state, native_state(on))
    return ok and result == true
end

local function restore_native_state(state)
    if not native_mseb() or not state then return true end
    local ok, result = pcall(plugin.mseb_apply_state, state)
    return ok and result == true
end

-- A rollback that returns the live EQ to MSEB's own curve must not save that
-- curve to the native file. On a build with audio.peq.transient MSEB never
-- saved it in the first place. Other builds saved it through the load
-- anyway, so their rollbacks keep saving.
local function rollback_persists()
    return not plugin.has_capability("audio.peq.transient")
end

-- Live crossfeed, or nil when this build has no crossfeed. `angle_supported`
-- is false on the early crossfeed builds that had strength but no angle.
-- One snapshot serves both fields.
local function read_crossfeed()
    if not plugin.has_capability("audio.crossfeed") then return nil end
    local state = live_snapshot()
    if not state then return nil end
    local strength = state.crossfeed
    if type(strength) ~= "number" or strength ~= strength or strength < 0 or strength > 1 then
        strength = 0
    end
    local live = { strength = strength, angle = 0, angle_supported = false }
    if plugin.has_capability("audio.crossfeed.angle") then
        live.angle_supported = true
        if angle_index(state.crossfeed_angle) then live.angle = state.crossfeed_angle end
    end
    return live
end

-- Builds a complete MSEB profile before loading it, so each change results
-- in one native profile load rather than a save for every EQ field.
-- MSEB owns the bands while active; the preamp stays the user's own, read
-- from the backup taken when MSEB was switched on. Crossfeed is not MSEB's:
-- the current live strength and angle are written back unchanged. A profile
-- without those keys would load them as off, which is the reset this avoids.
local function profile_text()
    local width = 1.0 + values.sound_stage / 100.0
    local lines = { "bypass=0", "preamp=" .. backup_preamp(), string.format("stereo_width=%.6f", width) }
    local live = read_crossfeed()
    if live then
        table.insert(lines, string.format("crossfeed=%.6f", live.strength))
        if live.angle_supported then
            table.insert(lines, string.format("crossfeed_angle=%d", live.angle))
        end
    end
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
        table.insert(lines, string.format("band%d_freq=%.2f", i - 1, freqs[i]))
        table.insert(lines, string.format("band%d_gain=%.2f", i - 1, gain))
        table.insert(lines, string.format("band%d_q=%.3f", i - 1, qs[i]))
        table.insert(lines, string.format("band%d_type=%d", i - 1, band_type))
        table.insert(lines, string.format("band%d_enabled=%d", i - 1, gain ~= 0 and 1 or 0))
    end
    return table.concat(lines, "\n") .. "\n"
end

-- Live-only apply when this build has it, so a tone change does not rewrite
-- the native EQ file. Older API 16 builds use the saving load.
local function load_active_profile()
    if plugin.has_capability("audio.peq.transient") and plugin.eq_apply_profile then
        return plugin.eq_apply_profile(PROFILE_PATH, { persist = false })
    end
    return plugin.eq_load_profile(PROFILE_PATH)
end

local function apply_profile()
    if curve == "new" and native_mseb() then
        return apply_native(true)
    end
    if not write_atomic(PROFILE_PATH, profile_text()) then return false end
    local loaded = load_active_profile()
    if not loaded then return false end
    -- A legacy PEQ curve takes ownership only after its profile was accepted.
    if native_mseb() then return apply_native(false) end
    return true
end

-- Puts back the EQ saved before MSEB was enabled. The backup loads through
-- the native loader, so no MSEB file is written and a read-only card cannot
-- block it. Returns ok, message. ok is false only when the native loader
-- refused the backup, and then nothing changed.
--
-- The backup can hold bands the snapshot validator refuses even though the
-- loader accepted them (for example q=0 on an unused band). So crossfeed the
-- user changed while MSEB was on is written back only when the loaded value
-- differs. If that write-back is refused, the loaded backup stays live and the
-- saved crossfeed is used. Turning MSEB off is never blocked by it. The
-- message tells the user their changed crossfeed was lost.
local function restore_backup()
    local live = read_crossfeed()
    if not plugin.eq_load_profile(BACKUP_PATH) then return false end
    -- Preserve the native effect until the manual PEQ backup is safely live.
    if native_mseb() and not apply_native(false) then return false end
    if not live then return true end
    local loaded = read_crossfeed()
    local same = math.abs(loaded.strength - live.strength) < 1e-6
        and (not live.angle_supported or loaded.angle == live.angle)
    if same then return true end
    local state = live_snapshot()
    state.crossfeed = live.strength
    if live.angle_supported then state.crossfeed_angle = live.angle end
    if apply_snapshot(state) then return true end
    return true, "MSEB off. Crossfeed was reset to its saved value."
end

-- Restore a manual PEQ snapshot without deleting its durable backup. Curve
-- transitions only remove that backup after the matching state write commits.
local function load_manual_backup()
    local live = read_crossfeed()
    if not file_exists(BACKUP_PATH) or not plugin.eq_load_profile(BACKUP_PATH) then return false end
    manual_backup_restored = true
    if not live then return true end
    local loaded = read_crossfeed()
    if math.abs(loaded.strength - live.strength) < 1e-6
        and (not live.angle_supported or loaded.angle == live.angle) then return true end
    local state = live_snapshot()
    state.crossfeed = live.strength
    if live.angle_supported then state.crossfeed_angle = live.angle end
    apply_snapshot(state)
    return true
end

-- Stock mode changes only the transient DSP and plugin state; it leaves the
-- manual PEQ alone. Legacy mode also owns the PEQ bands and uses a manual-EQ
-- backup. Each branch rolls its live state back if the plugin-state write
-- fails.
local function set_enabled(new_enabled)
    if new_enabled == enabled then return true end
    if new_enabled then
        if file_exists(OTHER_EQ_OWNER_BACKUP) then
            return false, "Turn off Loudness Boost first"
        end
        if curve == "new" and native_mseb() then
            if file_exists(BACKUP_PATH) and not manual_backup_restored and not load_manual_backup() then
                return false
            end
            local native_before = plugin.get_mseb_state()
            if not apply_native(true) then return false end
            enabled = true
            if not write_state() then
                enabled = false
                restore_native_state(native_before)
                return false
            end
            if manual_backup_restored and file_exists(BACKUP_PATH) then os.remove(BACKUP_PATH) end
            return true
        end
        -- The legacy PEQ curve owns the bands, so save the manual curve before
        -- applying it. A leftover backup remains authoritative after a failed
        -- earlier restore and must not be overwritten.
        local created = not file_exists(BACKUP_PATH)
        if created and not plugin.eq_save_profile(BACKUP_PATH) then return false end
        local before = live_snapshot()
        local native_before = native_mseb() and plugin.get_mseb_state() or nil
        if not apply_profile() then
            local restored = apply_snapshot(before) or plugin.eq_load_profile(BACKUP_PATH)
            restore_native_state(native_before)
            if created and restored then os.remove(BACKUP_PATH) end
            return false
        end
        enabled = true
        if not write_state() then
            enabled = false
            if not apply_snapshot(before) then plugin.eq_load_profile(BACKUP_PATH) end
            restore_native_state(native_before)
            if created then os.remove(BACKUP_PATH) end
            return false
        end
    else
        if curve == "new" and native_mseb() then
            local native_before = plugin.get_mseb_state()
            if file_exists(BACKUP_PATH) and not manual_backup_restored and not load_manual_backup() then
                return false
            end
            if not apply_native(false) then return false end
            enabled = false
            if not write_state() then
                enabled = true
                restore_native_state(native_before)
                return false
            end
            -- A backup can only be left from an interrupted old-version
            -- migration. It is removed only after it was restored and the
            -- disabled state committed.
            if manual_backup_restored and file_exists(BACKUP_PATH) then os.remove(BACKUP_PATH) end
            return true
        end
        if not file_exists(BACKUP_PATH) then return false end
        local before = live_snapshot()
        local native_before = native_mseb() and plugin.get_mseb_state() or nil
        local restored, message = restore_backup()
        if not restored then return false end
        enabled = false
        if not write_state() then
            enabled = true
            if not apply_snapshot(before, rollback_persists()) then apply_profile() end
            restore_native_state(native_before)
            return false
        end
        os.remove(BACKUP_PATH)
        return true, message
    end
    return true
end

-- set_enabled() returns false with a reason when it refuses, and true with a
-- message when the switch worked but the user should know something.
local function show_enabled_result(ok, message)
    if not ok then
        plugin.show_toast(message or "Could not change MSEB. Try again.")
    elseif message then
        plugin.show_toast(message)
    end
end

local function snapshot_values()
    local previous = {}
    for _, a in ipairs(AXES) do previous[a.key] = values[a.key] end
    return previous
end

local function restore_values(previous)
    for _, a in ipairs(AXES) do values[a.key] = previous[a.key] end
end

-- Every change to tone, width, or curve goes through here. Native mode
-- updates transient MSEB state; legacy mode updates its PEQ profile. Curve
-- transitions additionally preserve the manual PEQ backup until the state
-- write commits.
local function commit_values(change)
    local previous = snapshot_values()
    local previous_curve = curve
    local previous_range = axis_range
    local before = live_snapshot()
    local native_before = native_mseb() and plugin.get_mseb_state() or nil
    local was_stock = enabled and curve == "new" and native_mseb()
    change()
    local becomes_stock = enabled and curve == "new" and native_mseb()
    local created_backup = false
    local ok = true
    if enabled and was_stock and not becomes_stock then
        created_backup = not file_exists(BACKUP_PATH)
        if created_backup then
            ok = plugin.eq_save_profile(BACKUP_PATH)
            if ok then manual_backup_restored = false end
        end
        if ok then ok = apply_profile() end
    elseif enabled and not was_stock and becomes_stock then
        -- Switching away from the PEQ-owned legacy curve restores the saved
        -- manual EQ before stock MSEB takes over. Keep its backup until state
        -- persistence succeeds, so a failed conversion can return to legacy.
        ok = load_manual_backup()
        if ok then ok = apply_profile() end
    elseif enabled then
        ok = apply_profile()
    end
    if ok then ok = write_state() end
    if ok then
        if was_stock and not becomes_stock and created_backup then
            -- Legacy mode now owns PEQ and needs this backup for disable.
        elseif not was_stock and becomes_stock and file_exists(BACKUP_PATH) then
            os.remove(BACKUP_PATH)
        end
        return true
    end
    curve = previous_curve
    axis_range = previous_range
    restore_values(previous)
    if enabled and was_stock and not becomes_stock then
        local restored = apply_snapshot(before, rollback_persists())
        if not restored and file_exists(BACKUP_PATH) then restored = plugin.eq_load_profile(BACKUP_PATH) end
        restore_native_state(native_before)
        if created_backup and restored then os.remove(BACKUP_PATH) end
    elseif enabled and not was_stock and becomes_stock then
        restore_native_state(native_before)
        -- Reapply the old legacy curve after returning config fields; its
        -- durable manual-EQ backup stays available for a later retry.
        if not apply_snapshot(before, rollback_persists()) then apply_profile() end
    else
        if enabled and not apply_snapshot(before, rollback_persists()) then apply_profile() end
        restore_native_state(native_before)
    end
    return false
end

-- Resets tone and width only. Crossfeed belongs to the live EQ and is kept.
local function reset_defaults()
    return commit_values(function()
        for _, a in ipairs(AXES) do values[a.key] = 0 end
    end)
end

local open_settings
local open_options
local choose_axis_range
local set_axis_range

local function encode_name(name)
    return (name:gsub(".", function(ch) return string.format("%02X", string.byte(ch)) end))
end

local function decode_name(encoded)
    if type(encoded) ~= "string" or #encoded == 0 or #encoded % 2 ~= 0 or encoded:find("[^%x]") then return nil end
    local out = {}
    for i = 1, #encoded, 2 do out[#out + 1] = string.char(tonumber(encoded:sub(i, i + 1), 16)) end
    local name = table.concat(out)
    if #name == 0 or #name > PRESET_NAME_MAX or name:find("[%c]") then return nil end
    return name
end

local function clean_preset_name(raw)
    if type(raw) ~= "string" then return nil end
    local name = raw:gsub("^%s+", ""):gsub("%s+$", "")
    if #name == 0 or #name > PRESET_NAME_MAX or name:find("[%c]") then return nil end
    return name
end

local function valid_named_preset(kv)
    if kv.format ~= "1" or (kv.curve ~= "new" and kv.curve ~= "legacy") then return false end
    if kv.range ~= "20" and kv.range ~= "40" and kv.range ~= "100" then return false end
    for _, axis in ipairs(AXES) do
        if axis_in_curve(axis, kv.curve) then
            local value = tonumber(kv[axis.key])
            if type(value) ~= "number" or value ~= value or value == math.huge or value == -math.huge
                or value < -100 or value > 100 or value % 1 ~= 0 then return false end
        end
    end
    return true
end

local function read_named_presets()
    local entries, damaged = {}, {}
    for i = 1, PRESET_LIMIT do
        local kv, found, signature = read_kv_file(named_preset_path(i))
        if found then
            local name = decode_name(kv.name_hex)
            if name and valid_named_preset(kv) then
                entries[#entries + 1] = { id = i, name = name, kv = kv, signature = signature }
            else
                damaged[#damaged + 1] = { id = i, signature = signature, name = "Damaged preset " .. i }
            end
        end
    end
    return entries, damaged
end

local function current_named_preset(entry)
    local kv, found, signature = read_kv_file(named_preset_path(entry.id))
    local name = found and decode_name(kv.name_hex) or nil
    if not name or not valid_named_preset(kv) or name ~= entry.name or signature ~= entry.signature then
        plugin.show_toast("Preset changed; reopen the preset list")
        return nil
    end
    return { id = entry.id, name = name, kv = kv, signature = signature }
end

local function preset_text(name)
    local lines = { "format=1", "name_hex=" .. encode_name(name), "curve=" .. curve,
                    "range=" .. tostring(axis_range) }
    for _, a in ipairs(AXES) do
        if axis_in_curve(a, curve) then lines[#lines + 1] = a.key .. "=" .. tostring(values[a.key]) end
    end
    return table.concat(lines, "\n") .. "\n"
end

local function write_named_preset(id, name)
    return write_atomic(named_preset_path(id), preset_text(name))
end

local function prompt_preset_name(title, initial, callback)
    if not plugin.show_text_input then
        plugin.show_toast("Text input is unavailable")
        return
    end
    local opened = plugin.show_text_input(title, initial, false, function(text)
        local name = clean_preset_name(text)
        if not name then
            plugin.show_toast("Enter a short preset name without line breaks")
            return
        end
        callback(name)
    end)
    if opened == false then plugin.show_toast("Could not open name entry") end
end

local function duplicate_preset_name(name, exclude_id)
    local wanted = name:lower()
    for _, entry in ipairs(read_named_presets()) do
        if entry.id ~= exclude_id and entry.name:lower() == wanted then return true end
    end
    return false
end

local function choose_free_preset_id()
    for i = 1, PRESET_LIMIT do
        if not file_exists(named_preset_path(i)) then return i end
    end
    return nil
end

local function save_named_preset()
    local entries = read_named_presets()
    local actions = { "Create new preset" }
    for _, entry in ipairs(entries) do actions[#actions + 1] = "Overwrite: " .. entry.name end
    plugin.show_list("Save named preset", actions, function(index)
        if index == 1 then
            prompt_preset_name("New preset name", "", function(name)
                if duplicate_preset_name(name) then plugin.show_toast("A preset with that name already exists"); return end
                -- Re-scan after text entry: the list remains open after Return,
                -- and another create action may already have consumed its old slot.
                local free_id = choose_free_preset_id()
                if not free_id then plugin.show_toast("Preset limit reached (" .. PRESET_LIMIT .. ")"); return end
                if write_named_preset(free_id, name) then plugin.show_toast("Preset saved")
                else plugin.show_toast("Could not save preset. Try again.") end
            end)
            return
        end
        local selected = entries[index - 1]
        if not selected then return end
        local current = current_named_preset(selected)
        if not current then return end
        plugin.show_list("Overwrite preset?", { "Cancel", "Overwrite " .. current.name }, function(confirm)
            if confirm ~= 2 then return end
            local latest = current_named_preset(current)
            if not latest then return end
            if duplicate_preset_name(latest.name, latest.id) then
                plugin.show_toast("A preset with that name already exists")
                return
            end
            if write_named_preset(latest.id, latest.name) then plugin.show_toast("Preset overwritten")
            else plugin.show_toast("Could not save preset. Try again.") end
        end)
    end)
end

local function load_named_preset(entry)
    local current = current_named_preset(entry)
    if not current then return end
    local kv = current.kv
    local next_curve = curve_from_marker(kv.curve)
    if next_curve ~= "new" then
        plugin.show_toast("Older MSEB controls are unsupported; preset was not loaded")
        return
    end
    local next_range = tonumber(kv.range)
    local ok = commit_values(function()
        curve = next_curve
        axis_range = next_range
        for _, a in ipairs(AXES) do
            if axis_in_curve(a, next_curve) then values[a.key] = clamp_axis(kv[a.key])
            else values[a.key] = 0 end
        end
    end)
    plugin.show_toast(ok and "Preset loaded" or "Could not load preset. Try again.")
    if ok then open_settings({ update = true }) end
end

local function rename_named_preset(entry)
    local current = current_named_preset(entry)
    if not current then return end
    prompt_preset_name("Rename preset", current.name, function(name)
        local latest = current_named_preset(current)
        if not latest then return end
        if duplicate_preset_name(name, latest.id) then plugin.show_toast("A preset with that name already exists"); return end
        local kv = latest.kv
        local lines = { "format=1", "name_hex=" .. encode_name(name), "curve=" .. kv.curve,
                        "range=" .. kv.range }
        for _, a in ipairs(AXES) do
            if kv[a.key] then lines[#lines + 1] = a.key .. "=" .. kv[a.key] end
        end
        if write_atomic(named_preset_path(latest.id), table.concat(lines, "\n") .. "\n") then
            plugin.show_toast("Preset renamed")
        else
            plugin.show_toast("Could not rename preset. Try again.")
        end
    end)
end

local function delete_named_preset(entry)
    local current = current_named_preset(entry)
    if not current then return end
    plugin.show_list("Delete preset?", { "Cancel", "Delete " .. current.name }, function(index)
        if index ~= 2 then return end
        local latest = current_named_preset(current)
        if not latest then return end
        if os.remove(named_preset_path(latest.id)) then plugin.show_toast("Preset deleted")
        else plugin.show_toast("Could not delete preset. Try again.") end
    end)
end

local function current_damaged_preset(entry)
    local kv, found, signature = read_kv_file(named_preset_path(entry.id))
    if not found or signature ~= entry.signature or (decode_name(kv.name_hex) and valid_named_preset(kv)) then
        plugin.show_toast("Preset changed; reopen the preset list")
        return nil
    end
    return true
end

local function delete_damaged_preset(entry)
    if not current_damaged_preset(entry) then return end
    plugin.show_list("Delete damaged preset?", { "Cancel", "Delete file " .. entry.id }, function(index)
        if index ~= 2 or not current_damaged_preset(entry) then return end
        if os.remove(named_preset_path(entry.id)) then plugin.show_toast("Damaged preset deleted")
        else plugin.show_toast("Could not delete preset. Try again.") end
    end)
end

local function manage_named_preset(entry)
    local current = current_named_preset(entry)
    if not current then return end
    plugin.show_list(current.name, { "Load", "Overwrite", "Rename", "Delete" }, function(index)
        local latest = current_named_preset(current)
        if not latest then return end
        if index == 1 then load_named_preset(latest)
        elseif index == 2 then
            plugin.show_list("Overwrite preset?", { "Cancel", "Overwrite " .. latest.name }, function(confirm)
                if confirm ~= 2 then return end
                local confirmed = current_named_preset(latest)
                if not confirmed then return end
                if write_named_preset(confirmed.id, confirmed.name) then plugin.show_toast("Preset overwritten")
                else plugin.show_toast("Could not save preset. Try again.") end
            end)
        elseif index == 3 then rename_named_preset(latest)
        elseif index == 4 then delete_named_preset(latest) end
    end)
end

local function open_named_presets()
    local entries, damaged = read_named_presets()
    local labels, targets = {}, {}
    for _, entry in ipairs(entries) do
        labels[#labels + 1] = entry.name
        targets[#targets + 1] = { kind = "valid", entry = entry }
    end
    for _, entry in ipairs(damaged) do
        labels[#labels + 1] = entry.name .. " (delete to free slot)"
        targets[#targets + 1] = { kind = "damaged", entry = entry }
    end
    if #labels == 0 then labels[1] = "No named presets saved" end
    plugin.show_list("Named presets", labels, function(index)
        local target = targets[index]
        if not target then return end
        if target.kind == "valid" then manage_named_preset(target.entry)
        else delete_damaged_preset(target.entry) end
    end)
end

choose_axis_range = function(refresh)
    plugin.show_list("Adjustment Range", { "±20", "±40", "±100" }, function(index)
        set_axis_range(RANGE_VALUES[index], refresh)
    end)
end

set_axis_range = function(new_range, refresh)
    if new_range ~= 20 and new_range ~= 40 and new_range ~= 100 then return end
    if new_range == axis_range then return end
    local previous = axis_range
    axis_range = new_range
    if not write_state() then
        axis_range = previous
        plugin.show_toast("Could not save range. Try again.")
        return
    end
    local outside = false
    for _, a in ipairs(AXES) do
        if axis_in_curve(a, curve) and math.abs(values[a.key]) > new_range then outside = true end
    end
    if outside then
        plugin.show_toast("Range saved. Existing values kept; widen the range to edit values beyond it.")
    else
        plugin.show_toast("Range set to ±" .. new_range)
    end
    open_settings({ update = true })
    if refresh then refresh() end
end

local function save_slot(n)
    return write_kv_file(slot_path(n), false)
end

-- Pre-stock slots are rejected before state or audio changes. Current stock
-- slots carry tone and width only, so loading one leaves live crossfeed alone.
local function load_slot(n)
    local kv, found = read_kv_file(slot_path(n))
    if not found then
        plugin.show_toast("Slot is empty")
        return
    end
    local next_curve = curve_from_marker(kv.curve)
    if next_curve ~= "new" then
        plugin.show_toast("Older MSEB controls are unsupported; slot was not loaded")
        return
    end
    local ok = commit_values(function()
        curve = next_curve
        for _, a in ipairs(AXES) do
            if axis_in_curve(a, next_curve) then
                values[a.key] = kv[a.key] and clamp_axis(kv[a.key]) or 0
            else
                values[a.key] = 0
            end
        end
    end)
    plugin.show_toast(ok and "Slot loaded" or "Could not load slot. Try again.")
    if ok then open_settings({ update = true }) end
end

local function convert_to_new()
    if curve == "new" then return true end
    return commit_values(function()
        curve = "new"
        for _, a in ipairs(AXES) do
            if a.mode ~= nil then values[a.key] = 0 end
        end
    end)
end

-- Restore saved audio only after confirming this release supports its UI and
-- stock engine. Legacy settings are reapplied unchanged when their backup is
-- available; conversion is still required before the new controls appear.
if enabled and modern_mseb_ui then
    if file_exists(OTHER_EQ_OWNER_BACKUP) then
        -- Loudness Boost owns the EQ snapshot. If stock MSEB has no snapshot,
        -- simply turn off its transient override; never load the PEQ over the
        -- boost's active profile.
        local restored = true
        if file_exists(BACKUP_PATH) then
            restored = restore_backup()
        elseif curve == "new" and native_mseb() then
            restored = apply_native(false)
        end
        if restored then
            enabled = false
            if write_state() and file_exists(BACKUP_PATH) then os.remove(BACKUP_PATH) end
        end
    elseif curve == "new" and native_mseb() then
        if file_exists(BACKUP_PATH) then
            -- Upgrade from the former PEQ approximation. Restore the manual
            -- EQ once, then let stock MSEB own playback. Keep the backup until
            -- the enabled state is durably written so a failed migration can
            -- be retried on the next launch.
            local restored = load_manual_backup()
            if restored and apply_native(true) and write_state() then
                os.remove(BACKUP_PATH)
            end
        else
            -- Native state is transient across manager reloads; persisted
            -- plugin state is authoritative on each launch.
            apply_native(true)
        end
    elseif file_exists(BACKUP_PATH) then
        if not apply_profile() then
            local restored = restore_backup()
            enabled = false
            -- Keep the backup until the user's EQ is really back.
            if write_state() and restored then os.remove(BACKUP_PATH) end
        end
    else
        if curve ~= "legacy" then
            enabled = false
            write_state()
        end
    end
end

local function show_screen(title, rows, options)
    if options then
        plugin.show_settings_list(title, rows, options)
    else
        plugin.show_settings_list(title, rows)
    end
end

local open_sound_stage

local function redraw_sound_stage()
    open_sound_stage({ update = true })
end

-- Sliders report once, when the finger lifts. A cancelled drag never gets
-- here, so it changes nothing. A value that did not change writes nothing.
-- A refused change redraws the screen, so the slider shows the value that is
-- actually applied, not the one the finger left it on.
local function tone_slider(key, redraw)
    return function(v)
        local next_value = math.max(-axis_range, math.min(axis_range, clamp_axis(v)))
        if next_value == values[key] then return end
        if not commit_values(function() values[key] = next_value end) then
            plugin.show_toast("Could not apply changes. Try again.")
            redraw()
        end
    end
end

local function group_rows(entries, note, redraw, refresh_range)
    local rows = {}
    local has_outside = false
    for _, e in ipairs(entries) do
        if math.abs(values[e[1]]) > axis_range then has_outside = true end
    end
    if has_outside then
        table.insert(rows, {
            type = "row",
            label = "Some values exceed this range. Widen it to edit them.",
            wrap = true,
            on_select = function() plugin.show_toast("Stored values and sound are unchanged; widen the range to edit values outside it.") end,
        })
    end
    if note then
        table.insert(rows, {
            type = "row",
            label = note.label,
            wrap = true,
            on_select = function()
                plugin.show_toast(note.toast)
            end,
        })
    end
    for _, e in ipairs(entries) do
        local key, label = e[1], e[2]
        if math.abs(values[key]) > axis_range then
            table.insert(rows, {
                type = "row",
                label = label .. ": " .. tostring(values[key]) .. " (outside ±" .. tostring(axis_range) .. ")",
                on_select = function() choose_axis_range(refresh_range) end,
            })
        else
            table.insert(rows, {
                type = "slider",
                label = label,
                min = -axis_range,
                max = axis_range,
                value = values[key],
                on_change = tone_slider(key, redraw),
            })
        end
    end
    return rows
end

-- Stereo width remains part of MSEB's state and presets. Crossfeed belongs to
-- the native Sound page and is deliberately not exposed here.
open_sound_stage = function(options)
    local rows = {
        {
            type = "row",
            label = native_mseb()
                and "Stock MSEB width changes the channel mix."
                or "Stereo width changes the channel mix.",
            wrap = true,
            on_select = function()
                plugin.show_toast(native_mseb()
                    and "Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."
                    or "Negative narrows, positive widens with lower center level. Mono input is unchanged.")
            end,
        },
    }
    if math.abs(values.sound_stage) > axis_range then
        table.insert(rows, {
            type = "row",
            label = "Stereo Width: " .. tostring(values.sound_stage) .. " (outside ±" .. tostring(axis_range) .. ")",
            on_select = function() choose_axis_range(function() open_sound_stage({ update = true }) end) end,
        })
    else
        table.insert(rows, { type = "slider", label = "Stereo Width", min = -axis_range, max = axis_range, value = values.sound_stage, on_change = tone_slider("sound_stage", redraw_sound_stage) })
    end
    show_screen("Sound Stage", rows, options)
end

-- The new-release UI uses the native stock ten-control layout. Legacy saved
-- curves must be explicitly converted before this screen is shown.
local STOCK_AXES = {
    { "temperature", "Overall Temperature" },
    { "bass_ext", "Bass Extension" },
    { "bass_texture", "Bass Texture" },
    { "thickness", "Note Thickness" },
    { "vocal_pos", "Vocals" },
    { "female_vocal", "Female Overtones" },
    { "sibilance_lf", "Sibilance LF" },
    { "sibilance_hf", "Sibilance HF" },
    { "impulse_tone", "Impulse Response" },
    { "air", "Air" },
}

local function refresh_mseb_pages()
    open_settings({ update = true })
end

open_options = function()
    local items = {
        "Adjustment Range",
        "Sound Stage",
        "Reset to Defaults",
        "Named Presets",
        "Save Named Preset",
        "Save to Slot",
        "Load from Slot",
    }
    local actions = {
        function()
            choose_axis_range()
        end,
        function()
            open_sound_stage()
        end,
        function()
            if reset_defaults() then
                plugin.show_toast("MSEB reset")
                refresh_mseb_pages()
            else
                plugin.show_toast("Could not reset MSEB. Try again.")
            end
        end,
        open_named_presets,
        save_named_preset,
        function()
            plugin.show_list("Save to Slot", { "Slot 1", "Slot 2", "Slot 3" }, function(index)
                if save_slot(index) then plugin.show_toast("Saved to slot")
                else plugin.show_toast("Could not save slot. Try again.") end
            end)
        end,
        function()
            plugin.show_list("Load from Slot", { "Slot 1", "Slot 2", "Slot 3" }, function(index)
                load_slot(index)
            end)
        end,
    }
    plugin.show_list("MSEB Options", items, function(index)
        local action = actions[index]
        if action then action() end
    end)
end

local LEGACY_LAYOUT_MESSAGE = "This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."

local function show_legacy_confirmation(after)
    local function switch_to_stock()
        if curve ~= "legacy" then
            plugin.show_toast("Stock MSEB controls are already selected")
            return
        end
        if not convert_to_new() then
            plugin.show_toast("Could not switch controls. Try again.")
            return
        end
        plugin.show_toast("Stock MSEB controls selected")
        if after then after() end
        open_settings({ update = true })
    end

    -- The native confirmation popup carries the explanation as its title and
    -- supplies its own Cancel; Cancel and the backdrop leave settings as they
    -- are. Older players fall back to the settings screen below.
    if plugin.has_capability("ui.confirmation") and plugin.show_confirmation then
        if plugin.show_confirmation(LEGACY_LAYOUT_MESSAGE, "Switch to stock MSEB", switch_to_stock) then
            return
        end
    end

    local rows = {
        {
            type = "row",
            label = LEGACY_LAYOUT_MESSAGE,
            wrap = true,
            on_select = function()
                plugin.show_toast("Switching replaces Instrument Presence, Bass Bite, and Treble Bite")
            end,
        },
        {
            type = "row",
            label = "Switch to stock MSEB",
            on_select = switch_to_stock,
        },
        {
            type = "row",
            label = "Cancel",
            on_select = function()
                plugin.show_toast("Kept existing MSEB settings")
                if plugin.has_capability("ui.quick_toggle") then
                    plugin.set_quick_toggle("mseb", enabled)
                end
            end,
        },
    }
    plugin.show_settings_list("MSEB", rows, { update = true })
end

open_settings = function(options, after)
    if curve == "legacy" then
        show_legacy_confirmation(after)
        return
    end
    local rows = {
        {
            type = "toggle",
            label = "Enabled",
            value = enabled,
            on_change = function(v)
                local ok, message = set_enabled(v)
                show_enabled_result(ok, message)
                if plugin.has_capability("ui.quick_toggle") then
                    plugin.set_quick_toggle("mseb", enabled)
                end
            end,
        },
        {
            type = "row",
            label = "Options",
            on_select = function() open_options() end,
        },
    }

    local redraw = function() open_settings({ update = true }) end
    -- Range selection refreshes this root screen itself, so do not request a
    -- second redraw from the flat settings list.
    local flat_rows = group_rows(STOCK_AXES, nil, redraw, nil)
    for _, row in ipairs(flat_rows) do rows[#rows + 1] = row end
    plugin.show_settings_list("MSEB", rows, options)
end

if modern_mseb_ui then
    plugin.register_list_item("music_audio", "MSEB", open_settings)
else
    plugin.show_toast("Latest Compas firmware with stock MSEB is required")
end

-- Quick drawer tile, mirroring the "Enabled" row above.
if modern_mseb_ui and plugin.has_capability("ui.quick_toggle") then
    plugin.register_quick_toggle("mseb", "MSEB", function(on)
        if on and curve == "legacy" then
            plugin.set_quick_toggle("mseb", enabled)
            open_settings({ update = true }, function()
                local ok, message = set_enabled(true)
                show_enabled_result(ok, message)
                plugin.set_quick_toggle("mseb", enabled)
            end)
            return
        end
        local ok, message = set_enabled(on)
        show_enabled_result(ok, message)
        if not ok then
            plugin.set_quick_toggle("mseb", enabled)
        end
    end, {
        icon = "pull_down/mseb.png",
        value = enabled,
        on_hold = open_settings,
    })
end
