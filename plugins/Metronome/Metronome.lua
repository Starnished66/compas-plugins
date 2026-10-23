plugin.define({
    id = "example.metronome",
    name = "Metronome",
    version = "1.4.1",
    api_min = 17,
})

-- Metronome with sample-accurate timing and no native code.
--
-- Plugin timers fire at most once a second, so clicks cannot be timed from
-- Lua. Instead the plugin renders a few bars of clicks into a 16-bit stereo
-- PCM WAV file with every click at its exact sample offset, plays it with
-- plugin.play_file() and loops it with the native A-B loop
-- (plugin.set_ab_loop), which wraps inside the audio thread without
-- reopening the output.
--
-- Timing: a pulse is one counted beat and lasts 60 / bpm seconds. A click at
-- pulse k, subdivision position s/d, is placed at frame
--     round((k * d + s) * rate * 60 / (d * bpm))
-- computed in integers (round half up), so no error accumulates. The loop is
-- an integer number of bars (at least MIN_LOOP_SEC seconds) and its length is
-- round(bars * pulses * rate * 60 / bpm) frames. The file carries a short
-- silent tail past the loop end, because the player rejects a loop end at or
-- beyond the file length, and it converts seconds to frames by truncation, so
-- the end is requested half a frame late: (loop_frames + 0.5) / rate.
--
-- Players with the "audio.loop" capability repeat the bar with
-- plugin.audio_loop_start() instead: the bar is exactly one loop long, it
-- never becomes the current track, and music is only paused, so the queue and
-- Now Playing are untouched. Older players fall back to playing the file as a
-- track: the previous track and position can be resumed on stop, but not the
-- previous queue.

local MIN_LOOP_SEC = 3
local TAIL_DIV = 4              -- silent tail after the loop: rate / TAIL_DIV frames
local LONG_LOOP_SEC = 10        -- longer loops are rendered at LOW_RATE to keep the file small
local HIGH_RATE, LOW_RATE = 44100, 22050
local BPM_MIN, BPM_MAX = 20, 300
local ARM_GIVE_UP_TICKS = 10
local REARM_GIVE_UP_TICKS = 5
local TAP_GAP = 2.0
local TAP_KEEP = 5
local DEBOUNCE = 1.5

local SOUNDS = {
    accent = { freq = 2000, ms = 30, key = "lvl_accent" },
    beat   = { freq = 1250, ms = 25, key = "lvl_beat" },
    sub    = { freq = 800,  ms = 15, key = "lvl_sub" },
}

-- d is the number of equal slots per beat, pos the slots that sound.
local SUBS = {
    { id = "none",        name = "Single notes (no subdivision)", d = 1, pos = { 0 } },
    { id = "eighths",     name = "Eighth notes (2)",              d = 2, pos = { 0, 1 } },
    { id = "triplets",    name = "Eighth-note triplets (3)",      d = 3, pos = { 0, 1, 2 } },
    { id = "sixteenths",  name = "Sixteenth notes (4)",           d = 4, pos = { 0, 1, 2, 3 } },
    { id = "quintuplets", name = "Quintuplets (5)",               d = 5, pos = { 0, 1, 2, 3, 4 } },
    { id = "sextuplets",  name = "Sixteenth sextuplets (6)",      d = 6, pos = { 0, 1, 2, 3, 4, 5 } },
    { id = "swing",       name = "Swing eighths (long-short 2:1)", d = 3, pos = { 0, 2 } },
}

local DEFAULTS = {
    bpm = 120, num = 4, den = 4, count = "eighth", sub = "none",
    accent_on = 1, lvl_accent = 10, lvl_beat = 8, lvl_sub = 6, restore = 1,
}

local sd_root = plugin.sd_root and plugin.sd_root() or "."
local DIR = sd_root .. "/.metronome"
local FILES = { DIR .. "/metronome_a.wav", DIR .. "/metronome_b.wav" }

------------------------------------------------------------------------
-- Settings

local cfg = {}

local function loop_supported()
    return plugin.has_capability and plugin.has_capability("audio.loop") and
        plugin.audio_loop_start ~= nil
end

