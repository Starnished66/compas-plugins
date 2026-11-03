plugin.define({ id = "example.playback_extras", name = "Playback Extras", version = "1.4.0", api_min = 19 })

local T = {
    de = {
        ["Playback Extras"] = "Wiedergabe-Extras",
        ["Turn off MSEB first"] = "MSEB zuerst ausschalten",
        ["About Loudness Boost"] = "Über Lautstärke-Boost",
        ["What does this do?"] = "Was bewirkt das?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Hebt den gesamten EQ-Vorverstärker um den gewählten Wert an, solange aktiviert.",
        ["Loudness Boost"] = "Lautstärke-Boost",
        ["Enable Boost"] = "Boost aktivieren",
        ["Could not enable boost. Try again."] = "Boost konnte nicht aktiviert werden. Erneut versuchen.",
        ["Could not restore sound settings. Try again."] = "Klangeinstellungen konnten nicht wiederhergestellt werden. Erneut versuchen.",
        ["Boost Amount (dB)"] = "Boost-Stärke (dB)",
        ["Could not apply boost. Try again."] = "Boost konnte nicht angewendet werden. Erneut versuchen.",
        ["About"] = "Info",
    },
    es = {
        ["Playback Extras"] = "Extras de reproducción",
        ["Turn off MSEB first"] = "Desactiva MSEB primero",
        ["About Loudness Boost"] = "Acerca de Realce de volumen",
        ["What does this do?"] = "¿Qué hace esto?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Aumenta el preamplificador de todo el EQ en la cantidad elegida mientras está activo.",
        ["Loudness Boost"] = "Realce de volumen",
        ["Enable Boost"] = "Activar realce",
        ["Could not enable boost. Try again."] = "No se pudo activar el realce. Inténtalo de nuevo.",
        ["Could not restore sound settings. Try again."] = "No se pudieron restaurar los ajustes de sonido. Inténtalo de nuevo.",
        ["Boost Amount (dB)"] = "Cantidad de realce (dB)",
        ["Could not apply boost. Try again."] = "No se pudo aplicar el realce. Inténtalo de nuevo.",
        ["About"] = "Acerca de",
    },
    fi = {
        ["Playback Extras"] = "Toiston lisäasetukset",
        ["Turn off MSEB first"] = "Poista MSEB ensin käytöstä",
        ["About Loudness Boost"] = "Tietoja äänenvoimakkuuden korostuksesta",
        ["What does this do?"] = "Mitä tämä tekee?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Nostaa koko EQ-esivahvistusta valitun määrän ollessaan käytössä.",
        ["Loudness Boost"] = "Äänenvoimakkuuden korostus",
        ["Enable Boost"] = "Ota korostus käyttöön",
        ["Could not enable boost. Try again."] = "Korostusta ei voitu ottaa käyttöön. Yritä uudelleen.",
        ["Could not restore sound settings. Try again."] = "Ääniasetuksia ei voitu palauttaa. Yritä uudelleen.",
        ["Boost Amount (dB)"] = "Korostuksen määrä (dB)",
        ["Could not apply boost. Try again."] = "Korostusta ei voitu käyttää. Yritä uudelleen.",
        ["About"] = "Tietoja",
    },
    fr = {
        ["Playback Extras"] = "Options de lecture",
        ["Turn off MSEB first"] = "Désactivez d'abord MSEB",
        ["About Loudness Boost"] = "À propos du Boost de volume",
        ["What does this do?"] = "À quoi cela sert-il ?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Augmente le préampli de tout l'EQ de la valeur choisie lorsqu'il est activé.",
        ["Loudness Boost"] = "Boost de volume",
        ["Enable Boost"] = "Activer le boost",
        ["Could not enable boost. Try again."] = "Impossible d'activer le boost. Réessayez.",
        ["Could not restore sound settings. Try again."] = "Impossible de restaurer les paramètres audio. Réessayez.",
        ["Boost Amount (dB)"] = "Niveau de boost (dB)",
        ["Could not apply boost. Try again."] = "Impossible d'appliquer le boost. Réessayez.",
        ["About"] = "À propos",
    },
    it = {
        ["Playback Extras"] = "Extra di riproduzione",
        ["Turn off MSEB first"] = "Disattiva prima MSEB",
        ["About Loudness Boost"] = "Info su Aumento volume",
        ["What does this do?"] = "A cosa serve?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Aumenta il preamplificatore dell'intero EQ del valore scelto quando è attivo.",
        ["Loudness Boost"] = "Aumento volume",
        ["Enable Boost"] = "Attiva aumento",
        ["Could not enable boost. Try again."] = "Impossibile attivare l'aumento. Riprova.",
        ["Could not restore sound settings. Try again."] = "Impossibile ripristinare le impostazioni audio. Riprova.",
        ["Boost Amount (dB)"] = "Livello di aumento (dB)",
        ["Could not apply boost. Try again."] = "Impossibile applicare l'aumento. Riprova.",
        ["About"] = "Info",
    },
    ja = {
        ["Playback Extras"] = "再生エクストラ",
        ["Turn off MSEB first"] = "先に MSEB をオフにしてください",
        ["About Loudness Boost"] = "ラウドネスブーストについて",
        ["What does this do?"] = "これは何ですか？",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "有効な間、EQ 全体のプリアンプを選択した量だけ引き上げます。",
        ["Loudness Boost"] = "ラウドネスブースト",
        ["Enable Boost"] = "ブーストを有効化",
        ["Could not enable boost. Try again."] = "ブーストを有効にできませんでした。再試行してください。",
        ["Could not restore sound settings. Try again."] = "サウンド設定を復元できませんでした。再試行してください。",
        ["Boost Amount (dB)"] = "ブースト量 (dB)",
        ["Could not apply boost. Try again."] = "ブーストを適用できませんでした。再試行してください。",
        ["About"] = "情報",
    },
    nl = {
        ["Playback Extras"] = "Afspeel-extra's",
        ["Turn off MSEB first"] = "Schakel eerst MSEB uit",
        ["About Loudness Boost"] = "Over Volumeboost",
        ["What does this do?"] = "Wat doet dit?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Verhoogt de voorversterking van de gehele EQ met de gekozen waarde wanneer ingeschakeld.",
        ["Loudness Boost"] = "Volumeboost",
        ["Enable Boost"] = "Boost inschakelen",
        ["Could not enable boost. Try again."] = "Kan boost niet inschakelen. Probeer het opnieuw.",
        ["Could not restore sound settings. Try again."] = "Kan geluidsinstellingen niet herstellen. Probeer het opnieuw.",
        ["Boost Amount (dB)"] = "Boosthoeveelheid (dB)",
        ["Could not apply boost. Try again."] = "Kan boost niet toepassen. Probeer het opnieuw.",
        ["About"] = "Over",
    },
    pt = {
        ["Playback Extras"] = "Extras de reprodução",
        ["Turn off MSEB first"] = "Desative o MSEB primeiro",
        ["About Loudness Boost"] = "Sobre o Reforço de volume",
        ["What does this do?"] = "O que isto faz?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Aumenta o pré-amplificador de todo o EQ na quantidade escolhida enquanto ativado.",
        ["Loudness Boost"] = "Reforço de volume",
        ["Enable Boost"] = "Ativar reforço",
        ["Could not enable boost. Try again."] = "Não foi possível ativar o reforço. Tente novamente.",
        ["Could not restore sound settings. Try again."] = "Não foi possível restaurar as configurações de som. Tente novamente.",
        ["Boost Amount (dB)"] = "Nível de reforço (dB)",
        ["Could not apply boost. Try again."] = "Não foi possível aplicar o reforço. Tente novamente.",
        ["About"] = "Sobre",
    },
    ru = {
        ["Playback Extras"] = "Дополнения воспроизведения",
        ["Turn off MSEB first"] = "Сначала отключите MSEB",
        ["About Loudness Boost"] = "О функции «Усиление громкости»",
        ["What does this do?"] = "Что это делает?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Повышает предусиление всего EQ на выбранную величину, пока функция включена.",
        ["Loudness Boost"] = "Усиление громкости",
        ["Enable Boost"] = "Включить усиление",
        ["Could not enable boost. Try again."] = "Не удалось включить усиление. Повторите попытку.",
        ["Could not restore sound settings. Try again."] = "Не удалось восстановить настройки звука. Повторите попытку.",
        ["Boost Amount (dB)"] = "Величина усиления (дБ)",
        ["Could not apply boost. Try again."] = "Не удалось применить усиление. Повторите попытку.",
        ["About"] = "О функции",
    },
    uk = {
        ["Playback Extras"] = "Доповнення відтворення",
        ["Turn off MSEB first"] = "Спочатку вимкніть MSEB",
        ["About Loudness Boost"] = "Про «Підсилення гучності»",
        ["What does this do?"] = "Що це робить?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Підвищує передпідсилення всього EQ на вибране значення, доки функцію ввімкнено.",
        ["Loudness Boost"] = "Підсилення гучності",
        ["Enable Boost"] = "Увімкнути підсилення",
        ["Could not enable boost. Try again."] = "Не вдалося увімкнути підсилення. Спробуйте ще раз.",
        ["Could not restore sound settings. Try again."] = "Не вдалося відновити налаштування звуку. Спробуйте ще раз.",
        ["Boost Amount (dB)"] = "Рівень підсилення (дБ)",
        ["Could not apply boost. Try again."] = "Не вдалося застосувати підсилення. Спробуйте ще раз.",
        ["About"] = "Про функцію",
    },
    vi = {
        ["Playback Extras"] = "Tiện ích phát nhạc",
        ["Turn off MSEB first"] = "Hãy tắt MSEB trước",
        ["About Loudness Boost"] = "Giới thiệu về Tăng âm lượng",
        ["What does this do?"] = "Tính năng này làm gì?",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "Tăng tiền khuếch đại toàn bộ EQ theo mức đã chọn khi được bật.",
        ["Loudness Boost"] = "Tăng âm lượng",
        ["Enable Boost"] = "Bật tăng âm lượng",
        ["Could not enable boost. Try again."] = "Không thể bật tăng âm lượng. Hãy thử lại.",
        ["Could not restore sound settings. Try again."] = "Không thể khôi phục cài đặt âm thanh. Hãy thử lại.",
        ["Boost Amount (dB)"] = "Mức tăng (dB)",
        ["Could not apply boost. Try again."] = "Không thể áp dụng mức tăng. Hãy thử lại.",
        ["About"] = "Giới thiệu",
    },
    zh_CN = {
        ["Playback Extras"] = "播放附加功能",
        ["Turn off MSEB first"] = "请先关闭 MSEB",
        ["About Loudness Boost"] = "关于响度增强",
        ["What does this do?"] = "此功能有什么作用？",
        ["Raises the whole-EQ preamp by the chosen amount while enabled."] = "启用时，按所选数值提高整个 EQ 的前置增益。",
        ["Loudness Boost"] = "响度增强",
        ["Enable Boost"] = "启用增强",
        ["Could not enable boost. Try again."] = "无法启用增强。请重试。",
        ["Could not restore sound settings. Try again."] = "无法恢复声音设置。请重试。",
        ["Boost Amount (dB)"] = "增强幅度 (dB)",
        ["Could not apply boost. Try again."] = "无法应用增强。请重试。",
        ["About"] = "关于",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- Reference implementation for plugin.register_list_item("music_audio", ...)
-- and plugin.show_settings_list() (see PLUGINS.md): adds a "Loudness Boost"
-- row to Settings -> Music Settings -> Audio, opening a nested submenu with
-- a real toggle switch, a real slider, and a nested row (a submenu inside a
-- submenu).
-- Also demonstrates the icon/height/text_size row options: the toggle row
-- gets a real icon (pointed at a real stock theme2 asset by its raw
-- filesystem path -- no user-supplied image needed for this example to
-- work), and the "About" row is shown at "large" text size.
--
-- Boost derives an active profile from a saved snapshot, preserving the
-- user's bands and restoring their original preamp and bypass when disabled.

local STATE_PATH = plugin.sd_root() .. "/.plugins/.playback_extras_state"
local BACKUP_PATH = plugin.sd_root() .. "/.plugins/.playback_extras_backup.peq"
local ACTIVE_PATH = plugin.sd_root() .. "/.plugins/.playback_extras_active.peq"
-- Legacy MSEB uses a PEQ snapshot; stock MSEB reports its transient owner
-- state instead. Two effects cannot own the PEQ at the same time.
local OTHER_EQ_OWNER_BACKUP = plugin.sd_root() .. "/.plugins/.mseb_pre_backup.peq"

local function stock_mseb_active()
    if not plugin.has_capability or not plugin.has_capability("audio.mseb.stock")
        or type(plugin.get_mseb_state) ~= "function" then return false end
    local ok, current = pcall(plugin.get_mseb_state)
    return ok and type(current) == "table" and current.enabled == true
end

local function file_exists(path)
    local f = io.open(path, "r")
    if f then f:close() return true end
    return false
end

local function read_state()
    local f = io.open(STATE_PATH, "r")
    if not f then return { enabled = false, boost_db = 4 } end
    local enabled_line = f:read("*l")
    local boost_line = f:read("*l")
    f:close()
    return {
        enabled = enabled_line == "1",
        boost_db = tonumber(boost_line) or 4,
    }
end

local function write_state(state)
    local temp_path = STATE_PATH .. ".tmp"
    local f = io.open(temp_path, "w")
    if not f then return false end
    local ok = f:write(state.enabled and "1" or "0", "\n", tostring(state.boost_db))
    local closed = f:close()
    if not ok or not closed then
        os.remove(temp_path)
        return false
    end
    return os.rename(temp_path, STATE_PATH)
end

local state = read_state()

-- A real stock theme2 asset, present on every real device -- see this
-- file's own header comment. Raw absolute filesystem path, not a
-- theme2-relative one (see PLUGINS.md's "Row images, resizing, and text
-- size" section for why).
local BOOST_ICON = "/usr/resource/litegui/theme2/launcher/music.png"

local function build_active_profile()
    local source = io.open(BACKUP_PATH, "r")
    if not source then return false end
    local temp_path = ACTIVE_PATH .. ".tmp"
    local target = io.open(temp_path, "w")
    if not target then source:close() return false end
    local seen_bypass, seen_preamp = false, false
    local ok = true
    local line = source:read("*l")
    while line and ok do
        local key = line:match("^([^=]+)=")
        if key == "bypass" then
            ok = target:write("bypass=0\n")
            seen_bypass = true
        elseif key == "preamp" then
            ok = target:write("preamp=" .. tostring(state.boost_db) .. "\n")
            seen_preamp = true
        else
            ok = target:write(line, "\n")
        end
        line = source:read("*l")
    end
    local source_closed = source:close()
    if ok and not seen_bypass then ok = target:write("bypass=0\n") end
    if ok and not seen_preamp then ok = target:write("preamp=" .. tostring(state.boost_db) .. "\n") end
    local target_closed = target:close()
    if not ok or not source_closed or not target_closed or not os.rename(temp_path, ACTIVE_PATH) then
        os.remove(temp_path)
        return false
    end
    return plugin.eq_load_profile(ACTIVE_PATH)
end

local function enable_boost()
    if file_exists(OTHER_EQ_OWNER_BACKUP) or stock_mseb_active() then return false, tr("Turn off MSEB first") end
    -- A backup left by a restore that failed still holds the user's EQ from
    -- before the boost; keep it rather than snapshot the current state.
    if not file_exists(BACKUP_PATH) and not plugin.eq_save_profile(BACKUP_PATH) then return false end
    return build_active_profile()
end

local function restore_profile()
    if not plugin.eq_load_profile(BACKUP_PATH) then return false end
    return true
end

if state.enabled and (file_exists(OTHER_EQ_OWNER_BACKUP) or stock_mseb_active()) then
    -- Both on is only possible with files left by older versions; step aside
    -- and give the user back the EQ saved before the boost.
    local restored = file_exists(BACKUP_PATH) and plugin.eq_load_profile(BACKUP_PATH)
    state.enabled = false
    if write_state(state) and restored then os.remove(BACKUP_PATH) end
elseif state.enabled and not build_active_profile() then
    local restored = plugin.eq_load_profile(BACKUP_PATH)
    state.enabled = false
    if write_state(state) and restored then os.remove(BACKUP_PATH) end
end

local function open_about_menu()
    plugin.show_settings_list(tr("About Loudness Boost"), {
        {
            type = "row",
            label = tr("What does this do?"),
            on_select = function()
                plugin.show_toast(tr("Raises the whole-EQ preamp by the chosen amount while enabled."))
            end,
        },
    })
end

local function open_menu()
    plugin.show_settings_list(tr("Loudness Boost"), {
        {
            type = "toggle",
            label = tr("Enable Boost"),
            value = state.enabled,
            icon = BOOST_ICON,
            on_change = function(new_value)
                if new_value then
                    local ok, reason = enable_boost()
                    if not ok then
                        plugin.show_toast(reason or tr("Could not enable boost. Try again."))
                        return
                    end
                    state.enabled = true
                    if not write_state(state) then
                        state.enabled = false
                        plugin.eq_load_profile(BACKUP_PATH)
                        plugin.show_toast(tr("Could not enable boost. Try again."))
                        return
                    end
                else
                    if not restore_profile() then
                        plugin.show_toast(tr("Could not restore sound settings. Try again."))
                        return
                    end
                    state.enabled = false
                    if not write_state(state) then
                        state.enabled = true
                        build_active_profile()
                        plugin.show_toast(tr("Could not restore sound settings. Try again."))
                        return
                    end
                    os.remove(BACKUP_PATH)
                end
            end,
        },
        {
            type = "slider",
            label = tr("Boost Amount (dB)"),
            min = 0,
            max = 12,
            value = state.boost_db,
            on_change = function(new_value)
                local previous = state.boost_db
                state.boost_db = new_value
                if state.enabled and not build_active_profile() then
                    state.boost_db = previous
                    plugin.show_toast(tr("Could not apply boost. Try again."))
                    return
                end
                if not write_state(state) then
                    state.boost_db = previous
                    if state.enabled then build_active_profile() end
                end
            end,
        },
        {
            type = "row",
            label = tr("About"),
            on_select = open_about_menu,
        },
    })
end

plugin.register_list_item("music_audio", tr("Loudness Boost"), open_menu, { group = "effects" })
