-- Choose an image for the device's startup splash. The native player prepares
-- a screen-sized RGB565 cache and applies it on the next boot.

plugin.define({
    id = "org.compas.startup_image",
    name = "Startup Image",
    version = "1.0.2",
    api_min = 17,
})

local plugin_dir = plugin.sd_root() .. "/.plugins/StartupImage"
-- Write to a new candidate so a failed conversion never damages the image
-- currently selected for the next boot.
local prepared_path = plugin_dir .. "/startup-next.bin"
local picker_busy = false
local preparing = false

local function friendly_error(err)
    local message = string.lower(tostring(err or ""))
    if message:find("busy", 1, true) or message:find("already", 1, true) then
        return "Player is busy; try again shortly"
    elseif message:find("dimension", 1, true) or message:find("resolution", 1, true)
        or message:find("pixel", 1, true) then
        return "Image dimensions are too large; choose a smaller image"
    elseif message:find("3mb", 1, true) or message:find("size", 1, true)
        or message:find("large", 1, true) then
        return "Choose an image no larger than 3 MB"
    elseif message:find("memory", 1, true) or message:find("nomem", 1, true) then
        return "Not enough memory to prepare that image"
    elseif message:find("corrupt", 1, true) or message:find("invalid", 1, true)
        or message:find("decode", 1, true) or message:find("format", 1, true)
        or message:find("unsupported", 1, true) then
        return "That image could not be read; choose a valid JPG, PNG, or BMP"
    end
    return "Could not prepare the startup image"
end

local function current_status()
    local ok, has_image = pcall(plugin.has_startup_image)
    if ok and has_image then
        return "Custom image set · applies on next boot"
    end
    return "Using the default splash"
end

local menu_handle
local open_menu
local choose_image
local restore_default

local function menu_items()
    local function info_row(label)
        if plugin.has_capability("ui.list_wrap") then
            return { label = label, wrap = true }
        end
        return label
    end
    return {
        info_row(current_status()),
        "Choose image",
        "Restore default splash",
        info_row("JPG, PNG, or BMP · up to 3 MB"),
        info_row("Changes apply on the next boot. Custom images keep their original colors."),
    }
end

local function on_menu_select(index)
    if index == 2 then
        choose_image()
    elseif index == 3 then
        restore_default()
    end
end

local function refresh_menu_status()
    if not menu_handle or not plugin.has_capability("ui.list_update")
        or not plugin.has_capability("ui.list_showing")
        or type(plugin.is_list_showing) ~= "function"
        or not plugin.is_list_showing(menu_handle) then
        return
    end
    local replacement = plugin.show_list("Startup Image", menu_items(), on_menu_select,
        { replace = menu_handle })
    if replacement then menu_handle = replacement end
end

local function supported_image(path)
    if type(path) ~= "string" then return false end
    local ext = string.lower(path:match("%.([^./]+)$") or "")
    return ext == "png" or ext == "jpg" or ext == "jpeg" or ext == "bmp"
end

choose_image = function()
    if picker_busy or preparing then
        plugin.show_toast("Startup image preparation is already in progress")
        return
    end
    if not plugin.has_capability("ui.file_picker") then
        plugin.show_toast("Image selection needs a newer player build")
        return
    end
    if not plugin.has_capability("ui.startup_image") then
        plugin.show_toast("Startup image support needs a newer player build")
        return
    end

    local function on_picked(source)
        picker_busy = false
        if not source then return end -- Cancellation leaves the current image unchanged.
        if not supported_image(source) then
            plugin.show_toast("Choose a JPG, PNG, or BMP image")
            return
        end
        if not plugin.mkdir(plugin_dir) then
            plugin.show_toast("Could not create the startup image folder on the SD card")
            return
        end

        preparing = true
        local progress
        if plugin.has_capability("ui.progress") then
            progress = plugin.show_progress("Startup Image", "Preparing image…", nil)
        end
        local completed = false
        local function finish(ok, reason)
            if completed then return end
            completed = true
            preparing = false
            if progress then plugin.close_progress(progress); progress = nil end
            if not ok then
                plugin.show_toast(friendly_error(reason))
                return
            end
            plugin.show_toast("Startup image saved · applies on next boot")
            refresh_menu_status()
        end

        local started, start_err = plugin.image_startup_async(source, prepared_path,
            function(path, reason)
                if not path then
                    finish(false, reason)
                    return
                end

                local call_ok, install_started, install_err = pcall(
                    plugin.set_startup_image_async, path, function(ok, err)
                        finish(ok == true, err)
                    end)
                if not call_ok then
                    finish(false, install_started)
                elseif install_started ~= true then
                    finish(false, install_err or install_started)
                end
                if not call_ok or install_started ~= true then
                    return
                end
            end)

        if not started then
            finish(false, start_err)
        end
    end

    picker_busy = true
    local ok, result, open_err = pcall(plugin.pick_file, nil, on_picked)
    if not ok or result ~= true then
        picker_busy = false
        plugin.show_toast(friendly_error(open_err or (not ok and result) or result))
    end
end

restore_default = function()
    if preparing then
        plugin.show_toast("Wait for image preparation to finish")
        return
    end
    preparing = true
    local progress
    if plugin.has_capability("ui.progress") then
        progress = plugin.show_progress("Startup Image", "Restoring default splash…", nil)
    end
    local completed = false
    local function finish(ok, err)
        if completed then return end
        completed = true
        preparing = false
        if progress then plugin.close_progress(progress); progress = nil end
        if not ok then
            plugin.show_toast(friendly_error(err))
            return
        end
        plugin.show_toast("Default splash restored · applies on next boot")
        refresh_menu_status()
    end
    local call_ok, started, err = pcall(plugin.set_startup_image_async, nil, finish)
    if not call_ok then
        finish(false, started)
    elseif started ~= true then
        finish(false, err or started)
    end
    if not call_ok or started ~= true then
        return
    end
end

open_menu = function()
    if not plugin.has_capability("ui.startup_image") then
        plugin.show_toast("Startup image support needs a newer player build")
        return
    end
    menu_handle = plugin.show_list("Startup Image", menu_items(), on_menu_select)
end

plugin.register_list_item("display", "Startup Image", open_menu, {
    group = "appearance",
})
