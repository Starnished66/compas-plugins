#!/usr/bin/env python3
"""API-17, no-network smoke harness for the Compas plugin collection.

This is a test harness, not a provider-compatibility test. It runs each Lua
plugin in an isolated Lua environment after the release owner gives the
Stage-3 GO. All filesystem access is in-memory, HTTP is forced offline, and
the SDK proxy rejects unrecognized or unimplemented methods explicitly.
"""

from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile


ROOT = Path(__file__).resolve().parents[1]
HOST = Path(os.environ.get("COMPAS_PLAYER_ROOT", ROOT.parent / "compas-player"))
OUTPUT = Path(os.environ.get(
    "COMPAS_STAGE3_OUTPUT",
    Path(os.environ.get("XDG_CACHE_HOME") or Path.home() / ".cache") / "compas-player/qa/plugin-sandbox.json",
))


LUA_DRIVER = r'''-- This code executes only when the Python runner receives --run.
local known, capabilities, path, plugin_name, scenario = API_NAMES, CAPABILITIES, PLUGIN_PATH, PLUGIN_NAME, SCENARIO
local report = { plugin = plugin_name, scenario = scenario, syntax_status = "not_checked", metadata = nil, registrations = {}, ui = {}, events = {}, api_calls = {}, failures = {} }
local virtual_files = {}
local storage_values = {}
local json_encode
local sdk_effect_counts = {}
local json_roundtrips = {}
local mock_limitations = {}
local next_handle = 0
local event_callbacks = {}
local missing_api_names = {}
local unsupported_capability_names = {}
local entrypoint_callbacks = {}
local ui_actions = {}
local max_ui_actions = 200
local max_menu_choices = 12
local ui_action_count = 0

local function scrub_label(value)
    if type(value) ~= "string" then return nil end
    local lower = value:lower()
    if lower:find("token", 1, true) or lower:find("password", 1, true)
        or lower:find("secret", 1, true) or lower:find("api key", 1, true)
        or lower:find("authorization", 1, true) then
        return "[REDACTED AUTH-RELATED LABEL]"
    end
    local s = value:gsub("https?://%S+", "[URL]")
    s = s:gsub("([Tt]oken|[Pp]assword|[Ss]ecret|[Aa]uthorization|[Aa]pi[_-]?[Kk]ey)=?[^%s,;]+", "%1=[REDACTED]")
    return s:sub(1, 180)
end

local function queue_ui_action(kind, label, callback, args, value)
    if type(callback) ~= "function" then return end
    if ui_action_count >= max_ui_actions then report.ui_traversal_capped = true; return end
    ui_action_count = ui_action_count + 1
    ui_actions[#ui_actions + 1] = { kind = kind, label = label, callback = callback, args = args or {}, value = value }
end

local function record_ui(kind, title, rows, callback)
    local item = { kind = kind, label = scrub_label(title), rows = {} }
    if type(rows) == "table" then
        local count = math.min(#rows, 100)
        for i = 1, count do
            local row = rows[i]
            if type(row) == "table" then
                local label = scrub_label(row.label or row.title or row.text)
                item.rows[#item.rows + 1] = {
                    label = label,
                    type = type(row.type) == "string" and row.type or nil,
                    has_on_select = type(row.on_select) == "function",
                    has_on_change = type(row.on_change) == "function",
                    has_on_toggle = type(row.on_toggle) == "function",
                    value_type = type(row.value),
                }
                if kind == "list" and type(callback) == "function" and i <= max_menu_choices then
                    queue_ui_action("menu_choice", label, callback, { i }, i)
                end
                if kind == "settings" then
                    if row.type == "toggle" and type(row.on_change) == "function" then
                        queue_ui_action("toggle", label, row.on_change, { false }, false)
                        queue_ui_action("toggle", label, row.on_change, { true }, true)
                    elseif row.type == "slider" and type(row.on_change) == "function" then
                        local lo, hi, current = tonumber(row.min) or 0, tonumber(row.max) or 100, tonumber(row.value) or 0
                        local values = { lo, current, hi }
                        local seen = {}
                        for _, value in ipairs(values) do
                            if not seen[value] then seen[value] = true; queue_ui_action("slider", label, row.on_change, { value }, value) end
                        end
                    elseif type(row.on_select) == "function" then
                        queue_ui_action("settings_select", label, row.on_select, {}, nil)
                    end
                end
            elseif type(row) == "string" then
                local label = scrub_label(row)
                item.rows[#item.rows + 1] = { label = label }
                if kind == "list" and type(callback) == "function" and i <= max_menu_choices then
                    queue_ui_action("menu_choice", label, callback, { i }, i)
                end
            end
        end
        if #rows > count or (kind == "list" and #rows > max_menu_choices) then report.ui_traversal_capped = true end
    end
    report.ui[#report.ui + 1] = item
    return item
end

local function vfile(pathname, mode)
    local key = tostring(pathname):gsub("^%./", "")
    local m = mode or "r"
    if (m:find("r", 1, true) and not m:find("w", 1, true) and not m:find("a", 1, true)) and virtual_files[key] == nil then
        return nil, "virtual file not found"
    end
    if m:find("w", 1, true) then virtual_files[key] = "" end
    if virtual_files[key] == nil then virtual_files[key] = "" end
    local cursor, closed = 1, false
    local f = {}
    function f:read(fmt)
        if closed then return nil end
        fmt = fmt or "*l"
        local data = virtual_files[key] or ""
        if fmt == "*a" then cursor = #data + 1; return data:sub(1) end
        local start, stop = data:find("\n", cursor, true)
        if not start then
            if cursor > #data then return nil end
            local line = data:sub(cursor); cursor = #data + 1; return line:gsub("\r$", "")
        end
        local line = data:sub(cursor, start - 1); cursor = stop + 1
        return line:gsub("\r$", "")
    end
    function f:write(...)
        if closed then return nil, "closed" end
        local chunks = {}
        for i = 1, select("#", ...) do chunks[#chunks + 1] = tostring(select(i, ...)) end
        local chunk = table.concat(chunks)
        if m:find("a", 1, true) then virtual_files[key] = (virtual_files[key] or "") .. chunk
        else virtual_files[key] = (virtual_files[key] or ""):sub(1, cursor - 1) .. chunk .. (virtual_files[key] or ""):sub(cursor + #chunk) end
        cursor = cursor + #chunk
        return self
    end
    function f:seek(whence, offset)
        local data = virtual_files[key] or ""
        local base = whence == "set" and 1 or whence == "end" and #data + 1 or cursor
        cursor = math.max(1, base + (offset or 0)); return cursor - 1
    end
    function f:flush() return true end
    function f:close() closed = true; return true end
    function f:lines()
        return function() return self:read("*l") end
    end
    return f
end

local sandbox_io = { open = vfile }
sandbox_io.lines = function(pathname) local f, err = vfile(pathname, "r"); if not f then return nil, err end; return f:lines() end
local sandbox_os = {
    clock = os.clock, date = os.date, difftime = os.difftime, time = os.time,
    remove = function(p) virtual_files[tostring(p)] = nil; return true end,
    rename = function(a, b) if virtual_files[tostring(a)] == nil then return nil, "virtual file not found" end; virtual_files[tostring(b)] = virtual_files[tostring(a)]; virtual_files[tostring(a)] = nil; return true end,
}

local known_set = {}
for _, name in ipairs(known) do known_set[name] = true end
local capability_set = {}
for _, name in ipairs(capabilities) do capability_set[name] = true end

local function unavailable(name)
    report.failures[#report.failures + 1] = { phase = "sdk_mock", api = name, class = "mock_handler_missing" }
    error("STAGE3_MISSING_API_MOCK:" .. name, 0)
end
local function signature_error(name, argument_type)
    report.failures[#report.failures + 1] = { phase = "sdk_signature", api = name, class = "wrong_arguments", argument_type = argument_type }
    error("STAGE3_SDK_SIGNATURE:" .. name, 0)
end
local function copy_json(value, depth)
    if type(value) ~= "table" then return value end
    depth = depth or 0
    if depth >= 20 then return {} end
    local copy = {}
    for key, item in pairs(value) do copy[key] = copy_json(item, depth + 1) end
    return copy
end
local function json_escape(s)
    return '"' .. tostring(s):gsub('[%z\1-\31\\"]', function(c)
        local map = { ['\\'] = '\\\\', ['"'] = '\\"', ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t' }
        return map[c] or string.format('\\u%04x', string.byte(c))
    end) .. '"'
end
json_encode = function(value)
    local ty = type(value)
    if ty == "nil" then return "null" end
    if ty == "boolean" or ty == "number" then return tostring(value) end
    if ty == "string" then return json_escape(value) end
    if ty ~= "table" then return "null" end
    local count, max = 0, 0
    for key in pairs(value) do
        if type(key) == "number" and key >= 1 and key % 1 == 0 then count = count + 1; if key > max then max = key end
        else count = -1000000; break end
    end
    local out = {}
    if count >= 0 and count == max then
        for i = 1, max do out[#out + 1] = json_encode(value[i]) end
        return "[" .. table.concat(out, ",") .. "]"
    end
    for key, item in pairs(value) do out[#out + 1] = json_escape(key) .. ":" .. json_encode(item) end
    return "{" .. table.concat(out, ",") .. "}"
end

local function safe_error_detail(err)
    local message = type(err) == "string" and err or ""
    local file, line = message:match("([%w_%.%-]+%.lua):(%d+):")
    line = tonumber(line)
    if message:find("STAGE3_CALLBACK_BUDGET", 1, true) then return "callback_budget", nil, file, line end
    if message:find("STAGE3_MISSING_API_MOCK", 1, true) then return "missing_api_mock", nil, file, line end
    if message:find("STAGE3_SDK_SIGNATURE", 1, true) then return "sdk_signature_mismatch", nil, file, line end
    if message:find("attempt to call a nil value", 1, true) then
        return "nil_call", message:match("%(global '([%w_]+)'%)") or message:match("%(field '([%w_]+)'%)") or message:match("%(method '([%w_]+)'%)"), file, line
    end
    if message:find("attempt to index a nil value", 1, true) then
        return "nil_index", message:match("%(global '([%w_]+)'%)") or message:match("%(field '([%w_]+)'%)") or message:match("%(method '([%w_]+)'%)"), file, line
    end
    return "unclassified_lua_error", nil, file, line
end

local api_handlers = {}
api_handlers.api_version = function() return 17 end
api_handlers.define = function(meta)
    report.metadata = { id = scrub_label(meta.id), name = scrub_label(meta.name), version = scrub_label(meta.version), api_min = tonumber(meta.api_min) }
    if type(meta.id) ~= "string" or type(meta.name) ~= "string" or type(meta.version) ~= "string"
        or not report.metadata.api_min or report.metadata.api_min < 1 or report.metadata.api_min > 17 then
        report.failures[#report.failures + 1] = { phase = "api17_metadata", class = "invalid_plugin_definition" }
    end
end
api_handlers.has_capability = function(name)
    if type(name) ~= "string" then signature_error("has_capability") end
    local found = capability_set[name] == true
    if scenario == "api17_offline_no_track" and not found then unsupported_capability_names[name] = true end
    return found
end
api_handlers.sd_root = function() return "/virtual-sd" end
api_handlers.on = function(name, cb)
    if type(name) ~= "string" or type(cb) ~= "function" then signature_error("on") end
    local supported = { track_started=true, paused=true, resumed=true, stopped=true, screen_woke=true, queue_exhausted=true, volume_changed=true, battery_changed=true, suspending=true, system_resumed=true, screenshot_saved=true, screenshot_failed=true, output_changed=true, button_lock_changed=true, remote_stream_needed=true }
    if not supported[name] then signature_error("on.event") end
    event_callbacks[name] = event_callbacks[name] or {}; table.insert(event_callbacks[name], cb)
end
api_handlers.register_list_item = function(section, label, cb, opts)
    if type(section) ~= "string" or type(label) ~= "string" or type(cb) ~= "function" then signature_error("register_list_item") end
    report.registrations[#report.registrations + 1] = { kind = "list_item", section = scrub_label(section), label = scrub_label(label), has_callback = type(cb) == "function" }
    if type(cb) == "function" then entrypoint_callbacks[#entrypoint_callbacks + 1] = { kind = "list_item", callback = cb, args = {} } end
end
local function register_and_defer(kind, label, cb, args, details)
    local item = { kind = kind, label = scrub_label(label), has_callback = type(cb) == "function" }
    if details then for k, v in pairs(details) do item[k] = v end end
    report.registrations[#report.registrations + 1] = item
    if type(cb) == "function" then entrypoint_callbacks[#entrypoint_callbacks + 1] = { kind = kind, callback = cb, args = args or {} } end
end
-- Signatures mirror plugin_manager.c: register_home_tile(id,label,callback,icon),
-- register_quick_toggle(id,label,callback,options),
-- register_player_action(action,callback), and
-- register_stream_media_tile(label,callback[,icon]). All return zero Lua values.
api_handlers.register_home_tile = function(id, label, cb, icon)
    if type(id) ~= "string" or type(label) ~= "string" or type(cb) ~= "function" or type(icon) ~= "string" then signature_error("register_home_tile") end
    return register_and_defer("home_tile", label, cb, {}, { id = scrub_label(id), icon = scrub_label(icon) })
end
api_handlers.register_quick_toggle = function(id, label, cb, options)
    if type(id) ~= "string" or type(label) ~= "string" or type(cb) ~= "function" or type(options) ~= "table" or type(options.icon) ~= "string" then signature_error("register_quick_toggle") end
    return register_and_defer("quick_toggle", label, cb, { false }, { id = scrub_label(id) })
end
api_handlers.register_player_action = function(action, cb)
    if type(action) ~= "string" or type(cb) ~= "function" then signature_error("register_player_action") end
    return register_and_defer("player_action", action, cb, { action }, { action = scrub_label(action) })
end
api_handlers.register_stream_media_tile = function(label, cb, icon)
    if type(label) ~= "string" or type(cb) ~= "function" or (icon ~= nil and type(icon) ~= "string") then signature_error("register_stream_media_tile") end
    return register_and_defer("stream_media_tile", label, cb, {}, { icon = scrub_label(icon) })
end
api_handlers.show_list = function(title, rows, callback, options)
    if type(title) ~= "string" or type(rows) ~= "table" or type(callback) ~= "function" or (options ~= nil and type(options) ~= "table") then signature_error("show_list") end
    record_ui("list", title, rows, callback); next_handle = next_handle + 1; return next_handle
end
api_handlers.show_settings_list = function(title, rows, options)
    if type(title) ~= "string" or type(rows) ~= "table" or (options ~= nil and type(options) ~= "table") then signature_error("show_settings_list") end
    for i = 1, math.min(#rows, 100) do
        local row = rows[i]
        if type(row) ~= "table" then signature_error("show_settings_list.row") end
        if row.type == "row" then
            if type(row.on_select) ~= "function" then signature_error("show_settings_list.row.on_select") end
        elseif row.type == "toggle" then
            if type(row.value) ~= "boolean" or type(row.on_change) ~= "function" then signature_error("show_settings_list.toggle") end
        elseif row.type == "slider" then
            local function integer(value) return type(value) == "number" and value == math.floor(value) end
            if not integer(row.min) or not integer(row.max) or not integer(row.value) or type(row.on_change) ~= "function" then signature_error("show_settings_list.slider") end
        else
            signature_error("show_settings_list.row.type")
        end
    end
    record_ui("settings", title, rows); next_handle = next_handle + 1; return next_handle
end
api_handlers.show_text_input = function(title, initial_text, is_secret, callback)
    if type(title) ~= "string" or (initial_text ~= nil and type(initial_text) ~= "string") or type(is_secret) ~= "boolean" or type(callback) ~= "function" then signature_error("show_text_input") end
    record_ui("text_input", title); return true
end
api_handlers.show_confirmation = function(title, confirm_label, callback)
    if type(title) ~= "string" or type(confirm_label) ~= "string" or type(callback) ~= "function" then signature_error("show_confirmation") end
    record_ui("confirmation", title, { confirm_label }); return true
end
api_handlers.show_progress = function(title, body) record_ui("progress", title, { body }); next_handle = next_handle + 1; return next_handle end
api_handlers.show_toast = function(message) record_ui("toast", message); return true end
api_handlers.show_text_view = function(title) record_ui("text_view", title); return true end
api_handlers.set_interval = function() next_handle = next_handle + 1; return next_handle end
api_handlers.clear_interval = function() return true end
-- These signatures and return shapes mirror plugin_manager.c and
-- plugin_http_bindings.c. No request options/URLs/headers are logged or sent.
api_handlers.http_request = function(options, callback)
    if type(options) ~= "table" or type(callback) ~= "function" or type(options.url) ~= "string" then signature_error("http_request") end
    return nil, "mock-offline"
end
api_handlers.http_get = function(url, verify_tls)
    if type(url) ~= "string" or (verify_tls ~= nil and type(verify_tls) ~= "boolean") then signature_error("http_get") end
    return nil, "mock-offline"
end
api_handlers.http_post = function(url, body, content_type, verify_tls)
    if type(url) ~= "string" or type(body) ~= "string" or (content_type ~= nil and type(content_type) ~= "string") or (verify_tls ~= nil and type(verify_tls) ~= "boolean") then signature_error("http_post") end
    return nil, "mock-offline"
end
api_handlers.get_current_track_path = function() return nil end
api_handlers.get_now_playing = function() return nil, nil, nil, 0 end
api_handlers.is_playing = function() return false end
api_handlers.is_paused = function() return false end
api_handlers.get_position = function() return 0 end
api_handlers.get_duration = function() return 0 end
api_handlers.get_volume = function() return 0 end
api_handlers.get_playback_format = function() return nil end
api_handlers.get_eq_state = function()
    local bands = {}
    for i = 1, 10 do bands[i] = { index = i, freq_hz = 0, gain_db = 0, q = 1, type = "peaking", enabled = false } end
    return { enabled = false, bypass = false, preamp_db = 0, stereo_width = 0, crossfeed = 0, crossfeed_angle = 0, bands = bands }
end
api_handlers.get_output_info = function()
    return { route = "none", active = false, dop = false, native_dsd = false, resampling = false, resampling_known = false, sample_rate = 0, bit_depth = 0, hardware_sample_rate = 0, hardware_bit_depth = 0, bluetooth_codec = nil }
end
api_handlers.get_mseb_state = function()
    return { enabled = false, width = 0, temperature = 0, bass_ext = 0, bass_texture = 0, thickness = 0, vocal_pos = 0, female_vocal = 0, sibilance_lf = 0, sibilance_hf = 0, impulse_tone = 0, air = 0 }
end
api_handlers.audio_loop_active = function() return false end
api_handlers.audio_loop_start = function(path) if type(path) ~= "string" then signature_error("audio_loop_start") end; return false end
api_handlers.eq_load_profile = function(path) if type(path) ~= "string" then signature_error("eq_load_profile") end; return false end
api_handlers.eq_save_profile = function(path) if type(path) ~= "string" then signature_error("eq_save_profile") end; return false end
api_handlers.eq_reset = function() end
api_handlers.eq_apply_state = function(state) if type(state) ~= "table" then signature_error("eq_apply_state") end; return false end
api_handlers.mseb_apply_state = function(state) if type(state) ~= "table" then signature_error("mseb_apply_state") end; return false end
api_handlers.get_ab_loop = function() return nil end
api_handlers.clear_ab_loop = function() end
api_handlers.get_ab_switch = function() return { preparing = false, ready = false, source = "none" } end
api_handlers.json_encode = function(value)
    local encoded = json_encode(value)
    if type(encoded) == "string" then json_roundtrips[encoded] = copy_json(value) end
    return encoded
end
api_handlers.json_decode = function(value)
    if type(value) ~= "string" then signature_error("json_decode", type(value)) end
    if json_roundtrips[value] ~= nil then return copy_json(json_roundtrips[value]) end
    if value:match("^%s*{}%s*$") then return {} end
    mock_limitations.json_decode_external_fixture = true
    return nil, "mock empty or unsupported JSON fixture"
end
api_handlers.set_icon = function(relative_path, source_path)
    if type(relative_path) ~= "string" or type(source_path) ~= "string" then signature_error("set_icon") end
    sdk_effect_counts.set_icon = (sdk_effect_counts.set_icon or 0) + 1
end
api_handlers.set_background_color = function(slot, rgb) if type(slot) ~= "string" or type(rgb) ~= "number" then signature_error("set_background_color") end; sdk_effect_counts.set_background_color = (sdk_effect_counts.set_background_color or 0) + 1 end
api_handlers.set_text_color = function(slot, rgb) if type(slot) ~= "string" or type(rgb) ~= "number" then signature_error("set_text_color") end; sdk_effect_counts.set_text_color = (sdk_effect_counts.set_text_color or 0) + 1 end
api_handlers.set_home_layout = function(layout, options) if type(layout) ~= "table" then signature_error("set_home_layout") end; sdk_effect_counts.set_home_layout = (sdk_effect_counts.set_home_layout or 0) + 1 end
api_handlers.set_launcher_layout = function(layout) if type(layout) ~= "table" then signature_error("set_launcher_layout") end; sdk_effect_counts.set_launcher_layout = (sdk_effect_counts.set_launcher_layout or 0) + 1 end
api_handlers.set_player_layout = function(layout) if type(layout) ~= "table" then signature_error("set_player_layout") end; sdk_effect_counts.set_player_layout = (sdk_effect_counts.set_player_layout or 0) + 1 end
api_handlers.set_hw_volume_curve = function(curve) if type(curve) ~= "table" then signature_error("set_hw_volume_curve") end; sdk_effect_counts.set_hw_volume_curve = (sdk_effect_counts.set_hw_volume_curve or 0) + 1 end
api_handlers.set_transport_skip = function(root, seconds) if type(root) ~= "string" or type(seconds) ~= "number" then signature_error("set_transport_skip") end; sdk_effect_counts.set_transport_skip = (sdk_effect_counts.set_transport_skip or 0) + 1 end
api_handlers.set_quick_toggle = function(id, value) if type(id) ~= "string" then signature_error("set_quick_toggle") end; sdk_effect_counts.set_quick_toggle = (sdk_effect_counts.set_quick_toggle or 0) + 1 end
api_handlers.reload_ui = function() sdk_effect_counts.reload_ui = (sdk_effect_counts.reload_ui or 0) + 1 end
api_handlers.has_startup_image = function() return false end
api_handlers.close_progress = function(handle) if type(handle) ~= "number" then signature_error("close_progress") end; return false end
api_handlers.is_list_showing = function(handle) if type(handle) ~= "number" then signature_error("is_list_showing") end; return false end
api_handlers.led_release = function() end
api_handlers.configure_button_lock = function(enabled) if type(enabled) ~= "boolean" then signature_error("configure_button_lock") end; return "Power + Volume Up" end
api_handlers.library_song_count = function() return 0 end
api_handlers.library_get_songs = function() return {}, 0 end
api_handlers.library_get_artists = function() return {} end
api_handlers.library_get_albums = function() return {} end
api_handlers.library_search = function() return {} end
api_handlers.library_get_song = function() return nil end
api_handlers.get_artist_albums = function() return nil end
api_handlers.get_album_tracks = function() return nil end
api_handlers.get_next_album_tracks = function() return nil end
api_handlers.refresh_theme = function() end
api_handlers.open_file_manager = function(folder)
    if folder ~= nil and type(folder) ~= "string" then signature_error("open_file_manager") end
    return nil, "mock file manager unavailable"
end
api_handlers.pick_file = function(folder, callback)
    if folder ~= nil and type(folder) ~= "string" or type(callback) ~= "function" then signature_error("pick_file") end
    return nil, "mock file picker unavailable"
end
api_handlers.set_startup_image_async = function(path, callback)
    if path ~= nil and type(path) ~= "string" or type(callback) ~= "function" then signature_error("set_startup_image_async") end
    return nil, "mock startup image operation unavailable"
end
api_handlers.show_lock_screen = function() return false, "mock lock screen unavailable" end
api_handlers.show_order_editor = function(title, items, callback)
    if type(title) ~= "string" or type(items) ~= "table" or type(callback) ~= "function" then signature_error("show_order_editor") end
    record_ui("order_editor", title, items)
end
api_handlers.exists = function() return false end
api_handlers.mkdir = function() return true end
api_handlers.list_dir = function() return {} end
api_handlers.list = function() return {} end
api_handlers.get = function() return nil end
api_handlers.set = function() return true end
api_handlers.delete = function() return true end
api_handlers.file_copy = function() return false, "mock virtual filesystem" end
api_handlers.file_delete = function() return false, "mock virtual filesystem" end
api_handlers.file_move = function() return false, "mock virtual filesystem" end
api_handlers.cancel_file_operation = function() return true end

local storage = {
    get = function(key, default)
        if type(key) ~= "string" then signature_error("storage.get") end
        report.storage_ops = report.storage_ops or {}; report.storage_ops.get = (report.storage_ops.get or 0) + 1
        local value = storage_values[key]
        if value ~= nil then return value end
        return default
    end,
    set = function(key, value)
        if type(key) ~= "string" or type(value) ~= "string" then signature_error("storage.set") end
        report.storage_ops = report.storage_ops or {}; report.storage_ops.set = (report.storage_ops.set or 0) + 1
        storage_values[key] = value; return true
    end,
    delete = function(key)
        if type(key) ~= "string" then signature_error("storage.delete") end
        report.storage_ops = report.storage_ops or {}; report.storage_ops.delete = (report.storage_ops.delete or 0) + 1
        local existed = storage_values[key] ~= nil; storage_values[key] = nil; return existed
    end,
    list = function(prefix)
        if prefix ~= nil and type(prefix) ~= "string" then signature_error("storage.list") end
        report.storage_ops = report.storage_ops or {}; report.storage_ops.list = (report.storage_ops.list or 0) + 1
        local result = {}; prefix = prefix or ""
        for key in pairs(storage_values) do if key:sub(1, #prefix) == prefix then result[#result + 1] = key end end
        table.sort(result); return result
    end,
}
local secrets = {
    get = function() return nil end, set = function() return true end,
    exists = function(key) if type(key) ~= "string" then signature_error("secrets.exists") end; return false end,
    delete = function() return false end,
}
local plugin = { storage = storage, secrets = secrets }
setmetatable(plugin, { __index = function(_, name)
    if not known_set[name] then
        missing_api_names[name] = true
        return nil
    end
    return function(...)
        report.api_calls[name] = (report.api_calls[name] or 0) + 1
        local handler = api_handlers[name]
        if not handler then unavailable(name) end
        return handler(...)
    end
end })

local env = {
    assert = assert, error = error, ipairs = ipairs, pairs = pairs, next = next,
    pcall = pcall, xpcall = xpcall, select = select, tonumber = tonumber,
    tostring = tostring, type = type, unpack = table.unpack or unpack, rawequal = rawequal,
    rawget = rawget, rawset = rawset, setmetatable = setmetatable, getmetatable = getmetatable,
    math = math, string = string, table = table, coroutine = coroutine, utf8 = utf8,
    io = sandbox_io, os = sandbox_os, plugin = plugin,
    print = function() end,
}
env._G = env

local f, load_err
if _VERSION == "Lua 5.1" then
    f, load_err = loadfile(path)
    if f and setfenv then setfenv(f, env) end
else
    f, load_err = loadfile(path, "t", env)
end
if not f then report.syntax_status = "failed"; report.failures[#report.failures + 1] = { phase = "syntax", class = "load_error" }
else
    report.syntax_status = "passed"
    local ok, err = pcall(f)
    if not ok then
        local detail, symbol, file, line = safe_error_detail(err)
        report.failures[#report.failures + 1] = { phase = "load", class = "plugin_load_error", detail = detail, symbol = symbol, source_file = file, source_line = line }
    end
end

-- The real loader finishes evaluating the complete chunk before any user can
-- select a registered item. Invoke callbacks only after successful load, one
-- at a time, with an isolated pcall and a no-track/default-toggle context.
local load_succeeded = #report.failures == 0
local unpack_args = table.unpack or unpack
local function bounded_call(callback, args)
    local remaining = 500000
    if debug and debug.sethook then
        debug.sethook(function()
            remaining = remaining - 10000
            if remaining <= 0 then error("STAGE3_CALLBACK_BUDGET", 0) end
        end, "", 10000)
    end
    local ok, err = xpcall(function() callback(unpack_args(args)) end, function(err) return debug.traceback(tostring(err), 2) end)
    if debug and debug.sethook then debug.sethook() end
    return ok, err
end
local function copy_values(source)
    local copy = {}; for key, value in pairs(source) do copy[key] = value end; return copy
end
local function restore_values(target, snapshot)
    for key in pairs(target) do target[key] = nil end
    for key, value in pairs(snapshot) do target[key] = value end
end
local function run_ui_actions()
    local cursor, steps = 1, 0
    while cursor <= #ui_actions and steps < max_ui_actions do
        local action = ui_actions[cursor]; cursor = cursor + 1; steps = steps + 1
        local files_before, storage_before = copy_values(virtual_files), copy_values(storage_values)
        local ok, err = bounded_call(action.callback, action.args)
        restore_values(virtual_files, files_before)
        restore_values(storage_values, storage_before)
        local event = { event = "ui:" .. action.kind, label = action.label, result = ok and "passed_mock" or "callback_error", value_type = type(action.value) }
        if type(action.value) == "boolean" or type(action.value) == "number" then event.value = action.value end
        report.events[#report.events + 1] = event
        if not ok then
            local detail, symbol, file, line = safe_error_detail(err)
            local frames = {}; local trace = tostring(err); for frame_file, frame_line in trace:gmatch("([%w_%.%-]+%.lua):(%d+)") do frames[#frames + 1] = { file = frame_file, line = tonumber(frame_line) }; if #frames >= 6 then break end end; for frame_line in trace:gmatch("%]:(%d+):") do frames[#frames + 1] = { file = "sandbox_driver", line = tonumber(frame_line) }; if #frames >= 6 then break end end
            report.failures[#report.failures + 1] = { phase = "ui_callback", class = "callback_error", detail = detail, symbol = symbol, source_file = file, source_line = line, source_frames = frames, kind = action.kind, label = action.label }
        end
    end
    if cursor <= #ui_actions then report.ui_traversal_capped = true end
    report.ui_traversal_steps = (report.ui_traversal_steps or 0) + steps
    ui_actions = {}
    ui_action_count = 0
end
if load_succeeded then
    for _, entry in ipairs(entrypoint_callbacks) do
        local files_before, storage_before = copy_values(virtual_files), copy_values(storage_values)
        local ok, err = bounded_call(entry.callback, entry.args)
        report.events[#report.events + 1] = { event = "entrypoint:" .. entry.kind, result = ok and "passed_mock" or "callback_error" }
        if not ok then local detail, symbol, file, line = safe_error_detail(err); report.failures[#report.failures + 1] = { phase = "entrypoint", class = "callback_error", detail = detail, symbol = symbol, source_file = file, source_line = line, kind = entry.kind } end
        run_ui_actions()
        restore_values(virtual_files, files_before)
        restore_values(storage_values, storage_before)
    end
    -- Safe no-current-track lifecycle smoke: callbacks receive no track data.
    for _, event in ipairs({ "stopped", "paused", "screen_woke", "system_resumed" }) do
        for _, cb in ipairs(event_callbacks[event] or {}) do
            local files_before, storage_before = copy_values(virtual_files), copy_values(storage_values)
            local ok, err = bounded_call(cb, {})
            report.events[#report.events + 1] = { event = event, result = ok and "passed_mock" or "callback_error" }
            if not ok then local detail, symbol, file, line = safe_error_detail(err); report.failures[#report.failures + 1] = { phase = "event_callback", class = "callback_error", detail = detail, symbol = symbol, source_file = file, source_line = line, event = event } end
            run_ui_actions()
            restore_values(virtual_files, files_before)
            restore_values(storage_values, storage_before)
        end
    end
end
report.missing_api_names = {}
for name in pairs(missing_api_names) do report.missing_api_names[#report.missing_api_names + 1] = name end
table.sort(report.missing_api_names)
report.unsupported_capability_names = {}
for name in pairs(unsupported_capability_names) do report.unsupported_capability_names[#report.unsupported_capability_names + 1] = name end
table.sort(report.unsupported_capability_names)
report.sdk_side_effects = sdk_effect_counts
report.mock_limitations = {}
for name in pairs(mock_limitations) do report.mock_limitations[#report.mock_limitations + 1] = name end
table.sort(report.mock_limitations)

print("STAGE3_RESULT:" .. json_encode(report))

'''


