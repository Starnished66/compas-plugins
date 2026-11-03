plugin.define({
    id = "org.compas.album_playback_rules",
    name = "Album Playback Rules",
    version = "1.2",
    api_min = 19,
})

local T = {
    de = {
        ["Failed to encode configuration"] = "Konfiguration konnte nicht kodiert werden",
        ["Failed to save settings to storage; changes are live for this session only"] = "Einstellungen konnten nicht gespeichert werden; Änderungen gelten nur für diese Sitzung",
        ["Storage unavailable; changes are live for this session only"] = "Speicher nicht verfügbar; Änderungen gelten nur für diese Sitzung",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Informationen zu Wiedergaberegeln pro Album:\n\n• Bereich & Abgleich: Regeln gelten anhand der Tags des aktuellen Titels (Künstler + Album) unabhängig von der Warteschlange. Das Plugin erkennt nicht, ob ein ganzes Album oder ein einzelner Titel in der Warteschlange ist, und kann ReplayGain nicht rückwirkend für den ersten laufenden Titel ändern.\n• ReplayGain-Zeitpunkt: Änderungen des ReplayGain-Modus wirken beim nächsten Titelwechsel.\n• Speicherung: Native Einstellungen (unterbrechungsfrei, Überblenden, ReplayGain, Reihenfolge) werden in den Systemeinstellungen gespeichert. Das Plugin ändert nur abweichende Werte und stellt Ausgangswerte beim Verlassen des Albums oder Deaktivieren wieder her.\n• Manuelle Änderungen: Manuelle Anpassungen während eines Albums bleiben beim Verlassen erhalten.\n• Kopplung: Unterbrechungsfrei deaktivieren schaltet Überblenden aus; Überblenden aktivieren schaltet unterbrechungsfrei ein.",
        ["Album Rules Policy"] = "Richtlinie für Albumregeln",
        ["Matches track tags; ReplayGain takes effect next track"] = "Gleicht Titel-Tags ab; ReplayGain wirkt beim nächsten Titel",
        ["Crossfade: Default"] = "Überblenden: Standard",
        ["Crossfade: Enabled"] = "Überblenden: Aktiviert",
        ["Crossfade: Disabled"] = "Überblenden: Deaktiviert",
        ["Gapless: Default"] = "Unterbrechungsfrei: Standard",
        ["Gapless: Enabled"] = "Unterbrechungsfrei: Aktiviert",
        ["Gapless: Disabled"] = "Unterbrechungsfrei: Deaktiviert",
        ["ReplayGain: Default"] = "ReplayGain: Standard",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Aus",
        ["track"] = "Titel",
        ["album"] = "Album",
        ["Play Order: Default"] = "Wiedergabereihenfolge: Standard",
        ["Play Order: %s"] = "Wiedergabereihenfolge: %s",
        ["sequential"] = "Der Reihe nach",
        ["repeat_all"] = "Alle wiederholen",
        ["repeat_one"] = "Einen wiederholen",
        ["shuffle"] = "Zufallswiedergabe",
        ["Album: %s"] = "Album: %s",
        ["Artist: %s"] = "Künstler: %s",
        ["Delete Rule"] = "Regel löschen",
        ["Edit Album Rule"] = "Albumregel bearbeiten",
        ["None"] = "Keine",
        ["Enabled"] = "Aktiviert",
        ["Active Session: %s"] = "Aktive Sitzung: %s",
        ["Add Rule for Current Album..."] = "Regel für aktuelles Album hinzufügen...",
        ["No album currently playing"] = "Derzeit wird kein Album abgespielt",
        ["Add Rule Manually..."] = "Regel manuell hinzufügen...",
        ["Artist Name"] = "Künstlername",
        ["Album Name"] = "Albumname",
        ["Persistence & ReplayGain Info"] = "Info zu Speicherung & ReplayGain",
        ["Album Playback Rules"] = "Wiedergaberegeln pro Album",
    },
    es = {
        ["Failed to encode configuration"] = "Error al codificar la configuración",
        ["Failed to save settings to storage; changes are live for this session only"] = "No se pudieron guardar los ajustes; los cambios solo se aplican en esta sesión",
        ["Storage unavailable; changes are live for this session only"] = "Almacenamiento no disponible; los cambios solo se aplican en esta sesión",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Información de reglas de reproducción por álbum:\n\n• Alcance y coincidencia: Las reglas coinciden con las etiquetas de la pista actual (Artista + Álbum) sin importar la cola. La API no permite inspeccionar la cola, por lo que el plugin no detecta si hay un álbum completo o una pista suelta, ni puede cambiar ReplayGain retroactivamente en la primera pista.\n• ReplayGain: Los cambios de modo ReplayGain surten efecto en el siguiente cambio de pista.\n• Persistencia: Los ajustes nativos (sin pausas, fundido, ReplayGain, orden) persisten en el sistema. El plugin aplica solo los valores modificados y restaura los originales al salir del álbum o desactivar el plugin.\n• Cambios manuales: Si ajustas algo manualmente durante un álbum, el plugin respeta tu cambio al salir del álbum.\n• Acoplamiento sin pausas y fundido: Desactivar sin pausas desactiva el fundido; activar el fundido activa sin pausas.",
        ["Album Rules Policy"] = "Política de reglas por álbum",
        ["Matches track tags; ReplayGain takes effect next track"] = "Coincide con etiquetas de pista; ReplayGain actúa en la siguiente pista",
        ["Crossfade: Default"] = "Fundido: Predeterminado",
        ["Crossfade: Enabled"] = "Fundido: Activado",
        ["Crossfade: Disabled"] = "Fundido: Desactivado",
        ["Gapless: Default"] = "Sin pausas: Predeterminado",
        ["Gapless: Enabled"] = "Sin pausas: Activado",
        ["Gapless: Disabled"] = "Sin pausas: Desactivado",
        ["ReplayGain: Default"] = "ReplayGain: Predeterminado",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Desactivado",
        ["track"] = "Pista",
        ["album"] = "Álbum",
        ["Play Order: Default"] = "Orden de reproducción: Predeterminado",
        ["Play Order: %s"] = "Orden de reproducción: %s",
        ["sequential"] = "Secuencial",
        ["repeat_all"] = "Repetir todo",
        ["repeat_one"] = "Repetir una",
        ["shuffle"] = "Aleatorio",
        ["Album: %s"] = "Álbum: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Delete Rule"] = "Eliminar regla",
        ["Edit Album Rule"] = "Editar regla de álbum",
        ["None"] = "Ninguna",
        ["Enabled"] = "Activado",
        ["Active Session: %s"] = "Sesión activa: %s",
        ["Add Rule for Current Album..."] = "Añadir regla para el álbum actual...",
        ["No album currently playing"] = "No hay ningún álbum reproduciéndose",
        ["Add Rule Manually..."] = "Añadir regla manualmente...",
        ["Artist Name"] = "Nombre del artista",
        ["Album Name"] = "Nombre del álbum",
        ["Persistence & ReplayGain Info"] = "Info de persistencia y ReplayGain",
        ["Album Playback Rules"] = "Reglas de reproducción por álbum",
    },
    fi = {
        ["Failed to encode configuration"] = "Asetusten koodaus epäonnistui",
        ["Failed to save settings to storage; changes are live for this session only"] = "Asetusten tallennus epäonnistui; muutokset ovat voimassa vain tässä istunnossa",
        ["Storage unavailable; changes are live for this session only"] = "Tallennustila ei ole käytettävissä; muutokset ovat voimassa vain tässä istunnossa",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Tietoa albumikohtaisista toistosäännöistä:\n\n• Kohdistus: Säännöt tunnistavat soivan kappaleen tunnisteet (Esittäjä + Albumi) jonosta riippumatta. Lisäosa ei näe jonon sisältöä eikä voi muuttaa jo soivan ensimmäisen kappaleen ReplayGain-arvoa.\n• ReplayGain-ajoitus: ReplayGain-muutokset tulevat voimaan seuraavan kappaleen vaihtuessa.\n• Pysyvyys: Soittimen asetukset (tauoton toisto, ristiinhäivytys, ReplayGain, toistojärjestys) tallentuvat järjestelmän asetuksiin. Lisäosa muuttaa vain tarvittavat arvot ja palauttaa alkuperäiset arvot albumin päättyessä tai lisäosan poistuessa käytöstä.\n• Käsin tehdyt muutokset: Jos muutat asetusta albumin aikana, lisäosa säilyttää muutoksesi.\n• Tauoton toisto ja ristiinhäivytys: Tauottoman toiston poistaminen poistaa ristiinhäivytyksen; ristiinhäivytyksen käyttöönotto ottaa tauottoman toiston käyttöön.",
        ["Album Rules Policy"] = "Albumisääntöjen käytäntö",
        ["Matches track tags; ReplayGain takes effect next track"] = "Täsmää kappaleen tunnisteisiin; ReplayGain vaikuttaa seuraavassa kappaleessa",
        ["Crossfade: Default"] = "Ristiinhäivytys: Oletus",
        ["Crossfade: Enabled"] = "Ristiinhäivytys: Käytössä",
        ["Crossfade: Disabled"] = "Ristiinhäivytys: Pois",
        ["Gapless: Default"] = "Tauoton: Oletus",
        ["Gapless: Enabled"] = "Tauoton: Käytössä",
        ["Gapless: Disabled"] = "Tauoton: Pois",
        ["ReplayGain: Default"] = "ReplayGain: Oletus",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Pois",
        ["track"] = "Kappale",
        ["album"] = "Albumi",
        ["Play Order: Default"] = "Toistojärjestys: Oletus",
        ["Play Order: %s"] = "Toistojärjestys: %s",
        ["sequential"] = "Järjestyksessä",
        ["repeat_all"] = "Kertaa kaikki",
        ["repeat_one"] = "Kertaa yksi",
        ["shuffle"] = "Sekoitus",
        ["Album: %s"] = "Albumi: %s",
        ["Artist: %s"] = "Esittäjä: %s",
        ["Delete Rule"] = "Poista sääntö",
        ["Edit Album Rule"] = "Muokkaa albumisääntöä",
        ["None"] = "Ei mitään",
        ["Enabled"] = "Käytössä",
        ["Active Session: %s"] = "Aktiivinen istunto: %s",
        ["Add Rule for Current Album..."] = "Lisää sääntö nykyiselle albumille...",
        ["No album currently playing"] = "Mikään albumi ei soi parhaillaan",
        ["Add Rule Manually..."] = "Lisää sääntö käsin...",
        ["Artist Name"] = "Esittäjän nimi",
        ["Album Name"] = "Albumin nimi",
        ["Persistence & ReplayGain Info"] = "Tietoa pysyvyydestä ja ReplayGainista",
        ["Album Playback Rules"] = "Albumikohtaiset toistosäännöt",
    },
    fr = {
        ["Failed to encode configuration"] = "Échec de l'encodage de la configuration",
        ["Failed to save settings to storage; changes are live for this session only"] = "Échec de l'enregistrement des paramètres ; les modifications ne s'appliquent qu'à cette session",
        ["Storage unavailable; changes are live for this session only"] = "Stockage indisponible ; les modifications ne s'appliquent qu'à cette session",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Informations sur les règles de lecture par album :\n\n• Portée et correspondance : Les règles correspondent aux tags de la piste en cours (Artiste + Album) quel que soit le type de file. Le plugin ne peut pas détecter si un album complet ou un titre seul est en file d'attente, ni modifier rétroactivement le ReplayGain du premier titre en cours.\n• ReplayGain : Les changements de mode ReplayGain prennent effet à la piste suivante.\n• Persistance : Les paramètres natifs (sans blanc, fondu, ReplayGain, ordre de lecture) persistent dans le système. Le plugin n'applique que les valeurs modifiées et restaure les valeurs initiales en quittant l'album ou en désactivant le plugin.\n• Modifications manuelles : Si vous modifiez un paramètre manuellement pendant la lecture d'un album, ce choix est conservé à la sortie.\n• Couplage sans blanc et fondu : Désactiver la lecture sans blanc désactive le fondu ; activer le fondu active la lecture sans blanc.",
        ["Album Rules Policy"] = "Politique des règles d'album",
        ["Matches track tags; ReplayGain takes effect next track"] = "Correspond aux tags ; ReplayGain prend effet au titre suivant",
        ["Crossfade: Default"] = "Fondu : Par défaut",
        ["Crossfade: Enabled"] = "Fondu : Activé",
        ["Crossfade: Disabled"] = "Fondu : Désactivé",
        ["Gapless: Default"] = "Sans blanc : Par défaut",
        ["Gapless: Enabled"] = "Sans blanc : Activé",
        ["Gapless: Disabled"] = "Sans blanc : Désactivé",
        ["ReplayGain: Default"] = "ReplayGain : Par défaut",
        ["ReplayGain: %s"] = "ReplayGain : %s",
        ["off"] = "Désactivé",
        ["track"] = "Piste",
        ["album"] = "Album",
        ["Play Order: Default"] = "Ordre de lecture : Par défaut",
        ["Play Order: %s"] = "Ordre de lecture : %s",
        ["sequential"] = "Séquentiel",
        ["repeat_all"] = "Tout répéter",
        ["repeat_one"] = "Répéter un titre",
        ["shuffle"] = "Aléatoire",
        ["Album: %s"] = "Album : %s",
        ["Artist: %s"] = "Artiste : %s",
        ["Delete Rule"] = "Supprimer la règle",
        ["Edit Album Rule"] = "Modifier la règle d'album",
        ["None"] = "Aucune",
        ["Enabled"] = "Activé",
        ["Active Session: %s"] = "Session active : %s",
        ["Add Rule for Current Album..."] = "Ajouter une règle pour l'album en cours...",
        ["No album currently playing"] = "Aucun album en cours de lecture",
        ["Add Rule Manually..."] = "Ajouter une règle manuellement...",
        ["Artist Name"] = "Nom de l'artiste",
        ["Album Name"] = "Nom de l'album",
        ["Persistence & ReplayGain Info"] = "Infos persistance et ReplayGain",
        ["Album Playback Rules"] = "Règles de lecture par album",
    },
    it = {
        ["Failed to encode configuration"] = "Impossibile codificare la configurazione",
        ["Failed to save settings to storage; changes are live for this session only"] = "Impossibile salvare le impostazioni; le modifiche valgono solo per questa sessione",
        ["Storage unavailable; changes are live for this session only"] = "Archiviazione non disponibile; le modifiche valgono solo per questa sessione",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Informazioni sulle regole di riproduzione per album:\n\n• Ambito e corrispondenza: Le regole corrispondono ai tag del brano in riproduzione (Artista + Album) indipendentemente dalla coda. Il plugin non può rilevare se in coda c'è un intero album o un singolo brano, né cambiare retroattivamente il ReplayGain del primo brano già in riproduzione.\n• Tempistica ReplayGain: Le modifiche al ReplayGain hanno effetto dal brano successivo.\n• Persistenza: Le impostazioni native (gapless, dissolvenza, ReplayGain, ordine) persistono nelle impostazioni di sistema. Il plugin applica solo i valori modificati e ripristina quelli iniziali all'uscita dall'album o alla disattivazione.\n• Modifiche manuali: Se modifichi manualmente un'impostazione durante l'ascolto di un album, la modifica viene mantenuta.\n• Accoppiamento gapless e dissolvenza: Disattivare gapless disattiva la dissolvenza; attivare la dissolvenza attiva gapless.",
        ["Album Rules Policy"] = "Criteri regole album",
        ["Matches track tags; ReplayGain takes effect next track"] = "Usa i tag del brano; ReplayGain ha effetto dal brano successivo",
        ["Crossfade: Default"] = "Dissolvenza: Predefinito",
        ["Crossfade: Enabled"] = "Dissolvenza: Attivata",
        ["Crossfade: Disabled"] = "Dissolvenza: Disattivata",
        ["Gapless: Default"] = "Gapless: Predefinito",
        ["Gapless: Enabled"] = "Gapless: Attivato",
        ["Gapless: Disabled"] = "Gapless: Disattivato",
        ["ReplayGain: Default"] = "ReplayGain: Predefinito",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Disattivato",
        ["track"] = "Brano",
        ["album"] = "Album",
        ["Play Order: Default"] = "Ordine di riproduzione: Predefinito",
        ["Play Order: %s"] = "Ordine di riproduzione: %s",
        ["sequential"] = "Sequenziale",
        ["repeat_all"] = "Ripeti tutto",
        ["repeat_one"] = "Ripeti uno",
        ["shuffle"] = "Casuale",
        ["Album: %s"] = "Album: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Delete Rule"] = "Elimina regola",
        ["Edit Album Rule"] = "Modifica regola album",
        ["None"] = "Nessuna",
        ["Enabled"] = "Attivato",
        ["Active Session: %s"] = "Sessione attiva: %s",
        ["Add Rule for Current Album..."] = "Aggiungi regola per l'album attuale...",
        ["No album currently playing"] = "Nessun album in riproduzione",
        ["Add Rule Manually..."] = "Aggiungi regola manualmente...",
        ["Artist Name"] = "Nome artista",
        ["Album Name"] = "Nome album",
        ["Persistence & ReplayGain Info"] = "Info persistenza e ReplayGain",
        ["Album Playback Rules"] = "Regole di riproduzione per album",
    },
    ja = {
        ["Failed to encode configuration"] = "設定のエンコードに失敗しました",
        ["Failed to save settings to storage; changes are live for this session only"] = "設定を保存できませんでした。変更はこのセッションでのみ有効です",
        ["Storage unavailable; changes are live for this session only"] = "ストレージを利用できません。変更はこのセッションでのみ有効です",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "アルバム別再生ルールの情報:\n\n• 適用範囲: キューの種類に関係なく、再生中の曲のタグ (アーティスト + アルバム) に一致します。プラグインはキュー全体か単曲かを判別できず、再生中の最初の曲の ReplayGain を遡って変更することもできません。\n• ReplayGain のタイミング: ReplayGain モードの変更は次の曲への切り替え時に反映されます。\n• 設定の保持: 本体の設定 (ギャップレス、クロスフェード、ReplayGain、再生順) はシステム設定に保存されます。プラグインは変更された値のみを適用し、アルバム終了時やプラグイン無効化時に元の値へ戻します。\n• 手動変更の優先: アルバム再生中に手動で設定を変更した場合、終了時に上書きせずその変更を維持します。\n• ギャップレスとクロスフェードの連動: ギャップレスを無効にするとクロスフェードも無効になり、クロスフェードを有効にするとギャップレスも有効になります。",
        ["Album Rules Policy"] = "アルバムルールの仕様",
        ["Matches track tags; ReplayGain takes effect next track"] = "曲タグで一致・ReplayGain は次の曲から有効",
        ["Crossfade: Default"] = "クロスフェード: デフォルト",
        ["Crossfade: Enabled"] = "クロスフェード: 有効",
        ["Crossfade: Disabled"] = "クロスフェード: 無効",
        ["Gapless: Default"] = "ギャップレス: デフォルト",
        ["Gapless: Enabled"] = "ギャップレス: 有効",
        ["Gapless: Disabled"] = "ギャップレス: 無効",
        ["ReplayGain: Default"] = "ReplayGain: デフォルト",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "オフ",
        ["track"] = "トラック",
        ["album"] = "アルバム",
        ["Play Order: Default"] = "再生順: デフォルト",
        ["Play Order: %s"] = "再生順: %s",
        ["sequential"] = "順再生",
        ["repeat_all"] = "全曲リピート",
        ["repeat_one"] = "1曲リピート",
        ["shuffle"] = "シャッフル",
        ["Album: %s"] = "アルバム: %s",
        ["Artist: %s"] = "アーティスト: %s",
        ["Delete Rule"] = "ルールを削除",
        ["Edit Album Rule"] = "アルバムルールを編集",
        ["None"] = "なし",
        ["Enabled"] = "有効",
        ["Active Session: %s"] = "現在のセッション: %s",
        ["Add Rule for Current Album..."] = "現在のアルバムのルールを追加...",
        ["No album currently playing"] = "再生中のアルバムがありません",
        ["Add Rule Manually..."] = "ルールを手動で追加...",
        ["Artist Name"] = "アーティスト名",
        ["Album Name"] = "アルバム名",
        ["Persistence & ReplayGain Info"] = "設定保持と ReplayGain の情報",
        ["Album Playback Rules"] = "アルバム別再生ルール",
    },
    nl = {
        ["Failed to encode configuration"] = "Configuratie coderen mislukt",
        ["Failed to save settings to storage; changes are live for this session only"] = "Instellingen opslaan mislukt; wijzigingen gelden alleen voor deze sessie",
        ["Storage unavailable; changes are live for this session only"] = "Opslag niet beschikbaar; wijzigingen gelden alleen voor deze sessie",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Informatie over afspeelregels per album:\n\n• Bereik & overeenkomst: Regels gelden op basis van de tags van het huidige nummer (Artiest + Album), ongeacht de wachtrij. De plugin kan niet zien of een heel album of een los nummer in de wachtrij staat, en kan ReplayGain niet met terugwerkende kracht wijzigen voor het eerste spelende nummer.\n• ReplayGain-timing: Wijzigingen in ReplayGain gaan in bij het volgende nummer.\n• Opslag: Systeeminstellingen (gapless, crossfade, ReplayGain, afspeelvolgorde) worden blijvend opgeslagen. De plugin past alleen gewijzigde waarden toe en herstelt de beginwaarden wanneer je het album verlaat of de plugin uitschakelt.\n• Handmatige wijzigingen: Als je tijdens een album handmatig een instelling aanpast, blijft die behouden.\n• Koppeling gapless & crossfade: Gapless uitschakelen schakelt crossfade uit; crossfade inschakelen schakelt gapless in.",
        ["Album Rules Policy"] = "Beleid voor albumregels",
        ["Matches track tags; ReplayGain takes effect next track"] = "Gebruikt nummertags; ReplayGain werkt vanaf volgend nummer",
        ["Crossfade: Default"] = "Crossfade: Standaard",
        ["Crossfade: Enabled"] = "Crossfade: Ingeschakeld",
        ["Crossfade: Disabled"] = "Crossfade: Uitgeschakeld",
        ["Gapless: Default"] = "Gapless: Standaard",
        ["Gapless: Enabled"] = "Gapless: Ingeschakeld",
        ["Gapless: Disabled"] = "Gapless: Uitgeschakeld",
        ["ReplayGain: Default"] = "ReplayGain: Standaard",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Uit",
        ["track"] = "Nummer",
        ["album"] = "Album",
        ["Play Order: Default"] = "Afspeelvolgorde: Standaard",
        ["Play Order: %s"] = "Afspeelvolgorde: %s",
        ["sequential"] = "Op volgorde",
        ["repeat_all"] = "Alles herhalen",
        ["repeat_one"] = "Eén herhalen",
        ["shuffle"] = "Willekeurig",
        ["Album: %s"] = "Album: %s",
        ["Artist: %s"] = "Artiest: %s",
        ["Delete Rule"] = "Regel verwijderen",
        ["Edit Album Rule"] = "Albumregel bewerken",
        ["None"] = "Geen",
        ["Enabled"] = "Ingeschakeld",
        ["Active Session: %s"] = "Actieve sessie: %s",
        ["Add Rule for Current Album..."] = "Regel voor huidig album toevoegen...",
        ["No album currently playing"] = "Er speelt momenteel geen album",
        ["Add Rule Manually..."] = "Regel handmatig toevoegen...",
        ["Artist Name"] = "Artiestennaam",
        ["Album Name"] = "Albumnaam",
        ["Persistence & ReplayGain Info"] = "Info over opslag & ReplayGain",
        ["Album Playback Rules"] = "Afspeelregels per album",
    },
    pt = {
        ["Failed to encode configuration"] = "Falha ao codificar a configuração",
        ["Failed to save settings to storage; changes are live for this session only"] = "Falha ao salvar as configurações; as alterações valem apenas nesta sessão",
        ["Storage unavailable; changes are live for this session only"] = "Armazenamento indisponível; as alterações valem apenas nesta sessão",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Informações sobre regras de reprodução por álbum:\n\n• Escopo e correspondência: As regras usam as tags da faixa atual (Artista + Álbum), independentemente da fila. O plugin não detecta se há um álbum inteiro ou uma faixa avulsa na fila, nem pode alterar retroativamente o ReplayGain da primeira faixa em reprodução.\n• Tempo do ReplayGain: Alterações no modo ReplayGain entram em vigor na próxima faixa.\n• Persistência: Configurações nativas (sem pausas, crossfade, ReplayGain, ordem de reprodução) persistem no sistema. O plugin aplica apenas valores alterados e restaura os originais ao sair do álbum ou desativar o plugin.\n• Ajustes manuais: Se você ajustar algo manualmente durante um álbum, o plugin mantém sua alteração ao sair.\n• Acoplamento sem pausas e crossfade: Desativar sem pausas desativa o crossfade; ativar o crossfade ativa sem pausas.",
        ["Album Rules Policy"] = "Política de regras de álbum",
        ["Matches track tags; ReplayGain takes effect next track"] = "Usa tags da faixa; ReplayGain vale na próxima faixa",
        ["Crossfade: Default"] = "Crossfade: Padrão",
        ["Crossfade: Enabled"] = "Crossfade: Ativado",
        ["Crossfade: Disabled"] = "Crossfade: Desativado",
        ["Gapless: Default"] = "Sem pausas: Padrão",
        ["Gapless: Enabled"] = "Sem pausas: Ativado",
        ["Gapless: Disabled"] = "Sem pausas: Desativado",
        ["ReplayGain: Default"] = "ReplayGain: Padrão",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Desativado",
        ["track"] = "Faixa",
        ["album"] = "Álbum",
        ["Play Order: Default"] = "Ordem de reprodução: Padrão",
        ["Play Order: %s"] = "Ordem de reprodução: %s",
        ["sequential"] = "Sequencial",
        ["repeat_all"] = "Repetir tudo",
        ["repeat_one"] = "Repetir uma",
        ["shuffle"] = "Aleatório",
        ["Album: %s"] = "Álbum: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Delete Rule"] = "Excluir regra",
        ["Edit Album Rule"] = "Editar regra do álbum",
        ["None"] = "Nenhuma",
        ["Enabled"] = "Ativado",
        ["Active Session: %s"] = "Sessão ativa: %s",
        ["Add Rule for Current Album..."] = "Adicionar regra para o álbum atual...",
        ["No album currently playing"] = "Nenhum álbum tocando no momento",
        ["Add Rule Manually..."] = "Adicionar regra manualmente...",
        ["Artist Name"] = "Nome do artista",
        ["Album Name"] = "Nome do álbum",
        ["Persistence & ReplayGain Info"] = "Info sobre persistência e ReplayGain",
        ["Album Playback Rules"] = "Regras de reprodução por álbum",
    },
    ru = {
        ["Failed to encode configuration"] = "Не удалось закодировать конфигурацию",
        ["Failed to save settings to storage; changes are live for this session only"] = "Не удалось сохранить настройки; изменения действуют только в этом сеансе",
        ["Storage unavailable; changes are live for this session only"] = "Хранилище недоступно; изменения действуют только в этом сеансе",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Сведения о правилах воспроизведения для альбомов:\n\n• Сопоставление: Правила применяются по тегам текущего трека (Исполнитель + Альбом) независимо от типа очереди. Плагин не видит содержимое очереди и не может изменить ReplayGain задним числом для уже играющего первого трека.\n• Время применения ReplayGain: Изменение режима ReplayGain вступает в силу со следующего трека.\n• Сохранение: Системные настройки (без пауз, кроссфейд, ReplayGain, порядок воспроизведения) сохраняются в памяти плеера. Плагин меняет только нужные значения и возвращает исходные при выходе из альбома или отключении плагина.\n• Ручные изменения: Если вы вручную изменили настройку во время прослушивания альбома, плагин сохранит её.\n• Связь режима без пауз и кроссфейда: Отключение режима без пауз отключает кроссфейд; включение кроссфейда включает режим без пауз.",
        ["Album Rules Policy"] = "Правила работы с альбомами",
        ["Matches track tags; ReplayGain takes effect next track"] = "По тегам трека; ReplayGain применяется со следующего трека",
        ["Crossfade: Default"] = "Кроссфейд: По умолчанию",
        ["Crossfade: Enabled"] = "Кроссфейд: Включён",
        ["Crossfade: Disabled"] = "Кроссфейд: Отключён",
        ["Gapless: Default"] = "Без пауз: По умолчанию",
        ["Gapless: Enabled"] = "Без пауз: Включено",
        ["Gapless: Disabled"] = "Без пауз: Отключено",
        ["ReplayGain: Default"] = "ReplayGain: По умолчанию",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Выкл.",
        ["track"] = "Трек",
        ["album"] = "Альбом",
        ["Play Order: Default"] = "Порядок воспроизведения: По умолчанию",
        ["Play Order: %s"] = "Порядок воспроизведения: %s",
        ["sequential"] = "По порядку",
        ["repeat_all"] = "Повтор всех",
        ["repeat_one"] = "Повтор одного",
        ["shuffle"] = "Случайно",
        ["Album: %s"] = "Альбом: %s",
        ["Artist: %s"] = "Исполнитель: %s",
        ["Delete Rule"] = "Удалить правило",
        ["Edit Album Rule"] = "Изменить правило альбома",
        ["None"] = "Нет",
        ["Enabled"] = "Включено",
        ["Active Session: %s"] = "Активный сеанс: %s",
        ["Add Rule for Current Album..."] = "Добавить правило для текущего альбома...",
        ["No album currently playing"] = "Сейчас не играет ни один альбом",
        ["Add Rule Manually..."] = "Добавить правило вручную...",
        ["Artist Name"] = "Имя исполнителя",
        ["Album Name"] = "Название альбома",
        ["Persistence & ReplayGain Info"] = "О сохранении и ReplayGain",
        ["Album Playback Rules"] = "Правила воспроизведения альбомов",
    },
    uk = {
        ["Failed to encode configuration"] = "Не вдалося закодувати конфігурацію",
        ["Failed to save settings to storage; changes are live for this session only"] = "Не вдалося зберегти налаштування; зміни діють лише для цього сеансу",
        ["Storage unavailable; changes are live for this session only"] = "Сховище недоступне; зміни діють лише для цього сеансу",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Інформація про правила відтворення для альбомів:\n\n• Зіставлення: Правила застосовуються за тегами поточного треку (Виконавець + Альбом) незалежно від черги. Плагін не бачить вміст черги та не може заднім числом змінити ReplayGain для першого треку, що вже грає.\n• Час застосування ReplayGain: Зміни режиму ReplayGain набувають чинності з наступного треку.\n• Збереження: Системні налаштування (без пауз, кросфейд, ReplayGain, порядок відтворення) зберігаються в системі. Плагін змінює лише потрібні значення та відновлює початкові після виходу з альбому або вимкнення плагіна.\n• Ручні зміни: Якщо ви вручну змінили налаштування під час прослуховування альбому, плагін збереже його.\n• Зв'язок режиму без пауз і кросфейду: Вимкнення режиму без пауз вимикає кросфейд; увімкнення кросфейду вмикає режим без пауз.",
        ["Album Rules Policy"] = "Правила роботи з альбомами",
        ["Matches track tags; ReplayGain takes effect next track"] = "За тегами треку; ReplayGain діє з наступного треку",
        ["Crossfade: Default"] = "Кросфейд: За замовчуванням",
        ["Crossfade: Enabled"] = "Кросфейд: Увімкнено",
        ["Crossfade: Disabled"] = "Кросфейд: Вимкнено",
        ["Gapless: Default"] = "Без пауз: За замовчуванням",
        ["Gapless: Enabled"] = "Без пауз: Увімкнено",
        ["Gapless: Disabled"] = "Без пауз: Вимкнено",
        ["ReplayGain: Default"] = "ReplayGain: За замовчуванням",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Вимк.",
        ["track"] = "Трек",
        ["album"] = "Альбом",
        ["Play Order: Default"] = "Порядок відтворення: За замовчуванням",
        ["Play Order: %s"] = "Порядок відтворення: %s",
        ["sequential"] = "Послідовно",
        ["repeat_all"] = "Повтор усіх",
        ["repeat_one"] = "Повтор одного",
        ["shuffle"] = "Випадково",
        ["Album: %s"] = "Альбом: %s",
        ["Artist: %s"] = "Виконавець: %s",
        ["Delete Rule"] = "Видалити правило",
        ["Edit Album Rule"] = "Редагувати правило альбому",
        ["None"] = "Немає",
        ["Enabled"] = "Увімкнено",
        ["Active Session: %s"] = "Активний сеанс: %s",
        ["Add Rule for Current Album..."] = "Додати правило для поточного альбому...",
        ["No album currently playing"] = "Зараз не відтворюється жоден альбом",
        ["Add Rule Manually..."] = "Додати правило вручну...",
        ["Artist Name"] = "Ім'я виконавця",
        ["Album Name"] = "Назва альбому",
        ["Persistence & ReplayGain Info"] = "Про збереження та ReplayGain",
        ["Album Playback Rules"] = "Правила відтворення альбомів",
    },
    vi = {
        ["Failed to encode configuration"] = "Không thể mã hóa cấu hình",
        ["Failed to save settings to storage; changes are live for this session only"] = "Không thể lưu cài đặt; thay đổi chỉ có hiệu lực trong phiên này",
        ["Storage unavailable; changes are live for this session only"] = "Bộ nhớ không khả dụng; thay đổi chỉ có hiệu lực trong phiên này",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "Thông tin quy tắc phát theo album:\n\n• Phạm vi & khớp thẻ: Quy tắc khớp với thẻ bài hát đang phát (Nghệ sĩ + Album) bất kể loại hàng đợi. Plugin không thể biết hàng đợi gồm cả album hay chỉ một bài, cũng không thể đổi ReplayGain hồi tố cho bài đầu tiên đang phát.\n• Thời điểm ReplayGain: Thay đổi chế độ ReplayGain có hiệu lực khi chuyển sang bài tiếp theo.\n• Lưu trữ: Các cài đặt gốc (phát liền mạch, chuyển mượt, ReplayGain, thứ tự phát) được lưu vào hệ thống. Plugin chỉ áp dụng giá trị thay đổi và khôi phục giá trị ban đầu khi rời album hoặc tắt plugin.\n• Thay đổi thủ công: Nếu bạn tự chỉnh cài đặt khi đang nghe album, plugin sẽ giữ nguyên thay đổi đó khi thoát album.\n• Liên kết phát liền mạch & chuyển mượt: Tắt phát liền mạch sẽ tắt chuyển mượt; bật chuyển mượt sẽ bật phát liền mạch.",
        ["Album Rules Policy"] = "Chính sách quy tắc album",
        ["Matches track tags; ReplayGain takes effect next track"] = "Khớp thẻ bài hát; ReplayGain có hiệu lực ở bài tiếp theo",
        ["Crossfade: Default"] = "Chuyển mượt: Mặc định",
        ["Crossfade: Enabled"] = "Chuyển mượt: Đã bật",
        ["Crossfade: Disabled"] = "Chuyển mượt: Đã tắt",
        ["Gapless: Default"] = "Phát liền mạch: Mặc định",
        ["Gapless: Enabled"] = "Phát liền mạch: Đã bật",
        ["Gapless: Disabled"] = "Phát liền mạch: Đã tắt",
        ["ReplayGain: Default"] = "ReplayGain: Mặc định",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "Tắt",
        ["track"] = "Bài hát",
        ["album"] = "Album",
        ["Play Order: Default"] = "Thứ tự phát: Mặc định",
        ["Play Order: %s"] = "Thứ tự phát: %s",
        ["sequential"] = "Tuần tự",
        ["repeat_all"] = "Lặp tất cả",
        ["repeat_one"] = "Lặp một bài",
        ["shuffle"] = "Trộn bài",
        ["Album: %s"] = "Album: %s",
        ["Artist: %s"] = "Nghệ sĩ: %s",
        ["Delete Rule"] = "Xóa quy tắc",
        ["Edit Album Rule"] = "Sửa quy tắc album",
        ["None"] = "Không có",
        ["Enabled"] = "Đã bật",
        ["Active Session: %s"] = "Phiên đang hoạt động: %s",
        ["Add Rule for Current Album..."] = "Thêm quy tắc cho album hiện tại...",
        ["No album currently playing"] = "Không có album nào đang phát",
        ["Add Rule Manually..."] = "Thêm quy tắc thủ công...",
        ["Artist Name"] = "Tên nghệ sĩ",
        ["Album Name"] = "Tên album",
        ["Persistence & ReplayGain Info"] = "Thông tin lưu trữ & ReplayGain",
        ["Album Playback Rules"] = "Quy tắc phát theo album",
    },
    zh_CN = {
        ["Failed to encode configuration"] = "编码配置失败",
        ["Failed to save settings to storage; changes are live for this session only"] = "保存设置失败；更改仅在本次会话中生效",
        ["Storage unavailable; changes are live for this session only"] = "存储不可用；更改仅在本次会话中生效",
        ["Per-Album Playback Rules Information:\n\n• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state."] = "按专辑播放规则说明：\n\n• 范围与匹配：规则根据当前播放曲目的标签（艺人 + 专辑）匹配，与队列类型无关。插件无法检测队列中是整张专辑还是单首曲目，也无法对正在播放的第一首曲目追溯更改 ReplayGain。\n• ReplayGain 生效时间：ReplayGain 模式更改将在切换到下一首曲目时生效。\n• 持久性：原生设置（无缝播放、淡入淡出、ReplayGain、播放顺序）保存在系统设置中。插件仅应用更改的值，并在离开专辑会话或禁用插件时恢复初始值。\n• 手动覆盖：如果在播放专辑时手动调整了某项设置，离开专辑时将保留你的手动调整。\n• 无缝播放与淡入淡出联动：关闭无缝播放会同时关闭淡入淡出；开启淡入淡出会同时开启无缝播放。",
        ["Album Rules Policy"] = "专辑规则说明",
        ["Matches track tags; ReplayGain takes effect next track"] = "匹配曲目标签；ReplayGain 在下一首生效",
        ["Crossfade: Default"] = "淡入淡出: 默认",
        ["Crossfade: Enabled"] = "淡入淡出: 已启用",
        ["Crossfade: Disabled"] = "淡入淡出: 已禁用",
        ["Gapless: Default"] = "无缝播放: 默认",
        ["Gapless: Enabled"] = "无缝播放: 已启用",
        ["Gapless: Disabled"] = "无缝播放: 已禁用",
        ["ReplayGain: Default"] = "ReplayGain: 默认",
        ["ReplayGain: %s"] = "ReplayGain: %s",
        ["off"] = "关闭",
        ["track"] = "曲目",
        ["album"] = "专辑",
        ["Play Order: Default"] = "播放顺序: 默认",
        ["Play Order: %s"] = "播放顺序: %s",
        ["sequential"] = "顺序播放",
        ["repeat_all"] = "列表循环",
        ["repeat_one"] = "单曲循环",
        ["shuffle"] = "随机播放",
        ["Album: %s"] = "专辑: %s",
        ["Artist: %s"] = "艺人: %s",
        ["Delete Rule"] = "删除规则",
        ["Edit Album Rule"] = "编辑专辑规则",
        ["None"] = "无",
        ["Enabled"] = "已启用",
        ["Active Session: %s"] = "当前会话: %s",
        ["Add Rule for Current Album..."] = "为当前专辑添加规则...",
        ["No album currently playing"] = "当前没有正在播放的专辑",
        ["Add Rule Manually..."] = "手动添加规则...",
        ["Artist Name"] = "艺人名称",
        ["Album Name"] = "专辑名称",
        ["Persistence & ReplayGain Info"] = "持久性与 ReplayGain 说明",
        ["Album Playback Rules"] = "专辑播放规则",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

-- Per-Album Playback Rules:
-- Customizes playback settings (gapless, crossfade, ReplayGain, play order) per album.
-- Identifies albums by Artist + Album compound key to handle album name collisions.
-- Matches currently playing track metadata tags (Artist + Album) regardless of queue type.
-- Player API provides no queue introspection: plugin cannot detect full-album queues vs
-- single-track queues, and cannot retroactively change ReplayGain for the first track.
-- ReplayGain mode changes take effect on the next track transition.
-- Snapshots native playback settings when an album session begins.
-- Applies edited rules to active sessions in-flight while preserving original baseline.
-- Transitions to Default restore the original owned baseline value immediately.
-- Applies ONLY changed values (apply_changed_only) because native setters persist.
-- Handles bidirectional coupling between gapless and crossfade:
--   - set_gapless(false) clears crossfade
--   - set_crossfade(true) enables gapless
-- Records actual post-apply changed pair and restores coupled pair ONLY when both
-- current values still match the owned pair, preserving manual user overrides to either field.
-- Discloses that native settings persist in firmware preferences (not transient).

local CONFIG_PATH = plugin.sd_root() .. "/.plugins/album_playback_rules_config.json"
local MAX_UI_ROWS = 500

local config = {
    enabled = false,
    rules = {} -- map of [lower_artist .. "\t" .. lower_album] = rule_table
}

local active_session = nil

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

local function make_album_key(artist, album)
    if not artist or not album then return nil end
    local a = artist:gsub("^%s+", ""):gsub("%s+$", ""):lower()
    local b = album:gsub("^%s+", ""):gsub("%s+$", ""):lower()
    if a == "" or b == "" then return nil end
    return a .. "\t" .. b
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
    if type(data.rules) == "table" then
        config.rules = {}
        local count = 0
        for k, v in pairs(data.rules) do
            if count >= MAX_UI_ROWS then break end
            if type(v) == "table" and type(v.artist) == "string" and #v.artist > 0 and #v.artist <= 256
               and type(v.album) == "string" and #v.album > 0 and #v.album <= 256 then
                local rule_key = make_album_key(v.artist, v.album)
                if rule_key then
                    local cf = nil
                    if type(v.crossfade) == "boolean" then cf = v.crossfade end
                    local gl = nil
                    if type(v.gapless) == "boolean" then gl = v.gapless end

                    -- Normalize contradictory rule: gapless=false and crossfade=true cannot coexist natively
                    if gl == false and cf == true then
                        cf = false
                    end

                    local rg = nil
                    if v.replaygain == "off" or v.replaygain == "track" or v.replaygain == "album" then
                        rg = v.replaygain
                    end

                    local pm = nil
                    if v.play_mode == "sequential" or v.play_mode == "repeat_all"
                       or v.play_mode == "repeat_one" or v.play_mode == "shuffle" then
                        pm = v.play_mode
                    end

                    config.rules[rule_key] = {
                        artist = v.artist,
                        album = v.album,
                        crossfade = cf,
                        gapless = gl,
                        replaygain = rg,
                        play_mode = pm,
                    }
                    count = count + 1
                end
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

local function get_current_track_identity()
    local path = plugin.get_current_track_path and plugin.get_current_track_path()
    local artist, album = nil, nil
    if path and plugin.has_capability and plugin.has_capability("library.track_metadata") and plugin.get_track_metadata then
        local meta = plugin.get_track_metadata(path)
        if meta then
            if meta.album_artist and meta.album_artist ~= "" then
                artist = meta.album_artist
            elseif meta.artist and meta.artist ~= "" then
                artist = meta.artist
            end
            if meta.album and meta.album ~= "" then
                album = meta.album
            end
        end
    end

    if (not artist or artist == "" or not album or album == "") and plugin.get_now_playing then
        local _, np_artist, np_album = plugin.get_now_playing()
        if not artist or artist == "" then artist = np_artist end
        if not album or album == "" then album = np_album end
    end

    if artist and artist ~= "" and album and album ~= "" then
        return artist, album
    end
    return nil, nil
end

local function restore_session(session)
    if not session or not session.applied then return end

    -- 1. Restore play_mode if owned
    if session.applied.play_mode ~= nil and plugin.get_play_mode and plugin.set_play_mode then
        local cur = plugin.get_play_mode()
        if cur == session.applied.play_mode then
            if session.baseline.play_mode ~= nil and session.baseline.play_mode ~= cur then
                plugin.set_play_mode(session.baseline.play_mode)
            end
        end
    end

    -- 2. Restore replaygain if owned
    if session.applied.replaygain ~= nil and plugin.get_replaygain_mode and plugin.set_replaygain_mode then
        local cur = plugin.get_replaygain_mode()
        if cur == session.applied.replaygain then
            if session.baseline.replaygain ~= nil and session.baseline.replaygain ~= cur then
                plugin.set_replaygain_mode(session.baseline.replaygain)
            end
        end
    end

    -- 3. Restore coupled gapless and crossfade pair
    local can_settings = plugin.has_capability and plugin.has_capability("playback.settings")
    if can_settings and session.applied.coupled_pair and plugin.get_gapless and plugin.set_gapless and plugin.get_crossfade and plugin.set_crossfade then
        local cur_gapless = plugin.get_gapless()
        local cur_crossfade = plugin.get_crossfade()

        -- Restore coupled pair ONLY when BOTH current values still match the owned pair!
        -- If user manually modified either field, do NOT clobber the user's manual override.
        if cur_gapless == session.applied.gapless and cur_crossfade == session.applied.crossfade then
            -- Restore in proper order respecting bidirectional coupling:
            if session.baseline.gapless == false then
                -- Disabling gapless also clears crossfade natively
                plugin.set_gapless(false)
            elseif session.baseline.crossfade == true then
                -- Enabling crossfade also enables gapless natively
                plugin.set_crossfade(true)
            else
                -- baseline is gapless=true and crossfade=false:
                plugin.set_crossfade(false)
                plugin.set_gapless(true)
            end
        end
    end
end

local function apply_rule_to_session(session, rule)
    local can_settings = plugin.has_capability and plugin.has_capability("playback.settings")
    local baseline = session.baseline
    local applied = session.applied

    -- 1. Play mode
    if plugin.get_play_mode and plugin.set_play_mode then
        local target_pm = rule.play_mode
        if target_pm == nil then
            -- Transition to Default: restore original baseline value immediately if still owned
            if applied.play_mode ~= nil then
                local cur_pm = plugin.get_play_mode()
                if cur_pm == applied.play_mode then
                    if baseline.play_mode ~= nil and baseline.play_mode ~= cur_pm then
                        plugin.set_play_mode(baseline.play_mode)
                    end
                end
                applied.play_mode = nil
            end
        else
            -- Explicit play mode target
            -- If already applied this target, rule didn't change play_mode:
            -- avoid flash writes and do not override manual user changes!
            if applied.play_mode ~= target_pm then
                local cur_pm = plugin.get_play_mode()
                if cur_pm ~= target_pm then
                    plugin.set_play_mode(target_pm)
                end
                applied.play_mode = target_pm
            end
        end
    end

    -- 2. ReplayGain (takes effect on next track transition)
    if can_settings and plugin.get_replaygain_mode and plugin.set_replaygain_mode then
        local target_rg = rule.replaygain
        if target_rg == nil then
            -- Transition to Default: restore original baseline value immediately if still owned
            if applied.replaygain ~= nil then
                local cur_rg = plugin.get_replaygain_mode()
                if cur_rg == applied.replaygain then
                    if baseline.replaygain ~= nil and baseline.replaygain ~= cur_rg then
                        plugin.set_replaygain_mode(baseline.replaygain)
                    end
                end
                applied.replaygain = nil
            end
        else
            -- Explicit ReplayGain target
            if applied.replaygain ~= target_rg then
                local cur_rg = plugin.get_replaygain_mode()
                if cur_rg ~= target_rg then
                    plugin.set_replaygain_mode(target_rg)
                end
                applied.replaygain = target_rg
            end
        end
    end

    -- 3. Gapless and Crossfade (coupled pair)
    if can_settings and plugin.get_gapless and plugin.set_gapless and plugin.get_crossfade and plugin.set_crossfade then
        local rule_gl = rule.gapless
        local rule_cf = rule.crossfade
        -- Normalize contradictory rule: gapless=false and crossfade=true cannot coexist natively
        if rule_gl == false and rule_cf == true then
            rule_cf = false
        end

        local rule_gl_changed = (applied.rule_gapless ~= rule_gl)
        local rule_cf_changed = (applied.rule_crossfade ~= rule_cf)

        if rule_gl_changed or rule_cf_changed then
            if rule_gl == nil and rule_cf == nil then
                -- Both transitioned to Default: restore original baseline values immediately if still owned
                if applied.coupled_pair then
                    local cur_gl = plugin.get_gapless()
                    local cur_cf = plugin.get_crossfade()
                    if cur_gl == applied.gapless and cur_cf == applied.crossfade then
                        if baseline.gapless == false then
                            if cur_gl ~= false then plugin.set_gapless(false) end
                        elseif baseline.crossfade == true then
                            if cur_cf ~= true then plugin.set_crossfade(true) end
                        else
                            if cur_cf ~= false then plugin.set_crossfade(false) end
                            if plugin.get_gapless() ~= true then plugin.set_gapless(true) end
                        end
                    end
                    applied.coupled_pair = nil
                    applied.gapless = nil
                    applied.crossfade = nil
                end
                applied.rule_gapless = nil
                applied.rule_crossfade = nil
            else
                local cur_gl = plugin.get_gapless()
                local cur_cf = plugin.get_crossfade()

                -- Target values: if a field is nil, target is its original baseline value
                local target_gl = baseline.gapless
                if rule_gl ~= nil then target_gl = rule_gl end
                local target_cf = baseline.crossfade
                if rule_cf ~= nil then target_cf = rule_cf end
                if target_gl == false and target_cf == true then
                    target_cf = false
                end

                -- Apply in proper order respecting firmware bidirectional coupling,
                -- avoiding flash writes if already matching target
                if target_gl == false then
                    if cur_gl ~= false then
                        plugin.set_gapless(false)
                    end
                elseif target_cf == true then
                    if cur_cf ~= true then
                        plugin.set_crossfade(true)
                    end
                else
                    -- target_gl == true and target_cf == false
                    if cur_cf ~= false then
                        plugin.set_crossfade(false)
                    end
                    if plugin.get_gapless() ~= true then
                        plugin.set_gapless(true)
                    end
                end

                local post_gl = plugin.get_gapless()
                local post_cf = plugin.get_crossfade()
                applied.gapless = post_gl
                applied.crossfade = post_cf
                applied.rule_gapless = rule_gl
                applied.rule_crossfade = rule_cf

                if post_gl ~= baseline.gapless or post_cf ~= baseline.crossfade then
                    applied.coupled_pair = true
                else
                    applied.coupled_pair = nil
                end
            end
        end
    end
end

local function start_new_session(rule, artist, album, key)
    local can_settings = plugin.has_capability and plugin.has_capability("playback.settings")
    local baseline = {
        gapless = nil,
        crossfade = nil,
        replaygain = nil,
        play_mode = nil,
    }
    if can_settings and plugin.get_gapless then
        baseline.gapless = plugin.get_gapless()
    end
    if can_settings and plugin.get_crossfade then
        baseline.crossfade = plugin.get_crossfade()
    end
    if can_settings and plugin.get_replaygain_mode then
        baseline.replaygain = plugin.get_replaygain_mode()
    end
    if plugin.get_play_mode then
        baseline.play_mode = plugin.get_play_mode()
    end

    local session = {
        artist = artist,
        album = album,
        key = key,
        baseline = baseline,
        applied = {},
    }
    active_session = session
    apply_rule_to_session(session, rule)
end

local function evaluate_playback()
    if not config.enabled then return end

    local artist, album = get_current_track_identity()
    if not artist or not album then
        if active_session then
            restore_session(active_session)
            active_session = nil
        end
        return
    end

    local key = make_album_key(artist, album)

    -- If left previous album session for a different album, restore it
    if active_session and active_session.key ~= key then
        restore_session(active_session)
        active_session = nil
    end

    local rule = config.rules[key]
    if not rule then
        -- No rule configured for this album
        if active_session then
            restore_session(active_session)
            active_session = nil
        end
        return
    end

    if active_session and active_session.key == key then
        -- Same album session: apply any in-flight rule edits to active session
        -- (preserves ORIGINAL baseline across edits, applies changed only)
        apply_rule_to_session(active_session, rule)
    else
        -- Start new album session: capture initial baseline and apply rule
        start_new_session(rule, artist, album, key)
    end
end

-- UI
local open_main_settings
local open_edit_rule

local function show_precedence_and_replaygain_info()
    local text = tr("Per-Album Playback Rules Information:\n\n"
        .. "• Scope & Queue Matching: Rules match currently playing track tags (Artist + Album) regardless of queue type. The player API provides no queue introspection, so the plugin cannot detect whether a full album or an individual track is queued, nor can it retroactively change ReplayGain for the currently playing first track.\n"
        .. "• ReplayGain Timing: ReplayGain mode changes take effect on the next track transition.\n"
        .. "• Persistence: Native settings (gapless, crossfade, ReplayGain, play order) persist in system settings and are not transient. The plugin applies only changed values and restores baseline values when you leave the album session or disable the plugin.\n"
        .. "• Manual Overrides: If you manually adjust a setting while playing an album, the plugin respects your override and does not clobber it on album exit.\n"
        .. "• Gapless & Crossfade Coupling: Disabling gapless clears crossfade; enabling crossfade enables gapless. Contradictory settings are normalized to maintain valid player state.")
    if plugin.show_text_view then
        plugin.show_text_view(tr("Album Rules Policy"), text)
    elseif plugin.show_toast then
        plugin.show_toast(tr("Matches track tags; ReplayGain takes effect next track"))
    end
end

open_edit_rule = function(key)
    local rule = config.rules[key]
    if not rule then return end

    local function cf_label()
        if rule.crossfade == nil then return tr("Crossfade: Default")
        elseif rule.crossfade then return tr("Crossfade: Enabled")
        else return tr("Crossfade: Disabled") end
    end

    local function gapless_label()
        if rule.gapless == nil then return tr("Gapless: Default")
        elseif rule.gapless then return tr("Gapless: Enabled")
        else return tr("Gapless: Disabled") end
    end

    local function rg_label()
        if rule.replaygain == nil then return tr("ReplayGain: Default")
        else return string.format(tr("ReplayGain: %s"), tr(rule.replaygain)) end
    end

    local function pm_label()
        if rule.play_mode == nil then return tr("Play Order: Default")
        else return string.format(tr("Play Order: %s"), tr(rule.play_mode)) end
    end

    local rows = {
        {
            type = "row",
            label = string.format(tr("Album: %s"), rule.album),
            on_select = function() end
        },
        {
            type = "row",
            label = string.format(tr("Artist: %s"), rule.artist),
            on_select = function() end
        },
        {
            type = "row",
            label = cf_label(),
            on_select = function()
                if rule.crossfade == nil then
                    rule.crossfade = true
                    rule.gapless = true -- crossfade=true requires gapless=true natively
                elseif rule.crossfade == true then
                    rule.crossfade = false
                else
                    rule.crossfade = nil
                end
                save_config()
                if config.enabled and active_session and active_session.key == key then
                    evaluate_playback()
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = gapless_label(),
            on_select = function()
                if rule.gapless == nil then
                    rule.gapless = true
                elseif rule.gapless == true then
                    rule.gapless = false
                    rule.crossfade = false -- gapless=false forces crossfade=false natively
                else
                    rule.gapless = nil
                end
                save_config()
                if config.enabled and active_session and active_session.key == key then
                    evaluate_playback()
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = rg_label(),
            on_select = function()
                local modes = { "off", "track", "album" }
                local cur_idx = 0
                for i, m in ipairs(modes) do
                    if rule.replaygain == m then cur_idx = i break end
                end
                if cur_idx == 0 then rule.replaygain = "album"
                elseif cur_idx == 3 then rule.replaygain = "track"
                elseif cur_idx == 2 then rule.replaygain = "off"
                else rule.replaygain = nil end
                save_config()
                if config.enabled and active_session and active_session.key == key then
                    evaluate_playback()
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = pm_label(),
            on_select = function()
                local modes = { "sequential", "repeat_all", "repeat_one", "shuffle" }
                local cur_idx = 0
                for i, m in ipairs(modes) do
                    if rule.play_mode == m then cur_idx = i break end
                end
                if cur_idx == 0 then rule.play_mode = "sequential"
                elseif cur_idx == 1 then rule.play_mode = "repeat_all"
                elseif cur_idx == 2 then rule.play_mode = "repeat_one"
                elseif cur_idx == 3 then rule.play_mode = "shuffle"
                else rule.play_mode = nil end
                save_config()
                if config.enabled and active_session and active_session.key == key then
                    evaluate_playback()
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = tr("Delete Rule"),
            on_select = function()
                config.rules[key] = nil
                save_config()
                if active_session and active_session.key == key then
                    restore_session(active_session)
                    active_session = nil
                end
                open_main_settings()
            end
        }
    }
    plugin.show_settings_list(tr("Edit Album Rule"), rows, { update = true })
end

open_main_settings = function()
    local rule_count = 0
    for _ in pairs(config.rules) do rule_count = rule_count + 1 end

    local current_desc = tr("None")
    if active_session and active_session.artist and active_session.album then
        current_desc = active_session.artist .. " — " .. active_session.album
    end

    local rows = {
        {
            type = "toggle",
            label = tr("Enabled"),
            value = config.enabled,
            on_change = function(new_val)
                config.enabled = new_val
                save_config()
                if new_val then
                    evaluate_playback()
                else
                    if active_session then
                        restore_session(active_session)
                        active_session = nil
                    end
                end
                open_main_settings()
            end
        },
        {
            type = "row",
            label = string.format(tr("Active Session: %s"), current_desc),
            on_select = function() end
        },
        {
            type = "row",
            label = tr("Add Rule for Current Album..."),
            on_select = function()
                local artist, album = get_current_track_identity()
                if not artist or not album then
                    if plugin.show_toast then plugin.show_toast(tr("No album currently playing")) end
                    return
                end
                local key = make_album_key(artist, album)
                if not config.rules[key] then
                    config.rules[key] = {
                        artist = artist,
                        album = album,
                        gapless = true,
                        crossfade = false,
                        replaygain = "album",
                        play_mode = "sequential",
                    }
                    save_config()
                    if config.enabled then evaluate_playback() end
                end
                open_edit_rule(key)
            end
        },
        {
            type = "row",
            label = tr("Add Rule Manually..."),
            on_select = function()
                plugin.show_text_input(tr("Artist Name"), "", false, function(artist_name)
                    if not artist_name or artist_name:gsub("%s+", "") == "" then return end
                    plugin.show_text_input(tr("Album Name"), "", false, function(album_name)
                        if not album_name or album_name:gsub("%s+", "") == "" then return end
                        local key = make_album_key(artist_name, album_name)
                        if key then
                            if not config.rules[key] then
                                config.rules[key] = {
                                    artist = artist_name,
                                    album = album_name,
                                    gapless = true,
                                    crossfade = false,
                                    replaygain = "album",
                                    play_mode = "sequential",
                                }
                                save_config()
                                if config.enabled then evaluate_playback() end
                            end
                            open_edit_rule(key)
                        end
                    end)
                end)
            end
        },
        {
            type = "row",
            label = tr("Persistence & ReplayGain Info"),
            on_select = show_precedence_and_replaygain_info
        }
    }

    local rule_keys = {}
    for k in pairs(config.rules) do rule_keys[#rule_keys + 1] = k end
    table.sort(rule_keys)
    local limit = math.min(#rule_keys, MAX_UI_ROWS - #rows)
    for i = 1, limit do
        local rk = rule_keys[i]
        local r = config.rules[rk]
        rows[#rows + 1] = {
            type = "row",
            label = r.artist .. " — " .. r.album,
            on_select = function()
                open_edit_rule(rk)
            end
        }
    end

    plugin.show_settings_list(tr("Album Playback Rules"), rows, { update = true })
end

-- Initialize
load_config()
plugin.register_list_item("playback", tr("Album Playback Rules"), open_main_settings)

plugin.on("track_started", function()
    evaluate_playback()
end)

plugin.on("stopped", function()
    if active_session then
        restore_session(active_session)
        active_session = nil
    end
end)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        config = config,
        load_config = load_config,
        save_config = save_config,
        make_album_key = make_album_key,
        get_current_track_identity = get_current_track_identity,
        evaluate_playback = evaluate_playback,
        restore_session = restore_session,
        apply_album_rules = start_new_session,
        apply_rule_to_session = apply_rule_to_session,
        start_new_session = start_new_session,
        open_main_settings = open_main_settings,
        open_edit_rule = open_edit_rule,
        get_active_session = function() return active_session end,
        set_active_session = function(s) active_session = s end,
    }
end
