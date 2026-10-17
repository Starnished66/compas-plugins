-- Host test for plugins/Metronome/Metronome.lua.
--
--   lua tools/test_metronome.lua [quick]
--
-- Runs the real plugin file against a stub of the plugin API, starts the
-- metronome through its own menu, and checks the WAV file it writes: header,
-- exact loop length, every click onset at its expected sample, accent on
-- beat 1, the loop end the plugin hands to plugin.set_ab_loop, and the
-- generation time. It also drives the start/arm/pause/stop state machine.

local quick = arg and arg[1] == "quick"
local script_dir = (arg and arg[0] or "tools/test_metronome.lua"):match("^(.*)/[^/]*$") or "."
local PLUGIN = script_dir .. "/../plugins/Metronome/Metronome.lua"

local function shell(cmd)
    local p = assert(io.popen(cmd))
    local out = p:read("a")
    p:close()
    return out
end
local SD = shell("mktemp -d"):gsub("%s+$", "")
local failures, checks = 0, 0

local function check(cond, message)
    checks = checks + 1
    if not cond then
        failures = failures + 1
        print("FAIL: " .. message)
    end
end

------------------------------------------------------------------------
-- Stub plugin API

local function new_env(storage)
    local S = {
        storage = storage or {}, played = {}, loops = {}, stops = 0, seeks = {},
        handlers = {}, intervals = {}, toasts = {}, current = nil, playing = false,
        paused = false, position = 0, crossfade = false, loop = nil, crossfade_sets = {},
        menu_cb = nil, items = nil, rows = {}, caps = { ["ui.more_menu"] = true },
    }
    local p = {}
    p.define = function() end
    p.sd_root = function() return SD end
    p.mkdir = function(path) os.execute("mkdir -p '" .. path .. "'") return true end
    p.storage = {
        get = function(k, d) local v = S.storage[k] if v == nil then return d end return v end,
        set = function(k, v) S.storage[k] = tostring(v) return true end,
        delete = function(k) S.storage[k] = nil return true end,
    }
    p.has_capability = function(name) return S.caps[name] == true or name ~= "ui.more_menu" end
    p.on = function(name, fn) S.handlers[name] = fn end
    p.register_list_item = function(list, label, cb, opts)
        S.rows[#S.rows + 1] = { list = list, label = label, icon = opts and opts.icon }
        S.menu_cb = cb
    end
    p.show_settings_list = function(_, items) S.items = items end
    p.show_list = function() end
    p.show_toast = function(m) S.toasts[#S.toasts + 1] = m end
    p.play_file = function(path, opts)
        S.played[#S.played + 1] = path
        S.play_opts = S.play_opts or {}
        S.play_opts[#S.played] = opts
        S.current, S.playing, S.paused, S.position, S.loop = path, true, false, 0, nil
    end
    p.stop = function() S.stops = S.stops + 1 S.playing, S.current, S.loop = false, nil, nil end
    p.get_current_track_path = function() return S.current end
    p.is_playing = function() return S.playing and not S.paused end
    p.is_paused = function() return S.paused end
    p.get_position = function() return S.position end
    p.seek = function(t) S.seeks[#S.seeks + 1] = t end
    p.get_crossfade = function() return S.crossfade end
    p.set_crossfade = function(v) S.crossfade = v S.crossfade_sets[#S.crossfade_sets + 1] = v end
    p.set_ab_loop = function(a, b)
        S.loops[#S.loops + 1] = { a, b }
        if S.reject_loop then return false end
        S.loop = { start = a, finish = b }
        return true
    end
    p.get_ab_loop = function() return S.loop end
    p.clear_ab_loop = function() S.loop = nil end
    p.set_interval = function(_, fn) S.intervals[#S.intervals + 1] = fn return #S.intervals end
    p.clear_interval = function(h) S.intervals[h] = nil end
    local env = setmetatable({ plugin = p }, { __index = _G })
    S.env = env
    return S
end

local function load_plugin(S)
    local chunk = assert(loadfile(PLUGIN, "t", S.env))
    chunk()
end

local function exists(path)
    local f = io.open(path, "rb")
    if f then f:close() return true end
    return false
end

local function rm_files()
    os.execute("rm -rf '" .. SD .. "/.metronome'")
end

------------------------------------------------------------------------
-- WAV analysis

local function read_all(path)
    local f = assert(io.open(path, "rb"))
    local data = f:read("a")
    f:close()
    return data
end

-- Expected loop length and click frames, derived independently of the plugin
-- (rational arithmetic, then checked against real-valued time).
local SUBS = {
    none = { d = 1, pos = { 0 } }, eighths = { d = 2, pos = { 0, 1 } },
    triplets = { d = 3, pos = { 0, 1, 2 } }, sixteenths = { d = 4, pos = { 0, 1, 2, 3 } },
    quintuplets = { d = 5, pos = { 0, 1, 2, 3, 4 } }, sextuplets = { d = 6, pos = { 0, 1, 2, 3, 4, 5 } },
    swing = { d = 3, pos = { 0, 2 } },
}

local function round_div(num, den)
    local q, r = num // den, num % den
    return q + ((2 * r >= den) and 1 or 0)
end

local function expected_for(c)
    local pulses = (c.den == 8 and c.count == "dotted") and c.num // 3 or c.num
    local bars = 1
    while bars * pulses * 60 < 3 * c.bpm do bars = bars + 1 end
    local loop_sec = bars * pulses * 60 / c.bpm
    local rate = loop_sec > 10 and 22050 or 44100
    local sub = SUBS[c.sub]
    local events = {}
    for k = 0, bars * pulses - 1 do
        for _, s in ipairs(sub.pos) do
            local t = (k + s / sub.d) * 60 / c.bpm
            local frame = round_div((k * sub.d + s) * rate * 60, sub.d * c.bpm)
            assert(math.abs(frame - t * rate) <= 0.5 + 1e-6, "expected frame is not nearest")
            events[#events + 1] = { frame = frame, accent = (k % pulses == 0 and s == 0) }
        end
    end
    return { rate = rate, bars = bars, events = events, loop_frames = round_div(bars * pulses * rate * 60, c.bpm) }
end

local function analyse(data, rate)
    local hdr = {}
    hdr.riff, hdr.size, hdr.wave, hdr.fmt, hdr.fmtlen, hdr.format, hdr.channels, hdr.rate,
        hdr.byterate, hdr.align, hdr.bits, hdr.data, hdr.datalen = string.unpack("<c4I4c4c4I4I2I2I4I4I2I2c4I4", data)
    local clicks = {}
    local last_end
    local peak = 0
    local cur
    for p, q in string.gmatch(data:sub(45), "()[^%z]+()") do
        local first, last = (p - 1) // 4, (q - 2) // 4
        if cur and first - cur.last <= 8 then
            cur.last = last
        else
            cur = { frame = first, last = last, peak = 0 }
            clicks[#clicks + 1] = cur
        end
    end
    -- Peak per click, from the samples themselves.
    for _, c in ipairs(clicks) do
        local seg = data:sub(45 + c.frame * 4, 45 + (c.last + 1) * 4 - 1)
        for i = 1, #seg - 3, 4 do
            local v = math.abs(string.unpack("<i2", seg, i))
            if v > c.peak then c.peak = v end
        end
    end
    return hdr, clicks
end

------------------------------------------------------------------------
-- Rendering matrix

local worst = { time = 0 }

local function run_case(c)
    rm_files()
    local S = new_env({
        bpm = c.bpm, num = c.num, den = c.den, count = c.count or "eighth", sub = c.sub,
        accent_on = c.accent_on or 1, lvl_accent = 10, lvl_beat = 8, lvl_sub = 5,
    })
    load_plugin(S)
    S.menu_cb()
    local t0 = os.clock()
    S.items[1].on_select()
    local elapsed = os.clock() - t0
    local label = string.format("%d/%d %s %d bpm %s", c.num, c.den, c.count or "", c.bpm, c.sub)
    if elapsed > worst.time then worst = { time = elapsed, label = label } end
    check(#S.played == 1, label .. ": play_file called once")
    check(S.play_opts[1] and S.play_opts[1].open_player == false, label .. ": starts without opening Now Playing")
    local path = S.played[1]
    check(exists(path), label .. ": file exists")
    check(not exists(path .. ".tmp"), label .. ": temp file renamed")
    S.handlers.track_started()
    local exp = expected_for({ bpm = c.bpm, num = c.num, den = c.den, count = c.count or "eighth", sub = c.sub })
    local data = read_all(path)
    local hdr, clicks = analyse(data, exp.rate)
    local total = exp.loop_frames + exp.rate // 4
    check(hdr.riff == "RIFF" and hdr.wave == "WAVE" and hdr.fmt == "fmt " and hdr.data == "data", label .. ": chunk ids")
    check(hdr.size == #data - 8, label .. ": RIFF size")
    check(hdr.fmtlen == 16 and hdr.format == 1 and hdr.channels == 2 and hdr.bits == 16, label .. ": PCM stereo 16-bit")
    check(hdr.rate == exp.rate and hdr.byterate == exp.rate * 4 and hdr.align == 4, label .. ": rate fields")
    check(hdr.datalen == total * 4 and #data == 44 + total * 4, label .. ": data length")
    check(#S.loops == 1 and S.loops[1][1] == 0, label .. ": loop armed from 0")
    local end_s = S.loops[1] and S.loops[1][2] or 0
    check(math.floor(end_s * exp.rate) == exp.loop_frames, label .. ": loop end truncates to bar length")
    check(end_s * exp.rate <= total, label .. ": loop end inside file")
    check(#clicks == #exp.events, label .. ": click count " .. #clicks .. " vs " .. #exp.events)
    local peak_accent, peak_beat, peak_sub = 0, 0, 0
    for i, e in ipairs(exp.events) do
        local got = clicks[i]
        if not got or got.frame ~= e.frame then
            check(false, label .. ": click " .. i .. " at " .. tostring(got and got.frame) .. " expected " .. e.frame)
            break
        end
        check(got.last < exp.loop_frames, label .. ": click ends before loop end")
        local kind_sub = (i - 1) % #SUBS[c.sub].pos ~= 0
        if kind_sub then
            peak_sub = math.max(peak_sub, got.peak)
        elseif e.accent and (c.accent_on or 1) == 1 then
            peak_accent = math.max(peak_accent, got.peak)
        else
            peak_beat = math.max(peak_beat, got.peak)
        end
        if e.accent and (c.accent_on or 1) == 1 and not kind_sub then
            check(got.peak > 0.85 * 0.9 * 32767 * 0.95, label .. ": accent level at bar start")
        end
    end
    if peak_sub > 0 then check(peak_sub < peak_beat or peak_beat == 0, label .. ": sub quieter than beat") end
    if peak_accent > 0 and peak_beat > 0 then check(peak_accent > peak_beat, label .. ": accent louder than beat") end
    if (c.accent_on or 1) == 0 and peak_beat > 0 then
        check(clicks[1].peak < 0.9 * 32767 * 0.85, label .. ": beat 1 is a plain beat when accent is off")
    end
    return exp
end

local meters = {
    { 2, 4 }, { 3, 4 }, { 4, 4 }, { 5, 4 }, { 1, 4 }, { 12, 4 },
    { 6, 8 }, { 7, 8 }, { 9, 8 }, { 12, 8 }, { 6, 8, "dotted" }, { 9, 8, "dotted" }, { 12, 8, "dotted" },
}
local subs = { "none", "eighths", "triplets", "sixteenths", "quintuplets", "sextuplets", "swing" }
local tempos = quick and { 20, 120, 300 } or { 20, 47, 60, 72, 73, 97, 120, 133, 200, 300 }

local cases = 0
for _, m in ipairs(meters) do
    for _, bpm in ipairs(tempos) do
        for _, sub in ipairs(subs) do
            run_case({ num = m[1], den = m[2], count = m[3], bpm = bpm, sub = sub })
            cases = cases + 1
        end
    end
end
run_case({ num = 4, den = 4, bpm = 120, sub = "triplets", accent_on = 0 })
cases = cases + 1
print(string.format("render cases: %d, worst generation time on host: %.3f s (%s)", cases, worst.time, worst.label))
check(worst.time < 0.2, "worst-case generation under 0.2 s on the host (about 2 s at 10x slower)")

------------------------------------------------------------------------
-- State machine

local function boot(storage, setup)
    rm_files()
    local S = new_env(storage or { bpm = 100, num = 4, den = 4, sub = "none" })
    if setup then setup(S) end
    load_plugin(S)
    S.menu_cb()
    return S
end

-- Start, arm, pause/resume re-arm, stop with previous track restore.
do
    local S = boot(nil, function(S)
        S.current, S.playing, S.position, S.crossfade = SD .. "/Music/song.flac", true, 42.5, true
    end)
    S.items[1].on_select()
    check(S.crossfade == false, "crossfade turned off on start")
    check(#S.played == 1 and S.played[1]:find("/%.metronome/metronome_[ab]%.wav$") ~= nil, "starts a file in .metronome")
    check(S.storage.prev_path == SD .. "/Music/song.flac", "previous track remembered")
    S.handlers.track_started()
    check(#S.loops == 1, "armed on track_started")
    S.paused, S.loop = true, nil
    S.handlers.paused()
    S.paused = false
    S.handlers.resumed()
    check(#S.loops == 2 and S.loop ~= nil, "re-armed after resume")
    S.items = nil
    S.menu_cb()
    check(S.items[1].label == "Stop", "menu shows Stop while running")
    S.items[1].on_select()
    check(S.played[#S.played] == SD .. "/Music/song.flac", "previous track restarted on stop")
    S.handlers.track_started()
    check(S.seeks[1] == 42.5, "previous position restored")
    check(S.crossfade == true and S.storage.xfade == nil, "crossfade restored")
    check(not exists(SD .. "/.metronome/metronome_a.wav") and not exists(SD .. "/.metronome/metronome_b.wav"), "files removed on stop")
    check(S.stops == 0, "no hard stop when previous track resumes")
end

-- Changing a setting while running regenerates and swaps files.
do
    local S = boot()
    S.items[1].on_select()
    S.handlers.track_started()
    local first = S.played[1]
    S.items[2].on_change(140)
    check(#S.played == 2 and S.played[2] ~= first, "tempo slider restarts with the other file")
    check(exists(first), "old file kept until the new one is armed")
    S.handlers.track_started()
    check(#S.loops == 2 and not exists(first), "old file removed after re-arm")
    check(math.abs(S.loops[2][2] * 44100 - math.floor(S.loops[2][2] * 44100) - 0.5) < 1e-3, "loop end is half a frame past the bar")
    -- Back-to-back changes before arming must not delete the file in use.
    S.items[2].on_change(150)
    S.items[2].on_change(160)
    check(exists(S.played[#S.played]), "file in use exists after quick successive changes")
    S.handlers.track_started()
    check(exists(S.played[#S.played]), "file in use survives arming")
end

-- Loop cleared externally: the metronome stops.
do
    local S = boot()
    S.items[1].on_select()
    S.handlers.track_started()
    S.loop = nil
    S.intervals[1]()
    check(S.stops == 1 and S.current == nil, "stops when the loop is cleared")
    check(not exists(SD .. "/.metronome/metronome_a.wav"), "files removed after loop cleared")
end

-- Track changed by the user: the metronome ends without stopping their track.
do
    local S = boot()
    S.items[1].on_select()
    S.handlers.track_started()
    S.current = SD .. "/other.flac"
    S.handlers.track_started()
    check(S.stops == 0, "other track left playing")
    check(not exists(SD .. "/.metronome/metronome_a.wav"), "files removed on track change")
    check(S.intervals[1] == nil, "timer cleared")
end

-- Arming never succeeds: give up cleanly and restore crossfade.
do
    local S = boot(nil, function(S) S.crossfade, S.reject_loop = true, true end)
    S.items[1].on_select()
    for _ = 1, 12 do if S.intervals[1] then S.intervals[1]() end end
    check(S.stops == 1 and S.crossfade == true, "gives up and restores crossfade")
end

-- Reload while the metronome plays: adopt it, and sweep when it does not.
do
    local S = boot()
    S.items[1].on_select()
    S.handlers.track_started()
    local path, loop = S.played[1], S.loop
    local S2 = new_env(S.storage)
    S2.current, S2.playing, S2.loop = path, true, loop
    load_plugin(S2)
    S2.menu_cb()
    check(S2.items[1].label == "Stop", "adopts a running metronome after reload")
    local S3 = new_env({ xfade = "1" })
    load_plugin(S3)
    check(not exists(path) and S3.crossfade == true, "stale files swept and crossfade restored on load")
end

rm_files()
os.execute("rmdir '" .. SD .. "' 2>/dev/null")
print(string.format("%d checks, %d failures", checks, failures))
os.exit(failures == 0 and 0 or 1)