def exported_api_names() -> set[str]:
    names: set[str] = set()
    for source in (HOST / "src/plugins").rglob("*.c"):
        text = source.read_text(encoding="utf-8", errors="replace")
        names.update(re.findall(r'\{\s*"([A-Za-z_][A-Za-z_0-9]*)"\s*,\s*(?:l_plugin|plugin_)', text))
    return names


_CAPABILITY_TABLE = re.compile(
    r"(?:static\s+)?const\s+char\s*\*\s*(?:const\s*)?plugin_capabilities\s*\[\s*\]\s*=\s*\{(.*?)\};",
    re.S,
)


def _discover_capability_table(source_root: Path = HOST) -> tuple[Path, str]:
    """Return the sole named table's source path and its exact initializer body."""
    plugins_dir = source_root / "src/plugins"
    if not plugins_dir.is_dir():
        raise RuntimeError(f"Plugin API source directory not found: {plugins_dir}")
    matches = []
    for source in sorted(plugins_dir.rglob("*.c")):
        text = source.read_text(encoding="utf-8", errors="replace")
        matches.extend((source, match.group(1)) for match in _CAPABILITY_TABLE.finditer(text))
    if not matches:
        raise RuntimeError(f"Could not find named plugin_capabilities table under {plugins_dir}")
    if len(matches) != 1:
        locations = ", ".join(str(path.relative_to(source_root)) for path, _ in matches)
        raise RuntimeError(f"Expected one named plugin_capabilities table under {plugins_dir}; found {len(matches)} at: {locations}")
    return matches[0]


