plugin.define({
    id = "example.abx_blind_test",
    name = "ABX Blind Test",
    version = "1.1.0",
    api_min = 16,
})

-- Blind ABX listening test with randomized X for matched audio files and parametric EQ profiles.
-- The tester evaluates Sample A, Sample B, and randomized Sample X to determine if X is A or B.
-- Supports:
-- 1. File comparison: utilizes native audio engine A/B switching (raw PCM gapless with shared DSP).
--    Supports 16-bit PCM (WAV/AIFF/CAF) and FLAC, as well as MP3 (source_bit_depth == 0)
--    with exact trimmed frame count, sample rate, and channel matching.
-- 2. EQ profile comparison: loads .peq profiles transiently (persist = false), preserving
--    and restoring the runtime baseline using get_eq_state and eq_apply_state with guarded state matching.
--    Hardware/DSP limitation: live PEQ profile coefficient updates cannot guarantee click-free switching.

local session = {
    active = false,
    mode = nil,            -- "file" or "eq"
    last_mode = nil,       -- remembered mode across session completion
    epoch = 0,             -- session epoch incremented on start/restart to invalidate stale callbacks
    current_view = "main", -- "main", "file", "eq", or "trial"

    -- File mode
    path_a = nil,
    path_b = nil,
    initial_generation = nil,
    owned_candidate = false, -- tracks whether we initiated a prepare_ab_switch job
    file_b_ready = false,
    file_b_preparing = false,
    prep_timer = nil,

    -- EQ mode
    baseline_eq = nil,
    last_applied_eq = nil,
    profile_a_state = nil,
    profile_b_state = nil,
    profile_a_name = "Baseline EQ",
    profile_b_name = "Profile B",
    profile_b_path = nil,

    -- Trial state
    total_trials = 10,
    current_trial = 1,
    trial_x = nil,         -- "a" or "b", generated once per trial
    score = 0,
    trial_results = {},
    current_audition = nil, -- "a", "b", or "x"

    -- Finished session preservation
    finished = false,
    final_score = 0,
    final_total = 0,
    final_p_val = 1.0,
}

local function is_finite_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

-- Binomial probability calculation for ABX testing:
-- Under the null hypothesis of pure guessing (p = 0.5),
-- calculate the one-tailed probability P(K >= k) of getting k or more correct out of n trials.
local function binomial_p_value(k, n)
    if not n or n <= 0 then return 1.0 end
    if not k or k <= 0 then return 1.0 end
    if k > n then return 0.0 end

    local function n_choose_i(total, choose)
        if choose == 0 or choose == total then return 1 end
        if choose > total - choose then choose = total - choose end
        local c = 1
        for j = 1, choose do
            c = c * (total - j + 1) / j
        end
        return c
    end

    local sum = 0
    for i = k, n do
        sum = sum + n_choose_i(n, i)
    end
    local p_val = sum * (0.5 ^ n)
    if p_val > 1.0 then p_val = 1.0 end
    return p_val
end

-- Deep comparison helper for EQ snapshots with 1e-6 precision.
-- Rejects missing or non-finite data. Detects manual edits of 0.01 dB gain/preamp or 0.01 Q/width.
local function eq_states_match(s1, s2)
    if type(s1) ~= "table" or type(s2) ~= "table" then return false end
    if s1.bypass ~= s2.bypass then return false end
    if not is_finite_number(s1.preamp_db) or not is_finite_number(s2.preamp_db) then return false end
    if math.abs(s1.preamp_db - s2.preamp_db) > 1e-6 then return false end
    if not is_finite_number(s1.stereo_width) or not is_finite_number(s2.stereo_width) then return false end
    if math.abs(s1.stereo_width - s2.stereo_width) > 1e-6 then return false end

    local b1 = s1.bands
    local b2 = s2.bands
    if type(b1) ~= "table" or type(b2) ~= "table" then return false end
    if #b1 ~= 10 or #b2 ~= 10 then return false end

    for i = 1, 10 do
        local band1 = b1[i]
        local band2 = b2[i]
        if type(band1) ~= "table" or type(band2) ~= "table" then return false end
        if band1.enabled ~= band2.enabled then return false end
        if band1.type ~= band2.type then return false end
        if not is_finite_number(band1.freq_hz) or not is_finite_number(band2.freq_hz) then return false end
        if math.abs(band1.freq_hz - band2.freq_hz) > 1e-6 then return false end
        if not is_finite_number(band1.gain_db) or not is_finite_number(band2.gain_db) then return false end
        if math.abs(band1.gain_db - band2.gain_db) > 1e-6 then return false end
        if not is_finite_number(band1.q) or not is_finite_number(band2.q) then return false end
        if math.abs(band1.q - band2.q) > 1e-6 then return false end
    end
    return true
