-- Comprehensive test suite for Track Inspector plugin (Compas Plugin API 16)
local harness = require("harness")

local function build_wav_fixture(path, opts)
    opts = opts or {}
    local sample_rate = opts.sample_rate or 44100
    local channels = opts.channels or 2
    local bit_depth = opts.bit_depth or 16
    local format_code = opts.format_code or 1 -- 1 = PCM integer, 3 = float, 2 = ADPCM
    local num_frames = opts.num_frames or 44100 -- 1 second
    local block_align = channels * (bit_depth // 8)
    local byte_rate = sample_rate * block_align
    local data_bytes = num_frames * block_align

    local f = assert(io.open(path, "wb"))
    local file_size = 36 + data_bytes
    f:write("RIFF")
    f:write(string.char(file_size & 0xFF, (file_size >> 8) & 0xFF, (file_size >> 16) & 0xFF, (file_size >> 24) & 0xFF))
    f:write("WAVE")

    -- fmt chunk
    f:write("fmt ")
    local fmt_size = 16
    f:write(string.char(fmt_size & 0xFF, 0, 0, 0))
    f:write(string.char(format_code & 0xFF, (format_code >> 8) & 0xFF))
    f:write(string.char(channels & 0xFF, (channels >> 8) & 0xFF))
    f:write(string.char(sample_rate & 0xFF, (sample_rate >> 8) & 0xFF, (sample_rate >> 16) & 0xFF, (sample_rate >> 24) & 0xFF))
    f:write(string.char(byte_rate & 0xFF, (byte_rate >> 8) & 0xFF, (byte_rate >> 16) & 0xFF, (byte_rate >> 24) & 0xFF))
    f:write(string.char(block_align & 0xFF, (block_align >> 8) & 0xFF))
    f:write(string.char(bit_depth & 0xFF, (bit_depth >> 8) & 0xFF))

    -- data chunk
    f:write("data")
    f:write(string.char(data_bytes & 0xFF, (data_bytes >> 8) & 0xFF, (data_bytes >> 16) & 0xFF, (data_bytes >> 24) & 0xFF))
    f:write(string.rep("\0", math.min(data_bytes, 128)))
    f:close()
end

local function build_flac_fixture(path, opts)
    opts = opts or {}
    local sample_rate = opts.sample_rate or 44100
    local channels = opts.channels or 2
    local bit_depth = opts.bit_depth or 16
    local total_samples = opts.total_samples or 88200 -- 2 seconds at 44.1k

    local f = assert(io.open(path, "wb"))
    f:write("fLaC")
    f:write(string.char(0x80, 0x00, 0x00, 0x22))
    f:write(string.char(0x10, 0x00, 0x10, 0x00))
    f:write(string.char(0x00, 0x00, 0x00, 0x00, 0x00, 0x00))

    local ch_val = channels - 1
    local bp_val = bit_depth - 1

    local b1 = (sample_rate >> 12) & 0xFF
    local b2 = (sample_rate >> 4) & 0xFF
    local b3 = ((sample_rate & 0x0F) << 4) | ((ch_val & 0x07) << 1) | ((bp_val >> 4) & 0x01)
    local b4 = ((bp_val & 0x0F) << 4) | ((total_samples >> 32) & 0x0F)
    local b5 = (total_samples >> 24) & 0xFF
    local b6 = (total_samples >> 16) & 0xFF
    local b7 = (total_samples >> 8) & 0xFF
    local b8 = total_samples & 0xFF
    f:write(string.char(b1, b2, b3, b4, b5, b6, b7, b8))

    f:write(string.rep("\0", 16))
    f:write(string.rep("FLAC_AUDIO_FRAME_DATA", 100))
    f:close()
end

local function build_aiff_fixture(path, opts)
    opts = opts or {}
    local sample_rate = opts.sample_rate or 44100
    local channels = opts.channels or 2
    local bit_depth = opts.bit_depth or 16
    local num_frames = opts.num_frames or 44100
    local is_aifc = opts.is_aifc or false
    local compression_type = opts.compression_type or "NONE"

    local f = assert(io.open(path, "wb"))
    f:write("FORM")
    local form_size = is_aifc and 50 or 46
    f:write(string.char((form_size >> 24) & 0xFF, (form_size >> 16) & 0xFF, (form_size >> 8) & 0xFF, form_size & 0xFF))
    f:write(is_aifc and "AIFC" or "AIFF")

    -- COMM chunk
    f:write("COMM")
    local comm_size = is_aifc and 22 or 18
    f:write(string.char(0, 0, 0, comm_size))
    f:write(string.char((channels >> 8) & 0xFF, channels & 0xFF))
    f:write(string.char((num_frames >> 24) & 0xFF, (num_frames >> 16) & 0xFF, (num_frames >> 8) & 0xFF, num_frames & 0xFF))
    f:write(string.char((bit_depth >> 8) & 0xFF, bit_depth & 0xFF))

    -- 80-bit IEEE 754 extended float for sample_rate
    if sample_rate == 44100 then
        f:write(string.char(0x40, 0x0E, 0xAC, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00))
    elseif sample_rate == 96000 then
        f:write(string.char(0x40, 0x0F, 0xBB, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00))
    else
        f:write(string.char(0x40, 0x0E, 0xAC, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00))
    end

    if is_aifc then
        f:write(compression_type:sub(1, 4))
    end

    f:write("SSND")
    local ssnd_size = 16
    f:write(string.char(0, 0, 0, ssnd_size))
    f:write(string.char(0, 0, 0, 0, 0, 0, 0, 0))
    f:write(string.rep("\0", 8))
    f:close()
end

return function(assert_eq, assert_true, assert_false)
    local test_dir = "/tmp/track_inspector_test_env_" .. tostring(os.time())
    os.execute("mkdir -p '" .. test_dir .. "'")

    local wav16_path = test_dir .. "/track1.wav"
    local wav_float_path = test_dir .. "/track_float.wav"
    local wav_adpcm_path = test_dir .. "/track_adpcm.wav"
    local flac16_path = test_dir .. "/song1.flac"
    local aiff16_path = test_dir .. "/classic.aiff"
    local aifc_ima4_path = test_dir .. "/compressed.aifc"
    local aifc_fl32_path = test_dir .. "/float.aifc"
    local mp3_dummy_path = test_dir .. "/song.mp3"
    local truncated_path = test_dir .. "/truncated.wav"

    build_wav_fixture(wav16_path, { sample_rate = 44100, channels = 2, bit_depth = 16, format_code = 1 })
    build_wav_fixture(wav_float_path, { sample_rate = 48000, channels = 2, bit_depth = 32, format_code = 3 })
    build_wav_fixture(wav_adpcm_path, { sample_rate = 22050, channels = 1, bit_depth = 4, format_code = 2 })
    build_flac_fixture(flac16_path, { sample_rate = 44100, channels = 2, bit_depth = 16, total_samples = 88200 })
    build_aiff_fixture(aiff16_path, { sample_rate = 44100, channels = 2, bit_depth = 16 })
    build_aiff_fixture(aifc_ima4_path, { sample_rate = 44100, channels = 2, bit_depth = 16, is_aifc = true, compression_type = "ima4" })
    build_aiff_fixture(aifc_fl32_path, { sample_rate = 44100, channels = 2, bit_depth = 32, is_aifc = true, compression_type = "fl32" })

    local f_mp3 = assert(io.open(mp3_dummy_path, "wb"))
    f_mp3:write("ID3\x04\x00\x00\x00\x00\x00\x0A\xFF\xFB\x90\x64\x00\x00\x00")
    f_mp3:close()

    local f_trunc = assert(io.open(truncated_path, "wb"))
    f_trunc:write("RIFF\x10")
    f_trunc:close()

    ----------------------------------------------------------------------------
    -- Test 1: Plugin Definition & Strict Event Validation
    ----------------------------------------------------------------------------
    do
        local h = harness.new({ sd_root = test_dir })

        local ok_bad, err_bad = pcall(function()
            h.plugin.on("shutdown", function() end)
        end)
        assert_false(ok_bad, "Harness strictly rejects invalid event 'shutdown'")
        assert_true(err_bad:find("unknown event 'shutdown'") ~= nil, "Error indicates unknown event")

        local M = h.load("plugins/TrackInspector/TrackInspector.lua")
        assert_true(h.defined ~= nil, "Plugin called plugin.define")
        assert_eq(h.defined.id, "compas.track_inspector", "Plugin stable ID")
        assert_eq(h.defined.name, "Track Inspector", "Plugin name")
        assert_eq(h.defined.version, "1.1", "Plugin version v1.1")
        assert_eq(h.defined.api_min, 16, "Plugin api_min 16")
        assert_eq(h.count_active_intervals(), 0, "No timers allocated anywhere in plugin")
    end

    ----------------------------------------------------------------------------
    -- Test 2: In-Place Replacement (ui.list_update replace option) & Stack Stability
    ----------------------------------------------------------------------------
    do
        local h = harness.new({
            sd_root = test_dir,
            format_snapshot = {
                path = test_dir .. "/track1.wav",
                codec = "pcm",
                sample_rate = 44100,
                bit_depth = 16,
                output_sample_rate = 44100,
                output_bit_depth = 16,
                channels = 2,
                bitrate_kbps = 1411,
                duration_seconds = 60,
                software_volume_gain = 1.0,
                playback_speed = 1.0,
            },
            output_info = { route = "wired", active = true, sample_rate = 44100, bit_depth = 16 },
            eq_state = { bypass = true, preamp_db = 0, stereo_width = 1.0, bands = {} },
        })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        -- Open main menu (depth 1)
        h.registered_list_items[1].on_open()
        assert_eq(#h.screen_stack, 1, "Main menu at stack depth 1")

        -- Open format screen (depth 2)
        h.screen_stack[1].on_select(1)
        assert_eq(#h.screen_stack, 2, "Format screen at stack depth 2")
        local handle_before = h.screen_stack[2].handle

        -- Tap Refresh row (index 1) repeatedly 10 times
        for i = 1, 10 do
            local current_screen = h.screen_stack[2]
            current_screen.on_select(1)
            assert_eq(#h.screen_stack, 2, "Stack depth strictly stays 2 across repeated refreshes (" .. i .. ")")
            assert_true(h.screen_stack[2].handle ~= handle_before, "Handle is refreshed in place")
            handle_before = h.screen_stack[2].handle
        end

        -- Stale handle replacement returns nil
        local stale_res = h.plugin.show_list("Stale Test", { "Row" }, function() end, { replace = 99999 })
        assert_true(stale_res == nil, "Stale or non-top handle replacement returns nil")
    end

    ----------------------------------------------------------------------------
    -- Test 3: Folder Browser Virtual Navigation & SD Root Confinement
    ----------------------------------------------------------------------------
    do
        local h = harness.new({
            sd_root = test_dir,
            dirs = {
                [test_dir] = {
                    { name = "Albums", dir = true },
                    { name = "track1.wav", dir = false },
                },
                [test_dir .. "/Albums"] = {
                    { name = "Rock", dir = true },
                    { name = "song.flac", dir = false },
                },
                [test_dir .. "/Albums/Rock"] = {
                    { name = "hit.wav", dir = false },
                },
            },
        })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        -- Path traversal checks
        assert_true(M.is_within_sd(test_dir, test_dir), "Root is within SD")
        assert_true(M.is_within_sd(test_dir .. "/Albums", test_dir), "Subdir is within SD")
        assert_false(M.is_within_sd("/etc/passwd", test_dir), "Outside root rejected")
        assert_false(M.is_within_sd(test_dir .. "/../etc/passwd", test_dir), "Traversal path rejected")
        assert_false(M.is_within_sd("http://remote.com/file", test_dir), "Remote URL rejected")

        -- Open file inspector from main menu (stack depth 2)
        h.registered_list_items[1].on_open()
        h.screen_stack[1].on_select(5)
        assert_eq(#h.screen_stack, 2, "File browser at stack depth 2")

        -- Navigate into Albums: replaces in place at depth 2!
        local browser_screen = h.screen_stack[2]
        local albums_idx = nil
        for idx, item in ipairs(browser_screen.items) do
            if item.label:find("Albums") then albums_idx = idx break end
        end
        assert_true(albums_idx ~= nil, "Found Albums directory row")
        browser_screen.on_select(albums_idx)
        assert_eq(#h.screen_stack, 2, "Entering subdir replaces browser in-place (depth remains 2)")

        -- Navigate into Rock: replaces in place at depth 2!
        browser_screen = h.screen_stack[2]
        local rock_idx = nil
        for idx, item in ipairs(browser_screen.items) do
            if item.label:find("Rock") then rock_idx = idx break end
        end
        assert_true(rock_idx ~= nil, "Found Rock directory row")
        browser_screen.on_select(rock_idx)
        assert_eq(#h.screen_stack, 2, "Deep folder navigation maintains depth 2")

        -- Tap Parent Folder: navigates back in place at depth 2!
        browser_screen = h.screen_stack[2]
        assert_eq(browser_screen.items[1].label, ".. (Parent Folder)", "Parent folder row present")
        browser_screen.on_select(1)
        assert_eq(#h.screen_stack, 2, "Parent navigation maintains depth 2")
        assert_true(h.screen_stack[2].title:find("Albums") ~= nil, "Navigated back to Albums in place")

        -- Tap a file row: pushes details screen at depth 3 <= 4!
        browser_screen = h.screen_stack[2]
        local file_idx = nil
        for idx, item in ipairs(browser_screen.items) do
            if item.label:find("song.flac") then file_idx = idx break end
        end
        assert_true(file_idx ~= nil, "Found song.flac row")
        browser_screen.on_select(file_idx)
        assert_eq(#h.screen_stack, 3, "File details screen pushes to depth 3 <= 4")

        -- Pop details -> returns to folder browser (depth 2)
        h.pop_screen()
        assert_eq(#h.screen_stack, 2, "Popping details returns to folder browser at depth 2")

        -- Pop browser -> returns to main menu (depth 1)
        h.pop_screen()
        assert_eq(#h.screen_stack, 1, "Popping browser returns to main menu at depth 1")
    end

    ----------------------------------------------------------------------------
    -- Test 4: Compressed & Float Formats in WAV and AIFF
    ----------------------------------------------------------------------------
    do
        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        -- WAV PCM Integer (format 1)
        local res_pcm = M.parse_local_file_header(wav16_path)
        assert_eq(res_pcm.codec, "pcm", "WAV PCM integer codec")
        assert_eq(res_pcm.format_name, "WAV (PCM Integer)", "WAV PCM integer name")
        assert_false(res_pcm.is_compressed, "WAV PCM is not compressed")

        -- WAV IEEE Float (format 3)
        local res_float = M.parse_local_file_header(wav_float_path)
        assert_eq(res_float.codec, "wav_float", "WAV Float codec wav_float")
        assert_eq(res_float.format_name, "WAV (IEEE Float)", "WAV IEEE Float format name")
        assert_false(res_float.is_compressed, "WAV Float not compressed")

        -- WAV ADPCM Compressed (format 2): must NOT label as PCM!
        local res_adpcm = M.parse_local_file_header(wav_adpcm_path)
        assert_eq(res_adpcm.codec, "wav_compressed", "WAV ADPCM labeled wav_compressed")
        assert_true(res_adpcm.is_compressed, "WAV ADPCM is compressed")
        assert_false(res_adpcm.codec == "pcm", "WAV ADPCM never labeled pcm")

        -- AIFC Compressed ("ima4"): must NOT label as PCM!
        local res_ima4 = M.parse_local_file_header(aifc_ima4_path)
        assert_eq(res_ima4.codec, "aifc_compressed", "AIFC ima4 labeled aifc_compressed")
        assert_true(res_ima4.is_compressed, "AIFC ima4 flagged as compressed")
        assert_false(res_ima4.codec == "pcm", "AIFC ima4 never labeled pcm")

        -- AIFC Float ("fl32")
        local res_fl32 = M.parse_local_file_header(aifc_fl32_path)
        assert_eq(res_fl32.codec, "aifc_float", "AIFC fl32 labeled aifc_float")
        assert_false(res_fl32.is_compressed, "AIFC float uncompressed")
    end

    ----------------------------------------------------------------------------
    -- Test 5: Strict Numerical Tolerance (1e-6) and Non-Unity Gains
    ----------------------------------------------------------------------------
    do
        local base_fmt = {
            path = test_dir .. "/clean.flac",
            codec = "flac",
            sample_rate = 44100,
            bit_depth = 16,
            output_sample_rate = 44100,
            output_bit_depth = 16,
            channels = 2,
            software_volume_gain = 1.0,
            playback_speed = 1.0,
            replaygain_applied = false,
        }
        local out = {
            route = "wired",
            active = true,
            sample_rate = 44100,
            bit_depth = 16,
            hardware_sample_rate = 44100,
            hardware_bit_depth = 16,
            resampling = false,
            resampling_known = true,
        }
        local eq = { bypass = true }

        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        -- Small non-unity software volume (gain = 1.0001, diff 1e-4 > 1e-6)
        local fmt_small_vol = setmetatable({ software_volume_gain = 1.0001 }, { __index = base_fmt })
        local assess_vol = M.assess_bit_perfect(fmt_small_vol, out, eq)
        assert_false(assess_vol.is_candidate, "Small gain 1.0001 flagged as non-unity modification")
        assert_true(assess_vol.reasons[1]:find("Software volume") ~= nil, "Reason contains software volume scaling")

        -- Small non-unity gain (gain = 0.9999)
        local fmt_low_vol = setmetatable({ software_volume_gain = 0.9999 }, { __index = base_fmt })
        local assess_low = M.assess_bit_perfect(fmt_low_vol, out, eq)
        assert_false(assess_low.is_candidate, "Small attenuation 0.9999 flagged")

        -- Small speed difference (speed = 1.0001)
        local fmt_small_spd = setmetatable({ playback_speed = 1.0001 }, { __index = base_fmt })
        local assess_spd = M.assess_bit_perfect(fmt_small_spd, out, eq)
        assert_false(assess_spd.is_candidate, "Small speed 1.0001 flagged")

        -- Small preamp difference (preamp = 0.0001 dB with bypass=false)
        local eq_small_preamp = { bypass = false, preamp_db = 0.0001, stereo_width = 1.0, bands = {} }
        local assess_preamp = M.assess_bit_perfect(base_fmt, out, eq_small_preamp)
        assert_false(assess_preamp.is_candidate, "Small preamp 0.0001 dB flagged")

        -- Small stereo width difference (width = 1.0001 with bypass=false)
        local eq_small_width = { bypass = false, preamp_db = 0.0, stereo_width = 1.0001, bands = {} }
        local assess_width = M.assess_bit_perfect(base_fmt, out, eq_small_width)
        assert_false(assess_width.is_candidate, "Small stereo width 1.0001 flagged")
    end

    ----------------------------------------------------------------------------
    -- Test 6: Unknown, Missing, and Non-Finite Fields Disqualification
    ----------------------------------------------------------------------------
    do
        local base_fmt = {
            path = test_dir .. "/clean.flac",
            codec = "flac",
            sample_rate = 44100,
            bit_depth = 16,
            output_sample_rate = 44100,
            output_bit_depth = 16,
            channels = 2,
            software_volume_gain = 1.0,
            playback_speed = 1.0,
            replaygain_applied = false,
        }
        local out = { route = "wired", active = true, sample_rate = 44100, bit_depth = 16, hardware_sample_rate = 44100, hardware_bit_depth = 16, resampling = false, resampling_known = true }
        local eq = { bypass = true }

        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        -- Unknown codec
        local fmt_no_codec = setmetatable({ codec = "unknown" }, { __index = base_fmt })
        assert_false(M.assess_bit_perfect(fmt_no_codec, out, eq).is_candidate, "Unknown codec disqualified")

        local hybrid_fmt = setmetatable({ codec = "wavpack" }, { __index = base_fmt })
        assert_false(M.assess_bit_perfect(hybrid_fmt, out, eq).is_candidate, "Unreported WavPack hybrid mode cannot certify lossless source")
        local fmt_24 = setmetatable({ bit_depth = 24, output_bit_depth = 24 }, { __index = base_fmt })
        assert_false(M.assess_bit_perfect(fmt_24, out, eq).is_candidate, "Driver 16-bit sink rejects matching 24-bit source and engine candidate")

        -- Missing bit depth
        local fmt_no_depth = setmetatable({ bit_depth = 0 }, { __index = base_fmt })
        assert_false(M.assess_bit_perfect(fmt_no_depth, out, eq).is_candidate, "Zero bit depth disqualified")

        -- Missing channels
        local fmt_no_ch = setmetatable({ channels = 0 }, { __index = base_fmt })
        assert_false(M.assess_bit_perfect(fmt_no_ch, out, eq).is_candidate, "Zero channels disqualified")

        -- Non-finite NaN software volume
        local nan = 0.0 / 0.0
        local fmt_nan_vol = setmetatable({ software_volume_gain = nan }, { __index = base_fmt })
        assert_false(M.assess_bit_perfect(fmt_nan_vol, out, eq).is_candidate, "NaN software volume disqualified")

        -- Infinite speed
        local inf = math.huge
        local fmt_inf_spd = setmetatable({ playback_speed = inf }, { __index = base_fmt })
        assert_false(M.assess_bit_perfect(fmt_inf_spd, out, eq).is_candidate, "Infinite playback speed disqualified")
    end

    ----------------------------------------------------------------------------
    -- Test 7: True DoP Requirements vs DSD-to-PCM
    ----------------------------------------------------------------------------
    do
        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        -- True DoP valid
        local true_dop_fmt = {
            path = "/sd/dsd.dsf",
            codec = "dsd",
            sample_rate = 2822400,
            bit_depth = 1,
            output_sample_rate = 176400,
            output_bit_depth = 24,
            channels = 2,
            is_dsd = true,
            dop = true,
            software_volume_gain = 1.0,
            playback_speed = 1.0,
        }
        local true_dop_out = {
            route = "wired",
            active = true,
            dop = true,
            sample_rate = 176400,
            bit_depth = 24,
            hardware_sample_rate = 176400,
            hardware_bit_depth = 24,
            resampling = false,
            resampling_known = true,
        }
        local assess_dop = M.assess_bit_perfect(true_dop_fmt, true_dop_out, { bypass = true })
        assert_true(assess_dop.is_candidate, "True DoP is candidate")
        assert_eq(assess_dop.status, "Bit-Perfect DoP Candidate (Wired)", "DoP candidate status")

        -- DoP with carrier mismatch (e.g. carrier 44100 instead of 176400)
        local mismatch_dop_fmt = setmetatable({ output_sample_rate = 44100 }, { __index = true_dop_fmt })
        local assess_mismatch = M.assess_bit_perfect(mismatch_dop_fmt, true_dop_out, { bypass = true })
        assert_false(assess_mismatch.is_candidate, "DoP with carrier rate mismatch disqualified")

        -- DoP with insufficient bit depth (16-bit instead of >= 24)
        local low_depth_dop = setmetatable({ output_bit_depth = 16 }, { __index = true_dop_fmt })
        local assess_low_d = M.assess_bit_perfect(low_depth_dop, true_dop_out, { bypass = true })
        assert_false(assess_low_d.is_candidate, "DoP with 16-bit depth disqualified")

        -- DSD-to-PCM decimation
        local dsd_pcm_fmt = setmetatable({ dop = false }, { __index = true_dop_fmt })
        local assess_decimation = M.assess_bit_perfect(dsd_pcm_fmt, true_dop_out, { bypass = true })
        assert_false(assess_decimation.is_candidate, "DSD converted to PCM disqualified from direct DSD passthrough")
    end

    ----------------------------------------------------------------------------
    -- Test 8: Secret URLs & Path Sanitization (Zero Token/Password Leaks)
    ----------------------------------------------------------------------------
    do
        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        assert_true(M.is_remote_url("http://media.local/song.flac"), "HTTP is remote URL")
        assert_true(M.is_remote_url("https://media.local/song.flac"), "HTTPS is remote URL")
        assert_false(M.is_remote_url("/sd/music/song.flac"), "Local SD path is not remote")

        local secret_url = "http://alice:supersecret@media.local:8096/audio/12345/stream.flac?api_key=SECRET_TOKEN_XYZ&session=abc#start=10"
        local sanitized = M.sanitize_path(secret_url)
        assert_false(sanitized:find("alice"), "Sanitized URL strips username")
        assert_false(sanitized:find("supersecret"), "Sanitized URL strips password")
        assert_false(sanitized:find("SECRET_TOKEN"), "Sanitized URL strips query api_key")
        assert_false(sanitized:find("start=10"), "Sanitized URL strips fragment")
        assert_eq(sanitized, "http://media.local:8096/audio/12345/stream.flac", "Sanitized path preserves safe scheme host and path")

        local safe_short = M.safe_display_path(secret_url, false)
        assert_eq(safe_short, "stream.flac", "Short display shows only safe basename without query/credentials")

        local safe_full = M.safe_display_path(secret_url, true)
        assert_eq(safe_full, "http://media.local:8096/audio/12345/stream.flac", "Full display shows sanitized URL without secrets")
    end

    ----------------------------------------------------------------------------
    -- Test 9: Configured EQ with DoP vs DSD-to-PCM Decimation
    ----------------------------------------------------------------------------
    do
        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        local dop_fmt = {
            path = "/sd/test.dsf",
            codec = "dsd",
            sample_rate = 2822400,
            bit_depth = 1,
            output_sample_rate = 176400,
            output_bit_depth = 24,
            channels = 2,
            is_dsd = true,
            dop = true,
            software_volume_gain = 0.8, -- software volume configured, but bypassed in DoP!
            playback_speed = 1.0,
        }
        local dop_out = {
            route = "wired",
            active = true,
            dop = true,
            sample_rate = 176400,
            bit_depth = 24,
            hardware_sample_rate = 176400,
            hardware_bit_depth = 24,
            resampling = false,
            resampling_known = true,
        }
        local configured_eq = {
            bypass = false,
            preamp_db = 3.0,
            stereo_width = 1.5,
            bands = { { enabled = true, gain_db = 4.0 } },
        }

        -- In true DoP, PCM DSP (EQ, preamp, width, software gain) is bypassed by native hardware DoP!
        local assess_dop_eq = M.assess_bit_perfect(dop_fmt, dop_out, configured_eq)
        assert_true(assess_dop_eq.is_candidate, "Configured EQ does not disqualify true DoP candidate (PCM DSP bypassed)")
        assert_eq(assess_dop_eq.status, "Bit-Perfect DoP Candidate (Wired)", "DoP status is candidate")
        local found_bypass_note = false
        for _, n in ipairs(assess_dop_eq.notes) do
            if n:find("bypasses PCM Equalizer") then found_bypass_note = true break end
        end
        assert_true(found_bypass_note, "Notes explain DoP hardware bypass of PCM DSP")

        -- In DSD-to-PCM, decimation is active and PCM DSP DOES affect audio
        local dsd_pcm_fmt = setmetatable({ dop = false }, { __index = dop_fmt })
        local assess_dsd_pcm_eq = M.assess_bit_perfect(dsd_pcm_fmt, dop_out, configured_eq)
        assert_false(assess_dsd_pcm_eq.is_candidate, "DSD-to-PCM with configured EQ is disqualified")
        local found_eq_reason = false
        for _, r in ipairs(assess_dsd_pcm_eq.reasons) do
            if r:find("Parametric EQ active") or r:find("EQ digital preamp") then found_eq_reason = true break end
        end
        assert_true(found_eq_reason, "DSD-to-PCM reports active EQ reasons")
    end

    ----------------------------------------------------------------------------
    -- Test 10: Route Uncertainty for Bluetooth and USB DAC
    ----------------------------------------------------------------------------
    do
        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        local clean_fmt = {
            path = "/sd/clean.flac",
            codec = "flac",
            sample_rate = 44100,
            bit_depth = 16,
            output_sample_rate = 44100,
            output_bit_depth = 16,
            channels = 2,
            software_volume_gain = 1.0,
            playback_speed = 1.0,
            replaygain_applied = false,
        }
        local bt_out = {
            route = "bluetooth",
            bluetooth_codec = "LDAC",
            active = true,
            sample_rate = 44100,
            bit_depth = 16,
            hardware_sample_rate = 44100,
            hardware_bit_depth = 16,
            resampling = false,
            resampling_known = true,
        }
        local assess_bt = M.assess_bit_perfect(clean_fmt, bt_out, { bypass = true })
        assert_false(assess_bt.is_candidate, "Bluetooth route cannot certify bit-perfect")
        assert_eq(assess_bt.status, "Route Uncertainty: End-to-End Uncertifiable (Bluetooth)", "Bluetooth status reflects route uncertainty")

        local usb_out = {
            route = "usb_dac",
            active = true,
            sample_rate = 44100,
            bit_depth = 16,
            hardware_sample_rate = 44100,
            hardware_bit_depth = 16,
            resampling = false,
            resampling_known = true,
        }
        local assess_usb = M.assess_bit_perfect(clean_fmt, usb_out, { bypass = true })
        assert_false(assess_usb.is_candidate, "USB DAC route cannot certify bit-perfect without endpoint verification")
        assert_eq(assess_usb.status, "Route Uncertainty: End-to-End Uncertifiable (USB DAC)", "USB DAC status reflects route uncertainty")
    end

    ----------------------------------------------------------------------------
    -- Test 11: Header Parsing Edge Cases & Unsupported Extension Rejection
    ----------------------------------------------------------------------------
    do
        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        -- Truncated header
        local res_trunc, err_trunc = M.parse_local_file_header(truncated_path)
        assert_true(res_trunc == nil, "Truncated file reports nil info")
        assert_true(err_trunc ~= nil and (err_trunc:find("Truncated") ~= nil or err_trunc:find("Malformed") ~= nil), "Truncated file error message")

        -- MP3 file: Track Inspector must NOT guess format from .mp3 suffix!
        local res_mp3, err_mp3 = M.parse_local_file_header(mp3_dummy_path)
        assert_true(res_mp3 == nil, "MP3 header without local parser reports nil info")
        assert_true(err_mp3 ~= nil and err_mp3:find("Unknown header format") ~= nil and err_mp3:find("not inferred from suffix") ~= nil, "Error indicates unsupported header, no suffix guessing")

        -- FLAC container bitrate calculation
        local res_flac, err_flac = M.parse_local_file_header(flac16_path)
        assert_true(res_flac ~= nil, "FLAC header valid")
        assert_eq(res_flac.format_name, "FLAC (Free Lossless Audio Codec)", "FLAC format name")
        assert_eq(res_flac.sample_rate, 44100, "FLAC sample rate")
        assert_eq(res_flac.bit_depth, 16, "FLAC bit depth")
        assert_true(res_flac.bitrate_kbps ~= nil and res_flac.bitrate_kbps > 0, "FLAC estimated container bitrate present")

        -- Bit depth expansion (16-bit source to 24-bit output)
        local fmt_expand = {
            path = "/sd/test.flac",
            codec = "flac",
            sample_rate = 44100,
            bit_depth = 16,
            output_sample_rate = 44100,
            output_bit_depth = 24,
            channels = 2,
            software_volume_gain = 1.0,
            playback_speed = 1.0,
            replaygain_applied = false,
        }
        local out_expand = {
            route = "wired",
            active = true,
            sample_rate = 44100,
            bit_depth = 24,
            hardware_sample_rate = 44100,
            hardware_bit_depth = 24,
            resampling = false,
            resampling_known = true,
        }
        local assess_expand = M.assess_bit_perfect(fmt_expand, out_expand, { bypass = true })
        assert_false(assess_expand.is_candidate, "Bit depth expanded from 16 to 24-bit is disqualified")
        local found_expand_reason = false
        for _, r in ipairs(assess_expand.reasons) do
            if r:find("Bit depth expanded") then found_expand_reason = true break end
        end
        assert_true(found_expand_reason, "Reports bit depth expanded reason")
    end

    ----------------------------------------------------------------------------
    -- Test 12: Inactive Playback & Standby Sink Status
    ----------------------------------------------------------------------------
    do
        local h = harness.new({ sd_root = test_dir })
        local M = h.load("plugins/TrackInspector/TrackInspector.lua")

        local assess_idle = M.assess_bit_perfect(nil, nil, nil)
        assert_false(assess_idle.is_candidate, "Idle playback is not candidate")
        assert_eq(assess_idle.status, "No Active Playback", "Idle playback status")

        local clean_fmt = {
            path = "/sd/clean.flac",
            codec = "flac",
            sample_rate = 44100,
            bit_depth = 16,
            output_sample_rate = 44100,
            output_bit_depth = 16,
            channels = 2,
            software_volume_gain = 1.0,
            playback_speed = 1.0,
            replaygain_applied = false,
        }
        local standby_out = { route = "wired", active = false }
        local assess_standby = M.assess_bit_perfect(clean_fmt, standby_out, { bypass = true })
        assert_false(assess_standby.is_candidate, "Standby sink is not candidate")
        assert_eq(assess_standby.status, "Sink Inactive / Standby", "Standby sink status")
    end

    os.execute("rm -rf '" .. test_dir .. "'")
end
