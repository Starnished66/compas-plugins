plugin.define({
  id = "example.lock_screen",
  name = "Lock Screen",
  version = "1.7",
  api_min = 19,
})

-- Lock Screen companion plugin.
-- Configures the screen shown when the display wakes from being off.

if not plugin.has_capability("ui.lock_screen") then
  plugin.show_toast("Lock Screen needs a newer player build")
  return
end

local KEY_MODE = "mode" -- Kept for migration from versions before 1.3.
local KEY_ENABLED = "enabled"
local KEY_BUTTON_LOCK = "button_lock"
local button_lock_shortcut
local KEY_BACKGROUND = "background"
local KEY_IMAGE = "image_path"
local KEY_IMAGE_FIT = "image_fit"

local BACKGROUNDS = {
  { key = "album_art", label = "Album art" },
  { key = "image", label = "Photo" },
  { key = "clock", label = "Clock" },
}

local function legacy_mode()
  local mode = plugin.storage.get(KEY_MODE, "off")
  if mode == "album_art" or mode == "image" or mode == "clock" then return mode end
  return "off"
end

local get_background

local function is_enabled()
  local saved = plugin.storage.get(KEY_ENABLED)
  if saved == "1" or saved == "true" then return true end
  if saved == "0" or saved == "false" then return false end
  return legacy_mode() ~= "off"
end

local function set_enabled(enabled)
  plugin.storage.set(KEY_ENABLED, enabled and "1" or "0")
  -- Preserve the old on/off representation for older plugin versions.
  plugin.storage.set(KEY_MODE, enabled and get_background() or "off")
end

local function is_button_lock_enabled()
  local saved = plugin.storage.get(KEY_BUTTON_LOCK)
  return saved == "1" or saved == "true"
end

local function set_button_lock_enabled(enabled)
  button_lock_shortcut = plugin.configure_button_lock(enabled)
  plugin.storage.set(KEY_BUTTON_LOCK, enabled and "1" or "0")
end

button_lock_shortcut = plugin.configure_button_lock(is_button_lock_enabled())

get_background = function()
  local saved = plugin.storage.get(KEY_BACKGROUND)
  if saved == "album_art" or saved == "image" or saved == "clock" then return saved end
  local old = legacy_mode()
  return old == "off" and "album_art" or old
end

local function set_background(background)
  plugin.storage.set(KEY_BACKGROUND, background)
  plugin.storage.set(KEY_MODE, is_enabled() and background or "off")
end

local function get_custom_image_path()
  return plugin.storage.get(KEY_IMAGE, "")
end

local function has_readable_photo(path)
  if not path or path == "" then return false end
  local file = io.open(path, "rb")
  if not file then return false end
  file:close()
  return true
end

local function get_custom_image_fit()
  local fit = plugin.storage.get(KEY_IMAGE_FIT)
  if fit == "contain" then return "contain" end
  -- Make new and migrated photo backgrounds fill the display by default.
  return "cover"
end

local function get_preview_options()
  local preview = {
    mode = get_background(),
    image_fit = get_custom_image_fit(),
  }
  if preview.mode == "image" then
    local image_path = get_custom_image_path()
    if has_readable_photo(image_path) then
      preview.image_path = image_path
    else
      preview.mode = "clock"
    end
  end
  return preview
end

local function trigger_lock_screen(preview)
  if not preview and not is_enabled() then return end

  local mode = get_background()
  local opts = { mode = mode, image_fit = get_custom_image_fit() }
  if mode == "image" then
    local image_path = get_custom_image_path()
    if not image_path or image_path == "" then
      plugin.show_toast("Choose a photo for the lock screen first")
      return
    end
    opts.image_path = image_path
  end

  local shown = plugin.show_lock_screen(opts)
  if not shown then
    plugin.show_toast("Could not show lock screen. Showing the clock instead.")
    plugin.show_lock_screen({ mode = "clock" })
  end
end

plugin.on("screen_woke", trigger_lock_screen)

local function is_photo(name)
  local lower = name:lower()
  return lower:match("%.png$") or lower:match("%.jpg$") or lower:match("%.jpeg$")
end

local open_lock_settings
local open_background_settings