-- Plays without opening Now Playing where the player supports it, so the
-- metronome screen stays in front.
local function play_here(path)
    if plugin.has_capability and plugin.has_capability("playback.stay_on_screen") then
        plugin.play_file(path, { open_player = false })
    else
        plugin.play_file(path)
    end
end

local function store_get(key)
    if not plugin.storage then return nil end
    local ok, value = pcall(plugin.storage.get, key)
    if ok then return value end
    return nil
end

local function store_set(key, value)
    if not plugin.storage then return end
    pcall(plugin.storage.set, key, tostring(value))
end

local function store_delete(key)
    if not plugin.storage then return end
    pcall(plugin.storage.delete, key)
end

local function clamp_int(value, lo, hi, default)
    local n = tonumber(value)
    if not n or n ~= n then return default end
    n = math.tointeger(math.floor(n + 0.5))
    if not n then return default end
    if n < lo then return lo end
    if n > hi then return hi end
    return n
end

local function find_sub(id)
    for _, sub in ipairs(SUBS) do
        if sub.id == id then return sub end
    end
    return SUBS[1]
end

local function compound_capable(num, den)
    return den == 8 and num % 3 == 0
end

local function sanitize()
    cfg.bpm = clamp_int(cfg.bpm, BPM_MIN, BPM_MAX, DEFAULTS.bpm)
    cfg.num = clamp_int(cfg.num, 1, 12, DEFAULTS.num)
    cfg.den = (tonumber(cfg.den) == 8) and 8 or 4
    cfg.sub = find_sub(cfg.sub).id
    cfg.accent_on = clamp_int(cfg.accent_on, 0, 1, 1)
    cfg.restore = clamp_int(cfg.restore, 0, 1, 1)
    cfg.lvl_accent = clamp_int(cfg.lvl_accent, 0, 10, DEFAULTS.lvl_accent)
    cfg.lvl_beat = clamp_int(cfg.lvl_beat, 0, 10, DEFAULTS.lvl_beat)
    cfg.lvl_sub = clamp_int(cfg.lvl_sub, 0, 10, DEFAULTS.lvl_sub)
    if cfg.count ~= "dotted" or not compound_capable(cfg.num, cfg.den) then cfg.count = "eighth" end
end

local function load_settings()
    for key, default in pairs(DEFAULTS) do
        local stored = store_get(key)
        if stored == nil or stored == "" then cfg[key] = default else cfg[key] = stored end
    end
    sanitize()
end

local function save_settings()
    sanitize()
    for key in pairs(DEFAULTS) do store_set(key, cfg[key]) end
end

------------------------------------------------------------------------
-- Rendering

-- Builds the click schedule and loop length for a configuration. Pure
-- integer arithmetic; see the header comment for the formulas.
local function build_plan(c, exact)
    local pulses = c.num
    if c.den == 8 and c.count == "dotted" and c.num % 3 == 0 then pulses = c.num // 3 end
    local per_bar_x60 = 60 * pulses
    local bars = (MIN_LOOP_SEC * c.bpm + per_bar_x60 - 1) // per_bar_x60
    if bars < 1 then bars = 1 end
    local loop_sec = bars * pulses * 60 / c.bpm
    local rate = loop_sec > LONG_LOOP_SEC and LOW_RATE or HIGH_RATE
    local sub = find_sub(c.sub)
    local d = sub.d
    local events = {}
    for k = 0, bars * pulses - 1 do
        for _, s in ipairs(sub.pos) do
            local kind
            if s ~= 0 then
                kind = "sub"
            elseif k % pulses == 0 and c.accent_on == 1 then
                kind = "accent"
            else
                kind = "beat"
            end
            if c[SOUNDS[kind].key] > 0 then
                events[#events + 1] = {
                    frame = (2 * (k * d + s) * rate * 60 + d * c.bpm) // (2 * d * c.bpm),
                    kind = kind,
                }
            end
        end
    end
    local loop_frames = (2 * bars * pulses * rate * 60 + c.bpm) // (2 * c.bpm)
    return {
        rate = rate, bars = bars, pulses = pulses, events = events,
        loop_frames = loop_frames,
        total_frames = exact and loop_frames or loop_frames + rate // TAIL_DIV,
        loop_end = (loop_frames + 0.5) / rate,
    }
