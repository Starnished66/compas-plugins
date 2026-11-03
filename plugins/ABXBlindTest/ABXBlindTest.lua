plugin.define({
    id = "example.abx_blind_test",
    name = "ABX Blind Test",
    version = "1.2.0",
    api_min = 19,
})

local T = {
    de = {
        ["ABX Blind Test"] = "ABX-Blindtest",
        ["Baseline EQ"] = "Basis-EQ",
        ["Profile B"] = "Profil B",
        ["Current Snapshot"] = "Aktueller Stand",
        ["Path must be a non-empty string"] = "Pfad darf nicht leer sein",
        ["Network URLs are not supported for local comparison"] = "Netzwerk-URLs werden für lokalen Vergleich nicht unterstützt",
        ["Path traversal ('..') is not permitted"] = "Pfadwechsel ('..') ist nicht erlaubt",
        ["Path must be located inside the SD card (%s)"] = "Pfad muss auf der SD-Karte liegen (%s)",
        ["playback paused or stopped"] = "Wiedergabe pausiert oder gestoppt",
        ["native switch not ready"] = "Nativer Umschalter nicht bereit",
        ["playback format unavailable"] = "Wiedergabeformat nicht verfügbar",
        ["track restarted or changed"] = "Titel neu gestartet oder gewechselt",
        ["track path changed"] = "Titelpfad geändert",
        ["playback speed must be 1.0x (currently %s)"] = "Geschwindigkeit muss 1.0x sein (aktuell %s)",
        ["unknown"] = "unbekannt",
        ["crossfade enabled"] = "Überblenden aktiviert",
        ["stream/dsd source"] = "Stream-/DSD-Quelle",
        ["track duration not positive and finite"] = "Titeldauer nicht positiv und endlich",
        ["streaming audio not supported"] = "Streaming-Audio nicht unterstützt",
        ["track duration not finite or positive"] = "Titeldauer nicht endlich oder positiv",
        ["track playback generation changed"] = "Wiedergabegeneration geändert",
        ["Player lacks playback.ab_switch capability"] = "Player unterstützt playback.ab_switch nicht",
        ["Primary track must be currently playing"] = "Haupttitel muss gerade abgespielt werden",
        ["Playback format query unavailable"] = "Wiedergabeformat-Abfrage nicht verfügbar",
        ["No active audio format"] = "Kein aktives Audioformat",
        ["Stream playback cannot be used for comparison"] = "Streams können nicht für Vergleiche genutzt werden",
        ["DSD tracks cannot be used for AB switch"] = "DSD-Titel können nicht für den AB-Umschalter genutzt werden",
        ["Playback speed must be 1.0x"] = "Wiedergabegeschwindigkeit muss 1.0x sein",
        ["Crossfade must be disabled in Sound settings"] = "Überblenden muss in den Toneinstellungen deaktiviert sein",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Codec (%s, %d-Bit) nicht unterstützt: erfordert 16-Bit FLAC/PCM oder MP3",
        ["Comparison preparation cancelled"] = "Vergleichsvorbereitung abgebrochen",
        ["Alternate track ready for ABX test!"] = "Alternativer Titel bereit für ABX-Test!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Vorbereitung abgelehnt: Abtastrate, Kanäle oder Frame-Anzahl stimmen nicht überein",
        ["Preparation timed out (5m)"] = "Zeitüberschreitung bei der Vorbereitung (5 Min.)",
        ["Timer slot limit reached; cannot poll preparation"] = "Timer-Limit erreicht; Vorbereitung kann nicht abgefragt werden",
        ["Invalid Track B: %s"] = "Ungültiger Titel B: %s",
        ["No active track path found"] = "Kein aktiver Titelpfad gefunden",
        ["Player lacks prepare_ab_switch API"] = "Player unterstützt prepare_ab_switch nicht",
        ["Audio engine rejected comparison preparation"] = "Audio-Engine hat Vergleichsvorbereitung abgelehnt",
        ["Preparing alternate file..."] = "Alternative Datei wird vorbereitet...",
        ["Readiness lost (%s); ABX session ended."] = "Bereitschaft verloren (%s); ABX-Sitzung beendet.",
        ["Native switch selection failed; ABX session ended."] = "Umschalten fehlgeschlagen; ABX-Sitzung beendet.",
        ["Playback invalid (%s); ABX session ended."] = "Wiedergabe ungültig (%s); ABX-Sitzung beendet.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Externe EQ-Änderung erkannt; Durchgang beendet, um deine Einstellungen zu schützen.",
        ["Invalid session mode; ABX session ended."] = "Ungültiger Sitzungsmodus; ABX-Sitzung beendet.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Bereitschaft vor Abstimmung verloren (%s); ABX-Sitzung beendet.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Wiedergabe vor Abstimmung ungültig (%s); ABX-Sitzung beendet.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Externe EQ-Änderung vor Abstimmung erkannt; Durchgang beendet, um deine Einstellungen zu schützen.",
        ["Invalid mode before vote; ABX session ended."] = "Ungültiger Modus vor Abstimmung; ABX-Sitzung beendet.",
        ["Audition failed for next trial; session ended."] = "Hörprobe für nächsten Durchgang fehlgeschlagen; Sitzung beendet.",
        ["Vote recorded. Starting Trial %d of %d"] = "Stimme gezählt. Starte Durchgang %d von %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Test abgeschlossen! Ergebnis: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Wiedergabe nicht bereit (%s); ABX-Sitzung beendet.",
        ["Profile B not loaded; cannot restart EQ test."] = "Profil B nicht geladen; EQ-Test kann nicht neu gestartet werden.",
        ["No test mode configured; cannot restart."] = "Kein Testmodus konfiguriert; Neustart nicht möglich.",
        ["Audition failed on restart; session ended."] = "Hörprobe beim Neustart fehlgeschlagen; Sitzung beendet.",
        ["ABX Session restarted"] = "ABX-Sitzung neu gestartet",
        ["Parent folder"] = "Übergeordneter Ordner",
        ["No matching files here (%s)"] = "Keine passenden Dateien hier (%s)",
        ["Select File"] = "Datei auswählen",
        ["Audio File ABX Test..."] = "Audiodatei-ABX-Test...",
        ["Equalizer Profile ABX Test..."] = "EQ-Profil-ABX-Test...",
        ["Trials Per Session: %d"] = "Durchgänge pro Sitzung: %d",
        ["Trials set to %d"] = "Durchgänge auf %d gesetzt",
        ["About ABX Blind Test"] = "Über ABX-Blindtest",
        ["Blind ABX listener evaluation tool with randomized X."] = "ABX-Blindtest-Werkzeug mit zufälligem X.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "In jedem Durchgang wird Probe X zufällig Quelle A oder B zugewiesen.",
        ["Audition A, B, and X, then select your vote."] = "Höre A, B und X an und gib dann deine Stimme ab.",
        ["File mode uses native gapless switching with shared DSP."] = "Der Dateimodus nutzt unterbrechungsfreies Umschalten mit gemeinsamem DSP.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Unterstützt 16-Bit-FLAC/PCM und passende lokale MP3-Dateien.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "Beim Umschalten von EQ-Profilen ist ein klickfreier Wechsel nicht garantiert.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Berechnet nach Abschluss die exakte Binomialwahrscheinlichkeit (p-Wert).",
        ["(None Playing)"] = "(Keine Wiedergabe)",
        ["(Not Selected)"] = "(Nicht ausgewählt)",
        ["Status: Idle"] = "Status: Bereit",
        ["Status: Preparing... (Tap to Cancel)"] = "Status: Vorbereitung... (Tippen zum Abbrechen)",
        ["Status: Ready (Matched)"] = "Status: Bereit (Abgeglichen)",
        ["Main menu"] = "Hauptmenü",
        ["Track A: %s"] = "Titel A: %s",
        ["None"] = "Keine",
        ["Track B: %s"] = "Titel B: %s",
        ["Selected: %s"] = "Ausgewählt: %s",
        ["Select Track B (File Browser)..."] = "Titel B wählen (Dateibrowser)...",
        ["Enter Track B Path (Text)..."] = "Pfad für Titel B eingeben (Text)...",
        ["Enter Track B Path"] = "Pfad für Titel B eingeben",
        ["Invalid path: %s"] = "Ungültiger Pfad: %s",
        ["Prepare Comparison"] = "Vergleich vorbereiten",
        ["Cancel Preparation"] = "Vorbereitung abbrechen",
        ["Start ABX File Test"] = "ABX-Dateitest starten",
        ["Track B is not ready yet"] = "Titel B ist noch nicht bereit",
        ["Not ready: %s"] = "Nicht bereit: %s",
        ["Audition failed on start"] = "Hörprobe beim Start fehlgeschlagen",
        ["Clear Comparison"] = "Vergleich zurücksetzen",
        ["Comparison cleared"] = "Vergleich zurückgesetzt",
        ["Notice: PEQ updates are not click-free"] = "Hinweis: PEQ-Wechsel sind nicht klickfrei",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "PEQ-Koeffizientenwechsel können kein klickfreies Umschalten garantieren.",
        ["Profile A: %s"] = "Profil A: %s",
        ["Profile B: %s"] = "Profil B: %s",
        ["Use Current EQ as Profile A"] = "Aktuellen EQ als Profil A nutzen",
        ["Captured Current EQ as Profile A"] = "Aktueller EQ als Profil A gespeichert",
        ["Load .peq for Profile B..."] = ".peq für Profil B laden...",
        ["Invalid Profile Path: %s"] = "Ungültiger Profilpfad: %s",
        ["Loaded %s transiently"] = "%s temporär geladen",
        ["Failed to load .peq profile"] = ".peq-Profil konnte nicht geladen werden",
        ["Start ABX EQ Test"] = "ABX-EQ-Test starten",
        ["Player lacks audio.peq.state capability"] = "Player unterstützt audio.peq.state nicht",
        ["EQ state query unavailable"] = "EQ-Statusabfrage nicht verfügbar",
        ["Playback not ready: %s"] = "Wiedergabe nicht bereit: %s",
        ["Could not read baseline EQ"] = "Basis-EQ konnte nicht gelesen werden",
        ["Please load Profile B first"] = "Bitte zuerst Profil B laden",
        ["About EQ Comparisons"] = "Über EQ-Vergleiche",
        ["About EQ ABX Test"] = "Über den EQ-ABX-Test",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Lädt .peq-Profile temporär (ohne dauerhaftes Speichern).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Hardware-Einschränkung: EQ-Wechsel sind nicht garantiert klickfrei.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Stellt den ursprünglichen EQ nach Abschluss oder Abbruch wieder her.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "Werden während eines Durchgangs externe EQ-Regler geändert, wird die Sitzung beendet, um deine Anpassungen zu erhalten.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Klanganpassungen sind weder lautstärkeangepasst noch bitgenau.",
        ["Trial %d of %d"] = "Durchgang %d von %d",
        ["Auditioning %s"] = "Hörprobe: %s",
        ["Sample A"] = "Probe A",
        ["Sample B"] = "Probe B",
        ["Sample X (Hidden)"] = "Probe X (Verdeckt)",
        ["Sample X"] = "Probe X",
        ["Vote: X is A"] = "Stimme: X ist A",
        ["Vote: X is B"] = "Stimme: X ist B",
        ["Final Score: %d/%d (%.1f%%)"] = "Endergebnis: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "p-Wert: %.4f (%s)",
        ["Significant"] = "Signifikant",
        ["Inconclusive"] = "Nicht eindeutig",
        ["Restart Test"] = "Test neu starten",
        ["Exit ABX Session"] = "ABX-Sitzung beenden",
        ["ABX Session ended"] = "ABX-Sitzung beendet",
        ["Playback interrupted; ABX session ended."] = "Wiedergabe unterbrochen; ABX-Sitzung beendet.",
    },
    es = {
        ["ABX Blind Test"] = "Prueba ciega ABX",
        ["Baseline EQ"] = "EQ base",
        ["Profile B"] = "Perfil B",
        ["Current Snapshot"] = "Instantánea actual",
        ["Path must be a non-empty string"] = "La ruta no puede estar vacía",
        ["Network URLs are not supported for local comparison"] = "No se admiten URL de red para la comparación local",
        ["Path traversal ('..') is not permitted"] = "No se permite '..' en la ruta",
        ["Path must be located inside the SD card (%s)"] = "La ruta debe estar dentro de la tarjeta SD (%s)",
        ["playback paused or stopped"] = "reproducción en pausa o detenida",
        ["native switch not ready"] = "cambio nativo no preparado",
        ["playback format unavailable"] = "formato de reproducción no disponible",
        ["track restarted or changed"] = "pista reiniciada o cambiada",
        ["track path changed"] = "cambió la ruta de la pista",
        ["playback speed must be 1.0x (currently %s)"] = "la velocidad debe ser 1.0x (actualmente %s)",
        ["unknown"] = "desconocido",
        ["crossfade enabled"] = "fundido activado",
        ["stream/dsd source"] = "fuente de transmisión/DSD",
        ["track duration not positive and finite"] = "la duración no es positiva y finita",
        ["streaming audio not supported"] = "audio en transmisión no compatible",
        ["track duration not finite or positive"] = "la duración no es finita o positiva",
        ["track playback generation changed"] = "cambió la generación de reproducción",
        ["Player lacks playback.ab_switch capability"] = "El reproductor no tiene la capacidad playback.ab_switch",
        ["Primary track must be currently playing"] = "La pista principal debe estar reproduciéndose",
        ["Playback format query unavailable"] = "Consulta de formato de reproducción no disponible",
        ["No active audio format"] = "Sin formato de audio activo",
        ["Stream playback cannot be used for comparison"] = "Las transmisiones no se pueden usar para comparar",
        ["DSD tracks cannot be used for AB switch"] = "Las pistas DSD no se pueden usar para el cambio AB",
        ["Playback speed must be 1.0x"] = "La velocidad de reproducción debe ser 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "El fundido debe desactivarse en los Ajustes de sonido",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Códec principal (%s, %d bits) no compatible: requiere FLAC/PCM de 16 bits o MP3",
        ["Comparison preparation cancelled"] = "Preparación de comparación cancelada",
        ["Alternate track ready for ABX test!"] = "¡Pista alternativa lista para la prueba ABX!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Preparación rechazada: frecuencia de muestreo, canales o fotogramas no coinciden",
        ["Preparation timed out (5m)"] = "Tiempo de preparación agotado (5m)",
        ["Timer slot limit reached; cannot poll preparation"] = "Límite de temporizadores alcanzado; no se puede verificar la preparación",
        ["Invalid Track B: %s"] = "Pista B no válida: %s",
        ["No active track path found"] = "No se encontró ruta de pista activa",
        ["Player lacks prepare_ab_switch API"] = "El reproductor no tiene la API prepare_ab_switch",
        ["Audio engine rejected comparison preparation"] = "El motor de audio rechazó la preparación de la comparación",
        ["Preparing alternate file..."] = "Preparando archivo alternativo...",
        ["Readiness lost (%s); ABX session ended."] = "Preparación perdida (%s); sesión ABX finalizada.",
        ["Native switch selection failed; ABX session ended."] = "Falló la selección de cambio nativo; sesión ABX finalizada.",
        ["Playback invalid (%s); ABX session ended."] = "Reproducción no válida (%s); sesión ABX finalizada.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Se detectó un cambio externo de EQ; prueba finalizada para conservar tus Ajustes.",
        ["Invalid session mode; ABX session ended."] = "Modo de sesión no válido; sesión ABX finalizada.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Preparación perdida antes de votar (%s); sesión ABX finalizada.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Reproducción no válida antes de votar (%s); sesión ABX finalizada.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Cambio externo de EQ detectado antes de votar; prueba finalizada para conservar tus Ajustes.",
        ["Invalid mode before vote; ABX session ended."] = "Modo no válido antes de votar; sesión ABX finalizada.",
        ["Audition failed for next trial; session ended."] = "Falló la audición para el siguiente intento; sesión finalizada.",
        ["Vote recorded. Starting Trial %d of %d"] = "Voto registrado. Iniciando intento %d de %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "¡Prueba completada! Puntuación: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Reproducción no lista (%s); sesión ABX finalizada.",
        ["Profile B not loaded; cannot restart EQ test."] = "Perfil B no cargado; no se puede reiniciar la prueba de EQ.",
        ["No test mode configured; cannot restart."] = "Sin modo de prueba configurado; no se puede reiniciar.",
        ["Audition failed on restart; session ended."] = "Falló la audición al reiniciar; sesión finalizada.",
        ["ABX Session restarted"] = "Sesión ABX reiniciada",
        ["Parent folder"] = "Carpeta superior",
        ["No matching files here (%s)"] = "No hay archivos coincidentes aquí (%s)",
        ["Select File"] = "Seleccionar archivo",
        ["Audio File ABX Test..."] = "Prueba ABX de archivos de audio...",
        ["Equalizer Profile ABX Test..."] = "Prueba ABX de perfiles de EQ...",
        ["Trials Per Session: %d"] = "Intentos por sesión: %d",
        ["Trials set to %d"] = "Intentos establecidos en %d",
        ["About ABX Blind Test"] = "Acerca de Prueba ciega ABX",
        ["Blind ABX listener evaluation tool with randomized X."] = "Herramienta de evaluación auditiva ciega ABX con X aleatorio.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "En cada intento, la muestra X se asigna al azar a la fuente A o B.",
        ["Audition A, B, and X, then select your vote."] = "Escucha A, B y X, y luego selecciona tu voto.",
        ["File mode uses native gapless switching with shared DSP."] = "El modo de archivo usa conmutación nativa sin pausas con DSP compartido.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Admite FLAC/PCM de 16 bits y archivos MP3 locales emparejados.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "El cambio de perfil EQ no garantiza actualizaciones en vivo sin chasquidos.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Calcula la probabilidad binomial exacta (valor p) al finalizar.",
        ["(None Playing)"] = "(Nada reproduciéndose)",
        ["(Not Selected)"] = "(No seleccionado)",
        ["Status: Idle"] = "Estado: Inactivo",
        ["Status: Preparing... (Tap to Cancel)"] = "Estado: Preparando... (Toca para cancelar)",
        ["Status: Ready (Matched)"] = "Estado: Listo (Emparejado)",
        ["Main menu"] = "Menú principal",
        ["Track A: %s"] = "Pista A: %s",
        ["None"] = "Ninguna",
        ["Track B: %s"] = "Pista B: %s",
        ["Selected: %s"] = "Seleccionado: %s",
        ["Select Track B (File Browser)..."] = "Seleccionar pista B (Explorador)...",
        ["Enter Track B Path (Text)..."] = "Introducir ruta de pista B (Texto)...",
        ["Enter Track B Path"] = "Introducir ruta de pista B",
        ["Invalid path: %s"] = "Ruta no válida: %s",
        ["Prepare Comparison"] = "Preparar comparación",
        ["Cancel Preparation"] = "Cancelar preparación",
        ["Start ABX File Test"] = "Iniciar prueba ABX de archivo",
        ["Track B is not ready yet"] = "La pista B aún no está lista",
        ["Not ready: %s"] = "No está listo: %s",
        ["Audition failed on start"] = "Falló la audición al iniciar",
        ["Clear Comparison"] = "Limpiar comparación",
        ["Comparison cleared"] = "Comparación limpiada",
        ["Notice: PEQ updates are not click-free"] = "Aviso: los cambios de PEQ pueden producir chasquidos",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "La actualización de coeficientes PEQ no garantiza cambios sin chasquidos.",
        ["Profile A: %s"] = "Perfil A: %s",
        ["Profile B: %s"] = "Perfil B: %s",
        ["Use Current EQ as Profile A"] = "Usar EQ actual como Perfil A",
        ["Captured Current EQ as Profile A"] = "EQ actual capturado como Perfil A",
        ["Load .peq for Profile B..."] = "Cargar .peq para Perfil B...",
        ["Invalid Profile Path: %s"] = "Ruta de perfil no válida: %s",
        ["Loaded %s transiently"] = "Cargado %s temporalmente",
        ["Failed to load .peq profile"] = "No se pudo cargar el perfil .peq",
        ["Start ABX EQ Test"] = "Iniciar prueba ABX de EQ",
        ["Player lacks audio.peq.state capability"] = "El reproductor no tiene la capacidad audio.peq.state",
        ["EQ state query unavailable"] = "Consulta de estado de EQ no disponible",
        ["Playback not ready: %s"] = "Reproducción no lista: %s",
        ["Could not read baseline EQ"] = "No se pudo leer el EQ base",
        ["Please load Profile B first"] = "Carga primero el Perfil B",
        ["About EQ Comparisons"] = "Acerca de las comparaciones de EQ",
        ["About EQ ABX Test"] = "Acerca de la prueba ABX de EQ",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Carga perfiles .peq temporalmente (sin guardar en memoria).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Limitación de hardware: los cambios de EQ pueden producir chasquidos.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Restaura el EQ base al completar o cancelar la prueba.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "Si tocas controles externos de EQ durante un intento, la sesión se suspende para conservar tus Ajustes.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Los ajustes de tono no igualan sonoridad ni son bit-perfect.",
        ["Trial %d of %d"] = "Intento %d de %d",
        ["Auditioning %s"] = "Escuchando %s",
        ["Sample A"] = "Muestra A",
        ["Sample B"] = "Muestra B",
        ["Sample X (Hidden)"] = "Muestra X (Oculta)",
        ["Sample X"] = "Muestra X",
        ["Vote: X is A"] = "Votar: X es A",
        ["Vote: X is B"] = "Votar: X es B",
        ["Final Score: %d/%d (%.1f%%)"] = "Puntuación final: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "valor p: %.4f (%s)",
        ["Significant"] = "Significativo",
        ["Inconclusive"] = "No concluyente",
        ["Restart Test"] = "Reiniciar prueba",
        ["Exit ABX Session"] = "Salir de la sesión ABX",
        ["ABX Session ended"] = "Sesión ABX finalizada",
        ["Playback interrupted; ABX session ended."] = "Reproducción interrumpida; sesión ABX finalizada.",
    },
    fi = {
        ["ABX Blind Test"] = "ABX-sokkotesti",
        ["Baseline EQ"] = "Perus-EQ",
        ["Profile B"] = "Profiili B",
        ["Current Snapshot"] = "Nykyinen tila",
        ["Path must be a non-empty string"] = "Polku ei voi olla tyhjä",
        ["Network URLs are not supported for local comparison"] = "Verkko-osoitteita ei tueta paikallisessa vertailussa",
        ["Path traversal ('..') is not permitted"] = "Polun siirtymä ('..') ei ole sallittu",
        ["Path must be located inside the SD card (%s)"] = "Polun on oltava SD-kortilla (%s)",
        ["playback paused or stopped"] = "toisto keskeytetty tai pysäytetty",
        ["native switch not ready"] = "natiivi vaihto ei ole valmis",
        ["playback format unavailable"] = "toistomuoto ei saatavilla",
        ["track restarted or changed"] = "kappale aloitettu alusta tai vaihdettu",
        ["track path changed"] = "kappaleen polku muuttui",
        ["playback speed must be 1.0x (currently %s)"] = "toistonopeuden on oltava 1.0x (nyt %s)",
        ["unknown"] = "tuntematon",
        ["crossfade enabled"] = "ristihäivytys käytössä",
        ["stream/dsd source"] = "suoratoisto-/DSD-lähde",
        ["track duration not positive and finite"] = "kappaleen kesto ei ole positiivinen ja äärellinen",
        ["streaming audio not supported"] = "suoratoistoääntä ei tueta",
        ["track duration not finite or positive"] = "kappaleen kesto ei ole äärellinen tai positiivinen",
        ["track playback generation changed"] = "toistosukupolvi muuttui",
        ["Player lacks playback.ab_switch capability"] = "Soittimesta puuttuu playback.ab_switch-ominaisuus",
        ["Primary track must be currently playing"] = "Ensisijaisen kappaleen on oltava toistossa",
        ["Playback format query unavailable"] = "Toistomuodon kysely ei ole käytettävissä",
        ["No active audio format"] = "Ei aktiivista äänimuotoa",
        ["Stream playback cannot be used for comparison"] = "Suoratoistoa ei voi käyttää vertailuun",
        ["DSD tracks cannot be used for AB switch"] = "DSD-kappaleita ei voi käyttää AB-vaihtoon",
        ["Playback speed must be 1.0x"] = "Toistonopeuden on oltava 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "Ristihäivytys on poistettava käytöstä ääniasetuksissa",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Koodekkia (%s, %d-bit) ei tueta: vaatii 16-bittisen FLAC/PCM:n tai MP3:n",
        ["Comparison preparation cancelled"] = "Vertailun valmistelu peruutettu",
        ["Alternate track ready for ABX test!"] = "Vaihtoehtoinen kappale valmis ABX-testiin!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Valmistelu hylättiin: näytteenottotaajuus, kanavat tai kehysmäärät eivät täsmää",
        ["Preparation timed out (5m)"] = "Valmistelu aikakatkaistiin (5 min)",
        ["Timer slot limit reached; cannot poll preparation"] = "Ajastinraja täynnä; valmistelua ei voi seurata",
        ["Invalid Track B: %s"] = "Virheellinen kappale B: %s",
        ["No active track path found"] = "Aktiivisen kappaleen polkua ei löytynyt",
        ["Player lacks prepare_ab_switch API"] = "Soittimesta puuttuu prepare_ab_switch-rajapinta",
        ["Audio engine rejected comparison preparation"] = "Äänimoottori hylkäsi vertailun valmistelun",
        ["Preparing alternate file..."] = "Valmistellaan vaihtoehtoista tiedostoa...",
        ["Readiness lost (%s); ABX session ended."] = "Valmius menetettiin (%s); ABX-istunto päättyi.",
        ["Native switch selection failed; ABX session ended."] = "Vaihto epäonnistui; ABX-istunto päättyi.",
        ["Playback invalid (%s); ABX session ended."] = "Virheellinen toisto (%s); ABX-istunto päättyi.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Ulkoinen EQ-muutos havaittu; koe lopetettiin asetustesi säilyttämiseksi.",
        ["Invalid session mode; ABX session ended."] = "Virheellinen istuntotila; ABX-istunto päättyi.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Valmius menetettiin ennen äänestystä (%s); ABX-istunto päättyi.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Virheellinen toisto ennen äänestystä (%s); ABX-istunto päättyi.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Ulkoinen EQ-muutos havaittu ennen äänestystä; koe lopetettiin asetustesi säilyttämiseksi.",
        ["Invalid mode before vote; ABX session ended."] = "Virheellinen tila ennen äänestystä; ABX-istunto päättyi.",
        ["Audition failed for next trial; session ended."] = "Seuraavan kierroksen kuuntelu epäonnistui; istunto päättyi.",
        ["Vote recorded. Starting Trial %d of %d"] = "Ääni tallennettu. Aloitetaan kierros %d / %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Testi valmis! Tulos: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Toisto ei ole valmis (%s); ABX-istunto päättyi.",
        ["Profile B not loaded; cannot restart EQ test."] = "Profiilia B ei ole ladattu; EQ-testiä ei voi käynnistää uudelleen.",
        ["No test mode configured; cannot restart."] = "Testitilaa ei ole määritetty; ei voi käynnistää uudelleen.",
        ["Audition failed on restart; session ended."] = "Kuuntelu epäonnistui uudelleenkäynnistyksessä; istunto päättyi.",
        ["ABX Session restarted"] = "ABX-istunto käynnistettiin uudelleen",
        ["Parent folder"] = "Yläkansio",
        ["No matching files here (%s)"] = "Ei vastaavia tiedostoja täällä (%s)",
        ["Select File"] = "Valitse tiedosto",
        ["Audio File ABX Test..."] = "Äänitiedoston ABX-testi...",
        ["Equalizer Profile ABX Test..."] = "EQ-profiilin ABX-testi...",
        ["Trials Per Session: %d"] = "Kierroksia istunnossa: %d",
        ["Trials set to %d"] = "Kierrosmääräksi asetettu %d",
        ["About ABX Blind Test"] = "Tietoja ABX-sokkotestistä",
        ["Blind ABX listener evaluation tool with randomized X."] = "ABX-sokkokuuntelutyökalu satunnaistetulla X-näytteellä.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "Jokaisella kierroksella näyte X arvotaan joko lähteeksi A tai B.",
        ["Audition A, B, and X, then select your vote."] = "Kuuntele A, B ja X ja valitse sitten äänesi.",
        ["File mode uses native gapless switching with shared DSP."] = "Tiedostotila käyttää saumatonta vaihtoa jaetulla DSP:llä.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Tukee 16-bittisiä FLAC/PCM- ja täsmääviä paikallisia MP3-tiedostoja.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "EQ-profiilin vaihto ei takaa napsahtamatonta vaihtoa.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Laskee tarkan binomitodennäköisyyden (p-arvon) testin lopuksi.",
        ["(None Playing)"] = "(Ei toistoa)",
        ["(Not Selected)"] = "(Ei valittu)",
        ["Status: Idle"] = "Tila: Jouten",
        ["Status: Preparing... (Tap to Cancel)"] = "Tila: Valmistellaan... (Peruuta napauttamalla)",
        ["Status: Ready (Matched)"] = "Tila: Valmis (Täsmää)",
        ["Main menu"] = "Päävalikko",
        ["Track A: %s"] = "Kappale A: %s",
        ["None"] = "Ei mitään",
        ["Track B: %s"] = "Kappale B: %s",
        ["Selected: %s"] = "Valittu: %s",
        ["Select Track B (File Browser)..."] = "Valitse kappale B (Tiedostoselain)...",
        ["Enter Track B Path (Text)..."] = "Syötä kappaleen B polku (Teksti)...",
        ["Enter Track B Path"] = "Syötä kappaleen B polku",
        ["Invalid path: %s"] = "Virheellinen polku: %s",
        ["Prepare Comparison"] = "Valmistele vertailu",
        ["Cancel Preparation"] = "Peruuta valmistelu",
        ["Start ABX File Test"] = "Aloita tiedostojen ABX-testi",
        ["Track B is not ready yet"] = "Kappale B ei ole vielä valmis",
        ["Not ready: %s"] = "Ei valmis: %s",
        ["Audition failed on start"] = "Kuuntelu epäonnistui alussa",
        ["Clear Comparison"] = "Tyhjennä vertailu",
        ["Comparison cleared"] = "Vertailu tyhjennetty",
        ["Notice: PEQ updates are not click-free"] = "Huom: PEQ-päivitykset eivät ole napsahtamattomia",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "PEQ-profiilin kertoimien päivitys ei takaa napsahtamatonta vaihtoa.",
        ["Profile A: %s"] = "Profiili A: %s",
        ["Profile B: %s"] = "Profiili B: %s",
        ["Use Current EQ as Profile A"] = "Käytä nykyistä EQ:ta profiilina A",
        ["Captured Current EQ as Profile A"] = "Nykyinen EQ tallennettu profiiliksi A",
        ["Load .peq for Profile B..."] = "Lataa .peq profiiliksi B...",
        ["Invalid Profile Path: %s"] = "Virheellinen profiilipolku: %s",
        ["Loaded %s transiently"] = "Ladattiin %s väliaikaisesti",
        ["Failed to load .peq profile"] = ".peq-profiilin lataus epäonnistui",
        ["Start ABX EQ Test"] = "Aloita EQ-ABX-testi",
        ["Player lacks audio.peq.state capability"] = "Soittimesta puuttuu audio.peq.state-ominaisuus",
        ["EQ state query unavailable"] = "EQ-tilan kysely ei ole käytettävissä",
        ["Playback not ready: %s"] = "Toisto ei ole valmis: %s",
        ["Could not read baseline EQ"] = "Perus-EQ:ta ei voitu lukea",
        ["Please load Profile B first"] = "Lataa ensin profiili B",
        ["About EQ Comparisons"] = "Tietoja EQ-vertailuista",
        ["About EQ ABX Test"] = "Tietoja EQ-ABX-testistä",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Lataa .peq-profiilit väliaikaisesti (tallentamatta muistiin).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Laitteistorajoitus: EQ-päivitykset eivät takaa napsahtamatonta vaihtoa.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Palauttaa alkuperäisen EQ:n testin valmistuessa tai peruuntuessa.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "Jos ulkoisia EQ-säätimiä muutetaan kokeen aikana, istunto keskeytetään säätöjesi säilyttämiseksi.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Äänensävyn säädöt eivät ole äänenvoimakkuustasattuja eivätkä bittitarkkoja.",
        ["Trial %d of %d"] = "Kierros %d / %d",
        ["Auditioning %s"] = "Kuunnellaan: %s",
        ["Sample A"] = "Näyte A",
        ["Sample B"] = "Näyte B",
        ["Sample X (Hidden)"] = "Näyte X (Piilotettu)",
        ["Sample X"] = "Näyte X",
        ["Vote: X is A"] = "Äänestä: X on A",
        ["Vote: X is B"] = "Äänestä: X on B",
        ["Final Score: %d/%d (%.1f%%)"] = "Lopputulos: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "p-arvo: %.4f (%s)",
        ["Significant"] = "Merkitsevä",
        ["Inconclusive"] = "Ratkaisematon",
        ["Restart Test"] = "Aloita testi alusta",
        ["Exit ABX Session"] = "Poistu ABX-istunnosta",
        ["ABX Session ended"] = "ABX-istunto päättyi",
        ["Playback interrupted; ABX session ended."] = "Toisto keskeytyi; ABX-istunto päättyi.",
    },
    fr = {
        ["ABX Blind Test"] = "Test aveugle ABX",
        ["Baseline EQ"] = "EQ de base",
        ["Profile B"] = "Profil B",
        ["Current Snapshot"] = "État actuel",
        ["Path must be a non-empty string"] = "Le chemin ne doit pas être vide",
        ["Network URLs are not supported for local comparison"] = "Les URL réseau ne sont pas prises en charge pour la comparaison locale",
        ["Path traversal ('..') is not permitted"] = "Le parcours de chemin ('..') n'est pas autorisé",
        ["Path must be located inside the SD card (%s)"] = "Le chemin doit se trouver sur la carte SD (%s)",
        ["playback paused or stopped"] = "lecture en pause ou arrêtée",
        ["native switch not ready"] = "commutation native non prête",
        ["playback format unavailable"] = "format de lecture indisponible",
        ["track restarted or changed"] = "piste redémarrée ou changée",
        ["track path changed"] = "chemin de piste modifié",
        ["playback speed must be 1.0x (currently %s)"] = "la vitesse doit être de 1.0x (actuellement %s)",
        ["unknown"] = "inconnu",
        ["crossfade enabled"] = "fondu enchaîné activé",
        ["stream/dsd source"] = "source flux/DSD",
        ["track duration not positive and finite"] = "durée de piste non positive et finie",
        ["streaming audio not supported"] = "audio en streaming non pris en charge",
        ["track duration not finite or positive"] = "durée de piste non finie ou positive",
        ["track playback generation changed"] = "génération de lecture modifiée",
        ["Player lacks playback.ab_switch capability"] = "Le lecteur ne dispose pas de playback.ab_switch",
        ["Primary track must be currently playing"] = "La piste principale doit être en cours de lecture",
        ["Playback format query unavailable"] = "Requête de format de lecture indisponible",
        ["No active audio format"] = "Aucun format audio actif",
        ["Stream playback cannot be used for comparison"] = "Les flux ne peuvent pas être utilisés pour la comparaison",
        ["DSD tracks cannot be used for AB switch"] = "Les pistes DSD ne peuvent pas être utilisées pour le commutateur AB",
        ["Playback speed must be 1.0x"] = "La vitesse de lecture doit être de 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "Le fondu enchaîné doit être désactivé dans les paramètres audio",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Codec principal (%s, %d bits) non pris en charge : FLAC/PCM 16 bits ou MP3 requis",
        ["Comparison preparation cancelled"] = "Préparation de la comparaison annulée",
        ["Alternate track ready for ABX test!"] = "Piste alternative prête pour le test ABX !",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Préparation refusée : fréquence d'échantillonnage, canaux ou nombre de trames différents",
        ["Preparation timed out (5m)"] = "Délai de préparation dépassé (5 min)",
        ["Timer slot limit reached; cannot poll preparation"] = "Limite de minuteurs atteinte ; suivi impossible",
        ["Invalid Track B: %s"] = "Piste B invalide : %s",
        ["No active track path found"] = "Aucun chemin de piste actif trouvé",
        ["Player lacks prepare_ab_switch API"] = "Le lecteur ne dispose pas de l'API prepare_ab_switch",
        ["Audio engine rejected comparison preparation"] = "Le moteur audio a refusé la préparation de la comparaison",
        ["Preparing alternate file..."] = "Préparation du fichier alternatif...",
        ["Readiness lost (%s); ABX session ended."] = "État prêt perdu (%s) ; session ABX terminée.",
        ["Native switch selection failed; ABX session ended."] = "Échec de commutation native ; session ABX terminée.",
        ["Playback invalid (%s); ABX session ended."] = "Lecture invalide (%s) ; session ABX terminée.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Modification externe de l'EQ détectée ; essai terminé pour préserver vos réglages.",
        ["Invalid session mode; ABX session ended."] = "Mode de session invalide ; session ABX terminée.",
        ["Readiness lost before vote (%s); ABX session ended."] = "État prêt perdu avant le vote (%s) ; session ABX terminée.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Lecture invalide avant le vote (%s) ; session ABX terminée.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Modification externe de l'EQ avant le vote ; essai terminé pour préserver vos réglages.",
        ["Invalid mode before vote; ABX session ended."] = "Mode invalide avant le vote ; session ABX terminée.",
        ["Audition failed for next trial; session ended."] = "Échec de l'écoute pour l'essai suivant ; session terminée.",
        ["Vote recorded. Starting Trial %d of %d"] = "Vote enregistré. Début de l'essai %d sur %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Test terminé ! Score : %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Lecture non prête (%s) ; session ABX terminée.",
        ["Profile B not loaded; cannot restart EQ test."] = "Profil B non chargé ; impossible de redémarrer le test EQ.",
        ["No test mode configured; cannot restart."] = "Aucun mode de test configuré ; redémarrage impossible.",
        ["Audition failed on restart; session ended."] = "Échec de l'écoute au redémarrage ; session terminée.",
        ["ABX Session restarted"] = "Session ABX redémarrée",
        ["Parent folder"] = "Dossier parent",
        ["No matching files here (%s)"] = "Aucun fichier correspondant ici (%s)",
        ["Select File"] = "Sélectionner un fichier",
        ["Audio File ABX Test..."] = "Test ABX de fichiers audio...",
        ["Equalizer Profile ABX Test..."] = "Test ABX de profils EQ...",
        ["Trials Per Session: %d"] = "Essais par session : %d",
        ["Trials set to %d"] = "Essais définis sur %d",
        ["About ABX Blind Test"] = "À propos du test aveugle ABX",
        ["Blind ABX listener evaluation tool with randomized X."] = "Outil d'évaluation d'écoute aveugle ABX avec X aléatoire.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "À chaque essai, l'échantillon X est attribué au hasard à A ou B.",
        ["Audition A, B, and X, then select your vote."] = "Écoutez A, B et X, puis votez.",
        ["File mode uses native gapless switching with shared DSP."] = "Le mode fichier utilise la commutation sans coupure avec DSP partagé.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Prend en charge les fichiers FLAC/PCM 16 bits et MP3 locaux correspondants.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "La commutation de profil EQ ne garantit pas l'absence de clics.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Calcule la probabilité binomiale exacte (valeur p) à la fin.",
        ["(None Playing)"] = "(Aucune lecture)",
        ["(Not Selected)"] = "(Non sélectionné)",
        ["Status: Idle"] = "État : Inactif",
        ["Status: Preparing... (Tap to Cancel)"] = "État : Préparation... (Toucher pour annuler)",
        ["Status: Ready (Matched)"] = "État : Prêt (Correspondant)",
        ["Main menu"] = "Menu principal",
        ["Track A: %s"] = "Piste A : %s",
        ["None"] = "Aucune",
        ["Track B: %s"] = "Piste B : %s",
        ["Selected: %s"] = "Sélectionné : %s",
        ["Select Track B (File Browser)..."] = "Choisir la piste B (Explorateur)...",
        ["Enter Track B Path (Text)..."] = "Saisir le chemin de la piste B (Texte)...",
        ["Enter Track B Path"] = "Saisir le chemin de la piste B",
        ["Invalid path: %s"] = "Chemin invalide : %s",
        ["Prepare Comparison"] = "Préparer la comparaison",
        ["Cancel Preparation"] = "Annuler la préparation",
        ["Start ABX File Test"] = "Démarrer le test ABX de fichier",
        ["Track B is not ready yet"] = "La piste B n'est pas encore prête",
        ["Not ready: %s"] = "Non prêt : %s",
        ["Audition failed on start"] = "Échec de l'écoute au démarrage",
        ["Clear Comparison"] = "Effacer la comparaison",
        ["Comparison cleared"] = "Comparaison effacée",
        ["Notice: PEQ updates are not click-free"] = "Note : les changements PEQ peuvent produire un clic",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "La mise à jour des coefficients PEQ ne garantit pas une commutation sans clic.",
        ["Profile A: %s"] = "Profil A : %s",
        ["Profile B: %s"] = "Profil B : %s",
        ["Use Current EQ as Profile A"] = "Utiliser l'EQ actuel comme Profil A",
        ["Captured Current EQ as Profile A"] = "EQ actuel capturé comme Profil A",
        ["Load .peq for Profile B..."] = "Charger un .peq pour le Profil B...",
        ["Invalid Profile Path: %s"] = "Chemin de profil invalide : %s",
        ["Loaded %s transiently"] = "%s chargé temporairement",
        ["Failed to load .peq profile"] = "Échec du chargement du profil .peq",
        ["Start ABX EQ Test"] = "Démarrer le test ABX d'EQ",
        ["Player lacks audio.peq.state capability"] = "Le lecteur ne dispose pas de audio.peq.state",
        ["EQ state query unavailable"] = "Requête d'état EQ indisponible",
        ["Playback not ready: %s"] = "Lecture non prête : %s",
        ["Could not read baseline EQ"] = "Impossible de lire l'EQ de base",
        ["Please load Profile B first"] = "Veuillez d'abord charger le Profil B",
        ["About EQ Comparisons"] = "À propos des comparaisons d'EQ",
        ["About EQ ABX Test"] = "À propos du test ABX d'EQ",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Charge les profils .peq temporairement (sans sauvegarde flash).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Limite matérielle : les changements d'EQ ne sont pas garantis sans clic.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Restaure l'EQ de base à la fin ou à l'annulation du test.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "Si les réglages EQ externes sont modifiés pendant un essai, la session s'arrête pour préserver vos réglages.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Les réglages de tonalité ne sont ni égalisés en volume ni bit-perfect.",
        ["Trial %d of %d"] = "Essai %d sur %d",
        ["Auditioning %s"] = "Écoute de %s",
        ["Sample A"] = "Échantillon A",
        ["Sample B"] = "Échantillon B",
        ["Sample X (Hidden)"] = "Échantillon X (Masqué)",
        ["Sample X"] = "Échantillon X",
        ["Vote: X is A"] = "Voter : X est A",
        ["Vote: X is B"] = "Voter : X est B",
        ["Final Score: %d/%d (%.1f%%)"] = "Score final : %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "valeur p : %.4f (%s)",
        ["Significant"] = "Significatif",
        ["Inconclusive"] = "Non concluant",
        ["Restart Test"] = "Redémarrer le test",
        ["Exit ABX Session"] = "Quitter la session ABX",
        ["ABX Session ended"] = "Session ABX terminée",
        ["Playback interrupted; ABX session ended."] = "Lecture interrompue ; session ABX terminée.",
    },
    it = {
        ["ABX Blind Test"] = "Test cieco ABX",
        ["Baseline EQ"] = "EQ di base",
        ["Profile B"] = "Profilo B",
        ["Current Snapshot"] = "Stato attuale",
        ["Path must be a non-empty string"] = "Il percorso non può essere vuoto",
        ["Network URLs are not supported for local comparison"] = "Gli URL di rete non sono supportati per il confronto locale",
        ["Path traversal ('..') is not permitted"] = "Il percorso con '..' non è consentito",
        ["Path must be located inside the SD card (%s)"] = "Il percorso deve trovarsi sulla scheda SD (%s)",
        ["playback paused or stopped"] = "riproduzione in pausa o fermata",
        ["native switch not ready"] = "commutazione nativa non pronta",
        ["playback format unavailable"] = "formato di riproduzione non disponibile",
        ["track restarted or changed"] = "brano riavviato o cambiato",
        ["track path changed"] = "percorso del brano cambiato",
        ["playback speed must be 1.0x (currently %s)"] = "la velocità deve essere 1.0x (attuale %s)",
        ["unknown"] = "sconosciuto",
        ["crossfade enabled"] = "dissolvenza incrociata attiva",
        ["stream/dsd source"] = "sorgente stream/DSD",
        ["track duration not positive and finite"] = "durata del brano non positiva e finita",
        ["streaming audio not supported"] = "audio in streaming non supportato",
        ["track duration not finite or positive"] = "durata del brano non finita o positiva",
        ["track playback generation changed"] = "generazione di riproduzione cambiata",
        ["Player lacks playback.ab_switch capability"] = "Il lettore non supporta playback.ab_switch",
        ["Primary track must be currently playing"] = "Il brano principale deve essere in riproduzione",
        ["Playback format query unavailable"] = "Interrogazione formato di riproduzione non disponibile",
        ["No active audio format"] = "Nessun formato audio attivo",
        ["Stream playback cannot be used for comparison"] = "Lo streaming non può essere usato per il confronto",
        ["DSD tracks cannot be used for AB switch"] = "I brani DSD non possono essere usati per la commutazione AB",
        ["Playback speed must be 1.0x"] = "La velocità di riproduzione deve essere 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "La dissolvenza deve essere disattivata nelle impostazioni audio",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Codec principale (%s, %d bit) non supportato: richiede FLAC/PCM a 16 bit o MP3",
        ["Comparison preparation cancelled"] = "Preparazione del confronto annullata",
        ["Alternate track ready for ABX test!"] = "Brano alternativo pronto per il test ABX!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Preparazione rifiutata: frequenza, canali o numero di frame non corrispondono",
        ["Preparation timed out (5m)"] = "Tempo di preparazione scaduto (5m)",
        ["Timer slot limit reached; cannot poll preparation"] = "Limite timer raggiunto; impossibile monitorare la preparazione",
        ["Invalid Track B: %s"] = "Brano B non valido: %s",
        ["No active track path found"] = "Nessun percorso di brano attivo trovato",
        ["Player lacks prepare_ab_switch API"] = "Il lettore non supporta l'API prepare_ab_switch",
        ["Audio engine rejected comparison preparation"] = "Il motore audio ha rifiutato la preparazione del confronto",
        ["Preparing alternate file..."] = "Preparazione file alternativo...",
        ["Readiness lost (%s); ABX session ended."] = "Prontezza persa (%s); sessione ABX terminata.",
        ["Native switch selection failed; ABX session ended."] = "Commutazione nativa non riuscita; sessione ABX terminata.",
        ["Playback invalid (%s); ABX session ended."] = "Riproduzione non valida (%s); sessione ABX terminata.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Rilevata modifica EQ esterna; prova terminata per preservare le tue impostazioni.",
        ["Invalid session mode; ABX session ended."] = "Modalità sessione non valida; sessione ABX terminata.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Prontezza persa prima del voto (%s); sessione ABX terminata.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Riproduzione non valida prima del voto (%s); sessione ABX terminata.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Rilevata modifica EQ esterna prima del voto; prova terminata per preservare le tue impostazioni.",
        ["Invalid mode before vote; ABX session ended."] = "Modalità non valida prima del voto; sessione ABX terminata.",
        ["Audition failed for next trial; session ended."] = "Ascolto fallito per la prova successiva; sessione terminata.",
        ["Vote recorded. Starting Trial %d of %d"] = "Voto registrato. Avvio prova %d di %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Test completato! Punteggio: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Riproduzione non pronta (%s); sessione ABX terminata.",
        ["Profile B not loaded; cannot restart EQ test."] = "Profilo B non caricato; impossibile riavviare il test EQ.",
        ["No test mode configured; cannot restart."] = "Nessuna modalità di test configurata; impossibile riavviare.",
        ["Audition failed on restart; session ended."] = "Ascolto fallito al riavvio; sessione terminata.",
        ["ABX Session restarted"] = "Sessione ABX riavviata",
        ["Parent folder"] = "Cartella superiore",
        ["No matching files here (%s)"] = "Nessun file corrispondente qui (%s)",
        ["Select File"] = "Seleziona file",
        ["Audio File ABX Test..."] = "Test ABX file audio...",
        ["Equalizer Profile ABX Test..."] = "Test ABX profilo EQ...",
        ["Trials Per Session: %d"] = "Prove per sessione: %d",
        ["Trials set to %d"] = "Prove impostate a %d",
        ["About ABX Blind Test"] = "Informazioni sul test cieco ABX",
        ["Blind ABX listener evaluation tool with randomized X."] = "Strumento di valutazione d'ascolto cieco ABX con X casuale.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "In ogni prova, il campione X è assegnato casualmente alla sorgente A o B.",
        ["Audition A, B, and X, then select your vote."] = "Ascolta A, B e X, poi esprimi il tuo voto.",
        ["File mode uses native gapless switching with shared DSP."] = "La modalità file usa la commutazione nativa senza interruzioni con DSP condiviso.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Supporta file FLAC/PCM a 16 bit e MP3 locali corrispondenti.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "Il cambio di profilo EQ non garantisce assenza di clic.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Calcola la probabilità binomiale esatta (valore p) al termine.",
        ["(None Playing)"] = "(Nessuna riproduzione)",
        ["(Not Selected)"] = "(Non selezionato)",
        ["Status: Idle"] = "Stato: Inattivo",
        ["Status: Preparing... (Tap to Cancel)"] = "Stato: Preparazione... (Tocca per annullare)",
        ["Status: Ready (Matched)"] = "Stato: Pronto (Corrispondente)",
        ["Main menu"] = "Menu principale",
        ["Track A: %s"] = "Brano A: %s",
        ["None"] = "Nessuno",
        ["Track B: %s"] = "Brano B: %s",
        ["Selected: %s"] = "Selezionato: %s",
        ["Select Track B (File Browser)..."] = "Seleziona Brano B (Esplora file)...",
        ["Enter Track B Path (Text)..."] = "Inserisci percorso Brano B (Testo)...",
        ["Enter Track B Path"] = "Inserisci percorso Brano B",
        ["Invalid path: %s"] = "Percorso non valido: %s",
        ["Prepare Comparison"] = "Prepara confronto",
        ["Cancel Preparation"] = "Annulla preparazione",
        ["Start ABX File Test"] = "Avvia test ABX file",
        ["Track B is not ready yet"] = "Il Brano B non è ancora pronto",
        ["Not ready: %s"] = "Non pronto: %s",
        ["Audition failed on start"] = "Ascolto fallito all'avvio",
        ["Clear Comparison"] = "Cancella confronto",
        ["Comparison cleared"] = "Confronto cancellato",
        ["Notice: PEQ updates are not click-free"] = "Nota: le modifiche PEQ possono produrre clic",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "L'aggiornamento dei coefficienti PEQ non garantisce commutazioni senza clic.",
        ["Profile A: %s"] = "Profilo A: %s",
        ["Profile B: %s"] = "Profilo B: %s",
        ["Use Current EQ as Profile A"] = "Usa EQ attuale come Profilo A",
        ["Captured Current EQ as Profile A"] = "EQ attuale salvato come Profilo A",
        ["Load .peq for Profile B..."] = "Carica .peq per Profilo B...",
        ["Invalid Profile Path: %s"] = "Percorso profilo non valido: %s",
        ["Loaded %s transiently"] = "Caricato %s temporaneamente",
        ["Failed to load .peq profile"] = "Impossibile caricare il profilo .peq",
        ["Start ABX EQ Test"] = "Avvia test ABX EQ",
        ["Player lacks audio.peq.state capability"] = "Il lettore non supporta audio.peq.state",
        ["EQ state query unavailable"] = "Interrogazione stato EQ non disponibile",
        ["Playback not ready: %s"] = "Riproduzione non pronta: %s",
        ["Could not read baseline EQ"] = "Impossibile leggere l'EQ di base",
        ["Please load Profile B first"] = "Carica prima il Profilo B",
        ["About EQ Comparisons"] = "Informazioni sui confronti EQ",
        ["About EQ ABX Test"] = "Informazioni sul test ABX EQ",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Carica i profili .peq temporaneamente (senza salvataggio su memoria).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Limite hardware: gli aggiornamenti EQ non garantiscono commutazioni senza clic.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Ripristina l'EQ di base al termine o all'annullamento del test.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "Se i controlli EQ esterni vengono toccati durante una prova, la sessione termina per preservare le tue modifiche.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Le regolazioni di tono non sono pareggiate in volume né bit-perfect.",
        ["Trial %d of %d"] = "Prova %d di %d",
        ["Auditioning %s"] = "Ascolto: %s",
        ["Sample A"] = "Campione A",
        ["Sample B"] = "Campione B",
        ["Sample X (Hidden)"] = "Campione X (Nascosto)",
        ["Sample X"] = "Campione X",
        ["Vote: X is A"] = "Vota: X è A",
        ["Vote: X is B"] = "Vota: X è B",
        ["Final Score: %d/%d (%.1f%%)"] = "Punteggio finale: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "valore p: %.4f (%s)",
        ["Significant"] = "Significativo",
        ["Inconclusive"] = "Non conclusivo",
        ["Restart Test"] = "Riavvia test",
        ["Exit ABX Session"] = "Esci dalla sessione ABX",
        ["ABX Session ended"] = "Sessione ABX terminata",
        ["Playback interrupted; ABX session ended."] = "Riproduzione interrotta; sessione ABX terminata.",
    },
    ja = {
        ["ABX Blind Test"] = "ABX ブラインドテスト",
        ["Baseline EQ"] = "基準 EQ",
        ["Profile B"] = "プロファイル B",
        ["Current Snapshot"] = "現在の設定",
        ["Path must be a non-empty string"] = "パスが空です",
        ["Network URLs are not supported for local comparison"] = "ネットワーク URL はローカル比較に対応していません",
        ["Path traversal ('..') is not permitted"] = "パストラバーサル ('..') は許可されていません",
        ["Path must be located inside the SD card (%s)"] = "パスは SD カード内 (%s) にある必要があります",
        ["playback paused or stopped"] = "再生が一時停止または停止中",
        ["native switch not ready"] = "ネイティブ切替の準備ができていません",
        ["playback format unavailable"] = "再生フォーマットを取得できません",
        ["track restarted or changed"] = "曲が再開または変更されました",
        ["track path changed"] = "曲のパスが変更されました",
        ["playback speed must be 1.0x (currently %s)"] = "再生速度は 1.0x である必要があります (現在 %s)",
        ["unknown"] = "不明",
        ["crossfade enabled"] = "クロスフェードが有効です",
        ["stream/dsd source"] = "ストリーム/DSD ソース",
        ["track duration not positive and finite"] = "曲の長さが有効ではありません",
        ["streaming audio not supported"] = "ストリーミング再生は非対応です",
        ["track duration not finite or positive"] = "曲の長さが有効ではありません",
        ["track playback generation changed"] = "再生状態が変更されました",
        ["Player lacks playback.ab_switch capability"] = "プレーヤーが playback.ab_switch に対応していません",
        ["Primary track must be currently playing"] = "基準となる曲を再生中である必要があります",
        ["Playback format query unavailable"] = "再生フォーマットを取得できません",
        ["No active audio format"] = "有効なオーディオフォーマットがありません",
        ["Stream playback cannot be used for comparison"] = "ストリーム再生は比較に使用できません",
        ["DSD tracks cannot be used for AB switch"] = "DSD 曲は AB 切替に使用できません",
        ["Playback speed must be 1.0x"] = "再生速度は 1.0x にしてください",
        ["Crossfade must be disabled in Sound settings"] = "サウンド設定でクロスフェードを無効にしてください",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "非対応コーデック (%s, %d-bit): 16-bit FLAC/PCM または MP3 が必要です",
        ["Comparison preparation cancelled"] = "比較の準備をキャンセルしました",
        ["Alternate track ready for ABX test!"] = "比較曲の準備が完了しました！",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "準備失敗: サンプルレート、チャンネル数、またはフレーム数が一致しません",
        ["Preparation timed out (5m)"] = "準備がタイムアウトしました (5分)",
        ["Timer slot limit reached; cannot poll preparation"] = "タイマー上限に達したため準備を確認できません",
        ["Invalid Track B: %s"] = "無効なトラック B: %s",
        ["No active track path found"] = "再生中の曲のパスが見つかりません",
        ["Player lacks prepare_ab_switch API"] = "プレーヤーが prepare_ab_switch に対応していません",
        ["Audio engine rejected comparison preparation"] = "オーディオエンジンが比較準備を拒否しました",
        ["Preparing alternate file..."] = "比較ファイルを準備中...",
        ["Readiness lost (%s); ABX session ended."] = "準備状態が解除されました (%s)。ABX セッションを終了しました。",
        ["Native switch selection failed; ABX session ended."] = "切替に失敗しました。ABX セッションを終了しました。",
        ["Playback invalid (%s); ABX session ended."] = "再生が無効になりました (%s)。ABX セッションを終了しました。",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "外部での EQ 変更を検出しました。設定を保護するためテストを終了しました。",
        ["Invalid session mode; ABX session ended."] = "無効なモードです。ABX セッションを終了しました。",
        ["Readiness lost before vote (%s); ABX session ended."] = "投票前に準備状態が解除されました (%s)。セッションを終了しました。",
        ["Playback invalid before vote (%s); ABX session ended."] = "投票前に再生が無効になりました (%s)。セッションを終了しました。",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "投票前に EQ 変更を検出しました。設定を保護するためテストを終了しました。",
        ["Invalid mode before vote; ABX session ended."] = "投票前に無効なモードになりました。セッションを終了しました。",
        ["Audition failed for next trial; session ended."] = "次の試行の試聴に失敗しました。セッションを終了しました。",
        ["Vote recorded. Starting Trial %d of %d"] = "投票を記録しました。試行 %d / %d を開始します",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "テスト完了！ スコア: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "再生準備ができていません (%s)。セッションを終了しました。",
        ["Profile B not loaded; cannot restart EQ test."] = "プロファイル B が読み込まれていないため再開できません。",
        ["No test mode configured; cannot restart."] = "テストモードが未設定のため再開できません。",
        ["Audition failed on restart; session ended."] = "再開時の試聴に失敗しました。セッションを終了しました。",
        ["ABX Session restarted"] = "ABX セッションを再開しました",
        ["Parent folder"] = "親フォルダ",
        ["No matching files here (%s)"] = "一致するファイルがありません (%s)",
        ["Select File"] = "ファイルを選択",
        ["Audio File ABX Test..."] = "音声ファイル ABX テスト...",
        ["Equalizer Profile ABX Test..."] = "EQ プロファイル ABX テスト...",
        ["Trials Per Session: %d"] = "セッションあたりの試行回数: %d",
        ["Trials set to %d"] = "試行回数を %d 回に設定しました",
        ["About ABX Blind Test"] = "ABX ブラインドテストについて",
        ["Blind ABX listener evaluation tool with randomized X."] = "ランダムな X を用いた ABX ブラインド試聴テストツールです。",
        ["In each trial, sample X is randomly assigned to source A or B."] = "各試行で、サンプル X は A または B にランダムに割り当てられます。",
        ["Audition A, B, and X, then select your vote."] = "A、B、X を試聴し、X がどちらか投票してください。",
        ["File mode uses native gapless switching with shared DSP."] = "ファイルモードは共通 DSP によるギャップレス切替を使用します。",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "16-bit FLAC/PCM および条件の一致するローカル MP3 に対応しています。",
        ["EQ profile switching cannot guarantee click-free live updates."] = "EQ プロファイルの切替時にはクリック音が入る場合があります。",
        ["Calculates exact binomial probability (p-value) upon completion."] = "完了時に正確な二項確率 (p値) を計算します。",
        ["(None Playing)"] = "(再生なし)",
        ["(Not Selected)"] = "(未選択)",
        ["Status: Idle"] = "状態: 待機中",
        ["Status: Preparing... (Tap to Cancel)"] = "状態: 準備中... (タップでキャンセル)",
        ["Status: Ready (Matched)"] = "状態: 準備完了 (一致)",
        ["Main menu"] = "メインメニュー",
        ["Track A: %s"] = "トラック A: %s",
        ["None"] = "なし",
        ["Track B: %s"] = "トラック B: %s",
        ["Selected: %s"] = "選択済み: %s",
        ["Select Track B (File Browser)..."] = "トラック B を選択 (ファイルブラウザ)...",
        ["Enter Track B Path (Text)..."] = "トラック B のパスを入力 (テキスト)...",
        ["Enter Track B Path"] = "トラック B のパスを入力",
        ["Invalid path: %s"] = "無効なパス: %s",
        ["Prepare Comparison"] = "比較を準備",
        ["Cancel Preparation"] = "準備をキャンセル",
        ["Start ABX File Test"] = "ABX ファイルテストを開始",
        ["Track B is not ready yet"] = "トラック B の準備がまだできていません",
        ["Not ready: %s"] = "準備未完了: %s",
        ["Audition failed on start"] = "開始時の試聴に失敗しました",
        ["Clear Comparison"] = "比較をクリア",
        ["Comparison cleared"] = "比較をクリアしました",
        ["Notice: PEQ updates are not click-free"] = "注意: PEQ の切替時にはノイズが入る場合があります",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "PEQ プロファイルの係数更新ではクリック音のない切替を保証できません。",
        ["Profile A: %s"] = "プロファイル A: %s",
        ["Profile B: %s"] = "プロファイル B: %s",
        ["Use Current EQ as Profile A"] = "現在の EQ をプロファイル A として使用",
        ["Captured Current EQ as Profile A"] = "現在の EQ をプロファイル A に設定しました",
        ["Load .peq for Profile B..."] = "プロファイル B 用の .peq を読み込む...",
        ["Invalid Profile Path: %s"] = "無効なプロファイルパス: %s",
        ["Loaded %s transiently"] = "%s を一時的に読み込みました",
        ["Failed to load .peq profile"] = ".peq プロファイルの読み込みに失敗しました",
        ["Start ABX EQ Test"] = "ABX EQ テストを開始",
        ["Player lacks audio.peq.state capability"] = "プレーヤーが audio.peq.state に対応していません",
        ["EQ state query unavailable"] = "EQ 状態を取得できません",
        ["Playback not ready: %s"] = "再生準備未完了: %s",
        ["Could not read baseline EQ"] = "基準 EQ を読み取れませんでした",
        ["Please load Profile B first"] = "先にプロファイル B を読み込んでください",
        ["About EQ Comparisons"] = "EQ 比較について",
        ["About EQ ABX Test"] = "EQ ABX テストについて",
        ["Loads .peq profiles transiently (without flash persistence)."] = ".peq プロファイルを一時的に読み込みます（保存はしません）。",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "ハードウェア制限により、EQ 更新時にクリック音が入る場合があります。",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "テスト完了または中止時に元の EQ 設定を復元します。",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "テスト中に外部から EQ を変更すると、調整を保護するためテストを中断します。",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "トーン調整はラウドネス補正されず、ビットパーフェクトではありません。",
        ["Trial %d of %d"] = "試行 %d / %d",
        ["Auditioning %s"] = "%s を試聴中",
        ["Sample A"] = "サンプル A",
        ["Sample B"] = "サンプル B",
        ["Sample X (Hidden)"] = "サンプル X (ブラインド)",
        ["Sample X"] = "サンプル X",
        ["Vote: X is A"] = "投票: X は A",
        ["Vote: X is B"] = "投票: X は B",
        ["Final Score: %d/%d (%.1f%%)"] = "最終スコア: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "p値: %.4f (%s)",
        ["Significant"] = "有意差あり",
        ["Inconclusive"] = "判定不能",
        ["Restart Test"] = "テストをやり直す",
        ["Exit ABX Session"] = "ABX セッションを終了",
        ["ABX Session ended"] = "ABX セッションを終了しました",
        ["Playback interrupted; ABX session ended."] = "再生が中断されたため、ABX セッションを終了しました。",
    },
    nl = {
        ["ABX Blind Test"] = "ABX-blindtest",
        ["Baseline EQ"] = "Basis-EQ",
        ["Profile B"] = "Profiel B",
        ["Current Snapshot"] = "Huidige opname",
        ["Path must be a non-empty string"] = "Pad mag niet leeg zijn",
        ["Network URLs are not supported for local comparison"] = "Netwerk-URL's worden niet ondersteund voor lokale vergelijking",
        ["Path traversal ('..') is not permitted"] = "Padoverschrijding ('..') is niet toegestaan",
        ["Path must be located inside the SD card (%s)"] = "Pad moet op de SD-kaart staan (%s)",
        ["playback paused or stopped"] = "afspelen gepauzeerd of gestopt",
        ["native switch not ready"] = "native schakelaar niet gereed",
        ["playback format unavailable"] = "afspeelformaat niet beschikbaar",
        ["track restarted or changed"] = "nummer herstart of gewijzigd",
        ["track path changed"] = "nummerpad gewijzigd",
        ["playback speed must be 1.0x (currently %s)"] = "afspeelsnelheid moet 1.0x zijn (nu %s)",
        ["unknown"] = "onbekend",
        ["crossfade enabled"] = "crossfade ingeschakeld",
        ["stream/dsd source"] = "stream-/DSD-bron",
        ["track duration not positive and finite"] = "duur van nummer niet positief en eindig",
        ["streaming audio not supported"] = "streamingaudio niet ondersteund",
        ["track duration not finite or positive"] = "duur van nummer niet eindig of positief",
        ["track playback generation changed"] = "afspeelgeneratie gewijzigd",
        ["Player lacks playback.ab_switch capability"] = "Speler mist playback.ab_switch-ondersteuning",
        ["Primary track must be currently playing"] = "Hoofdnummer moet momenteel afspelen",
        ["Playback format query unavailable"] = "Opvragen afspeelformaat niet beschikbaar",
        ["No active audio format"] = "Geen actief audioformaat",
        ["Stream playback cannot be used for comparison"] = "Streams kunnen niet worden gebruikt voor vergelijking",
        ["DSD tracks cannot be used for AB switch"] = "DSD-nummers kunnen niet worden gebruikt voor AB-schakelaar",
        ["Playback speed must be 1.0x"] = "Afspeelsnelheid moet 1.0x zijn",
        ["Crossfade must be disabled in Sound settings"] = "Crossfade moet zijn uitgeschakeld in de geluidsinstellingen",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Codec (%s, %d-bit) niet ondersteund: vereist 16-bit FLAC/PCM of MP3",
        ["Comparison preparation cancelled"] = "Voorbereiding van vergelijking geannuleerd",
        ["Alternate track ready for ABX test!"] = "Alternatief nummer klaar voor ABX-test!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Voorbereiding geweigerd: samplerate, kanalen of aantal frames komen niet overeen",
        ["Preparation timed out (5m)"] = "Voorbereiding verlopen (5m)",
        ["Timer slot limit reached; cannot poll preparation"] = "Timerlimiet bereikt; kan voorbereiding niet volgen",
        ["Invalid Track B: %s"] = "Ongeldig nummer B: %s",
        ["No active track path found"] = "Geen actief nummerpad gevonden",
        ["Player lacks prepare_ab_switch API"] = "Speler mist prepare_ab_switch-API",
        ["Audio engine rejected comparison preparation"] = "Audio-engine weigerde voorbereiding van vergelijking",
        ["Preparing alternate file..."] = "Alternatief bestand voorbereiden...",
        ["Readiness lost (%s); ABX session ended."] = "Gereedheid verloren (%s); ABX-sessie beëindigd.",
        ["Native switch selection failed; ABX session ended."] = "Omschakelen mislukt; ABX-sessie beëindigd.",
        ["Playback invalid (%s); ABX session ended."] = "Afspelen ongeldig (%s); ABX-sessie beëindigd.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Externe EQ-wijziging gedetecteerd; proef beëindigd om je instellingen te behouden.",
        ["Invalid session mode; ABX session ended."] = "Ongeldige sessiemodus; ABX-sessie beëindigd.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Gereedheid verloren vóór stem (%s); ABX-sessie beëindigd.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Afspelen ongeldig vóór stem (%s); ABX-sessie beëindigd.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Externe EQ-wijziging vóór stem gedetecteerd; proef beëindigd om je instellingen te behouden.",
        ["Invalid mode before vote; ABX session ended."] = "Ongeldige modus vóór stem; ABX-sessie beëindigd.",
        ["Audition failed for next trial; session ended."] = "Beluisteren voor volgende ronde mislukt; sessie beëindigd.",
        ["Vote recorded. Starting Trial %d of %d"] = "Stem opgeslagen. Ronde %d van %d start",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Test voltooid! Score: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Afspelen niet gereed (%s); ABX-sessie beëindigd.",
        ["Profile B not loaded; cannot restart EQ test."] = "Profiel B niet geladen; kan EQ-test niet herstarten.",
        ["No test mode configured; cannot restart."] = "Geen testmodus ingesteld; kan niet herstarten.",
        ["Audition failed on restart; session ended."] = "Beluisteren bij herstart mislukt; sessie beëindigd.",
        ["ABX Session restarted"] = "ABX-sessie herstart",
        ["Parent folder"] = "Bovenliggende map",
        ["No matching files here (%s)"] = "Geen overeenkomende bestanden hier (%s)",
        ["Select File"] = "Bestand selecteren",
        ["Audio File ABX Test..."] = "Audiobestand ABX-test...",
        ["Equalizer Profile ABX Test..."] = "EQ-profiel ABX-test...",
        ["Trials Per Session: %d"] = "Rondes per sessie: %d",
        ["Trials set to %d"] = "Rondes ingesteld op %d",
        ["About ABX Blind Test"] = "Over ABX-blindtest",
        ["Blind ABX listener evaluation tool with randomized X."] = "Blinde ABX-luistertest met willekeurige X.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "In elke ronde wordt fragment X willekeurig toegewezen aan bron A of B.",
        ["Audition A, B, and X, then select your vote."] = "Beluister A, B en X en breng daarna je stem uit.",
        ["File mode uses native gapless switching with shared DSP."] = "Bestandsmodus gebruikt naadloos schakelen met gedeelde DSP.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Ondersteunt 16-bit FLAC/PCM en overeenkomende lokale MP3-bestanden.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "Wisselen van EQ-profiel kan niet altijd zonder klikgeluid.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Berekent na afloop de exacte binomiale waarschijnlijkheid (p-waarde).",
        ["(None Playing)"] = "(Niets speelt)",
        ["(Not Selected)"] = "(Niet geselecteerd)",
        ["Status: Idle"] = "Status: Inactief",
        ["Status: Preparing... (Tap to Cancel)"] = "Status: Voorbereiden... (Tik om te annuleren)",
        ["Status: Ready (Matched)"] = "Status: Gereed (Overeenkomend)",
        ["Main menu"] = "Hoofdmenu",
        ["Track A: %s"] = "Nummer A: %s",
        ["None"] = "Geen",
        ["Track B: %s"] = "Nummer B: %s",
        ["Selected: %s"] = "Geselecteerd: %s",
        ["Select Track B (File Browser)..."] = "Selecteer nummer B (Bestandsbrowser)...",
        ["Enter Track B Path (Text)..."] = "Voer pad nummer B in (Tekst)...",
        ["Enter Track B Path"] = "Voer pad nummer B in",
        ["Invalid path: %s"] = "Ongeldig pad: %s",
        ["Prepare Comparison"] = "Vergelijking voorbereiden",
        ["Cancel Preparation"] = "Voorbereiding annuleren",
        ["Start ABX File Test"] = "Start ABX-bestandstest",
        ["Track B is not ready yet"] = "Nummer B is nog niet gereed",
        ["Not ready: %s"] = "Niet gereed: %s",
        ["Audition failed on start"] = "Beluisteren bij start mislukt",
        ["Clear Comparison"] = "Vergelijking wissen",
        ["Comparison cleared"] = "Vergelijking gewist",
        ["Notice: PEQ updates are not click-free"] = "Let op: PEQ-wissels zijn niet klikvrij",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "Het bijwerken van PEQ-coëfficiënten kan klikvrij schakelen niet garanderen.",
        ["Profile A: %s"] = "Profiel A: %s",
        ["Profile B: %s"] = "Profiel B: %s",
        ["Use Current EQ as Profile A"] = "Huidige EQ als Profiel A gebruiken",
        ["Captured Current EQ as Profile A"] = "Huidige EQ vastgelegd als Profiel A",
        ["Load .peq for Profile B..."] = "Laad .peq voor Profiel B...",
        ["Invalid Profile Path: %s"] = "Ongeldig profielpad: %s",
        ["Loaded %s transiently"] = "%s tijdelijk geladen",
        ["Failed to load .peq profile"] = "Laden van .peq-profiel mislukt",
        ["Start ABX EQ Test"] = "Start ABX-EQ-test",
        ["Player lacks audio.peq.state capability"] = "Speler mist audio.peq.state-ondersteuning",
        ["EQ state query unavailable"] = "Opvragen EQ-status niet beschikbaar",
        ["Playback not ready: %s"] = "Afspelen niet gereed: %s",
        ["Could not read baseline EQ"] = "Kon basis-EQ niet lezen",
        ["Please load Profile B first"] = "Laad eerst Profiel B",
        ["About EQ Comparisons"] = "Over EQ-vergelijkingen",
        ["About EQ ABX Test"] = "Over de EQ-ABX-test",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Laadt .peq-profielen tijdelijk (zonder opslag in geheugen).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Hardwarebeperking: EQ-wissels zijn niet gegarandeerd klikvrij.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Herstelt de basis-EQ na afloop of annulering van de test.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "Als externe EQ-regelaars tijdens een ronde worden aangepast, stopt de sessie om je wijzigingen te behouden.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Toonregelingen zijn niet qua luidheid gelijkgetrokken en niet bit-perfect.",
        ["Trial %d of %d"] = "Ronde %d van %d",
        ["Auditioning %s"] = "Beluisteren: %s",
        ["Sample A"] = "Fragment A",
        ["Sample B"] = "Fragment B",
        ["Sample X (Hidden)"] = "Fragment X (Verborgen)",
        ["Sample X"] = "Fragment X",
        ["Vote: X is A"] = "Stem: X is A",
        ["Vote: X is B"] = "Stem: X is B",
        ["Final Score: %d/%d (%.1f%%)"] = "Eindscore: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "p-waarde: %.4f (%s)",
        ["Significant"] = "Significant",
        ["Inconclusive"] = "Onbeslist",
        ["Restart Test"] = "Test herstarten",
        ["Exit ABX Session"] = "ABX-sessie verlaten",
        ["ABX Session ended"] = "ABX-sessie beëindigd",
        ["Playback interrupted; ABX session ended."] = "Afspelen onderbroken; ABX-sessie beëindigd.",
    },
    pt = {
        ["ABX Blind Test"] = "Teste cego ABX",
        ["Baseline EQ"] = "EQ base",
        ["Profile B"] = "Perfil B",
        ["Current Snapshot"] = "Estado atual",
        ["Path must be a non-empty string"] = "O caminho não pode estar vazio",
        ["Network URLs are not supported for local comparison"] = "URLs de rede não são suportados para comparação local",
        ["Path traversal ('..') is not permitted"] = "Navegação de caminho ('..') não é permitida",
        ["Path must be located inside the SD card (%s)"] = "O caminho deve estar dentro do cartão SD (%s)",
        ["playback paused or stopped"] = "reprodução pausada ou parada",
        ["native switch not ready"] = "alternância nativa não está pronta",
        ["playback format unavailable"] = "formato de reprodução indisponível",
        ["track restarted or changed"] = "faixa reiniciada ou alterada",
        ["track path changed"] = "caminho da faixa alterado",
        ["playback speed must be 1.0x (currently %s)"] = "a velocidade deve ser 1.0x (atualmente %s)",
        ["unknown"] = "desconhecido",
        ["crossfade enabled"] = "crossfade ativado",
        ["stream/dsd source"] = "fonte de stream/DSD",
        ["track duration not positive and finite"] = "duração da faixa não é positiva e finita",
        ["streaming audio not supported"] = "áudio de streaming não suportado",
        ["track duration not finite or positive"] = "duração da faixa não é finita ou positiva",
        ["track playback generation changed"] = "geração de reprodução alterada",
        ["Player lacks playback.ab_switch capability"] = "O reprodutor não possui o recurso playback.ab_switch",
        ["Primary track must be currently playing"] = "A faixa principal deve estar tocando",
        ["Playback format query unavailable"] = "Consulta de formato de reprodução indisponível",
        ["No active audio format"] = "Nenhum formato de áudio ativo",
        ["Stream playback cannot be used for comparison"] = "Streams não podem ser usados para comparação",
        ["DSD tracks cannot be used for AB switch"] = "Faixas DSD não podem ser usadas na alternância AB",
        ["Playback speed must be 1.0x"] = "A velocidade de reprodução deve ser 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "O crossfade deve ser desativado nas configurações de som",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Codec principal (%s, %d bits) não suportado: requer FLAC/PCM de 16 bits ou MP3",
        ["Comparison preparation cancelled"] = "Preparação da comparação cancelada",
        ["Alternate track ready for ABX test!"] = "Faixa alternativa pronta para o teste ABX!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Preparação recusada: taxa de amostragem, canais ou contagem de quadros diferentes",
        ["Preparation timed out (5m)"] = "Tempo de preparação esgotado (5m)",
        ["Timer slot limit reached; cannot poll preparation"] = "Limite de temporizadores atingido; não é possível verificar a preparação",
        ["Invalid Track B: %s"] = "Faixa B inválida: %s",
        ["No active track path found"] = "Nenhum caminho de faixa ativa encontrado",
        ["Player lacks prepare_ab_switch API"] = "O reprodutor não possui a API prepare_ab_switch",
        ["Audio engine rejected comparison preparation"] = "O motor de áudio recusou a preparação da comparação",
        ["Preparing alternate file..."] = "Preparando arquivo alternativo...",
        ["Readiness lost (%s); ABX session ended."] = "Prontidão perdida (%s); sessão ABX encerrada.",
        ["Native switch selection failed; ABX session ended."] = "Falha na alternância nativa; sessão ABX encerrada.",
        ["Playback invalid (%s); ABX session ended."] = "Reprodução inválida (%s); sessão ABX encerrada.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Alteração externa de EQ detectada; tentativa encerrada para preservar seus ajustes.",
        ["Invalid session mode; ABX session ended."] = "Modo de sessão inválido; sessão ABX encerrada.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Prontidão perdida antes do voto (%s); sessão ABX encerrada.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Reprodução inválida antes do voto (%s); sessão ABX encerrada.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Alteração externa de EQ antes do voto; tentativa encerrada para preservar seus ajustes.",
        ["Invalid mode before vote; ABX session ended."] = "Modo inválido antes do voto; sessão ABX encerrada.",
        ["Audition failed for next trial; session ended."] = "Falha na audição da próxima tentativa; sessão encerrada.",
        ["Vote recorded. Starting Trial %d of %d"] = "Voto registrado. Iniciando tentativa %d de %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Teste concluído! Pontuação: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Reprodução não está pronta (%s); sessão ABX encerrada.",
        ["Profile B not loaded; cannot restart EQ test."] = "Perfil B não carregado; não é possível reiniciar o teste de EQ.",
        ["No test mode configured; cannot restart."] = "Nenhum modo de teste configurado; não é possível reiniciar.",
        ["Audition failed on restart; session ended."] = "Falha na audição ao reiniciar; sessão encerrada.",
        ["ABX Session restarted"] = "Sessão ABX reiniciada",
        ["Parent folder"] = "Pasta superior",
        ["No matching files here (%s)"] = "Nenhum arquivo correspondente aqui (%s)",
        ["Select File"] = "Selecionar arquivo",
        ["Audio File ABX Test..."] = "Teste ABX de arquivo de áudio...",
        ["Equalizer Profile ABX Test..."] = "Teste ABX de perfil de EQ...",
        ["Trials Per Session: %d"] = "Tentativas por sessão: %d",
        ["Trials set to %d"] = "Tentativas definidas para %d",
        ["About ABX Blind Test"] = "Sobre o Teste cego ABX",
        ["Blind ABX listener evaluation tool with randomized X."] = "Ferramenta de avaliação auditiva cega ABX com X aleatório.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "Em cada tentativa, a amostra X é atribuída aleatoriamente à fonte A ou B.",
        ["Audition A, B, and X, then select your vote."] = "Ouça A, B e X e depois registre seu voto.",
        ["File mode uses native gapless switching with shared DSP."] = "O modo de arquivo usa alternância nativa sem pausas com DSP compartilhado.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Suporta FLAC/PCM de 16 bits e arquivos MP3 locais correspondentes.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "A troca de perfil EQ não garante atualizações ao vivo sem estalos.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Calcula a probabilidade binomial exata (valor p) ao concluir.",
        ["(None Playing)"] = "(Nada tocando)",
        ["(Not Selected)"] = "(Não selecionado)",
        ["Status: Idle"] = "Status: Inativo",
        ["Status: Preparing... (Tap to Cancel)"] = "Status: Preparando... (Toque para cancelar)",
        ["Status: Ready (Matched)"] = "Status: Pronto (Correspondente)",
        ["Main menu"] = "Menu principal",
        ["Track A: %s"] = "Faixa A: %s",
        ["None"] = "Nenhuma",
        ["Track B: %s"] = "Faixa B: %s",
        ["Selected: %s"] = "Selecionado: %s",
        ["Select Track B (File Browser)..."] = "Selecionar Faixa B (Navegador)...",
        ["Enter Track B Path (Text)..."] = "Digitar caminho da Faixa B (Texto)...",
        ["Enter Track B Path"] = "Digitar caminho da Faixa B",
        ["Invalid path: %s"] = "Caminho inválido: %s",
        ["Prepare Comparison"] = "Preparar comparação",
        ["Cancel Preparation"] = "Cancelar preparação",
        ["Start ABX File Test"] = "Iniciar teste ABX de arquivo",
        ["Track B is not ready yet"] = "A Faixa B ainda não está pronta",
        ["Not ready: %s"] = "Não está pronto: %s",
        ["Audition failed on start"] = "Falha na audição ao iniciar",
        ["Clear Comparison"] = "Limpar comparação",
        ["Comparison cleared"] = "Comparação limpa",
        ["Notice: PEQ updates are not click-free"] = "Aviso: trocas de PEQ podem causar estalos",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "A atualização dos coeficientes PEQ não garante alternância sem estalos.",
        ["Profile A: %s"] = "Perfil A: %s",
        ["Profile B: %s"] = "Perfil B: %s",
        ["Use Current EQ as Profile A"] = "Usar EQ atual como Perfil A",
        ["Captured Current EQ as Profile A"] = "EQ atual capturado como Perfil A",
        ["Load .peq for Profile B..."] = "Carregar .peq para o Perfil B...",
        ["Invalid Profile Path: %s"] = "Caminho de perfil inválido: %s",
        ["Loaded %s transiently"] = "%s carregado temporariamente",
        ["Failed to load .peq profile"] = "Falha ao carregar perfil .peq",
        ["Start ABX EQ Test"] = "Iniciar teste ABX de EQ",
        ["Player lacks audio.peq.state capability"] = "O reprodutor não possui o recurso audio.peq.state",
        ["EQ state query unavailable"] = "Consulta de estado do EQ indisponível",
        ["Playback not ready: %s"] = "Reprodução não está pronta: %s",
        ["Could not read baseline EQ"] = "Não foi possível ler o EQ base",
        ["Please load Profile B first"] = "Carregue o Perfil B primeiro",
        ["About EQ Comparisons"] = "Sobre comparações de EQ",
        ["About EQ ABX Test"] = "Sobre o teste ABX de EQ",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Carrega perfis .peq temporariamente (sem salvar na memória).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Limitação de hardware: alterações de EQ não garantem troca sem estalos.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Restaura o EQ base ao concluir ou cancelar o teste.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "Se os controles externos de EQ forem alterados durante o teste, a sessão é encerrada para preservar seus ajustes.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Os ajustes de tom não têm volume compensado nem são bit-perfect.",
        ["Trial %d of %d"] = "Tentativa %d de %d",
        ["Auditioning %s"] = "Ouvindo %s",
        ["Sample A"] = "Amostra A",
        ["Sample B"] = "Amostra B",
        ["Sample X (Hidden)"] = "Amostra X (Oculta)",
        ["Sample X"] = "Amostra X",
        ["Vote: X is A"] = "Votar: X é A",
        ["Vote: X is B"] = "Votar: X é B",
        ["Final Score: %d/%d (%.1f%%)"] = "Pontuação final: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "valor p: %.4f (%s)",
        ["Significant"] = "Significativo",
        ["Inconclusive"] = "Inconclusivo",
        ["Restart Test"] = "Reiniciar teste",
        ["Exit ABX Session"] = "Sair da sessão ABX",
        ["ABX Session ended"] = "Sessão ABX encerrada",
        ["Playback interrupted; ABX session ended."] = "Reprodução interrompida; sessão ABX encerrada.",
    },
    ru = {
        ["ABX Blind Test"] = "Слепой тест ABX",
        ["Baseline EQ"] = "Базовый EQ",
        ["Profile B"] = "Профиль B",
        ["Current Snapshot"] = "Текущий снимок",
        ["Path must be a non-empty string"] = "Путь не может быть пустым",
        ["Network URLs are not supported for local comparison"] = "Сетевые URL не поддерживаются для локального сравнения",
        ["Path traversal ('..') is not permitted"] = "Переход '..' в пути запрещён",
        ["Path must be located inside the SD card (%s)"] = "Путь должен находиться на SD-карте (%s)",
        ["playback paused or stopped"] = "воспроизведение на паузе или остановлено",
        ["native switch not ready"] = "переключатель не готов",
        ["playback format unavailable"] = "формат воспроизведения недоступен",
        ["track restarted or changed"] = "трек перезапущен или изменён",
        ["track path changed"] = "путь к треку изменился",
        ["playback speed must be 1.0x (currently %s)"] = "скорость должна быть 1.0x (сейчас %s)",
        ["unknown"] = "неизвестно",
        ["crossfade enabled"] = "кроссфейд включён",
        ["stream/dsd source"] = "поток или источник DSD",
        ["track duration not positive and finite"] = "длительность трека некорректна",
        ["streaming audio not supported"] = "потоковое аудио не поддерживается",
        ["track duration not finite or positive"] = "длительность трека некорректна",
        ["track playback generation changed"] = "поколение воспроизведения изменилось",
        ["Player lacks playback.ab_switch capability"] = "Плеер не поддерживает playback.ab_switch",
        ["Primary track must be currently playing"] = "Основной трек должен воспроизводиться",
        ["Playback format query unavailable"] = "Запрос формата воспроизведения недоступен",
        ["No active audio format"] = "Нет активного аудиоформата",
        ["Stream playback cannot be used for comparison"] = "Потоки нельзя использовать для сравнения",
        ["DSD tracks cannot be used for AB switch"] = "Треки DSD нельзя использовать для переключения AB",
        ["Playback speed must be 1.0x"] = "Скорость воспроизведения должна быть 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "Отключите кроссфейд в настройках звука",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Кодек (%s, %d бит) не поддерживается: нужен 16-бит FLAC/PCM или MP3",
        ["Comparison preparation cancelled"] = "Подготовка сравнения отменена",
        ["Alternate track ready for ABX test!"] = "Второй трек готов к тесту ABX!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Подготовка отклонена: не совпадают частота, каналы или число фреймов",
        ["Preparation timed out (5m)"] = "Время подготовки истекло (5 мин)",
        ["Timer slot limit reached; cannot poll preparation"] = "Лимит таймеров исчерпан; опрос невозможен",
        ["Invalid Track B: %s"] = "Некорректный трек B: %s",
        ["No active track path found"] = "Путь активного трека не найден",
        ["Player lacks prepare_ab_switch API"] = "Плеер не поддерживает prepare_ab_switch",
        ["Audio engine rejected comparison preparation"] = "Аудиодвижок отклонил подготовку сравнения",
        ["Preparing alternate file..."] = "Подготовка второго файла...",
        ["Readiness lost (%s); ABX session ended."] = "Готовность потеряна (%s); сессия ABX завершена.",
        ["Native switch selection failed; ABX session ended."] = "Ошибка переключения; сессия ABX завершена.",
        ["Playback invalid (%s); ABX session ended."] = "Некорректное воспроизведение (%s); сессия ABX завершена.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Обнаружено внешнее изменение EQ; тест завершён для сохранения ваших настроек.",
        ["Invalid session mode; ABX session ended."] = "Некорректный режим; сессия ABX завершена.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Готовность потеряна перед голосованием (%s); сессия ABX завершена.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Воспроизведение нарушено перед голосованием (%s); сессия ABX завершена.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Обнаружено изменение EQ перед голосованием; тест завершён для сохранения ваших настроек.",
        ["Invalid mode before vote; ABX session ended."] = "Некорректный режим перед голосованием; сессия ABX завершена.",
        ["Audition failed for next trial; session ended."] = "Ошибка прослушивания для следующей попытки; сессия завершена.",
        ["Vote recorded. Starting Trial %d of %d"] = "Голос учтён. Попытка %d из %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Тест завершён! Результат: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Воспроизведение не готово (%s); сессия ABX завершена.",
        ["Profile B not loaded; cannot restart EQ test."] = "Профиль B не загружен; перезапуск невозможен.",
        ["No test mode configured; cannot restart."] = "Режим теста не выбран; перезапуск невозможен.",
        ["Audition failed on restart; session ended."] = "Ошибка прослушивания при перезапуске; сессия завершена.",
        ["ABX Session restarted"] = "Сессия ABX перезапущена",
        ["Parent folder"] = "Родительская папка",
        ["No matching files here (%s)"] = "Здесь нет подходящих файлов (%s)",
        ["Select File"] = "Выберите файл",
        ["Audio File ABX Test..."] = "Тест ABX аудиофайлов...",
        ["Equalizer Profile ABX Test..."] = "Тест ABX профилей EQ...",
        ["Trials Per Session: %d"] = "Попыток за сессию: %d",
        ["Trials set to %d"] = "Число попыток: %d",
        ["About ABX Blind Test"] = "О слепом тесте ABX",
        ["Blind ABX listener evaluation tool with randomized X."] = "Инструмент слепого тестирования ABX со случайным выбором X.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "В каждой попытке образец X случайно назначается источнику A или B.",
        ["Audition A, B, and X, then select your vote."] = "Прослушайте A, B и X, затем проголосуйте.",
        ["File mode uses native gapless switching with shared DSP."] = "Режим файлов использует бесшовное переключение с общим DSP.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Поддерживает 16-бит FLAC/PCM и совпадающие локальные файлы MP3.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "Переключение профилей EQ не гарантирует отсутствие щелчков.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "По окончании вычисляет точную биномиальную вероятность (p-значение).",
        ["(None Playing)"] = "(Ничего не играет)",
        ["(Not Selected)"] = "(Не выбрано)",
        ["Status: Idle"] = "Статус: Ожидание",
        ["Status: Preparing... (Tap to Cancel)"] = "Статус: Подготовка... (Нажмите для отмены)",
        ["Status: Ready (Matched)"] = "Статус: Готово (Совпадает)",
        ["Main menu"] = "Главное меню",
        ["Track A: %s"] = "Трек A: %s",
        ["None"] = "Нет",
        ["Track B: %s"] = "Трек B: %s",
        ["Selected: %s"] = "Выбрано: %s",
        ["Select Track B (File Browser)..."] = "Выбрать трек B (Обзор файлов)...",
        ["Enter Track B Path (Text)..."] = "Ввести путь к треку B (Текст)...",
        ["Enter Track B Path"] = "Введите путь к треку B",
        ["Invalid path: %s"] = "Некорректный путь: %s",
        ["Prepare Comparison"] = "Подготовить сравнение",
        ["Cancel Preparation"] = "Отменить подготовку",
        ["Start ABX File Test"] = "Начать тест ABX файлов",
        ["Track B is not ready yet"] = "Трек B ещё не готов",
        ["Not ready: %s"] = "Не готово: %s",
        ["Audition failed on start"] = "Ошибка прослушивания при запуске",
        ["Clear Comparison"] = "Очистить сравнение",
        ["Comparison cleared"] = "Сравнение очищено",
        ["Notice: PEQ updates are not click-free"] = "Внимание: переключение PEQ может щёлкать",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "Обновление коэффициентов PEQ не гарантирует переключение без щелчков.",
        ["Profile A: %s"] = "Профиль A: %s",
        ["Profile B: %s"] = "Профиль B: %s",
        ["Use Current EQ as Profile A"] = "Использовать текущий EQ как Профиль A",
        ["Captured Current EQ as Profile A"] = "Текущий EQ сохранён как Профиль A",
        ["Load .peq for Profile B..."] = "Загрузить .peq для Профиля B...",
        ["Invalid Profile Path: %s"] = "Некорректный путь к профилю: %s",
        ["Loaded %s transiently"] = "Временно загружен %s",
        ["Failed to load .peq profile"] = "Не удалось загрузить профиль .peq",
        ["Start ABX EQ Test"] = "Начать тест ABX EQ",
        ["Player lacks audio.peq.state capability"] = "Плеер не поддерживает audio.peq.state",
        ["EQ state query unavailable"] = "Запрос состояния EQ недоступен",
        ["Playback not ready: %s"] = "Воспроизведение не готово: %s",
        ["Could not read baseline EQ"] = "Не удалось прочитать базовый EQ",
        ["Please load Profile B first"] = "Сначала загрузите Профиль B",
        ["About EQ Comparisons"] = "О сравнении EQ",
        ["About EQ ABX Test"] = "О тесте ABX для EQ",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Загружает профили .peq временно (без сохранения в память).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Ограничение железа: смена EQ может сопровождаться щелчком.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Восстанавливает исходный EQ после завершения или отмены теста.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "При внешнем изменении EQ во время теста сессия прерывается для сохранения ваших настроек.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Настройки тембра не выровнены по громкости и не являются bit-perfect.",
        ["Trial %d of %d"] = "Попытка %d из %d",
        ["Auditioning %s"] = "Прослушивание: %s",
        ["Sample A"] = "Образец A",
        ["Sample B"] = "Образец B",
        ["Sample X (Hidden)"] = "Образец X (Скрытый)",
        ["Sample X"] = "Образец X",
        ["Vote: X is A"] = "Голос: X — это A",
        ["Vote: X is B"] = "Голос: X — это B",
        ["Final Score: %d/%d (%.1f%%)"] = "Итог: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "p-значение: %.4f (%s)",
        ["Significant"] = "Значимо",
        ["Inconclusive"] = "Неопределённо",
        ["Restart Test"] = "Перезапустить тест",
        ["Exit ABX Session"] = "Выйти из сессии ABX",
        ["ABX Session ended"] = "Сессия ABX завершена",
        ["Playback interrupted; ABX session ended."] = "Воспроизведение прервано; сессия ABX завершена.",
    },
    uk = {
        ["ABX Blind Test"] = "Сліпий тест ABX",
        ["Baseline EQ"] = "Базовий EQ",
        ["Profile B"] = "Профіль B",
        ["Current Snapshot"] = "Поточний знімок",
        ["Path must be a non-empty string"] = "Шлях не може бути порожнім",
        ["Network URLs are not supported for local comparison"] = "Мережеві URL не підтримуються для локального порівняння",
        ["Path traversal ('..') is not permitted"] = "Перехід '..' у шляху заборонено",
        ["Path must be located inside the SD card (%s)"] = "Шлях має бути на SD-карті (%s)",
        ["playback paused or stopped"] = "відтворення призупинено або зупинено",
        ["native switch not ready"] = "перемикач не готовий",
        ["playback format unavailable"] = "формат відтворення недоступний",
        ["track restarted or changed"] = "трек перезапущено або змінено",
        ["track path changed"] = "шлях до треку змінився",
        ["playback speed must be 1.0x (currently %s)"] = "швидкість має бути 1.0x (зараз %s)",
        ["unknown"] = "невідомо",
        ["crossfade enabled"] = "кросфейд увімкнено",
        ["stream/dsd source"] = "потік або джерело DSD",
        ["track duration not positive and finite"] = "тривалість треку некоректна",
        ["streaming audio not supported"] = "потокове аудіо не підтримується",
        ["track duration not finite or positive"] = "тривалість треку некоректна",
        ["track playback generation changed"] = "покоління відтворення змінилося",
        ["Player lacks playback.ab_switch capability"] = "Плеєр не підтримує playback.ab_switch",
        ["Primary track must be currently playing"] = "Основний трек має відтворюватися",
        ["Playback format query unavailable"] = "Запит формату відтворення недоступний",
        ["No active audio format"] = "Немає активного аудіоформату",
        ["Stream playback cannot be used for comparison"] = "Потоки не можна використовувати для порівняння",
        ["DSD tracks cannot be used for AB switch"] = "Треки DSD не можна використовувати для перемикання AB",
        ["Playback speed must be 1.0x"] = "Швидкість відтворення має бути 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "Вимкніть кросфейд у налаштуваннях звуку",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Кодек (%s, %d біт) не підтримується: потрібен 16-біт FLAC/PCM або MP3",
        ["Comparison preparation cancelled"] = "Підготовку порівняння скасовано",
        ["Alternate track ready for ABX test!"] = "Другий трек готовий до тесту ABX!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Підготовку відхилено: не збігаються частота, канали або кількість фреймів",
        ["Preparation timed out (5m)"] = "Час підготовки минув (5 хв)",
        ["Timer slot limit reached; cannot poll preparation"] = "Ліміт таймерів вичерпано; опитування неможливе",
        ["Invalid Track B: %s"] = "Некоректний трек B: %s",
        ["No active track path found"] = "Шлях активного треку не знайдено",
        ["Player lacks prepare_ab_switch API"] = "Плеєр не підтримує prepare_ab_switch",
        ["Audio engine rejected comparison preparation"] = "Аудіорушій відхилив підготовку порівняння",
        ["Preparing alternate file..."] = "Підготовка другого файлу...",
        ["Readiness lost (%s); ABX session ended."] = "Готовність втрачено (%s); сесію ABX завершено.",
        ["Native switch selection failed; ABX session ended."] = "Помилка перемикання; сесію ABX завершено.",
        ["Playback invalid (%s); ABX session ended."] = "Некоректне відтворення (%s); сесію ABX завершено.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Виявлено зовнішню зміну EQ; тест завершено для збереження ваших налаштувань.",
        ["Invalid session mode; ABX session ended."] = "Некоректний режим; сесію ABX завершено.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Готовність втрачено перед голосуванням (%s); сесію ABX завершено.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Відтворення порушено перед голосуванням (%s); сесію ABX завершено.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Виявлено зміну EQ перед голосуванням; тест завершено для збереження ваших налаштувань.",
        ["Invalid mode before vote; ABX session ended."] = "Некоректний режим перед голосуванням; сесію ABX завершено.",
        ["Audition failed for next trial; session ended."] = "Помилка прослуховування для наступної спроби; сесію завершено.",
        ["Vote recorded. Starting Trial %d of %d"] = "Голос враховано. Спроба %d з %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Тест завершено! Результат: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Відтворення не готове (%s); сесію ABX завершено.",
        ["Profile B not loaded; cannot restart EQ test."] = "Профіль B не завантажено; перезапуск неможливий.",
        ["No test mode configured; cannot restart."] = "Режим тесту не вибрано; перезапуск неможливий.",
        ["Audition failed on restart; session ended."] = "Помилка прослуховування під час перезапуску; сесію завершено.",
        ["ABX Session restarted"] = "Сесію ABX перезапущено",
        ["Parent folder"] = "Батьківська тека",
        ["No matching files here (%s)"] = "Тут немає відповідних файлів (%s)",
        ["Select File"] = "Виберіть файл",
        ["Audio File ABX Test..."] = "Тест ABX аудіофайлів...",
        ["Equalizer Profile ABX Test..."] = "Тест ABX профілів EQ...",
        ["Trials Per Session: %d"] = "Спроб за сесію: %d",
        ["Trials set to %d"] = "Кількість спроб: %d",
        ["About ABX Blind Test"] = "Про сліпий тест ABX",
        ["Blind ABX listener evaluation tool with randomized X."] = "Інструмент сліпого тестування ABX із випадковим вибором X.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "У кожній спробі зразок X випадково призначається джерелу A або B.",
        ["Audition A, B, and X, then select your vote."] = "Прослухайте A, B і X, а потім проголосуйте.",
        ["File mode uses native gapless switching with shared DSP."] = "Режим файлів використовує безшовне перемикання зі спільним DSP.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Підтримує 16-біт FLAC/PCM та відповідні локальні файли MP3.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "Перемикання профілів EQ не гарантує відсутності клацань.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Після завершення обчислює точну біноміальну ймовірність (p-значення).",
        ["(None Playing)"] = "(Нічого не грає)",
        ["(Not Selected)"] = "(Не вибрано)",
        ["Status: Idle"] = "Статус: Очікування",
        ["Status: Preparing... (Tap to Cancel)"] = "Статус: Підготовка... (Торкніться для скасування)",
        ["Status: Ready (Matched)"] = "Статус: Готово (Збігається)",
        ["Main menu"] = "Головне меню",
        ["Track A: %s"] = "Трек A: %s",
        ["None"] = "Немає",
        ["Track B: %s"] = "Трек B: %s",
        ["Selected: %s"] = "Вибрано: %s",
        ["Select Track B (File Browser)..."] = "Вибрати трек B (Огляд файлів)...",
        ["Enter Track B Path (Text)..."] = "Ввести шлях до треку B (Текст)...",
        ["Enter Track B Path"] = "Введіть шлях до треку B",
        ["Invalid path: %s"] = "Некоректний шлях: %s",
        ["Prepare Comparison"] = "Підготувати порівняння",
        ["Cancel Preparation"] = "Скасувати підготовку",
        ["Start ABX File Test"] = "Почати тест ABX файлів",
        ["Track B is not ready yet"] = "Трек B ще не готовий",
        ["Not ready: %s"] = "Не готово: %s",
        ["Audition failed on start"] = "Помилка прослуховування під час запуску",
        ["Clear Comparison"] = "Очистити порівняння",
        ["Comparison cleared"] = "Порівняння очищено",
        ["Notice: PEQ updates are not click-free"] = "Увага: перемикання PEQ може клацати",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "Оновлення коефіцієнтів PEQ не гарантує перемикання без клацань.",
        ["Profile A: %s"] = "Профіль A: %s",
        ["Profile B: %s"] = "Профіль B: %s",
        ["Use Current EQ as Profile A"] = "Використати поточний EQ як Профіль A",
        ["Captured Current EQ as Profile A"] = "Поточний EQ збережено як Профіль A",
        ["Load .peq for Profile B..."] = "Завантажити .peq для Профілю B...",
        ["Invalid Profile Path: %s"] = "Некоректний шлях до профілю: %s",
        ["Loaded %s transiently"] = "Тимчасово завантажено %s",
        ["Failed to load .peq profile"] = "Не вдалося завантажити профіль .peq",
        ["Start ABX EQ Test"] = "Почати тест ABX EQ",
        ["Player lacks audio.peq.state capability"] = "Плеєр не підтримує audio.peq.state",
        ["EQ state query unavailable"] = "Запит стану EQ недоступний",
        ["Playback not ready: %s"] = "Відтворення не готове: %s",
        ["Could not read baseline EQ"] = "Не вдалося прочитати базовий EQ",
        ["Please load Profile B first"] = "Спочатку завантажте Профіль B",
        ["About EQ Comparisons"] = "Про порівняння EQ",
        ["About EQ ABX Test"] = "Про тест ABX для EQ",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Завантажує профілі .peq тимчасово (без збереження в пам'ять).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Обмеження заліза: зміна EQ може супроводжуватися клацанням.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Відновлює початковий EQ після завершення або скасування тесту.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "У разі зовнішньої зміни EQ під час тесту сесія переривається для збереження ваших налаштувань.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Налаштування тембру не вирівняні за гучністю і не є bit-perfect.",
        ["Trial %d of %d"] = "Спроба %d з %d",
        ["Auditioning %s"] = "Прослуховування: %s",
        ["Sample A"] = "Зразок A",
        ["Sample B"] = "Зразок B",
        ["Sample X (Hidden)"] = "Зразок X (Прихований)",
        ["Sample X"] = "Зразок X",
        ["Vote: X is A"] = "Голос: X — це A",
        ["Vote: X is B"] = "Голос: X — це B",
        ["Final Score: %d/%d (%.1f%%)"] = "Підсумок: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "p-значення: %.4f (%s)",
        ["Significant"] = "Значуще",
        ["Inconclusive"] = "Невизначено",
        ["Restart Test"] = "Перезапустити тест",
        ["Exit ABX Session"] = "Вийти з сесії ABX",
        ["ABX Session ended"] = "Сесію ABX завершено",
        ["Playback interrupted; ABX session ended."] = "Відтворення перервано; сесію ABX завершено.",
    },
    vi = {
        ["ABX Blind Test"] = "Thử nghiệm mù ABX",
        ["Baseline EQ"] = "EQ gốc",
        ["Profile B"] = "Hồ sơ B",
        ["Current Snapshot"] = "Trạng thái hiện tại",
        ["Path must be a non-empty string"] = "Đường dẫn không được để trống",
        ["Network URLs are not supported for local comparison"] = "Không hỗ trợ URL mạng để so sánh nội bộ",
        ["Path traversal ('..') is not permitted"] = "Không cho phép '..' trong đường dẫn",
        ["Path must be located inside the SD card (%s)"] = "Đường dẫn phải nằm trong thẻ SD (%s)",
        ["playback paused or stopped"] = "đang tạm dừng hoặc đã dừng phát",
        ["native switch not ready"] = "bộ chuyển đổi gốc chưa sẵn sàng",
        ["playback format unavailable"] = "định dạng phát không khả dụng",
        ["track restarted or changed"] = "bài hát đã phát lại hoặc thay đổi",
        ["track path changed"] = "đường dẫn bài hát đã thay đổi",
        ["playback speed must be 1.0x (currently %s)"] = "tốc độ phát phải là 1.0x (hiện tại %s)",
        ["unknown"] = "không rõ",
        ["crossfade enabled"] = "đang bật chuyển bài mượt (crossfade)",
        ["stream/dsd source"] = "nguồn phát trực tuyến/DSD",
        ["track duration not positive and finite"] = "thời lượng bài hát không hợp lệ",
        ["streaming audio not supported"] = "không hỗ trợ âm thanh trực tuyến",
        ["track duration not finite or positive"] = "thời lượng bài hát không hợp lệ",
        ["track playback generation changed"] = "phiên phát đã thay đổi",
        ["Player lacks playback.ab_switch capability"] = "Trình phát không hỗ trợ playback.ab_switch",
        ["Primary track must be currently playing"] = "Bài hát chính phải đang được phát",
        ["Playback format query unavailable"] = "Không thể truy vấn định dạng phát",
        ["No active audio format"] = "Không có định dạng âm thanh đang hoạt động",
        ["Stream playback cannot be used for comparison"] = "Không thể dùng luồng phát trực tuyến để so sánh",
        ["DSD tracks cannot be used for AB switch"] = "Không thể dùng bài DSD cho chuyển đổi AB",
        ["Playback speed must be 1.0x"] = "Tốc độ phát phải là 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "Phải tắt Crossfade trong cài đặt Âm thanh",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "Codec chính (%s, %d-bit) không hỗ trợ: cần FLAC/PCM 16-bit hoặc MP3",
        ["Comparison preparation cancelled"] = "Đã hủy chuẩn bị so sánh",
        ["Alternate track ready for ABX test!"] = "Bài hát đối chiếu đã sẵn sàng cho bài thử ABX!",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "Chuẩn bị bị từ chối: tần số lấy mẫu, số kênh hoặc số khung không khớp",
        ["Preparation timed out (5m)"] = "Hết thời gian chuẩn bị (5 phút)",
        ["Timer slot limit reached; cannot poll preparation"] = "Đã đạt giới hạn bộ hẹn giờ; không thể kiểm tra chuẩn bị",
        ["Invalid Track B: %s"] = "Bài B không hợp lệ: %s",
        ["No active track path found"] = "Không tìm thấy đường dẫn bài đang phát",
        ["Player lacks prepare_ab_switch API"] = "Trình phát thiếu API prepare_ab_switch",
        ["Audio engine rejected comparison preparation"] = "Bộ xử lý âm thanh từ chối chuẩn bị so sánh",
        ["Preparing alternate file..."] = "Đang chuẩn bị tệp đối chiếu...",
        ["Readiness lost (%s); ABX session ended."] = "Mất trạng thái sẵn sàng (%s); đã kết thúc phiên ABX.",
        ["Native switch selection failed; ABX session ended."] = "Chuyển đổi gốc thất bại; đã kết thúc phiên ABX.",
        ["Playback invalid (%s); ABX session ended."] = "Phát không hợp lệ (%s); đã kết thúc phiên ABX.",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "Phát hiện thay đổi EQ bên ngoài; đã dừng thử nghiệm để giữ cài đặt của bạn.",
        ["Invalid session mode; ABX session ended."] = "Chế độ phiên không hợp lệ; đã kết thúc phiên ABX.",
        ["Readiness lost before vote (%s); ABX session ended."] = "Mất trạng thái sẵn sàng trước khi chọn (%s); đã kết thúc phiên ABX.",
        ["Playback invalid before vote (%s); ABX session ended."] = "Phát không hợp lệ trước khi chọn (%s); đã kết thúc phiên ABX.",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "Phát hiện thay đổi EQ trước khi chọn; đã dừng thử nghiệm để giữ cài đặt của bạn.",
        ["Invalid mode before vote; ABX session ended."] = "Chế độ không hợp lệ trước khi chọn; đã kết thúc phiên ABX.",
        ["Audition failed for next trial; session ended."] = "Nghe thử cho lượt tiếp theo thất bại; đã kết thúc phiên.",
        ["Vote recorded. Starting Trial %d of %d"] = "Đã ghi nhận. Bắt đầu lượt %d / %d",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "Hoàn tất! Điểm: %d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "Phát chưa sẵn sàng (%s); đã kết thúc phiên ABX.",
        ["Profile B not loaded; cannot restart EQ test."] = "Chưa tải Hồ sơ B; không thể khởi động lại bài thử EQ.",
        ["No test mode configured; cannot restart."] = "Chưa cấu hình chế độ thử; không thể khởi động lại.",
        ["Audition failed on restart; session ended."] = "Nghe thử khi khởi động lại thất bại; đã kết thúc phiên.",
        ["ABX Session restarted"] = "Đã khởi động lại phiên ABX",
        ["Parent folder"] = "Thư mục cha",
        ["No matching files here (%s)"] = "Không có tệp phù hợp ở đây (%s)",
        ["Select File"] = "Chọn tệp",
        ["Audio File ABX Test..."] = "Thử nghiệm ABX tệp âm thanh...",
        ["Equalizer Profile ABX Test..."] = "Thử nghiệm ABX hồ sơ EQ...",
        ["Trials Per Session: %d"] = "Số lượt mỗi phiên: %d",
        ["Trials set to %d"] = "Đã đặt số lượt thành %d",
        ["About ABX Blind Test"] = "Giới thiệu Thử nghiệm mù ABX",
        ["Blind ABX listener evaluation tool with randomized X."] = "Công cụ đánh giá nghe mù ABX với mẫu X ngẫu nhiên.",
        ["In each trial, sample X is randomly assigned to source A or B."] = "Trong mỗi lượt, mẫu X được gán ngẫu nhiên cho nguồn A hoặc B.",
        ["Audition A, B, and X, then select your vote."] = "Nghe thử A, B và X, sau đó đưa ra lựa chọn của bạn.",
        ["File mode uses native gapless switching with shared DSP."] = "Chế độ tệp dùng chuyển đổi không ngắt quãng với DSP dùng chung.",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "Hỗ trợ FLAC/PCM 16-bit và các tệp MP3 nội bộ khớp thông số.",
        ["EQ profile switching cannot guarantee click-free live updates."] = "Chuyển đổi hồ sơ EQ không đảm bảo hoàn toàn không có tiếng tách.",
        ["Calculates exact binomial probability (p-value) upon completion."] = "Tính xác suất nhị thức chính xác (giá trị p) khi hoàn thành.",
        ["(None Playing)"] = "(Không phát)",
        ["(Not Selected)"] = "(Chưa chọn)",
        ["Status: Idle"] = "Trạng thái: Chờ",
        ["Status: Preparing... (Tap to Cancel)"] = "Trạng thái: Đang chuẩn bị... (Chạm để hủy)",
        ["Status: Ready (Matched)"] = "Trạng thái: Sẵn sàng (Đã khớp)",
        ["Main menu"] = "Menu chính",
        ["Track A: %s"] = "Bài A: %s",
        ["None"] = "Không có",
        ["Track B: %s"] = "Bài B: %s",
        ["Selected: %s"] = "Đã chọn: %s",
        ["Select Track B (File Browser)..."] = "Chọn Bài B (Trình duyệt tệp)...",
        ["Enter Track B Path (Text)..."] = "Nhập đường dẫn Bài B (Văn bản)...",
        ["Enter Track B Path"] = "Nhập đường dẫn Bài B",
        ["Invalid path: %s"] = "Đường dẫn không hợp lệ: %s",
        ["Prepare Comparison"] = "Chuẩn bị so sánh",
        ["Cancel Preparation"] = "Hủy chuẩn bị",
        ["Start ABX File Test"] = "Bắt đầu thử ABX tệp",
        ["Track B is not ready yet"] = "Bài B chưa sẵn sàng",
        ["Not ready: %s"] = "Chưa sẵn sàng: %s",
        ["Audition failed on start"] = "Nghe thử thất bại khi bắt đầu",
        ["Clear Comparison"] = "Xóa so sánh",
        ["Comparison cleared"] = "Đã xóa so sánh",
        ["Notice: PEQ updates are not click-free"] = "Lưu ý: đổi PEQ có thể gây tiếng tách",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "Cập nhật hệ số hồ sơ PEQ không đảm bảo chuyển đổi không có tiếng tách.",
        ["Profile A: %s"] = "Hồ sơ A: %s",
        ["Profile B: %s"] = "Hồ sơ B: %s",
        ["Use Current EQ as Profile A"] = "Dùng EQ hiện tại làm Hồ sơ A",
        ["Captured Current EQ as Profile A"] = "Đã lưu EQ hiện tại làm Hồ sơ A",
        ["Load .peq for Profile B..."] = "Tải .peq cho Hồ sơ B...",
        ["Invalid Profile Path: %s"] = "Đường dẫn hồ sơ không hợp lệ: %s",
        ["Loaded %s transiently"] = "Đã tải tạm thời %s",
        ["Failed to load .peq profile"] = "Không tải được hồ sơ .peq",
        ["Start ABX EQ Test"] = "Bắt đầu thử ABX EQ",
        ["Player lacks audio.peq.state capability"] = "Trình phát không hỗ trợ audio.peq.state",
        ["EQ state query unavailable"] = "Không thể truy vấn trạng thái EQ",
        ["Playback not ready: %s"] = "Phát chưa sẵn sàng: %s",
        ["Could not read baseline EQ"] = "Không đọc được EQ gốc",
        ["Please load Profile B first"] = "Vui lòng tải Hồ sơ B trước",
        ["About EQ Comparisons"] = "Giới thiệu so sánh EQ",
        ["About EQ ABX Test"] = "Giới thiệu thử nghiệm ABX EQ",
        ["Loads .peq profiles transiently (without flash persistence)."] = "Tải hồ sơ .peq tạm thời (không lưu vào bộ nhớ).",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "Giới hạn phần cứng: cập nhật EQ không đảm bảo không có tiếng tách.",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "Khôi phục EQ gốc khi hoàn tất hoặc hủy bài thử.",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "Nếu chỉnh EQ bên ngoài trong lúc thử, phiên sẽ dừng để giữ các thay đổi của bạn.",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "Các tinh chỉnh âm sắc không cân bằng âm lượng và không bit-perfect.",
        ["Trial %d of %d"] = "Lượt %d / %d",
        ["Auditioning %s"] = "Đang nghe %s",
        ["Sample A"] = "Mẫu A",
        ["Sample B"] = "Mẫu B",
        ["Sample X (Hidden)"] = "Mẫu X (Ẩn)",
        ["Sample X"] = "Mẫu X",
        ["Vote: X is A"] = "Chọn: X là A",
        ["Vote: X is B"] = "Chọn: X là B",
        ["Final Score: %d/%d (%.1f%%)"] = "Điểm cuối: %d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "giá trị p: %.4f (%s)",
        ["Significant"] = "Có ý nghĩa",
        ["Inconclusive"] = "Chưa kết luận",
        ["Restart Test"] = "Thử lại từ đầu",
        ["Exit ABX Session"] = "Thoát phiên ABX",
        ["ABX Session ended"] = "Đã kết thúc phiên ABX",
        ["Playback interrupted; ABX session ended."] = "Phát bị gián đoạn; đã kết thúc phiên ABX.",
    },
    zh_CN = {
        ["ABX Blind Test"] = "ABX 盲听测试",
        ["Baseline EQ"] = "基准 EQ",
        ["Profile B"] = "配置 B",
        ["Current Snapshot"] = "当前快照",
        ["Path must be a non-empty string"] = "路径不能为空",
        ["Network URLs are not supported for local comparison"] = "本地对比不支持网络 URL",
        ["Path traversal ('..') is not permitted"] = "不允许路径跳转 ('..')",
        ["Path must be located inside the SD card (%s)"] = "路径必须位于 SD 卡内 (%s)",
        ["playback paused or stopped"] = "播放已暂停或停止",
        ["native switch not ready"] = "原生切换未就绪",
        ["playback format unavailable"] = "播放格式不可用",
        ["track restarted or changed"] = "曲目已重新开始或切换",
        ["track path changed"] = "曲目路径已更改",
        ["playback speed must be 1.0x (currently %s)"] = "播放速度必须为 1.0x（当前为 %s）",
        ["unknown"] = "未知",
        ["crossfade enabled"] = "已启用淡入淡出",
        ["stream/dsd source"] = "流媒体/DSD 音源",
        ["track duration not positive and finite"] = "曲目时长无效",
        ["streaming audio not supported"] = "不支持流媒体音频",
        ["track duration not finite or positive"] = "曲目时长无效",
        ["track playback generation changed"] = "播放状态已改变",
        ["Player lacks playback.ab_switch capability"] = "播放器不支持 playback.ab_switch",
        ["Primary track must be currently playing"] = "主曲目必须正在播放",
        ["Playback format query unavailable"] = "无法查询播放格式",
        ["No active audio format"] = "无活动音频格式",
        ["Stream playback cannot be used for comparison"] = "流媒体播放不能用于对比",
        ["DSD tracks cannot be used for AB switch"] = "DSD 曲目不能用于 AB 切换",
        ["Playback speed must be 1.0x"] = "播放速度必须为 1.0x",
        ["Crossfade must be disabled in Sound settings"] = "必须在声音设置中关闭淡入淡出",
        ["Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"] = "不支持主编码 (%s, %d-bit)：需要 16-bit FLAC/PCM 或 MP3",
        ["Comparison preparation cancelled"] = "已取消对比准备",
        ["Alternate track ready for ABX test!"] = "对比曲目已准备好进行 ABX 测试！",
        ["Preparation rejected: sample rate, channels, or frame counts mismatch"] = "准备被拒绝：采样率、声道或帧数不匹配",
        ["Preparation timed out (5m)"] = "准备超时（5分钟）",
        ["Timer slot limit reached; cannot poll preparation"] = "定时器已达上限；无法轮询准备状态",
        ["Invalid Track B: %s"] = "曲目 B 无效：%s",
        ["No active track path found"] = "未找到活动曲目路径",
        ["Player lacks prepare_ab_switch API"] = "播放器缺少 prepare_ab_switch 接口",
        ["Audio engine rejected comparison preparation"] = "音频引擎拒绝了对比准备",
        ["Preparing alternate file..."] = "正在准备对比文件...",
        ["Readiness lost (%s); ABX session ended."] = "就绪状态丢失 (%s)；ABX 会话已结束。",
        ["Native switch selection failed; ABX session ended."] = "原生切换失败；ABX 会话已结束。",
        ["Playback invalid (%s); ABX session ended."] = "播放无效 (%s)；ABX 会话已结束。",
        ["External EQ change detected; trial ended to preserve your custom settings."] = "检测到外部 EQ 更改；测试已结束以保留您的设置。",
        ["Invalid session mode; ABX session ended."] = "会话模式无效；ABX 会话已结束。",
        ["Readiness lost before vote (%s); ABX session ended."] = "投票前就绪状态丢失 (%s)；ABX 会话已结束。",
        ["Playback invalid before vote (%s); ABX session ended."] = "投票前播放无效 (%s)；ABX 会话已结束。",
        ["External EQ change detected before vote; trial ended to preserve your custom settings."] = "投票前检测到外部 EQ 更改；测试已结束以保留您的设置。",
        ["Invalid mode before vote; ABX session ended."] = "投票前模式无效；ABX 会话已结束。",
        ["Audition failed for next trial; session ended."] = "下一轮试听失败；会话已结束。",
        ["Vote recorded. Starting Trial %d of %d"] = "投票已记录。开始第 %d / %d 轮",
        ["Test Complete! Score: %d/%d (%.1f%%)"] = "测试完成！得分：%d/%d (%.1f%%)",
        ["Playback not ready (%s); ABX session ended."] = "播放未就绪 (%s)；ABX 会话已结束。",
        ["Profile B not loaded; cannot restart EQ test."] = "未加载配置 B；无法重新开始 EQ 测试。",
        ["No test mode configured; cannot restart."] = "未配置测试模式；无法重新开始。",
        ["Audition failed on restart; session ended."] = "重新开始时试听失败；会话已结束。",
        ["ABX Session restarted"] = "ABX 会话已重新开始",
        ["Parent folder"] = "上级文件夹",
        ["No matching files here (%s)"] = "此处无匹配文件 (%s)",
        ["Select File"] = "选择文件",
        ["Audio File ABX Test..."] = "音频文件 ABX 测试...",
        ["Equalizer Profile ABX Test..."] = "EQ 配置 ABX 测试...",
        ["Trials Per Session: %d"] = "每轮测试次数：%d",
        ["Trials set to %d"] = "测试次数已设为 %d",
        ["About ABX Blind Test"] = "关于 ABX 盲听测试",
        ["Blind ABX listener evaluation tool with randomized X."] = "带有随机 X 的 ABX 盲听评估工具。",
        ["In each trial, sample X is randomly assigned to source A or B."] = "在每次测试中，样本 X 会随机分配给音源 A 或 B。",
        ["Audition A, B, and X, then select your vote."] = "试听 A、B 和 X，然后投票。",
        ["File mode uses native gapless switching with shared DSP."] = "文件模式使用共享 DSP 的原生无缝切换。",
        ["Supports 16-bit FLAC/PCM and matched local MP3 files."] = "支持 16-bit FLAC/PCM 及匹配的本地 MP3 文件。",
        ["EQ profile switching cannot guarantee click-free live updates."] = "切换 EQ 配置无法保证完全无爆音。",
        ["Calculates exact binomial probability (p-value) upon completion."] = "完成后计算精确二项分布概率（p 值）。",
        ["(None Playing)"] = "（未在播放）",
        ["(Not Selected)"] = "（未选择）",
        ["Status: Idle"] = "状态：空闲",
        ["Status: Preparing... (Tap to Cancel)"] = "状态：准备中...（轻触取消）",
        ["Status: Ready (Matched)"] = "状态：就绪（已匹配）",
        ["Main menu"] = "主菜单",
        ["Track A: %s"] = "曲目 A：%s",
        ["None"] = "无",
        ["Track B: %s"] = "曲目 B：%s",
        ["Selected: %s"] = "已选择：%s",
        ["Select Track B (File Browser)..."] = "选择曲目 B（文件浏览器）...",
        ["Enter Track B Path (Text)..."] = "输入曲目 B 路径（文本）...",
        ["Enter Track B Path"] = "输入曲目 B 路径",
        ["Invalid path: %s"] = "无效路径：%s",
        ["Prepare Comparison"] = "准备对比",
        ["Cancel Preparation"] = "取消准备",
        ["Start ABX File Test"] = "开始 ABX 文件测试",
        ["Track B is not ready yet"] = "曲目 B 尚未就绪",
        ["Not ready: %s"] = "未就绪：%s",
        ["Audition failed on start"] = "启动试听失败",
        ["Clear Comparison"] = "清除对比",
        ["Comparison cleared"] = "已清除对比",
        ["Notice: PEQ updates are not click-free"] = "注意：PEQ 切换并非完全无爆音",
        ["PEQ profile coefficient updates cannot guarantee click-free switching."] = "PEQ 配置系数更新无法保证无爆音切换。",
        ["Profile A: %s"] = "配置 A：%s",
        ["Profile B: %s"] = "配置 B：%s",
        ["Use Current EQ as Profile A"] = "将当前 EQ 设为配置 A",
        ["Captured Current EQ as Profile A"] = "已将当前 EQ 捕获为配置 A",
        ["Load .peq for Profile B..."] = "为配置 B 加载 .peq...",
        ["Invalid Profile Path: %s"] = "配置文件路径无效：%s",
        ["Loaded %s transiently"] = "已临时加载 %s",
        ["Failed to load .peq profile"] = "加载 .peq 配置失败",
        ["Start ABX EQ Test"] = "开始 ABX EQ 测试",
        ["Player lacks audio.peq.state capability"] = "播放器不支持 audio.peq.state",
        ["EQ state query unavailable"] = "无法查询 EQ 状态",
        ["Playback not ready: %s"] = "播放未就绪：%s",
        ["Could not read baseline EQ"] = "无法读取基准 EQ",
        ["Please load Profile B first"] = "请先加载配置 B",
        ["About EQ Comparisons"] = "关于 EQ 对比",
        ["About EQ ABX Test"] = "关于 EQ ABX 测试",
        ["Loads .peq profiles transiently (without flash persistence)."] = "临时加载 .peq 配置（不写入闪存）。",
        ["Hardware limitation: EQ updates cannot guarantee click-free switching."] = "硬件限制：EQ 更新无法保证切换无爆音。",
        ["Restores runtime baseline EQ upon test completion or cancellation."] = "测试完成或取消后恢复基准 EQ。",
        ["If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."] = "若测试期间更改外部 EQ，会话将中止以保留您的调整。",
        ["Tone adjustments are not loudness-matched or bit-perfect."] = "音调调整未做响度匹配，也非比特精确。",
        ["Trial %d of %d"] = "第 %d / %d 轮",
        ["Auditioning %s"] = "正在试听 %s",
        ["Sample A"] = "样本 A",
        ["Sample B"] = "样本 B",
        ["Sample X (Hidden)"] = "样本 X（隐藏）",
        ["Sample X"] = "样本 X",
        ["Vote: X is A"] = "投票：X 是 A",
        ["Vote: X is B"] = "投票：X 是 B",
        ["Final Score: %d/%d (%.1f%%)"] = "最终得分：%d/%d (%.1f%%)",
        ["p-value: %.4f (%s)"] = "p 值：%.4f (%s)",
        ["Significant"] = "显著",
        ["Inconclusive"] = "无定论",
        ["Restart Test"] = "重新开始测试",
        ["Exit ABX Session"] = "退出 ABX 会话",
        ["ABX Session ended"] = "ABX 会话已结束",
        ["Playback interrupted; ABX session ended."] = "播放中断；ABX 会话已结束。",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

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

local function crossfeed_state_values(state)
    local strength = state.crossfeed
    if strength == nil then strength = 0 end -- Older snapshots omitted crossfeed entirely.
    if not is_finite_number(strength) or strength < 0 or strength > 1 then return nil end

    local angle = state.crossfeed_angle
    if angle == nil then
        angle = 0 -- Older firmware snapshots did not include the angle.
    elseif not is_finite_number(angle)
       or (angle ~= 0 and angle ~= 30 and angle ~= 45 and angle ~= 60 and angle ~= 90) then
        return nil
    end

    return strength, angle
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
    local crossfeed1, angle1 = crossfeed_state_values(s1)
    local crossfeed2, angle2 = crossfeed_state_values(s2)
    if crossfeed1 == nil or crossfeed2 == nil then return false end
    if s1.bypass ~= s2.bypass then return false end
    if not is_finite_number(s1.preamp_db) or not is_finite_number(s2.preamp_db) then return false end
    if math.abs(s1.preamp_db - s2.preamp_db) > 1e-6 then return false end
    if not is_finite_number(s1.stereo_width) or not is_finite_number(s2.stereo_width) then return false end
    if math.abs(s1.stereo_width - s2.stereo_width) > 1e-6 then return false end
    if math.abs(crossfeed1 - crossfeed2) > 1e-6 or angle1 ~= angle2 then return false end

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
        return false, tr("Path must be a non-empty string")
    end
    if path:match("^[A-Za-z]+://") then
        return false, tr("Network URLs are not supported for local comparison")
    end
    if ("/" .. path .. "/"):find("/../", 1, true) then
        return false, tr("Path traversal ('..') is not permitted")
    end
    local root = plugin.sd_root and plugin.sd_root() or "/data/mnt/sd_0"
    if path ~= root and path:sub(1, #root + 1) ~= (root .. "/") then
        return false, string.format(tr("Path must be located inside the SD card (%s)"), root)
    end
    return true
end

-- Validate live file readiness at controls (audition, vote, start)
local function validate_live_file_readiness()
    if not plugin.is_playing or not plugin.is_playing() then
        return false, tr("playback paused or stopped")
    end
    local st = plugin.get_ab_switch and plugin.get_ab_switch()
    if not st or not st.ready then
        return false, tr("native switch not ready")
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    if not fmt then
        return false, tr("playback format unavailable")
    end
    if session.initial_generation and fmt.generation and fmt.generation ~= session.initial_generation then
        return false, tr("track restarted or changed")
    end
    if session.path_a and fmt.path and fmt.path ~= session.path_a then
        return false, tr("track path changed")
    end
    local speed = fmt.playback_speed
    if speed == nil and plugin.get_playback_speed then speed = plugin.get_playback_speed() end
    if not is_finite_number(speed) or speed ~= 1.0 then
        return false, string.format(tr("playback speed must be 1.0x (currently %s)"), tostring(speed or tr("unknown")))
    end
    local crossfade = fmt.crossfade_enabled
    if crossfade == nil and plugin.get_crossfade then crossfade = plugin.get_crossfade() end
    if crossfade then
        return false, tr("crossfade enabled")
    end
    if fmt.is_stream or fmt.is_dsd then
        return false, tr("stream/dsd source")
    end
    if not is_finite_number(fmt.duration_seconds) or fmt.duration_seconds <= 0 then
        return false, tr("track duration not positive and finite")
    end
    return true
end

-- Validate current playback eligibility for EQ testing
local function validate_live_eq_playback()
    if not plugin.is_playing or not plugin.is_playing() then
        return false, tr("playback paused or stopped")
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    if not fmt then
        return false, tr("playback format unavailable")
    end
    if fmt.is_stream then
        return false, tr("streaming audio not supported")
    end
    if not is_finite_number(fmt.duration_seconds) or fmt.duration_seconds <= 0 then
        return false, tr("track duration not finite or positive")
    end
    if session.path_a and fmt.path and session.path_a ~= fmt.path then
        return false, tr("track path changed")
    end
    if session.initial_generation and fmt.generation and session.initial_generation ~= fmt.generation then
        return false, tr("track playback generation changed")
    end
    return true
end

-- Validate primary playing track before starting file comparison preparation
local function validate_primary_track()
    if not plugin.has_capability or not plugin.has_capability("playback.ab_switch") then
        return false, tr("Player lacks playback.ab_switch capability")
    end
    if not plugin.is_playing or not plugin.is_playing() then
        return false, tr("Primary track must be currently playing")
    end
    if not plugin.get_playback_format then
        return false, tr("Playback format query unavailable")
    end
    local fmt = plugin.get_playback_format()
    if not fmt then
        return false, tr("No active audio format")
    end
    if fmt.is_stream then
        return false, tr("Stream playback cannot be used for comparison")
    end
    if fmt.is_dsd then
        return false, tr("DSD tracks cannot be used for AB switch")
    end
    local speed = fmt.playback_speed
    if speed == nil and plugin.get_playback_speed then speed = plugin.get_playback_speed() end
    if not is_finite_number(speed) or speed ~= 1.0 then
        return false, tr("Playback speed must be 1.0x")
    end
    local crossfade = fmt.crossfade_enabled
    if crossfade == nil and plugin.get_crossfade then
        crossfade = plugin.get_crossfade()
    end
    if crossfade then
        return false, tr("Crossfade must be disabled in Sound settings")
    end
    local is_16bit_lossless = (fmt.bit_depth == 16 and (fmt.codec == "flac" or fmt.codec == "pcm"))
    local is_mp3 = (fmt.codec == "mp3" and fmt.bit_depth == 0)
    if not is_16bit_lossless and not is_mp3 then
        return false, string.format(tr("Primary codec (%s, %d-bit) unsupported: requires 16-bit FLAC/PCM or MP3"), fmt.codec or tr("unknown"), fmt.bit_depth or 0)
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
            plugin.show_toast(tr("Comparison preparation cancelled"))
            return
        end

        if st.ready then
            stop_prep_timer()
            session.file_b_preparing = false
            session.file_b_ready = true
            plugin.show_toast(tr("Alternate track ready for ABX test!"))
        elseif not st.preparing then
            -- Audio engine finished preparation and rejected (authoritative mismatch result)
            stop_prep_timer()
            clear_owned_candidate()
            plugin.show_toast(tr("Preparation rejected: sample rate, channels, or frame counts mismatch"))
        elseif polls > 300 then
            stop_prep_timer()
            clear_owned_candidate()
            plugin.show_toast(tr("Preparation timed out (5m)"))
        end
    end)

    if ok and handle then
        session.prep_timer = handle
    else
        session.prep_timer = nil
        clear_owned_candidate()
        plugin.show_toast(tr("Timer slot limit reached; cannot poll preparation"))
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
        plugin.show_toast(string.format(tr("Invalid Track B: %s"), path_err))
        return
    end

    local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
    session.path_a = cur_fmt and cur_fmt.path or (plugin.get_current_track_path and plugin.get_current_track_path())
    session.initial_generation = cur_fmt and cur_fmt.generation or 1

    if not session.path_a then
        plugin.show_toast(tr("No active track path found"))
        return
    end

    if not plugin.prepare_ab_switch then
        plugin.show_toast(tr("Player lacks prepare_ab_switch API"))
        return
    end

    -- Clear any previous candidate before initiating a new one
    clear_owned_candidate()

    local accepted = plugin.prepare_ab_switch(session.path_b)
    if not accepted then
        session.owned_candidate = false
        session.file_b_ready = false
        session.file_b_preparing = false
        plugin.show_toast(tr("Audio engine rejected comparison preparation"))
        show_view("file")
        return
    end

    session.owned_candidate = true
    session.file_b_preparing = true
    session.file_b_ready = false
    plugin.show_toast(tr("Preparing alternate file..."))
    start_prep_polling()
    show_view("file")
end

-- Auditioning helpers with session epoch and trial ID guard
local function select_audition(source_letter, ep, trial_id)
    if not session.active then return false end
    if ep and (ep ~= session.epoch or trial_id ~= session.current_trial) then
        return false
    end

    local target_key = source_letter
    if source_letter == "x" then
        target_key = session.trial_x
    end

    if session.mode == "file" then
        local ok_ready, err = validate_live_file_readiness()
        if not ok_ready then
            stop_session(string.format(tr("Readiness lost (%s); ABX session ended."), err))
            show_view("main")
            return false
        end
        if not plugin.select_ab_source then return false end
        local ok = plugin.select_ab_source(target_key)
        if not ok then
            stop_session(tr("Native switch selection failed; ABX session ended."))
            show_view("main")
            return false
        end
    elseif session.mode == "eq" then
        local ok_play, err_play = validate_live_eq_playback()
        if not ok_play then
            stop_session(string.format(tr("Playback invalid (%s); ABX session ended."), err_play))
            show_view("main")
            return false
        end
        local current = plugin.get_eq_state and plugin.get_eq_state()
        if session.last_applied_eq and not eq_states_match(current, session.last_applied_eq) then
            stop_session(tr("External EQ change detected; trial ended to preserve your custom settings."))
            show_view("main")
            return false
        end
        local target_state = (target_key == "a") and session.profile_a_state or session.profile_b_state
        if target_state and plugin.eq_apply_state then
            plugin.eq_apply_state(target_state, { persist = false })
            session.last_applied_eq = plugin.get_eq_state and plugin.get_eq_state()
        end
    else
        stop_session(tr("Invalid session mode; ABX session ended."))
        show_view("main")
        return false
    end

    session.current_audition = source_letter
    return true
end

-- Recording vote on current trial with session epoch and trial ID guard
local function record_vote(guess_letter, ep, trial_id)
    if not session.active then return end
    if ep ~= session.epoch or trial_id ~= session.current_trial then
        return
    end
    if session.current_trial > session.total_trials then return end

    -- Validation BEFORE counting vote
    if session.mode == "file" then
        local ok_ready, err = validate_live_file_readiness()
        if not ok_ready then
            stop_session(string.format(tr("Readiness lost before vote (%s); ABX session ended."), err))
            show_view("main")
            return
        end
    elseif session.mode == "eq" then
        local ok_play, err_play = validate_live_eq_playback()
        if not ok_play then
            stop_session(string.format(tr("Playback invalid before vote (%s); ABX session ended."), err_play))
            show_view("main")
            return
        end
        local current = plugin.get_eq_state and plugin.get_eq_state()
        if session.last_applied_eq and not eq_states_match(current, session.last_applied_eq) then
            stop_session(tr("External EQ change detected before vote; trial ended to preserve your custom settings."))
            show_view("main")
            return
        end
    else
        stop_session(tr("Invalid mode before vote; ABX session ended."))
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
            stop_session(tr("Audition failed for next trial; session ended."))
            show_view("main")
            return
        end
        -- Strictly avoid exposing true X in toasts
        plugin.show_toast(string.format(tr("Vote recorded. Starting Trial %d of %d"), session.current_trial, session.total_trials))
    else
        -- Trials finished: clean up native context while preserving score display
        session.finished = true
        session.final_score = session.score
        session.final_total = session.total_trials
        session.final_p_val = binomial_p_value(session.score, session.total_trials)
        local pct = (session.score / session.total_trials) * 100

        session.last_mode = session.mode
        session.active = false

        plugin.show_toast(string.format(tr("Test Complete! Score: %d/%d (%.1f%%)"), session.final_score, session.final_total, pct))
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
            stop_session(string.format(tr("Readiness lost (%s); ABX session ended."), tostring(err)))
            show_view("file")
            return
        end
    elseif mode_to_run == "eq" then
        session.mode = "eq"
        local ok_play, err_play = validate_live_eq_playback()
        if not ok_play then
            session.mode = nil
            stop_session(string.format(tr("Playback not ready (%s); ABX session ended."), tostring(err_play)))
            show_view("eq")
            return
        end
        local current = plugin.get_eq_state and plugin.get_eq_state()
        if session.last_applied_eq and not eq_states_match(current, session.last_applied_eq) then
            session.mode = nil
            stop_session(tr("External EQ change detected; trial ended to preserve your custom settings."))
            show_view("main")
            return
        end
        if not session.profile_b_state then
            session.mode = nil
            stop_session(tr("Profile B not loaded; cannot restart EQ test."))
            show_view("eq")
            return
        end
    else
        session.mode = nil
        stop_session(tr("No test mode configured; cannot restart."))
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
        stop_session(tr("Audition failed on restart; session ended."))
        show_view("main")
        return
    end
    plugin.show_toast(tr("ABX Session restarted"))
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
                rows[#rows + 1] = tr("Parent folder")
                actions[#actions + 1] = function()
                    navigate_to(parent)
                end
            end
        end

        -- Subdirectories: arbitrarily deep (no depth cutoff)
        for i = 1, #folders do
            local f_name = folders[i]
            rows[#rows + 1] = f_name .. "/"
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
            local formats = {}
            for _, ext in ipairs(filter_exts) do
                formats[#formats + 1] = ext:gsub("^%.", ""):upper()
            end
            rows[1] = string.format(tr("No matching files here (%s)"), table.concat(formats, ", "))
            actions[1] = function() end
        end

        local opts = { selected = 1 }
        if file_browser_handle then
            opts.replace = file_browser_handle
        end

        local new_h = plugin.show_list(tr("Select File"), rows, function(index)
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
            label = tr("Audio File ABX Test..."),
            on_select = function() show_view("file") end,
        },
        {
            type = "row",
            label = tr("Equalizer Profile ABX Test..."),
            on_select = function() show_view("eq") end,
        },
        {
            type = "row",
            label = string.format(tr("Trials Per Session: %d"), session.total_trials),
            on_select = function()
                if session.total_trials == 5 then session.total_trials = 10
                elseif session.total_trials == 10 then session.total_trials = 16
                elseif session.total_trials == 16 then session.total_trials = 20
                else session.total_trials = 5 end
                plugin.show_toast(string.format(tr("Trials set to %d"), session.total_trials))
                show_view("main")
            end,
        },
        {
            type = "row",
            label = tr("About ABX Blind Test"),
            on_select = function()
                if not plugin.show_list then return end
                plugin.show_list(tr("About ABX Blind Test"), {
                    tr("Blind ABX listener evaluation tool with randomized X."),
                    tr("In each trial, sample X is randomly assigned to source A or B."),
                    tr("Audition A, B, and X, then select your vote."),
                    tr("File mode uses native gapless switching with shared DSP."),
                    tr("Supports 16-bit FLAC/PCM and matched local MP3 files."),
                    tr("EQ profile switching cannot guarantee click-free live updates."),
                    tr("Calculates exact binomial probability (p-value) upon completion."),
                }, function() end)
            end,
        },
    }
end

local function build_file_view_items()
    local cur_track = plugin.get_current_track_path and plugin.get_current_track_path()
    local path_a_disp = cur_track and (cur_track:match("[^/]+$") or cur_track) or tr("(None Playing)")
    local path_b_disp = session.path_b and (session.path_b:match("[^/]+$") or session.path_b) or tr("(Not Selected)")

    local status_str = tr("Status: Idle")
    if session.file_b_preparing then
        status_str = tr("Status: Preparing... (Tap to Cancel)")
    elseif session.file_b_ready then
        status_str = tr("Status: Ready (Matched)")
    end

    local items = {
        {
            type = "row",
            label = tr("Main menu"),
            on_select = function() show_view("main") end,
        },
        {
            type = "row",
            label = string.format(tr("Track A: %s"), path_a_disp),
            on_select = function() plugin.show_toast(string.format(tr("Track A: %s"), cur_track or tr("None"))) end,
        },
        {
            type = "row",
            label = string.format(tr("Track B: %s"), path_b_disp),
            on_select = function()
                browse_files({ ".flac", ".wav", ".aiff", ".caf", ".mp3" }, function(picked_path)
                    session.path_b = picked_path
                    clear_owned_candidate()
                    plugin.show_toast(string.format(tr("Selected: %s"), picked_path:match("[^/]+$") or picked_path))
                    prepare_file_b()
                end)
            end,
        },
        {
            type = "row",
            label = tr("Select Track B (File Browser)..."),
            on_select = function()
                browse_files({ ".flac", ".wav", ".aiff", ".caf", ".mp3" }, function(picked_path)
                    session.path_b = picked_path
                    clear_owned_candidate()
                    plugin.show_toast(string.format(tr("Selected: %s"), picked_path:match("[^/]+$") or picked_path))
                    show_view("file")
                end)
            end,
        },
        {
            type = "row",
            label = tr("Enter Track B Path (Text)..."),
            on_select = function()
                if not plugin.show_text_input then return end
                plugin.show_text_input(tr("Enter Track B Path"), session.path_b or "", false, function(txt)
                    if txt and txt ~= "" then
                        local valid, err = validate_sd_file_path(txt)
                        if not valid then
                            plugin.show_toast(string.format(tr("Invalid path: %s"), err))
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
            label = tr("Prepare Comparison"),
            on_select = prepare_file_b,
        },
        {
            type = "row",
            label = status_str,
            on_select = function()
                if session.file_b_preparing then
                    clear_owned_candidate()
                    plugin.show_toast(tr("Comparison preparation cancelled"))
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
            label = tr("Cancel Preparation"),
            on_select = function()
                clear_owned_candidate()
                plugin.show_toast(tr("Comparison preparation cancelled"))
                show_view("file")
            end,
        }
    end

    items[#items + 1] = {
        type = "row",
        label = tr("Start ABX File Test"),
        on_select = function()
            local st = plugin.get_ab_switch and plugin.get_ab_switch()
            if st and st.ready then
                session.file_b_ready = true
                session.file_b_preparing = false
            end
            if not session.file_b_ready then
                plugin.show_toast(tr("Track B is not ready yet"))
                show_view("file")
                return
            end
            local ok, reason = validate_primary_track()
            if not ok then plugin.show_toast(reason) return end
            local ok_ready, err = validate_live_file_readiness()
            if not ok_ready then plugin.show_toast(string.format(tr("Not ready: %s"), err)) return end

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
                stop_session(tr("Audition failed on start"))
                show_view("file")
                return
            end
            show_view("trial")
        end,
    }

    items[#items + 1] = {
        type = "row",
        label = tr("Clear Comparison"),
        on_select = function()
            clear_owned_candidate()
            plugin.show_toast(tr("Comparison cleared"))
            show_view("file")
        end,
    }

    return items
end

local function build_eq_view_items()
    return {
        {
            type = "row",
            label = tr("Main menu"),
            on_select = function() show_view("main") end,
        },
        {
            type = "row",
            label = tr("Notice: PEQ updates are not click-free"),
            on_select = function()
                plugin.show_toast(tr("PEQ profile coefficient updates cannot guarantee click-free switching."))
            end,
        },
        {
            type = "row",
            label = string.format(tr("Profile A: %s"), tr(session.profile_a_name)),
            on_select = function() plugin.show_toast(string.format(tr("Profile A: %s"), tr(session.profile_a_name))) end,
        },
        {
            type = "row",
            label = string.format(tr("Profile B: %s"), tr(session.profile_b_name)),
            on_select = function() plugin.show_toast(string.format(tr("Profile B: %s"), tr(session.profile_b_name))) end,
        },
        {
            type = "row",
            label = tr("Use Current EQ as Profile A"),
            on_select = function()
                if plugin.get_eq_state then
                    session.profile_a_state = plugin.get_eq_state()
                    session.profile_a_name = "Current Snapshot"
                    plugin.show_toast(tr("Captured Current EQ as Profile A"))
                    show_view("eq")
                end
            end,
        },
        {
            type = "row",
            label = tr("Load .peq for Profile B..."),
            on_select = function()
                browse_files({ ".peq" }, function(path)
                    local valid, err = validate_sd_file_path(path)
                    if not valid then
                        plugin.show_toast(string.format(tr("Invalid Profile Path: %s"), err))
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
                            plugin.show_toast(string.format(tr("Loaded %s transiently"), session.profile_b_name))
                        else
                            plugin.show_toast(tr("Failed to load .peq profile"))
                        end
                    end
                    show_view("eq")
                end)
            end,
        },
        {
            type = "row",
            label = tr("Start ABX EQ Test"),
            on_select = function()
                if not plugin.has_capability or not plugin.has_capability("audio.peq.state") then
                    plugin.show_toast(tr("Player lacks audio.peq.state capability"))
                    return
                end
                if not plugin.get_eq_state then
                    plugin.show_toast(tr("EQ state query unavailable"))
                    return
                end

                local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
                session.path_a = cur_fmt and cur_fmt.path or (plugin.get_current_track_path and plugin.get_current_track_path())
                session.initial_generation = cur_fmt and cur_fmt.generation or 1

                local ok_play, err_play = validate_live_eq_playback()
                if not ok_play then
                    plugin.show_toast(string.format(tr("Playback not ready: %s"), err_play))
                    return
                end

                session.baseline_eq = plugin.get_eq_state()
                if not session.baseline_eq then
                    plugin.show_toast(tr("Could not read baseline EQ"))
                    return
                end

                if not session.profile_a_state then
                    session.profile_a_state = session.baseline_eq
                    session.profile_a_name = "Baseline EQ"
                end

                if not session.profile_b_state then
                    plugin.show_toast(tr("Please load Profile B first"))
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
                    stop_session(tr("Audition failed on start"))
                    show_view("eq")
                    return
                end
                show_view("trial")
            end,
        },
        {
            type = "row",
            label = tr("About EQ Comparisons"),
            on_select = function()
                if not plugin.show_list then return end
                plugin.show_list(tr("About EQ ABX Test"), {
                    tr("Loads .peq profiles transiently (without flash persistence)."),
                    tr("Hardware limitation: EQ updates cannot guarantee click-free switching."),
                    tr("Restores runtime baseline EQ upon test completion or cancellation."),
                    tr("If external EQ controls are touched during a trial, the session suspends to preserve your adjustments."),
                    tr("Tone adjustments are not loudness-matched or bit-perfect."),
                }, function() end)
            end,
        },
    }
end

local function build_trial_view_items()
    local is_finished = session.finished or (session.current_trial > session.total_trials)
    local items = {}

    local ep = session.epoch
    local trial_id = session.current_trial

    if not is_finished then
        local trial_str = string.format(tr("Trial %d of %d"), session.current_trial, session.total_trials)
        items[#items + 1] = {
            type = "row",
            label = trial_str,
            on_select = function() plugin.show_toast(trial_str) end,
        }

        -- Native toggles mark the sample currently being auditioned; the
        -- view is rebuilt after every tap so exactly one stays switched on.
        local function add_audition_toggle(letter, label, name)
            items[#items + 1] = {
                type = "toggle",
                label = label,
                value = session.current_audition == letter,
                on_change = function()
                    if select_audition(letter, ep, trial_id) then
                        plugin.show_toast(string.format(tr("Auditioning %s"), name))
                        show_view("trial")
                    elseif session.current_view == "trial" then
                        show_view("trial")
                    end
                end,
            }
        end
        add_audition_toggle("a", tr("Sample A"), tr("Sample A"))
        add_audition_toggle("b", tr("Sample B"), tr("Sample B"))
        add_audition_toggle("x", tr("Sample X (Hidden)"), tr("Sample X"))

        items[#items + 1] = {
            type = "row",
            label = tr("Vote: X is A"),
            on_select = function() record_vote("a", ep, trial_id) end,
        }
        items[#items + 1] = {
            type = "row",
            label = tr("Vote: X is B"),
            on_select = function() record_vote("b", ep, trial_id) end,
        }
    else
        local p_val = session.final_p_val or binomial_p_value(session.score, session.total_trials)
        local score = session.final_score or session.score
        local total = session.final_total or session.total_trials
        local pct = (total > 0) and ((score / total) * 100) or 0
        local res_str = string.format(tr("Final Score: %d/%d (%.1f%%)"), score, total, pct)
        local p_str = string.format(tr("p-value: %.4f (%s)"), p_val, (p_val < 0.05) and tr("Significant") or tr("Inconclusive"))

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
        label = tr("Restart Test"),
        on_select = restart_session,
    }

    items[#items + 1] = {
        type = "row",
        label = tr("Exit ABX Session"),
        on_select = function()
            session.finished = false
            stop_session(tr("ABX Session ended"))
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
    plugin.show_settings_list(tr("ABX Blind Test"), items, { update = true })
end

-- Playback interruption handling:
-- Both file mode and EQ mode stop on pause/stop/track changes.
-- Does NOT automatically reopen or pop up the settings menu from events.
if plugin.on then
    local function on_playback_interrupted()
        if session.active then
            stop_session(tr("Playback interrupted; ABX session ended."))
        else
            clear_owned_candidate()
        end
    end
    plugin.on("paused", on_playback_interrupted)
    plugin.on("stopped", on_playback_interrupted)
    plugin.on("track_started", on_playback_interrupted)
end

if plugin.register_list_item then
    plugin.register_list_item("playback", tr("ABX Blind Test"), function()
        if session.active or session.finished then
            show_view("trial")
        else
            show_view("main")
        end
    end)
end
