plugin.define({
    id = "org.compas.output_aware_sound",
    name = "Output-Aware Sound",
    version = "1.2.0",
    api_min = 19,
})

local T = {
    de = {
        ["Failed to encode configuration"] = "Konfiguration konnte nicht kodiert werden",
        ["Failed to save settings to storage; changes are live for this session only"] = "Einstellungen konnten nicht gespeichert werden; Änderungen gelten nur für diese Sitzung",
        ["Storage unavailable; changes are live for this session only"] = "Speicher nicht verfügbar; Änderungen gelten nur für diese Sitzung",
        ["Manual or external EQ change detected"] = "Manuelle oder externe EQ-Änderung erkannt",
        ["(None / Clear)"] = "(Keine / Löschen)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Richtlinien für ausgabeabhängigen Klang:\n\n• EQ-Vorrang: Werden EQ-Einstellungen manuell oder durch AutoEQ geändert, pausiert die Automatik sofort.\n• Temporäre Profile: Wendet PEQ-Profile an, ohne sie im Flash zu speichern ({persist = false}).\n• Vorverstärkung & Gain: Im .peq-Profil enthalten; eq_set_preamp wird beim Wechsel nicht aufgerufen.\n• Gehörschutz: Passt die Lautstärke nicht automatisch an.\n• Nicht zugewiesene Ausgänge: Stellt beim Wechsel zu einem nicht zugewiesenen Ausgang den Ausgangszustand wieder her.\n• Audioformate: Profile passen den Frequenzgang an; keine Bit-Perfect-Ausgabe.",
        ["Sound & Safety Policy"] = "Klang- & Sicherheitsrichtlinie",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "Temporärer PEQ pro Ausgang; sichere Lautstärke, nicht bit-perfect",
        ["Disabled"] = "Deaktiviert",
        ["Suspended (%s)"] = "Pausiert (%s)",
        ["External change"] = "Externe Änderung",
        ["Active: %s"] = "Aktiv: %s",
        ["Active"] = "Aktiv",
        ["Detecting..."] = "Erkenne...",
        ["Wired Headphones"] = "Kabelkopfhörer",
        ["USB DAC"] = "USB-DAC",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (Standard-Fallback)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (Unbekannter Codec)",
        ["Enabled"] = "Aktiviert",
        ["Status: %s"] = "Status: %s",
        ["Output-Aware Sound reclaimed"] = "Ausgabeabhängiger Klang wieder übernommen",
        ["Current Route: %s"] = "Aktueller Ausgang: %s",
        ["None"] = "Keine",
        ["Profile for %s"] = "Profil für %s",
        ["Policy & Safety Info"] = "Richtlinien & Sicherheit",
        ["Output-Aware Sound"] = "Ausgabeabhängiger Klang",
    },
    es = {
        ["Failed to encode configuration"] = "No se pudo codificar la configuración",
        ["Failed to save settings to storage; changes are live for this session only"] = "No se pudieron guardar los ajustes; los cambios solo se aplican en esta sesión",
        ["Storage unavailable; changes are live for this session only"] = "Almacenamiento no disponible; los cambios solo se aplican en esta sesión",
        ["Manual or external EQ change detected"] = "Cambio de EQ manual o externo detectado",
        ["(None / Clear)"] = "(Ninguno / Borrar)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Pautas de Sonido según salida:\n\n• Control del EQ: Si cambias los ajustes de EQ manualmente o mediante AutoEQ Context, la automatización se suspende de inmediato para evitar conflictos.\n• Perfiles transitorios: Aplica perfiles PEQ sin guardarlos en la memoria flash ({persist = false}).\n• Preamp y ganancia: Incluidos en los perfiles .peq; nunca se llama a eq_set_preamp al cambiar.\n• Seguridad auditiva: No ajusta el volumen automáticamente.\n• Salidas sin asignar: Restaura la base guardada al cambiar a una salida sin perfil.\n• Formatos de audio: Los perfiles ajustan la curva tonal; no ofrece salida bit-perfect.",
        ["Sound & Safety Policy"] = "Política de sonido y seguridad",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "PEQ transitorio por salida; volumen seguro, no bit-perfect",
        ["Disabled"] = "Desactivado",
        ["Suspended (%s)"] = "Suspendido (%s)",
        ["External change"] = "Cambio externo",
        ["Active: %s"] = "Activo: %s",
        ["Active"] = "Activo",
        ["Detecting..."] = "Detectando...",
        ["Wired Headphones"] = "Auriculares con cable",
        ["USB DAC"] = "DAC USB",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (reserva predeterminada)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (códec desconocido)",
        ["Enabled"] = "Activado",
        ["Status: %s"] = "Estado: %s",
        ["Output-Aware Sound reclaimed"] = "Control de Sonido según salida recuperado",
        ["Current Route: %s"] = "Salida actual: %s",
        ["None"] = "Ninguno",
        ["Profile for %s"] = "Perfil para %s",
        ["Policy & Safety Info"] = "Información de política y seguridad",
        ["Output-Aware Sound"] = "Sonido según salida",
    },
    fi = {
        ["Failed to encode configuration"] = "Asetusten koodaus epäonnistui",
        ["Failed to save settings to storage; changes are live for this session only"] = "Asetusten tallennus epäonnistui; muutokset ovat voimassa vain tämän istunnon ajan",
        ["Storage unavailable; changes are live for this session only"] = "Tallennustila ei käytettävissä; muutokset ovat voimassa vain tämän istunnon ajan",
        ["Manual or external EQ change detected"] = "Manuaalinen tai ulkoinen EQ-muutos havaittu",
        ["(None / Clear)"] = "(Ei mitään / Tyhjennä)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Lähtökohtaisen äänen ohjeet:\n\n• EQ-hallinta: Jos EQ-asetuksia muutetaan käsin tai AutoEQ Contextilla, automatiikka keskeytyy heti ristiriitojen estämiseksi.\n• Väliaikaiset profiilit: Ottaa PEQ-profiilit käyttöön tallentamatta flash-muistiin ({persist = false}).\n• Esivahvistus ja vahvistus: Sisältyvät .peq-profiileihin; eq_set_preampia ei kutsuta vaihdon yhteydessä.\n• Kuuloturvallisuus: Ei säädä äänenvoimakkuutta automaattisesti.\n• Määrittämättömät lähdöt: Palauttaa perustilan siirryttäessä määrittämättömään lähtöön.\n• Äänimuodot: Profiilit säätävät äänikäyrää; ei lupaa bit-perfect-toistoa.",
        ["Sound & Safety Policy"] = "Ääni- ja turvallisuuskäytäntö",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "Väliaikainen PEQ per lähtö; turvallinen äänenvoimakkuus, ei bit-perfect",
        ["Disabled"] = "Pois käytöstä",
        ["Suspended (%s)"] = "Keskeytetty (%s)",
        ["External change"] = "Ulkoinen muutos",
        ["Active: %s"] = "Aktiivinen: %s",
        ["Active"] = "Aktiivinen",
        ["Detecting..."] = "Tunnistetaan...",
        ["Wired Headphones"] = "Langalliset kuulokkeet",
        ["USB DAC"] = "USB-DAC",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (oletusvaravalinta)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (tuntematon koodekki)",
        ["Enabled"] = "Käytössä",
        ["Status: %s"] = "Tila: %s",
        ["Output-Aware Sound reclaimed"] = "Lähtökohtainen ääni otettu taas hallintaan",
        ["Current Route: %s"] = "Nykyinen lähtö: %s",
        ["None"] = "Ei mitään",
        ["Profile for %s"] = "Profiili: %s",
        ["Policy & Safety Info"] = "Käytäntö ja turvallisuustiedot",
        ["Output-Aware Sound"] = "Lähtökohtainen ääni",
    },
    fr = {
        ["Failed to encode configuration"] = "Échec de l'encodage de la configuration",
        ["Failed to save settings to storage; changes are live for this session only"] = "Échec de la sauvegarde ; les modifications ne s'appliquent qu'à cette session",
        ["Storage unavailable; changes are live for this session only"] = "Stockage indisponible ; les modifications ne s'appliquent qu'à cette session",
        ["Manual or external EQ change detected"] = "Modification d'EQ manuelle ou externe détectée",
        ["(None / Clear)"] = "(Aucun / Effacer)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Principes du Son selon la sortie :\n\n• Priorité EQ : Si l'EQ est modifié manuellement ou par AutoEQ Context, l'automatisation est immédiatement suspendue.\n• Profils transitoires : Applique les profils PEQ sans écrire en mémoire flash ({persist = false}).\n• Préampli et gain : Inclus dans les fichiers .peq ; eq_set_preamp n'est jamais appelé lors d'une transition.\n• Sécurité auditive : Ne modifie pas le volume automatiquement.\n• Sorties non associées : Restaure l'EQ de base lors du passage à une sortie sans profil.\n• Formats audio : Les profils ajustent la courbe tonale ; ne garantit pas une sortie bit-perfect.",
        ["Sound & Safety Policy"] = "Politique audio et sécurité",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "PEQ transitoire par sortie ; volume sûr, non bit-perfect",
        ["Disabled"] = "Désactivé",
        ["Suspended (%s)"] = "Suspendu (%s)",
        ["External change"] = "Modification externe",
        ["Active: %s"] = "Actif : %s",
        ["Active"] = "Actif",
        ["Detecting..."] = "Détection...",
        ["Wired Headphones"] = "Casque filaire",
        ["USB DAC"] = "DAC USB",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (repli par défaut)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (codec inconnu)",
        ["Enabled"] = "Activé",
        ["Status: %s"] = "État : %s",
        ["Output-Aware Sound reclaimed"] = "Contrôle du Son selon la sortie repris",
        ["Current Route: %s"] = "Sortie actuelle : %s",
        ["None"] = "Aucun",
        ["Profile for %s"] = "Profil pour %s",
        ["Policy & Safety Info"] = "Politique et sécurité",
        ["Output-Aware Sound"] = "Son selon la sortie",
    },
    it = {
        ["Failed to encode configuration"] = "Impossibile codificare la configurazione",
        ["Failed to save settings to storage; changes are live for this session only"] = "Impossibile salvare le impostazioni; le modifiche valgono solo per questa sessione",
        ["Storage unavailable; changes are live for this session only"] = "Archiviazione non disponibile; le modifiche valgono solo per questa sessione",
        ["Manual or external EQ change detected"] = "Rilevata modifica EQ manuale o esterna",
        ["(None / Clear)"] = "(Nessuno / Cancella)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Linee guida Suono in base all'uscita:\n\n• Controllo EQ: Se l'EQ viene modificato manualmente o da AutoEQ Context, l'automazione si sospende subito per evitare conflitti.\n• Profili transitori: Applica i profili PEQ senza salvarli nella memoria flash ({persist = false}).\n• Preamp e guadagno: Inclusi nei profili .peq; eq_set_preamp non viene mai chiamato al cambio.\n• Sicurezza uditiva: Non regola il volume automaticamente.\n• Uscite non associate: Ripristina l'EQ di base passando a un'uscita non associata.\n• Formati audio: I profili regolano la curva tonale; non garantisce uscita bit-perfect.",
        ["Sound & Safety Policy"] = "Politica audio e sicurezza",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "PEQ transitorio per uscita; volume sicuro, non bit-perfect",
        ["Disabled"] = "Disattivato",
        ["Suspended (%s)"] = "Sospeso (%s)",
        ["External change"] = "Modifica esterna",
        ["Active: %s"] = "Attivo: %s",
        ["Active"] = "Attivo",
        ["Detecting..."] = "Rilevamento...",
        ["Wired Headphones"] = "Cuffie cablate",
        ["USB DAC"] = "DAC USB",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (fallback predefinito)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (codec sconosciuto)",
        ["Enabled"] = "Attivato",
        ["Status: %s"] = "Stato: %s",
        ["Output-Aware Sound reclaimed"] = "Controllo Suono in base all'uscita ripristinato",
        ["Current Route: %s"] = "Uscita attuale: %s",
        ["None"] = "Nessuno",
        ["Profile for %s"] = "Profilo per %s",
        ["Policy & Safety Info"] = "Info su politica e sicurezza",
        ["Output-Aware Sound"] = "Suono in base all'uscita",
    },
    ja = {
        ["Failed to encode configuration"] = "設定のエンコードに失敗しました",
        ["Failed to save settings to storage; changes are live for this session only"] = "設定を保存できませんでした。変更は今回のセッションのみ有効です",
        ["Storage unavailable; changes are live for this session only"] = "ストレージを利用できません。変更は今回のセッションのみ有効です",
        ["Manual or external EQ change detected"] = "手動または外部による EQ 変更を検出しました",
        ["(None / Clear)"] = "(なし / クリア)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "出力連動サウンドのガイドライン:\n\n• EQ の優先権: 手動または AutoEQ Context で EQ が変更されると、競合を防ぐため自動切替はただちに一時停止します。\n• 一時プロファイル: フラッシュに保存せず PEQ プロファイルを適用します ({persist = false})。\n• プリアンプとゲイン: .peq 内に含まれ、切替時に eq_set_preamp は呼び出されません。\n• 聴覚保護: 音量の自動変更は行いません。\n• 未設定の出力先: 未設定の出力先に切り替わると元の EQ 状態に戻します。\n• 音声フォーマット: トーンカーブを調整するもので、ビットパーフェクト出力ではありません。",
        ["Sound & Safety Policy"] = "サウンドと安全ポリシー",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "出力別の一時 PEQ・安全な音量・非ビットパーフェクト",
        ["Disabled"] = "無効",
        ["Suspended (%s)"] = "一時停止 (%s)",
        ["External change"] = "外部変更",
        ["Active: %s"] = "有効: %s",
        ["Active"] = "有効",
        ["Detecting..."] = "検出中...",
        ["Wired Headphones"] = "有線ヘッドホン",
        ["USB DAC"] = "USB DAC",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (標準フォールバック)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (不明なコーデック)",
        ["Enabled"] = "有効",
        ["Status: %s"] = "状態: %s",
        ["Output-Aware Sound reclaimed"] = "出力連動サウンドの制御を再開しました",
        ["Current Route: %s"] = "現在の出力: %s",
        ["None"] = "なし",
        ["Profile for %s"] = "%s のプロファイル",
        ["Policy & Safety Info"] = "ポリシーと安全情報",
        ["Output-Aware Sound"] = "出力連動サウンド",
    },
    nl = {
        ["Failed to encode configuration"] = "Configuratie coderen mislukt",
        ["Failed to save settings to storage; changes are live for this session only"] = "Instellingen opslaan mislukt; wijzigingen gelden alleen voor deze sessie",
        ["Storage unavailable; changes are live for this session only"] = "Opslag niet beschikbaar; wijzigingen gelden alleen voor deze sessie",
        ["Manual or external EQ change detected"] = "Handmatige of externe EQ-wijziging gedetecteerd",
        ["(None / Clear)"] = "(Geen / Wissen)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Richtlijnen voor Uitgangsbewust geluid:\n\n• EQ-eigendom: Als EQ-instellingen handmatig of door AutoEQ Context worden gewijzigd, pauzeert de automatisering direct.\n• Tijdelijke profielen: Past PEQ-profielen toe zonder naar flash te schrijven ({persist = false}).\n• Preamp & gain: Opgenomen in .peq-profielen; eq_set_preamp wordt niet per overgang aangeroepen.\n• Gehoorveiligheid: Past het volume niet automatisch aan.\n• Niet-gekoppelde uitgangen: Herstelt de basis-EQ bij overschakelen naar een uitgang zonder profiel.\n• Audioformaten: Profielen passen de klankcurve aan; geen bit-perfect uitvoer.",
        ["Sound & Safety Policy"] = "Geluids- en veiligheidsbeleid",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "Tijdelijke PEQ per uitgang; veilig volume, niet bit-perfect",
        ["Disabled"] = "Uitgeschakeld",
        ["Suspended (%s)"] = "Gepauzeerd (%s)",
        ["External change"] = "Externe wijziging",
        ["Active: %s"] = "Actief: %s",
        ["Active"] = "Actief",
        ["Detecting..."] = "Detecteren...",
        ["Wired Headphones"] = "Bedrade hoofdtelefoon",
        ["USB DAC"] = "USB-DAC",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (standaardterugval)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (onbekende codec)",
        ["Enabled"] = "Ingeschakeld",
        ["Status: %s"] = "Status: %s",
        ["Output-Aware Sound reclaimed"] = "Uitgangsbewust geluid hervat",
        ["Current Route: %s"] = "Huidige uitgang: %s",
        ["None"] = "Geen",
        ["Profile for %s"] = "Profiel voor %s",
        ["Policy & Safety Info"] = "Beleid en veiligheidsinfo",
        ["Output-Aware Sound"] = "Uitgangsbewust geluid",
    },
    pt = {
        ["Failed to encode configuration"] = "Falha ao codificar a configuração",
        ["Failed to save settings to storage; changes are live for this session only"] = "Falha ao salvar configurações; as alterações valem apenas nesta sessão",
        ["Storage unavailable; changes are live for this session only"] = "Armazenamento indisponível; as alterações valem apenas nesta sessão",
        ["Manual or external EQ change detected"] = "Alteração manual ou externa de EQ detectada",
        ["(None / Clear)"] = "(Nenhum / Limpar)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Diretrizes do Som por saída:\n\n• Controle do EQ: Se o EQ for alterado manualmente ou pelo AutoEQ Context, a automação é suspensa imediatamente para evitar conflitos.\n• Perfis transitórios: Aplica perfis PEQ sem gravar na memória flash ({persist = false}).\n• Pré-amplificação e ganho: Contidos nos perfis .peq; eq_set_preamp nunca é chamado na transição.\n• Segurança auditiva: Não ajusta o volume automaticamente.\n• Saídas sem perfil: Restaura o EQ base ao mudar para uma saída não mapeada.\n• Formatos de áudio: Os perfis ajustam a curva tonal; não garante saída bit-perfect.",
        ["Sound & Safety Policy"] = "Política de som e segurança",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "PEQ transitório por saída; volume seguro, não bit-perfect",
        ["Disabled"] = "Desativado",
        ["Suspended (%s)"] = "Suspenso (%s)",
        ["External change"] = "Alteração externa",
        ["Active: %s"] = "Ativo: %s",
        ["Active"] = "Ativo",
        ["Detecting..."] = "Detectando...",
        ["Wired Headphones"] = "Fones com fio",
        ["USB DAC"] = "USB DAC",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (padrão de reserva)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (codec desconhecido)",
        ["Enabled"] = "Ativado",
        ["Status: %s"] = "Status: %s",
        ["Output-Aware Sound reclaimed"] = "Controle do Som por saída retomado",
        ["Current Route: %s"] = "Saída atual: %s",
        ["None"] = "Nenhum",
        ["Profile for %s"] = "Perfil para %s",
        ["Policy & Safety Info"] = "Política e segurança",
        ["Output-Aware Sound"] = "Som por saída",
    },
    ru = {
        ["Failed to encode configuration"] = "Не удалось закодировать конфигурацию",
        ["Failed to save settings to storage; changes are live for this session only"] = "Не удалось сохранить настройки; изменения действуют только в этом сеансе",
        ["Storage unavailable; changes are live for this session only"] = "Хранилище недоступно; изменения действуют только в этом сеансе",
        ["Manual or external EQ change detected"] = "Обнаружено ручное или внешнее изменение EQ",
        ["(None / Clear)"] = "(Нет / Очистить)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Правила Звука по выходу:\n\n• Приоритет EQ: Если настройки EQ изменены вручную или через AutoEQ Context, автоматика сразу приостанавливается.\n• Временные профили: Применяет профили PEQ без записи во флеш-память ({persist = false}).\n• Предусиление и гейн: Хранятся внутри профилей .peq; eq_set_preamp не вызывается при переключении.\n• Безопасность слуха: Не меняет громкость автоматически.\n• Неназначенные выходы: Восстанавливает исходный EQ при переходе на выход без профиля.\n• Аудиоформаты: Профили меняют АЧХ; режим bit-perfect не заявлен.",
        ["Sound & Safety Policy"] = "Политика звука и безопасности",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "Временный PEQ для выхода; безопасная громкость, не bit-perfect",
        ["Disabled"] = "Отключено",
        ["Suspended (%s)"] = "Приостановлено (%s)",
        ["External change"] = "Внешнее изменение",
        ["Active: %s"] = "Активно: %s",
        ["Active"] = "Активно",
        ["Detecting..."] = "Определение...",
        ["Wired Headphones"] = "Проводные наушники",
        ["USB DAC"] = "USB ЦАП",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (резервный по умолчанию)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (неизвестный кодек)",
        ["Enabled"] = "Включено",
        ["Status: %s"] = "Статус: %s",
        ["Output-Aware Sound reclaimed"] = "Управление Звуком по выходу восстановлено",
        ["Current Route: %s"] = "Текущий выход: %s",
        ["None"] = "Нет",
        ["Profile for %s"] = "Профиль для %s",
        ["Policy & Safety Info"] = "Политика и безопасность",
        ["Output-Aware Sound"] = "Звук по выходу",
    },
    uk = {
        ["Failed to encode configuration"] = "Не вдалося закодувати конфігурацію",
        ["Failed to save settings to storage; changes are live for this session only"] = "Не вдалося зберегти налаштування; зміни діють лише в цьому сеансі",
        ["Storage unavailable; changes are live for this session only"] = "Сховище недоступне; зміни діють лише в цьому сеансі",
        ["Manual or external EQ change detected"] = "Виявлено ручну або зовнішню зміну EQ",
        ["(None / Clear)"] = "(Немає / Очистити)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Правила Звуку за виходом:\n\n• Пріоритет EQ: Якщо налаштування EQ змінено вручну або через AutoEQ Context, автоматика одразу призупиняється.\n• Тимчасові профілі: Застосовує профілі PEQ без запису у флеш-пам'ять ({persist = false}).\n• Передпідсилення та гейн: Містяться у профілях .peq; eq_set_preamp не викликається під час перемикання.\n• Безпека слуху: Не регулює гучність автоматично.\n• Непризначені виходи: Відновлює початковий EQ при переході на вихід без профілю.\n• Аудіоформати: Профілі змінюють АЧХ; bit-perfect не заявлено.",
        ["Sound & Safety Policy"] = "Політика звуку та безпеки",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "Тимчасовий PEQ на вихід; безпечна гучність, не bit-perfect",
        ["Disabled"] = "Вимкнено",
        ["Suspended (%s)"] = "Призупинено (%s)",
        ["External change"] = "Зовнішня зміна",
        ["Active: %s"] = "Активно: %s",
        ["Active"] = "Активно",
        ["Detecting..."] = "Визначення...",
        ["Wired Headphones"] = "Дротові навушники",
        ["USB DAC"] = "USB ЦАП",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (типовий резервний)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (невідомий кодек)",
        ["Enabled"] = "Увімкнено",
        ["Status: %s"] = "Статус: %s",
        ["Output-Aware Sound reclaimed"] = "Керування Звуком за виходом відновлено",
        ["Current Route: %s"] = "Поточний вихід: %s",
        ["None"] = "Немає",
        ["Profile for %s"] = "Профіль для %s",
        ["Policy & Safety Info"] = "Політика та безпека",
        ["Output-Aware Sound"] = "Звук за виходом",
    },
    vi = {
        ["Failed to encode configuration"] = "Không thể mã hóa cấu hình",
        ["Failed to save settings to storage; changes are live for this session only"] = "Không thể lưu cài đặt; thay đổi chỉ có hiệu lực trong phiên này",
        ["Storage unavailable; changes are live for this session only"] = "Bộ nhớ không khả dụng; thay đổi chỉ có hiệu lực trong phiên này",
        ["Manual or external EQ change detected"] = "Phát hiện thay đổi EQ thủ công hoặc từ bên ngoài",
        ["(None / Clear)"] = "(Không / Xóa)",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "Nguyên tắc Âm thanh theo đầu ra:\n\n• Quyền điều khiển EQ: Nếu cài đặt EQ bị thay đổi thủ công hoặc bởi AutoEQ Context, tự động hóa sẽ tạm dừng ngay để tránh xung đột.\n• Hồ sơ tạm thời: Áp dụng hồ sơ PEQ mà không ghi vào bộ nhớ flash ({persist = false}).\n• Preamp & Gain: Nằm sẵn trong tệp .peq; không gọi eq_set_preamp khi chuyển đổi.\n• An toàn thính giác: Không tự động thay đổi âm lượng.\n• Đầu ra chưa gán: Khôi phục EQ gốc khi chuyển sang đầu ra chưa gán hồ sơ.\n• Định dạng âm thanh: Hồ sơ điều chỉnh đường cong âm sắc; không cam kết xuất bit-perfect.",
        ["Sound & Safety Policy"] = "Chính sách âm thanh & an toàn",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "PEQ tạm thời theo đầu ra; âm lượng an toàn, không bit-perfect",
        ["Disabled"] = "Đã tắt",
        ["Suspended (%s)"] = "Đã tạm dừng (%s)",
        ["External change"] = "Thay đổi bên ngoài",
        ["Active: %s"] = "Đang hoạt động: %s",
        ["Active"] = "Đang hoạt động",
        ["Detecting..."] = "Đang phát hiện...",
        ["Wired Headphones"] = "Tai nghe có dây",
        ["USB DAC"] = "USB DAC",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth (dự phòng mặc định)",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth (codec không rõ)",
        ["Enabled"] = "Đã bật",
        ["Status: %s"] = "Trạng thái: %s",
        ["Output-Aware Sound reclaimed"] = "Đã lấy lại quyền điều khiển Âm thanh theo đầu ra",
        ["Current Route: %s"] = "Đầu ra hiện tại: %s",
        ["None"] = "Không có",
        ["Profile for %s"] = "Hồ sơ cho %s",
        ["Policy & Safety Info"] = "Thông tin chính sách & an toàn",
        ["Output-Aware Sound"] = "Âm thanh theo đầu ra",
    },
    zh_CN = {
        ["Failed to encode configuration"] = "无法编码配置",
        ["Failed to save settings to storage; changes are live for this session only"] = "无法保存设置；更改仅在本次会话中生效",
        ["Storage unavailable; changes are live for this session only"] = "存储不可用；更改仅在本次会话中生效",
        ["Manual or external EQ change detected"] = "检测到手动或外部 EQ 更改",
        ["(None / Clear)"] = "（无 / 清除）",
        ["Output-Aware Sound Guidelines:\n\n• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, Output-Aware automation suspends immediately to prevent fighting.\n• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n• Hearing Safety: Does not adjust volume automatically.\n• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output."] = "输出感知音效说明：\n\n• EQ 控制权：如果手动或通过 AutoEQ Context 更改了 EQ 设置，自动切换会立即暂停以避免冲突。\n• 临时配置文件：应用 PEQ 配置文件时不写入闪存（{persist = false}）。\n• 前级与增益：包含在 .peq 配置文件内；切换时不会调用 eq_set_preamp。\n• 听力安全：不会自动调节音量。\n• 未映射输出：切换到未映射的输出时恢复原有基线 EQ。\n• 音频格式：配置文件会调整频响曲线，并非源码直通（bit-perfect）输出。",
        ["Sound & Safety Policy"] = "声音与安全策略",
        ["Transient PEQ per route; safe volume, non-bitperfect"] = "按输出临时应用 PEQ；安全音量，非 bit-perfect",
        ["Disabled"] = "已禁用",
        ["Suspended (%s)"] = "已暂停（%s）",
        ["External change"] = "外部更改",
        ["Active: %s"] = "已启用：%s",
        ["Active"] = "已启用",
        ["Detecting..."] = "正在检测...",
        ["Wired Headphones"] = "有线耳机",
        ["USB DAC"] = "USB DAC",
        ["Bluetooth (LDAC)"] = "Bluetooth (LDAC)",
        ["Bluetooth (aptX)"] = "Bluetooth (aptX)",
        ["Bluetooth (AAC)"] = "Bluetooth (AAC)",
        ["Bluetooth (SBC)"] = "Bluetooth (SBC)",
        ["Bluetooth (Default Fallback)"] = "Bluetooth（默认回退）",
        ["Bluetooth (Unknown Codec)"] = "Bluetooth（未知编解码器）",
        ["Enabled"] = "已启用",
        ["Status: %s"] = "状态：%s",
        ["Output-Aware Sound reclaimed"] = "已重新接管输出感知音效",
        ["Current Route: %s"] = "当前输出：%s",
        ["None"] = "无",
        ["Profile for %s"] = "%s 的配置文件",
        ["Policy & Safety Info"] = "策略与安全信息",
        ["Output-Aware Sound"] = "输出感知音效",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- Output-Aware Sound:
-- Automatically applies PEQ profiles when output route or Bluetooth codec changes.
-- Maps wired, USB DAC, and Bluetooth (per codec with explicit unknown/default fallbacks).
-- Applies profiles transiently ({ persist = false }) without writing to flash.
-- Gain/preamp is bundled within the .peq file; does not call eq_set_preamp.
-- Does not perform automatic volume jumps to ensure hearing safety.
-- Does not claim bit-perfect output (Bluetooth and USB conversions are hardware-dependent).
--
-- EQ Ownership Policy:
-- - Maintains a detached get_eq_state snapshot of the last applied state with 1e-6 precision.
-- - Before an automatic transition, compares current EQ state to the last applied state.
-- - If state differs, automatic writes suspend immediately until re-enabled/reclaimed.
-- - Baseline EQ is restored on leaving mapped route or on disable if still owned.
-- - Baseline EQ is preserved across profile edits while owned.

local CONFIG_PATH = plugin.sd_root() .. "/.plugins/output_aware_sound_config.json"
local PROFILES_DIR = plugin.sd_root() .. "/PEQ_Profiles"
local MAX_UI_ROWS = 500
local EPSILON = 1e-6

local config = {
    enabled = false,
    routes = {
        ["wired"] = "",
        ["usb_dac"] = "",
        ["bluetooth:ldac"] = "",
        ["bluetooth:aptx"] = "",
        ["bluetooth:aac"] = "",
        ["bluetooth:sbc"] = "",
        ["bluetooth:default"] = "",
        ["bluetooth:unknown"] = "",
    }
}

local baseline_state = nil
local last_applied_state = nil
local is_suspended = false
local suspension_reason = nil
local last_applied_key = nil
local last_applied_profile = nil
local last_profile_succeeded = false

local function is_valid_profile_name(name)
    if type(name) ~= "string" or #name == 0 or #name > 128 then return false end
    if name:find("[/\\]") or name:find("%.%.") then return false end
    if not name:lower():match("%.peq$") then return false end
    return true
end

local function num_eq(a, b)
    if not a and not b then return true end
    if not a or not b then return false end
    if a ~= a or b ~= b then return false end -- reject NaN
    if a == math.huge or a == -math.huge or b == math.huge or b == -math.huge then return false end
    return math.abs(a - b) <= EPSILON
end

local function crossfeed_state_values(state)
    local strength = state.crossfeed
    if strength == nil then strength = 0 end -- Older snapshots omitted crossfeed entirely.
    if type(strength) ~= "number" or strength ~= strength or strength == math.huge or strength == -math.huge
       or strength < 0 or strength > 1 then
        return nil
    end

    local angle = state.crossfeed_angle
    if angle == nil then
        angle = 0 -- Older firmware snapshots did not include the angle.
    elseif type(angle) ~= "number" or angle ~= angle or angle == math.huge or angle == -math.huge
       or (angle ~= 0 and angle ~= 30 and angle ~= 45 and angle ~= 60 and angle ~= 90) then
        return nil
    end

    return strength, angle
end

local function eq_states_equal(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then return false end
    local a_crossfeed, a_angle = crossfeed_state_values(a)
    local b_crossfeed, b_angle = crossfeed_state_values(b)
    if a_crossfeed == nil or b_crossfeed == nil then return false end
    if a == b then return true end
    if a.bypass ~= b.bypass then return false end
    if not num_eq(a.preamp_db, b.preamp_db) then return false end
    if not num_eq(a.stereo_width, b.stereo_width) then return false end
    if not num_eq(a_crossfeed, b_crossfeed) or a_angle ~= b_angle then return false end
    if not a.bands or not b.bands then return a.bands == b.bands end
    if #a.bands ~= #b.bands then return false end
    for i = 1, #a.bands do
        local b1 = a.bands[i]
        local b2 = b.bands[i]
        if not b1 or not b2 then return false end
        if b1.enabled ~= b2.enabled then return false end
        if b1.type ~= b2.type then return false end
        if not num_eq(b1.freq_hz, b2.freq_hz) then return false end
        if not num_eq(b1.gain_db, b2.gain_db) then return false end
        if not num_eq(b1.q, b2.q) then return false end
    end
    return true
end

local function json_encode(val)
    if not (plugin.has_capability and plugin.has_capability("data.json") and plugin.json_encode) then return nil end
    local ok, res = pcall(plugin.json_encode, val)
    if ok and type(res) == "string" then return res end
    return nil
end

local function json_decode(text)
    if not (plugin.has_capability and plugin.has_capability("data.json") and plugin.json_decode) then return nil end
    local ok, res = pcall(plugin.json_decode, text)
    if ok and type(res) == "table" then return res end
    return nil
end

local function load_config()
    local content = nil
    if plugin.has_capability and plugin.has_capability("storage.namespaced") and plugin.storage and plugin.storage.get then
        content = plugin.storage.get("config")
    end
    if not content or content == "" then
        local f = io.open(CONFIG_PATH, "r")
        if f then
            content = f:read(65536)
            f:close()
        end
    end
    if not content or content == "" or #content > 65536 then return end
    local data = json_decode(content)
    if type(data) ~= "table" then return end
    if type(data.enabled) == "boolean" then config.enabled = data.enabled end
    if type(data.routes) == "table" then
        for k, v in pairs(data.routes) do
            if type(k) == "string" and (type(v) == "string" and (v == "" or is_valid_profile_name(v))) then
                config.routes[k] = v
            end
        end
    end
end

local function save_config()
    local encoded = json_encode(config)
    if not encoded or #encoded > 65536 then
        if plugin.show_toast then plugin.show_toast(tr("Failed to encode configuration")) end
        return false
    end

    -- Sole authoritative namespaced storage writer
    if plugin.has_capability and plugin.has_capability("storage.namespaced") and plugin.storage and plugin.storage.set then
        local saved = plugin.storage.set("config", encoded)
        if saved then
            return true
        end
        if plugin.show_toast then
            plugin.show_toast(tr("Failed to save settings to storage; changes are live for this session only"))
        end
        return false
    end

    if plugin.show_toast then
        plugin.show_toast(tr("Storage unavailable; changes are live for this session only"))
    end
    return false
end

local function list_available_profiles()
    local profiles = {}
    if not plugin.list_dir then return profiles end
    local entries = plugin.list_dir(PROFILES_DIR)
    if not entries then return profiles end
    for _, ent in ipairs(entries) do
        if not ent.dir and ent.name and is_valid_profile_name(ent.name) then
            profiles[#profiles + 1] = ent.name
        end
    end
    table.sort(profiles)
    return profiles
end

local function resolve_route_key(snapshot)
    if not snapshot then return "unknown" end
    local r = snapshot.route
    if (not r or r == "inactive" or r == "unknown") and snapshot.requested_route then
        r = snapshot.requested_route
    end
    if r == "wired" then
        return "wired"
    elseif r == "usb_dac" then
        return "usb_dac"
    elseif r == "bluetooth" then
        local codec = snapshot.bluetooth_codec
        if codec and codec ~= "" then
            return "bluetooth:" .. string.lower(codec)
        else
            return "bluetooth:unknown"
        end
    end
    return "unknown"
end

local function resolve_profile_for_route_key(route_key)
    if not route_key or route_key == "unknown" then return nil end
    local prof = config.routes[route_key]
    if prof and is_valid_profile_name(prof) then return prof end

    if route_key:sub(1, 10) == "bluetooth:" then
        local def = config.routes["bluetooth:default"]
        if def and is_valid_profile_name(def) then return def end
    end
    return nil
end

local function apply_target_profile(profile_name)
    if not is_valid_profile_name(profile_name) then return false end
    local full_path = PROFILES_DIR .. "/" .. profile_name
    if not (plugin.has_capability and plugin.has_capability("audio.peq.transient") and plugin.eq_apply_profile) then
        return false
    end
    return plugin.eq_apply_profile(full_path, { persist = false })
end

local function handle_output_snapshot(snapshot)
    if not config.enabled then return end
    if is_suspended then return end

    local route_key = resolve_route_key(snapshot)
    local target_profile = resolve_profile_for_route_key(route_key)

    if not target_profile or target_profile == "" then
        -- Route has no profile mapped: restore runtime baseline if previously applied!
        if last_applied_profile ~= nil then
            if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
                local current_eq = plugin.get_eq_state()
                if last_applied_state and not eq_states_equal(current_eq, last_applied_state) then
                    is_suspended = true
                    suspension_reason = "Manual or external EQ change detected"
                    return -- do NOT clobber user's manual change
                end
            end
            if baseline_state and plugin.has_capability and plugin.has_capability("audio.peq.state")
               and plugin.eq_apply_state then
                plugin.eq_apply_state(baseline_state, { persist = false })
                if plugin.get_eq_state then last_applied_state = plugin.get_eq_state() end
            end
            last_applied_profile = nil
            last_applied_key = route_key
            last_profile_succeeded = false
        end
        return
    end

    -- Deduplication: if route key and target profile haven't changed and last attempt succeeded, skip
    if route_key == last_applied_key and target_profile == last_applied_profile and last_profile_succeeded then
        return
    end

    -- Verify EQ ownership against last applied snapshot
    if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
        local current_eq = plugin.get_eq_state()
        if last_applied_state and not eq_states_equal(current_eq, last_applied_state) then
            is_suspended = true
            suspension_reason = "Manual or external EQ change detected"
            return -- Suspend automatic writes; do NOT write to EQ!
        end
    end

    local ok = apply_target_profile(target_profile)
    last_applied_key = route_key
    last_applied_profile = target_profile
    if ok then
        last_profile_succeeded = true
        if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
            last_applied_state = plugin.get_eq_state()
        end
    else
        last_profile_succeeded = false -- Retry on next transition
    end
end

local function evaluate_current_output()
    if not (plugin.has_capability and plugin.has_capability("playback.output_info") and plugin.get_output_info) then
        return
    end
    local info = plugin.get_output_info()
    if info then
        handle_output_snapshot(info)
    end
end

local function grant_control(is_reclaiming)
    is_suspended = false
    suspension_reason = nil
    last_applied_key = nil
    last_applied_profile = nil
    last_profile_succeeded = false

    if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
        local current_eq = plugin.get_eq_state()
        if baseline_state == nil or is_reclaiming or (last_applied_state and not eq_states_equal(current_eq, last_applied_state)) then
            baseline_state = current_eq
        end
        last_applied_state = plugin.get_eq_state()
    end
    evaluate_current_output()
end

local function release_control()
    if baseline_state and plugin.has_capability and plugin.has_capability("audio.peq.state")
       and plugin.get_eq_state and plugin.eq_apply_state then
        local current_eq = plugin.get_eq_state()
        if last_applied_state and eq_states_equal(current_eq, last_applied_state) then
            -- Still owned: restore baseline without persisting to flash
            plugin.eq_apply_state(baseline_state, { persist = false })
        end
    end
    baseline_state = nil
    last_applied_state = nil
    is_suspended = false
    suspension_reason = nil
    last_applied_key = nil
    last_applied_profile = nil
    last_profile_succeeded = false
end

-- UI
local open_main_settings

local function show_profile_picker(title, current_val, on_picked)
    local all_profiles = list_available_profiles()
    local items = { tr("(None / Clear)") }
    for i = 1, math.min(#all_profiles, MAX_UI_ROWS - 1) do
        items[#items + 1] = all_profiles[i]
    end
    plugin.show_list(title, items, function(idx)
        if idx == 1 then
            on_picked("")
        else
            on_picked(items[idx])
        end
    end)
end

local function show_precedence_and_safety_info()
    local text = tr("Output-Aware Sound Guidelines:\n\n"
        .. "• EQ Ownership: If EQ settings are changed manually or by AutoEQ Context, "
        .. "Output-Aware automation suspends immediately to prevent fighting.\n"
        .. "• Transient Profiles: Applies PEQ profiles without persisting to flash ({persist = false}).\n"
        .. "• Preamp & Gain: Bound inside .peq profiles; eq_set_preamp is never called per transition.\n"
        .. "• Hearing Safety: Does not adjust volume automatically.\n"
        .. "• Unmapped Routes: Restores owned baseline when switching to an unmapped route.\n"
        .. "• Audio Formats: Profiles adjust tonal curve; does not claim bit-perfect output.")
    if plugin.show_text_view then
        plugin.show_text_view(tr("Sound & Safety Policy"), text)
    elseif plugin.show_toast then
        plugin.show_toast(tr("Transient PEQ per route; safe volume, non-bitperfect"))
    end
end

open_main_settings = function()
    local status_text
    if not config.enabled then
        status_text = tr("Disabled")
    elseif is_suspended then
        status_text = string.format(tr("Suspended (%s)"), tr(suspension_reason or "External change"))
    else
        status_text = last_applied_profile
            and string.format(tr("Active: %s"), last_applied_profile)
            or tr("Active")
    end

    local current_route_desc = last_applied_key or tr("Detecting...")

    local route_rows = {
        { key = "wired", label = tr("Wired Headphones") },
        { key = "usb_dac", label = tr("USB DAC") },
        { key = "bluetooth:ldac", label = tr("Bluetooth (LDAC)") },
        { key = "bluetooth:aptx", label = tr("Bluetooth (aptX)") },
        { key = "bluetooth:aac", label = tr("Bluetooth (AAC)") },
        { key = "bluetooth:sbc", label = tr("Bluetooth (SBC)") },
        { key = "bluetooth:default", label = tr("Bluetooth (Default Fallback)") },
        { key = "bluetooth:unknown", label = tr("Bluetooth (Unknown Codec)") },
    }

    local rows = {
        {
            type = "toggle",
            label = tr("Enabled"),
            value = config.enabled,
            on_change = function(new_val)
                config.enabled = new_val
                save_config()
                if new_val then
                    grant_control(false)
                else
                    release_control()
                end
                open_main_settings()
            end
        },
        {
            type = "row",
            label = string.format(tr("Status: %s"), status_text),
            on_select = function()
                if is_suspended then
                    grant_control(true)
                    if plugin.show_toast then plugin.show_toast(tr("Output-Aware Sound reclaimed")) end
                    open_main_settings()
                end
            end
        },
        {
            type = "row",
            label = string.format(tr("Current Route: %s"), current_route_desc),
            on_select = function()
                evaluate_current_output()
                open_main_settings()
            end
        }
    }

    for _, item in ipairs(route_rows) do
        local rkey = item.key
        local rlabel = item.label
        local prof = config.routes[rkey] or ""
        rows[#rows + 1] = {
            type = "row",
            label = string.format("%s: %s", rlabel, prof ~= "" and prof or tr("None")),
            on_select = function()
                show_profile_picker(string.format(tr("Profile for %s"), rlabel), prof, function(chosen)
                    if chosen == "" or is_valid_profile_name(chosen) then
                        config.routes[rkey] = chosen
                        save_config()
                        if config.enabled and not is_suspended then
                            evaluate_current_output()
                        end
                        open_main_settings()
                    end
                end)
            end
        }
    end

    rows[#rows + 1] = {
        type = "row",
        label = tr("Policy & Safety Info"),
        on_select = show_precedence_and_safety_info
    }

    plugin.show_settings_list(tr("Output-Aware Sound"), rows, { update = true })
end

-- Initialize
load_config()
plugin.register_list_item("music_audio", tr("Output-Aware Sound"), open_main_settings)

plugin.on("output_changed", function(current, previous)
    handle_output_snapshot(current)
end)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        config = config,
        load_config = load_config,
        save_config = save_config,
        resolve_route_key = resolve_route_key,
        resolve_profile_for_route_key = resolve_profile_for_route_key,
        handle_output_snapshot = handle_output_snapshot,
        evaluate_current_output = evaluate_current_output,
        grant_control = grant_control,
        release_control = release_control,
        eq_states_equal = eq_states_equal,
        is_valid_profile_name = is_valid_profile_name,
        open_main_settings = open_main_settings,
        get_status = function()
            return {
                enabled = config.enabled,
                suspended = is_suspended,
                reason = suspension_reason,
                last_applied_key = last_applied_key,
                last_applied_profile = last_applied_profile,
                last_succeeded = last_profile_succeeded,
                last_applied_state = last_applied_state,
                baseline_state = baseline_state,
            }
        end,
        set_suspended = function(s, r) is_suspended = s; suspension_reason = r end,
    }
end
