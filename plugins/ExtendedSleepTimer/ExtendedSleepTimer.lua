plugin.define({
    id = "example.extended_sleep_timer",
    name = "Extended Sleep Timer",
    version = "1.3.0",
    api_min = 19,
})

local T = {
    de = {
        ["%d min"] = "%d Min.",
        ["%d hr"] = "%d Std.",
        ["%d hr %d min"] = "%d Std. %d Min.",
        ["Sleep timer finished"] = "Schlaftimer abgelaufen",
        ["Could not arm sleep timer: all timer slots busy"] = "Schlaftimer konnte nicht aktiviert werden: alle Timer belegt",
        ["Sleep timer set for %s"] = "Schlaftimer auf %s gestellt",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Schlaftimer abgebrochen. Lautstärke bleibt unverändert; manuell anpassen.",
        ["Extended sleep timer cancelled"] = "Erweiterter Schlaftimer abgebrochen",
        ["Extended sleep timer is off"] = "Erweiterter Schlaftimer ist aus",
        ["Remaining: %s (fade cancelled by volume change)"] = "Verbleibend: %s (Ausblenden durch Lautstärkeänderung abgebrochen)",
        ["Remaining: %s (fading out)"] = "Verbleibend: %s (blendet aus)",
        ["Time remaining: %s"] = "Verbleibende Zeit: %s",
        ["Stops playback when the countdown reaches zero."] = "Stoppt die Wiedergabe, wenn der Countdown null erreicht.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Wähle eine Dauer zwischen 15 Minuten und 3 Stunden.",
        ["Changing duration while armed restarts the countdown."] = "Ändern der Dauer bei aktivem Timer startet den Countdown neu.",
        ["The countdown resets when the player restarts."] = "Der Countdown wird beim Neustart des Players zurückgesetzt.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "Sanftes Ausblenden senkt die Lautstärke in den letzten 1 bis 30 Minuten.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "Manuelles Ändern der Lautstärke bricht das Ausblenden für diesen Countdown ab.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Nach Ablauf oder Abbruch bleibt die aktuelle Lautstärke erhalten; manuell anpassen.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Sanftes Ausblenden nicht verfügbar: Player unterstützt keine stille/temporäre Lautstärke.",
        ["About Extended Timer"] = "Über den erweiterten Timer",
        ["Timer Enabled"] = "Timer aktiviert",
        ["Duration (minutes)"] = "Dauer (Minuten)",
        ["Timer restarted: %s"] = "Timer neu gestartet: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Timer neu gestartet: %s nur für diese Sitzung (Speichern fehlgeschlagen)",
        ["Duration: %s"] = "Dauer: %s",
        ["Duration: %s for this session only (storage failed)"] = "Dauer: %s nur für diese Sitzung (Speichern fehlgeschlagen)",
        ["Bedtime Fade-out"] = "Sanftes Ausblenden",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Sanftes Ausblenden deaktiviert. Lautstärke bleibt unverändert; manuell anpassen.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Sanftes Ausblenden nur für diese Sitzung deaktiviert (Speichern fehlgeschlagen). Lautstärke bleibt unverändert; manuell anpassen.",
        ["Bedtime fade enabled"] = "Sanftes Ausblenden aktiviert",
        ["Bedtime fade disabled"] = "Sanftes Ausblenden deaktiviert",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Sanftes Ausblenden nur für diese Sitzung aktiviert (Speichern fehlgeschlagen)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Sanftes Ausblenden nur für diese Sitzung deaktiviert (Speichern fehlgeschlagen)",
        ["Fade Duration (minutes)"] = "Ausblenddauer (Minuten)",
        ["Fade duration: %d min"] = "Ausblenddauer: %d Min.",
        ["Fade duration: %d min for this session only (storage failed)"] = "Ausblenddauer: %d Min. nur für diese Sitzung (Speichern fehlgeschlagen)",
        ["Bedtime Fade-out: Unsupported"] = "Sanftes Ausblenden: Nicht unterstützt",
        ["Bedtime fade requires silent and transient volume support"] = "Sanftes Ausblenden erfordert Unterstützung für stille und temporäre Lautstärke",
        ["Show Time Remaining"] = "Verbleibende Zeit anzeigen",
        ["How It Works"] = "Funktionsweise",
        ["Extended Sleep Timer"] = "Erweiterter Schlaftimer",
    },
    es = {
        ["%d min"] = "%d min",
        ["%d hr"] = "%d h",
        ["%d hr %d min"] = "%d h %d min",
        ["Sleep timer finished"] = "Temporizador finalizado",
        ["Could not arm sleep timer: all timer slots busy"] = "No se pudo activar el temporizador: no hay ranuras libres",
        ["Sleep timer set for %s"] = "Temporizador configurado en %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Temporizador cancelado. El volumen se mantiene en el nivel actual; ajústalo manualmente.",
        ["Extended sleep timer cancelled"] = "Temporizador extendido cancelado",
        ["Extended sleep timer is off"] = "El temporizador extendido está apagado",
        ["Remaining: %s (fade cancelled by volume change)"] = "Restante: %s (atenuación cancelada por cambio de volumen)",
        ["Remaining: %s (fading out)"] = "Restante: %s (atenuando)",
        ["Time remaining: %s"] = "Tiempo restante: %s",
        ["Stops playback when the countdown reaches zero."] = "Detiene la reproducción cuando la cuenta atrás llega a cero.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Elige cualquier duración entre 15 minutos y 3 horas.",
        ["Changing duration while armed restarts the countdown."] = "Cambiar la duración con el temporizador activo reinicia la cuenta atrás.",
        ["The countdown resets when the player restarts."] = "La cuenta atrás se reinicia cuando se reinicia el reproductor.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "La atenuación nocturna baja el volumen suavemente durante los últimos 1 a 30 minutos.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "Ajustar el volumen manualmente durante la atenuación la cancela en esta cuenta atrás.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Al finalizar o cancelar, el volumen se mantiene en su nivel actual; ajústalo manualmente.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Atenuación nocturna no disponible: falta soporte de volumen silencioso/transitorio.",
        ["About Extended Timer"] = "Acerca del temporizador extendido",
        ["Timer Enabled"] = "Temporizador activado",
        ["Duration (minutes)"] = "Duración (minutos)",
        ["Timer restarted: %s"] = "Temporizador reiniciado: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Temporizador reiniciado: %s solo para esta sesión (falló el guardado)",
        ["Duration: %s"] = "Duración: %s",
        ["Duration: %s for this session only (storage failed)"] = "Duración: %s solo para esta sesión (falló el guardado)",
        ["Bedtime Fade-out"] = "Atenuación nocturna",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Atenuación nocturna desactivada. El volumen se mantiene en su nivel actual; ajústalo manualmente.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Atenuación nocturna desactivada solo para esta sesión (falló el guardado). El volumen se mantiene en su nivel actual; ajústalo manualmente.",
        ["Bedtime fade enabled"] = "Atenuación nocturna activada",
        ["Bedtime fade disabled"] = "Atenuación nocturna desactivada",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Atenuación nocturna activada solo para esta sesión (falló el guardado)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Atenuación nocturna desactivada solo para esta sesión (falló el guardado)",
        ["Fade Duration (minutes)"] = "Duración de atenuación (minutos)",
        ["Fade duration: %d min"] = "Duración de atenuación: %d min",
        ["Fade duration: %d min for this session only (storage failed)"] = "Duración de atenuación: %d min solo para esta sesión (falló el guardado)",
        ["Bedtime Fade-out: Unsupported"] = "Atenuación nocturna: No compatible",
        ["Bedtime fade requires silent and transient volume support"] = "La atenuación nocturna requiere soporte de volumen silencioso y transitorio",
        ["Show Time Remaining"] = "Mostrar tiempo restante",
        ["How It Works"] = "Cómo funciona",
        ["Extended Sleep Timer"] = "Temporizador de apagado extendido",
    },
    fi = {
        ["%d min"] = "%d min",
        ["%d hr"] = "%d t",
        ["%d hr %d min"] = "%d t %d min",
        ["Sleep timer finished"] = "Uniajastin päättyi",
        ["Could not arm sleep timer: all timer slots busy"] = "Uniajastinta ei voitu käynnistää: kaikki ajastinpaikat varattuja",
        ["Sleep timer set for %s"] = "Uniajastin asetettu: %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Uniajastin peruttu. Äänenvoimakkuus jää nykyiselle tasolle; säädä käsin.",
        ["Extended sleep timer cancelled"] = "Laajennettu uniajastin peruttu",
        ["Extended sleep timer is off"] = "Laajennettu uniajastin on pois päältä",
        ["Remaining: %s (fade cancelled by volume change)"] = "Jäljellä: %s (häivytys peruttu äänenvoimakkuuden muutoksella)",
        ["Remaining: %s (fading out)"] = "Jäljellä: %s (häivytetään)",
        ["Time remaining: %s"] = "Aikaa jäljellä: %s",
        ["Stops playback when the countdown reaches zero."] = "Pysäyttää toiston, kun laskuri saavuttaa nollan.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Valitse kesto 15 minuutista 3 tuntiin.",
        ["Changing duration while armed restarts the countdown."] = "Keston muuttaminen ajastimen ollessa päällä käynnistää laskurin alusta.",
        ["The countdown resets when the player restarts."] = "Laskuri nollautuu, kun soitin käynnistyy uudelleen.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "Iltahäivytys laskee äänenvoimakkuutta hiljalleen viimeisten 1–30 minuutin aikana.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "Äänenvoimakkuuden säätäminen käsin häivytyksen aikana peruu häivytyksen.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Kun ajastin päättyy tai perutaan, äänenvoimakkuus jää nykyiselle tasolleen; säädä käsin.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Iltahäivytys ei käytettävissä: soittimesta puuttuu hiljainen/väliaikainen äänenvoimakkuus.",
        ["About Extended Timer"] = "Tietoja laajennetusta ajastimesta",
        ["Timer Enabled"] = "Ajastin käytössä",
        ["Duration (minutes)"] = "Kesto (minuuttia)",
        ["Timer restarted: %s"] = "Ajastin käynnistetty uudelleen: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Ajastin käynnistetty uudelleen: %s vain tälle istunnolle (tallennus epäonnistui)",
        ["Duration: %s"] = "Kesto: %s",
        ["Duration: %s for this session only (storage failed)"] = "Kesto: %s vain tälle istunnolle (tallennus epäonnistui)",
        ["Bedtime Fade-out"] = "Iltahäivytys",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Iltahäivytys poistettu käytöstä. Äänenvoimakkuus jää nykyiselle tasolle; säädä käsin.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Iltahäivytys poistettu käytöstä vain tälle istunnolle (tallennus epäonnistui). Äänenvoimakkuus jää nykyiselle tasolle; säädä käsin.",
        ["Bedtime fade enabled"] = "Iltahäivytys käytössä",
        ["Bedtime fade disabled"] = "Iltahäivytys pois käytöstä",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Iltahäivytys käytössä vain tälle istunnolle (tallennus epäonnistui)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Iltahäivytys pois käytöstä vain tälle istunnolle (tallennus epäonnistui)",
        ["Fade Duration (minutes)"] = "Häivytyksen kesto (minuuttia)",
        ["Fade duration: %d min"] = "Häivytyksen kesto: %d min",
        ["Fade duration: %d min for this session only (storage failed)"] = "Häivytyksen kesto: %d min vain tälle istunnolle (tallennus epäonnistui)",
        ["Bedtime Fade-out: Unsupported"] = "Iltahäivytys: Ei tuettu",
        ["Bedtime fade requires silent and transient volume support"] = "Iltahäivytys vaatii hiljaisen ja väliaikaisen äänenvoimakkuuden tuen",
        ["Show Time Remaining"] = "Näytä jäljellä oleva aika",
        ["How It Works"] = "Miten se toimii",
        ["Extended Sleep Timer"] = "Laajennettu uniajastin",
    },
    fr = {
        ["%d min"] = "%d min",
        ["%d hr"] = "%d h",
        ["%d hr %d min"] = "%d h %d min",
        ["Sleep timer finished"] = "Minuteur de veille terminé",
        ["Could not arm sleep timer: all timer slots busy"] = "Impossible d'activer le minuteur : tous les emplacements sont occupés",
        ["Sleep timer set for %s"] = "Minuteur de veille réglé sur %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Minuteur annulé. Le volume reste à son niveau actuel ; réglez-le manuellement.",
        ["Extended sleep timer cancelled"] = "Minuteur de veille étendu annulé",
        ["Extended sleep timer is off"] = "Le minuteur de veille étendu est désactivé",
        ["Remaining: %s (fade cancelled by volume change)"] = "Restant : %s (fondu annulé par changement de volume)",
        ["Remaining: %s (fading out)"] = "Restant : %s (fondu en cours)",
        ["Time remaining: %s"] = "Temps restant : %s",
        ["Stops playback when the countdown reaches zero."] = "Arrête la lecture lorsque le compte à rebours atteint zéro.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Choisissez une durée de 15 minutes à 3 heures.",
        ["Changing duration while armed restarts the countdown."] = "Modifier la durée lorsque le minuteur est actif relance le compte à rebours.",
        ["The countdown resets when the player restarts."] = "Le compte à rebours est réinitialisé au redémarrage du lecteur.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "Le fondu de sommeil baisse doucement le volume pendant les 1 à 30 dernières minutes.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "Un réglage manuel du volume pendant le fondu annule le fondu pour ce décompte.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Une fois terminé ou annulé, le volume reste au niveau actuel ; réglez-le manuellement.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Fondu de sommeil indisponible : volume silencieux/transitoire non pris en charge.",
        ["About Extended Timer"] = "À propos du minuteur étendu",
        ["Timer Enabled"] = "Minuteur activé",
        ["Duration (minutes)"] = "Durée (minutes)",
        ["Timer restarted: %s"] = "Minuteur relancé : %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Minuteur relancé : %s pour cette session uniquement (échec de sauvegarde)",
        ["Duration: %s"] = "Durée : %s",
        ["Duration: %s for this session only (storage failed)"] = "Durée : %s pour cette session uniquement (échec de sauvegarde)",
        ["Bedtime Fade-out"] = "Fondu de sommeil",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Fondu de sommeil désactivé. Le volume reste au niveau actuel ; réglez-le manuellement.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Fondu désactivé pour cette session uniquement (échec de sauvegarde). Le volume reste au niveau actuel ; réglez-le manuellement.",
        ["Bedtime fade enabled"] = "Fondu de sommeil activé",
        ["Bedtime fade disabled"] = "Fondu de sommeil désactivé",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Fondu activé pour cette session uniquement (échec de sauvegarde)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Fondu désactivé pour cette session uniquement (échec de sauvegarde)",
        ["Fade Duration (minutes)"] = "Durée du fondu (minutes)",
        ["Fade duration: %d min"] = "Durée du fondu : %d min",
        ["Fade duration: %d min for this session only (storage failed)"] = "Durée du fondu : %d min pour cette session uniquement (échec de sauvegarde)",
        ["Bedtime Fade-out: Unsupported"] = "Fondu de sommeil : Non pris en charge",
        ["Bedtime fade requires silent and transient volume support"] = "Le fondu de sommeil nécessite la prise en charge du volume silencieux et transitoire",
        ["Show Time Remaining"] = "Afficher le temps restant",
        ["How It Works"] = "Fonctionnement",
        ["Extended Sleep Timer"] = "Minuteur de veille étendu",
    },
    it = {
        ["%d min"] = "%d min",
        ["%d hr"] = "%d h",
        ["%d hr %d min"] = "%d h %d min",
        ["Sleep timer finished"] = "Timer di spegnimento terminato",
        ["Could not arm sleep timer: all timer slots busy"] = "Impossibile attivare il timer: tutti gli slot sono occupati",
        ["Sleep timer set for %s"] = "Timer impostato per %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Timer annullato. Il volume resta al livello attuale; regolalo manualmente.",
        ["Extended sleep timer cancelled"] = "Timer di spegnimento esteso annullato",
        ["Extended sleep timer is off"] = "Il timer di spegnimento esteso è disattivato",
        ["Remaining: %s (fade cancelled by volume change)"] = "Rimanente: %s (dissolvenza annullata per modifica volume)",
        ["Remaining: %s (fading out)"] = "Rimanente: %s (dissolvenza in corso)",
        ["Time remaining: %s"] = "Tempo rimanente: %s",
        ["Stops playback when the countdown reaches zero."] = "Ferma la riproduzione quando il conto alla rovescia raggiunge zero.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Scegli una durata da 15 minuti a 3 ore.",
        ["Changing duration while armed restarts the countdown."] = "Modificare la durata a timer attivo riavvia il conto alla rovescia.",
        ["The countdown resets when the player restarts."] = "Il conto alla rovescia si azzera al riavvio del lettore.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "La dissolvenza notturna abbassa gradualmente il volume negli ultimi 1–30 minuti.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "La regolazione manuale del volume durante la dissolvenza la annulla per questo timer.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Al termine o all'annullamento, il volume resta al livello attuale; regolalo manualmente.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Dissolvenza notturna non disponibile: manca il supporto per il volume silenzioso/transitorio.",
        ["About Extended Timer"] = "Informazioni sul timer esteso",
        ["Timer Enabled"] = "Timer attivo",
        ["Duration (minutes)"] = "Durata (minuti)",
        ["Timer restarted: %s"] = "Timer riavviato: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Timer riavviato: %s solo per questa sessione (salvataggio non riuscito)",
        ["Duration: %s"] = "Durata: %s",
        ["Duration: %s for this session only (storage failed)"] = "Durata: %s solo per questa sessione (salvataggio non riuscito)",
        ["Bedtime Fade-out"] = "Dissolvenza notturna",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Dissolvenza notturna disattivata. Il volume resta al livello attuale; regolalo manualmente.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Dissolvenza disattivata solo per questa sessione (salvataggio non riuscito). Il volume resta al livello attuale; regolalo manualmente.",
        ["Bedtime fade enabled"] = "Dissolvenza notturna attivata",
        ["Bedtime fade disabled"] = "Dissolvenza notturna disattivata",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Dissolvenza attivata solo per questa sessione (salvataggio non riuscito)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Dissolvenza disattivata solo per questa sessione (salvataggio non riuscito)",
        ["Fade Duration (minutes)"] = "Durata dissolvenza (minuti)",
        ["Fade duration: %d min"] = "Durata dissolvenza: %d min",
        ["Fade duration: %d min for this session only (storage failed)"] = "Durata dissolvenza: %d min solo per questa sessione (salvataggio non riuscito)",
        ["Bedtime Fade-out: Unsupported"] = "Dissolvenza notturna: Non supportata",
        ["Bedtime fade requires silent and transient volume support"] = "La dissolvenza notturna richiede il supporto del volume silenzioso e transitorio",
        ["Show Time Remaining"] = "Mostra tempo rimanente",
        ["How It Works"] = "Come funziona",
        ["Extended Sleep Timer"] = "Timer di spegnimento esteso",
    },
    ja = {
        ["%d min"] = "%d 分",
        ["%d hr"] = "%d 時間",
        ["%d hr %d min"] = "%d 時間 %d 分",
        ["Sleep timer finished"] = "スリープタイマーが終了しました",
        ["Could not arm sleep timer: all timer slots busy"] = "スリープタイマーを開始できません: タイマースロットが使用中です",
        ["Sleep timer set for %s"] = "スリープタイマーを %s に設定しました",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "タイマーを解除しました。音量は現在のままです。手動で調整してください。",
        ["Extended sleep timer cancelled"] = "拡張スリープタイマーを解除しました",
        ["Extended sleep timer is off"] = "拡張スリープタイマーはオフです",
        ["Remaining: %s (fade cancelled by volume change)"] = "残り: %s (音量変更によりフェード解除)",
        ["Remaining: %s (fading out)"] = "残り: %s (フェードアウト中)",
        ["Time remaining: %s"] = "残り時間: %s",
        ["Stops playback when the countdown reaches zero."] = "カウントダウンがゼロになると再生を停止します。",
        ["Choose any duration from 15 minutes to 3 hours."] = "15 分から 3 時間までの任意の長さを選択できます。",
        ["Changing duration while armed restarts the countdown."] = "作動中に時間を変更するとカウントダウンが再開されます。",
        ["The countdown resets when the player restarts."] = "プレーヤーを再起動するとカウントダウンはリセットされます。",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "おやすみフェードアウトは最後の 1〜30 分間で音量を静かに下げます。",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "フェード中に手動で音量を変更すると、このカウントダウンのフェードは解除されます。",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "終了または解除時、音量は現在のまま維持されます。手動で調整してください。",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "おやすみフェードアウト利用不可: サイレント/一時音量機能がありません。",
        ["About Extended Timer"] = "拡張タイマーについて",
        ["Timer Enabled"] = "タイマー有効",
        ["Duration (minutes)"] = "時間 (分)",
        ["Timer restarted: %s"] = "タイマーを再開しました: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "タイマー再開: %s (保存失敗のため今回のセッションのみ)",
        ["Duration: %s"] = "時間: %s",
        ["Duration: %s for this session only (storage failed)"] = "時間: %s (保存失敗のため今回のセッションのみ)",
        ["Bedtime Fade-out"] = "おやすみフェードアウト",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "フェードアウトを無効にしました。音量は現在のままです。手動で調整してください。",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "今回のセッションのみフェードを無効にしました (保存失敗)。音量は手動で調整してください。",
        ["Bedtime fade enabled"] = "おやすみフェード有効",
        ["Bedtime fade disabled"] = "おやすみフェード無効",
        ["Bedtime fade enabled for this session only (storage failed)"] = "おやすみフェード有効 (保存失敗のため今回のみ)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "おやすみフェード無効 (保存失敗のため今回のみ)",
        ["Fade Duration (minutes)"] = "フェード時間 (分)",
        ["Fade duration: %d min"] = "フェード時間: %d 分",
        ["Fade duration: %d min for this session only (storage failed)"] = "フェード時間: %d 分 (保存失敗のため今回のみ)",
        ["Bedtime Fade-out: Unsupported"] = "おやすみフェードアウト: 非対応",
        ["Bedtime fade requires silent and transient volume support"] = "おやすみフェードにはサイレントおよび一時音量のサポートが必要です",
        ["Show Time Remaining"] = "残り時間を表示",
        ["How It Works"] = "仕組み",
        ["Extended Sleep Timer"] = "拡張スリープタイマー",
    },
    nl = {
        ["%d min"] = "%d min",
        ["%d hr"] = "%d u",
        ["%d hr %d min"] = "%d u %d min",
        ["Sleep timer finished"] = "Slaaptimer afgelopen",
        ["Could not arm sleep timer: all timer slots busy"] = "Kon slaaptimer niet starten: alle timerslots bezet",
        ["Sleep timer set for %s"] = "Slaaptimer ingesteld op %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Slaaptimer geannuleerd. Volume blijft op het huidige niveau; pas handmatig aan.",
        ["Extended sleep timer cancelled"] = "Uitgebreide slaaptimer geannuleerd",
        ["Extended sleep timer is off"] = "Uitgebreide slaaptimer staat uit",
        ["Remaining: %s (fade cancelled by volume change)"] = "Resterend: %s (fade-out geannuleerd door volumewijziging)",
        ["Remaining: %s (fading out)"] = "Resterend: %s (volume neemt af)",
        ["Time remaining: %s"] = "Resterende tijd: %s",
        ["Stops playback when the countdown reaches zero."] = "Stopt het afspelen wanneer het aftellen nul bereikt.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Kies een duur van 15 minuten tot 3 uur.",
        ["Changing duration while armed restarts the countdown."] = "De duur wijzigen terwijl de timer actief is, start het aftellen opnieuw.",
        ["The countdown resets when the player restarts."] = "Het aftellen wordt gereset wanneer de speler opnieuw opstart.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "Slaap-fade-out verlaagt het volume geleidelijk tijdens de laatste 1 tot 30 minuten.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "Handmatig het volume aanpassen tijdens fade-out annuleert het faden voor deze timer.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Na afloop of annuleren blijft het volume op het huidige niveau; pas handmatig aan.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Slaap-fade-out niet beschikbaar: speler mist stil/tijdelijk volume.",
        ["About Extended Timer"] = "Over uitgebreide timer",
        ["Timer Enabled"] = "Timer ingeschakeld",
        ["Duration (minutes)"] = "Duur (minuten)",
        ["Timer restarted: %s"] = "Timer herstart: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Timer herstart: %s alleen voor deze sessie (opslaan mislukt)",
        ["Duration: %s"] = "Duur: %s",
        ["Duration: %s for this session only (storage failed)"] = "Duur: %s alleen voor deze sessie (opslaan mislukt)",
        ["Bedtime Fade-out"] = "Slaap-fade-out",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Slaap-fade-out uitgeschakeld. Volume blijft op het huidige niveau; pas handmatig aan.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Slaap-fade-out alleen voor deze sessie uitgeschakeld (opslaan mislukt). Volume blijft op het huidige niveau; pas handmatig aan.",
        ["Bedtime fade enabled"] = "Slaap-fade-out ingeschakeld",
        ["Bedtime fade disabled"] = "Slaap-fade-out uitgeschakeld",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Slaap-fade-out alleen voor deze sessie ingeschakeld (opslaan mislukt)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Slaap-fade-out alleen voor deze sessie uitgeschakeld (opslaan mislukt)",
        ["Fade Duration (minutes)"] = "Fadeduur (minuten)",
        ["Fade duration: %d min"] = "Fadeduur: %d min",
        ["Fade duration: %d min for this session only (storage failed)"] = "Fadeduur: %d min alleen voor deze sessie (opslaan mislukt)",
        ["Bedtime Fade-out: Unsupported"] = "Slaap-fade-out: Niet ondersteund",
        ["Bedtime fade requires silent and transient volume support"] = "Slaap-fade-out vereist ondersteuning voor stil en tijdelijk volume",
        ["Show Time Remaining"] = "Resterende tijd tonen",
        ["How It Works"] = "Hoe het werkt",
        ["Extended Sleep Timer"] = "Uitgebreide slaaptimer",
    },
    pt = {
        ["%d min"] = "%d min",
        ["%d hr"] = "%d h",
        ["%d hr %d min"] = "%d h %d min",
        ["Sleep timer finished"] = "Temporizador concluído",
        ["Could not arm sleep timer: all timer slots busy"] = "Não foi possível ativar o temporizador: todos os espaços ocupados",
        ["Sleep timer set for %s"] = "Temporizador definido para %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Temporizador cancelado. O volume permanece no nível atual; ajuste manualmente.",
        ["Extended sleep timer cancelled"] = "Temporizador estendido cancelado",
        ["Extended sleep timer is off"] = "O temporizador estendido está desligado",
        ["Remaining: %s (fade cancelled by volume change)"] = "Restante: %s (fade cancelado por alteração de volume)",
        ["Remaining: %s (fading out)"] = "Restante: %s (reduzindo o volume)",
        ["Time remaining: %s"] = "Tempo restante: %s",
        ["Stops playback when the countdown reaches zero."] = "Para a reprodução quando a contagem regressiva chega a zero.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Escolha qualquer duração de 15 minutos a 3 horas.",
        ["Changing duration while armed restarts the countdown."] = "Alterar a duração com o temporizador ativo reinicia a contagem.",
        ["The countdown resets when the player restarts."] = "A contagem é reiniciada quando o reprodutor reinicia.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "A redução suave baixa o volume gradualmente nos últimos 1 a 30 minutos.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "O ajuste manual de volume durante a redução cancela o efeito nesta contagem.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Ao terminar ou cancelar, o volume permanece no nível atual; ajuste manualmente.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Redução suave indisponível: falta suporte a volume silencioso/transitório.",
        ["About Extended Timer"] = "Sobre o temporizador estendido",
        ["Timer Enabled"] = "Temporizador ativado",
        ["Duration (minutes)"] = "Duração (minutos)",
        ["Timer restarted: %s"] = "Temporizador reiniciado: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Temporizador reiniciado: %s apenas nesta sessão (falha ao salvar)",
        ["Duration: %s"] = "Duração: %s",
        ["Duration: %s for this session only (storage failed)"] = "Duração: %s apenas nesta sessão (falha ao salvar)",
        ["Bedtime Fade-out"] = "Redução suave de volume",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Redução suave desativada. O volume permanece no nível atual; ajuste manualmente.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Redução suave desativada apenas nesta sessão (falha ao salvar). O volume permanece no nível atual; ajuste manualmente.",
        ["Bedtime fade enabled"] = "Redução suave ativada",
        ["Bedtime fade disabled"] = "Redução suave desativada",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Redução suave ativada apenas nesta sessão (falha ao salvar)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Redução suave desativada apenas nesta sessão (falha ao salvar)",
        ["Fade Duration (minutes)"] = "Duração da redução (minutos)",
        ["Fade duration: %d min"] = "Duração da redução: %d min",
        ["Fade duration: %d min for this session only (storage failed)"] = "Duração da redução: %d min apenas nesta sessão (falha ao salvar)",
        ["Bedtime Fade-out: Unsupported"] = "Redução suave: Não suportada",
        ["Bedtime fade requires silent and transient volume support"] = "A redução suave requer suporte a volume silencioso e transitório",
        ["Show Time Remaining"] = "Mostrar tempo restante",
        ["How It Works"] = "Como funciona",
        ["Extended Sleep Timer"] = "Temporizador de sono estendido",
    },
    ru = {
        ["%d min"] = "%d мин",
        ["%d hr"] = "%d ч",
        ["%d hr %d min"] = "%d ч %d мин",
        ["Sleep timer finished"] = "Таймер сна завершён",
        ["Could not arm sleep timer: all timer slots busy"] = "Не удалось включить таймер сна: все слоты заняты",
        ["Sleep timer set for %s"] = "Таймер сна установлен на %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Таймер сна отменён. Громкость осталась на текущем уровне; измените вручную.",
        ["Extended sleep timer cancelled"] = "Расширенный таймер сна отменён",
        ["Extended sleep timer is off"] = "Расширенный таймер сна выключен",
        ["Remaining: %s (fade cancelled by volume change)"] = "Осталось: %s (затухание отменено изменением громкости)",
        ["Remaining: %s (fading out)"] = "Осталось: %s (затухание)",
        ["Time remaining: %s"] = "Осталось времени: %s",
        ["Stops playback when the countdown reaches zero."] = "Останавливает воспроизведение, когда отсчёт достигает нуля.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Выберите любую длительность от 15 минут до 3 часов.",
        ["Changing duration while armed restarts the countdown."] = "Изменение длительности при включённом таймере перезапускает отсчёт.",
        ["The countdown resets when the player restarts."] = "Отсчёт сбрасывается при перезапуске плеера.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "Плавное затухание тихо снижает громкость за последние 1–30 минут.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "Ручное изменение громкости во время затухания отменяет его для этого отсчёта.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "После завершения или отмены громкость остаётся прежней; настройте её вручную.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Плавное затухание недоступно: плеер не поддерживает тихую/временную громкость.",
        ["About Extended Timer"] = "О расширенном таймере",
        ["Timer Enabled"] = "Таймер включён",
        ["Duration (minutes)"] = "Длительность (минуты)",
        ["Timer restarted: %s"] = "Таймер перезапущен: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Таймер перезапущен: %s только на этот сеанс (ошибка сохранения)",
        ["Duration: %s"] = "Длительность: %s",
        ["Duration: %s for this session only (storage failed)"] = "Длительность: %s только на этот сеанс (ошибка сохранения)",
        ["Bedtime Fade-out"] = "Плавное затухание",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Затухание выключено. Громкость осталась на текущем уровне; измените вручную.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Затухание выключено только на этот сеанс (ошибка сохранения). Громкость не изменилась; настройте вручную.",
        ["Bedtime fade enabled"] = "Плавное затухание включено",
        ["Bedtime fade disabled"] = "Плавное затухание выключено",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Затухание включено только на этот сеанс (ошибка сохранения)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Затухание выключено только на этот сеанс (ошибка сохранения)",
        ["Fade Duration (minutes)"] = "Длительность затухания (мин)",
        ["Fade duration: %d min"] = "Длительность затухания: %d мин",
        ["Fade duration: %d min for this session only (storage failed)"] = "Длительность затухания: %d мин только на этот сеанс (ошибка сохранения)",
        ["Bedtime Fade-out: Unsupported"] = "Плавное затухание: Не поддерживается",
        ["Bedtime fade requires silent and transient volume support"] = "Плавному затуханию требуется поддержка тихой и временной громкости",
        ["Show Time Remaining"] = "Показать оставшееся время",
        ["How It Works"] = "Как это работает",
        ["Extended Sleep Timer"] = "Расширенный таймер сна",
    },
    uk = {
        ["%d min"] = "%d хв",
        ["%d hr"] = "%d год",
        ["%d hr %d min"] = "%d год %d хв",
        ["Sleep timer finished"] = "Таймер сну завершено",
        ["Could not arm sleep timer: all timer slots busy"] = "Не вдалося увімкнути таймер сну: усі слоти зайняті",
        ["Sleep timer set for %s"] = "Таймер сну встановлено на %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Таймер сну скасовано. Гучність залишається на поточному рівні; змініть вручну.",
        ["Extended sleep timer cancelled"] = "Розширений таймер сну скасовано",
        ["Extended sleep timer is off"] = "Розширений таймер сну вимкнено",
        ["Remaining: %s (fade cancelled by volume change)"] = "Залишилося: %s (згасання скасовано зміною гучності)",
        ["Remaining: %s (fading out)"] = "Залишилося: %s (згасання)",
        ["Time remaining: %s"] = "Часу залишилося: %s",
        ["Stops playback when the countdown reaches zero."] = "Зупиняє відтворення, коли відлік досягає нуля.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Виберіть будь-яку тривалість від 15 хвилин до 3 годин.",
        ["Changing duration while armed restarts the countdown."] = "Зміна тривалості при увімкненому таймері перезапускає відлік.",
        ["The countdown resets when the player restarts."] = "Відлік скидається під час перезапуску плеєра.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "Плавне згасання тихо знижує гучність протягом останніх 1–30 хвилин.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "Ручна зміна гучності під час згасання скасовує його для цього відліку.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Після завершення або скасування гучність залишається поточною; налаштуйте вручну.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Плавне згасання недоступне: плеєр не підтримує тиху/тимчасову гучність.",
        ["About Extended Timer"] = "Про розширений таймер",
        ["Timer Enabled"] = "Таймер увімкнено",
        ["Duration (minutes)"] = "Тривалість (хвилини)",
        ["Timer restarted: %s"] = "Таймер перезапущено: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Таймер перезапущено: %s лише на цей сеанс (помилка збереження)",
        ["Duration: %s"] = "Тривалість: %s",
        ["Duration: %s for this session only (storage failed)"] = "Тривалість: %s лише на цей сеанс (помилка збереження)",
        ["Bedtime Fade-out"] = "Плавне згасання",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Згасання вимкнено. Гучність залишається на поточному рівні; змініть вручну.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Згасання вимкнено лише на цей сеанс (помилка збереження). Гучність не змінилася; налаштуйте вручну.",
        ["Bedtime fade enabled"] = "Плавне згасання увімкнено",
        ["Bedtime fade disabled"] = "Плавне згасання вимкнено",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Згасання увімкнено лише на цей сеанс (помилка збереження)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Згасання вимкнено лише на цей сеанс (помилка збереження)",
        ["Fade Duration (minutes)"] = "Тривалість згасання (хв)",
        ["Fade duration: %d min"] = "Тривалість згасання: %d хв",
        ["Fade duration: %d min for this session only (storage failed)"] = "Тривалість згасання: %d хв лише на цей сеанс (помилка збереження)",
        ["Bedtime Fade-out: Unsupported"] = "Плавне згасання: Не підтримується",
        ["Bedtime fade requires silent and transient volume support"] = "Плавному згасанню потрібна підтримка тихої та тимчасової гучності",
        ["Show Time Remaining"] = "Показати час, що залишився",
        ["How It Works"] = "Як це працює",
        ["Extended Sleep Timer"] = "Розширений таймер сну",
    },
    vi = {
        ["%d min"] = "%d phút",
        ["%d hr"] = "%d giờ",
        ["%d hr %d min"] = "%d giờ %d phút",
        ["Sleep timer finished"] = "Đã hết hẹn giờ ngủ",
        ["Could not arm sleep timer: all timer slots busy"] = "Không thể bật hẹn giờ ngủ: đã hết khe hẹn giờ",
        ["Sleep timer set for %s"] = "Đã đặt hẹn giờ ngủ %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "Đã hủy hẹn giờ ngủ. Âm lượng giữ nguyên mức hiện tại; hãy chỉnh thủ công.",
        ["Extended sleep timer cancelled"] = "Đã hủy hẹn giờ ngủ mở rộng",
        ["Extended sleep timer is off"] = "Hẹn giờ ngủ mở rộng đang tắt",
        ["Remaining: %s (fade cancelled by volume change)"] = "Còn lại: %s (đã hủy giảm dần do đổi âm lượng)",
        ["Remaining: %s (fading out)"] = "Còn lại: %s (đang giảm dần âm lượng)",
        ["Time remaining: %s"] = "Thời gian còn lại: %s",
        ["Stops playback when the countdown reaches zero."] = "Dừng phát nhạc khi đếm ngược về 0.",
        ["Choose any duration from 15 minutes to 3 hours."] = "Chọn thời lượng bất kỳ từ 15 phút đến 3 giờ.",
        ["Changing duration while armed restarts the countdown."] = "Thay đổi thời lượng khi đang bật sẽ khởi động lại đếm ngược.",
        ["The countdown resets when the player restarts."] = "Bộ đếm ngược sẽ đặt lại khi máy phát khởi động lại.",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "Giảm âm lượng trước khi ngủ sẽ hạ nhỏ âm lượng trong 1 đến 30 phút cuối.",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "Chỉnh âm lượng thủ công khi đang giảm dần sẽ hủy giảm âm cho lần đếm này.",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "Khi kết thúc hoặc hủy, âm lượng giữ nguyên mức hiện tại; hãy chỉnh thủ công.",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "Không hỗ trợ giảm âm dần: thiết bị thiếu âm lượng ẩn/tạm thời.",
        ["About Extended Timer"] = "Giới thiệu hẹn giờ mở rộng",
        ["Timer Enabled"] = "Bật hẹn giờ",
        ["Duration (minutes)"] = "Thời lượng (phút)",
        ["Timer restarted: %s"] = "Đã khởi động lại hẹn giờ: %s",
        ["Timer restarted: %s for this session only (storage failed)"] = "Đã khởi động lại hẹn giờ: %s chỉ trong phiên này (lỗi lưu)",
        ["Duration: %s"] = "Thời lượng: %s",
        ["Duration: %s for this session only (storage failed)"] = "Thời lượng: %s chỉ trong phiên này (lỗi lưu)",
        ["Bedtime Fade-out"] = "Giảm âm dần khi ngủ",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "Đã tắt giảm âm dần. Âm lượng giữ nguyên mức hiện tại; hãy chỉnh thủ công.",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "Đã tắt giảm âm dần chỉ trong phiên này (lỗi lưu). Âm lượng giữ nguyên; hãy chỉnh thủ công.",
        ["Bedtime fade enabled"] = "Đã bật giảm âm dần",
        ["Bedtime fade disabled"] = "Đã tắt giảm âm dần",
        ["Bedtime fade enabled for this session only (storage failed)"] = "Đã bật giảm âm dần chỉ trong phiên này (lỗi lưu)",
        ["Bedtime fade disabled for this session only (storage failed)"] = "Đã tắt giảm âm dần chỉ trong phiên này (lỗi lưu)",
        ["Fade Duration (minutes)"] = "Thời gian giảm âm (phút)",
        ["Fade duration: %d min"] = "Thời gian giảm âm: %d phút",
        ["Fade duration: %d min for this session only (storage failed)"] = "Thời gian giảm âm: %d phút chỉ trong phiên này (lỗi lưu)",
        ["Bedtime Fade-out: Unsupported"] = "Giảm âm dần: Không hỗ trợ",
        ["Bedtime fade requires silent and transient volume support"] = "Giảm âm dần cần hỗ trợ âm lượng ẩn và tạm thời",
        ["Show Time Remaining"] = "Xem thời gian còn lại",
        ["How It Works"] = "Cách hoạt động",
        ["Extended Sleep Timer"] = "Hẹn giờ ngủ mở rộng",
    },
    zh_CN = {
        ["%d min"] = "%d 分钟",
        ["%d hr"] = "%d 小时",
        ["%d hr %d min"] = "%d 小时 %d 分钟",
        ["Sleep timer finished"] = "睡眠定时器已结束",
        ["Could not arm sleep timer: all timer slots busy"] = "无法启动睡眠定时器：所有定时器槽位已满",
        ["Sleep timer set for %s"] = "睡眠定时器已设为 %s",
        ["Sleep timer cancelled. Volume stays at its current level; adjust manually."] = "睡眠定时器已取消。音量保持当前水平，请手动调节。",
        ["Extended sleep timer cancelled"] = "扩展睡眠定时器已取消",
        ["Extended sleep timer is off"] = "扩展睡眠定时器已关闭",
        ["Remaining: %s (fade cancelled by volume change)"] = "剩余：%s（音量更改已取消淡出）",
        ["Remaining: %s (fading out)"] = "剩余：%s（正在淡出）",
        ["Time remaining: %s"] = "剩余时间：%s",
        ["Stops playback when the countdown reaches zero."] = "倒计时归零时停止播放。",
        ["Choose any duration from 15 minutes to 3 hours."] = "可选择 15 分钟至 3 小时之间的任意时长。",
        ["Changing duration while armed restarts the countdown."] = "启用状态下更改时长会重新开始倒计时。",
        ["The countdown resets when the player restarts."] = "播放器重启后倒计时会重置。",
        ["Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes."] = "睡前淡出会在最后 1 至 30 分钟内平稳降低音量。",
        ["Manual volume adjustment during fade cancels fading for this countdown."] = "淡出期间手动调节音量将取消本次倒计时的淡出。",
        ["When finished or cancelled, volume stays at its current level; adjust manually."] = "结束或取消后，音量保持当前水平，请手动调节。",
        ["Bedtime Fade-out unavailable: player lacks silent/transient volume."] = "睡前淡出不可用：播放器不支持静默/临时音量。",
        ["About Extended Timer"] = "关于扩展定时器",
        ["Timer Enabled"] = "启用定时器",
        ["Duration (minutes)"] = "时长（分钟）",
        ["Timer restarted: %s"] = "定时器已重启：%s",
        ["Timer restarted: %s for this session only (storage failed)"] = "定时器已重启：%s，仅本次会话有效（保存失败）",
        ["Duration: %s"] = "时长：%s",
        ["Duration: %s for this session only (storage failed)"] = "时长：%s，仅本次会话有效（保存失败）",
        ["Bedtime Fade-out"] = "睡前淡出",
        ["Bedtime fade disabled. Volume stays at its current level; adjust manually."] = "睡前淡出已关闭。音量保持当前水平，请手动调节。",
        ["Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."] = "睡前淡出已关闭，仅本次会话有效（保存失败）。音量保持当前水平，请手动调节。",
        ["Bedtime fade enabled"] = "睡前淡出已开启",
        ["Bedtime fade disabled"] = "睡前淡出已关闭",
        ["Bedtime fade enabled for this session only (storage failed)"] = "睡前淡出已开启，仅本次会话有效（保存失败）",
        ["Bedtime fade disabled for this session only (storage failed)"] = "睡前淡出已关闭，仅本次会话有效（保存失败）",
        ["Fade Duration (minutes)"] = "淡出时长（分钟）",
        ["Fade duration: %d min"] = "淡出时长：%d 分钟",
        ["Fade duration: %d min for this session only (storage failed)"] = "淡出时长：%d 分钟，仅本次会话有效（保存失败）",
        ["Bedtime Fade-out: Unsupported"] = "睡前淡出：不支持",
        ["Bedtime fade requires silent and transient volume support"] = "睡前淡出需要静默和临时音量支持",
        ["Show Time Remaining"] = "显示剩余时间",
        ["How It Works"] = "工作原理",
        ["Extended Sleep Timer"] = "扩展睡眠定时器",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- An extended, plugin-owned sleep timer with an optional bedtime fade-out.
-- Duration and fade preferences persist; the countdown resets when the
-- player restarts, matching the native sleep timer behavior.

local STATE_PATH = plugin.sd_root() .. "/.plugins/.extended_sleep_timer_state"
local MIN_MINUTES = 15
local MAX_MINUTES = 180
local MIN_FADE_MINUTES = 1
local MAX_FADE_MINUTES = 30

local duration_minutes = 60
local fade_enabled = false
local fade_minutes = 15
local armed = false
local deadline = 0
local timer_handle = nil

local fade_in_progress = false
local captured_volume = nil
local last_applied_volume = nil
local fade_cancelled_manual = false

local function is_finite_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function clamp_duration(value)
    local n = tonumber(value)
    if not is_finite_number(n) then return 60 end
    n = math.floor(n)
    if n < MIN_MINUTES then return MIN_MINUTES end
    if n > MAX_MINUTES then return MAX_MINUTES end
    return n
end

local function clamp_fade(value)
    local n = tonumber(value)
    if not is_finite_number(n) then return 15 end
    n = math.floor(n)
    if n < MIN_FADE_MINUTES then return MIN_FADE_MINUTES end
    if n > MAX_FADE_MINUTES then return MAX_FADE_MINUTES end
    return n
end

local function is_fade_supported()
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
    -- 1. Check for modern transactional versioned JSON blob.
    -- All fields must be valid and complete before preferring it over legacy SD fallback.
    if plugin.storage and plugin.storage.get then
        local content = nil
        pcall(function() content = plugin.storage.get("config") end)
        if content and content ~= "" and #content <= 4096 then
            local data = decode_json(content)
            if type(data) == "table"
                and data.version == 1
                and is_finite_number(tonumber(data.duration_minutes))
                and type(data.fade_enabled) == "boolean"
                and is_finite_number(tonumber(data.fade_minutes)) then
                duration_minutes = clamp_duration(data.duration_minutes)
                fade_enabled = data.fade_enabled
                fade_minutes = clamp_fade(data.fade_minutes)
                return
            end
        end
    end

    -- 2. If no complete valid JSON blob exists, check SD read-only migration fallback
    local sd_found = false
    pcall(function()
        local f = io.open(STATE_PATH, "r")
        if not f then return end
        local line_dur = f:read("*l")
        local line_fade_en = f:read("*l")
        local line_fade_min = f:read("*l")
        f:close()
        if line_dur and line_dur ~= "" then
            duration_minutes = clamp_duration(line_dur)
            sd_found = true
        end
        if line_fade_en and line_fade_en ~= "" then
            fade_enabled = (line_fade_en == "1" or line_fade_en == "true")
        else
            fade_enabled = false
        end
        if line_fade_min and line_fade_min ~= "" then
            fade_minutes = clamp_fade(line_fade_min)
        else
            fade_minutes = 15
        end
    end)
    if sd_found then return end

    -- 3. If neither blob nor SD file exists, check legacy unversioned storage key
    if plugin.storage and plugin.storage.get then
        pcall(function()
            local s_dur = plugin.storage.get("duration_minutes")
            if s_dur and s_dur ~= "" then
                duration_minutes = clamp_duration(s_dur)
            end
        end)
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
            duration_minutes = duration_minutes,
            fade_enabled = fade_enabled,
            fade_minutes = fade_minutes,
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

    -- Clean up legacy individual keys so they cannot mask future state
    if plugin.storage.delete then
        pcall(function()
            plugin.storage.delete("duration_minutes")
            plugin.storage.delete("fade_enabled")
            plugin.storage.delete("fade_minutes")
        end)
    end
    return true
end

local function format_duration(minutes)
    local hours = math.floor(minutes / 60)
    local remainder = minutes % 60
    if hours == 0 then return string.format(tr("%d min"), remainder) end
    if remainder == 0 then return string.format(tr("%d hr"), hours) end
    return string.format(tr("%d hr %d min"), hours, remainder)
end

local function format_remaining(seconds)
    seconds = math.max(0, math.floor(seconds))
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor(seconds / 60) % 60
    local secs = seconds % 60
    if hours > 0 then return string.format("%d:%02d:%02d", hours, minutes, secs) end
    return string.format("%d:%02d", minutes, secs)
end

local function remaining_seconds()
    if not armed then return 0 end
    return math.max(0, deadline - os.time())
end

local function clear_timer()
    if timer_handle then
        plugin.clear_interval(timer_handle)
        timer_handle = nil
    end
end

local tick

local function ensure_timer()
    if timer_handle then return true end
    local ok, handle = pcall(plugin.set_interval, 1, tick)
    if ok and handle then
        timer_handle = handle
        return true
    end
    return false
end

tick = function()
    if not armed then
        clear_timer()
        return
    end

    local rem = remaining_seconds()
    if rem <= 0 then
        armed = false
        deadline = 0
        clear_timer()
        fade_in_progress = false
        captured_volume = nil
        last_applied_volume = nil
        fade_cancelled_manual = false
        plugin.stop()
        plugin.show_toast(tr("Sleep timer finished"))
        return
    end

    -- Bedtime fade-out: active only when enabled, supported, and not cancelled by manual volume change
    if fade_enabled and is_fade_supported() and not fade_cancelled_manual then
        local effective_fade_mins = math.min(fade_minutes, duration_minutes)
        local fade_sec = effective_fade_mins * 60
        if rem <= fade_sec then
            local cur = plugin.get_volume()
            if not fade_in_progress then
                -- Capture starting volume once when fade window begins
                fade_in_progress = true
                captured_volume = cur
                last_applied_volume = cur
            else
                -- Detect manual volume adjustment
                if cur ~= last_applied_volume then
                    -- Manual change cancels fading for this countdown; timer still stops at deadline
                    fade_cancelled_manual = true
                    fade_in_progress = false
                    return
                end
            end

            -- Proper remaining-time ratio fade down from captured_volume to 0
            local raw = math.floor(captured_volume * (rem / fade_sec))
            local target = math.min(last_applied_volume, raw)
            if target < cur then
                last_applied_volume = target
                plugin.set_volume(target, { silent = true, persist = false })
            end
        end
    end
end

local function set_armed(value)
    if value then
        deadline = os.time() + duration_minutes * 60
        fade_in_progress = false
        captured_volume = nil
        last_applied_volume = nil
        fade_cancelled_manual = false

        if not ensure_timer() then
            armed = false
            deadline = 0
            plugin.show_toast(tr("Could not arm sleep timer: all timer slots busy"))
            return false
        end

        armed = true
        plugin.show_toast(string.format(tr("Sleep timer set for %s"), format_duration(duration_minutes)))
    else
        local had_fade = fade_in_progress or fade_cancelled_manual
        armed = false
        deadline = 0
        clear_timer()
        fade_in_progress = false
        captured_volume = nil
        last_applied_volume = nil
        fade_cancelled_manual = false

        if had_fade then
            plugin.show_toast(tr("Sleep timer cancelled. Volume stays at its current level; adjust manually."))
        else
            plugin.show_toast(tr("Extended sleep timer cancelled"))
        end
    end
    return true
end

local function show_status()
    if not armed then
        plugin.show_toast(tr("Extended sleep timer is off"))
        return
    end
    local rem = remaining_seconds()
    if fade_cancelled_manual then
        plugin.show_toast(string.format(tr("Remaining: %s (fade cancelled by volume change)"), format_remaining(rem)))
    elseif fade_in_progress then
        plugin.show_toast(string.format(tr("Remaining: %s (fading out)"), format_remaining(rem)))
    else
        plugin.show_toast(string.format(tr("Time remaining: %s"), format_remaining(rem)))
    end
end

local function open_about()
    local about_lines = {
        tr("Stops playback when the countdown reaches zero."),
        tr("Choose any duration from 15 minutes to 3 hours."),
        tr("Changing duration while armed restarts the countdown."),
        tr("The countdown resets when the player restarts."),
    }
    if is_fade_supported() then
        about_lines[#about_lines + 1] = tr("Bedtime Fade-out quietly lowers volume over the final 1 to 30 minutes.")
        about_lines[#about_lines + 1] = tr("Manual volume adjustment during fade cancels fading for this countdown.")
        about_lines[#about_lines + 1] = tr("When finished or cancelled, volume stays at its current level; adjust manually.")
    else
        about_lines[#about_lines + 1] = tr("Bedtime Fade-out unavailable: player lacks silent/transient volume.")
    end
    plugin.show_list(tr("About Extended Timer"), about_lines, function() end)
end

local function open_settings()
    local items = {
        {
            type = "toggle",
            label = tr("Timer Enabled"),
            value = armed,
            on_change = set_armed,
        },
        {
            type = "slider",
            label = tr("Duration (minutes)"),
            min = MIN_MINUTES,
            max = MAX_MINUTES,
            value = duration_minutes,
            on_change = function(value)
                duration_minutes = clamp_duration(value)
                local saved = save_state()
                if armed then
                    deadline = os.time() + duration_minutes * 60
                    fade_in_progress = false
                    captured_volume = nil
                    last_applied_volume = nil
                    fade_cancelled_manual = false
                    if saved then
                        plugin.show_toast(string.format(tr("Timer restarted: %s"), format_duration(duration_minutes)))
                    else
                        plugin.show_toast(string.format(tr("Timer restarted: %s for this session only (storage failed)"), format_duration(duration_minutes)))
                    end
                else
                    if saved then
                        plugin.show_toast(string.format(tr("Duration: %s"), format_duration(duration_minutes)))
                    else
                        plugin.show_toast(string.format(tr("Duration: %s for this session only (storage failed)"), format_duration(duration_minutes)))
                    end
                end
            end,
        },
    }

    if is_fade_supported() then
        items[#items + 1] = {
            type = "toggle",
            label = tr("Bedtime Fade-out"),
            value = fade_enabled,
            on_change = function(value)
                fade_enabled = (value == true)
                local saved = save_state()
                if not fade_enabled and fade_in_progress then
                    fade_in_progress = false
                    captured_volume = nil
                    last_applied_volume = nil
                    if saved then
                        plugin.show_toast(tr("Bedtime fade disabled. Volume stays at its current level; adjust manually."))
                    else
                        plugin.show_toast(tr("Bedtime fade disabled for this session only (storage failed). Volume stays at its current level; adjust manually."))
                    end
                else
                    local status = fade_enabled and "Bedtime fade enabled" or "Bedtime fade disabled"
                    if saved then
                        plugin.show_toast(tr(status))
                    else
                        plugin.show_toast(tr(status .. " for this session only (storage failed)"))
                    end
                end
            end,
        }
        items[#items + 1] = {
            type = "slider",
            label = tr("Fade Duration (minutes)"),
            min = MIN_FADE_MINUTES,
            max = MAX_FADE_MINUTES,
            value = fade_minutes,
            on_change = function(value)
                fade_minutes = clamp_fade(value)
                local saved = save_state()
                if saved then
                    plugin.show_toast(string.format(tr("Fade duration: %d min"), fade_minutes))
                else
                    plugin.show_toast(string.format(tr("Fade duration: %d min for this session only (storage failed)"), fade_minutes))
                end
            end,
        }
    else
        items[#items + 1] = {
            type = "row",
            label = tr("Bedtime Fade-out: Unsupported"),
            on_select = function()
                plugin.show_toast(tr("Bedtime fade requires silent and transient volume support"))
            end,
        }
    end

    items[#items + 1] = {
        type = "row",
        label = tr("Show Time Remaining"),
        on_select = show_status,
    }
    items[#items + 1] = {
        type = "row",
        label = tr("How It Works"),
        on_select = open_about,
    }

    plugin.show_settings_list(tr("Extended Sleep Timer"), items)
end

load_state()

plugin.register_list_item("music_timers", tr("Extended Sleep Timer"), open_settings)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        open_settings = open_settings,
        set_armed = set_armed,
        tick = tick,
        is_armed = function() return armed end,
        get_deadline = function() return deadline end,
        get_duration_minutes = function() return duration_minutes end,
        get_fade_minutes = function() return fade_minutes end,
        is_fade_enabled = function() return fade_enabled end,
        is_fade_in_progress = function() return fade_in_progress end,
        is_fade_cancelled_manual = function() return fade_cancelled_manual end,
        get_captured_volume = function() return captured_volume end,
        has_timer = function() return timer_handle ~= nil end,
        save_state = save_state,
        load_state = load_state,
    }
end
