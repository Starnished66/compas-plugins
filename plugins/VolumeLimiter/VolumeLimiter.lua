plugin.define({
    id = "compas.volume_limiter",
    name = "Volume Limiter",
    version = "1.2.0",
    api_min = 19,
})

local T = {
    de = {
        ["Volume Limiter"] = "Lautstärkebegrenzer",
        ["Volume Limiter enabled (cap %d%%)"] = "Lautstärkebegrenzer aktiviert (Limit %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Lautstärkebegrenzer aktiviert (Limit %d%%) nur für diese Sitzung (Speichern fehlgeschlagen)",
        ["Volume Limiter disabled"] = "Lautstärkebegrenzer deaktiviert",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Lautstärkebegrenzer nur für diese Sitzung deaktiviert (Speichern fehlgeschlagen)",
        ["Volume cap: %d%%"] = "Lautstärkelimit: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Lautstärkelimit: %d%% nur für diese Sitzung (Speichern fehlgeschlagen)",
        ["Sets a software maximum volume ceiling."] = "Legt eine softwareseitige maximale Lautstärkeobergrenze fest.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Begrenzt Lautstärkeänderungen über dem Limit lautlos und ohne Flash-Verschleiß.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Lautstärkemeldungen werden nativ in 500-ms-Intervallen zusammengefasst.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Hinweis: Nur Software-Begrenzer; bietet keinen zertifizierten Gehörschutz oder physische akustische Sicherheitsgarantien.",
        ["About Volume Limiter"] = "Über Lautstärkebegrenzer",
        ["Limiter Enabled"] = "Begrenzer aktiviert",
        ["Maximum Volume"] = "Maximale Lautstärke",
        ["Volume Limiter: Unsupported"] = "Lautstärkebegrenzer: Nicht unterstützt",
        ["Limiter requires silent and transient volume support"] = "Begrenzer erfordert Unterstützung für lautlose und temporäre Lautstärkeänderung",
    },
    es = {
        ["Volume Limiter"] = "Limitador de volumen",
        ["Volume Limiter enabled (cap %d%%)"] = "Limitador de volumen activado (límite %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Limitador de volumen activado (límite %d%%) solo en esta sesión (falló el guardado)",
        ["Volume Limiter disabled"] = "Limitador de volumen desactivado",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Limitador de volumen desactivado solo en esta sesión (falló el guardado)",
        ["Volume cap: %d%%"] = "Límite de volumen: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Límite de volumen: %d%% solo en esta sesión (falló el guardado)",
        ["Sets a software maximum volume ceiling."] = "Establece un límite máximo de volumen por software.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Limita silenciosamente los cambios de volumen que superen el tope sin desgaste de memoria.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Las notificaciones de volumen se agrupan de forma nativa cada 500 ms.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Aviso: Solo limitador por software; no ofrece protección auditiva certificada ni garantías acústicas de hardware.",
        ["About Volume Limiter"] = "Acerca de Limitador de volumen",
        ["Limiter Enabled"] = "Limitador activado",
        ["Maximum Volume"] = "Volumen máximo",
        ["Volume Limiter: Unsupported"] = "Limitador de volumen: No compatible",
        ["Limiter requires silent and transient volume support"] = "El limitador requiere soporte de volumen silencioso y transitorio",
    },
    fi = {
        ["Volume Limiter"] = "Äänenvoimakkuuden rajoitin",
        ["Volume Limiter enabled (cap %d%%)"] = "Äänenvoimakkuuden rajoitin käytössä (raja %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Äänenvoimakkuuden rajoitin käytössä (raja %d%%) vain tässä istunnossa (tallennus epäonnistui)",
        ["Volume Limiter disabled"] = "Äänenvoimakkuuden rajoitin pois käytöstä",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Äänenvoimakkuuden rajoitin pois käytöstä vain tässä istunnossa (tallennus epäonnistui)",
        ["Volume cap: %d%%"] = "Äänenvoimakkuusraja: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Äänenvoimakkuusraja: %d%% vain tässä istunnossa (tallennus epäonnistui)",
        ["Sets a software maximum volume ceiling."] = "Asettaa ohjelmistollisen enimmäisäänenvoimakkuuden rajan.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Rajoittaa rajan ylittävät äänenvoimakkuuden muutokset huomaamattomasti ilman muistin kulumista.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Äänenvoimakkuusilmoitukset yhdistetään natiivisti 500 ms:n välein.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Huomautus: Vain ohjelmistorajoitin; ei tarjoa sertifioitua kuulonsuojausta tai laitteistotason akustisia turvallisuustakeita.",
        ["About Volume Limiter"] = "Tietoja äänenvoimakkuuden rajoittimesta",
        ["Limiter Enabled"] = "Rajoitin käytössä",
        ["Maximum Volume"] = "Enimmäisäänenvoimakkuus",
        ["Volume Limiter: Unsupported"] = "Äänenvoimakkuuden rajoitin: Ei tuettu",
        ["Limiter requires silent and transient volume support"] = "Rajoitin vaatii hiljaisen ja väliaikaisen äänenvoimakkuuden tuen",
    },
    fr = {
        ["Volume Limiter"] = "Limiteur de volume",
        ["Volume Limiter enabled (cap %d%%)"] = "Limiteur de volume activé (plafond %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Limiteur de volume activé (plafond %d%%) pour cette session uniquement (échec d'enregistrement)",
        ["Volume Limiter disabled"] = "Limiteur de volume désactivé",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Limiteur de volume désactivé pour cette session uniquement (échec d'enregistrement)",
        ["Volume cap: %d%%"] = "Plafond de volume : %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Plafond de volume : %d%% pour cette session uniquement (échec d'enregistrement)",
        ["Sets a software maximum volume ceiling."] = "Définit un plafond de volume maximal logiciel.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Limite discrètement les changements de volume dépassant le plafond sans usure de la mémoire flash.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Les notifications de volume sont regroupées nativement par intervalles de 500 ms.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Remarque : Limiteur logiciel uniquement ; n'offre pas de protection auditive certifiée ni de garantie matérielle de sécurité acoustique.",
        ["About Volume Limiter"] = "À propos du Limiteur de volume",
        ["Limiter Enabled"] = "Limiteur activé",
        ["Maximum Volume"] = "Volume maximal",
        ["Volume Limiter: Unsupported"] = "Limiteur de volume : Non pris en charge",
        ["Limiter requires silent and transient volume support"] = "Le limiteur nécessite la prise en charge du volume silencieux et transitoire",
    },
    it = {
        ["Volume Limiter"] = "Limitatore di volume",
        ["Volume Limiter enabled (cap %d%%)"] = "Limitatore di volume attivato (limite %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Limitatore di volume attivato (limite %d%%) solo per questa sessione (salvataggio non riuscito)",
        ["Volume Limiter disabled"] = "Limitatore di volume disattivato",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Limitatore di volume disattivato solo per questa sessione (salvataggio non riuscito)",
        ["Volume cap: %d%%"] = "Limite volume: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Limite volume: %d%% solo per questa sessione (salvataggio non riuscito)",
        ["Sets a software maximum volume ceiling."] = "Imposta un tetto massimo di volume tramite software.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Limita silenziosamente le variazioni di volume che superano il tetto senza usurare la memoria flash.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Le notifiche del volume vengono raggruppate nativamente a intervalli di 500 ms.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Avviso: Solo limitatore software; non fornisce protezione uditiva certificata né garanzie hardware di sicurezza acustica.",
        ["About Volume Limiter"] = "Info su Limitatore di volume",
        ["Limiter Enabled"] = "Limitatore attivo",
        ["Maximum Volume"] = "Volume massimo",
        ["Volume Limiter: Unsupported"] = "Limitatore di volume: Non supportato",
        ["Limiter requires silent and transient volume support"] = "Il limitatore richiede il supporto al volume silenzioso e transitorio",
    },
    ja = {
        ["Volume Limiter"] = "音量リミッター",
        ["Volume Limiter enabled (cap %d%%)"] = "音量リミッター有効（上限 %d%%）",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "このセッションのみ音量リミッター有効（上限 %d%%、保存失敗）",
        ["Volume Limiter disabled"] = "音量リミッター無効",
        ["Volume Limiter disabled for this session only (storage failed)"] = "このセッションのみ音量リミッター無効（保存失敗）",
        ["Volume cap: %d%%"] = "音量上限: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "このセッションのみ音量上限: %d%%（保存失敗）",
        ["Sets a software maximum volume ceiling."] = "ソフトウェアによる最大音量の上限を設定します。",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "フラッシュメモリを消耗せず、上限を超える音量変更を静かに制限します。",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "音量通知はネイティブで 500ms 間隔にまとめられます。",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "注意: ソフトウェアリミッターのみであり、認定された聴覚保護やハードウェアの音響安全保証は提供しません。",
        ["About Volume Limiter"] = "音量リミッターについて",
        ["Limiter Enabled"] = "リミッターを有効化",
        ["Maximum Volume"] = "最大音量",
        ["Volume Limiter: Unsupported"] = "音量リミッター: 非対応",
        ["Limiter requires silent and transient volume support"] = "リミッターにはサイレントおよび一時的な音量変更のサポートが必要です",
    },
    nl = {
        ["Volume Limiter"] = "Volumebegrenzer",
        ["Volume Limiter enabled (cap %d%%)"] = "Volumebegrenzer ingeschakeld (limiet %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Volumebegrenzer alleen voor deze sessie ingeschakeld (limiet %d%%, opslaan mislukt)",
        ["Volume Limiter disabled"] = "Volumebegrenzer uitgeschakeld",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Volumebegrenzer alleen voor deze sessie uitgeschakeld (opslaan mislukt)",
        ["Volume cap: %d%%"] = "Volumelimiet: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Volumelimiet: %d%% alleen voor deze sessie (opslaan mislukt)",
        ["Sets a software maximum volume ceiling."] = "Stelt een softwarematig maximumvolume in.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Begrenst stil volumewijzigingen boven de limiet zonder flash-slijtage.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Volumemeldingen worden standaard elke 500 ms samengevoegd.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Let op: Alleen softwarematige begrenzer; biedt geen gecertificeerde gehoorbescherming of fysieke akoestische veiligheidsgaranties.",
        ["About Volume Limiter"] = "Over Volumebegrenzer",
        ["Limiter Enabled"] = "Begrenzer ingeschakeld",
        ["Maximum Volume"] = "Maximumvolume",
        ["Volume Limiter: Unsupported"] = "Volumebegrenzer: Niet ondersteund",
        ["Limiter requires silent and transient volume support"] = "Begrenzer vereist ondersteuning voor stil en tijdelijk volume",
    },
    pt = {
        ["Volume Limiter"] = "Limitador de volume",
        ["Volume Limiter enabled (cap %d%%)"] = "Limitador de volume ativado (limite %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Limitador de volume ativado (limite %d%%) apenas nesta sessão (falha ao salvar)",
        ["Volume Limiter disabled"] = "Limitador de volume desativado",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Limitador de volume desativado apenas nesta sessão (falha ao salvar)",
        ["Volume cap: %d%%"] = "Limite de volume: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Limite de volume: %d%% apenas nesta sessão (falha ao salvar)",
        ["Sets a software maximum volume ceiling."] = "Define um teto máximo de volume por software.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Limita silenciosamente alterações de volume acima do teto sem desgaste da memória flash.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "As notificações de volume são agrupadas nativamente em intervalos de 500 ms.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Aviso: Apenas limitador por software; não fornece proteção auditiva certificada nem garantias físicas de segurança acústica.",
        ["About Volume Limiter"] = "Sobre o Limitador de volume",
        ["Limiter Enabled"] = "Limitador ativado",
        ["Maximum Volume"] = "Volume máximo",
        ["Volume Limiter: Unsupported"] = "Limitador de volume: Não suportado",
        ["Limiter requires silent and transient volume support"] = "O limitador requer suporte a volume silencioso e transitório",
    },
    ru = {
        ["Volume Limiter"] = "Ограничитель громкости",
        ["Volume Limiter enabled (cap %d%%)"] = "Ограничитель громкости включён (предел %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Ограничитель громкости включён (предел %d%%) только на этот сеанс (ошибка сохранения)",
        ["Volume Limiter disabled"] = "Ограничитель громкости выключен",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Ограничитель громкости выключен только на этот сеанс (ошибка сохранения)",
        ["Volume cap: %d%%"] = "Предел громкости: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Предел громкости: %d%% только на этот сеанс (ошибка сохранения)",
        ["Sets a software maximum volume ceiling."] = "Задаёт программный потолок максимальной громкости.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Незаметно ограничивает превышение громкости без износа флеш-памяти.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Уведомления о громкости объединяются системой с интервалом 500 мс.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Примечание: только программный ограничитель; не обеспечивает сертифицированную защиту слуха или аппаратные гарантии акустической безопасности.",
        ["About Volume Limiter"] = "Об ограничителе громкости",
        ["Limiter Enabled"] = "Ограничитель включён",
        ["Maximum Volume"] = "Максимальная громкость",
        ["Volume Limiter: Unsupported"] = "Ограничитель громкости: не поддерживается",
        ["Limiter requires silent and transient volume support"] = "Для ограничителя требуется поддержка тихой и временной регулировки громкости",
    },
    uk = {
        ["Volume Limiter"] = "Обмежувач гучності",
        ["Volume Limiter enabled (cap %d%%)"] = "Обмежувач гучності увімкнено (межа %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Обмежувач гучності увімкнено (межа %d%%) лише на цей сеанс (помилка збереження)",
        ["Volume Limiter disabled"] = "Обмежувач гучності вимкнено",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Обмежувач гучності вимкнено лише на цей сеанс (помилка збереження)",
        ["Volume cap: %d%%"] = "Межа гучності: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Межа гучності: %d%% лише на цей сеанс (помилка збереження)",
        ["Sets a software maximum volume ceiling."] = "Встановлює програмну верхню межу максимальної гучності.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Непомітно обмежує перевищення гучності без зношення флеш-пам'яті.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Сповіщення про гучність об'єднуються системою з інтервалом 500 мс.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Примітка: лише програмний обмежувач; не забезпечує сертифікованого захисту слуху чи апаратних гарантій акустичної безпеки.",
        ["About Volume Limiter"] = "Про обмежувач гучності",
        ["Limiter Enabled"] = "Обмежувач увімкнено",
        ["Maximum Volume"] = "Максимальна гучність",
        ["Volume Limiter: Unsupported"] = "Обмежувач гучності: не підтримується",
        ["Limiter requires silent and transient volume support"] = "Для обмежувача потрібна підтримка тихої та тимчасової зміни гучності",
    },
    vi = {
        ["Volume Limiter"] = "Giới hạn âm lượng",
        ["Volume Limiter enabled (cap %d%%)"] = "Đã bật Giới hạn âm lượng (tối đa %d%%)",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "Đã bật Giới hạn âm lượng (tối đa %d%%) chỉ trong phiên này (lưu thất bại)",
        ["Volume Limiter disabled"] = "Đã tắt Giới hạn âm lượng",
        ["Volume Limiter disabled for this session only (storage failed)"] = "Đã tắt Giới hạn âm lượng chỉ trong phiên này (lưu thất bại)",
        ["Volume cap: %d%%"] = "Giới hạn âm lượng: %d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "Giới hạn âm lượng: %d%% chỉ trong phiên này (lưu thất bại)",
        ["Sets a software maximum volume ceiling."] = "Đặt mức trần âm lượng tối đa bằng phần mềm.",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "Âm thầm giới hạn các thay đổi âm lượng vượt mức trần mà không làm hao mòn bộ nhớ flash.",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "Thông báo âm lượng được gộp tự nhiên theo chu kỳ 500ms.",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "Lưu ý: Chỉ là bộ giới hạn phần mềm; không cung cấp bảo vệ thính giác được chứng nhận hay đảm bảo an toàn âm thanh phần cứng.",
        ["About Volume Limiter"] = "Giới thiệu về Giới hạn âm lượng",
        ["Limiter Enabled"] = "Bật giới hạn",
        ["Maximum Volume"] = "Âm lượng tối đa",
        ["Volume Limiter: Unsupported"] = "Giới hạn âm lượng: Không hỗ trợ",
        ["Limiter requires silent and transient volume support"] = "Bộ giới hạn cần hỗ trợ thay đổi âm lượng ẩn và tạm thời",
    },
    zh_CN = {
        ["Volume Limiter"] = "音量限制器",
        ["Volume Limiter enabled (cap %d%%)"] = "音量限制器已启用（上限 %d%%）",
        ["Volume Limiter enabled (cap %d%%) for this session only (storage failed)"] = "音量限制器仅在本次会话中启用（上限 %d%%，保存失败）",
        ["Volume Limiter disabled"] = "音量限制器已禁用",
        ["Volume Limiter disabled for this session only (storage failed)"] = "音量限制器仅在本次会话中禁用（保存失败）",
        ["Volume cap: %d%%"] = "音量上限：%d%%",
        ["Volume cap: %d%% for this session only (storage failed)"] = "音量上限：%d%%（仅本次会话，保存失败）",
        ["Sets a software maximum volume ceiling."] = "设置软件最大音量上限。",
        ["Quietly clamps volume changes that exceed the cap without flash wear."] = "静默限制超过上限的音量变化，且不磨损闪存。",
        ["Volume notifications are coalesced at 500ms intervals natively."] = "系统原生以 500 毫秒间隔合并音量通知。",
        ["Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."] = "注意：仅为软件限制器；不提供经过认证的听力保护或硬件级声学安全保障。",
        ["About Volume Limiter"] = "关于音量限制器",
        ["Limiter Enabled"] = "启用限制器",
        ["Maximum Volume"] = "最大音量",
        ["Volume Limiter: Unsupported"] = "音量限制器：不支持",
        ["Limiter requires silent and transient volume support"] = "限制器需要静默和临时音量控制支持",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- Sets a software maximum volume ceiling and quietly clamps playback volume
-- without intrusive popups or saving transient overshoots to flash.

local DEFAULT_MAX_VOLUME = 70
local enabled = false
local max_volume = DEFAULT_MAX_VOLUME
local in_clamp = false

local function is_finite_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function clamp_volume_setting(value)
    local n = tonumber(value)
    if not is_finite_number(n) then return DEFAULT_MAX_VOLUME end
    n = math.floor(n)
    if n < 0 then return 0 end
    if n > 100 then return 100 end
    return n
end

local function is_supported()
    return plugin.has_capability("playback.silent_volume")
        and plugin.has_capability("playback.transient_volume")
end

local function decode_json(text)
    if type(text) ~= "string" or #text > 4096 then return nil end
    if not plugin.json_decode then return nil end
    local ok, res = pcall(plugin.json_decode, text)
    if ok and type(res) == "table" then return res end
    return nil
end

local function load_state()
    if not (plugin.storage and plugin.storage.get) then return end
    local content = nil
    pcall(function()
        content = plugin.storage.get("config")
    end)
    if not content or content == "" or #content > 4096 then return end
    local data = decode_json(content)
    if type(data) == "table"
        and data.version == 1
        and type(data.enabled) == "boolean"
        and is_finite_number(tonumber(data.max_volume)) then
        enabled = data.enabled
        max_volume = clamp_volume_setting(data.max_volume)
    end
end

local function save_state()
    if not (plugin.storage and plugin.storage.set) then
        return false
    end
    local encoded = nil
    if plugin.json_encode then
        local ok, res = pcall(plugin.json_encode, {
            version = 1,
            enabled = enabled,
            max_volume = max_volume,
        })
        if ok and type(res) == "string" then
            encoded = res
        end
    end
    if not encoded then return false end
    local ok, err = plugin.storage.set("config", encoded)
    if not ok then
        return false
    end
    return true
end

local function apply_clamp(target_percent)
    if in_clamp then return end
    if not is_supported() then return end
    -- Another volume tool may already have lowered a coalesced notification's
    -- value. A ceiling must never raise the current live volume.
    local live = plugin.get_volume()
    if not is_finite_number(live) or live <= target_percent then return end
    in_clamp = true
    pcall(function()
        -- Silent and transient: avoids screen popup and avoids flash writes on repeated overshoots
        plugin.set_volume(target_percent, { silent = true, persist = false })
    end)
    in_clamp = false
end

local function check_and_clamp(current_percent)
    if not enabled then return end
    local cur = current_percent
    if cur == nil then
        cur = plugin.get_volume()
    end
    if cur and is_finite_number(cur) and cur > max_volume then
        apply_clamp(max_volume)
    end
end

local function set_enabled(value)
    enabled = (value == true)
    local saved = save_state()
    if enabled then
        check_and_clamp()
        if saved then
            plugin.show_toast(string.format(tr("Volume Limiter enabled (cap %d%%)"), max_volume))
        else
            plugin.show_toast(string.format(tr("Volume Limiter enabled (cap %d%%) for this session only (storage failed)"), max_volume))
        end
    else
        if saved then
            plugin.show_toast(tr("Volume Limiter disabled"))
        else
            plugin.show_toast(tr("Volume Limiter disabled for this session only (storage failed)"))
        end
    end
end

local function set_max_volume(value)
    max_volume = clamp_volume_setting(value)
    local saved = save_state()
    if enabled then
        check_and_clamp()
    end
    if saved then
        plugin.show_toast(string.format(tr("Volume cap: %d%%"), max_volume))
    else
        plugin.show_toast(string.format(tr("Volume cap: %d%% for this session only (storage failed)"), max_volume))
    end
end

-- volume_changed callback: native events are coalesced at 500ms intervals
plugin.on("volume_changed", function(percent)
    if in_clamp then return end
    if not enabled then return end
    if type(percent) ~= "number" or not is_finite_number(percent) then return end
    if percent > max_volume then
        apply_clamp(max_volume)
    end
end)

local function open_about()
    local about_lines = {
        tr("Sets a software maximum volume ceiling."),
        tr("Quietly clamps volume changes that exceed the cap without flash wear."),
        tr("Volume notifications are coalesced at 500ms intervals natively."),
        tr("Notice: Software limiter only; does not provide certified hearing protection or physical hardware acoustic safety guarantees."),
    }
    plugin.show_list(tr("About Volume Limiter"), about_lines, function() end)
end

local function open_settings()
    local items = {}
    if is_supported() then
        items[#items + 1] = {
            type = "toggle",
            label = tr("Limiter Enabled"),
            value = enabled,
            on_change = set_enabled,
        }
        items[#items + 1] = {
            type = "slider",
            label = tr("Maximum Volume"),
            min = 0,
            max = 100,
            value = max_volume,
            on_change = set_max_volume,
        }
    else
        items[#items + 1] = {
            type = "row",
            label = tr("Volume Limiter: Unsupported"),
            on_select = function()
                plugin.show_toast(tr("Limiter requires silent and transient volume support"))
            end,
        }
    end
    items[#items + 1] = {
        type = "row",
        label = tr("About Volume Limiter"),
        on_select = open_about,
    }
    plugin.show_settings_list(tr("Volume Limiter"), items)
end

load_state()
-- Firmware restores startup volume before loading plugins; enforce the saved
-- ceiling before the initial native volume-event baseline is captured.
check_and_clamp()

plugin.register_list_item("music_audio", tr("Volume Limiter"), open_settings)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        open_settings = open_settings,
        set_enabled = set_enabled,
        set_max_volume = set_max_volume,
        is_enabled = function() return enabled end,
        get_max_volume = function() return max_volume end,
        check_and_clamp = check_and_clamp,
        apply_clamp = apply_clamp,
        is_in_clamp = function() return in_clamp end,
        save_state = save_state,
        load_state = load_state,
    }
end