local function open_photo_picker(dir_path)
  dir_path = dir_path or plugin.sd_root()
  if #dir_path >= 256 then
    plugin.show_toast("That folder path is too long to use for a lock screen photo")
    return
  end

  local ok, files = pcall(plugin.list_dir, dir_path)
  if not ok then
    plugin.show_toast("Could not read this photo folder")
    return
  end
  if type(files) ~= "table" then
    plugin.show_toast("Could not read this photo folder")
    return
  end

  local folders, photos = {}, {}
  for i = 1, math.min(#files, 500) do
    local entry = files[i]
    if type(entry.name) == "string" then
      local full_path = dir_path .. "/" .. entry.name
      if #full_path < 256 then
        if entry.dir then
          folders[#folders + 1] = entry.name
        elseif is_photo(entry.name) then
          photos[#photos + 1] = entry.name
        end
      end
    end
  end
  table.sort(folders)
  table.sort(photos)

  local items, destinations = {}, {}
  local parent = nil
  local root = plugin.sd_root()
  if dir_path ~= root then
    local trimmed = dir_path:gsub("/+$", "")
    local parent_path = trimmed:match("^(.*)/[^/]+$")
    if parent_path and #parent_path >= #root then parent = parent_path end
  end
  if parent then
    items[#items + 1] = { label = ".." }
    destinations[#destinations + 1] = { path = parent }
  end

  local limit = 500 - #items
  for _, name in ipairs(folders) do
    if #items >= limit then break end
    items[#items + 1] = { label = "Folder: " .. name }
    destinations[#destinations + 1] = { path = dir_path .. "/" .. name }
  end
  for _, name in ipairs(photos) do
    if #items >= limit then break end
    local path = dir_path .. "/" .. name
    items[#items + 1] = { label = name }
    destinations[#destinations + 1] = { photo = path }
  end

  local folder_name = dir_path == root and "SD Card" or dir_path:match("([^/]+)/*$") or "Photos"
  if #items == 0 then
    plugin.show_toast("No photos or folders here")
    return
  end

  plugin.show_list("Choose Photo · " .. folder_name, items, function(index)
    local destination = destinations[index]
    if not destination then return end
    if destination.path then
      open_photo_picker(destination.path)
    elseif destination.photo then
      plugin.storage.set(KEY_IMAGE, destination.photo)
      set_background("image")
      plugin.show_toast("Lock screen photo selected")
      open_lock_settings(true)
      open_background_settings(true)
    end
  end)
end

local function open_framing_settings()
  plugin.show_settings_list("Framing", {
    {
      type = "row",
      label = "Fill screen" .. (get_custom_image_fit() == "cover" and " (selected)" or ""),
      on_select = function()
        plugin.storage.set(KEY_IMAGE_FIT, "cover")
        plugin.show_toast("Framing: Fill screen")
        open_lock_settings(true)
      end,
    },
    {
      type = "row",
      label = "Keep whole image" .. (get_custom_image_fit() == "contain" and " (selected)" or ""),
      on_select = function()
        plugin.storage.set(KEY_IMAGE_FIT, "contain")
        plugin.show_toast("Framing: Keep whole image")
        open_lock_settings(true)
      end,
    },
  })
end

open_background_settings = function(update)
  local rows = {}
  for _, background in ipairs(BACKGROUNDS) do
    local selected_background = background.key
    local background_label = background.label
    local marker = get_background() == selected_background and " (selected)" or ""
    rows[#rows + 1] = {
      type = "row",
      label = background_label .. marker,
      on_select = function()
        if selected_background == "image" and not has_readable_photo(get_custom_image_path()) then
          open_photo_picker()
        else
          set_background(selected_background)
          open_lock_settings(true)
          open_background_settings(true)
        end
      end,
    }
  end

  if get_background() == "image" then
    rows[#rows + 1] = {
      type = "row", label = "Choose photo",
      on_select = function() open_photo_picker() end,
    }
  end

  plugin.show_settings_list("Lock Screen Background", rows, {
    update = update == true,
    preview = get_preview_options(),
  })
end

open_lock_settings = function(update)
  local background = get_background()
  local background_label = "Album art"
  for _, choice in ipairs(BACKGROUNDS) do
    if choice.key == background then background_label = choice.label end
  end

  local rows = {
    {
      type = "toggle",
      label = "Lock screen",
      value = is_enabled(),
      on_change = function(value) set_enabled(value) end,
    },
    {
      type = "toggle",
      label = "Button lock\n" .. button_lock_shortcut,
      value = is_button_lock_enabled(),
      wrap = true,
      on_change = function(value) set_button_lock_enabled(value) end,
    },
    {
      type = "row",
      label = "Background\n" .. background_label,
      wrap = true,
      on_select = open_background_settings,
    },
  }

  if background == "image" or background == "album_art" then
    rows[#rows + 1] = {
      type = "row",
      wrap = true,
      label = "Framing\n" .. (get_custom_image_fit() == "cover" and "Fill screen" or "Keep whole image"),
      on_select = open_framing_settings,
    }
  end

  rows[#rows + 1] = {
    type = "row",
    label = "Preview lock screen",
    on_select = function() trigger_lock_screen(true) end,
  }

  plugin.show_settings_list("Lock Screen", rows, {
    update = update == true,
    preview = get_preview_options(),
  })
end

plugin.register_list_item("display", "Lock Screen", open_lock_settings, {})