def _validated_capability_names(body: str, source: Path) -> list[str]:
    values = re.findall(r'"([a-z][a-z0-9_.]+)"', body)
    if not values:
        raise RuntimeError(f"Named plugin_capabilities table is empty in {source}")
    if len(values) != len(set(values)):
        raise RuntimeError(f"Named plugin_capabilities table has duplicate entries in {source}")
    return sorted(values)


def capability_names(source_root: Path = HOST) -> list[str]:
    """Read the single named capability table wherever it lives in this tree."""
    source, body = _discover_capability_table(source_root)
    return _validated_capability_names(body, source)


def plugin_records() -> list[dict]:
    records = []
    for lua in sorted((ROOT / "plugins").glob("*/*.lua")):
        text = lua.read_text(encoding="utf-8", errors="replace")
        define = re.search(r"plugin\.define\s*\(\s*\{(.*?)\}\s*\)", text, re.S)
        if not define:
            records.append({"path": str(lua.relative_to(ROOT)), "metadata_error": "plugin.define not found"})
            continue
        header = define.group(1)
        def field(name):
            match = re.search(r"\b" + name + r"\s*=\s*(['\"])(.*?)\1", header, re.S)
            return match.group(2) if match else None
        api_min = re.search(r"\bapi_min\s*=\s*(\d+)", header)
        calls = sorted(set(re.findall(r"\bplugin\.([A-Za-z_][A-Za-z_0-9]*)", text)))
        caps = sorted(set(re.findall(r"has_capability\s*\(\s*['\"]([^'\"]+)", text)))
        records.append({"path": str(lua.relative_to(ROOT)), "id": field("id"), "name": field("name"), "version": field("version"), "api_min": int(api_min.group(1)) if api_min else None, "api_symbols": calls, "capabilities": caps})
    return records


