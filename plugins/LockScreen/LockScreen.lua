plugin.define({
  id = "example.lock_screen",
  name = "Lock Screen",
  version = "1.2",
  api_min = 1,
})

-- Lock Screen companion plugin.
-- Adds a "Lock Screen" row to Settings -> Display.
-- Configures a cosmetic lock screen overlay shown when screen wakes from being off:
-- Modes: Off / Album Art / Custom Image / Clock.
-- Dismissed by swiping up.

if not plugin.has_capability("ui.lock_screen") then
  plugin.show_toast("Lock Screen needs a newer player build")
  return
end

local STORAGE_KEY_MODE = "mode"
local STORAGE_KEY_IMAGE = "image_path"
local STORAGE_KEY_IMAGE_FIT = "image_fit"

local MODES = {
  { key = "off",       label = "Off" },
  { key = "album_art", label = "Album Art" },
  { key = "image",     label = "Custom Image" },
  { key = "clock",     label = "Clock" },
}

local function get_current_mode()
  return plugin.storage.get(STORAGE_KEY_MODE, "off")
end

local function set_current_mode(mode_key)
  plugin.storage.set(STORAGE_KEY_MODE, mode_key)
end

local function get_custom_image_path()
  return plugin.storage.get(STORAGE_KEY_IMAGE, "")
end

local function set_custom_image_path(path)
  plugin.storage.set(STORAGE_KEY_IMAGE, path)
end

local function get_custom_image_fit()
  local fit = plugin.storage.get(STORAGE_KEY_IMAGE_FIT)
  if fit == "cover" then return "cover" end
  -- Migrate existing custom-image selections from natural-size rendering to
  -- Fit image the first time this plugin version opens the lock screen.
  return "contain"
end

local function set_custom_image_fit(fit)
  plugin.storage.set(STORAGE_KEY_IMAGE_FIT, fit)
end

local function trigger_lock_screen()
  local mode = get_current_mode()
  if mode == "off" then return end

  local opts = { mode = mode }
  if mode == "image" then
    local img_path = get_custom_image_path()
    if not img_path or img_path == "" then return end
    opts.image_path = img_path
    opts.image_fit = get_custom_image_fit()
  end

  local shown = plugin.show_lock_screen(opts)
  if not shown then
    plugin.show_toast("Could not show lock screen. Showing the clock instead.")
    plugin.show_lock_screen({ mode = "clock" })
  end
end

-- Screen woke event handler
plugin.on("screen_woke", function()
  trigger_lock_screen()
end)

local function open_custom_image_picker()
  local dir_path = plugin.sd_root() .. "/.plugins/lock_images"
  local files = plugin.list_dir(dir_path)
  local image_files = {}

  for _, entry in ipairs(files) do
    if not entry.dir then
      local name_lower = entry.name:lower()
      if name_lower:match("%.png$") or name_lower:match("%.jpg$") or name_lower:match("%.jpeg$") then
        table.insert(image_files, entry.name)
      end
    end
  end

  table.sort(image_files)

  while #image_files > 500 do image_files[#image_files] = nil end

  if #image_files == 0 then
    plugin.show_toast("Put pictures in the .plugins/lock_images folder to choose one")
    return
  end

  local current_img = get_custom_image_path()
  local selected_idx = 0
  for i, name in ipairs(image_files) do
    if dir_path .. "/" .. name == current_img then
      selected_idx = i
      break
    end
  end

  plugin.show_list("Select Image", image_files, function(index)
    if type(index) ~= "number" or index < 1 or index > #image_files then return end
    local chosen = dir_path .. "/" .. image_files[index]
    set_custom_image_path(chosen)
    set_current_mode("image")
    plugin.show_toast("Lock screen image selected")
  end, selected_idx > 0 and { selected = selected_idx } or nil)
end

local function open_custom_image_fit_picker()
  local current_fit = get_custom_image_fit()
  local selected_idx = current_fit == "cover" and 2 or 1
  plugin.show_list("Custom Image Fit", { "Fit image", "Fill screen" }, function(index)
    if index == 1 then
      set_custom_image_fit("contain")
      plugin.show_toast("Custom image: Fit image")
    elseif index == 2 then
      set_custom_image_fit("cover")
      plugin.show_toast("Custom image: Fill screen")
    end
  end, { selected = selected_idx })
end

plugin.register_list_item("display", "Lock Screen", function()
  local current_mode = get_current_mode()
  local labels = {}
  local selected_idx = 0

  for i, m in ipairs(MODES) do
    labels[i] = m.label
    if m.key == current_mode then
      selected_idx = i
    end
  end

  local show_image_fit = current_mode == "image" and get_custom_image_path() ~= ""
  if show_image_fit then
    local fit = get_custom_image_fit() == "cover" and "Fill screen" or "Fit image"
    labels[#labels + 1] = "Image fit: " .. fit
  end

  plugin.show_list("Lock Screen", labels, function(index)
    if show_image_fit and index == #MODES + 1 then
      open_custom_image_fit_picker()
      return
    end
    local chosen_mode = MODES[index].key
    if chosen_mode == "image" then
      open_custom_image_picker()
    else
      set_current_mode(chosen_mode)
      plugin.show_toast("Lock Screen: " .. MODES[index].label)
    end
  end, selected_idx > 0 and { selected = selected_idx } or nil)
end, { group = "player_layout" })