end

-- A short sine burst with a fast attack and exponential decay, 16-bit stereo.
local function render_click(freq, ms, level, rate)
    local n = (rate * ms + 500) // 1000
    local amp = 0.9 * level / 10 * 32767
    local tau = n / 7
    local att = math.max(4, rate // 2000)
    local parts = {}
    local pack, exp, cos, floor = string.pack, math.exp, math.cos, math.floor
    local w = 2 * math.pi * freq / rate
    for i = 0, n - 1 do
        local env = exp(-i / tau)
        if i < att then env = env * (i + 1) / att end
        local v = floor(amp * env * cos(w * i) + 0.5)
        parts[i + 1] = pack("<i2i2", v, v)
    end
    return table.concat(parts)
end

local ZERO_BLOCK = string.rep("\0", 65536)

local function wav_header(rate, frames)
    local data = frames * 4
    return string.pack("<c4I4c4c4I4I2I2I4I4I2I2c4I4",
        "RIFF", 36 + data, "WAVE", "fmt ", 16, 1, 2, rate, rate * 4, 4, 16, "data", data)
end

local function write_wav(path, plan, c)
    local clicks = {}
    for kind, sound in pairs(SOUNDS) do
        if c[sound.key] > 0 then
            clicks[kind] = render_click(sound.freq, sound.ms, c[sound.key], plan.rate)
        end
    end
    local tmp = path .. ".tmp"
    local f = io.open(tmp, "wb")
    if not f then return false, "Could not write the click file" end
    local ok = f:write(wav_header(plan.rate, plan.total_frames)) ~= nil
    local pos = 0
    local function silence(frames)
        local bytes = frames * 4
        while ok and bytes >= #ZERO_BLOCK do
            ok = f:write(ZERO_BLOCK) ~= nil
            bytes = bytes - #ZERO_BLOCK
        end
        if ok and bytes > 0 then ok = f:write(string.rep("\0", bytes)) ~= nil end
    end
    local events = plan.events
    for i = 1, #events do
        local e = events[i]
        silence(e.frame - pos)
        local nxt = events[i + 1] and events[i + 1].frame or plan.loop_frames
        local click = clicks[e.kind]
        local frames = #click // 4
        if frames > nxt - e.frame then
            frames = nxt - e.frame
            click = click:sub(1, frames * 4)
        end
        if ok then ok = f:write(click) ~= nil end
        pos = e.frame + frames
    end
    silence(plan.total_frames - pos)
    local closed = f:close()
    if not ok or not closed then
        os.remove(tmp)
        return false, "Could not write the click file"
    end
    os.remove(path)
    if not os.rename(tmp, path) then
        os.remove(tmp)
        return false, "Could not write the click file"
    end
    return true
end

------------------------------------------------------------------------
-- Run state

local run = { running = false }
local restore_pending = nil     -- { path, pos } to seek after the previous track starts
local timer = nil
local tap_times = {}
local open_menu

local function cleanup_files()
    for _, path in ipairs(FILES) do
        os.remove(path)
        os.remove(path .. ".tmp")
    end
end

local function stop_timer()
    if timer and plugin.clear_interval then plugin.clear_interval(timer) end
    timer = nil
end

local function uptime()
    local f = io.open("/proc/uptime", "r")
    if not f then return nil end
    local text = f:read("l")
    f:close()
    return tonumber(text and text:match("^(%d+%.?%d*)"))
end

local function now()
    return uptime() or os.time()
end

local function restore_crossfade()
    if store_get("xfade") == "1" then
        if plugin.set_crossfade then pcall(plugin.set_crossfade, true) end
        store_delete("xfade")
    end
end

local function clear_prev()
    store_delete("prev_path")
    store_delete("prev_pos")
end

-- Ends the run. restore: resume the previous track. stop_audio: stop the
-- player when the metronome file is still the current track.
local function finish(restore, stop_audio)
    if not run.running then return end
    local path = run.path
    run.running = false
    stop_timer()
    if run.loop then
        if plugin.audio_loop_active() then plugin.audio_loop_stop() end
        if restore and run.paused_music and plugin.is_paused() then plugin.toggle_pause() end
        cleanup_files()
        run = { running = false }
        return
    end
    local current = plugin.get_current_track_path and plugin.get_current_track_path()
    if current == path and plugin.get_ab_loop and plugin.get_ab_loop() and plugin.clear_ab_loop then
        plugin.clear_ab_loop()
    end
    local prev_path, prev_pos = store_get("prev_path"), tonumber(store_get("prev_pos")) or 0
    if restore and current == path and prev_path and prev_path ~= "" then
        restore_pending = { path = prev_path, pos = prev_pos }
        play_here(prev_path)
    elseif stop_audio and current == path then
        plugin.stop()
    end
    cleanup_files()
    restore_crossfade()
    clear_prev()
    run = { running = false }
end

local function try_arm()
    if not run.running or not plugin.set_ab_loop then return false end
    if plugin.get_current_track_path() ~= run.path then return false end
    if not plugin.is_playing() then return false end
    local pos = plugin.get_position() or 0
    if pos >= run.loop_end - 0.3 then
        -- Too late to arm without running into the tail: start the file again.
        run.pending = true
        run.ticks = 0
        play_here(run.path)
        return false
    end
    if plugin.set_ab_loop(0, run.loop_end) then
        run.armed = true
        run.pending = false
        run.need_rearm = false
        run.ticks = 0
        if run.old_path then
            os.remove(run.old_path)
            run.old_path = nil
        end
        return true
    end
    return false
end

-- Renders the bar for the current settings and plays it.
local function launch()
    local plan = build_plan(cfg, run.loop)
    local ok_dir, dir_err = true, nil
    if plugin.mkdir then ok_dir, dir_err = plugin.mkdir(DIR) end
    if not ok_dir then return false, "Could not create the click folder" end
    local index = (run.index or 0) % 2 + 1
    local path = FILES[index]
    local ok, err = write_wav(path, plan, cfg)
    if not ok then return false, err end
    run.old_path = run.running and run.path or nil
    run.index = index
    run.path = path
    run.loop_end = plan.loop_end
    run.armed, run.pending, run.need_rearm, run.ticks = false, true, false, 0
    run.dirty = nil
    run.running = true
    if run.loop then
        if not plugin.audio_loop_start(path) then return false, "Could not play the click file" end
        run.pending = false
        if run.old_path then
            os.remove(run.old_path)
            run.old_path = nil
        end
        return true
    end
    play_here(path)
    return true
end

local function on_tick()
    if not run.running then
        stop_timer()
        return
    end
    if run.loop then
        if not plugin.audio_loop_active() then
            finish(false, false)
            plugin.show_toast("Metronome stopped")
            return
        end
        if run.dirty and now() - run.dirty >= DEBOUNCE then
            local ok, err = launch()
            if not ok then
                finish(false, true)
                plugin.show_toast(err or "Metronome stopped")
            end
        end
        return
    end
    local current = plugin.get_current_track_path()
    if run.pending then
        run.ticks = (run.ticks or 0) + 1
        if current == run.path and try_arm() then return end
        if run.ticks > ARM_GIVE_UP_TICKS then
            finish(false, true)
            plugin.show_toast("Metronome could not loop. Turn off crossfade and playback speed.")
        end
        return
    end
    if current ~= run.path or not (plugin.is_playing() or plugin.is_paused()) then
        finish(false, false)
        plugin.show_toast("Metronome stopped")
        return
    end
    if plugin.is_paused() then return end
    if run.need_rearm then
        run.ticks = (run.ticks or 0) + 1
        if not try_arm() and run.ticks > REARM_GIVE_UP_TICKS then
            finish(false, true)
            plugin.show_toast("Metronome stopped")
        end
        return
    end
    if not plugin.get_ab_loop() then
        finish(false, true)
        plugin.show_toast("Metronome stopped: its loop was cleared")
        return
    end
    if run.dirty and now() - run.dirty >= DEBOUNCE then
        local ok, err = launch()
        if not ok then
            finish(false, true)
            plugin.show_toast(err or "Metronome stopped")
        end
    end
end

local function start_timer()
    if timer or not plugin.set_interval then return end
    local ok, handle = pcall(plugin.set_interval, 1, on_tick)
    if ok and handle then
        timer = handle
    else
        plugin.show_toast("Timer slots are full; the metronome may not recover from pauses")
    end
end

local function capture_previous()
    local current = plugin.get_current_track_path and plugin.get_current_track_path()
    clear_prev()
    if not current or current == "" or current:find("^%a+://") then return end
    if current:sub(1, #DIR + 1) == DIR .. "/" then return end
    if not (plugin.is_playing() or plugin.is_paused()) then return end
    store_set("prev_path", current)
    store_set("prev_pos", string.format("%.3f", plugin.get_position() or 0))
end

local function start_metronome()
    if run.running then return true end
    if loop_supported() then
        run = { running = false, loop = true, paused_music = plugin.is_playing() }
        local ok, err = launch()
        if not ok then
            run = { running = false }
            cleanup_files()
            plugin.show_toast(err or "Could not start the metronome")
            return false
        end
        start_timer()
        return true
    end
    if not plugin.has_capability("playback.ab_loop") then
        plugin.show_toast("This player cannot loop audio natively")
        return false
    end
    if run.running then return true end
    capture_previous()
    if plugin.get_crossfade and plugin.get_crossfade() and plugin.set_crossfade then
        store_set("xfade", "1")
        plugin.set_crossfade(false)
    end
    run = { running = false }
    local ok, err = launch()
    if not ok then
        run = { running = false }
        cleanup_files()
        restore_crossfade()
        clear_prev()
        plugin.show_toast(err or "Could not start the metronome")
        return false
    end
    start_timer()
    return true
end

local function stop_metronome()
    finish(cfg.restore == 1, true)
end

-- Applies a settings change to a running metronome. Tempo changes are
-- debounced so repeated taps or steps restart the loop only once.
local function settings_changed(debounce)
    save_settings()
    if not run.running then return end
    if debounce then
        run.dirty = now()
        return
    end
    local ok, err = launch()
    if not ok then
        finish(false, true)
        plugin.show_toast(err or "Metronome stopped")
    end
end

------------------------------------------------------------------------
-- Events

if plugin.on then
    plugin.on("track_started", function()
        local current = plugin.get_current_track_path()
        if restore_pending and current == restore_pending.path then
            local target = restore_pending.pos
            restore_pending = nil
            if target > 1 then plugin.seek(target) end
            return
        end
        if not run.running or run.loop then return end
        if current == run.path then
            if run.pending then try_arm() end
        elseif not run.pending then
            finish(false, false)
        end
    end)
    plugin.on("paused", function()
        if run.running and not run.loop and not run.pending then run.need_rearm = true end
    end)
    plugin.on("resumed", function()
        if run.running and not run.loop and not run.pending and run.need_rearm then
            run.ticks = 0
            try_arm()
        end
    end)
    plugin.on("stopped", function()
        if run.running and not run.loop and not run.pending then finish(false, false) end
    end)
end

------------------------------------------------------------------------
-- UI

local function meter_label()
    return cfg.num .. "/" .. cfg.den
end

local function tempo_unit()
    if cfg.den == 4 then return "quarter notes" end
    if cfg.count == "dotted" then return "dotted quarter notes" end
    return "eighth notes"
end

local function rhythm_summary()
    local sub = {
        none = "Single notes", eighths = "Eighths", triplets = "Triplets",
        sixteenths = "Sixteenths", quintuplets = "Quintuplets",
        sextuplets = "Sextuplets", swing = "Swing",
    }
    local summary = meter_label()
    if cfg.den == 8 then
        summary = summary .. " · " .. (cfg.count == "dotted" and "Dotted quarter" or "Eighth")
    end
    return summary .. " · " .. sub[cfg.sub]
end

local open_tempo_steps, open_rhythm, open_levels, open_playback

local function show_about()
    local playback
    if loop_supported() then
        playback = {
            { label = "Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music.", wrap = true },
            { label = "The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome.", wrap = true },
        }
    else
        playback = {
            { label = "Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored.", wrap = true },
            { label = "The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop.", wrap = true },
        }
    end
    plugin.show_list("About Metronome", {
        playback[1],
        playback[2],
        { label = "Tempo counts " .. tempo_unit() .. ". In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths.", wrap = true },
        { label = "Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound.", wrap = true },
        { label = loop_supported() and "Crossfade and playback speed are not affected." or
            "Crossfade is switched off while the metronome runs and restored when it stops.", wrap = true },
    }, function() end)
end

local function choose_meter()
    local items, selected = {}, 1
    for _, den in ipairs({ 4, 8 }) do
        for num = 1, 12 do
            items[#items + 1] = num .. "/" .. den
            if num == cfg.num and den == cfg.den then selected = #items end
        end
    end
    plugin.show_list("Time signature", items, function(index)
        local den = index > 12 and 8 or 4
        local num = (index - 1) % 12 + 1
        if num == cfg.num and den == cfg.den then return end
        cfg.num, cfg.den = num, den
        if not compound_capable(num, den) then cfg.count = "eighth" end
        settings_changed(false)
        open_menu(true)
        open_rhythm(true)
    end, { selected = selected })
end

local function choose_counting()
    local items = { "Eighth notes", "Dotted quarter notes" }
    plugin.show_list("Count tempo in", items, function(index)
        local count = index == 2 and "dotted" or "eighth"
        if count == cfg.count then return end
        cfg.count = count
        settings_changed(false)
        open_menu(true)
        open_rhythm(true)
    end, { selected = cfg.count == "dotted" and 2 or 1 })
end

local function choose_subdivision()
    local items, selected = {}, 1
    for i, sub in ipairs(SUBS) do
        items[i] = sub.name
        if sub.id == cfg.sub then selected = i end
    end
    plugin.show_list("Subdivision", items, function(index)
        if SUBS[index].id == cfg.sub then return end
        cfg.sub = SUBS[index].id
        settings_changed(false)
        open_menu(true)
        open_rhythm(true)
    end, { selected = selected })
end

local function set_bpm(value, debounce, redraw)
    local bpm = clamp_int(value, BPM_MIN, BPM_MAX, cfg.bpm)
    if bpm == cfg.bpm then return end
    cfg.bpm = bpm
    settings_changed(debounce)
    if redraw then redraw() end
end

local function tap_tempo()
    local t = uptime()
    if not t then
        plugin.show_toast("Tap tempo is not available on this system")
        return
    end
    if #tap_times > 0 and t - tap_times[#tap_times] > TAP_GAP then tap_times = {} end
    tap_times[#tap_times + 1] = t
    while #tap_times > TAP_KEEP do table.remove(tap_times, 1) end
    if #tap_times < 2 then
        plugin.show_toast("Keep tapping")
        return
    end
    local average = (tap_times[#tap_times] - tap_times[1]) / (#tap_times - 1)
    if average <= 0 then return end
    local bpm = math.floor(60 / average + 0.5)
    if bpm < BPM_MIN then bpm = BPM_MIN end
    if bpm > BPM_MAX then bpm = BPM_MAX end
    if bpm ~= cfg.bpm then
        cfg.bpm = bpm
        settings_changed(true)
    end
    open_menu(true)
end

local function level_slider(label, key)
    return {
        type = "slider", label = label, min = 0, max = 10, value = cfg[key],
        on_change = function(value)
            cfg[key] = value
            settings_changed(false)
            open_menu(true)
            open_levels(true)
        end,
    }
end

open_tempo_steps = function(update)
    local items = {}
    for _, step in ipairs({ -10, -1, 1, 10 }) do
        local target = clamp_int(cfg.bpm + step, BPM_MIN, BPM_MAX, cfg.bpm)
        items[#items + 1] = {
            type = "row",
            label = string.format("%s%d BPM → %d BPM", step > 0 and "+" or "", step, target),
            on_select = function()
                set_bpm(cfg.bpm + step, true, function()
                    open_menu(true)
                    open_tempo_steps(true)
                end)
            end,
        }
    end
    plugin.show_settings_list("Tempo adjustments", items, update and { update = true } or nil)
end

open_rhythm = function(update)
    local items = {
        { type = "row", label = "Time signature: " .. meter_label(), on_select = choose_meter },
    }
    if compound_capable(cfg.num, cfg.den) then
        items[#items + 1] = {
            type = "row",
            label = "Count tempo in: " .. (cfg.count == "dotted" and "dotted quarter" or "eighth") .. " notes",
            on_select = choose_counting,
        }
    end
    items[#items + 1] = { type = "row", label = "Subdivision: " .. find_sub(cfg.sub).name, on_select = choose_subdivision, wrap = true }
    items[#items + 1] = {
        type = "toggle", label = "Accent beat 1", value = cfg.accent_on == 1,
        on_change = function(value)
            cfg.accent_on = value and 1 or 0
            settings_changed(false)
            open_menu(true)
            open_rhythm(true)
        end,
    }
    plugin.show_settings_list("Rhythm", items, update and { update = true } or nil)
end

open_levels = function(update)
    local items = {
        level_slider("Accent level", "lvl_accent"),
        level_slider("Beat level", "lvl_beat"),
        level_slider("Subdivision level", "lvl_sub"),
    }
    plugin.show_settings_list("Sound levels", items, update and { update = true } or nil)
end

open_playback = function(update)
    local items = {
        {
            type = "toggle", label = loop_supported() and "Resume music on stop" or "Resume previous track on stop", value = cfg.restore == 1,
            on_change = function(value)
                cfg.restore = value and 1 or 0
                save_settings()
                open_playback(true)
            end,
        },
        { type = "row", label = "About Metronome", on_select = show_about },
    }
    plugin.show_settings_list("Playback & about", items, update and { update = true } or nil)
end

open_menu = function(update)
    local items = {
        {
            type = "row",
            label = run.running and "Stop" or "Start",
            icon = run.running and "Metronome/stop.png" or "Metronome/play.png",
            on_select = function()
                if run.running then stop_metronome() else start_metronome() end
                open_menu(true)
            end,
        },
        {
            type = "slider", label = "Tempo", min = BPM_MIN, max = BPM_MAX, value = cfg.bpm,
            icon = "Metronome/sliders-horizontal.png",
            on_change = function(value) set_bpm(value, false, function() open_menu(true) end) end,
        },
        { type = "row", label = "Tap tempo", icon = "Metronome/hand-tap.png", on_select = tap_tempo },
        { type = "row", label = "Tempo", icon = "Metronome/sliders-horizontal.png", on_select = function() open_tempo_steps(false) end },
        { type = "row", label = "Rhythm", icon = "Metronome/music-notes.png", on_select = function() open_rhythm(false) end },
        { type = "row", label = "Sound", icon = "Metronome/speaker-high.png", on_select = function() open_levels(false) end },
        { type = "row", label = "Options", icon = "Metronome/gear-six.png", on_select = function() open_playback(false) end },
    }
    local markers = build_plan(cfg).pulses
    plugin.show_settings_list("Metronome", items, {
        update = update == true,
        layout = "dashboard",
        markers = markers,
        accent_first = cfg.accent_on == 1,
        active = run.running,
        detail = rhythm_summary(),
    })
end

------------------------------------------------------------------------
-- Startup

load_settings()

local function adopt_or_sweep()
    local current = plugin.get_current_track_path and plugin.get_current_track_path()
    for i, path in ipairs(FILES) do
        if current == path then
            local loop = plugin.get_ab_loop and plugin.get_ab_loop()
            local plan = build_plan(cfg)
            run = {
                running = true, index = i, path = path,
                loop_end = loop and loop.finish or plan.loop_end,
                armed = loop ~= nil, pending = false, need_rearm = loop == nil, ticks = 0,
            }
            start_timer()
            return
        end
    end
    cleanup_files()
    restore_crossfade()
    clear_prev()
end
adopt_or_sweep()

if plugin.register_list_item then
    local icon = { icon = "Metronome.png" }
    local function open() open_menu(false) end
    -- More only. Its four plugin rows are shared, so fall back to Playback &
    -- Controls when More is full or missing rather than leave no way in.
    local in_more = plugin.has_capability and plugin.has_capability("ui.more_menu") and
        pcall(plugin.register_list_item, "more", "Metronome", open, icon)
    if not in_more then plugin.register_list_item("playback", "Metronome", open, icon) end
end