def lua_quote(value: str) -> str:
    """Quote a string as a Lua literal; JSON's unicode escapes are not Lua."""
    out = ['"']
    encoded = value.encode("utf-8")
    for i, byte in enumerate(encoded):
        if byte == 0x22:
            out.append('\\"')
        elif byte == 0x5C:
            out.append('\\\\')
        elif byte == 0x0A:
            out.append('\\n')
        elif byte == 0x0D:
            out.append('\\r')
        elif byte == 0x09:
            out.append('\\t')
        elif 0x20 <= byte <= 0x7E:
            out.append(chr(byte))
        else:
            out.append(f"\\{byte:03d}")
            if i + 1 < len(encoded) and 0x30 <= encoded[i + 1] <= 0x39:
                out.append('".."')
    out.append('"')
    return "".join(out)


def lua_array(values: list[str]) -> str:
    return "{" + ",".join(lua_quote(value) for value in values) + "}"


def lua_driver(api_names: list[str], capabilities: list[str], plugin_path: Path, plugin_name: str, scenario: str) -> str:
    return ("local API_NAMES=" + lua_array(api_names) + "\n" +
            "local CAPABILITIES=" + lua_array(capabilities) + "\n" +
            "local PLUGIN_PATH=" + lua_quote(str(plugin_path)) + "\n" +
            "local PLUGIN_NAME=" + lua_quote(plugin_name) + "\n" +
            "local SCENARIO=" + lua_quote(scenario) + "\n" + LUA_DRIVER)