end

local function stop_prep_timer()
    if session.prep_timer then
        plugin.clear_interval(session.prep_timer)
        session.prep_timer = nil
    end
end

local function restore_eq_baseline()
    if session.baseline_eq and plugin.eq_apply_state then
        local current = plugin.get_eq_state and plugin.get_eq_state()
        if session.last_applied_eq and eq_states_match(current, session.last_applied_eq) then
            plugin.eq_apply_state(session.baseline_eq, { persist = false })
        end
    end
    session.baseline_eq = nil
    session.last_applied_eq = nil
end

local function clear_owned_candidate()
    if session.owned_candidate then
        if plugin.clear_ab_switch then
            plugin.clear_ab_switch()
        end
        session.owned_candidate = false
    end
    session.file_b_ready = false
    session.file_b_preparing = false
    stop_prep_timer()
end

local function stop_session(reason)
    stop_prep_timer()
    clear_owned_candidate()
    if session.mode == "eq" then
        restore_eq_baseline()
    end
    session.active = false
    session.current_audition = nil
    if reason then
        plugin.show_toast(reason)
    end
end

-- Validate strict path safety: must be a local file inside SD card
local function validate_sd_file_path(path)
    if type(path) ~= "string" or path == "" then
        return false, "Path must be a non-empty string"
    end
    if path:match("^[A-Za-z]+://") then
        return false, "Network URLs are not supported for local comparison"
    end
    if ("/" .. path .. "/"):find("/../", 1, true) then
        return false, "Path traversal ('..') is not permitted"
    end
    local root = plugin.sd_root and plugin.sd_root() or "/data/mnt/sd_0"
    if path ~= root and path:sub(1, #root + 1) ~= (root .. "/") then
        return false, "Path must be located inside the SD card (" .. root .. ")"
    end
    return true
end

-- Validate live file readiness at controls (audition, vote, start)
local function validate_live_file_readiness()
    if not plugin.is_playing or not plugin.is_playing() then
        return false, "playback paused or stopped"
    end
    local st = plugin.get_ab_switch and plugin.get_ab_switch()
    if not st or not st.ready then
        return false, "native switch not ready"
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    if not fmt then
        return false, "playback format unavailable"
    end
    if session.initial_generation and fmt.generation and fmt.generation ~= session.initial_generation then
        return false, "track restarted or changed"
    end
    if session.path_a and fmt.path and fmt.path ~= session.path_a then
        return false, "track path changed"
    end
    local speed = fmt.playback_speed
    if speed == nil and plugin.get_playback_speed then speed = plugin.get_playback_speed() end
    if not is_finite_number(speed) or speed ~= 1.0 then
        return false, string.format("playback speed must be 1.0x (currently %s)", tostring(speed or "unknown"))
    end
    local crossfade = fmt.crossfade_enabled
    if crossfade == nil and plugin.get_crossfade then crossfade = plugin.get_crossfade() end
    if crossfade then
        return false, "crossfade enabled"
    end
    if fmt.is_stream or fmt.is_dsd then
        return false, "stream/dsd source"
    end
    if not is_finite_number(fmt.duration_seconds) or fmt.duration_seconds <= 0 then
        return false, "track duration not positive and finite"
    end
    return true
end

-- Validate current playback eligibility for EQ testing
local function validate_live_eq_playback()
    if not plugin.is_playing or not plugin.is_playing() then
        return false, "playback paused or stopped"
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    if not fmt then
        return false, "playback format unavailable"
    end
    if fmt.is_stream then
        return false, "streaming audio not supported"
    end
    if not is_finite_number(fmt.duration_seconds) or fmt.duration_seconds <= 0 then
        return false, "track duration not finite or positive"
    end
    if session.path_a and fmt.path and session.path_a ~= fmt.path then
        return false, "track path changed"
    end
    if session.initial_generation and fmt.generation and session.initial_generation ~= fmt.generation then
        return false, "track playback generation changed"
    end
    return true
end

-- Validate primary playing track before starting file comparison preparation
local function validate_primary_track()
    if not plugin.has_capability or not plugin.has_capability("playback.ab_switch") then
        return false, "Player lacks playback.ab_switch capability"
    end
    if not plugin.is_playing or not plugin.is_playing() then
        return false, "Primary track must be currently playing"
    end
    if not plugin.get_playback_format then
        return false, "Playback format query unavailable"
    end
    local fmt = plugin.get_playback_format()
    if not fmt then
        return false, "No active audio format"
    end
    if fmt.is_stream then
        return false, "Stream playback cannot be used for comparison"
    end
    if fmt.is_dsd then
        return false, "DSD tracks cannot be used for AB switch"
    end
    local speed = fmt.playback_speed
    if speed == nil and plugin.get_playback_speed then speed = plugin.get_playback_speed() end
    if not is_finite_number(speed) or speed ~= 1.0 then
        return false, "Playback speed must be 1.0x"
    end
    local crossfade = fmt.crossfade_enabled
    if crossfade == nil and plugin.get_crossfade then
        crossfade = plugin.get_crossfade()
    end
    if crossfade then
        return false, "Crossfade must be disabled in Sound settings"
    end
    local is_16bit_lossless = (fmt.bit_depth == 16 and (fmt.codec == "flac" or fmt.codec == "pcm"))
    local is_mp3 = (fmt.codec == "mp3" and fmt.bit_depth == 0)
    if not is_16bit_lossless and not is_mp3 then
        return false, string.format("Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3", fmt.codec or "unknown", fmt.bit_depth or 0)
    end
    return true
end

-- Forward declaration of view dispatcher
local show_view

-- Asynchronous preparation polling for File B.
-- Background polling does NOT reopen menus; it updates session flags and notifies via toast.
local function start_prep_polling()
    if session.prep_timer then return end
    local polls = 0
    -- Long bounded timeout: building MP3 seek index on slow SD can take several minutes.
    -- We allow up to 300 seconds (5 minutes), with a user cancel option always visible.
    local ok, handle = pcall(plugin.set_interval, 1, function()
        polls = polls + 1
        local st = plugin.get_ab_switch and plugin.get_ab_switch()
        if not st then
            stop_prep_timer()
            clear_owned_candidate()
            plugin.show_toast("Comparison preparation cancelled")
            return
        end

        if st.ready then
            stop_prep_timer()
            session.file_b_preparing = false
            session.file_b_ready = true
            plugin.show_toast("Alternate track ready for ABX test!")
        elseif not st.preparing then
            -- Audio engine finished preparation and rejected (authoritative mismatch result)
            stop_prep_timer()
            clear_owned_candidate()
            plugin.show_toast("Preparation rejected: sample rate, channels, or frame counts mismatch")
        elseif polls > 300 then
            stop_prep_timer()
            clear_owned_candidate()
            plugin.show_toast("Preparation timed out (5m)")
        end
    end)

    if ok and handle then
        session.prep_timer = handle
    else
        session.prep_timer = nil
        clear_owned_candidate()
        plugin.show_toast("Timer slot limit reached; cannot poll preparation")
    end
end

local function prepare_file_b()
    local ok, reason = validate_primary_track()
    if not ok then
        plugin.show_toast(reason)
        return
    end

    local valid_path, path_err = validate_sd_file_path(session.path_b)
    if not valid_path then
        plugin.show_toast("Invalid Track B: " .. path_err)
        return
    end

    local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
    session.path_a = cur_fmt and cur_fmt.path or (plugin.get_current_track_path and plugin.get_current_track_path())
    session.initial_generation = cur_fmt and cur_fmt.generation or 1

    if not session.path_a then
        plugin.show_toast("No active track path found")
        return
    end

    if not plugin.prepare_ab_switch then
        plugin.show_toast("Player lacks prepare_ab_switch API")
        return
    end

    -- Clear any previous candidate before initiating a new one
    clear_owned_candidate()

    local accepted = plugin.prepare_ab_switch(session.path_b)
    if not accepted then
        session.owned_candidate = false
        session.file_b_ready = false
        session.file_b_preparing = false
        plugin.show_toast("Audio engine rejected comparison preparation")
        show_view("file")
        return
    end

    session.owned_candidate = true
    session.file_b_preparing = true
    session.file_b_ready = false
    plugin.show_toast("Preparing alternate file...")
    start_prep_polling()
    show_view("file")
end

-- Auditioning helpers with session epoch and trial ID guard
local function select_audition(source_letter, ep, tr)
    if not session.active then return false end
    if ep and (ep ~= session.epoch or tr ~= session.current_trial) then
        return false
    end

    local target_key = source_letter
    if source_letter == "x" then
        target_key = session.trial_x
    end

    if session.mode == "file" then
        local ok_ready, err = validate_live_file_readiness()
        if not ok_ready then
            stop_session("Readiness lost (" .. err .. "); ABX session ended.")
            show_view("main")
            return false
        end
        if not plugin.select_ab_source then return false end
        local ok = plugin.select_ab_source(target_key)
        if not ok then
            stop_session("Native switch selection failed; ABX session ended.")
            show_view("main")
            return false
        end
    elseif session.mode == "eq" then
        local ok_play, err_play = validate_live_eq_playback()
        if not ok_play then
            stop_session("Playback invalid (" .. err_play .. "); ABX session ended.")
            show_view("main")
            return false
        end
        local current = plugin.get_eq_state and plugin.get_eq_state()
        if session.last_applied_eq and not eq_states_match(current, session.last_applied_eq) then
            stop_session("External EQ change detected; trial ended to preserve your custom settings.")
            show_view("main")
            return false
        end
        local target_state = (target_key == "a") and session.profile_a_state or session.profile_b_state
        if target_state and plugin.eq_apply_state then
            plugin.eq_apply_state(target_state, { persist = false })
            session.last_applied_eq = plugin.get_eq_state and plugin.get_eq_state()
        end
    else
        stop_session("Invalid session mode; ABX session ended.")
        show_view("main")
        return false
    end

    session.current_audition = source_letter
    return true
end

-- Recording vote on current trial with session epoch and trial ID guard
local function record_vote(guess_letter, ep, tr)
    if not session.active then return end
    if ep ~= session.epoch or tr ~= session.current_trial then
        return
    end
    if session.current_trial > session.total_trials then return end

    -- Validation BEFORE counting vote
    if session.mode == "file" then
        local ok_ready, err = validate_live_file_readiness()
        if not ok_ready then
            stop_session("Readiness lost before vote (" .. err .. "); ABX session ended.")
            show_view("main")
            return
        end
    elseif session.mode == "eq" then
        local ok_play, err_play = validate_live_eq_playback()
        if not ok_play then
            stop_session("Playback invalid before vote (" .. err_play .. "); ABX session ended.")
            show_view("main")
            return
        end
        local current = plugin.get_eq_state and plugin.get_eq_state()
        if session.last_applied_eq and not eq_states_match(current, session.last_applied_eq) then
            stop_session("External EQ change detected before vote; trial ended to preserve your custom settings.")
            show_view("main")
            return
        end
    else
        stop_session("Invalid mode before vote; ABX session ended.")
        show_view("main")
        return
    end

    local is_correct = (guess_letter == session.trial_x)
    session.trial_results[session.current_trial] = is_correct
    if is_correct then
        session.score = session.score + 1
    end

    session.current_trial = session.current_trial + 1

    if session.current_trial <= session.total_trials then
        -- Stable hidden X for next trial (guaranteed no re-roll until next vote)
        session.trial_x = (math.random() < 0.5) and "a" or "b"
        local ok_aud = select_audition("x", session.epoch, session.current_trial)
        if not ok_aud then
            stop_session("Audition failed for next trial; session ended.")
            show_view("main")
            return
        end
        -- Strictly avoid exposing true X in toasts
        plugin.show_toast(string.format("Vote recorded. Starting Trial %d of %d", session.current_trial, session.total_trials))
    else
        -- Trials finished: clean up native context while preserving score display
        session.finished = true
        session.final_score = session.score
        session.final_total = session.total_trials
        session.final_p_val = binomial_p_value(session.score, session.total_trials)
        local pct = (session.score / session.total_trials) * 100

        session.last_mode = session.mode
        session.active = false

        plugin.show_toast(string.format("Test Complete! Score: %d/%d (%.1f%%)", session.final_score, session.final_total, pct))
    end

    show_view("trial")
end

local function restart_session()
    session.epoch = session.epoch + 1

    local mode_to_run = session.mode or session.last_mode
    if mode_to_run == "file" then
        session.mode = "file"
        local ok_ready, err = validate_live_file_readiness()
        if not ok_ready then
            session.mode = nil
            stop_session("Readiness lost (" .. tostring(err) .. "); ABX session ended.")
            show_view("file")
            return
        end
    elseif mode_to_run == "eq" then
        session.mode = "eq"
        local ok_play, err_play = validate_live_eq_playback()
        if not ok_play then
            session.mode = nil
            stop_session("Playback not ready (" .. tostring(err_play) .. "); ABX session ended.")
            show_view("eq")
            return
        end
        local current = plugin.get_eq_state and plugin.get_eq_state()
        if session.last_applied_eq and not eq_states_match(current, session.last_applied_eq) then
            session.mode = nil
            stop_session("External EQ change detected; trial ended to preserve your custom settings.")
            show_view("main")
            return
        end
        if not session.profile_b_state then
            session.mode = nil
            stop_session("Profile B not loaded; cannot restart EQ test.")
            show_view("eq")
            return
        end
    else
        session.mode = nil
        stop_session("No test mode configured; cannot restart.")
        show_view("main")
        return
    end

    session.active = true
    session.finished = false
    session.current_trial = 1
    session.score = 0
    session.trial_results = {}
    session.trial_x = (math.random() < 0.5) and "a" or "b"
    local ok_aud = select_audition("x", session.epoch, session.current_trial)
    if not ok_aud then
        stop_session("Audition failed on restart; session ended.")
        show_view("main")
        return
    end
    plugin.show_toast("ABX Session restarted")
    show_view("trial")
end

-- File Browser utilizing API 16 `replace` for directory and parent navigation.
-- Uses exact top owned handle, allows arbitrarily deep real SD folders (no depth cutoff),
-- enforces strict SD root component comparison, rejects malicious entry names, and caps rows at 500.
local file_browser_handle = nil

local function browse_files(filter_exts, on_pick)
    if not plugin.list_dir or not plugin.show_list then return end
    local sd_top = plugin.sd_root and plugin.sd_root() or "/data/mnt/sd_0"
    file_browser_handle = nil

    local function is_strictly_under_sd(p)
        if type(p) ~= "string" or p == "" then return false end
        if p:find("%.%.") then return false end
        if p == sd_top then return true end
        if p:sub(1, #sd_top) == sd_top and p:sub(#sd_top + 1, #sd_top + 1) == "/" then
            return true
        end
        return false
    end

    local function navigate_to(dir)
        if not is_strictly_under_sd(dir) then
            dir = sd_top
        end

        local entries = plugin.list_dir(dir) or {}
        local folders = {}
        local files = {}

        for i = 1, #entries do
            local e = entries[i]
            local name = e and e.name
            -- Reject malicious entry names: reject slashes, '..', or '.'
            if type(name) == "string" and name ~= "" and name ~= "." and not name:find("/") and not name:find("\\") and not name:find("%.%.") then
                if name:sub(1, 1) ~= "." then
                    if e.dir then
                        folders[#folders + 1] = name
                    else
                        local name_lower = name:lower()
                        for _, ext in ipairs(filter_exts) do
                            if name_lower:sub(-#ext) == ext then
                                files[#files + 1] = name
                                break
                            end
                        end
                    end
                end
            end
        end

        table.sort(folders)
        table.sort(files)

        local rows = {}
        local actions = {}

        -- Parent directory navigation: replaces current list in place using same handle
        if dir ~= sd_top then
            local parent = dir:match("^(.*)/[^/]+$")
            if parent and is_strictly_under_sd(parent) then
                rows[#rows + 1] = "[..] Up to parent"
                actions[#actions + 1] = function()
                    navigate_to(parent)
                end
            end
        end

        -- Subdirectories: arbitrarily deep (no depth cutoff)
        for i = 1, #folders do
            local f_name = folders[i]
            rows[#rows + 1] = "[DIR] " .. f_name
            actions[#actions + 1] = function()
                navigate_to(dir .. "/" .. f_name)
            end
            if #rows >= 500 then break end
        end

        -- Files
        if #rows < 500 then
            for i = 1, #files do
                local fname = files[i]
                rows[#rows + 1] = fname
                actions[#actions + 1] = function()
                    file_browser_handle = nil
                    on_pick(dir .. "/" .. fname)
                end
                if #rows >= 500 then break end
            end
        end

        if #rows == 0 then
            rows[1] = "No matching files in directory"
            actions[1] = function() end
        end

        local opts = { selected = 1 }
        if file_browser_handle then
            opts.replace = file_browser_handle
        end

        local new_h = plugin.show_list("Select File", rows, function(index)
            local act = actions[index]
            if act then act() end
        end, opts)

        if new_h then
            file_browser_handle = new_h
        end
    end

    navigate_to(sd_top)
end

-- Virtual Views for unified Settings Screen (Title: "ABX Blind Test", pool = 1)
local function build_main_view_items()
    return {
        {
            type = "row",
            label = "Audio File ABX Test...",
            on_select = function() show_view("file") end,
        },
        {
            type = "row",
            label = "Equalizer Profile ABX Test...",
            on_select = function() show_view("eq") end,
        },
        {
            type = "row",
            label = string.format("Trials Per Session: %d", session.total_trials),
            on_select = function()
                if session.total_trials == 5 then session.total_trials = 10
                elseif session.total_trials == 10 then session.total_trials = 16
                elseif session.total_trials == 16 then session.total_trials = 20
                else session.total_trials = 5 end
                plugin.show_toast("Trials set to " .. session.total_trials)
                show_view("main")
            end,
        },
        {
            type = "row",
            label = "About ABX Blind Test",
            on_select = function()
                if not plugin.show_list then return end
                plugin.show_list("About ABX Blind Test", {
                    "Blind ABX listener evaluation tool with randomized X.",
                    "In each trial, sample X is randomly assigned to source A or B.",
                    "Audition A, B, and X, then select your vote.",
                    "File mode uses native gapless switching with shared DSP.",
                    "Supports 16-bit FLAC/PCM and matched local MP3 files.",
                    "EQ profile switching cannot guarantee click-free live updates.",
                    "Calculates exact binomial probability (p-value) upon completion.",
                }, function() end)
            end,
        },
    }
end

local function build_file_view_items()
    local cur_track = plugin.get_current_track_path and plugin.get_current_track_path()
    local path_a_disp = cur_track and (cur_track:match("[^/]+$") or cur_track) or "(None Playing)"
    local path_b_disp = session.path_b and (session.path_b:match("[^/]+$") or session.path_b) or "(Not Selected)"

    local status_str = "Status: Idle"
    if session.file_b_preparing then
        status_str = "Status: Preparing... (Tap to Cancel)"
    elseif session.file_b_ready then
        status_str = "Status: Ready (Matched)"
    end

    local items = {
        {
            type = "row",
            label = "< Back to Main Menu",
            on_select = function() show_view("main") end,
        },
        {
            type = "row",
            label = "Track A: " .. path_a_disp,
            on_select = function() plugin.show_toast("Track A: " .. (cur_track or "None")) end,
        },
        {
            type = "row",
            label = "Track B: " .. path_b_disp,
            on_select = function()
                browse_files({ ".flac", ".wav", ".aiff", ".caf", ".mp3" }, function(picked_path)
                    session.path_b = picked_path
                    clear_owned_candidate()
                    plugin.show_toast("Selected: " .. (picked_path:match("[^/]+$") or picked_path))
                    prepare_file_b()
                end)
            end,
        },
        {
            type = "row",
            label = "Select Track B (File Browser)...",
            on_select = function()
                browse_files({ ".flac", ".wav", ".aiff", ".caf", ".mp3" }, function(picked_path)
                    session.path_b = picked_path
                    clear_owned_candidate()
                    plugin.show_toast("Selected: " .. (picked_path:match("[^/]+$") or picked_path))
                    show_view("file")
                end)
            end,
        },
        {
            type = "row",
            label = "Enter Track B Path (Text)...",
            on_select = function()
                if not plugin.show_text_input then return end
                plugin.show_text_input("Enter Track B Path", session.path_b or "", false, function(txt)
                    if txt and txt ~= "" then
                        local valid, err = validate_sd_file_path(txt)
                        if not valid then
                            plugin.show_toast("Invalid path: " .. err)
                            return
                        end
                        session.path_b = txt
                        clear_owned_candidate()
                        show_view("file")
                    end
                end)
            end,
        },
        {
            type = "row",
            label = "Prepare Comparison",
            on_select = prepare_file_b,
        },
        {
            type = "row",
            label = status_str,
            on_select = function()
                if session.file_b_preparing then
                    clear_owned_candidate()
                    plugin.show_toast("Comparison preparation cancelled")
                    show_view("file")
                else
                    plugin.show_toast(status_str)
                end
            end,
        },
    }

    if session.file_b_preparing then
        items[#items + 1] = {
            type = "row",
            label = "Cancel Preparation",
            on_select = function()
                clear_owned_candidate()
                plugin.show_toast("Comparison preparation cancelled")
                show_view("file")
            end,
        }
    end

    items[#items + 1] = {
        type = "row",
        label = "Start ABX File Test",
        on_select = function()
            local st = plugin.get_ab_switch and plugin.get_ab_switch()
            if st and st.ready then
                session.file_b_ready = true
                session.file_b_preparing = false
            end
            if not session.file_b_ready then
                plugin.show_toast("Track B is not ready yet")
                show_view("file")
                return
            end
            local ok, reason = validate_primary_track()
            if not ok then plugin.show_toast(reason) return end
            local ok_ready, err = validate_live_file_readiness()
            if not ok_ready then plugin.show_toast("Not ready: " .. err) return end

            session.epoch = session.epoch + 1
            session.active = true
            session.finished = false
            session.mode = "file"
            session.last_mode = "file"
            session.current_trial = 1
            session.score = 0
            session.trial_results = {}
            session.trial_x = (math.random() < 0.5) and "a" or "b"
            local ok_aud = select_audition("x", session.epoch, session.current_trial)
            if not ok_aud then
                stop_session("Audition failed on start")
                show_view("file")
                return
            end
            show_view("trial")
        end,
    }

    items[#items + 1] = {
        type = "row",
        label = "Clear Comparison",
        on_select = function()
            clear_owned_candidate()
            plugin.show_toast("Comparison cleared")
            show_view("file")
        end,
    }

    return items
end

local function build_eq_view_items()
    return {
        {
            type = "row",
            label = "< Back to Main Menu",
            on_select = function() show_view("main") end,
        },
        {
            type = "row",
            label = "Notice: PEQ updates are not click-free",
            on_select = function()
                plugin.show_toast("PEQ profile coefficient updates cannot guarantee click-free switching.")
            end,
        },
        {
            type = "row",
            label = "Profile A: " .. session.profile_a_name,
            on_select = function() plugin.show_toast("Profile A: " .. session.profile_a_name) end,
        },
        {
            type = "row",
            label = "Profile B: " .. session.profile_b_name,
            on_select = function() plugin.show_toast("Profile B: " .. session.profile_b_name) end,
        },
        {
            type = "row",
            label = "Use Current EQ as Profile A",
            on_select = function()
                if plugin.get_eq_state then
                    session.profile_a_state = plugin.get_eq_state()
                    session.profile_a_name = "Current Snapshot"
                    plugin.show_toast("Captured Current EQ as Profile A")
                    show_view("eq")
                end
            end,
        },
        {
            type = "row",
            label = "Load .peq for Profile B...",
            on_select = function()
                browse_files({ ".peq" }, function(path)
                    local valid, err = validate_sd_file_path(path)
                    if not valid then
                        plugin.show_toast("Invalid Profile Path: " .. err)
                        return
                    end
                    if plugin.eq_apply_profile and plugin.get_eq_state and plugin.eq_apply_state then
                        local temp_base = plugin.get_eq_state()
                        local ok = plugin.eq_apply_profile(path, { persist = false })
                        if ok then
                            session.profile_b_state = plugin.get_eq_state()
                            session.profile_b_name = path:match("[^/]+$") or path
                            session.profile_b_path = path
                            plugin.eq_apply_state(temp_base, { persist = false })
                            plugin.show_toast("Loaded " .. session.profile_b_name .. " transiently")
                        else
                            plugin.show_toast("Failed to load .peq profile")
                        end
                    end
                    show_view("eq")
                end)
            end,
        },
        {
            type = "row",
            label = "Start ABX EQ Test",
            on_select = function()
                if not plugin.has_capability or not plugin.has_capability("audio.peq.state") then
                    plugin.show_toast("Player lacks audio.peq.state capability")
                    return
                end
                if not plugin.get_eq_state then
                    plugin.show_toast("EQ state query unavailable")
                    return
                end

                local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
                session.path_a = cur_fmt and cur_fmt.path or (plugin.get_current_track_path and plugin.get_current_track_path())
                session.initial_generation = cur_fmt and cur_fmt.generation or 1

                local ok_play, err_play = validate_live_eq_playback()
                if not ok_play then
                    plugin.show_toast("Playback not ready: " .. err_play)
                    return
                end

                session.baseline_eq = plugin.get_eq_state()
                if not session.baseline_eq then
                    plugin.show_toast("Could not read baseline EQ")
                    return
                end

                if not session.profile_a_state then
                    session.profile_a_state = session.baseline_eq
                    session.profile_a_name = "Baseline EQ"
                end

                if not session.profile_b_state then
                    plugin.show_toast("Please load Profile B first")
                    return
                end

                session.epoch = session.epoch + 1
                session.active = true
                session.finished = false
                session.mode = "eq"
                session.last_mode = "eq"
                session.current_trial = 1
                session.score = 0
                session.trial_results = {}
                session.last_applied_eq = session.baseline_eq
                session.trial_x = (math.random() < 0.5) and "a" or "b"

                local ok_aud = select_audition("x", session.epoch, session.current_trial)
                if not ok_aud then
                    stop_session("Audition failed on start")
                    show_view("eq")
                    return
                end
                show_view("trial")
            end,
        },
        {
            type = "row",
            label = "About EQ Comparisons",
            on_select = function()
                if not plugin.show_list then return end
                plugin.show_list("About EQ ABX Test", {
                    "Loads .peq profiles transiently (without flash persistence).",
                    "Hardware limitation: EQ updates cannot guarantee click-free switching.",
                    "Restores runtime baseline EQ upon test completion or cancellation.",
                    "If external EQ controls are touched during a trial, the session suspends to preserve your adjustments.",
                    "Tone adjustments are not loudness-matched or bit-perfect.",
                }, function() end)
            end,
        },
    }
end

local function build_trial_view_items()
    local is_finished = session.finished or (session.current_trial > session.total_trials)
    local items = {}

    local ep = session.epoch
    local tr = session.current_trial

    if not is_finished then
        local trial_str = string.format("Trial %d of %d", session.current_trial, session.total_trials)
        items[#items + 1] = {
            type = "row",
            label = trial_str,
            on_select = function() plugin.show_toast(trial_str) end,
        }

        local aud_a_label = (session.current_audition == "a") and "[*] Sample A" or "Sample A"
        local aud_b_label = (session.current_audition == "b") and "[*] Sample B" or "Sample B"
        local aud_x_label = (session.current_audition == "x") and "[*] Sample X (Hidden)" or "Sample X (Hidden)"

        items[#items + 1] = {
            type = "row",
            label = aud_a_label,
            on_select = function()
                if select_audition("a", ep, tr) then
                    plugin.show_toast("Auditioning Sample A")
                    show_view("trial")
                end
            end,
        }
        items[#items + 1] = {
            type = "row",
            label = aud_b_label,
            on_select = function()
                if select_audition("b", ep, tr) then
                    plugin.show_toast("Auditioning Sample B")
                    show_view("trial")
                end
            end,
        }
        items[#items + 1] = {
            type = "row",
            label = aud_x_label,
            on_select = function()
                if select_audition("x", ep, tr) then
                    plugin.show_toast("Auditioning Sample X")
                    show_view("trial")
                end
            end,
        }

        items[#items + 1] = {
            type = "row",
            label = "Vote: X is A",
            on_select = function() record_vote("a", ep, tr) end,
        }
        items[#items + 1] = {
            type = "row",
            label = "Vote: X is B",
            on_select = function() record_vote("b", ep, tr) end,
        }
    else
        local p_val = session.final_p_val or binomial_p_value(session.score, session.total_trials)
        local score = session.final_score or session.score
        local total = session.final_total or session.total_trials
        local pct = (total > 0) and ((score / total) * 100) or 0
        local res_str = string.format("Final Score: %d/%d (%.1f%%)", score, total, pct)
        local p_str = string.format("p-value: %.4f (%s)", p_val, (p_val < 0.05) and "Significant" or "Inconclusive")

        items[#items + 1] = {
            type = "row",
            label = res_str,
            on_select = function() plugin.show_toast(res_str) end,
        }
        items[#items + 1] = {
            type = "row",
            label = p_str,
            on_select = function() plugin.show_toast(p_str) end,
        }
    end

    items[#items + 1] = {
        type = "row",
        label = "Restart Test",
        on_select = restart_session,
    }

    items[#items + 1] = {
        type = "row",
        label = "Exit ABX Session",
        on_select = function()
            session.finished = false
            stop_session("ABX Session ended")
            show_view("main")
        end,
    }

    return items
end

show_view = function(view_name)
    session.current_view = view_name or session.current_view or "main"
    if not plugin.show_settings_list then return end

    local items
    if session.current_view == "file" then
        items = build_file_view_items()
    elseif session.current_view == "eq" then
        items = build_eq_view_items()
    elseif session.current_view == "trial" then
        if not session.active and not session.finished then
            session.current_view = "main"
            items = build_main_view_items()
        else
            items = build_trial_view_items()
        end
    else
        session.current_view = "main"
        items = build_main_view_items()
    end

    -- Uses title "ABX Blind Test" and update = true across all virtual views.
    -- This guarantees exactly one settings screen slot is consumed and refreshed in place.
    plugin.show_settings_list("ABX Blind Test", items, { update = true })
end

-- Playback interruption handling:
-- Both file mode and EQ mode stop on pause/stop/track changes.
-- Does NOT automatically reopen or pop up the settings menu from events.
if plugin.on then
    local function on_playback_interrupted()
        if session.active then
            stop_session("Playback interrupted; ABX session ended.")
        else
            clear_owned_candidate()
        end
    end
    plugin.on("paused", on_playback_interrupted)
    plugin.on("stopped", on_playback_interrupted)
    plugin.on("track_started", on_playback_interrupted)
end

if plugin.register_list_item then
    plugin.register_list_item("playback", "ABX Blind Test", function()
        if session.active or session.finished then
            show_view("trial")
        else
            show_view("main")
        end
    end)
end
