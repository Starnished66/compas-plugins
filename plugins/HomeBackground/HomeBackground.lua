-- Choose a photo for the Home screen background.
-- The player prepares an exact-screen RGB565 image asynchronously so the
-- Home layout can use it directly at startup.

plugin.define({
    id = "org.example.home_background",
    name = "Home Background",
    version = "1.2.2",
    api_min = 17,
})

local sd_root = plugin.sd_root()
local plugins_dir = sd_root .. "/.plugins"
local plugin_dir = plugins_dir .. "/HomeBackground"
local wallpaper_path = plugin_dir .. "/wallpaper.bin"
local legacy_path = plugins_dir .. "/home_bg.jpg"
local is_busy = false
local picker_busy = false
local unusable_background = false
local legacy_background_applied = false

local function file_exists(path)
    local file = io.open(path, "rb")
    if not file then return false end
    file:close()
    return true
end

local function apply_background()
    if not plugin.has_capability("ui.home_background") then return end
    if plugin.storage.get("disabled", "0") == "1" then return end

    -- The canonical file is managed by this plugin. Keep the old image as a
    -- fallback so existing installations retain their current background.
    if file_exists(wallpaper_path) then
        local ok = pcall(plugin.set_home_layout, {}, { background_image = wallpaper_path })
        if ok then return end
        unusable_background = true
    end
    if file_exists(legacy_path) then
        local ok = pcall(plugin.set_home_layout, {}, { background_image = legacy_path })
        if ok then
            legacy_background_applied = true
        else
            unusable_background = true
        end
    end
end

-- Layout options are applied during plugin loading, before Home is built.
apply_background()

local function current_background()
    if plugin.storage.get("disabled", "0") == "1" then return "Wallpaper is off" end
    if unusable_background then
        if legacy_background_applied then return "Using previous wallpaper; choose a new image" end
        return "Saved image unusable; choose another"
    end
    if file_exists(wallpaper_path) then return "Wallpaper is set" end
    if file_exists(legacy_path) then return "Using existing wallpaper" end
    return "No wallpaper set"
end

local function parent_folder(path)
    if type(path) ~= "string" then return nil end
    return path:match("^(.*)/[^/]+$")
end

local function picker_start_folder()
    local last_folder = plugin.storage.get("last_folder", "")
    if last_folder ~= "" then
        local ok, entries = pcall(plugin.list_dir, last_folder)
        if ok and type(entries) == "table" then return last_folder end
    end
    return nil -- Native picker opens at the SD root.
end

local function friendly_error(err)
    local message = string.lower(tostring(err or ""))
    if message:find("busy", 1, true) or message:find("already", 1, true) then
        return "Player is busy; try again shortly"
    elseif message:find("dimension", 1, true) then
        return "That image's resolution is too large"
    elseif message:find("3mb", 1, true) or message:find("size", 1, true)
        or message:find("large", 1, true) then
        return "Choose an image no larger than 3 MB"
    elseif message:find("memory", 1, true) or message:find("nomem", 1, true) then
        return "Not enough memory to prepare that image"
    elseif message:find("corrupt", 1, true) or message:find("invalid", 1, true)
        or message:find("decode", 1, true) or message:find("format", 1, true)
        or message:find("unsupported", 1, true) or message:find("pattern", 1, true) then
        return "That image could not be read; choose a valid JPG, PNG, or BMP"
    elseif message:find("open", 1, true) and message:find("folder", 1, true) then
        return "Could not open that folder; choose another location"
    elseif message:find("mkdir", 1, true) or message:find("create", 1, true) then
        return "Could not create the wallpaper folder on the SD card"
    end
    return "Could not prepare the wallpaper"
end

local function choose_wallpaper()
    if is_busy or picker_busy then
        plugin.show_toast("Wallpaper preparation is already in progress")
        return
    end
    if not plugin.has_capability("ui.file_picker") then
        plugin.show_toast("Wallpaper selection needs a newer player build")
        return
    end
    if not plugin.has_capability("data.wallpaper") then
        plugin.show_toast("Wallpaper preparation needs a newer player build")
        return
    end

    local function on_picked(source)
        picker_busy = false
        if not source then return end -- Cancel leaves the current image alone.

        local folder = parent_folder(source)
        if folder then plugin.storage.set("last_folder", folder) end

        if is_busy then
            plugin.show_toast("Wallpaper preparation is already in progress")
            return
        end
        if not plugin.mkdir(plugin_dir) then
            plugin.show_toast("Could not create the wallpaper folder on the SD card")
            return
        end

        is_busy = true
        local progress = nil
        if plugin.has_capability("ui.progress") then
            progress = plugin.show_progress("Wallpaper", "Preparing image…", nil)
        end

        local started, start_err = plugin.image_wallpaper_async(source, wallpaper_path,
            function(dest_path, reason)
                is_busy = false
                if progress then plugin.close_progress(progress) end
                if dest_path then
                    plugin.storage.set("disabled", "0")
                    plugin.show_toast("Wallpaper saved")
                    if plugin.has_capability("ui.reload") then plugin.reload_ui() end
                else
                    plugin.show_toast(friendly_error(reason))
                end
            end)

        if not started then
            is_busy = false
            if progress then plugin.close_progress(progress) end
            plugin.show_toast(friendly_error(start_err))
        end
    end

    local folder = picker_start_folder()
    picker_busy = true
    local ok, result, open_err = pcall(plugin.pick_file, folder, on_picked)
    if (not ok or result ~= true) and folder then
        -- The remembered folder may disappear between validation and open.
        ok, result, open_err = pcall(plugin.pick_file, nil, on_picked)
    end
    if not ok or result ~= true then
        picker_busy = false
        plugin.show_toast(friendly_error(open_err or (not ok and result) or result))
    end
end

local function remove_wallpaper()
    if is_busy then
        plugin.show_toast("Wait for wallpaper preparation to finish")
        return
    end
    -- Remove our own converted file, then suppress both sources. The legacy
    -- image belongs to the user and must remain untouched.
    if file_exists(wallpaper_path) then
        local removed, err = os.remove(wallpaper_path)
        if not removed then
            plugin.show_toast("Could not remove the saved wallpaper")
            return
        end
    end
    plugin.storage.set("disabled", "1")
    plugin.show_toast("Wallpaper removed")
    if plugin.has_capability("ui.reload") then plugin.reload_ui() end
end

local function open_wallpaper_menu()
    if not plugin.has_capability("data.wallpaper") then
        plugin.show_toast("Wallpaper selection needs a newer player build")
        return
    end
    local function info_row(label)
        if plugin.has_capability("ui.list_wrap") then
            return { label = label, wrap = true }
        end
        return label
    end
    local items = {
        info_row(current_background()),
        "Choose background",
        "Remove background",
        info_row("JPG, PNG or BMP · up to 3 MB"),
        info_row("PNG/BMP may also need to be 1200 px or smaller per side."),
        info_row("Fills the screen; edges may be cropped."),
    }
    plugin.show_list("Wallpaper", items, function(index)
        if index == 2 then
            choose_wallpaper()
        elseif index == 3 then
            remove_wallpaper()
        end
    end)
end

plugin.register_list_item("display", "Wallpaper", open_wallpaper_menu, {
    group = "appearance",
})