def run(args) -> int:
    exports = exported_api_names()
    caps = capability_names()
    records = plugin_records()
    syntax_results = []
    if args.run:
        interpreter = shutil.which(args.lua)
        if not interpreter:
            raise RuntimeError(f"Lua interpreter not found: {args.lua}")
        for rec in records:
            if rec.get("metadata_error"):
                syntax_results.append({"plugin": rec["path"], "result": "metadata_error"})
                continue
            path = ROOT / rec["path"]
            scenarios = [("api17_offline_no_track", caps), ("capabilities_unavailable", [])]
            for scenario, scenario_caps in scenarios:
                try:
                    proc = subprocess.run([interpreter, "-e", lua_driver(sorted(exports), scenario_caps, path, rec["name"] or rec["path"], scenario)], capture_output=True, text=True, timeout=args.timeout)
                except subprocess.TimeoutExpired:
                    syntax_results.append({"plugin": rec["name"], "scenario": scenario, "classification": "harness_timeout", "failures": [{"phase": "runner", "class": "timeout"}]})
                    continue
                except OSError:
                    syntax_results.append({"plugin": rec["name"], "scenario": scenario, "classification": "harness_failure", "failures": [{"phase": "runner", "class": "process_launch_error"}]})
                    continue
                # Lua driver errors can contain input-derived text; retain only structured stdout and return code.
                if proc.returncode == 0 and proc.stdout.strip():
                    try:
                        result_line = next(line for line in proc.stdout.splitlines() if line.startswith("STAGE3_RESULT:"))
                        result = json.loads(result_line.split(":", 1)[1])
                    except json.JSONDecodeError:
                        result = {"plugin": rec["name"], "scenario": scenario, "failures": [{"phase": "runner", "class": "invalid_result"}]}
                    except StopIteration:
                        result = {"plugin": rec["name"], "scenario": scenario, "failures": [{"phase": "runner", "class": "missing_result"}]}
                else:
                    result = {"plugin": rec["name"], "scenario": scenario, "failures": [{"phase": "runner", "class": "lua_process_error"}]}
                failures = result.get("failures", [])
                # Track Inspector probes this legacy name optionally, then reads
                # crossfeed_angle from get_eq_state(). Keep the absent probe
                # visible without counting its successfully handled fallback as
                # an unresolved SDK/mock gap.
                if result.get("plugin") == "Track Inspector" and "eq_get_crossfeed_angle" in result.get("missing_api_names", []):
                    labels = [row.get("label", "") for screen in result.get("ui", []) for row in screen.get("rows", []) if isinstance(row, dict)]
                    if any(label.startswith("Crossfeed delay:") for label in labels):
                        result["optional_api_absences"] = ["eq_get_crossfeed_angle; get_eq_state fallback rendered"]
                        result["missing_api_names"].remove("eq_get_crossfeed_angle")
                mock_gap = any(f.get("phase") == "sdk_mock" for f in failures)
                unknown_refs = bool(result.get("missing_api_names") or result.get("unsupported_capability_names") or result.get("mock_limitations"))
                process_error = any(f.get("phase") == "runner" for f in failures)
                if process_error:
                    result["classification"] = "harness_failure"
                elif mock_gap or unknown_refs:
                    result["classification"] = "incomplete_mock_or_api_gap"
                elif failures:
                    result["classification"] = "plugin_behavior_failure"
                else:
                    result["classification"] = "passed_mock"
                syntax_results.append(result)
    else:
        syntax_results = [{"plugin": rec.get("name", rec["path"]), "result": "not_run"} for rec in records]

    report = {
        "stage": "stage3_plugin_api17_sandbox",
        "execution": "ran" if args.run else "not_run_go_gate",
        "plugin_count": len(records),
        "exported_api_name_count": len(exports),
        "capability_name_count": len(caps),
        "plugins": records,
        "results": syntax_results,
        "provider_validation": "none; all HTTP is mocked offline before network access, so provider compatibility is unverified",
        "sandbox": "Lua io/os and plugin storage are virtualized; no network, owner credential, real provider, or device storage is used",
    }
    for rec in records:
        if rec.get("metadata_error"):
            continue
        rec["api17_compatibility"] = {
            "api_min_supported": rec["api_min"] is not None and 1 <= rec["api_min"] <= 17,
            "missing_capabilities": sorted(set(rec["capabilities"]) - set(caps)),
            "lexical_api_refs_not_in_host_exports": sorted(set(rec["api_symbols"]) - exports - {"storage", "secrets"}),
            "note": "Lexical reference sets can include comments/strings; runtime proxy checks actual property access. Missing names are findings for review, not silently ignored.",
        }
    if args.write_plan or args.run:
        OUTPUT.parent.mkdir(parents=True, exist_ok=True)
        OUTPUT.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        print(f"Wrote {OUTPUT}")
    print(f"Prepared {len(records)} plugin records; execution={'ran' if args.run else 'not run'}.")
    if args.run:
        classes = [result.get("classification") for result in syntax_results]
        if not syntax_results or any(c == "harness_failure" for c in classes):
            return 3
        if any(c == "plugin_behavior_failure" for c in classes):
            return 1
        if any(c == "incomplete_mock_or_api_gap" for c in classes):
            return 2
        if not all(c == "passed_mock" for c in classes):
            return 3
    return 0


