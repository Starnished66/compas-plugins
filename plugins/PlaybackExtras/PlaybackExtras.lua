plugin.define({ id = "example.playback_extras", name = "Playback Extras", version = "1.1", api_min = 13 })

-- Reference implementation for plugin.register_list_item("music_audio", ...)
-- and plugin.show_settings_list() (see PLUGINS.md): adds a "Loudness Boost"
-- row to Settings -> Music Settings -> Audio, opening a nested submenu with
-- a real toggle switch, a real slider, and a nested row (a submenu inside a
-- submenu).
-- Also demonstrates the icon/height/text_size row options: the toggle row
-- gets a real icon (pointed at a real stock theme2 asset by its raw
-- filesystem path -- no user-supplied image needed for this example to
-- work), and the "About" row is shown at "large" text size.
--
-- Boost derives an active profile from a saved snapshot, preserving the
-- user's bands and restoring their original preamp and bypass when disabled.

local STATE_PATH = plugin.sd_root() .. "/.plugins/.playback_extras_state"
local BACKUP_PATH = plugin.sd_root() .. "/.plugins/.playback_extras_backup.peq"
local ACTIVE_PATH = plugin.sd_root() .. "/.plugins/.playback_extras_active.peq"
-- MSEB also snapshots and restores the whole EQ; its backup exists exactly
-- while it is on. Two independent snapshots cannot be restored in any
-- order, so the boost refuses to turn on beside it.
local OTHER_EQ_OWNER_BACKUP = plugin.sd_root() .. "/.plugins/.mseb_pre_backup.peq"

local function file_exists(path)
    local f = io.open(path, "r")
    if f then f:close() return true end
    return false
end

local function read_state()
    local f = io.open(STATE_PATH, "r")
    if not f then return { enabled = false, boost_db = 4 } end
    local enabled_line = f:read("*l")
    local boost_line = f:read("*l")
    f:close()
    return {
        enabled = enabled_line == "1",
        boost_db = tonumber(boost_line) or 4,
    }
end

local function write_state(state)
    local temp_path = STATE_PATH .. ".tmp"
    local f = io.open(temp_path, "w")
    if not f then return false end
    local ok = f:write(state.enabled and "1" or "0", "\n", tostring(state.boost_db))
    local closed = f:close()
    if not ok or not closed then
        os.remove(temp_path)
        return false
    end
    return os.rename(temp_path, STATE_PATH)
end

local state = read_state()

-- A real stock theme2 asset, present on every real device -- see this
-- file's own header comment. Raw absolute filesystem path, not a
-- theme2-relative one (see PLUGINS.md's "Row images, resizing, and text
-- size" section for why).
local BOOST_ICON = "/usr/resource/litegui/theme2/launcher/music.png"

local function build_active_profile()
    local source = io.open(BACKUP_PATH, "r")
    if not source then return false end
    local temp_path = ACTIVE_PATH .. ".tmp"
    local target = io.open(temp_path, "w")
    if not target then source:close() return false end
    local seen_bypass, seen_preamp = false, false
    local ok = true
    local line = source:read("*l")
    while line and ok do
        local key = line:match("^([^=]+)=")
        if key == "bypass" then
            ok = target:write("bypass=0\n")
            seen_bypass = true
        elseif key == "preamp" then
            ok = target:write("preamp=" .. tostring(state.boost_db) .. "\n")
            seen_preamp = true
        else
            ok = target:write(line, "\n")
        end
        line = source:read("*l")
    end
    local source_closed = source:close()
    if ok and not seen_bypass then ok = target:write("bypass=0\n") end
    if ok and not seen_preamp then ok = target:write("preamp=" .. tostring(state.boost_db) .. "\n") end
    local target_closed = target:close()
    if not ok or not source_closed or not target_closed or not os.rename(temp_path, ACTIVE_PATH) then
        os.remove(temp_path)
        return false
    end
    return plugin.eq_load_profile(ACTIVE_PATH)
end

local function enable_boost()
    if file_exists(OTHER_EQ_OWNER_BACKUP) then return false, "Turn off MSEB first" end
    -- A backup left by a restore that failed still holds the user's EQ from
    -- before the boost; keep it rather than snapshot the current state.
    if not file_exists(BACKUP_PATH) and not plugin.eq_save_profile(BACKUP_PATH) then return false end
    return build_active_profile()
end

local function restore_profile()
    if not plugin.eq_load_profile(BACKUP_PATH) then return false end
    return true
end

if state.enabled and file_exists(OTHER_EQ_OWNER_BACKUP) then
    -- Both on is only possible with files left by older versions; step aside
    -- and give the user back the EQ saved before the boost.
    local restored = file_exists(BACKUP_PATH) and plugin.eq_load_profile(BACKUP_PATH)
    state.enabled = false
    if write_state(state) and restored then os.remove(BACKUP_PATH) end
elseif state.enabled and not build_active_profile() then
    local restored = plugin.eq_load_profile(BACKUP_PATH)
    state.enabled = false
    if write_state(state) and restored then os.remove(BACKUP_PATH) end
end

local function open_about_menu()
    plugin.show_settings_list("About Loudness Boost", {
        {
            type = "row",
            label = "What does this do?",
            on_select = function()
                plugin.show_toast("Raises the whole-EQ preamp by the chosen amount while enabled.")
            end,
        },
    })
end

local function open_menu()
    plugin.show_settings_list("Loudness Boost", {
        {
            type = "toggle",
            label = "Enable Boost",
            value = state.enabled,
            icon = BOOST_ICON,
            on_change = function(new_value)
                if new_value then
                    local ok, reason = enable_boost()
                    if not ok then
                        plugin.show_toast(reason or "Could not enable boost. Try again.")
                        return
                    end
                    state.enabled = true
                    if not write_state(state) then
                        state.enabled = false
                        plugin.eq_load_profile(BACKUP_PATH)
                        plugin.show_toast("Could not enable boost. Try again.")
                        return
                    end
                else
                    if not restore_profile() then
                        plugin.show_toast("Could not restore sound settings. Try again.")
                        return
                    end
                    state.enabled = false
                    if not write_state(state) then
                        state.enabled = true
                        build_active_profile()
                        plugin.show_toast("Could not restore sound settings. Try again.")
                        return
                    end
                    os.remove(BACKUP_PATH)
                end
            end,
        },
        {
            type = "slider",
            label = "Boost Amount (dB)",
            min = 0,
            max = 12,
            value = state.boost_db,
            on_change = function(new_value)
                local previous = state.boost_db
                state.boost_db = new_value
                if state.enabled and not build_active_profile() then
                    state.boost_db = previous
                    plugin.show_toast("Could not apply boost. Try again.")
                    return
                end
                if not write_state(state) then
                    state.boost_db = previous
                    if state.enabled then build_active_profile() end
                end
            end,
        },
        {
            type = "row",
            label = "About",
            text_size = "large",
            on_select = open_about_menu,
        },
    })
end

plugin.register_list_item("music_audio", "Loudness Boost", open_menu, { group = "effects" })
