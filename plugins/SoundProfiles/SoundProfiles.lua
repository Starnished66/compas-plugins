plugin.define({ id = "example.sound_profiles", name = "Sound Profiles", version = "1.3.0", api_min = 19 })

local T = {
    de = {
        ["Sound Profiles"] = "Klangprofile",
        ["Sound Profile"] = "Klangprofil",
        ["Flat (Default)"] = "Neutral (Standard)",
        ["Bass Boost"] = "Bass-Boost",
        ["Vocal"] = "Stimme",
        ["Treble Boost"] = "Höhen-Boost",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "V-Kurve",
        ["U Shape"] = "U-Kurve",
        ["Could not apply sound profile. Try again."] = "Klangprofil konnte nicht angewendet werden. Erneut versuchen.",
        ["Sound profile applied"] = "Klangprofil angewendet",
    },
    es = {
        ["Sound Profiles"] = "Perfiles de sonido",
        ["Sound Profile"] = "Perfil de sonido",
        ["Flat (Default)"] = "Plano (predeterminado)",
        ["Bass Boost"] = "Realce de graves",
        ["Vocal"] = "Vocal",
        ["Treble Boost"] = "Realce de agudos",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "Curva en V",
        ["U Shape"] = "Curva en U",
        ["Could not apply sound profile. Try again."] = "No se pudo aplicar el perfil de sonido. Inténtalo de nuevo.",
        ["Sound profile applied"] = "Perfil de sonido aplicado",
    },
    fi = {
        ["Sound Profiles"] = "Ääniprofiilit",
        ["Sound Profile"] = "Ääniprofiili",
        ["Flat (Default)"] = "Tasainen (oletus)",
        ["Bass Boost"] = "Basson korostus",
        ["Vocal"] = "Laulu",
        ["Treble Boost"] = "Diskantin korostus",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "V-käyrä",
        ["U Shape"] = "U-käyrä",
        ["Could not apply sound profile. Try again."] = "Ääniprofiilin käyttö epäonnistui. Yritä uudelleen.",
        ["Sound profile applied"] = "Ääniprofiili käytössä",
    },
    fr = {
        ["Sound Profiles"] = "Profils sonores",
        ["Sound Profile"] = "Profil sonore",
        ["Flat (Default)"] = "Plat (par défaut)",
        ["Bass Boost"] = "Amplification des basses",
        ["Vocal"] = "Voix",
        ["Treble Boost"] = "Amplification des aigus",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "Courbe en V",
        ["U Shape"] = "Courbe en U",
        ["Could not apply sound profile. Try again."] = "Impossible d'appliquer le profil sonore. Réessayez.",
        ["Sound profile applied"] = "Profil sonore appliqué",
    },
    it = {
        ["Sound Profiles"] = "Profili audio",
        ["Sound Profile"] = "Profilo audio",
        ["Flat (Default)"] = "Piatto (predefinito)",
        ["Bass Boost"] = "Rinforzo bassi",
        ["Vocal"] = "Voce",
        ["Treble Boost"] = "Rinforzo alti",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "Curva a V",
        ["U Shape"] = "Curva a U",
        ["Could not apply sound profile. Try again."] = "Impossibile applicare il profilo audio. Riprova.",
        ["Sound profile applied"] = "Profilo audio applicato",
    },
    ja = {
        ["Sound Profiles"] = "サウンドプロファイル",
        ["Sound Profile"] = "サウンドプロファイル",
        ["Flat (Default)"] = "フラット（標準）",
        ["Bass Boost"] = "低音ブースト",
        ["Vocal"] = "ボーカル",
        ["Treble Boost"] = "高音ブースト",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "V 字型",
        ["U Shape"] = "U 字型",
        ["Could not apply sound profile. Try again."] = "サウンドプロファイルを適用できませんでした。再試行してください。",
        ["Sound profile applied"] = "サウンドプロファイルを適用しました",
    },
    nl = {
        ["Sound Profiles"] = "Geluidsprofielen",
        ["Sound Profile"] = "Geluidsprofiel",
        ["Flat (Default)"] = "Vlak (standaard)",
        ["Bass Boost"] = "Basversterking",
        ["Vocal"] = "Vocaal",
        ["Treble Boost"] = "Treble-versterking",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "V-vorm",
        ["U Shape"] = "U-vorm",
        ["Could not apply sound profile. Try again."] = "Kan geluidsprofiel niet toepassen. Probeer het opnieuw.",
        ["Sound profile applied"] = "Geluidsprofiel toegepast",
    },
    pt = {
        ["Sound Profiles"] = "Perfis de som",
        ["Sound Profile"] = "Perfil de som",
        ["Flat (Default)"] = "Plano (padrão)",
        ["Bass Boost"] = "Reforço de graves",
        ["Vocal"] = "Vocal",
        ["Treble Boost"] = "Reforço de agudos",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "Curva em V",
        ["U Shape"] = "Curva em U",
        ["Could not apply sound profile. Try again."] = "Não foi possível aplicar o perfil de som. Tente novamente.",
        ["Sound profile applied"] = "Perfil de som aplicado",
    },
    ru = {
        ["Sound Profiles"] = "Профили звука",
        ["Sound Profile"] = "Профиль звука",
        ["Flat (Default)"] = "Ровный (по умолчанию)",
        ["Bass Boost"] = "Усиление басов",
        ["Vocal"] = "Вокал",
        ["Treble Boost"] = "Усиление высоких",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "V-образный",
        ["U Shape"] = "U-образный",
        ["Could not apply sound profile. Try again."] = "Не удалось применить профиль звука. Повторите попытку.",
        ["Sound profile applied"] = "Профиль звука применён",
    },
    uk = {
        ["Sound Profiles"] = "Профілі звуку",
        ["Sound Profile"] = "Профіль звуку",
        ["Flat (Default)"] = "Рівний (за замовчуванням)",
        ["Bass Boost"] = "Підсилення басів",
        ["Vocal"] = "Вокал",
        ["Treble Boost"] = "Підсилення високих",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "V-подібний",
        ["U Shape"] = "U-подібний",
        ["Could not apply sound profile. Try again."] = "Не вдалося застосувати профіль звуку. Спробуйте ще раз.",
        ["Sound profile applied"] = "Профіль звуку застосовано",
    },
    vi = {
        ["Sound Profiles"] = "Cấu hình âm thanh",
        ["Sound Profile"] = "Cấu hình âm thanh",
        ["Flat (Default)"] = "Phẳng (Mặc định)",
        ["Bass Boost"] = "Tăng âm trầm",
        ["Vocal"] = "Giọng hát",
        ["Treble Boost"] = "Tăng âm cao",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "Dạng chữ V",
        ["U Shape"] = "Dạng chữ U",
        ["Could not apply sound profile. Try again."] = "Không thể áp dụng cấu hình âm thanh. Hãy thử lại.",
        ["Sound profile applied"] = "Đã áp dụng cấu hình âm thanh",
    },
    zh_CN = {
        ["Sound Profiles"] = "声音配置",
        ["Sound Profile"] = "声音配置",
        ["Flat (Default)"] = "平直（默认）",
        ["Bass Boost"] = "低音增强",
        ["Vocal"] = "人声",
        ["Treble Boost"] = "高音增强",
        ["Harman IE 2017"] = "Harman IE 2017",
        ["V Shape"] = "V 形曲线",
        ["U Shape"] = "U 形曲线",
        ["Could not apply sound profile. Try again."] = "无法应用声音配置。请重试。",
        ["Sound profile applied"] = "已应用声音配置",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- Sound profile switcher, adds a "Sound Profile" row to Settings -> Music
-- Settings -> Audio.
-- Reference implementation for the plugin.eq_*() API (see PLUGINS.md):
-- ships a few curated EQ presets on top of this app's own 10-band
-- parametric EQ (src/audio/peq.c), switchable with one tap, persisted
-- across reboots the same way every other example plugin in this folder
-- persists its own state -- a plain file under .plugins/, re-applied at
-- the top of this script on every boot.

local STATE_PATH = plugin.sd_root() .. "/.plugins/.eq_profile_state"

-- Matches peq.c's own set_defaults() exactly (ISO-standard 10-band layout,
-- band 0 a low shelf, band 9 a high shelf, the rest peaking bells) so a
-- profile only needs to say which bands it touches and by how much -- every
-- other band stays at this app's own normal default frequency/Q, just like
-- Flat does.
local BAND_FREQS = { 31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 }
local BAND_Q     = { 0.2, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.2 }
local BAND_TYPE  = { "low_shelf", "peaking", "peaking", "peaking", "peaking",
                      "peaking", "peaking", "peaking", "peaking", "high_shelf" }

-- gains is sparse: only the bands a profile actually boosts/cuts (1-based,
-- matching plugin.eq_set_band()'s own convention) need an entry -- every
-- other band is left disabled at its default gain (0dB), the same "skip
-- disabled bands" fast path peq_process() already takes.
local PROFILES = {
    { key = "bass_boost",   name = "Bass Boost",   gains = { [1] = 6, [2] = 4, [3] = 2 } },
    { key = "vocal",        name = "Vocal",         gains = { [1] = -2, [6] = 3, [7] = 4, [8] = 3 } },
    { key = "treble_boost", name = "Treble Boost", gains = { [8] = 3, [9] = 4, [10] = 5 } },

    -- Harman In-Ear 2017 (IE) approximation from the supplied target graph.
    -- The original IE curve has a strong bass shelf, a deep lower-mid dip,
    -- a pronounced 2-4 kHz rise, and a treble fall above ~8-10 kHz.
    -- This 10-band EQ approximates that shape with the plugin's fixed bands.
    -- 16 kHz is kept at 0 dB because the very steep end-of-graph fall is
    -- strongly affected by the measurement/coupler limit and cannot be
    -- represented cleanly by the 0.2-Q high shelf.
    { key = "harman_ie_2017", name = "Harman IE 2017", gains = {
        [1] = 8, [2] = 6, [3] = 2, [4] = -2, [5] = -1,
        [6] = 0, [7] = 6, [8] = 9, [9] = 6, [10] = 0
    } },

    -- V-shaped: elevated bass and upper treble with a recessed midrange.
    { key = "v_shape", name = "V Shape", gains = {
        [1] = 4, [2] = 3, [3] = 1, [6] = -2, [7] = -2, [8] = 2, [9] = 3, [10] = 3
    } },

    -- U-shaped: milder V-shape with less midrange recession.
    { key = "u_shape", name = "U Shape", gains = {
        [1] = 3, [2] = 2, [3] = 1, [6] = -1, [7] = -1, [8] = 1, [9] = 2, [10] = 2
    } },
}

local function profile_path(key)
    return plugin.sd_root() .. "/.plugins/.eq_" .. key .. ".peq"
end

local function read_state()
    local f = io.open(STATE_PATH, "r")
    if not f then return "flat" end
    local s = f:read("*l")
    f:close()
    return s or "flat"
end

local function write_state(key)
    local temp_path = STATE_PATH .. ".tmp"
    local f = io.open(temp_path, "w")
    if not f then return false end
    local ok = f:write(key)
    local closed = f:close()
    if not ok or not closed then
        os.remove(temp_path)
        return false
    end
    return os.rename(temp_path, STATE_PATH)
end

-- Generates a complete profile without changing the live EQ.
local function ensure_profile_file(profile)
    local path = profile_path(profile.key)
    local f = io.open(path, "r")
    if f then
        f:close()
        return path
    end

    local temp_path = path .. ".tmp"
    f = io.open(temp_path, "w")
    if not f then return nil end
    local ok = f:write("bypass=0\npreamp=0.00\n")
    for i = 1, 10 do
        local gain = profile.gains[i] or 0
        local band_type = (BAND_TYPE[i] == "low_shelf") and 1 or (BAND_TYPE[i] == "high_shelf") and 2 or 0
        if ok then
            ok = f:write(string.format("band%d_freq=%.2f\nband%d_gain=%.2f\nband%d_q=%.3f\nband%d_type=%d\nband%d_enabled=%d\n",
                i - 1, BAND_FREQS[i], i - 1, gain, i - 1, BAND_Q[i], i - 1, band_type, i - 1, gain ~= 0 and 1 or 0))
        end
    end
    local closed = f:close()
    if not ok or not closed or not os.rename(temp_path, path) then
        os.remove(temp_path)
        return nil
    end
    return path
end

local function apply_profile(key)
    if key == "flat" then
        plugin.eq_reset()
        return true
    end
    for _, p in ipairs(PROFILES) do
        if p.key == key then
            local path = ensure_profile_file(p)
            return path ~= nil and plugin.eq_load_profile(path)
        end
    end
    return false
end

local current_key = read_state()

plugin.register_list_item("music_audio", tr("Sound Profile"), function()
    local names = { tr("Flat (Default)") }
    for _, p in ipairs(PROFILES) do table.insert(names, tr(p.name)) end

    plugin.show_list(tr("Sound Profile"), names, function(index)
        local key = (index == 1) and "flat" or PROFILES[index - 1].key
        if not apply_profile(key) or not write_state(key) then
            plugin.show_toast(tr("Could not apply sound profile. Try again."))
            return
        end
        current_key = key
        plugin.show_toast(tr("Sound profile applied"))
    end)
end, { group = "effects" })