def self_test() -> int:
    """Exercise the driver with a self-contained fixture, never a real plugin."""
    interpreter = shutil.which("lua")
    if not interpreter:
        raise RuntimeError("Lua interpreter not found for harness self-test")
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    current_table_path, current_table_body = _discover_capability_table(HOST)
    current_capabilities = _validated_capability_names(current_table_body, current_table_path)
    table_declaration = "static const char * const plugin_capabilities[] = {\n" + current_table_body + "\n};\n"
    with tempfile.TemporaryDirectory(prefix="stage3-capability-fixture-", dir=OUTPUT.parent) as temp_root:
        temp_root = Path(temp_root)
        layouts = (
            ("old-module", Path("src/plugins/plugin_manager.c")),
            ("extracted-module", Path("src/plugins/bindings/plugin_info_bindings.c")),
        )
        for fixture_name, relative_source in layouts:
            fixture_root = temp_root / fixture_name
            fixture_source = fixture_root / relative_source
            fixture_source.parent.mkdir(parents=True, exist_ok=True)
            fixture_source.write_text(table_declaration, encoding="utf-8")
            if capability_names(fixture_root) != current_capabilities:
                raise RuntimeError(f"Capability discovery changed at fixture layout {relative_source}")

        absent_root = temp_root / "absent"
        (absent_root / "src/plugins").mkdir(parents=True)
        try:
            capability_names(absent_root)
        except RuntimeError as exc:
            if "Could not find named plugin_capabilities table" not in str(exc):
                raise
        else:
            raise RuntimeError("Capability discovery self-test accepted a missing table")

        ambiguous_root = temp_root / "ambiguous"
        ambiguous_a = ambiguous_root / "src/plugins/a.c"
        ambiguous_b = ambiguous_root / "src/plugins/b.c"
        ambiguous_a.parent.mkdir(parents=True)
        ambiguous_a.write_text(table_declaration, encoding="utf-8")
        ambiguous_b.write_text(table_declaration, encoding="utf-8")
        try:
            capability_names(ambiguous_root)
        except RuntimeError as exc:
            if "Expected one named plugin_capabilities table" not in str(exc):
                raise
        else:
            raise RuntimeError("Capability discovery self-test accepted ambiguous tables")
    fixture = OUTPUT.parent / "stage3-plugin-harness-selftest.lua"
    fixture.write_text(
        "plugin.define({id='test.stage3.fixture', name='Stage3 fixture', version='1.0', api_min=17})\n"
        "assert(plugin.storage.get('missing') == nil)\n"
        "assert(plugin.storage.get('missing', 'fallback') == 'fallback')\n"
        "assert(plugin.storage.get('missing', false) == false)\n"
        "assert(plugin.storage.get('missing', '') == '')\n"
        "assert(plugin.storage.set('present', 'stored'))\n"
        "assert(plugin.storage.get('present', 'fallback') == 'stored')\n"
        "local ready = false\n"
        "plugin.register_list_item('music_library', 'Fixture entry', function()\n"
        "  assert(ready, 'entrypoint ran before module load completed')\n"
        "  local encoded = plugin.json_encode({Live=true})\n"
        "  assert(type(encoded) == 'string')\n"
        "  assert(plugin.storage.set('json', encoded))\n"
        "  assert(plugin.json_decode(plugin.storage.get('json')).Live == true)\n"
        "  plugin.show_settings_list('Fixture settings', {{type='toggle', label='Fixture toggle', value=false, on_change=function() end}})\n"
        "end)\n"
        "plugin.on('stopped', function() end)\n"
        "ready = true\n",
        encoding="utf-8",
    )
    try:
        proc = subprocess.run(
            [interpreter, "-e", lua_driver(sorted(exported_api_names()), capability_names(), fixture, "Stage3 fixture", "self_test")],
            capture_output=True, text=True, timeout=10,
        )
        if proc.returncode != 0:
            print("Sandbox harness self-test failed: Lua process error.")
            return 1
        line = next((line for line in proc.stdout.splitlines() if line.startswith("STAGE3_RESULT:")), None)
        if line is None:
            print("Sandbox harness self-test failed: no structured result.")
            return 1
        result = json.loads(line.split(":", 1)[1])
        assert result["metadata"]["id"] == "test.stage3.fixture"
        assert result["registrations"][0]["label"] == "Fixture entry"
        assert result["ui"][0]["label"] == "Fixture settings"
        assert result["ui"][0]["rows"][0]["label"] == "Fixture toggle"
        assert any(event["event"] == "entrypoint:list_item" for event in result["events"])
        assert not result["failures"]
        print("Sandbox harness self-test passed using only a self-contained Lua fixture.")
        return 0
    except (AssertionError, json.JSONDecodeError, StopIteration):
        print("Sandbox harness self-test failed: structured result mismatch.")
        return 1
    finally:
        fixture.unlink(missing_ok=True)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run", action="store_true", help="Run the sandbox load/UI smoke. Requires owner GO PLUGINS first.")
    parser.add_argument("--write-plan", action="store_true", help="Write a static API17 inventory without executing plugins.")
    parser.add_argument("--self-test", action="store_true", help="Run a self-contained harness fixture only; never loads plugins.")
    parser.add_argument("--lua", default="lua", help="Lua interpreter executable matching the player build runtime")
    parser.add_argument("--timeout", type=int, default=20)
    args = parser.parse_args()
    if args.self_test:
        return self_test()
    if args.run and os.environ.get("GO_PLUGINS") != "1":
        parser.error("functional execution is gated; set GO_PLUGINS=1 only after root authorization")
    if not args.run and not args.write_plan:
        print("Stage 3 plugin harness is prepared. No plugins were loaded; use --write-plan for static output.")
        return 0
    return run(args)


if __name__ == "__main__":
    raise SystemExit(main())
