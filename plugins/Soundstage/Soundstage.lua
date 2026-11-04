plugin.define({ id = "compas.soundstage", name = "Soundstage", version = "1.0.0", api_min = 19 })

-- Translations are keyed by the English text. Filled in separately.
local T = {
    de = {
        ["Amount (%)"] = "Stärke (%)",
        ["Bass frequency (Hz)"] = "Bassfrequenz (Hz)",
        ["Bass width (dB)"] = "Bassbreite (dB)",
        ["Could not apply Soundstage. Try again."] = "Klangbühne konnte nicht angewendet werden. Erneut versuchen.",
        ["Could not open preset list"] = "Preset-Liste konnte nicht geöffnet werden",
        ["Could not open confirmation"] = "Bestätigung konnte nicht geöffnet werden",
        ["Could not save Soundstage settings"] = "Klangbühnen-Einstellungen konnten nicht gespeichert werden",
        ["Custom"] = "Benutzerdefiniert",
        ["Damping (%)"] = "Dämpfung (%)",
        ["Enabled"] = "Aktiviert",
        ["Focused center"] = "Fokussierte Mitte",
        ["Hall"] = "Saal",
        ["Natural"] = "Natürlich",
        ["Player firmware is too old for Soundstage"] = "Player-Firmware ist zu alt für Klangbühne",
        ["Preset"] = "Preset",
        ["Reflections (%)"] = "Reflexionen (%)",
        ["Reset"] = "Zurücksetzen",
        ["Reset Soundstage to defaults?"] = "Klangbühne auf Standard zurücksetzen?",
        ["Reset to defaults"] = "Zurücksetzen",
        ["Room"] = "Raum",
        ["Room size (%)"] = "Raumgröße (%)",
        ["Side EQ"] = "Side-EQ",
        ["Side level (dB)"] = "Side-Pegel (dB)",
        ["Small room"] = "Kleiner Raum",
        ["Soundstage"] = "Klangbühne",
        ["Speaker angle (deg)"] = "Lautsprecherwinkel (deg)",
        ["Studio monitors"] = "Studiomonitore",
        ["Treble frequency (Hz)"] = "Höhenfrequenz (Hz)",
        ["Treble width (dB)"] = "Höhenbreite (dB)",
        ["Virtual speakers"] = "Virtuelle Lautsprecher",
        ["Wide"] = "Breit",
    },
    es = {
        ["Amount (%)"] = "Cantidad (%)",
        ["Bass frequency (Hz)"] = "Frecuencia de graves (Hz)",
        ["Bass width (dB)"] = "Ancho de graves (dB)",
        ["Could not apply Soundstage. Try again."] = "No se pudo aplicar Escenario sonoro. Inténtalo de nuevo.",
        ["Could not open preset list"] = "No se pudo abrir la lista de preajustes",
        ["Could not open confirmation"] = "No se pudo abrir la confirmación",
        ["Could not save Soundstage settings"] = "No se pudieron guardar los ajustes de Escenario sonoro",
        ["Custom"] = "Personalizado",
        ["Damping (%)"] = "Amortiguación (%)",
        ["Enabled"] = "Activado",
        ["Focused center"] = "Centro enfocado",
        ["Hall"] = "Sala de conciertos",
        ["Natural"] = "Natural",
        ["Player firmware is too old for Soundstage"] = "El firmware del reproductor es demasiado antiguo para Escenario sonoro",
        ["Preset"] = "Preajuste",
        ["Reflections (%)"] = "Reflexiones (%)",
        ["Reset"] = "Restablecer",
        ["Reset Soundstage to defaults?"] = "¿Restablecer Escenario sonoro a los valores por defecto?",
        ["Reset to defaults"] = "Restablecer",
        ["Room"] = "Sala",
        ["Room size (%)"] = "Tamaño de sala (%)",
        ["Side EQ"] = "EQ lateral",
        ["Side level (dB)"] = "Nivel lateral (dB)",
        ["Small room"] = "Sala pequeña",
        ["Soundstage"] = "Escenario sonoro",
        ["Speaker angle (deg)"] = "Ángulo de altavoces (deg)",
        ["Studio monitors"] = "Monitores de estudio",
        ["Treble frequency (Hz)"] = "Frecuencia de agudos (Hz)",
        ["Treble width (dB)"] = "Ancho de agudos (dB)",
        ["Virtual speakers"] = "Altavoces virtuales",
        ["Wide"] = "Amplio",
    },
    fi = {
        ["Amount (%)"] = "Määrä (%)",
        ["Bass frequency (Hz)"] = "Bassotaajuus (Hz)",
        ["Bass width (dB)"] = "Basson leveys (dB)",
        ["Could not apply Soundstage. Try again."] = "Äänikuvan käyttö epäonnistui. Yritä uudelleen.",
        ["Could not open preset list"] = "Esiasetuslistaa ei voitu avata",
        ["Could not open confirmation"] = "Vahvistusta ei voitu avata",
        ["Could not save Soundstage settings"] = "Äänikuvan asetuksia ei voitu tallentaa",
        ["Custom"] = "Mukautettu",
        ["Damping (%)"] = "Vaimennus (%)",
        ["Enabled"] = "Käytössä",
        ["Focused center"] = "Tarkennettu keskiö",
        ["Hall"] = "Sali",
        ["Natural"] = "Luonnollinen",
        ["Player firmware is too old for Soundstage"] = "Soittimen laiteohjelmisto on liian vanha äänikuvalle",
        ["Preset"] = "Esiasetus",
        ["Reflections (%)"] = "Heijastukset (%)",
        ["Reset"] = "Palauta",
        ["Reset Soundstage to defaults?"] = "Palautetaanko äänikuvan oletusasetukset?",
        ["Reset to defaults"] = "Palauta oletukset",
        ["Room"] = "Huone",
        ["Room size (%)"] = "Huoneen koko (%)",
        ["Side EQ"] = "Sivu-EQ",
        ["Side level (dB)"] = "Sivutaso (dB)",
        ["Small room"] = "Pieni huone",
        ["Soundstage"] = "Äänikuva",
        ["Speaker angle (deg)"] = "Kaiutinkulma (deg)",
        ["Studio monitors"] = "Studiomonitorit",
        ["Treble frequency (Hz)"] = "Diskanttitaajuus (Hz)",
        ["Treble width (dB)"] = "Diskantin leveys (dB)",
        ["Virtual speakers"] = "Virtuaalikaiuttimet",
        ["Wide"] = "Leveä",
    },
    fr = {
        ["Amount (%)"] = "Intensité (%)",
        ["Bass frequency (Hz)"] = "Fréquence des graves (Hz)",
        ["Bass width (dB)"] = "Largeur des graves (dB)",
        ["Could not apply Soundstage. Try again."] = "Impossible d'appliquer la scène sonore. Réessayez.",
        ["Could not open preset list"] = "Impossible d'ouvrir la liste des préréglages",
        ["Could not open confirmation"] = "Impossible d'ouvrir la confirmation",
        ["Could not save Soundstage settings"] = "Impossible d'enregistrer les paramètres de scène sonore",
        ["Custom"] = "Personnalisé",
        ["Damping (%)"] = "Amortissement (%)",
        ["Enabled"] = "Activé",
        ["Focused center"] = "Centre focalisé",
        ["Hall"] = "Grande salle",
        ["Natural"] = "Naturel",
        ["Player firmware is too old for Soundstage"] = "Le micrologiciel du lecteur est trop ancien pour la scène sonore",
        ["Preset"] = "Préréglage",
        ["Reflections (%)"] = "Réflexions (%)",
        ["Reset"] = "Réinitialiser",
        ["Reset Soundstage to defaults?"] = "Rétablir les valeurs par défaut de la scène sonore ?",
        ["Reset to defaults"] = "Réinitialiser",
        ["Room"] = "Pièce",
        ["Room size (%)"] = "Taille de pièce (%)",
        ["Side EQ"] = "EQ latéral",
        ["Side level (dB)"] = "Niveau latéral (dB)",
        ["Small room"] = "Petite pièce",
        ["Soundstage"] = "Scène sonore",
        ["Speaker angle (deg)"] = "Angle des haut-parleurs (deg)",
        ["Studio monitors"] = "Moniteurs de studio",
        ["Treble frequency (Hz)"] = "Fréquence des aigus (Hz)",
        ["Treble width (dB)"] = "Largeur des aigus (dB)",
        ["Virtual speakers"] = "Haut-parleurs virtuels",
        ["Wide"] = "Large",
    },
    it = {
        ["Amount (%)"] = "Quantità (%)",
        ["Bass frequency (Hz)"] = "Frequenza bassi (Hz)",
        ["Bass width (dB)"] = "Ampiezza bassi (dB)",
        ["Could not apply Soundstage. Try again."] = "Impossibile applicare la scena sonora. Riprova.",
        ["Could not open preset list"] = "Impossibile aprire l'elenco dei preset",
        ["Could not open confirmation"] = "Impossibile aprire la conferma",
        ["Could not save Soundstage settings"] = "Impossibile salvare le impostazioni della scena sonora",
        ["Custom"] = "Personalizzato",
        ["Damping (%)"] = "Smorzamento (%)",
        ["Enabled"] = "Attivato",
        ["Focused center"] = "Centro a fuoco",
        ["Hall"] = "Sala",
        ["Natural"] = "Naturale",
        ["Player firmware is too old for Soundstage"] = "Il firmware del lettore è troppo vecchio per la scena sonora",
        ["Preset"] = "Preset",
        ["Reflections (%)"] = "Riflessioni (%)",
        ["Reset"] = "Ripristina",
        ["Reset Soundstage to defaults?"] = "Ripristinare la scena sonora ai valori predefiniti?",
        ["Reset to defaults"] = "Ripristina predefiniti",
        ["Room"] = "Stanza",
        ["Room size (%)"] = "Dimensioni stanza (%)",
        ["Side EQ"] = "EQ laterale",
        ["Side level (dB)"] = "Livello laterale (dB)",
        ["Small room"] = "Stanza piccola",
        ["Soundstage"] = "Scena sonora",
        ["Speaker angle (deg)"] = "Angolo altoparlanti (deg)",
        ["Studio monitors"] = "Monitor da studio",
        ["Treble frequency (Hz)"] = "Frequenza alti (Hz)",
        ["Treble width (dB)"] = "Ampiezza alti (dB)",
        ["Virtual speakers"] = "Altoparlanti virtuali",
        ["Wide"] = "Ampio",
    },
    ja = {
        ["Amount (%)"] = "適用量 (%)",
        ["Bass frequency (Hz)"] = "低音周波数 (Hz)",
        ["Bass width (dB)"] = "低音幅 (dB)",
        ["Could not apply Soundstage. Try again."] = "音場を適用できませんでした。再試行してください。",
        ["Could not open preset list"] = "プリセット一覧を開けませんでした",
        ["Could not open confirmation"] = "確認を開けませんでした",
        ["Could not save Soundstage settings"] = "音場の設定を保存できませんでした",
        ["Custom"] = "カスタム",
        ["Damping (%)"] = "ダンピング (%)",
        ["Enabled"] = "有効",
        ["Focused center"] = "フォーカスセンター",
        ["Hall"] = "ホール",
        ["Natural"] = "ナチュラル",
        ["Player firmware is too old for Soundstage"] = "プレーヤーのファームウェアが古いため音場を利用できません",
        ["Preset"] = "プリセット",
        ["Reflections (%)"] = "反射音 (%)",
        ["Reset"] = "リセット",
        ["Reset Soundstage to defaults?"] = "音場を初期値に戻しますか？",
        ["Reset to defaults"] = "初期値に戻す",
        ["Room"] = "ルーム",
        ["Room size (%)"] = "ルームサイズ (%)",
        ["Side EQ"] = "サイド EQ",
        ["Side level (dB)"] = "サイドレベル (dB)",
        ["Small room"] = "スモールルーム",
        ["Soundstage"] = "音場",
        ["Speaker angle (deg)"] = "スピーカー角度 (deg)",
        ["Studio monitors"] = "スタジオモニター",
        ["Treble frequency (Hz)"] = "高音周波数 (Hz)",
        ["Treble width (dB)"] = "高音幅 (dB)",
        ["Virtual speakers"] = "バーチャルスピーカー",
        ["Wide"] = "ワイド",
    },
    nl = {
        ["Amount (%)"] = "Hoeveelheid (%)",
        ["Bass frequency (Hz)"] = "Basfrequentie (Hz)",
        ["Bass width (dB)"] = "Basbreedte (dB)",
        ["Could not apply Soundstage. Try again."] = "Kon klankbeeld niet toepassen. Probeer het opnieuw.",
        ["Could not open preset list"] = "Kon presetlijst niet openen",
        ["Could not open confirmation"] = "Kon bevestiging niet openen",
        ["Could not save Soundstage settings"] = "Kon klankbeeld-instellingen niet opslaan",
        ["Custom"] = "Aangepast",
        ["Damping (%)"] = "Demping (%)",
        ["Enabled"] = "Ingeschakeld",
        ["Focused center"] = "Gefocust midden",
        ["Hall"] = "Zaal",
        ["Natural"] = "Natuurlijk",
        ["Player firmware is too old for Soundstage"] = "Speler-firmware is te oud voor Klankbeeld",
        ["Preset"] = "Preset",
        ["Reflections (%)"] = "Reflecties (%)",
        ["Reset"] = "Herstellen",
        ["Reset Soundstage to defaults?"] = "Klankbeeld herstellen naar standaardwaarden?",
        ["Reset to defaults"] = "Standaard herstellen",
        ["Room"] = "Ruimte",
        ["Room size (%)"] = "Ruimtegrootte (%)",
        ["Side EQ"] = "Side-EQ",
        ["Side level (dB)"] = "Side-niveau (dB)",
        ["Small room"] = "Kleine ruimte",
        ["Soundstage"] = "Klankbeeld",
        ["Speaker angle (deg)"] = "Luidsprekerhoek (deg)",
        ["Studio monitors"] = "Studiomonitors",
        ["Treble frequency (Hz)"] = "Treble-frequentie (Hz)",
        ["Treble width (dB)"] = "Treble-breedte (dB)",
        ["Virtual speakers"] = "Virtuele luidsprekers",
        ["Wide"] = "Breed",
    },
    pt = {
        ["Amount (%)"] = "Quantidade (%)",
        ["Bass frequency (Hz)"] = "Frequência dos graves (Hz)",
        ["Bass width (dB)"] = "Largura dos graves (dB)",
        ["Could not apply Soundstage. Try again."] = "Não foi possível aplicar o palco sonoro. Tente novamente.",
        ["Could not open preset list"] = "Não foi possível abrir a lista de predefinições",
        ["Could not open confirmation"] = "Não foi possível abrir a confirmação",
        ["Could not save Soundstage settings"] = "Não foi possível salvar as configurações do palco sonoro",
        ["Custom"] = "Personalizado",
        ["Damping (%)"] = "Amortecimento (%)",
        ["Enabled"] = "Ativado",
        ["Focused center"] = "Centro focado",
        ["Hall"] = "Salão",
        ["Natural"] = "Natural",
        ["Player firmware is too old for Soundstage"] = "O firmware do reprodutor é muito antigo para o palco sonoro",
        ["Preset"] = "Predefinição",
        ["Reflections (%)"] = "Reflexões (%)",
        ["Reset"] = "Restaurar",
        ["Reset Soundstage to defaults?"] = "Restaurar o palco sonoro para os padrões?",
        ["Reset to defaults"] = "Restaurar padrões",
        ["Room"] = "Sala",
        ["Room size (%)"] = "Tamanho da sala (%)",
        ["Side EQ"] = "EQ lateral",
        ["Side level (dB)"] = "Nível lateral (dB)",
        ["Small room"] = "Sala pequena",
        ["Soundstage"] = "Palco sonoro",
        ["Speaker angle (deg)"] = "Ângulo dos alto-falantes (deg)",
        ["Studio monitors"] = "Monitores de estúdio",
        ["Treble frequency (Hz)"] = "Frequência dos agudos (Hz)",
        ["Treble width (dB)"] = "Largura dos agudos (dB)",
        ["Virtual speakers"] = "Alto-falantes virtuais",
        ["Wide"] = "Amplo",
    },
    ru = {
        ["Amount (%)"] = "Интенсивность (%)",
        ["Bass frequency (Hz)"] = "Частота баса (Hz)",
        ["Bass width (dB)"] = "Ширина баса (dB)",
        ["Could not apply Soundstage. Try again."] = "Не удалось применить звуковую сцену. Повторите попытку.",
        ["Could not open preset list"] = "Не удалось открыть список пресетов",
        ["Could not open confirmation"] = "Не удалось открыть подтверждение",
        ["Could not save Soundstage settings"] = "Не удалось сохранить настройки звуковой сцены",
        ["Custom"] = "Пользовательский",
        ["Damping (%)"] = "Демпфирование (%)",
        ["Enabled"] = "Включено",
        ["Focused center"] = "Сфокусированный центр",
        ["Hall"] = "Зал",
        ["Natural"] = "Естественный",
        ["Player firmware is too old for Soundstage"] = "Прошивка плеера слишком старая для звуковой сцены",
        ["Preset"] = "Пресет",
        ["Reflections (%)"] = "Отражения (%)",
        ["Reset"] = "Сбросить",
        ["Reset Soundstage to defaults?"] = "Сбросить звуковую сцену по умолчанию?",
        ["Reset to defaults"] = "Сбросить",
        ["Room"] = "Комната",
        ["Room size (%)"] = "Размер комнаты (%)",
        ["Side EQ"] = "Боковой EQ",
        ["Side level (dB)"] = "Боковой уровень (dB)",
        ["Small room"] = "Маленькая комната",
        ["Soundstage"] = "Звуковая сцена",
        ["Speaker angle (deg)"] = "Угол динамиков (deg)",
        ["Studio monitors"] = "Студийные мониторы",
        ["Treble frequency (Hz)"] = "Частота ВЧ (Hz)",
        ["Treble width (dB)"] = "Ширина ВЧ (dB)",
        ["Virtual speakers"] = "Виртуальные динамики",
        ["Wide"] = "Широкий",
    },
    uk = {
        ["Amount (%)"] = "Інтенсивність (%)",
        ["Bass frequency (Hz)"] = "Частота баса (Hz)",
        ["Bass width (dB)"] = "Ширина баса (dB)",
        ["Could not apply Soundstage. Try again."] = "Не вдалося застосувати звукову сцену. Спробуйте ще раз.",
        ["Could not open preset list"] = "Не вдалося відкрити список пресетів",
        ["Could not open confirmation"] = "Не вдалося відкрити підтвердження",
        ["Could not save Soundstage settings"] = "Не вдалося зберегти налаштування звукової сцени",
        ["Custom"] = "Власний",
        ["Damping (%)"] = "Демпфування (%)",
        ["Enabled"] = "Увімкнено",
        ["Focused center"] = "Сфокусований центр",
        ["Hall"] = "Зал",
        ["Natural"] = "Природний",
        ["Player firmware is too old for Soundstage"] = "Прошивка плеєра застаріла для звукової сцени",
        ["Preset"] = "Пресет",
        ["Reflections (%)"] = "Відбиття (%)",
        ["Reset"] = "Скинути",
        ["Reset Soundstage to defaults?"] = "Скинути звукову сцену за замовчуванням?",
        ["Reset to defaults"] = "Скинути",
        ["Room"] = "Кімната",
        ["Room size (%)"] = "Розмір кімнати (%)",
        ["Side EQ"] = "Бічний EQ",
        ["Side level (dB)"] = "Бічний рівень (dB)",
        ["Small room"] = "Маленька кімната",
        ["Soundstage"] = "Звукова сцена",
        ["Speaker angle (deg)"] = "Кут динаміків (deg)",
        ["Studio monitors"] = "Студійні монітори",
        ["Treble frequency (Hz)"] = "Частота ВЧ (Hz)",
        ["Treble width (dB)"] = "Ширина ВЧ (dB)",
        ["Virtual speakers"] = "Віртуальні динаміки",
        ["Wide"] = "Широкий",
    },
    vi = {
        ["Amount (%)"] = "Mức độ (%)",
        ["Bass frequency (Hz)"] = "Tần số âm trầm (Hz)",
        ["Bass width (dB)"] = "Độ rộng âm trầm (dB)",
        ["Could not apply Soundstage. Try again."] = "Không thể áp dụng âm trường. Hãy thử lại.",
        ["Could not open preset list"] = "Không thể mở danh sách cài đặt sẵn",
        ["Could not open confirmation"] = "Không thể mở hộp xác nhận",
        ["Could not save Soundstage settings"] = "Không thể lưu cài đặt âm trường",
        ["Custom"] = "Tùy chỉnh",
        ["Damping (%)"] = "Độ suy giảm (%)",
        ["Enabled"] = "Đã bật",
        ["Focused center"] = "Tập trung trung tâm",
        ["Hall"] = "Hội trường",
        ["Natural"] = "Tự nhiên",
        ["Player firmware is too old for Soundstage"] = "Firmware của máy phát quá cũ đối với âm trường",
        ["Preset"] = "Cài đặt sẵn",
        ["Reflections (%)"] = "Phản xạ (%)",
        ["Reset"] = "Đặt lại",
        ["Reset Soundstage to defaults?"] = "Đặt lại âm trường về mặc định?",
        ["Reset to defaults"] = "Khôi phục mặc định",
        ["Room"] = "Phòng",
        ["Room size (%)"] = "Kích thước phòng (%)",
        ["Side EQ"] = "EQ kênh bên",
        ["Side level (dB)"] = "Mức kênh bên (dB)",
        ["Small room"] = "Phòng nhỏ",
        ["Soundstage"] = "Âm trường",
        ["Speaker angle (deg)"] = "Góc loa (deg)",
        ["Studio monitors"] = "Loa kiểm âm",
        ["Treble frequency (Hz)"] = "Tần số âm cao (Hz)",
        ["Treble width (dB)"] = "Độ rộng âm cao (dB)",
        ["Virtual speakers"] = "Loa ảo",
        ["Wide"] = "Rộng",
    },
    zh_CN = {
        ["Amount (%)"] = "强度 (%)",
        ["Bass frequency (Hz)"] = "低频频率 (Hz)",
        ["Bass width (dB)"] = "低频宽度 (dB)",
        ["Could not apply Soundstage. Try again."] = "无法应用声场，请重试。",
        ["Could not open preset list"] = "无法打开预设列表",
        ["Could not open confirmation"] = "无法打开确认窗口",
        ["Could not save Soundstage settings"] = "无法保存声场设置",
        ["Custom"] = "自定义",
        ["Damping (%)"] = "阻尼 (%)",
        ["Enabled"] = "已启用",
        ["Focused center"] = "聚焦中央",
        ["Hall"] = "大厅",
        ["Natural"] = "自然",
        ["Player firmware is too old for Soundstage"] = "播放器固件版本过低，无法使用声场",
        ["Preset"] = "预设",
        ["Reflections (%)"] = "反射 (%)",
        ["Reset"] = "重置",
        ["Reset Soundstage to defaults?"] = "将声场恢复为默认值？",
        ["Reset to defaults"] = "恢复默认",
        ["Room"] = "房间",
        ["Room size (%)"] = "房间大小 (%)",
        ["Side EQ"] = "侧边 EQ",
        ["Side level (dB)"] = "侧边电平 (dB)",
        ["Small room"] = "小房间",
        ["Soundstage"] = "声场",
        ["Speaker angle (deg)"] = "扬声器角度 (deg)",
        ["Studio monitors"] = "录音棚监听",
        ["Treble frequency (Hz)"] = "高频频率 (Hz)",
        ["Treble width (dB)"] = "高频宽度 (dB)",
        ["Virtual speakers"] = "虚拟扬声器",
        ["Wide"] = "宽广",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

local TITLE = "Soundstage"
local TOGGLE_ID = "soundstage"
local TOGGLE_ICON = "/usr/resource/litegui/theme2/launcher/music.png"

-- Native field name, allowed range, and the slider step used by the UI.
local RANGES = {
    speaker_angle_deg = { 10, 60 },
    binaural_amount = { 0, 1 },
    side_db = { -12, 6 },
    side_low_db = { -12, 6 },
    side_low_hz = { 50, 500 },
    side_high_db = { -12, 6 },
    side_high_hz = { 2000, 12000 },
    reflections = { 0, 1 },
    room_size = { 0, 1 },
    damping = { 0, 1 },
}
local FIELDS = {
    "speaker_angle_deg", "binaural_amount", "side_db", "side_low_db", "side_low_hz",
    "side_high_db", "side_high_hz", "reflections", "room_size", "damping",
}

-- Values a preset does not mention fall back to the native defaults.
local BASE = {
    speaker_angle_deg = 30, binaural_amount = 0, side_db = 0, side_low_db = 0,
    side_low_hz = 150, side_high_db = 0, side_high_hz = 5000,
    reflections = 0, room_size = 0.5, damping = 0.5,
}

local PRESETS = {
    { name = "Natural", v = { binaural_amount = 0.6, reflections = 0.15, room_size = 0.3, damping = 0.6 } },
    { name = "Studio monitors", v = { binaural_amount = 1, reflections = 0.25, room_size = 0.35, damping = 0.5 } },
    { name = "Small room", v = { binaural_amount = 0.8, reflections = 0.5, room_size = 0.3, damping = 0.6 } },
    { name = "Hall", v = { binaural_amount = 0.8, speaker_angle_deg = 35, reflections = 0.8, room_size = 1, damping = 0.4 } },
    { name = "Focused center", v = { binaural_amount = 1, speaker_angle_deg = 20, side_low_db = -6, side_low_hz = 150, reflections = 0.1 } },
    { name = "Wide", v = { binaural_amount = 1, speaker_angle_deg = 50, side_db = 3, side_high_db = 2, side_high_hz = 5000, reflections = 0.2, room_size = 0.5 } },
}
local DEFAULT_PRESET = 1
local CUSTOM = 0

local supported = plugin.has_capability("audio.soundstage")
    and plugin.has_capability("ui.settings_list_10_sliders")

local function clamp(key, x)
    local r = RANGES[key]
    if x < r[1] then return r[1] end
    if x > r[2] then return r[2] end
    return x
end

local function preset_values(index)
    local out = { enabled = false }
    for _, k in ipairs(FIELDS) do
        out[k] = PRESETS[index].v[k] or BASE[k]
    end
    return out
end

local function copy_state(s)
    local out = { enabled = s.enabled }
    for _, k in ipairs(FIELDS) do out[k] = s[k] end
    return out
end

local state = preset_values(DEFAULT_PRESET)
local preset = DEFAULT_PRESET

-- Persistence: one "key=value;..." string plus the preset index.
local function save()
    local parts = { "enabled=" .. (state.enabled and "1" or "0") }
    for _, k in ipairs(FIELDS) do
        parts[#parts + 1] = string.format("%s=%.4f", k, state[k])
    end
    local ok1 = plugin.storage.set("state", table.concat(parts, ";"))
    local ok2 = plugin.storage.set("preset", tostring(preset))
    return ok1 ~= false and ok2 ~= false
end

local function load()
    local raw = plugin.storage.get("state", "")
    if raw == "" then return end
    local loaded = preset_values(DEFAULT_PRESET)
    for key, val in raw:gmatch("([%w_]+)=([^;]+)") do
        local n = tonumber(val)
        if key == "enabled" then
            loaded.enabled = (val == "1")
        elseif RANGES[key] and n and n == n and n ~= math.huge and n ~= -math.huge then
            loaded[key] = clamp(key, n)
        end
    end
    state = loaded
    local p = tonumber(plugin.storage.get("preset", ""))
    if p and (p == CUSTOM or PRESETS[p]) then preset = p else preset = CUSTOM end
end

-- Applies a candidate state natively; returns true only when it was accepted.
local function native_apply(candidate)
    if not supported or not plugin.soundstage_apply_state then return false end
    local ok, result = pcall(plugin.soundstage_apply_state, candidate)
    return ok and result == true
end

-- Applies and saves a change. On refusal the previous values are restored.
local function commit(new_state, new_preset)
    if not native_apply(new_state) then
        plugin.show_toast(tr("Could not apply Soundstage. Try again."))
        return false
    end
    state, preset = new_state, new_preset
    if not save() then plugin.show_toast(tr("Could not save Soundstage settings")) end
    return true
end

local function sync_toggle()
    if supported and plugin.has_capability("ui.quick_toggle") then
        plugin.set_quick_toggle(TOGGLE_ID, state.enabled)
    end
end

local open_root, open_section

local function redraw(section)
    open_root({ update = true })
    if section then open_section(section, { update = true }) end
end

local function set_enabled(on)
    local s = copy_state(state)
    s.enabled = on
    local ok = commit(s, preset)
    sync_toggle()
    return ok
end

-- Slider helpers. step snaps the integer slider value; scale maps it to native.
local function snap(x, step)
    return math.floor(x / step + 0.5) * step
end

local function slider(section, key, label, min, max, step, scale)
    local shown = snap(state[key] / scale, step)
    shown = math.max(min, math.min(max, math.floor(shown + 0.5)))
    return {
        type = "slider",
        label = tr(label),
        min = min, max = max, value = shown,
        on_change = function(v)
            if snap(v, step) ~= shown then
                local s = copy_state(state)
                s[key] = clamp(key, snap(v, step) * scale)
                commit(s, CUSTOM)
            end
            redraw(section)
        end,
    }
end

local SECTIONS = {
    { id = "speakers", title = "Virtual speakers", rows = function(sec) return {
        slider(sec, "speaker_angle_deg", "Speaker angle (deg)", 10, 60, 5, 1),
        slider(sec, "binaural_amount", "Amount (%)", 0, 100, 1, 0.01),
    } end },
    { id = "side", title = "Side EQ", rows = function(sec) return {
        slider(sec, "side_db", "Side level (dB)", -12, 6, 1, 1),
        slider(sec, "side_low_db", "Bass width (dB)", -12, 6, 1, 1),
        slider(sec, "side_low_hz", "Bass frequency (Hz)", 50, 500, 10, 1),
        slider(sec, "side_high_db", "Treble width (dB)", -12, 6, 1, 1),
        slider(sec, "side_high_hz", "Treble frequency (Hz)", 2000, 12000, 500, 1),
    } end },
    { id = "room", title = "Room", rows = function(sec) return {
        slider(sec, "reflections", "Reflections (%)", 0, 100, 1, 0.01),
        slider(sec, "room_size", "Room size (%)", 0, 100, 1, 0.01),
        slider(sec, "damping", "Damping (%)", 0, 100, 1, 0.01),
    } end },
}

open_section = function(section, options)
    plugin.show_settings_list(tr(section.title), section.rows(section), options)
end

local function preset_name()
    if PRESETS[preset] then return tr(PRESETS[preset].name) end
    return tr("Custom")
end

local function choose_preset()
    local names = {}
    for i, p in ipairs(PRESETS) do names[i] = tr(p.name) end
    local ok = plugin.show_menu(tr("Preset"), names, function(index)
        local s = preset_values(index)
        s.enabled = state.enabled
        commit(s, index)
        redraw(nil)
    end, { selected = PRESETS[preset] and preset or nil })
    if not ok then plugin.show_toast(tr("Could not open preset list")) end
end

local function confirm_reset()
    local function do_reset()
        local s = preset_values(DEFAULT_PRESET)
        s.enabled = state.enabled
        commit(s, DEFAULT_PRESET)
        redraw(nil)
    end
    if not (plugin.has_capability("ui.confirmation") and plugin.show_confirmation) then
        do_reset()
        return
    end
    local ok = plugin.show_confirmation(tr("Reset Soundstage to defaults?"), tr("Reset"), do_reset)
    if not ok then plugin.show_toast(tr("Could not open confirmation")) end
end

open_root = function(options)
    local rows = {
        {
            type = "toggle",
            label = tr("Enabled"),
            value = state.enabled,
            on_change = function(on)
                if not set_enabled(on) then open_root({ update = true }) end
            end,
        },
        {
            type = "row",
            label = tr("Preset") .. ": " .. preset_name(),
            on_select = choose_preset,
        },
    }
    for _, section in ipairs(SECTIONS) do
        rows[#rows + 1] = {
            type = "row",
            label = tr(section.title),
            on_select = function() open_section(section) end,
        }
    end
    rows[#rows + 1] = {
        type = "row",
        label = tr("Reset to defaults"),
        on_select = confirm_reset,
    }
    plugin.show_settings_list(tr(TITLE), rows, options)
end

local function open_settings()
    if not supported then
        plugin.show_toast(tr("Player firmware is too old for Soundstage"))
        return
    end
    open_root()
end

plugin.register_list_item("music_audio", tr(TITLE), open_settings)

if supported then
    load()
    -- The native configuration is transient, so re-apply the saved one.
    if not native_apply(state) then
        plugin.show_toast(tr("Could not apply Soundstage. Try again."))
    end
    if plugin.has_capability("ui.quick_toggle") then
        plugin.register_quick_toggle(TOGGLE_ID, tr(TITLE), function(on)
            -- No redraw here: update = true opens the screen when it is not showing.
            if not set_enabled(on) then sync_toggle() end
        end, {
            icon = TOGGLE_ICON,
            value = state.enabled,
            on_hold = open_settings,
        })
    end
end
