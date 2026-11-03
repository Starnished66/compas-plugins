plugin.define({
    id = "example.cover_art_fetcher",
    name = "Cover Art Fetcher",
    version = "1.3.0",
    api_min = 19,
})

local T = {
    de = {
        ["Fetching cover art"] = "Cover wird geladen",
        ["Cover fetch in progress"] = "Cover-Abruf läuft",
        ["Cover fetch already in progress — %s"] = "Cover-Abruf läuft bereits — %s",
        ["Could not read saved cover requests"] = "Gespeicherte Cover-Anfragen konnten nicht gelesen werden",
        ["Album tags or path are not supported"] = "Album-Tags oder Pfad werden nicht unterstützt",
        ["Could not update saved cover request"] = "Gespeicherte Cover-Anfrage konnte nicht aktualisiert werden",
        ["Cover request is already saved"] = "Cover-Anfrage ist bereits gespeichert",
        ["Cover fetch queued"] = "Cover-Abruf in Warteschlange",
        ["Saved cover request queue is full"] = "Warteschlange für Cover-Anfragen ist voll",
        ["Could not save request; it was not queued"] = "Anfrage konnte nicht gespeichert werden",
        ["Cover request saved for download"] = "Cover-Anfrage zum Herunterladen gespeichert",
        ["Could not save retry request"] = "Wiederholungsanfrage konnte nicht gespeichert werden",
        ["This player cannot track downloaded covers"] = "Dieser Player kann heruntergeladene Cover nicht protokollieren",
        ["Download history is unavailable; cover not saved"] = "Download-Verlauf nicht verfügbar; Cover nicht gespeichert",
        ["Download history for this album is being checked"] = "Download-Verlauf für dieses Album wird geprüft",
        ["This album's path is too long to record; cover not saved"] = "Albumpfad ist zu lang zum Protokollieren; Cover nicht gespeichert",
        ["Download history is full; cover not saved"] = "Download-Verlauf ist voll; Cover nicht gespeichert",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "Eine .compas-fetch-Datei befindet sich im Albumordner; Cover nicht gespeichert",
        ["Could not record the download; cover not saved"] = "Download konnte nicht protokolliert werden; Cover nicht gespeichert",
        ["Could not save album sidecar"] = "Album-Coverdatei konnte nicht gespeichert werden",
        ["Saved %s"] = "%s gespeichert",
        ["Cover request queued for retry"] = "Cover-Anfrage zur Wiederholung eingereiht",
        ["No cover art for this release"] = "Kein Cover für diese Veröffentlichung",
        ["Could not match this album conservatively"] = "Album konnte nicht eindeutig zugeordnet werden",
        ["Too many MusicBrainz matches to choose safely"] = "Zu viele MusicBrainz-Treffer für eine sichere Auswahl",
        ["%s already present"] = "%s bereits vorhanden",
        ["Cover fetch failed (network)"] = "Cover-Abruf fehlgeschlagen (Netzwerk)",
        ["Saving cover…"] = "Cover wird gespeichert…",
        ["Downloading cover…"] = "Cover wird heruntergeladen…",
        ["Checking Cover Art Archive…"] = "Cover Art Archive wird geprüft…",
        ["Looking up MusicBrainz…"] = "Suche bei MusicBrainz…",
        ["Cover fetch already queued"] = "Cover-Abruf bereits in Warteschlange",
        ["This player cannot fetch cover art"] = "Dieser Player kann keine Cover abrufen",
        ["Album tag has leading or trailing spaces; cover not saved"] = "Album-Tag hat Leerzeichen am Anfang oder Ende; Cover nicht gespeichert",
        ["Could not identify this indexed album safely"] = "Indiziertes Album konnte nicht sicher erkannt werden",
        ["Could not check saved cover requests; nothing was changed"] = "Gespeicherte Anfragen konnten nicht geprüft werden; nichts geändert",
        ["This cover cannot be reverted"] = "Dieses Cover kann nicht zurückgesetzt werden",
        ["A fetch for this album is running; try again when it finishes"] = "Abruf für dieses Album läuft noch; bitte später erneut versuchen",
        ["The cover is missing; nothing was changed"] = "Das Cover fehlt; nichts wurde geändert",
        ["The cover was changed or replaced; nothing was changed"] = "Das Cover wurde geändert oder ersetzt; nichts wurde geändert",
        ["No free backup name; nothing was changed"] = "Kein freier Backup-Name verfügbar; nichts wurde geändert",
        ["Could not clear queued request; nothing was changed"] = "Wartende Anfrage konnte nicht gelöscht werden; nichts geändert",
        ["Could not record the revert; nothing was changed"] = "Zurücksetzen konnte nicht protokolliert werden; nichts geändert",
        ["Could not rename the cover; nothing was changed"] = "Cover konnte nicht umbenannt werden; nichts wurde geändert",
        ["checking"] = "wird geprüft",
        ["saved"] = "gespeichert",
        ["not saved"] = "nicht gespeichert",
        ["reverted"] = "zurückgesetzt",
        ["missing"] = "fehlt",
        ["Download history is unavailable"] = "Download-Verlauf ist nicht verfügbar",
        ["No downloaded covers recorded"] = "Keine heruntergeladenen Cover verzeichnet",
        ["Newer"] = "Neuer",
        ["Older"] = "Älter",
        ["Downloaded covers"] = "Heruntergeladene Cover",
        ["Album: %s"] = "Album: %s",
        ["Artist: %s"] = "Interpret: %s",
        ["Recorded: %s"] = "Erfasst: %s",
        ["Size: %d bytes"] = "Größe: %d Bytes",
        ["Status: %s"] = "Status: %s",
        ["Backup"] = "Backup",
        ["Revert: rename to %s"] = "Zurücksetzen: umbenennen in %s",
        ["Cancel"] = "Abbrechen",
        ["Downloaded cover"] = "Heruntergeladenes Cover",
        ["Cover reverted. Use Reload cover if it still shows"] = "Cover zurückgesetzt. Bei Bedarf „Cover neu laden“ nutzen",
        ["No files changed"] = "Keine Dateien geändert",
        ["Play a local track first"] = "Spiele zuerst einen lokalen Titel ab",
        ["No downloaded cover recorded for this album"] = "Kein heruntergeladenes Cover für dieses Album verzeichnet",
        ["This album"] = "Dieses Album",
        ["Tracks at the top of the card are not repaired"] = "Titel im obersten Verzeichnis der Karte werden nicht repariert",
        ["Update the music database, then try again"] = "Aktualisiere die Musikdatenbank und versuche es erneut",
        ["The track changed; try again"] = "Der Titel hat gewechselt; bitte erneut versuchen",
        ["Library is too large to check safely"] = "Bibliothek ist zu groß für eine sichere Prüfung",
        ["Could not check folder artwork"] = "Ordner-Cover konnte nicht geprüft werden",
        ["Shared artwork found, but no safe backup name is free"] = "Geteiltes Cover gefunden, aber kein freier Backup-Name verfügbar",
        ["No shared generic artwork affects this album"] = "Kein geteiltes Ordner-Cover betrifft dieses Album",
        ["Rename %d file to %s"] = "%d Datei in %s umbenennen",
        ["Rename %d files to %s"] = "%d Dateien in %s umbenennen",
        ["Shared folder artwork"] = "Geteiltes Ordner-Cover",
        ["Renamed %d, could not rename %d"] = "%d umbenannt, %d fehlgeschlagen",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "%d umbenannt. Bei Bedarf „Cover neu laden“ nutzen",
        ["About Cover Art Fetcher"] = "Über Cover-Abruf",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Sucht das aktuelle Album bei MusicBrainz und lädt ein 500px- (oder 250px-) Front-JPEG vom Cover Art Archive als <Albumtitel>.jpg neben den Titel herunter.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Überschreibt niemals ein vorhandenes Album-Cover. Die Zuordnung ist vorsichtig: Indizierte Tags müssen zur Wiedergabe passen und Albumnamen dürfen nicht mit benachbarten Ordnern oder Interpreten kollidieren.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "Die Lua-API erkennt keine eingebetteten Bilder in Audiodateien; solche Alben erhalten daher eventuell trotzdem eine Coverdatei im Ordner.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Ein allgemeines cover- oder folder-Bild neben dem Titel oder einen Ordner darüber kann für jedes Album dort angezeigt werden. „Geteiltes Ordner-Cover reparieren“ listet diese Dateien auf und benennt sie erst nach Bestätigung in .compas-backup um.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Jedes von diesem Plugin gespeicherte Cover wird mit Pfad, Größe und Prüfsumme protokolliert. Unter „Heruntergeladene Cover“ kannst du es zurücksetzen: Nach Bestätigung wird es in .compas-backup umbenannt, sofern die Datei unverändert ist.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Anfragen für fehlende Cover werden vor dem Download gespeichert und bei verfügbarer Wi-Fi-Verbindung fortgesetzt, auch nach einem Neustart. Unter „Ausstehende Cover-Anfragen“ kannst du sie wiederholen oder löschen.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "Der automatische Modus ist standardmäßig aus. MusicBrainz ist auf eine Abfrage pro Sekunde begrenzt.",
        ["Cover Art Fetcher"] = "Cover-Abruf",
        ["Fetch cover for current album"] = "Cover für aktuelles Album abrufen",
        ["Pending cover requests (%s)"] = "Ausstehende Cover-Anfragen (%s)",
        ["unavailable"] = "nicht verfügbar",
        ["Pending cover requests"] = "Ausstehende Cover-Anfragen",
        ["%d saved request(s)"] = "%d gespeicherte Anfrage(n)",
        ["A request is downloading"] = "Eine Anfrage wird heruntergeladen",
        ["Waiting for connection or retry time"] = "Warte auf Verbindung oder Wiederholungszeitpunkt",
        ["Retry pending downloads"] = "Ausstehende Downloads wiederholen",
        ["Clear pending requests…"] = "Ausstehende Anfragen löschen…",
        ["Clear pending requests?"] = "Ausstehende Anfragen löschen?",
        ["Keep requests"] = "Anfragen behalten",
        ["Clear requests"] = "Anfragen löschen",
        ["Pending requests cleared"] = "Ausstehende Anfragen gelöscht",
        ["Could not save queue change"] = "Änderung der Warteschlange konnte nicht gespeichert werden",
        ["Automatic fetch"] = "Automatischer Abruf",
        ["Revert cover for current album"] = "Cover für aktuelles Album zurücksetzen",
        ["Repair shared folder artwork"] = "Geteiltes Ordner-Cover reparieren",
        ["How it works"] = "Funktionsweise",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Gespeicherte Cover-Anfragen konnten nicht gelesen werden; prüfe die Einstellungen von Cover-Abruf",
    },
    es = {
        ["Fetching cover art"] = "Buscando carátula",
        ["Cover fetch in progress"] = "Búsqueda de carátula en curso",
        ["Cover fetch already in progress — %s"] = "Ya hay una búsqueda de carátula en curso — %s",
        ["Could not read saved cover requests"] = "No se pudieron leer las solicitudes de carátula guardadas",
        ["Album tags or path are not supported"] = "Las etiquetas o la ruta del álbum no son compatibles",
        ["Could not update saved cover request"] = "No se pudo actualizar la solicitud de carátula guardada",
        ["Cover request is already saved"] = "La solicitud de carátula ya está guardada",
        ["Cover fetch queued"] = "Búsqueda de carátula en cola",
        ["Saved cover request queue is full"] = "La cola de solicitudes de carátula está llena",
        ["Could not save request; it was not queued"] = "No se pudo guardar la solicitud; no se puso en cola",
        ["Cover request saved for download"] = "Solicitud de carátula guardada para descargar",
        ["Could not save retry request"] = "No se pudo guardar la solicitud de reintento",
        ["This player cannot track downloaded covers"] = "Este reproductor no puede registrar carátulas descargadas",
        ["Download history is unavailable; cover not saved"] = "El historial de descargas no está disponible; carátula no guardada",
        ["Download history for this album is being checked"] = "Se está comprobando el historial de descargas de este álbum",
        ["This album's path is too long to record; cover not saved"] = "La ruta de este álbum es demasiado larga para registrarla; carátula no guardada",
        ["Download history is full; cover not saved"] = "El historial de descargas está lleno; carátula no guardada",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "Hay un archivo .compas-fetch en la carpeta de este álbum; carátula no guardada",
        ["Could not record the download; cover not saved"] = "No se pudo registrar la descarga; carátula no guardada",
        ["Could not save album sidecar"] = "No se pudo guardar la carátula del álbum",
        ["Saved %s"] = "Guardado %s",
        ["Cover request queued for retry"] = "Solicitud de carátula en cola para reintentar",
        ["No cover art for this release"] = "No hay carátula para este lanzamiento",
        ["Could not match this album conservatively"] = "No se pudo encontrar una coincidencia segura para este álbum",
        ["Too many MusicBrainz matches to choose safely"] = "Demasiadas coincidencias en MusicBrainz para elegir con seguridad",
        ["%s already present"] = "%s ya existe",
        ["Cover fetch failed (network)"] = "Falló la descarga de la carátula (red)",
        ["Saving cover…"] = "Guardando carátula…",
        ["Downloading cover…"] = "Descargando carátula…",
        ["Checking Cover Art Archive…"] = "Consultando Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "Buscando en MusicBrainz…",
        ["Cover fetch already queued"] = "La búsqueda de carátula ya está en cola",
        ["This player cannot fetch cover art"] = "Este reproductor no puede descargar carátulas",
        ["Album tag has leading or trailing spaces; cover not saved"] = "La etiqueta del álbum tiene espacios al inicio o al final; carátula no guardada",
        ["Could not identify this indexed album safely"] = "No se pudo identificar este álbum indexado de forma segura",
        ["Could not check saved cover requests; nothing was changed"] = "No se pudieron comprobar las solicitudes guardadas; no se cambió nada",
        ["This cover cannot be reverted"] = "Esta carátula no se puede revertir",
        ["A fetch for this album is running; try again when it finishes"] = "Hay una descarga en curso para este álbum; inténtalo cuando termine",
        ["The cover is missing; nothing was changed"] = "Falta la carátula; no se cambió nada",
        ["The cover was changed or replaced; nothing was changed"] = "La carátula fue modificada o reemplazada; no se cambió nada",
        ["No free backup name; nothing was changed"] = "No hay nombre de respaldo libre; no se cambió nada",
        ["Could not clear queued request; nothing was changed"] = "No se pudo borrar la solicitud en cola; no se cambió nada",
        ["Could not record the revert; nothing was changed"] = "No se pudo registrar la reversión; no se cambió nada",
        ["Could not rename the cover; nothing was changed"] = "No se pudo renombrar la carátula; no se cambió nada",
        ["checking"] = "comprobando",
        ["saved"] = "guardada",
        ["not saved"] = "no guardada",
        ["reverted"] = "revertida",
        ["missing"] = "no encontrada",
        ["Download history is unavailable"] = "El historial de descargas no está disponible",
        ["No downloaded covers recorded"] = "No hay carátulas descargadas registradas",
        ["Newer"] = "Más recientes",
        ["Older"] = "Más antiguas",
        ["Downloaded covers"] = "Carátulas descargadas",
        ["Album: %s"] = "Álbum: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Recorded: %s"] = "Registrado: %s",
        ["Size: %d bytes"] = "Tamaño: %d bytes",
        ["Status: %s"] = "Estado: %s",
        ["Backup"] = "Respaldo",
        ["Revert: rename to %s"] = "Revertir: renombrar a %s",
        ["Cancel"] = "Cancelar",
        ["Downloaded cover"] = "Carátula descargada",
        ["Cover reverted. Use Reload cover if it still shows"] = "Carátula revertida. Usa Recargar carátula si aún aparece",
        ["No files changed"] = "No se modificaron archivos",
        ["Play a local track first"] = "Reproduce primero una pista local",
        ["No downloaded cover recorded for this album"] = "No hay ninguna carátula descargada registrada para este álbum",
        ["This album"] = "Este álbum",
        ["Tracks at the top of the card are not repaired"] = "Las pistas en la raíz de la tarjeta no se reparan",
        ["Update the music database, then try again"] = "Actualiza la base de datos de música e inténtalo de nuevo",
        ["The track changed; try again"] = "La pista cambió; inténtalo de nuevo",
        ["Library is too large to check safely"] = "La biblioteca es demasiado grande para comprobarla de forma segura",
        ["Could not check folder artwork"] = "No se pudo comprobar la carátula de la carpeta",
        ["Shared artwork found, but no safe backup name is free"] = "Se encontró carátula compartida, pero no hay nombre de respaldo libre",
        ["No shared generic artwork affects this album"] = "Ninguna carátula genérica compartida afecta a este álbum",
        ["Rename %d file to %s"] = "Renombrar %d archivo a %s",
        ["Rename %d files to %s"] = "Renombrar %d archivos a %s",
        ["Shared folder artwork"] = "Carátula de carpeta compartida",
        ["Renamed %d, could not rename %d"] = "Renombrados: %d, sin renombrar: %d",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "Renombrados: %d. Usa Recargar carátula si aún se muestra la anterior",
        ["About Cover Art Fetcher"] = "Acerca del Buscador de carátulas",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Busca el álbum actual en MusicBrainz y descarga un JPEG frontal de 500px (o 250px) de Cover Art Archive como <título del álbum>.jpg junto a la pista.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Nunca sobrescribe una carátula existente. La búsqueda es conservadora: las etiquetas indexadas deben coincidir con la reproducción y los nombres de álbum no deben colisionar entre carpetas cercanas o artistas.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "La API de Lua no puede ver imágenes incrustadas en los archivos de audio, por lo que esos álbumes aún pueden recibir un archivo de carátula en la carpeta.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Una imagen genérica cover o folder junto a la pista, o una carpeta más arriba, puede mostrarse en todos los álbumes de esa ubicación. Reparar carátula de carpeta compartida enumera esos archivos y los renombra a .compas-backup solo tras tu confirmación.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Cada carátula que guarda este plugin se registra con su ruta exacta, tamaño y huella. Carátulas descargadas te permite revertir una: tras confirmar, se renombra a .compas-backup si sigue siendo exactamente el archivo guardado. Los archivos que hayas añadido o cambiado nunca se tocan.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Las solicitudes de carátulas faltantes se guardan antes de descargar y se reanudan cuando vuelve el Wi-Fi, incluso tras reiniciar. Solicitudes pendientes te permite reintentarlas o borrarlas.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "El modo automático está desactivado hasta que lo actives. MusicBrainz está limitado a una consulta por segundo.",
        ["Cover Art Fetcher"] = "Buscador de carátulas",
        ["Fetch cover for current album"] = "Buscar carátula del álbum actual",
        ["Pending cover requests (%s)"] = "Solicitudes de carátula pendientes (%s)",
        ["unavailable"] = "no disponible",
        ["Pending cover requests"] = "Solicitudes de carátula pendientes",
        ["%d saved request(s)"] = "%d solicitud(es) guardada(s)",
        ["A request is downloading"] = "Se está descargando una solicitud",
        ["Waiting for connection or retry time"] = "Esperando conexión o tiempo de reintento",
        ["Retry pending downloads"] = "Reintentar descargas pendientes",
        ["Clear pending requests…"] = "Borrar solicitudes pendientes…",
        ["Clear pending requests?"] = "¿Borrar solicitudes pendientes?",
        ["Keep requests"] = "Conservar solicitudes",
        ["Clear requests"] = "Borrar solicitudes",
        ["Pending requests cleared"] = "Solicitudes pendientes borradas",
        ["Could not save queue change"] = "No se pudo guardar el cambio en la cola",
        ["Automatic fetch"] = "Búsqueda automática",
        ["Revert cover for current album"] = "Revertir carátula del álbum actual",
        ["Repair shared folder artwork"] = "Reparar carátula de carpeta compartida",
        ["How it works"] = "Cómo funciona",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "No se pudieron leer las solicitudes de carátula guardadas; revisa los ajustes del Buscador de carátulas",
    },
    fi = {
        ["Fetching cover art"] = "Haetaan kansikuvaa",
        ["Cover fetch in progress"] = "Kansikuvan haku käynnissä",
        ["Cover fetch already in progress — %s"] = "Kansikuvan haku on jo käynnissä — %s",
        ["Could not read saved cover requests"] = "Tallennettuja kansikuvapyyntöjä ei voitu lukea",
        ["Album tags or path are not supported"] = "Albumin tunnisteita tai polkua ei tueta",
        ["Could not update saved cover request"] = "Tallennettua kansikuvapyyntöä ei voitu päivittää",
        ["Cover request is already saved"] = "Kansikuvapyyntö on jo tallennettu",
        ["Cover fetch queued"] = "Kansikuvan haku jonossa",
        ["Saved cover request queue is full"] = "Tallennettujen kansikuvapyyntöjen jono on täynnä",
        ["Could not save request; it was not queued"] = "Pyyntöä ei voitu tallentaa; sitä ei lisätty jonoon",
        ["Cover request saved for download"] = "Kansikuvapyyntö tallennettu latausta varten",
        ["Could not save retry request"] = "Uudelleenyrityspyyntöä ei voitu tallentaa",
        ["This player cannot track downloaded covers"] = "Tämä soitin ei voi seurata ladattuja kansikuvia",
        ["Download history is unavailable; cover not saved"] = "Lataushistoria ei ole käytettävissä; kantta ei tallennettu",
        ["Download history for this album is being checked"] = "Tämän albumin lataushistoriaa tarkistetaan",
        ["This album's path is too long to record; cover not saved"] = "Albumin polku on liian pitkä kirjattavaksi; kantta ei tallennettu",
        ["Download history is full; cover not saved"] = "Lataushistoria on täynnä; kantta ei tallennettu",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "Albumin kansiossa on .compas-fetch-tiedosto; kantta ei tallennettu",
        ["Could not record the download; cover not saved"] = "Latausta ei voitu kirjata; kantta ei tallennettu",
        ["Could not save album sidecar"] = "Albumin kansikuvaa ei voitu tallentaa",
        ["Saved %s"] = "Tallennettu %s",
        ["Cover request queued for retry"] = "Kansikuvapyyntö asetettu jonoon uudelleenyritystä varten",
        ["No cover art for this release"] = "Tälle julkaisulle ei ole kansikuvaa",
        ["Could not match this album conservatively"] = "Albumia ei voitu yhdistää varmasti",
        ["Too many MusicBrainz matches to choose safely"] = "Liikaa MusicBrainz-osumia turvalliseen valintaan",
        ["%s already present"] = "%s on jo olemassa",
        ["Cover fetch failed (network)"] = "Kansikuvan haku epäonnistui (verkko)",
        ["Saving cover…"] = "Tallennetaan kansikuvaa…",
        ["Downloading cover…"] = "Ladataan kansikuvaa…",
        ["Checking Cover Art Archive…"] = "Tarkistetaan Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "Haetaan MusicBrainzista…",
        ["Cover fetch already queued"] = "Kansikuvan haku on jo jonossa",
        ["This player cannot fetch cover art"] = "Tämä soitin ei voi hakea kansikuvia",
        ["Album tag has leading or trailing spaces; cover not saved"] = "Albumin tunnisteessa on välilyöntejä alussa tai lopussa; kantta ei tallennettu",
        ["Could not identify this indexed album safely"] = "Indeksoitua albumia ei voitu tunnistaa turvallisesti",
        ["Could not check saved cover requests; nothing was changed"] = "Tallennettuja pyyntöjä ei voitu tarkistaa; mitään ei muutettu",
        ["This cover cannot be reverted"] = "Tätä kansikuvaa ei voi palauttaa",
        ["A fetch for this album is running; try again when it finishes"] = "Tämän albumin haku on käynnissä; yritä uudelleen sen valmistuttua",
        ["The cover is missing; nothing was changed"] = "Kansikuva puuttuu; mitään ei muutettu",
        ["The cover was changed or replaced; nothing was changed"] = "Kansikuvaa on muutettu tai se on korvattu; mitään ei muutettu",
        ["No free backup name; nothing was changed"] = "Vapaata varmuuskopionimeä ei ole; mitään ei muutettu",
        ["Could not clear queued request; nothing was changed"] = "Jonossa olevaa pyyntöä ei voitu poistaa; mitään ei muutettu",
        ["Could not record the revert; nothing was changed"] = "Palautusta ei voitu kirjata; mitään ei muutettu",
        ["Could not rename the cover; nothing was changed"] = "Kansikuvaa ei voitu nimetä uudelleen; mitään ei muutettu",
        ["checking"] = "tarkistetaan",
        ["saved"] = "tallennettu",
        ["not saved"] = "ei tallennettu",
        ["reverted"] = "palautettu",
        ["missing"] = "puuttuu",
        ["Download history is unavailable"] = "Lataushistoria ei ole käytettävissä",
        ["No downloaded covers recorded"] = "Ei kirjattuja ladattuja kansikuvia",
        ["Newer"] = "Uudemmat",
        ["Older"] = "Vanhemmat",
        ["Downloaded covers"] = "Ladatut kansikuvat",
        ["Album: %s"] = "Albumi: %s",
        ["Artist: %s"] = "Esittäjä: %s",
        ["Recorded: %s"] = "Kirjattu: %s",
        ["Size: %d bytes"] = "Koko: %d tavua",
        ["Status: %s"] = "Tila: %s",
        ["Backup"] = "Varmuuskopio",
        ["Revert: rename to %s"] = "Palauta: nimeä muotoon %s",
        ["Cancel"] = "Peruuta",
        ["Downloaded cover"] = "Ladattu kansikuva",
        ["Cover reverted. Use Reload cover if it still shows"] = "Kansikuva palautettu. Käytä Lataa kansi uudelleen, jos se näkyy yhä",
        ["No files changed"] = "Tiedostoja ei muutettu",
        ["Play a local track first"] = "Toista ensin paikallinen kappale",
        ["No downloaded cover recorded for this album"] = "Tälle albumille ei ole kirjattu ladattua kansikuvaa",
        ["This album"] = "Tämä albumi",
        ["Tracks at the top of the card are not repaired"] = "Kortin juuressa olevia kappaleita ei korjata",
        ["Update the music database, then try again"] = "Päivitä musiikkitietokanta ja yritä uudelleen",
        ["The track changed; try again"] = "Kappale vaihtui; yritä uudelleen",
        ["Library is too large to check safely"] = "Kirjasto on liian suuri turvalliseen tarkistukseen",
        ["Could not check folder artwork"] = "Kansion kansikuvaa ei voitu tarkistaa",
        ["Shared artwork found, but no safe backup name is free"] = "Jaettu kansikuva löytyi, mutta vapaata varmuuskopionimeä ei ole",
        ["No shared generic artwork affects this album"] = "Yksikään jaettu yleinen kansikuva ei vaikuta tähän albumiin",
        ["Rename %d file to %s"] = "Nimeä %d tiedosto muotoon %s",
        ["Rename %d files to %s"] = "Nimeä %d tiedostoa muotoon %s",
        ["Shared folder artwork"] = "Jaettu kansion kansikuva",
        ["Renamed %d, could not rename %d"] = "Nimetty uudelleen %d, epäonnistui %d",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "Nimetty uudelleen %d. Käytä Lataa kansi uudelleen, jos vanha kuva näkyy yhä",
        ["About Cover Art Fetcher"] = "Tietoja Kansikuvien noutajasta",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Etsii nykyisen albumin MusicBrainzista ja lataa 500px (tai 250px) JPEG-etukannen Cover Art Archivesta nimellä <albumin nimi>.jpg kappaleen viereen.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Ei koskaan korvaa olemassa olevaa kansitiedostoa. Yhdistäminen on varovaista: indeksoitujen tunnisteiden on vastattava toistoa eivätkä albumin nimet saa törmätä läheisten kansioiden tai esittäjien kesken.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "Lua-API ei näe äänitiedostoihin upotettuja kuvia, joten niillekin albumeille voidaan ladata kansiotiedosto.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Yleinen cover- tai folder-kuva kappaleen vieressä tai ylemmässä kansiossa voi näkyä kaikille kansion albumeille. Korjaa jaettu kansion kansikuva listaa nämä tiedostot ja nimeää ne muotoon .compas-backup vasta vahvistuksesi jälkeen.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Jokainen lisäosan tallentama kansi kirjataan polun, koon ja tarkistussumman kanssa. Ladatut kansikuvat -kohdasta voit palauttaa kannen: vahvistuksen jälkeen se nimetään muotoon .compas-backup, jos tiedosto on yhä täsmälleen sama.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Puuttuvien kansien pyynnöt tallennetaan ennen latausta ja jatkuvat Wi-Fi-yhteyden palatessa, myös uudelleenkäynnistyksen jälkeen. Odottavat kansikuvapyynnöt -kohdasta voit yrittää niitä uudelleen tai tyhjentää ne.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "Automaattinen tila on pois päältä, kunnes otat sen käyttöön. MusicBrainz on rajoitettu yhteen hakuun sekunnissa.",
        ["Cover Art Fetcher"] = "Kansikuvien noutaja",
        ["Fetch cover for current album"] = "Hae kansikuva nykyiselle albumille",
        ["Pending cover requests (%s)"] = "Odottavat kansikuvapyynnöt (%s)",
        ["unavailable"] = "ei saatavilla",
        ["Pending cover requests"] = "Odottavat kansikuvapyynnöt",
        ["%d saved request(s)"] = "%d tallennettu(a) pyyntö(ä)",
        ["A request is downloading"] = "Pyyntöä ladataan parhaillaan",
        ["Waiting for connection or retry time"] = "Odotetaan yhteyttä tai uudelleenyritysaikaa",
        ["Retry pending downloads"] = "Yritä odottavia latauksia uudelleen",
        ["Clear pending requests…"] = "Tyhjennä odottavat pyynnöt…",
        ["Clear pending requests?"] = "Tyhjennetäänkö odottavat pyynnöt?",
        ["Keep requests"] = "Säilytä pyynnöt",
        ["Clear requests"] = "Tyhjennä pyynnöt",
        ["Pending requests cleared"] = "Odottavat pyynnöt tyhjennetty",
        ["Could not save queue change"] = "Jonon muutosta ei voitu tallentaa",
        ["Automatic fetch"] = "Automaattinen haku",
        ["Revert cover for current album"] = "Palauta nykyisen albumin kansikuva",
        ["Repair shared folder artwork"] = "Korjaa jaettu kansion kansikuva",
        ["How it works"] = "Miten se toimii",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Tallennettuja kansikuvapyyntöjä ei voitu lukea; tarkista Kansikuvien noutajan asetukset",
    },
    fr = {
        ["Fetching cover art"] = "Récupération de la pochette",
        ["Cover fetch in progress"] = "Récupération de la pochette en cours",
        ["Cover fetch already in progress — %s"] = "Récupération déjà en cours — %s",
        ["Could not read saved cover requests"] = "Impossible de lire les demandes de pochettes enregistrées",
        ["Album tags or path are not supported"] = "Les tags de l'album ou le chemin ne sont pas pris en charge",
        ["Could not update saved cover request"] = "Impossible de mettre à jour la demande enregistrée",
        ["Cover request is already saved"] = "La demande de pochette est déjà enregistrée",
        ["Cover fetch queued"] = "Récupération mise en file d'attente",
        ["Saved cover request queue is full"] = "La file des demandes de pochettes est pleine",
        ["Could not save request; it was not queued"] = "Impossible d'enregistrer la demande ; non ajoutée à la file",
        ["Cover request saved for download"] = "Demande de pochette enregistrée pour téléchargement",
        ["Could not save retry request"] = "Impossible d'enregistrer la relance",
        ["This player cannot track downloaded covers"] = "Ce lecteur ne peut pas suivre les pochettes téléchargées",
        ["Download history is unavailable; cover not saved"] = "Historique indisponible ; pochette non enregistrée",
        ["Download history for this album is being checked"] = "Vérification de l'historique pour cet album en cours",
        ["This album's path is too long to record; cover not saved"] = "Chemin de l'album trop long ; pochette non enregistrée",
        ["Download history is full; cover not saved"] = "Historique plein ; pochette non enregistrée",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "Un fichier .compas-fetch existe dans le dossier ; pochette non enregistrée",
        ["Could not record the download; cover not saved"] = "Impossible d'enregistrer le suivi ; pochette non enregistrée",
        ["Could not save album sidecar"] = "Impossible d'enregistrer le fichier de pochette",
        ["Saved %s"] = "%s enregistré",
        ["Cover request queued for retry"] = "Demande mise en attente pour nouvel essai",
        ["No cover art for this release"] = "Aucune pochette pour cette parution",
        ["Could not match this album conservatively"] = "Impossible d'associer cet album avec certitude",
        ["Too many MusicBrainz matches to choose safely"] = "Trop de résultats MusicBrainz pour choisir sans risque",
        ["%s already present"] = "%s déjà présent",
        ["Cover fetch failed (network)"] = "Échec de récupération de la pochette (réseau)",
        ["Saving cover…"] = "Enregistrement de la pochette…",
        ["Downloading cover…"] = "Téléchargement de la pochette…",
        ["Checking Cover Art Archive…"] = "Vérification de Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "Recherche sur MusicBrainz…",
        ["Cover fetch already queued"] = "Récupération déjà en file d'attente",
        ["This player cannot fetch cover art"] = "Ce lecteur ne peut pas récupérer de pochettes",
        ["Album tag has leading or trailing spaces; cover not saved"] = "Le tag d'album contient des espaces superflus ; pochette non enregistrée",
        ["Could not identify this indexed album safely"] = "Impossible d'identifier cet album indexé de façon sûre",
        ["Could not check saved cover requests; nothing was changed"] = "Impossible de vérifier les demandes enregistrées ; rien n'a été modifié",
        ["This cover cannot be reverted"] = "Cette pochette ne peut pas être annulée",
        ["A fetch for this album is running; try again when it finishes"] = "Un téléchargement est en cours pour cet album ; réessayez à la fin",
        ["The cover is missing; nothing was changed"] = "La pochette est introuvable ; rien n'a été modifié",
        ["The cover was changed or replaced; nothing was changed"] = "La pochette a été modifiée ou remplacée ; rien n'a été modifié",
        ["No free backup name; nothing was changed"] = "Aucun nom de sauvegarde disponible ; rien n'a été modifié",
        ["Could not clear queued request; nothing was changed"] = "Impossible d'effacer la demande en attente ; rien n'a été modifié",
        ["Could not record the revert; nothing was changed"] = "Impossible d'enregistrer l'annulation ; rien n'a été modifié",
        ["Could not rename the cover; nothing was changed"] = "Impossible de renommer la pochette ; rien n'a été modifié",
        ["checking"] = "vérification",
        ["saved"] = "enregistrée",
        ["not saved"] = "non enregistrée",
        ["reverted"] = "annulée",
        ["missing"] = "manquante",
        ["Download history is unavailable"] = "Historique des téléchargements indisponible",
        ["No downloaded covers recorded"] = "Aucune pochette téléchargée enregistrée",
        ["Newer"] = "Plus récentes",
        ["Older"] = "Plus anciennes",
        ["Downloaded covers"] = "Pochettes téléchargées",
        ["Album: %s"] = "Album : %s",
        ["Artist: %s"] = "Artiste : %s",
        ["Recorded: %s"] = "Enregistré : %s",
        ["Size: %d bytes"] = "Taille : %d octets",
        ["Status: %s"] = "État : %s",
        ["Backup"] = "Sauvegarde",
        ["Revert: rename to %s"] = "Annuler : renommer en %s",
        ["Cancel"] = "Annuler",
        ["Downloaded cover"] = "Pochette téléchargée",
        ["Cover reverted. Use Reload cover if it still shows"] = "Pochette annulée. Utilisez Recharger la pochette si elle s'affiche encore",
        ["No files changed"] = "Aucun fichier modifié",
        ["Play a local track first"] = "Lisez d'abord une piste locale",
        ["No downloaded cover recorded for this album"] = "Aucune pochette téléchargée enregistrée pour cet album",
        ["This album"] = "Cet album",
        ["Tracks at the top of the card are not repaired"] = "Les pistes à la racine de la carte ne sont pas réparées",
        ["Update the music database, then try again"] = "Mettez à jour la base musicale puis réessayez",
        ["The track changed; try again"] = "La piste a changé ; réessayez",
        ["Library is too large to check safely"] = "La bibliothèque est trop grande pour être vérifiée",
        ["Could not check folder artwork"] = "Impossible de vérifier les illustrations du dossier",
        ["Shared artwork found, but no safe backup name is free"] = "Illustration partagée trouvée, mais aucun nom de sauvegarde disponible",
        ["No shared generic artwork affects this album"] = "Aucune illustration générique partagée n'affecte cet album",
        ["Rename %d file to %s"] = "Renommer %d fichier en %s",
        ["Rename %d files to %s"] = "Renommer %d fichiers en %s",
        ["Shared folder artwork"] = "Illustration de dossier partagée",
        ["Renamed %d, could not rename %d"] = "%d renommé(s), %d échec(s)",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "%d renommé(s). Utilisez Recharger la pochette si l'ancienne apparaît encore",
        ["About Cover Art Fetcher"] = "À propos du Récupérateur de pochettes",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Recherche l'album actuel sur MusicBrainz et télécharge un JPEG recto de 500px (ou 250px) depuis Cover Art Archive sous le nom <titre de l'album>.jpg à côté de la piste.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "N'écrase jamais une pochette existante. La correspondance est prudente : les tags indexés doivent correspondre à la lecture et les noms d'albums ne doivent pas entrer en conflit avec les dossiers voisins.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "L'API Lua ne voit pas les images intégrées aux fichiers audio ; ces albums peuvent donc tout de même recevoir un fichier de pochette.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Une image générique cover ou folder à côté de la piste, ou dans le dossier parent, peut s'afficher pour tous les albums présents. Réparer l'illustration partagée liste ces fichiers et les renomme en .compas-backup après confirmation.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Chaque pochette enregistrée par ce plugin est suivie avec son chemin, sa taille et son empreinte. Pochettes téléchargées permet d'en annuler une : après confirmation, elle est renommée en .compas-backup si le fichier est resté identique.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Les demandes sont enregistrées avant le téléchargement et reprennent au retour du Wi-Fi, même après redémarrage. Demandes en attente permet de les relancer ou de les effacer.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "Le mode automatique est désactivé tant que vous ne l'activez pas. MusicBrainz est limité à une requête par seconde.",
        ["Cover Art Fetcher"] = "Récupérateur de pochettes",
        ["Fetch cover for current album"] = "Récupérer la pochette de l'album actuel",
        ["Pending cover requests (%s)"] = "Demandes de pochettes en attente (%s)",
        ["unavailable"] = "indisponible",
        ["Pending cover requests"] = "Demandes de pochettes en attente",
        ["%d saved request(s)"] = "%d demande(s) enregistrée(s)",
        ["A request is downloading"] = "Un téléchargement est en cours",
        ["Waiting for connection or retry time"] = "En attente de connexion ou du prochain essai",
        ["Retry pending downloads"] = "Relancer les téléchargements en attente",
        ["Clear pending requests…"] = "Effacer les demandes en attente…",
        ["Clear pending requests?"] = "Effacer les demandes en attente ?",
        ["Keep requests"] = "Garder les demandes",
        ["Clear requests"] = "Effacer les demandes",
        ["Pending requests cleared"] = "Demandes en attente effacées",
        ["Could not save queue change"] = "Impossible d'enregistrer la modification de la file",
        ["Automatic fetch"] = "Récupération automatique",
        ["Revert cover for current album"] = "Annuler la pochette de l'album actuel",
        ["Repair shared folder artwork"] = "Réparer l'illustration de dossier partagée",
        ["How it works"] = "Fonctionnement",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Impossible de lire les demandes enregistrées ; vérifiez les paramètres du Récupérateur de pochettes",
    },
    it = {
        ["Fetching cover art"] = "Recupero copertina",
        ["Cover fetch in progress"] = "Recupero copertina in corso",
        ["Cover fetch already in progress — %s"] = "Recupero copertina già in corso — %s",
        ["Could not read saved cover requests"] = "Impossibile leggere le richieste di copertina salvate",
        ["Album tags or path are not supported"] = "Tag dell'album o percorso non supportati",
        ["Could not update saved cover request"] = "Impossibile aggiornare la richiesta di copertina salvata",
        ["Cover request is already saved"] = "La richiesta di copertina è già salvata",
        ["Cover fetch queued"] = "Recupero copertina in coda",
        ["Saved cover request queue is full"] = "La coda delle richieste di copertina è piena",
        ["Could not save request; it was not queued"] = "Impossibile salvare la richiesta; non è stata messa in coda",
        ["Cover request saved for download"] = "Richiesta di copertina salvata per il download",
        ["Could not save retry request"] = "Impossibile salvare la richiesta di nuovo tentativo",
        ["This player cannot track downloaded covers"] = "Questo lettore non può tenere traccia delle copertine scaricate",
        ["Download history is unavailable; cover not saved"] = "Cronologia download non disponibile; copertina non salvata",
        ["Download history for this album is being checked"] = "Verifica della cronologia download per questo album in corso",
        ["This album's path is too long to record; cover not saved"] = "Percorso dell'album troppo lungo per essere registrato; copertina non salvata",
        ["Download history is full; cover not saved"] = "Cronologia download piena; copertina non salvata",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "File .compas-fetch presente nella cartella dell'album; copertina non salvata",
        ["Could not record the download; cover not saved"] = "Impossibile registrare il download; copertina non salvata",
        ["Could not save album sidecar"] = "Impossibile salvare il file copertina dell'album",
        ["Saved %s"] = "Salvato %s",
        ["Cover request queued for retry"] = "Richiesta copertina in coda per nuovo tentativo",
        ["No cover art for this release"] = "Nessuna copertina per questa pubblicazione",
        ["Could not match this album conservatively"] = "Impossibile trovare una corrispondenza sicura per questo album",
        ["Too many MusicBrainz matches to choose safely"] = "Troppi risultati su MusicBrainz per scegliere con sicurezza",
        ["%s already present"] = "%s già presente",
        ["Cover fetch failed (network)"] = "Recupero copertina non riuscito (rete)",
        ["Saving cover…"] = "Salvataggio copertina…",
        ["Downloading cover…"] = "Download copertina…",
        ["Checking Cover Art Archive…"] = "Controllo Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "Ricerca su MusicBrainz…",
        ["Cover fetch already queued"] = "Recupero copertina già in coda",
        ["This player cannot fetch cover art"] = "Questo lettore non può scaricare copertine",
        ["Album tag has leading or trailing spaces; cover not saved"] = "Il tag album ha spazi iniziali o finali; copertina non salvata",
        ["Could not identify this indexed album safely"] = "Impossibile identificare in modo sicuro questo album indicizzato",
        ["Could not check saved cover requests; nothing was changed"] = "Impossibile controllare le richieste salvate; nessuna modifica effettuata",
        ["This cover cannot be reverted"] = "Questa copertina non può essere ripristinata",
        ["A fetch for this album is running; try again when it finishes"] = "Download in corso per questo album; riprova al termine",
        ["The cover is missing; nothing was changed"] = "La copertina manca; nessuna modifica effettuata",
        ["The cover was changed or replaced; nothing was changed"] = "La copertina è stata modificata o sostituita; nessuna modifica effettuata",
        ["No free backup name; nothing was changed"] = "Nessun nome di backup disponibile; nessuna modifica effettuata",
        ["Could not clear queued request; nothing was changed"] = "Impossibile rimuovere la richiesta in coda; nessuna modifica effettuata",
        ["Could not record the revert; nothing was changed"] = "Impossibile registrare il ripristino; nessuna modifica effettuata",
        ["Could not rename the cover; nothing was changed"] = "Impossibile rinominare la copertina; nessuna modifica effettuata",
        ["checking"] = "verifica",
        ["saved"] = "salvata",
        ["not saved"] = "non salvata",
        ["reverted"] = "ripristinata",
        ["missing"] = "mancante",
        ["Download history is unavailable"] = "Cronologia download non disponibile",
        ["No downloaded covers recorded"] = "Nessuna copertina scaricata registrata",
        ["Newer"] = "Più recenti",
        ["Older"] = "Più vecchie",
        ["Downloaded covers"] = "Copertine scaricate",
        ["Album: %s"] = "Album: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Recorded: %s"] = "Registrato: %s",
        ["Size: %d bytes"] = "Dimensione: %d byte",
        ["Status: %s"] = "Stato: %s",
        ["Backup"] = "Backup",
        ["Revert: rename to %s"] = "Ripristina: rinomina in %s",
        ["Cancel"] = "Annulla",
        ["Downloaded cover"] = "Copertina scaricata",
        ["Cover reverted. Use Reload cover if it still shows"] = "Copertina ripristinata. Usa Ricarica copertina se è ancora visibile",
        ["No files changed"] = "Nessun file modificato",
        ["Play a local track first"] = "Riproduci prima una traccia locale",
        ["No downloaded cover recorded for this album"] = "Nessuna copertina scaricata registrata per questo album",
        ["This album"] = "Questo album",
        ["Tracks at the top of the card are not repaired"] = "Le tracce nella radice della scheda non vengono riparate",
        ["Update the music database, then try again"] = "Aggiorna il database musicale e riprova",
        ["The track changed; try again"] = "La traccia è cambiata; riprova",
        ["Library is too large to check safely"] = "La libreria è troppo grande per un controllo sicuro",
        ["Could not check folder artwork"] = "Impossibile verificare le immagini della cartella",
        ["Shared artwork found, but no safe backup name is free"] = "Trovata copertina condivisa, ma nessun nome di backup è libero",
        ["No shared generic artwork affects this album"] = "Nessuna copertina generica condivisa influisce su questo album",
        ["Rename %d file to %s"] = "Rinomina %d file in %s",
        ["Rename %d files to %s"] = "Rinomina %d file in %s",
        ["Shared folder artwork"] = "Copertina cartella condivisa",
        ["Renamed %d, could not rename %d"] = "Rinominati %d, non rinominati %d",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "Rinominati %d. Usa Ricarica copertina se appare ancora quella vecchia",
        ["About Cover Art Fetcher"] = "Informazioni su Recupero copertine",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Cerca l'album attuale su MusicBrainz e scarica un JPEG frontale da 500px (o 250px) da Cover Art Archive come <titolo album>.jpg accanto alla traccia.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Non sovrascrive mai una copertina esistente. La corrispondenza è prudente: i tag indicizzati devono corrispondere alla riproduzione e i nomi degli album non devono entrare in conflitto tra cartelle vicine o artisti.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "L'API Lua non rileva le immagini incorporate nei file audio, quindi anche quegli album potrebbero ricevere un file di copertina nella cartella.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Un'immagine generica cover o folder accanto alla traccia, o nella cartella superiore, può apparire per ogni album presente. Ripara copertina cartella condivisa elenca questi file e li rinomina in .compas-backup solo dopo la tua conferma.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Ogni copertina salvata da questo plugin viene registrata con percorso, dimensione e impronta. Copertine scaricate ti permette di annullarne una: dopo la conferma, viene rinominata in .compas-backup se il file è rimasto identico.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Le richieste di copertine mancanti vengono salvate prima del download e riprendono quando torna il Wi-Fi, anche dopo un riavvio. Richieste di copertina in sospeso ti permette di riprovarle o cancellarle.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "La modalità automatica è disattivata finché non la attivi. MusicBrainz è limitato a una ricerca al secondo.",
        ["Cover Art Fetcher"] = "Recupero copertine",
        ["Fetch cover for current album"] = "Scarica copertina per l'album attuale",
        ["Pending cover requests (%s)"] = "Richieste di copertina in sospeso (%s)",
        ["unavailable"] = "non disponibile",
        ["Pending cover requests"] = "Richieste di copertina in sospeso",
        ["%d saved request(s)"] = "%d richiesta/e salvata/e",
        ["A request is downloading"] = "Una richiesta è in fase di download",
        ["Waiting for connection or retry time"] = "In attesa di connessione o del prossimo tentativo",
        ["Retry pending downloads"] = "Riprova download in sospeso",
        ["Clear pending requests…"] = "Cancella richieste in sospeso…",
        ["Clear pending requests?"] = "Cancellare le richieste in sospeso?",
        ["Keep requests"] = "Mantieni richieste",
        ["Clear requests"] = "Cancella richieste",
        ["Pending requests cleared"] = "Richieste in sospeso cancellate",
        ["Could not save queue change"] = "Impossibile salvare la modifica alla coda",
        ["Automatic fetch"] = "Recupero automatico",
        ["Revert cover for current album"] = "Ripristina copertina dell'album attuale",
        ["Repair shared folder artwork"] = "Ripara copertina cartella condivisa",
        ["How it works"] = "Come funziona",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Impossibile leggere le richieste di copertina salvate; controlla le impostazioni di Recupero copertine",
    },
    ja = {
        ["Fetching cover art"] = "カバーアートを取得中",
        ["Cover fetch in progress"] = "カバーアート取得中",
        ["Cover fetch already in progress — %s"] = "カバーアートは既に取得中です — %s",
        ["Could not read saved cover requests"] = "保存されたカバー取得リクエストを読み込めませんでした",
        ["Album tags or path are not supported"] = "アルバムのタグまたはパスがサポートされていません",
        ["Could not update saved cover request"] = "保存されたカバー取得リクエストを更新できませんでした",
        ["Cover request is already saved"] = "カバー取得リクエストは既に保存されています",
        ["Cover fetch queued"] = "カバー取得をキューに追加しました",
        ["Saved cover request queue is full"] = "保存されたカバー取得リクエストのキューが満杯です",
        ["Could not save request; it was not queued"] = "リクエストを保存できなかったためキューに追加されませんでした",
        ["Cover request saved for download"] = "ダウンロード用のカバー取得リクエストを保存しました",
        ["Could not save retry request"] = "再試行リクエストを保存できませんでした",
        ["This player cannot track downloaded covers"] = "このプレーヤーはダウンロードしたカバーの履歴を記録できません",
        ["Download history is unavailable; cover not saved"] = "ダウンロード履歴を利用できないためカバーを保存しませんでした",
        ["Download history for this album is being checked"] = "このアルバムのダウンロード履歴を確認中です",
        ["This album's path is too long to record; cover not saved"] = "アルバムのパスが長すぎて記録できないため保存しませんでした",
        ["Download history is full; cover not saved"] = "ダウンロード履歴が満杯のためカバーを保存しませんでした",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "フォルダ内に .compas-fetch ファイルがあるため保存しませんでした",
        ["Could not record the download; cover not saved"] = "ダウンロードを記録できなかったためカバーを保存しませんでした",
        ["Could not save album sidecar"] = "アルバムのカバー画像を保存できませんでした",
        ["Saved %s"] = "%s を保存しました",
        ["Cover request queued for retry"] = "カバー取得リクエストを再試行キューに入れました",
        ["No cover art for this release"] = "このリリースのカバーアートはありません",
        ["Could not match this album conservatively"] = "このアルバムを確実に特定できませんでした",
        ["Too many MusicBrainz matches to choose safely"] = "MusicBrainz の候補が多すぎるため安全に選択できません",
        ["%s already present"] = "%s は既に存在します",
        ["Cover fetch failed (network)"] = "カバーの取得に失敗しました (ネットワーク)",
        ["Saving cover…"] = "カバーを保存中…",
        ["Downloading cover…"] = "カバーをダウンロード中…",
        ["Checking Cover Art Archive…"] = "Cover Art Archive を確認中…",
        ["Looking up MusicBrainz…"] = "MusicBrainz を検索中…",
        ["Cover fetch already queued"] = "カバー取得は既にキューに入っています",
        ["This player cannot fetch cover art"] = "このプレーヤーはカバーアートを取得できません",
        ["Album tag has leading or trailing spaces; cover not saved"] = "アルバムタグの前後に空白があるため保存しませんでした",
        ["Could not identify this indexed album safely"] = "インデックス内のアルバムを安全に特定できませんでした",
        ["Could not check saved cover requests; nothing was changed"] = "保存されたリクエストを確認できませんでした。変更はありません",
        ["This cover cannot be reverted"] = "このカバーは元に戻せません",
        ["A fetch for this album is running; try again when it finishes"] = "このアルバムの取得が実行中です。完了後にもう一度お試しください",
        ["The cover is missing; nothing was changed"] = "カバーが見つかりません。変更はありません",
        ["The cover was changed or replaced; nothing was changed"] = "カバーが変更または置換されています。変更はありません",
        ["No free backup name; nothing was changed"] = "利用可能なバックアップ名がありません。変更はありません",
        ["Could not clear queued request; nothing was changed"] = "待機中のリクエストを消去できませんでした。変更はありません",
        ["Could not record the revert; nothing was changed"] = "復元処理を記録できませんでした。変更はありません",
        ["Could not rename the cover; nothing was changed"] = "カバーの名前を変更できませんでした。変更はありません",
        ["checking"] = "確認中",
        ["saved"] = "保存済み",
        ["not saved"] = "未保存",
        ["reverted"] = "復元済み",
        ["missing"] = "不明",
        ["Download history is unavailable"] = "ダウンロード履歴を利用できません",
        ["No downloaded covers recorded"] = "ダウンロードしたカバーの記録がありません",
        ["Newer"] = "新しい順",
        ["Older"] = "古い順",
        ["Downloaded covers"] = "ダウンロード済みカバー",
        ["Album: %s"] = "アルバム: %s",
        ["Artist: %s"] = "アーティスト: %s",
        ["Recorded: %s"] = "記録日時: %s",
        ["Size: %d bytes"] = "サイズ: %d バイト",
        ["Status: %s"] = "状態: %s",
        ["Backup"] = "バックアップ",
        ["Revert: rename to %s"] = "元に戻す: %s に名前変更",
        ["Cancel"] = "キャンセル",
        ["Downloaded cover"] = "ダウンロード済みカバー",
        ["Cover reverted. Use Reload cover if it still shows"] = "カバーを戻しました。まだ表示される場合はカバーの再読み込みを実行してください",
        ["No files changed"] = "ファイルは変更されませんでした",
        ["Play a local track first"] = "先にローカルの曲を再生してください",
        ["No downloaded cover recorded for this album"] = "このアルバムのダウンロード済みカバー記録はありません",
        ["This album"] = "このアルバム",
        ["Tracks at the top of the card are not repaired"] = "カードの最上位にある曲は修復対象外です",
        ["Update the music database, then try again"] = "音楽データベースを更新してからもう一度お試しください",
        ["The track changed; try again"] = "曲が変わりました。もう一度お試しください",
        ["Library is too large to check safely"] = "ライブラリが大きすぎるため安全に確認できません",
        ["Could not check folder artwork"] = "フォルダのカバー画像を確認できませんでした",
        ["Shared artwork found, but no safe backup name is free"] = "共有画像が見つかりましたが、空きバックアップ名がありません",
        ["No shared generic artwork affects this album"] = "このアルバムに影響する共有の汎用カバー画像はありません",
        ["Rename %d file to %s"] = "%d 個のファイルを %s に名前変更",
        ["Rename %d files to %s"] = "%d 個のファイルを %s に名前変更",
        ["Shared folder artwork"] = "共有フォルダのアートワーク",
        ["Renamed %d, could not rename %d"] = "%d 個を変更、%d 個は変更できませんでした",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "%d 個を変更しました。古い画像が残る場合はカバーの再読み込みを使用してください",
        ["About Cover Art Fetcher"] = "カバーアート取得について",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "再生中のアルバムを MusicBrainz で検索し、Cover Art Archive から 500px (または 250px) のフロント JPEG を曲と同じフォルダに <アルバム名>.jpg として保存します。",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "既存のアルバム画像を上書きすることはありません。タグが再生情報と一致し、近くのフォルダや別アーティストのアルバム名と競合しない場合のみ取得します。",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "Lua API は音声ファイル内の埋め込み画像を参照できないため、埋め込み画像があるアルバムにもカバー画像ファイルが保存される場合があります。",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "曲の横や上のフォルダにある cover や folder 画像は、そこにある全アルバムで表示されることがあります。「共有フォルダのアートワークを修復」はそれらを一覧表示し、確認後にのみ .compas-backup に名前変更します。",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "このプラグインが保存したすべてのカバーはパス・サイズ・ハッシュ値とともに記録されます。「ダウンロード済みカバー」から確認後に .compas-backup へ名前変更して元に戻せます。ユーザーが追加・変更したファイルには触れません。",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "未取得のカバーリクエストはダウンロード前に保存され、再起動後でも Wi-Fi 接続時に再開されます。「保留中のカバーリクエスト」で再試行や消去ができます。",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "自動モードは有効にするまでオフです。MusicBrainz への検索は毎秒 1 回に制限されています。",
        ["Cover Art Fetcher"] = "カバーアート取得",
        ["Fetch cover for current album"] = "現在のアルバムのカバーを取得",
        ["Pending cover requests (%s)"] = "保留中のカバーリクエスト (%s)",
        ["unavailable"] = "利用不可",
        ["Pending cover requests"] = "保留中のカバーリクエスト",
        ["%d saved request(s)"] = "保存済みリクエスト %d 件",
        ["A request is downloading"] = "リクエストをダウンロード中",
        ["Waiting for connection or retry time"] = "接続または再試行時刻を待機中",
        ["Retry pending downloads"] = "保留中のダウンロードを再試行",
        ["Clear pending requests…"] = "保留中のリクエストを消去…",
        ["Clear pending requests?"] = "保留中のリクエストを消去しますか？",
        ["Keep requests"] = "リクエストを保持",
        ["Clear requests"] = "リクエストを消去",
        ["Pending requests cleared"] = "保留中のリクエストを消去しました",
        ["Could not save queue change"] = "キューの変更を保存できませんでした",
        ["Automatic fetch"] = "自動取得",
        ["Revert cover for current album"] = "現在のアルバムのカバーを元に戻す",
        ["Repair shared folder artwork"] = "共有フォルダのアートワークを修復",
        ["How it works"] = "仕組み",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "保存済みのカバーリクエストを読み込めませんでした。カバーアート取得の設定を確認してください",
    },
    nl = {
        ["Fetching cover art"] = "Albumhoes ophalen",
        ["Cover fetch in progress"] = "Albumhoes wordt opgehaald",
        ["Cover fetch already in progress — %s"] = "Ophalen is al bezig — %s",
        ["Could not read saved cover requests"] = "Kon opgeslagen hoesverzoeken niet lezen",
        ["Album tags or path are not supported"] = "Albumtags of pad worden niet ondersteund",
        ["Could not update saved cover request"] = "Kon opgeslagen hoesverzoek niet bijwerken",
        ["Cover request is already saved"] = "Hoesverzoek is al opgeslagen",
        ["Cover fetch queued"] = "Albumhoes in wachtrij",
        ["Saved cover request queue is full"] = "Wachtrij voor opgeslagen hoesverzoeken is vol",
        ["Could not save request; it was not queued"] = "Kon verzoek niet opslaan; niet in wachtrij geplaatst",
        ["Cover request saved for download"] = "Hoesverzoek opgeslagen voor download",
        ["Could not save retry request"] = "Kon nieuw verzoek niet opslaan",
        ["This player cannot track downloaded covers"] = "Deze speler kan gedownloade hoezen niet bijhouden",
        ["Download history is unavailable; cover not saved"] = "Downloadgeschiedenis niet beschikbaar; hoes niet opgeslagen",
        ["Download history for this album is being checked"] = "Downloadgeschiedenis voor dit album wordt gecontroleerd",
        ["This album's path is too long to record; cover not saved"] = "Albumpad is te lang om vast te leggen; hoes niet opgeslagen",
        ["Download history is full; cover not saved"] = "Downloadgeschiedenis is vol; hoes niet opgeslagen",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "Er staat een .compas-fetch-bestand in de albummap; hoes niet opgeslagen",
        ["Could not record the download; cover not saved"] = "Kon download niet vastleggen; hoes niet opgeslagen",
        ["Could not save album sidecar"] = "Kon albumhoes niet opslaan",
        ["Saved %s"] = "%s opgeslagen",
        ["Cover request queued for retry"] = "Hoesverzoek in wachtrij voor nieuwe poging",
        ["No cover art for this release"] = "Geen albumhoes voor deze uitgave",
        ["Could not match this album conservatively"] = "Kon dit album niet met zekerheid koppelen",
        ["Too many MusicBrainz matches to choose safely"] = "Te veel MusicBrainz-resultaten om veilig te kiezen",
        ["%s already present"] = "%s is al aanwezig",
        ["Cover fetch failed (network)"] = "Albumhoes ophalen mislukt (netwerk)",
        ["Saving cover…"] = "Hoes opslaan…",
        ["Downloading cover…"] = "Hoes downloaden…",
        ["Checking Cover Art Archive…"] = "Cover Art Archive controleren…",
        ["Looking up MusicBrainz…"] = "Zoeken op MusicBrainz…",
        ["Cover fetch already queued"] = "Albumhoes staat al in de wachtrij",
        ["This player cannot fetch cover art"] = "Deze speler kan geen albumhoezen ophalen",
        ["Album tag has leading or trailing spaces; cover not saved"] = "Albumtag heeft spaties aan begin of einde; hoes niet opgeslagen",
        ["Could not identify this indexed album safely"] = "Kon dit geïndexeerde album niet veilig identificeren",
        ["Could not check saved cover requests; nothing was changed"] = "Kon opgeslagen verzoeken niet controleren; niets gewijzigd",
        ["This cover cannot be reverted"] = "Deze hoes kan niet worden teruggedraaid",
        ["A fetch for this album is running; try again when it finishes"] = "Er loopt al een download voor dit album; probeer het straks opnieuw",
        ["The cover is missing; nothing was changed"] = "De hoes ontbreekt; niets gewijzigd",
        ["The cover was changed or replaced; nothing was changed"] = "De hoes is gewijzigd of vervangen; niets gewijzigd",
        ["No free backup name; nothing was changed"] = "Geen vrije back-upnaam beschikbaar; niets gewijzigd",
        ["Could not clear queued request; nothing was changed"] = "Kon verzoek in wachtrij niet wissen; niets gewijzigd",
        ["Could not record the revert; nothing was changed"] = "Kon terugdraaien niet vastleggen; niets gewijzigd",
        ["Could not rename the cover; nothing was changed"] = "Kon de hoes niet hernoemen; niets gewijzigd",
        ["checking"] = "controleren",
        ["saved"] = "opgeslagen",
        ["not saved"] = "niet opgeslagen",
        ["reverted"] = "teruggedraaid",
        ["missing"] = "ontbreekt",
        ["Download history is unavailable"] = "Downloadgeschiedenis is niet beschikbaar",
        ["No downloaded covers recorded"] = "Geen gedownloade hoezen geregistreerd",
        ["Newer"] = "Nieuwer",
        ["Older"] = "Ouder",
        ["Downloaded covers"] = "Gedownloade hoezen",
        ["Album: %s"] = "Album: %s",
        ["Artist: %s"] = "Artiest: %s",
        ["Recorded: %s"] = "Vastgelegd: %s",
        ["Size: %d bytes"] = "Grootte: %d bytes",
        ["Status: %s"] = "Status: %s",
        ["Backup"] = "Back-up",
        ["Revert: rename to %s"] = "Terugdraaien: hernoemen naar %s",
        ["Cancel"] = "Annuleren",
        ["Downloaded cover"] = "Gedownloade hoes",
        ["Cover reverted. Use Reload cover if it still shows"] = "Hoes teruggedraaid. Gebruik Hoes herladen als deze nog zichtbaar is",
        ["No files changed"] = "Geen bestanden gewijzigd",
        ["Play a local track first"] = "Speel eerst een lokaal nummer af",
        ["No downloaded cover recorded for this album"] = "Geen gedownloade hoes geregistreerd voor dit album",
        ["This album"] = "Dit album",
        ["Tracks at the top of the card are not repaired"] = "Nummers in de hoofdmap van de kaart worden niet gerepareerd",
        ["Update the music database, then try again"] = "Werk de muziekdatabase bij en probeer het opnieuw",
        ["The track changed; try again"] = "Het nummer is gewijzigd; probeer het opnieuw",
        ["Library is too large to check safely"] = "Bibliotheek is te groot om veilig te controleren",
        ["Could not check folder artwork"] = "Kon mapafbeelding niet controleren",
        ["Shared artwork found, but no safe backup name is free"] = "Gedeelde afbeelding gevonden, maar geen vrije back-upnaam beschikbaar",
        ["No shared generic artwork affects this album"] = "Geen gedeelde standaardafbeelding beïnvloedt dit album",
        ["Rename %d file to %s"] = "%d bestand hernoemen naar %s",
        ["Rename %d files to %s"] = "%d bestanden hernoemen naar %s",
        ["Shared folder artwork"] = "Gedeelde mapafbeelding",
        ["Renamed %d, could not rename %d"] = "%d hernoemd, %d mislukt",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "%d hernoemd. Gebruik Hoes herladen als de oude afbeelding nog zichtbaar is",
        ["About Cover Art Fetcher"] = "Over Albumhoezen ophalen",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Zoekt het huidige album op MusicBrainz en downloadt een 500px (of 250px) JPEG-voorkant van het Cover Art Archive als <albumtitel>.jpg naast het nummer.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Overschrijft nooit een bestaande albumhoes. Koppelen gebeurt voorzichtig: geïndexeerde tags moeten overeenkomen met het afspelen en albumnamen mogen niet botsen tussen omliggende mappen of artiesten.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "De Lua-API ziet geen ingesloten afbeeldingen in audiobestanden, dus die albums kunnen alsnog een losse hoes in de map krijgen.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Een algemene cover- of folder-afbeelding naast het nummer, of één map hoger, kan bij elk album daar worden getoond. Gedeelde mapafbeelding repareren toont deze bestanden en hernoemt ze pas na bevestiging naar .compas-backup.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Elke hoes die deze plugin opslaat wordt vastgelegd met pad, grootte en controlegetal. Via Gedownloade hoezen kun je er een terugdraaien: na bevestiging wordt deze hernoemd naar .compas-backup als het bestand ongewijzigd is.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Verzoeken voor ontbrekende hoezen worden vóór het downloaden opgeslagen en hervat zodra er weer Wi-Fi is, zelfs na herstarten. Via Openstaande hoesverzoeken kun je ze opnieuw proberen of wissen.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "Automatisch ophalen staat uit totdat je het inschakelt. MusicBrainz is beperkt tot één zoekopdracht per seconde.",
        ["Cover Art Fetcher"] = "Albumhoezen ophalen",
        ["Fetch cover for current album"] = "Hoes ophalen voor huidig album",
        ["Pending cover requests (%s)"] = "Openstaande hoesverzoeken (%s)",
        ["unavailable"] = "niet beschikbaar",
        ["Pending cover requests"] = "Openstaande hoesverzoeken",
        ["%d saved request(s)"] = "%d opgeslagen verzoek(en)",
        ["A request is downloading"] = "Er wordt een verzoek gedownload",
        ["Waiting for connection or retry time"] = "Wachten op verbinding of nieuwe poging",
        ["Retry pending downloads"] = "Openstaande downloads opnieuw proberen",
        ["Clear pending requests…"] = "Openstaande verzoeken wissen…",
        ["Clear pending requests?"] = "Openstaande verzoeken wissen?",
        ["Keep requests"] = "Verzoeken behouden",
        ["Clear requests"] = "Verzoeken wissen",
        ["Pending requests cleared"] = "Openstaande verzoeken gewist",
        ["Could not save queue change"] = "Kon wachtrijwijziging niet opslaan",
        ["Automatic fetch"] = "Automatisch ophalen",
        ["Revert cover for current album"] = "Hoes voor huidig album terugdraaien",
        ["Repair shared folder artwork"] = "Gedeelde mapafbeelding repareren",
        ["How it works"] = "Hoe het werkt",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Opgeslagen hoesverzoeken konden niet worden gelezen; controleer de instellingen van Albumhoezen ophalen",
    },
    pt = {
        ["Fetching cover art"] = "Buscando capa",
        ["Cover fetch in progress"] = "Busca de capa em andamento",
        ["Cover fetch already in progress — %s"] = "Busca de capa já em andamento — %s",
        ["Could not read saved cover requests"] = "Não foi possível ler os pedidos de capa salvos",
        ["Album tags or path are not supported"] = "As tags do álbum ou o caminho não são suportados",
        ["Could not update saved cover request"] = "Não foi possível atualizar o pedido de capa salvo",
        ["Cover request is already saved"] = "O pedido de capa já está salvo",
        ["Cover fetch queued"] = "Busca de capa na fila",
        ["Saved cover request queue is full"] = "A fila de pedidos de capa salvos está cheia",
        ["Could not save request; it was not queued"] = "Não foi possível salvar o pedido; não entrou na fila",
        ["Cover request saved for download"] = "Pedido de capa salvo para download",
        ["Could not save retry request"] = "Não foi possível salvar o pedido de nova tentativa",
        ["This player cannot track downloaded covers"] = "Este reprodutor não pode rastrear capas baixadas",
        ["Download history is unavailable; cover not saved"] = "Histórico de downloads indisponível; capa não salva",
        ["Download history for this album is being checked"] = "O histórico de downloads deste álbum está sendo verificado",
        ["This album's path is too long to record; cover not saved"] = "O caminho deste álbum é longo demais para registrar; capa não salva",
        ["Download history is full; cover not saved"] = "Histórico de downloads cheio; capa não salva",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "Há um arquivo .compas-fetch na pasta deste álbum; capa não salva",
        ["Could not record the download; cover not saved"] = "Não foi possível registrar o download; capa não salva",
        ["Could not save album sidecar"] = "Não foi possível salvar o arquivo de capa do álbum",
        ["Saved %s"] = "%s salvo",
        ["Cover request queued for retry"] = "Pedido de capa na fila para nova tentativa",
        ["No cover art for this release"] = "Nenhuma capa para este lançamento",
        ["Could not match this album conservatively"] = "Não foi possível associar este álbum com segurança",
        ["Too many MusicBrainz matches to choose safely"] = "Muitos resultados no MusicBrainz para escolher com segurança",
        ["%s already present"] = "%s já existe",
        ["Cover fetch failed (network)"] = "Falha ao buscar capa (rede)",
        ["Saving cover…"] = "Salvando capa…",
        ["Downloading cover…"] = "Baixando capa…",
        ["Checking Cover Art Archive…"] = "Verificando Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "Consultando MusicBrainz…",
        ["Cover fetch already queued"] = "Busca de capa já está na fila",
        ["This player cannot fetch cover art"] = "Este reprodutor não pode buscar capas",
        ["Album tag has leading or trailing spaces; cover not saved"] = "A tag do álbum tem espaços no início ou no fim; capa não salva",
        ["Could not identify this indexed album safely"] = "Não foi possível identificar este álbum indexado com segurança",
        ["Could not check saved cover requests; nothing was changed"] = "Não foi possível verificar os pedidos salvos; nada foi alterado",
        ["This cover cannot be reverted"] = "Esta capa não pode ser revertida",
        ["A fetch for this album is running; try again when it finishes"] = "Uma busca para este álbum está em andamento; tente novamente quando terminar",
        ["The cover is missing; nothing was changed"] = "A capa está ausente; nada foi alterado",
        ["The cover was changed or replaced; nothing was changed"] = "A capa foi alterada ou substituída; nada foi alterado",
        ["No free backup name; nothing was changed"] = "Nenhum nome de backup livre; nada foi alterado",
        ["Could not clear queued request; nothing was changed"] = "Não foi possível limpar o pedido na fila; nada foi alterado",
        ["Could not record the revert; nothing was changed"] = "Não foi possível registrar a reversão; nada foi alterado",
        ["Could not rename the cover; nothing was changed"] = "Não foi possível renomear a capa; nada foi alterado",
        ["checking"] = "verificando",
        ["saved"] = "salva",
        ["not saved"] = "não salva",
        ["reverted"] = "revertida",
        ["missing"] = "ausente",
        ["Download history is unavailable"] = "O histórico de downloads está indisponível",
        ["No downloaded covers recorded"] = "Nenhuma capa baixada registrada",
        ["Newer"] = "Mais recentes",
        ["Older"] = "Mais antigas",
        ["Downloaded covers"] = "Capas baixadas",
        ["Album: %s"] = "Álbum: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Recorded: %s"] = "Registrado: %s",
        ["Size: %d bytes"] = "Tamanho: %d bytes",
        ["Status: %s"] = "Status: %s",
        ["Backup"] = "Backup",
        ["Revert: rename to %s"] = "Reverter: renomear para %s",
        ["Cancel"] = "Cancelar",
        ["Downloaded cover"] = "Capa baixada",
        ["Cover reverted. Use Reload cover if it still shows"] = "Capa revertida. Use Recarregar capa se ela ainda aparecer",
        ["No files changed"] = "Nenhum arquivo alterado",
        ["Play a local track first"] = "Reproduza uma faixa local primeiro",
        ["No downloaded cover recorded for this album"] = "Nenhuma capa baixada registrada para este álbum",
        ["This album"] = "Este álbum",
        ["Tracks at the top of the card are not repaired"] = "Faixas na raiz do cartão não são reparadas",
        ["Update the music database, then try again"] = "Atualize o banco de dados de músicas e tente novamente",
        ["The track changed; try again"] = "A faixa mudou; tente novamente",
        ["Library is too large to check safely"] = "A biblioteca é grande demais para verificar com segurança",
        ["Could not check folder artwork"] = "Não foi possível verificar a capa da pasta",
        ["Shared artwork found, but no safe backup name is free"] = "Capa compartilhada encontrada, mas não há nome de backup livre",
        ["No shared generic artwork affects this album"] = "Nenhuma capa genérica compartilhada afeta este álbum",
        ["Rename %d file to %s"] = "Renomear %d arquivo para %s",
        ["Rename %d files to %s"] = "Renomear %d arquivos para %s",
        ["Shared folder artwork"] = "Capa de pasta compartilhada",
        ["Renamed %d, could not rename %d"] = "%d renomeado(s), %d falhou(aram)",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "%d renomeado(s). Use Recarregar capa se a capa antiga ainda aparecer",
        ["About Cover Art Fetcher"] = "Sobre o Buscador de capas",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Procura o álbum atual no MusicBrainz e baixa um JPEG frontal de 500px (ou 250px) do Cover Art Archive como <título do álbum>.jpg ao lado da faixa.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Nunca sobrescreve uma capa existente. A correspondência é conservadora: as tags indexadas devem coincidir com a reprodução e os nomes dos álbuns não devem colidir entre pastas próximas ou artistas.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "A API Lua não consegue ver imagens embutidas nos arquivos de áudio, então esses álbuns ainda podem receber uma capa na pasta.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Uma imagem genérica cover ou folder ao lado da faixa, ou uma pasta acima, pode aparecer para todos os álbuns dali. Reparar capa de pasta compartilhada lista esses arquivos e os renomeia para .compas-backup somente após sua confirmação.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Cada capa salva por este plugin é registrada com caminho exato, tamanho e assinatura. Capas baixadas permite reverter uma capa: após confirmar, ela é renomeada para .compas-backup se ainda for exatamente o arquivo salvo.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Pedidos de capas ausentes são salvos antes de baixar e retomados quando o Wi-Fi volta, mesmo após reiniciar. Pedidos de capa pendentes permite tentar novamente ou limpá-los.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "O modo automático fica desligado até você ativá-lo. O MusicBrainz é limitado a uma consulta por segundo.",
        ["Cover Art Fetcher"] = "Buscador de capas",
        ["Fetch cover for current album"] = "Buscar capa para o álbum atual",
        ["Pending cover requests (%s)"] = "Pedidos de capa pendentes (%s)",
        ["unavailable"] = "indisponível",
        ["Pending cover requests"] = "Pedidos de capa pendentes",
        ["%d saved request(s)"] = "%d pedido(s) salvo(s)",
        ["A request is downloading"] = "Um pedido está sendo baixado",
        ["Waiting for connection or retry time"] = "Aguardando conexão ou tempo de nova tentativa",
        ["Retry pending downloads"] = "Tentar novamente os downloads pendentes",
        ["Clear pending requests…"] = "Limpar pedidos pendentes…",
        ["Clear pending requests?"] = "Limpar pedidos pendentes?",
        ["Keep requests"] = "Manter pedidos",
        ["Clear requests"] = "Limpar pedidos",
        ["Pending requests cleared"] = "Pedidos pendentes limpos",
        ["Could not save queue change"] = "Não foi possível salvar a alteração na fila",
        ["Automatic fetch"] = "Busca automática",
        ["Revert cover for current album"] = "Reverter capa do álbum atual",
        ["Repair shared folder artwork"] = "Reparar capa de pasta compartilhada",
        ["How it works"] = "Como funciona",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Não foi possível ler os pedidos de capa salvos; verifique as configurações do Buscador de capas",
    },
    ru = {
        ["Fetching cover art"] = "Загрузка обложки",
        ["Cover fetch in progress"] = "Идёт загрузка обложки",
        ["Cover fetch already in progress — %s"] = "Загрузка обложки уже идёт — %s",
        ["Could not read saved cover requests"] = "Не удалось прочитать сохранённые запросы обложек",
        ["Album tags or path are not supported"] = "Теги альбома или путь не поддерживаются",
        ["Could not update saved cover request"] = "Не удалось обновить сохранённый запрос обложки",
        ["Cover request is already saved"] = "Запрос обложки уже сохранён",
        ["Cover fetch queued"] = "Запрос обложки в очереди",
        ["Saved cover request queue is full"] = "Очередь сохранённых запросов обложек заполнена",
        ["Could not save request; it was not queued"] = "Не удалось сохранить запрос; он не добавлен в очередь",
        ["Cover request saved for download"] = "Запрос обложки сохранён для загрузки",
        ["Could not save retry request"] = "Не удалось сохранить запрос повтора",
        ["This player cannot track downloaded covers"] = "Этот плеер не поддерживает учёт скачанных обложек",
        ["Download history is unavailable; cover not saved"] = "История загрузок недоступна; обложка не сохранена",
        ["Download history for this album is being checked"] = "Проверяется история загрузок для этого альбома",
        ["This album's path is too long to record; cover not saved"] = "Путь к альбому слишком длинный для записи; обложка не сохранена",
        ["Download history is full; cover not saved"] = "История загрузок заполнена; обложка не сохранена",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "В папке альбома есть файл .compas-fetch; обложка не сохранена",
        ["Could not record the download; cover not saved"] = "Не удалось записать загрузку; обложка не сохранена",
        ["Could not save album sidecar"] = "Не удалось сохранить файл обложки альбома",
        ["Saved %s"] = "Сохранено: %s",
        ["Cover request queued for retry"] = "Запрос обложки поставлен в очередь на повтор",
        ["No cover art for this release"] = "Для этого релиза нет обложки",
        ["Could not match this album conservatively"] = "Не удалось однозначно сопоставить этот альбом",
        ["Too many MusicBrainz matches to choose safely"] = "Слишком много совпадений в MusicBrainz для точного выбора",
        ["%s already present"] = "%s уже существует",
        ["Cover fetch failed (network)"] = "Ошибка загрузки обложки (сеть)",
        ["Saving cover…"] = "Сохранение обложки…",
        ["Downloading cover…"] = "Скачивание обложки…",
        ["Checking Cover Art Archive…"] = "Проверка Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "Поиск в MusicBrainz…",
        ["Cover fetch already queued"] = "Загрузка обложки уже в очереди",
        ["This player cannot fetch cover art"] = "Этот плеер не может загружать обложки",
        ["Album tag has leading or trailing spaces; cover not saved"] = "В теге альбома есть крайние пробелы; обложка не сохранена",
        ["Could not identify this indexed album safely"] = "Не удалось надёжно определить этот альбом в медиатеке",
        ["Could not check saved cover requests; nothing was changed"] = "Не удалось проверить сохранённые запросы; ничего не изменено",
        ["This cover cannot be reverted"] = "Эту обложку нельзя откатить",
        ["A fetch for this album is running; try again when it finishes"] = "Загрузка для этого альбома ещё идёт; повторите позже",
        ["The cover is missing; nothing was changed"] = "Обложка отсутствует; ничего не изменено",
        ["The cover was changed or replaced; nothing was changed"] = "Обложка была изменена или заменена; ничего не изменено",
        ["No free backup name; nothing was changed"] = "Нет свободного имени для резервной копии; ничего не изменено",
        ["Could not clear queued request; nothing was changed"] = "Не удалось удалить запрос из очереди; ничего не изменено",
        ["Could not record the revert; nothing was changed"] = "Не удалось записать откат; ничего не изменено",
        ["Could not rename the cover; nothing was changed"] = "Не удалось переименовать обложку; ничего не изменено",
        ["checking"] = "проверка",
        ["saved"] = "сохранена",
        ["not saved"] = "не сохранена",
        ["reverted"] = "откачена",
        ["missing"] = "отсутствует",
        ["Download history is unavailable"] = "История загрузок недоступна",
        ["No downloaded covers recorded"] = "Нет записей о скачанных обложках",
        ["Newer"] = "Новее",
        ["Older"] = "Старше",
        ["Downloaded covers"] = "Скачанные обложки",
        ["Album: %s"] = "Альбом: %s",
        ["Artist: %s"] = "Исполнитель: %s",
        ["Recorded: %s"] = "Записано: %s",
        ["Size: %d bytes"] = "Размер: %d байт",
        ["Status: %s"] = "Статус: %s",
        ["Backup"] = "Резервная копия",
        ["Revert: rename to %s"] = "Откатить: переименовать в %s",
        ["Cancel"] = "Отмена",
        ["Downloaded cover"] = "Скачанная обложка",
        ["Cover reverted. Use Reload cover if it still shows"] = "Обложка откачена. Нажмите «Перезагрузить обложку», если она ещё видна",
        ["No files changed"] = "Файлы не изменены",
        ["Play a local track first"] = "Сначала включите локальный трек",
        ["No downloaded cover recorded for this album"] = "Для этого альбома нет записей о скачанной обложке",
        ["This album"] = "Этот альбом",
        ["Tracks at the top of the card are not repaired"] = "Треки в корне карты памяти не исправляются",
        ["Update the music database, then try again"] = "Обновите базу музыки и попробуйте снова",
        ["The track changed; try again"] = "Трек сменился; попробуйте снова",
        ["Library is too large to check safely"] = "Медиатека слишком велика для безопасной проверки",
        ["Could not check folder artwork"] = "Не удалось проверить обложки в папке",
        ["Shared artwork found, but no safe backup name is free"] = "Найдена общая обложка, но нет свободного имени для копии",
        ["No shared generic artwork affects this album"] = "Общие обложки папки не влияют на этот альбом",
        ["Rename %d file to %s"] = "Переименовать %d файл в %s",
        ["Rename %d files to %s"] = "Переименовать файлы (%d) в %s",
        ["Shared folder artwork"] = "Общая обложка папки",
        ["Renamed %d, could not rename %d"] = "Переименовано: %d, ошибок: %d",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "Переименовано: %d. Используйте «Перезагрузить обложку», если старая ещё видна",
        ["About Cover Art Fetcher"] = "О загрузчике обложек",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Ищет текущий альбом в MusicBrainz и скачивает фронтальный JPEG 500px (или 250px) из Cover Art Archive как <название альбома>.jpg рядом с треком.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Никогда не перезаписывает существующую обложку альбома. Сопоставление строгое: теги в базе должны совпадать с воспроизведением, а названия альбомов не должны конфликтовать между соседними папками или исполнителями.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "Lua API не видит встроенные в аудиофайлы картинки, поэтому для таких альбомов всё равно может быть скачан файл обложки.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Общий файл cover или folder рядом с треком или папкой выше может отображаться для всех альбомов в ней. «Исправить общую обложку папки» показывает такие файлы и переименовывает их в .compas-backup только после подтверждения.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Каждая сохранённая плагином обложка записывается с путём, размером и контрольной суммой. В разделе «Скачанные обложки» её можно откатить: после подтверждения файл переименовывается в .compas-backup, если он не менялся.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Запросы недостающих обложек сохраняются перед загрузкой и возобновляются при появлении Wi-Fi даже после перезапуска. В «Ожидающих запросах» их можно повторить или очистить.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "Автоматический режим выключен, пока вы его не включите. Запросы к MusicBrainz ограничены одним в секунду.",
        ["Cover Art Fetcher"] = "Загрузчик обложек",
        ["Fetch cover for current album"] = "Скачать обложку для текущего альбома",
        ["Pending cover requests (%s)"] = "Ожидающие запросы обложек (%s)",
        ["unavailable"] = "недоступно",
        ["Pending cover requests"] = "Ожидающие запросы обложек",
        ["%d saved request(s)"] = "Сохранённых запросов: %d",
        ["A request is downloading"] = "Идёт загрузка запроса",
        ["Waiting for connection or retry time"] = "Ожидание сети или времени повтора",
        ["Retry pending downloads"] = "Повторить ожидающие загрузки",
        ["Clear pending requests…"] = "Очистить ожидающие запросы…",
        ["Clear pending requests?"] = "Очистить ожидающие запросы?",
        ["Keep requests"] = "Оставить запросы",
        ["Clear requests"] = "Очистить запросы",
        ["Pending requests cleared"] = "Ожидающие запросы очищены",
        ["Could not save queue change"] = "Не удалось сохранить изменения очереди",
        ["Automatic fetch"] = "Автоматическая загрузка",
        ["Revert cover for current album"] = "Откатить обложку текущего альбома",
        ["Repair shared folder artwork"] = "Исправить общую обложку папки",
        ["How it works"] = "Как это работает",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Не удалось прочитать сохранённые запросы обложек; проверьте настройки Загрузчика обложек",
    },
    uk = {
        ["Fetching cover art"] = "Завантаження обкладинки",
        ["Cover fetch in progress"] = "Триває завантаження обкладинки",
        ["Cover fetch already in progress — %s"] = "Завантаження обкладинки вже триває — %s",
        ["Could not read saved cover requests"] = "Не вдалося прочитати збережені запити обкладинок",
        ["Album tags or path are not supported"] = "Теги альбому або шлях не підтримуються",
        ["Could not update saved cover request"] = "Не вдалося оновити збережений запит обкладинки",
        ["Cover request is already saved"] = "Запит обкладинки вже збережено",
        ["Cover fetch queued"] = "Запит обкладинки в черзі",
        ["Saved cover request queue is full"] = "Черга збережених запитів обкладинок заповнена",
        ["Could not save request; it was not queued"] = "Не вдалося зберегти запит; його не додано в чергу",
        ["Cover request saved for download"] = "Запит обкладинки збережено для завантаження",
        ["Could not save retry request"] = "Не вдалося зберегти запит повтору",
        ["This player cannot track downloaded covers"] = "Цей плеєр не підтримує облік завантажених обкладинок",
        ["Download history is unavailable; cover not saved"] = "Історія завантажень недоступна; обкладинку не збережено",
        ["Download history for this album is being checked"] = "Перевіряється історія завантажень для цього альбому",
        ["This album's path is too long to record; cover not saved"] = "Шлях до альбому задовгий для запису; обкладинку не збережено",
        ["Download history is full; cover not saved"] = "Історія завантажень заповнена; обкладинку не збережено",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "У теці альбому є файл .compas-fetch; обкладинку не збережено",
        ["Could not record the download; cover not saved"] = "Не вдалося записати завантаження; обкладинку не збережено",
        ["Could not save album sidecar"] = "Не вдалося зберегти файл обкладинки альбому",
        ["Saved %s"] = "Збережено: %s",
        ["Cover request queued for retry"] = "Запит обкладинки поставлено в чергу на повтор",
        ["No cover art for this release"] = "Для цього релізу немає обкладинки",
        ["Could not match this album conservatively"] = "Не вдалося однозначно зіставити цей альбом",
        ["Too many MusicBrainz matches to choose safely"] = "Забагато збігів у MusicBrainz для безпечного вибору",
        ["%s already present"] = "%s уже існує",
        ["Cover fetch failed (network)"] = "Помилка завантаження обкладинки (мережа)",
        ["Saving cover…"] = "Збереження обкладинки…",
        ["Downloading cover…"] = "Завантаження обкладинки…",
        ["Checking Cover Art Archive…"] = "Перевірка Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "Пошук у MusicBrainz…",
        ["Cover fetch already queued"] = "Завантаження обкладинки вже в черзі",
        ["This player cannot fetch cover art"] = "Цей плеєр не може завантажувати обкладинки",
        ["Album tag has leading or trailing spaces; cover not saved"] = "У тезі альбому є крайні пробіли; обкладинку не збережено",
        ["Could not identify this indexed album safely"] = "Не вдалося надійно визначити цей альбом у медіатеці",
        ["Could not check saved cover requests; nothing was changed"] = "Не вдалося перевірити збережені запити; нічого не змінено",
        ["This cover cannot be reverted"] = "Цю обкладинку не можна відкотити",
        ["A fetch for this album is running; try again when it finishes"] = "Завантаження для цього альбому ще триває; спробуйте пізніше",
        ["The cover is missing; nothing was changed"] = "Обкладинка відсутня; нічого не змінено",
        ["The cover was changed or replaced; nothing was changed"] = "Обкладинку було змінено або замінено; нічого не змінено",
        ["No free backup name; nothing was changed"] = "Немає вільного імені для резервної копії; нічого не змінено",
        ["Could not clear queued request; nothing was changed"] = "Не вдалося видалити запит із черги; нічого не змінено",
        ["Could not record the revert; nothing was changed"] = "Не вдалося записати відкат; нічого не змінено",
        ["Could not rename the cover; nothing was changed"] = "Не вдалося перейменувати обкладинку; нічого не змінено",
        ["checking"] = "перевірка",
        ["saved"] = "збережено",
        ["not saved"] = "не збережено",
        ["reverted"] = "відкочено",
        ["missing"] = "відсутня",
        ["Download history is unavailable"] = "Історія завантажень недоступна",
        ["No downloaded covers recorded"] = "Немає записів про завантажені обкладинки",
        ["Newer"] = "Новіші",
        ["Older"] = "Старіші",
        ["Downloaded covers"] = "Завантажені обкладинки",
        ["Album: %s"] = "Альбом: %s",
        ["Artist: %s"] = "Виконавець: %s",
        ["Recorded: %s"] = "Записано: %s",
        ["Size: %d bytes"] = "Розмір: %d байт",
        ["Status: %s"] = "Статус: %s",
        ["Backup"] = "Резервна копія",
        ["Revert: rename to %s"] = "Відкотити: перейменувати на %s",
        ["Cancel"] = "Скасувати",
        ["Downloaded cover"] = "Завантажена обкладинка",
        ["Cover reverted. Use Reload cover if it still shows"] = "Обкладинку відкочено. Натисніть «Перезавантажити обкладинку», якщо вона ще видима",
        ["No files changed"] = "Файли не змінено",
        ["Play a local track first"] = "Спочатку увімкніть локальний трек",
        ["No downloaded cover recorded for this album"] = "Для цього альбому немає записів про завантажену обкладинку",
        ["This album"] = "Цей альбом",
        ["Tracks at the top of the card are not repaired"] = "Треки в корені карти пам'яті не виправляються",
        ["Update the music database, then try again"] = "Оновіть музичну базу даних і спробуйте знову",
        ["The track changed; try again"] = "Трек змінився; спробуйте знову",
        ["Library is too large to check safely"] = "Медіатека завелика для безпечної перевірки",
        ["Could not check folder artwork"] = "Не вдалося перевірити обкладинки в теці",
        ["Shared artwork found, but no safe backup name is free"] = "Знайдено спільну обкладинку, але немає вільного імені для копії",
        ["No shared generic artwork affects this album"] = "Спільні обкладинки теки не впливають на цей альбом",
        ["Rename %d file to %s"] = "Перейменувати %d файл на %s",
        ["Rename %d files to %s"] = "Перейменувати файли (%d) на %s",
        ["Shared folder artwork"] = "Спільна обкладинка теки",
        ["Renamed %d, could not rename %d"] = "Перейменовано: %d, помилок: %d",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "Перейменовано: %d. Використайте «Перезавантажити обкладинку», якщо стара ще видима",
        ["About Cover Art Fetcher"] = "Про завантажувач обкладинок",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Шукає поточний альбом у MusicBrainz і завантажує фронтальний JPEG 500px (або 250px) із Cover Art Archive як <назва альбому>.jpg поруч із треком.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Ніколи не перезаписує наявну обкладинку альбому. Зіставлення обережне: теги в базі мають збігатися з відтворенням, а назви альбомів не повинні конфліктувати між сусідніми теками чи виконавцями.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "Lua API не бачить вбудовані в аудіофайли зображення, тому для таких альбомів усе одно може бути збережено файл обкладинки.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Загальний файл cover або folder поруч із треком чи текою вище може показуватися для всіх альбомів у ній. «Виправити спільну обкладинку теки» показує такі файли й перейменовує їх на .compas-backup лише після підтвердження.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Кожна збережена плагіном обкладинка записується зі шляхом, розміром і контрольною сумою. У розділі «Завантажені обкладинки» її можна відкотити: після підтвердження файл перейменовується на .compas-backup, якщо він не змінювався.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Запити відсутніх обкладинок зберігаються перед завантаженням і відновлюються з появою Wi-Fi навіть після перезапуску. В «Очікуваних запитах» їх можна повторити або очистити.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "Автоматичний режим вимкнено, доки ви його не увімкнете. Запити до MusicBrainz обмежено одним на секунду.",
        ["Cover Art Fetcher"] = "Завантажувач обкладинок",
        ["Fetch cover for current album"] = "Завантажити обкладинку поточного альбому",
        ["Pending cover requests (%s)"] = "Очікувані запити обкладинок (%s)",
        ["unavailable"] = "недоступно",
        ["Pending cover requests"] = "Очікувані запити обкладинок",
        ["%d saved request(s)"] = "Збережених запитів: %d",
        ["A request is downloading"] = "Триває завантаження запиту",
        ["Waiting for connection or retry time"] = "Очікування мережі або часу повтору",
        ["Retry pending downloads"] = "Повторити очікувані завантаження",
        ["Clear pending requests…"] = "Очистити очікувані запити…",
        ["Clear pending requests?"] = "Очистити очікувані запити?",
        ["Keep requests"] = "Залишити запити",
        ["Clear requests"] = "Очистити запити",
        ["Pending requests cleared"] = "Очікувані запити очищено",
        ["Could not save queue change"] = "Не вдалося зберегти зміни черги",
        ["Automatic fetch"] = "Автоматичне завантаження",
        ["Revert cover for current album"] = "Відкотити обкладинку поточного альбому",
        ["Repair shared folder artwork"] = "Виправити спільну обкладинку теки",
        ["How it works"] = "Як це працює",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Не вдалося прочитати збережені запити обкладинок; перевірте налаштування Завантажувача обкладинок",
    },
    vi = {
        ["Fetching cover art"] = "Đang tải ảnh bìa",
        ["Cover fetch in progress"] = "Đang tải ảnh bìa",
        ["Cover fetch already in progress — %s"] = "Đang tải ảnh bìa — %s",
        ["Could not read saved cover requests"] = "Không thể đọc yêu cầu ảnh bìa đã lưu",
        ["Album tags or path are not supported"] = "Thẻ album hoặc đường dẫn không được hỗ trợ",
        ["Could not update saved cover request"] = "Không thể cập nhật yêu cầu ảnh bìa đã lưu",
        ["Cover request is already saved"] = "Yêu cầu ảnh bìa đã được lưu sẵn",
        ["Cover fetch queued"] = "Đã xếp hàng tải ảnh bìa",
        ["Saved cover request queue is full"] = "Hàng đợi yêu cầu ảnh bìa đã đầy",
        ["Could not save request; it was not queued"] = "Không thể lưu yêu cầu; chưa đưa vào hàng đợi",
        ["Cover request saved for download"] = "Đã lưu yêu cầu ảnh bìa để tải xuống",
        ["Could not save retry request"] = "Không thể lưu yêu cầu thử lại",
        ["This player cannot track downloaded covers"] = "Thiết bị này không thể theo dõi ảnh bìa đã tải",
        ["Download history is unavailable; cover not saved"] = "Lịch sử tải không khả dụng; chưa lưu ảnh bìa",
        ["Download history for this album is being checked"] = "Đang kiểm tra lịch sử tải của album này",
        ["This album's path is too long to record; cover not saved"] = "Đường dẫn album quá dài để ghi nhận; chưa lưu ảnh bìa",
        ["Download history is full; cover not saved"] = "Lịch sử tải đã đầy; chưa lưu ảnh bìa",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "Có tệp .compas-fetch trong thư mục album; chưa lưu ảnh bìa",
        ["Could not record the download; cover not saved"] = "Không thể ghi nhận lượt tải; chưa lưu ảnh bìa",
        ["Could not save album sidecar"] = "Không thể lưu tệp ảnh bìa album",
        ["Saved %s"] = "Đã lưu %s",
        ["Cover request queued for retry"] = "Đã xếp hàng thử lại yêu cầu ảnh bìa",
        ["No cover art for this release"] = "Không có ảnh bìa cho bản phát hành này",
        ["Could not match this album conservatively"] = "Không thể khớp chính xác album này",
        ["Too many MusicBrainz matches to choose safely"] = "Có quá nhiều kết quả MusicBrainz để chọn an toàn",
        ["%s already present"] = "%s đã tồn tại",
        ["Cover fetch failed (network)"] = "Tải ảnh bìa thất bại (mạng)",
        ["Saving cover…"] = "Đang lưu ảnh bìa…",
        ["Downloading cover…"] = "Đang tải ảnh bìa…",
        ["Checking Cover Art Archive…"] = "Đang kiểm tra Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "Đang tra cứu MusicBrainz…",
        ["Cover fetch already queued"] = "Yêu cầu tải ảnh bìa đã có trong hàng đợi",
        ["This player cannot fetch cover art"] = "Thiết bị này không thể tải ảnh bìa",
        ["Album tag has leading or trailing spaces; cover not saved"] = "Thẻ album có khoảng trắng ở đầu hoặc cuối; chưa lưu ảnh bìa",
        ["Could not identify this indexed album safely"] = "Không thể xác định an toàn album này trong thư viện",
        ["Could not check saved cover requests; nothing was changed"] = "Không thể kiểm tra yêu cầu đã lưu; không có gì thay đổi",
        ["This cover cannot be reverted"] = "Không thể hoàn tác ảnh bìa này",
        ["A fetch for this album is running; try again when it finishes"] = "Đang tải ảnh bìa cho album này; hãy thử lại khi hoàn tất",
        ["The cover is missing; nothing was changed"] = "Không tìm thấy ảnh bìa; không có gì thay đổi",
        ["The cover was changed or replaced; nothing was changed"] = "Ảnh bìa đã bị sửa hoặc thay thế; không có gì thay đổi",
        ["No free backup name; nothing was changed"] = "Không còn tên tệp sao lưu trống; không có gì thay đổi",
        ["Could not clear queued request; nothing was changed"] = "Không thể xóa yêu cầu trong hàng đợi; không có gì thay đổi",
        ["Could not record the revert; nothing was changed"] = "Không thể ghi nhận hoàn tác; không có gì thay đổi",
        ["Could not rename the cover; nothing was changed"] = "Không thể đổi tên ảnh bìa; không có gì thay đổi",
        ["checking"] = "đang kiểm tra",
        ["saved"] = "đã lưu",
        ["not saved"] = "chưa lưu",
        ["reverted"] = "đã hoàn tác",
        ["missing"] = "bị thiếu",
        ["Download history is unavailable"] = "Lịch sử tải không khả dụng",
        ["No downloaded covers recorded"] = "Chưa có ảnh bìa đã tải nào được ghi nhận",
        ["Newer"] = "Mới hơn",
        ["Older"] = "Cũ hơn",
        ["Downloaded covers"] = "Ảnh bìa đã tải",
        ["Album: %s"] = "Album: %s",
        ["Artist: %s"] = "Nghệ sĩ: %s",
        ["Recorded: %s"] = "Ghi nhận: %s",
        ["Size: %d bytes"] = "Kích thước: %d byte",
        ["Status: %s"] = "Trạng thái: %s",
        ["Backup"] = "Bản sao lưu",
        ["Revert: rename to %s"] = "Hoàn tác: đổi tên thành %s",
        ["Cancel"] = "Hủy",
        ["Downloaded cover"] = "Ảnh bìa đã tải",
        ["Cover reverted. Use Reload cover if it still shows"] = "Đã hoàn tác ảnh bìa. Hãy dùng Tải lại ảnh bìa nếu ảnh cũ vẫn hiện",
        ["No files changed"] = "Không có tệp nào thay đổi",
        ["Play a local track first"] = "Hãy phát một bài nhạc trên máy trước",
        ["No downloaded cover recorded for this album"] = "Không có ảnh bìa đã tải nào được ghi nhận cho album này",
        ["This album"] = "Album này",
        ["Tracks at the top of the card are not repaired"] = "Các bài nhạc ở thư mục gốc của thẻ không được sửa",
        ["Update the music database, then try again"] = "Hãy cập nhật cơ sở dữ liệu nhạc rồi thử lại",
        ["The track changed; try again"] = "Bài nhạc đã đổi; hãy thử lại",
        ["Library is too large to check safely"] = "Thư viện quá lớn để kiểm tra an toàn",
        ["Could not check folder artwork"] = "Không thể kiểm tra ảnh bìa thư mục",
        ["Shared artwork found, but no safe backup name is free"] = "Tìm thấy ảnh bìa dùng chung nhưng không còn tên sao lưu trống",
        ["No shared generic artwork affects this album"] = "Không có ảnh bìa chung nào ảnh hưởng đến album này",
        ["Rename %d file to %s"] = "Đổi tên %d tệp thành %s",
        ["Rename %d files to %s"] = "Đổi tên %d tệp thành %s",
        ["Shared folder artwork"] = "Ảnh bìa thư mục dùng chung",
        ["Renamed %d, could not rename %d"] = "Đã đổi tên %d, lỗi %d",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "Đã đổi tên %d. Hãy dùng Tải lại ảnh bìa nếu ảnh cũ vẫn hiện",
        ["About Cover Art Fetcher"] = "Giới thiệu Trình tải ảnh bìa",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "Tra cứu album hiện tại trên MusicBrainz và tải ảnh JPEG mặt trước 500px (hoặc 250px) từ Cover Art Archive thành <tên album>.jpg cạnh tệp nhạc.",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "Không bao giờ ghi đè ảnh bìa đã có. Việc đối chiếu rất thận trọng: thẻ bài hát trong thư viện phải khớp với bài đang phát và tên album không được trùng lặp giữa các thư mục gần nhau hoặc nghệ sĩ khác.",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "API Lua không thể đọc ảnh nhúng sẵn trong tệp âm thanh, nên các album đó vẫn có thể được tải tệp ảnh bìa riêng.",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "Ảnh cover hoặc folder chung nằm cạnh bài nhạc hoặc ở thư mục cha có thể hiển thị cho mọi album tại đó. Sửa ảnh bìa thư mục dùng chung sẽ liệt kê các tệp này và chỉ đổi tên thành .compas-backup sau khi bạn xác nhận.",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "Mỗi ảnh bìa plugin này lưu đều được ghi lại đường dẫn, kích thước và mã kiểm tra. Mục Ảnh bìa đã tải cho phép bạn hoàn tác: sau khi xác nhận, tệp sẽ được đổi tên thành .compas-backup nếu vẫn nguyên vẹn như lúc lưu.",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "Yêu cầu tải ảnh bìa được lưu trước khi tải và tự tiếp tục khi có Wi-Fi, kể cả sau khi khởi động lại. Mục Yêu cầu đang chờ cho phép thử lại hoặc xóa chúng.",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "Chế độ tự động mặc định tắt cho đến khi bạn bật. MusicBrainz giới hạn mỗi giây một lượt tra cứu.",
        ["Cover Art Fetcher"] = "Trình tải ảnh bìa",
        ["Fetch cover for current album"] = "Tải ảnh bìa cho album hiện tại",
        ["Pending cover requests (%s)"] = "Yêu cầu ảnh bìa đang chờ (%s)",
        ["unavailable"] = "không khả dụng",
        ["Pending cover requests"] = "Yêu cầu ảnh bìa đang chờ",
        ["%d saved request(s)"] = "%d yêu cầu đã lưu",
        ["A request is downloading"] = "Đang tải một yêu cầu",
        ["Waiting for connection or retry time"] = "Đang chờ kết nối hoặc thời gian thử lại",
        ["Retry pending downloads"] = "Thử lại các lượt tải đang chờ",
        ["Clear pending requests…"] = "Xóa yêu cầu đang chờ…",
        ["Clear pending requests?"] = "Xóa các yêu cầu đang chờ?",
        ["Keep requests"] = "Giữ lại yêu cầu",
        ["Clear requests"] = "Xóa yêu cầu",
        ["Pending requests cleared"] = "Đã xóa các yêu cầu đang chờ",
        ["Could not save queue change"] = "Không thể lưu thay đổi hàng đợi",
        ["Automatic fetch"] = "Tự động tải",
        ["Revert cover for current album"] = "Hoàn tác ảnh bìa của album hiện tại",
        ["Repair shared folder artwork"] = "Sửa ảnh bìa thư mục dùng chung",
        ["How it works"] = "Cách hoạt động",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "Không đọc được yêu cầu ảnh bìa đã lưu; hãy kiểm tra cài đặt Trình tải ảnh bìa",
    },
    zh_CN = {
        ["Fetching cover art"] = "正在获取封面",
        ["Cover fetch in progress"] = "正在获取封面",
        ["Cover fetch already in progress — %s"] = "封面获取已在进行中 — %s",
        ["Could not read saved cover requests"] = "无法读取已保存的封面请求",
        ["Album tags or path are not supported"] = "不支持该专辑标签或路径",
        ["Could not update saved cover request"] = "无法更新已保存的封面请求",
        ["Cover request is already saved"] = "封面请求已保存",
        ["Cover fetch queued"] = "封面获取已加入队列",
        ["Saved cover request queue is full"] = "已保存的封面请求队列已满",
        ["Could not save request; it was not queued"] = "无法保存请求，未加入队列",
        ["Cover request saved for download"] = "已保存封面下载请求",
        ["Could not save retry request"] = "无法保存重试请求",
        ["This player cannot track downloaded covers"] = "此播放器无法记录已下载的封面",
        ["Download history is unavailable; cover not saved"] = "下载记录不可用，未保存封面",
        ["Download history for this album is being checked"] = "正在检查此专辑的下载记录",
        ["This album's path is too long to record; cover not saved"] = "专辑路径过长无法记录，未保存封面",
        ["Download history is full; cover not saved"] = "下载记录已满，未保存封面",
        ["A .compas-fetch file is in this album's folder; cover not saved"] = "专辑文件夹中存在 .compas-fetch 文件，未保存封面",
        ["Could not record the download; cover not saved"] = "无法记录下载信息，未保存封面",
        ["Could not save album sidecar"] = "无法保存专辑封面文件",
        ["Saved %s"] = "已保存 %s",
        ["Cover request queued for retry"] = "封面请求已加入重试队列",
        ["No cover art for this release"] = "此发行版没有封面图片",
        ["Could not match this album conservatively"] = "无法安全地唯一匹配此专辑",
        ["Too many MusicBrainz matches to choose safely"] = "MusicBrainz 匹配结果过多，无法安全选择",
        ["%s already present"] = "%s 已存在",
        ["Cover fetch failed (network)"] = "封面获取失败（网络）",
        ["Saving cover…"] = "正在保存封面…",
        ["Downloading cover…"] = "正在下载封面…",
        ["Checking Cover Art Archive…"] = "正在查询 Cover Art Archive…",
        ["Looking up MusicBrainz…"] = "正在查询 MusicBrainz…",
        ["Cover fetch already queued"] = "封面获取已在队列中",
        ["This player cannot fetch cover art"] = "此播放器无法获取封面",
        ["Album tag has leading or trailing spaces; cover not saved"] = "专辑标签首尾包含空格，未保存封面",
        ["Could not identify this indexed album safely"] = "无法安全识别此媒体库专辑",
        ["Could not check saved cover requests; nothing was changed"] = "无法检查已保存的封面请求，未作任何更改",
        ["This cover cannot be reverted"] = "无法撤销此封面",
        ["A fetch for this album is running; try again when it finishes"] = "此专辑正在获取封面，请完成后再试",
        ["The cover is missing; nothing was changed"] = "封面文件不存在，未作任何更改",
        ["The cover was changed or replaced; nothing was changed"] = "封面已被修改或替换，未作任何更改",
        ["No free backup name; nothing was changed"] = "没有可用的备份文件名，未作任何更改",
        ["Could not clear queued request; nothing was changed"] = "无法清除队列中的请求，未作任何更改",
        ["Could not record the revert; nothing was changed"] = "无法记录撤销操作，未作任何更改",
        ["Could not rename the cover; nothing was changed"] = "无法重命名封面，未作任何更改",
        ["checking"] = "检查中",
        ["saved"] = "已保存",
        ["not saved"] = "未保存",
        ["reverted"] = "已撤销",
        ["missing"] = "已缺失",
        ["Download history is unavailable"] = "下载记录不可用",
        ["No downloaded covers recorded"] = "没有已下载封面的记录",
        ["Newer"] = "较新",
        ["Older"] = "较旧",
        ["Downloaded covers"] = "已下载的封面",
        ["Album: %s"] = "专辑：%s",
        ["Artist: %s"] = "艺术家：%s",
        ["Recorded: %s"] = "记录时间：%s",
        ["Size: %d bytes"] = "大小：%d 字节",
        ["Status: %s"] = "状态：%s",
        ["Backup"] = "备份",
        ["Revert: rename to %s"] = "撤销：重命名为 %s",
        ["Cancel"] = "取消",
        ["Downloaded cover"] = "已下载的封面",
        ["Cover reverted. Use Reload cover if it still shows"] = "封面已撤销。如果仍显示旧封面，请使用“重新加载封面”",
        ["No files changed"] = "未更改任何文件",
        ["Play a local track first"] = "请先播放本地曲目",
        ["No downloaded cover recorded for this album"] = "此专辑没有已下载封面的记录",
        ["This album"] = "此专辑",
        ["Tracks at the top of the card are not repaired"] = "存储卡根目录下的曲目不支持修复",
        ["Update the music database, then try again"] = "请先更新音乐数据库，然后再试",
        ["The track changed; try again"] = "曲目已切换，请重试",
        ["Library is too large to check safely"] = "媒体库过大，无法安全检查",
        ["Could not check folder artwork"] = "无法检查文件夹封面",
        ["Shared artwork found, but no safe backup name is free"] = "发现共享封面，但没有可用的安全备份名称",
        ["No shared generic artwork affects this album"] = "没有影响此专辑的共享通用封面",
        ["Rename %d file to %s"] = "将 %d 个文件重命名为 %s",
        ["Rename %d files to %s"] = "将 %d 个文件重命名为 %s",
        ["Shared folder artwork"] = "共享文件夹封面",
        ["Renamed %d, could not rename %d"] = "已重命名 %d 个，失败 %d 个",
        ["Renamed %d. Use Reload cover if old artwork still shows"] = "已重命名 %d 个。如果仍显示旧封面，请使用“重新加载封面”",
        ["About Cover Art Fetcher"] = "关于封面获取器",
        ["Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."] = "在 MusicBrainz 上查找当前专辑，并从 Cover Art Archive 下载 500px（或 250px）正面 JPEG 封面，作为 <专辑名>.jpg 保存在曲目旁。",
        ["Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."] = "绝不覆盖已有的专辑封面文件。匹配策略非常谨慎：媒体库标签必须与当前播放一致，且专辑文件名不得与相邻文件夹或其他艺术家冲突。",
        ["The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."] = "Lua API 无法检测音频文件内嵌的封面图片，因此这类专辑仍可能会下载文件夹封面。",
        ["A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."] = "曲目旁或上一级文件夹中的通用 cover 或 folder 图片可能会显示在该处的所有专辑上。“修复共享文件夹封面”会列出这些文件，并仅在确认后将其重命名为 .compas-backup。",
        ["Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."] = "此插件保存的每张封面都会记录精确路径、大小和校验值。可在“已下载的封面”中撤销：确认后，只要文件未被改动，就会重命名为 .compas-backup。你自己添加或修改的文件绝不会被改动。",
        ["Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."] = "缺失封面请求会在下载前保存，并在 Wi-Fi 恢复时继续下载（重启后依然有效）。可在“待处理的封面请求”中重试或清除。",
        ["Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."] = "自动模式默认关闭，需手动开启。MusicBrainz 限制每秒最多查询一次。",
        ["Cover Art Fetcher"] = "封面获取器",
        ["Fetch cover for current album"] = "获取当前专辑封面",
        ["Pending cover requests (%s)"] = "待处理的封面请求（%s）",
        ["unavailable"] = "不可用",
        ["Pending cover requests"] = "待处理的封面请求",
        ["%d saved request(s)"] = "%d 个已保存请求",
        ["A request is downloading"] = "正在下载请求",
        ["Waiting for connection or retry time"] = "正在等待网络连接或重试时间",
        ["Retry pending downloads"] = "重试待处理的下载",
        ["Clear pending requests…"] = "清除待处理的请求…",
        ["Clear pending requests?"] = "清除待处理的请求？",
        ["Keep requests"] = "保留请求",
        ["Clear requests"] = "清除请求",
        ["Pending requests cleared"] = "已清除待处理的请求",
        ["Could not save queue change"] = "无法保存队列更改",
        ["Automatic fetch"] = "自动获取",
        ["Revert cover for current album"] = "撤销当前专辑封面",
        ["Repair shared folder artwork"] = "修复共享文件夹封面",
        ["How it works"] = "工作原理",
        ["Saved cover requests could not be read; check Cover Art Fetcher settings"] = "无法读取已保存的封面请求，请检查封面获取器设置",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- Fills a missing album-title.jpg sidecar from MusicBrainz + Cover Art Archive.
-- Prefers the 500px JPEG front thumbnail. Never overwrites an existing
-- album-title.jpg. Embedded artwork is not exposed in the Lua API, so a folder
-- whose files already have pictures in tags may still get a sidecar.
-- A separate, confirmed repair renames shared generic cover/folder images
-- that hide the current album's art; it never runs automatically.
-- Each saved cover has a durable receipt so the user can revert it later.

local USER_AGENT = "CompasPlayer-CoverArtFetcher/1.2.0 (https://github.com/Starnished66/compas-player)"
local STATE_PATH = plugin.sd_root() .. "/.plugins/.cover_art_fetcher_state"
local PENDING_PATH = plugin.sd_root() .. "/.plugins/.cover_art_fetcher_pending"
local PENDING_TMP = PENDING_PATH .. ".tmp"
local PENDING_HEADER = "CAF-PENDING 1"
local PENDING_MAX = 500
local PENDING_MAX_BYTES = 2 * 1024 * 1024
local MB_INTERVAL = 1
local MAX_JSON = 262144
local MAX_IMAGE_BYTES = 2 * 1024 * 1024
local IMAGE_TOTAL_TIMEOUT_MS = 90000
local MAX_REDIRECTS = 5
local SONG_PAGE = 50
local MAX_LIBRARY_SCAN = 100000
local MAX_PATH = 4095
local MAX_FILENAME = 255 - #".jpg.compas-fetch" - #".part.XXXXXX"
local MAX_FAIL_KEYS = 40
local FAIL_COOLDOWN = 6 * 60 * 60
local MB_RESULT_LIMIT = 25
local JSON_LIMITS = { max_input_bytes = MAX_JSON, max_nesting = 16, max_entries = 8000 }
-- The native refresh accepts one start per plugin per minute and refuses
-- while library work runs. Saves inside that window share one retry.
local REFRESH_SPACING = 61
local REFRESH_BUSY_RETRY = 15
local REFRESH_MAX_ATTEMPTS = 40
-- Names the native lookup tries for generic folder art, in its order.
local GENERIC_NAMES = { "cover.jpeg", "cover.jpg", "cover.png", "cover.bmp", "folder.jpg", "folder.jpeg", "folder.png" }
local ALBUM_EXTS = { "jpeg", "jpg", "png", "bmp" }
local BACKUP_SUFFIX = ".compas-backup"
local MAX_BACKUP_SLOTS = 9
local REPAIR_MAX_IDENTITIES = 64
local REPAIR_DIRS_PER_IDENTITY = 4
local MAX_LIST_LABEL = 500

local state = { auto = false }
local mb_next_ok = 0
local queue = {}
local busy = false
local pending_dest = {}
local generation = 0
local fail_memory = {}
local last_auto_key = nil
local active_job = nil
local pending_items, pending_loaded, pending_inflight = {}, false, nil
local pending_generation, pending_next_at = 0, 0
local pending_network_until, pending_network_failures = 0, 0
local pending_load_retry_at = 0
local pending_server_until = 0
local pending_blocked_delete = {}
local pending_last_attempt = 0
local enqueue, auto_suppressed, pending_drain
local MANUAL_REFRESH_SECONDS = 25
local refresh = { pending = false, next_at = 0, attempts = 0 }

local function trim(s)
    return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function lower(s)
    return trim(s):lower()
end

local function load_state()
    local f = io.open(STATE_PATH, "r")
    if not f then return end
    local line = f:read("*l")
    f:close()
    state.auto = line == "1"
end

local function save_state()
    local tmp = STATE_PATH .. ".tmp"
    local f = io.open(tmp, "w")
    if not f then return end
    f:write(state.auto and "1" or "0", "\n")
    f:close()
    os.remove(STATE_PATH)
    os.rename(tmp, STATE_PATH)
end

local function url_encode(value)
    return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function lucene_escape(value)
    return (tostring(value):gsub("([%+%-&|!%(%)%{%}%[%]%^\"~%*:?\\/])", "\\%1"))
end

local function header(headers, name)
    if type(headers) ~= "table" then return nil end
    local want = name:lower()
    for k, v in pairs(headers) do
        if type(k) == "string" and k:lower() == want then return v end
    end
    return nil
end

local function is_absolute_local_path(path)
    return type(path) == "string" and path:sub(1, 1) == "/" and not path:find("://", 1, true)
end

local function file_exists(path)
    if not path then return false end
    local f = io.open(path, "rb")
    if not f then return false end
    f:close()
    return true
end

local function file_size(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local size = f:seek("end")
    f:close()
    return size
end

local function album_dir(path)
    if not is_absolute_local_path(path) then return nil end
    local slash = path:match("^.*()/")
    if not slash or slash < 2 then return nil end
    return path:sub(1, slash - 1)
end

-- The player's own filename substitutions, applied to the raw tag exactly as
-- the native lookup does (no trimming).
local function native_album_name(album)
    if type(album) ~= "string" or album == "" then return nil end
    return (album:gsub('"', "'"):gsub('[%*/:<>?\\|]', "_"))
end

-- Takes the raw indexed album tag. The native lookup does not trim, so a tag
-- with outer spaces would get a sidecar it never opens; refuse it instead.
local function sanitized_album_name(album)
    if type(album) ~= "string" then return nil, "unsafe-name" end
    if album ~= trim(album) then return nil, "untrimmed-album" end
    local name = native_album_name(album)
    if not name then return nil, "unsafe-name" end
    local generic = lower(name)
    if name:find("[%c]") or generic:match("%.[0-9]+x[0-9]+$") then return nil, "unsafe-name" end
    if name == "." or name == ".." or #name > MAX_FILENAME
        or generic == "cover" or generic == "folder" or generic == "artist" then return nil, "unsafe-name" end
    return name
end

local function cover_path(dir, album)
    local name, reason = sanitized_album_name(album)
    if not dir or not name then return nil, reason or "unsafe-name" end
    local path = dir .. "/" .. name .. ".jpg"
    if #path + #".compas-fetch.part.XXXXXX" > MAX_PATH then return nil, "unsafe-name" end
    return path
end

local function album_key(artist, album, dir)
    return lower(artist) .. "\t" .. lower(album) .. "\t" .. tostring(dir or "")
end

local function failed_recently(key)
    local t = fail_memory[key]
    return t and (os.time() - t) < FAIL_COOLDOWN
end

local function remember_fail(key)
    fail_memory[key] = os.time()
    local n = 0
    for _ in pairs(fail_memory) do n = n + 1 end
    if n <= MAX_FAIL_KEYS then return end
    local oldest_k, oldest_t
    for k, t in pairs(fail_memory) do
        if not oldest_t or t < oldest_t then
            oldest_k, oldest_t = k, t
        end
    end
    if oldest_k then fail_memory[oldest_k] = nil end
end

local function notify(message, is_auto)
    if is_auto then return end
    plugin.show_toast(message)
end

-- Bounded decode; a malformed or oversized body is treated like no data.
-- Size and type are checked here too, not only by the request limit.
local function decode_json(body)
    if type(body) ~= "string" or body == "" or #body > MAX_JSON then return nil end
    local ok, value = pcall(plugin.json_decode, body, JSON_LIMITS)
    if not ok or type(value) ~= "table" then return nil end
    return value
end

-- One coalesced library refresh. The native call is rate limited and may be
-- busy; retry from the interval until it starts or the attempts run out.
local function try_refresh()
    if not refresh.pending or os.time() < refresh.next_at then return end
    refresh.attempts = refresh.attempts + 1
    local ok, started, reason = pcall(plugin.refresh_library)
    if ok and started ~= false then
        refresh.pending = false
        refresh.next_at = os.time() + REFRESH_SPACING
        return
    end
    if not ok or refresh.attempts >= REFRESH_MAX_ATTEMPTS
        or (reason ~= "rate_limited" and reason ~= "already_running") then
        refresh.pending = false
        return
    end
    refresh.next_at = os.time() + (reason == "rate_limited" and REFRESH_SPACING or REFRESH_BUSY_RETRY)
end

local function request_refresh()
    refresh.pending = true
    refresh.attempts = 0
    try_refresh()
end

local function progress_available()
    return plugin.has_capability("ui.progress")
end

local function open_job_progress(job, message, fraction)
    if not job or (job.is_auto and not job.manual_requested) or not progress_available() then return false end
    if job.progress_handle and plugin.update_progress(job.progress_handle, message, fraction) then
        return true
    end
    job.progress_handle = nil
    job.progress_attempted = true
    job.progress_handle = plugin.show_progress(tr("Fetching cover art"), message, fraction)
    return job.progress_handle ~= nil
end

local function update_job_progress(job, message, fraction)
    if not job or (job.is_auto and not job.manual_requested) or not progress_available() then return false end
    if job.progress_handle and plugin.update_progress(job.progress_handle, message, fraction) then
        return true
    end
    job.progress_handle = nil
    if not job.progress_attempted then
        job.progress_attempted = true
        job.progress_handle = plugin.show_progress(tr("Fetching cover art"), message, fraction)
        return job.progress_handle ~= nil
    end
    return false
end

local function close_job_progress(job)
    if job and job.progress_handle then
        plugin.close_progress(job.progress_handle)
        job.progress_handle = nil
    end
end

local function notify_job(job, message)
    if not job or (job.is_auto and not job.manual_requested) then return end
    plugin.show_toast(message)
end

local function set_stage(job, stage)
    if not job then return end
    job.stage = stage
    job.next_status_refresh = os.time() + MANUAL_REFRESH_SECONDS
    update_job_progress(job, stage, nil)
end

local function active_status(job)
    local stage = job and job.stage or tr("Cover fetch in progress")
    return string.format(tr("Cover fetch already in progress — %s"), stage)
end

local function artist_credit_name(release)
    local credit = release["artist-credit"]
    if type(credit) ~= "table" then return "" end
    local parts = {}
    for i = 1, #credit do
        local item = credit[i]
        if type(item) == "table" then
            local name = item.name
            if type(name) ~= "string" or name == "" then
                local artist = item.artist
                if type(artist) == "table" then name = artist.name end
            end
            parts[#parts + 1] = tostring(name or "")
            if type(item.joinphrase) == "string" then
                parts[#parts + 1] = item.joinphrase
            end
        end
    end
    return trim(table.concat(parts))
end

local function names_equal(a, b)
    return lower(a) ~= "" and lower(a) == lower(b)
end

-- Keep only releases whose title and artist credit match the tags. Shared
-- album titles by other artists are dropped rather than guessed.
local function is_mbid(id)
    return type(id) == "string" and #id == 36
        and id:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
end

-- The search is over release groups, so editions of one album collapse into
-- one row. Keep only groups whose title and artist credit match the tags.
-- Exactly one group must remain, and the reply must be the complete result
-- set: a truncated page could hide a second album with the same title.
local function pick_release_group(payload, artist, album, album_artist)
    if type(payload) ~= "table" or type(payload["release-groups"]) ~= "table" then return nil, "no-match" end
    local groups = payload["release-groups"]
    local count, offset = payload.count, payload.offset
    if type(count) ~= "number" or count ~= #groups then return nil, "incomplete" end
    if offset ~= nil and offset ~= 0 then return nil, "incomplete" end

    local want_artist = album_artist ~= "" and album_artist or artist
    local match_id, credit_seen
    for i = 1, #groups do
        local group = groups[i]
        if type(group) == "table" and names_equal(group.title, album) then
            local credit = artist_credit_name(group)
            if names_equal(credit, want_artist) or names_equal(credit, artist) then
                -- A matching row without a usable id is ambiguous, not skippable.
                if not is_mbid(group.id) then return nil, "no-match" end
                if match_id and group.id ~= match_id then return nil, "no-match" end
                if credit_seen and lower(credit) ~= credit_seen then return nil, "no-match" end
                match_id, credit_seen = group.id, lower(credit)
            end
        end
    end
    if not match_id then return nil, "no-match" end
    return match_id
end

-- Sized thumbnails only, never the unsized original in img.image. Numeric
-- keys come first; older images list only the documented aliases "large"
-- (500px) and "small" (250px), accepted only when the URL names that size.
local THUMBNAIL_KEYS = {
    { key = "500" }, { key = 500 }, { key = "250" }, { key = 250 },
    { key = "large", suffix = "%-500%.jpg$" }, { key = "small", suffix = "%-250%.jpg$" },
}

local function thumbnail_url(listing)
    if type(listing) ~= "table" or type(listing.images) ~= "table" then return nil end
    for i = 1, #listing.images do
        local img = listing.images[i]
        if type(img) == "table" and img.front == true and type(img.thumbnails) == "table" then
            for _, choice in ipairs(THUMBNAIL_KEYS) do
                local url = img.thumbnails[choice.key]
                if type(url) == "string" and url:match("^https?://") and url ~= img.image
                    and (not choice.suffix or url:match(choice.suffix)) then
                    return url
                end
            end
        end
    end
    return nil
end

local function to_https(url)
    if type(url) ~= "string" then return nil end
    if url:match("^http://") then
        return "https://" .. url:sub(8)
    end
    if url:match("^https://") then return url end
    return nil
end

local function resolve_reference(base, location)
    local ref = trim(location):gsub("#.*$", "")
    if ref == "" then return nil end
    if ref:match("^https://") then return ref end
    if ref:match("^http://") then return "https://" .. ref:sub(8) end
    if ref:match("^[%a][%w+.-]*:") then return nil end
    local scheme, host, path = tostring(base or ""):match("^(https)://([^/?#]+)([^?#]*)")
    if not scheme then
        local http_host, http_path
        http_host, http_path = tostring(base or ""):match("^http://([^/?#]+)([^?#]*)")
        if not http_host then return nil end
        scheme, host, path = "https", http_host, http_path
    end
    if ref:sub(1, 2) == "//" then
        return "https:" .. ref
    end
    if path == "" then path = "/" end
    if ref:sub(1, 1) == "/" then
        return scheme .. "://" .. host .. ref
    end
    local dir = path:match("^.*/") or "/"
    return scheme .. "://" .. host .. dir .. ref
end

local function is_redirect(status)
    return status == 301 or status == 302 or status == 303 or status == 307 or status == 308
end

local function http_json(url, redirect_limit, callback)
    return plugin.http_request({
        url = url,
        method = "GET",
        headers = {
            ["User-Agent"] = USER_AGENT,
            ["Accept"] = "application/json",
        },
        verify_tls = true,
        max_response_bytes = MAX_JSON,
        connect_timeout_ms = 10000,
        read_timeout_ms = 15000,
        total_timeout_ms = 30000,
        redirect_limit = redirect_limit or 5,
    }, callback)
end

local function path_is_under_root(path, root)
    if not is_absolute_local_path(path) or path:find("%z") or path:find("//", 1, true) then return false end
    root = tostring(root or ""):gsub("/+$", "")
    if root == "" or path:sub(1, #root + 1) ~= root .. "/" then return false end
    for component in path:gmatch("[^/]+") do
        if component == "." or component == ".." then return false end
    end
    return true
end

local function directories_overlap(a, b)
    if a == b or a:sub(1, #b + 1) == b .. "/" or b:sub(1, #a + 1) == a .. "/" then return true end
    -- Native artwork lookup also falls back between sibling disc folders.
    local function disc_parent(dir)
        local parent, name = dir:match("^(.*)/([^/]+)$")
        name = (name or ""):lower()
        if name:match("^cd[ _%.%-]*%d+$") or name:match("^disc[ _%.%-]*%d+$")
            or name:match("^disk[ _%.%-]*%d+$") then return parent end
    end
    local parent = disc_parent(a)
    return parent ~= nil and parent == disc_parent(b)
end

-- One bounded, paged pass over the indexed library; memory stays constant.
local function scan_library(visitor)
    local offset, expected_total = 0, nil
    while true do
        local songs, total = plugin.library_get_songs(offset, SONG_PAGE)
        if type(songs) ~= "table" or type(total) ~= "number" or total < 0 or total % 1 ~= 0 then
            return false, "scan-failed"
        end
        if total > MAX_LIBRARY_SCAN then return false, "scan-limit" end
        if expected_total and total ~= expected_total then return false, "scan-failed" end
        expected_total = total
        if #songs > math.min(SONG_PAGE, total - offset) then return false, "scan-failed" end
        if offset < total and (#songs == 0 or #songs < math.min(SONG_PAGE, total - offset)) then
            return false, "scan-failed"
        end
        if #songs == 0 then return true end
        for i = 1, #songs do
            if type(songs[i]) ~= "table" or type(songs[i].path) ~= "string" then
                return false, "scan-failed"
            end
            local keep_going, reason = visitor(songs[i])
            if keep_going == false then return false, reason end
        end
        offset = offset + #songs
        if offset >= total then return true end
        if offset >= MAX_LIBRARY_SCAN then return false, "scan-limit" end
    end
end

local function protected_scan(visitor)
    local ok, err = pcall(function()
        local complete, reason = scan_library(visitor)
        if not complete then error(reason, 0) end
    end)
    if ok then return true end
    return false, type(err) == "string" and err or "scan-failed"
end

-- Scan the whole indexed library so title filenames cannot shadow another
-- album's sidecar in this directory or an ancestor/child directory.
local function inspect_library(path, now_artist, now_album)
    local current_dir = album_dir(path)

    local found
    local ok, scan_err = protected_scan(function(song)
        if song.path == path then
            if found or type(song.album) ~= "string" or not names_equal(song.artist, now_artist)
                or not names_equal(song.album, now_album)
                or trim(song.artist) == "" or trim(song.album) == "" then
                return false, "metadata-mismatch"
            end
            found = { path = song.path, artist = trim(song.artist), album = trim(song.album),
                raw_album = song.album, album_artist = trim(song.album_artist or "") }
        end
    end)
    if not ok then return nil, scan_err end
    if not found then return nil, "not-indexed" end
    local current_name, name_err = sanitized_album_name(found.raw_album)
    if not current_name then return nil, name_err end

    local current_effective = trim(found.album_artist or "")
    if current_effective == "" then current_effective = trim(found.artist) end
    local conflict, track_conflict = false, false
    ok, scan_err = protected_scan(function(song)
        local song_dir = path_is_under_root(song.path, plugin.sd_root()) and album_dir(song.path) or nil
        if song_dir and directories_overlap(current_dir, song_dir) then
            local song_name = sanitized_album_name(song.album)
            local effective = trim(song.album_artist or "")
            if effective == "" then effective = trim(song.artist) end
            if song_name and lower(song_name) == lower(current_name)
                and (lower(effective) ~= lower(current_effective) or not names_equal(song.album, found.album)) then
                conflict = true
            end
            if song_dir == current_dir then
                local stem = tostring(song.path):match("([^/]+)%.[^%.]+$")
                if stem and lower(stem) == lower(current_name) then
                    local same_album = names_equal(song.album, found.album) and lower(effective) == lower(current_effective)
                    if not same_album then track_conflict = true end
                end
            end
        end
    end)
    if not ok then return nil, scan_err end
    if track_conflict then return nil, "track-name-collision" end
    if conflict then return nil, "title-collision" end
    return found
end

local function current_album()
    local path = plugin.get_current_track_path()
    if not path_is_under_root(path, plugin.sd_root()) then return nil end
    local _, artist, album = plugin.get_now_playing()
    artist, album = trim(artist), trim(album)
    if artist == "" or album == "" then return nil end
    local dir = album_dir(path)
    if not dir then return nil end
    local song, err = inspect_library(path, artist, album)
    if not song then return nil, err end
    if plugin.get_current_track_path() ~= path then return nil, "track-changed" end
    artist, album = trim(song.artist), trim(song.album)
    local album_artist = trim(song.album_artist or "")
    local dest, dest_err = cover_path(dir, song.raw_album)
    if not dest then return nil, dest_err end
    return {
        artist = artist,
        album = album,
        album_artist = album_artist,
        dir = dir,
        dest = dest,
        path = path,
        key = album_key(artist, album, dir),
    }
end

local function pending_escape(v)
    return tostring(v or ""):gsub("%%", "%%25"):gsub("\t", "%%09"):gsub("\n", "%%0A"):gsub("\r", "%%0D")
end
local function pending_unescape(v)
    return (v:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end))
end
local function pending_encode(items)
    local out = { PENDING_HEADER .. "\t" .. tostring(pending_server_until) }
    for _, q in ipairs(items) do
        out[#out + 1] = table.concat({ pending_escape(q.path), pending_escape(q.artist), pending_escape(q.album),
            pending_escape(q.album_artist), pending_escape(q.dest), tostring(q.requested),
            tostring(q.retry_at), tostring(q.attempts), q.explicit and "1" or "0" }, "\t")
    end
    return table.concat(out, "\n") .. "\n"
end
local function save_pending(items)
    local data = pending_encode(items)
    if #items > PENDING_MAX or #data > PENDING_MAX_BYTES then return false end
    local f = io.open(PENDING_TMP, "wb")
    if not f then return false end
    local ok = pcall(function() assert(f:write(data)); assert(f:close()) end)
    if not ok then
        pcall(function() f:close() end)
        os.remove(PENDING_TMP)
        return false
    end
    if not os.rename(PENDING_TMP, PENDING_PATH) then
        os.remove(PENDING_TMP)
        return false
    end
    return true
end
local function pending_item_valid(q)
    if type(q) ~= "table" or type(q.path) ~= "string" or not path_is_under_root(q.path, plugin.sd_root()) then return false end
    for _, k in ipairs({ "artist", "album", "album_artist" }) do
        if type(q[k]) ~= "string" or #q[k] > 1024 or q[k]:find("[%c]") then return false end
    end
    if trim(q.artist) == "" or trim(q.album) == "" or type(q.explicit) ~= "boolean" then return false end
    local dir = album_dir(q.path)
    local dest = dir and cover_path(dir, q.album)
    if not dest or q.dest ~= dest then return false end
    for _, k in ipairs({ "requested", "retry_at", "attempts" }) do
        if type(q[k]) ~= "number" or q[k] < 0 or q[k] % 1 ~= 0 then return false end
    end
    return true
end
local function load_pending()
    pending_items, pending_loaded = {}, false
    local f, open_err, open_code = io.open(PENDING_PATH, "rb")
    if not f then
        if open_code == 2 or (type(open_err) == "string" and open_err:find("No such file", 1, true)) then
            pending_loaded = true; return true
        end
        return false
    end
    local data, read_err = f:read(PENDING_MAX_BYTES + 1)
    local closed = f:close()
    if read_err or not closed then return false end
    if type(data) ~= "string" or #data > PENDING_MAX_BYTES then return false end
    local first_end = data:find("\n", 1, true)
    if not first_end then return false end
    local header = data:sub(1, first_end - 1)
    local deadline = header:match("^" .. PENDING_HEADER:gsub("(%W)", "%%%1") .. "\t(%d+)$")
    if not deadline or #deadline > 12 then return false end
    pending_server_until = tonumber(deadline)
    local loaded, seen, pos, records = {}, {}, first_end + 1, 0
    while pos <= #data do
        local eol = data:find("\n", pos, true)
        if not eol then return false end
        local line = data:sub(pos, eol - 1)
        pos = eol + 1
        if line ~= "" then
            records = records + 1
            if records > PENDING_MAX then return false end
            local fields, field_pos = {}, 1
            for _ = 1, 8 do
                local at = line:find("\t", field_pos, true)
                if not at then return false end
                fields[#fields + 1] = line:sub(field_pos, at - 1); field_pos = at + 1
            end
            fields[#fields + 1] = line:sub(field_pos)
            if #fields ~= 9 or (fields[9] ~= "0" and fields[9] ~= "1") then return false end
            local function stored_uint(text)
                if not text:match("^%d+$") or #text > 12 then return nil end
                return tonumber(text)
            end
            local q = { path = pending_unescape(fields[1]), artist = pending_unescape(fields[2]),
                album = pending_unescape(fields[3]), album_artist = pending_unescape(fields[4]),
                dest = pending_unescape(fields[5]), requested = stored_uint(fields[6]),
                retry_at = stored_uint(fields[7]), attempts = stored_uint(fields[8]), explicit = fields[9] == "1" }
            if not pending_item_valid(q) or seen[q.dest] then return false end
            seen[q.dest] = true; loaded[#loaded + 1] = q
        end
    end
    pending_items, pending_loaded = loaded, true
    return true
end
local function pending_add(job, is_auto)
    if not pending_loaded and not load_pending() then
        if not is_auto then plugin.show_toast(tr("Could not read saved cover requests")) end
        return false
    end
    for i, q in ipairs(pending_items) do
        if q.dest == job.dest then
            local old = {}; for k, v in pairs(q) do old[k] = v end
            q.path, q.artist, q.album, q.album_artist = job.path, job.artist, job.album, job.album_artist or ""
            q.requested = os.time()
            if not is_auto then
                q.manual_requested, q.explicit = true, true
                q.retry_at, q.attempts = 0, 0
                pending_network_until, pending_network_failures = 0, 0
            end
            if not pending_item_valid(q) then
                for k in pairs(q) do q[k] = nil end; for k, v in pairs(old) do q[k] = v end
                if not is_auto then plugin.show_toast(tr("Album tags or path are not supported")) end
                return false
            end
            table.remove(pending_items, i); table.insert(pending_items, 1, q)
            if not save_pending(pending_items) then
                table.remove(pending_items, 1); table.insert(pending_items, i, q)
                for k in pairs(q) do q[k] = nil end; for k, v in pairs(old) do q[k] = v end
                if not is_auto then plugin.show_toast(tr("Could not update saved cover request")) end
                return false
            end
            if not is_auto then
                pending_blocked_delete[q.dest] = nil
                plugin.show_toast(tr("Cover request is already saved"))
                if active_job and active_job.pending_item == q then
                    active_job.manual_requested = true
                    open_job_progress(active_job, active_job.stage or tr("Cover fetch in progress"), nil)
                else
                    for _, queued in ipairs(queue) do
                        if queued.pending_item == q then
                            queued.manual_requested = true
                            open_job_progress(queued, queued.stage or tr("Cover fetch queued"), nil)
                        end
                    end
                end
            end
            return true
        end
    end
    if #pending_items >= PENDING_MAX then
        if not is_auto then plugin.show_toast(tr("Saved cover request queue is full")) end
        return false
    end
    local q = { path = job.path, artist = job.artist, album = job.album,
        album_artist = job.album_artist or "", dest = job.dest, requested = os.time(), retry_at = 0, attempts = 0,
        manual_requested = not is_auto, explicit = not is_auto }
    if not pending_item_valid(q) then
        if not is_auto then plugin.show_toast(tr("Album tags or path are not supported")) end
        return false
    end
    if not is_auto then pending_network_until, pending_network_failures = 0, 0 end
    table.insert(pending_items, 1, q)
    if not save_pending(pending_items) then table.remove(pending_items, 1)
        if not is_auto then plugin.show_toast(tr("Could not save request; it was not queued")) end
        return false
    end
    if not is_auto then plugin.show_toast(tr("Cover request saved for download")) end
    return true
end
local function pending_delete(q)
    local ix
    for i, item in ipairs(pending_items) do if item == q then ix = i; break end end
    if not ix then return true end
    table.remove(pending_items, ix)
    if not save_pending(pending_items) then
        table.insert(pending_items, ix, q)
        pending_blocked_delete[q.dest] = q
        pending_next_at = os.time() + 60
        return false
    end
    pending_blocked_delete[q.dest] = nil
    return true
end
local function retry_after_seconds(value)
    local seconds = tonumber(value)
    if seconds and seconds == seconds and seconds > 0 and seconds < math.huge then return math.min(seconds, 24 * 60 * 60) end
    if type(value) ~= "string" then return nil end
    local day, mon, year, hour, minute, second = value:match("%a+, (%d%d) (%a+) (%d%d%d%d) (%d%d):(%d%d):(%d%d) GMT")
    local months = {Jan=1,Feb=2,Mar=3,Apr=4,May=5,Jun=6,Jul=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12}
    if not day or not months[mon] then return nil end
    local ok, stamp = pcall(os.time, {year=tonumber(year),month=months[mon],day=tonumber(day),
        hour=tonumber(hour),min=tonumber(minute),sec=tonumber(second),isdst=false})
    if not ok or type(stamp) ~= "number" then return nil end
    local offset = os.difftime(os.time(os.date("!*t", stamp)), stamp)
    return math.min(24 * 60 * 60, math.max(0, stamp - offset - os.time()))
end

local function pending_defer(q, seconds, server_limited, network_failure)
    q.attempts = math.min((q.attempts or 0) + 1, 30)
    q.manual_requested = false
    local requested_delay = retry_after_seconds(seconds)
    local delay = math.ceil(math.max(60, requested_delay or 0, math.min(3600, 60 * 2 ^ math.min(q.attempts - 1, 6))))
    q.retry_at = os.time() + delay
    if server_limited then
        pending_server_until = math.max(pending_server_until, q.retry_at)
    end
    -- A failed album waits independently; other ready albums can continue.
    pending_next_at = os.time() + MB_INTERVAL
    if network_failure then
        pending_network_failures = math.min(7, pending_network_failures + 1)
        pending_network_until = os.time() + math.min(3600, 60 * 2 ^ (pending_network_failures - 1))
    end
    if not save_pending(pending_items) then
        -- Preserve the in-memory cooldown even if the SD write failed.
        pending_next_at = os.time() + 60
    end
end
local function pending_network()
    if not plugin.has_capability("network.status") or type(plugin.network_status) ~= "function" then return nil end
    local ok, info = pcall(plugin.network_status)
    return ok and type(info) == "table" and info or nil
end
local function pending_retry_all(quiet)
    if not pending_loaded and not load_pending() then
        if not quiet then plugin.show_toast(tr("Could not read saved cover requests")) end
        return false
    end
    -- Manual retry may clear transport backoff, but never a server Retry-After floor.
    local now, old = os.time(), {}
    for i, q in ipairs(pending_items) do
        old[i] = q.retry_at
        if q.retry_at > now and q.retry_at <= pending_server_until then
            -- Keep the persisted server deadline.
        else
            q.retry_at = 0
        end
    end
    pending_next_at = math.max(now, mb_next_ok, pending_server_until)
    if not save_pending(pending_items) then
        for i, q in ipairs(pending_items) do q.retry_at = old[i] end
        if not quiet then plugin.show_toast(tr("Could not save retry request")) end
        return
    end
    pending_network_until, pending_network_failures = 0, 0
    pending_drain()
end
local function pending_clear()
    local empty = {}
    if not save_pending(empty) then return false end
    pending_generation = pending_generation + 1
    if active_job and active_job.pending_item then
        close_job_progress(active_job)
        pending_dest[active_job.dest] = nil
        active_job = nil; busy = false; generation = generation + 1
    end
    pending_inflight = nil
    local kept = {}
    for _, job in ipairs(queue) do
        if not job.pending_item then kept[#kept + 1] = job
        else close_job_progress(job) end
    end
    queue = kept
    pending_items = empty
    pending_loaded = true
    pending_network_until, pending_network_failures = 0, 0
    pending_blocked_delete = {}
    pending_next_at = math.max(os.time(), mb_next_ok, pending_server_until)
    return true
end

local function sd_root_dir()
    return (tostring(plugin.sd_root() or ""):gsub("/+$", ""))
end

local function regular_file(path)
    local f = io.open(path, "rb")
    if not f then return false end
    local _, err = f:read(0)
    f:close()
    return err == nil
end

-- First free non-image backup name; an existing backup is never reused.
local function backup_path(path)
    for slot = 1, MAX_BACKUP_SLOTS do
        local candidate = path .. BACKUP_SUFFIX .. (slot == 1 and "" or ("-" .. slot))
        if #candidate > MAX_PATH then return nil end
        if not file_exists(candidate) then return candidate end
    end
    return nil
end

-- Size and MD5 of a regular file of at most MAX_IMAGE_BYTES, or nil. One read
-- of at most 2 MiB; the hash itself runs natively.
local function file_fingerprint(path)
    if type(path) ~= "string" then return nil, nil, "unavailable" end
    local f, open_err, open_code = io.open(path, "rb")
    if not f then
        if open_code == 2 then
            -- ENOENT is evidence of absence only if the containing directory
            -- itself can be opened. A missing/unreadable parent can mean the
            -- card or a directory is unavailable, so recovery must wait.
            local parent = album_dir(path)
            local dir = parent and io.open(parent, "rb")
            if dir then
                dir:close()
                return nil, nil, "missing"
            end
        end
        return nil, nil, "unavailable"
    end
    local size = f:seek("end")
    if not size or not f:seek("set", 0) then
        f:close()
        return nil, nil, "unavailable"
    end
    if size < 1 or size > MAX_IMAGE_BYTES then
        f:close()
        return nil, nil, "different"
    end
    local data, read_err = f:read(size)
    local closed, close_err = f:close()
    if type(data) ~= "string" or #data ~= size or not closed then
        return nil, nil, "unavailable"
    end
    return size, plugin.md5(data), "readable"
end

-- ---- Download receipts ----
-- Every cover this plugin saves has a receipt in plugin.storage, written
-- before the cover appears (write-ahead), so it can later be reverted. A
-- receipt names the exact file, its size and MD5. States:
--   pending    recorded, cover not yet confirmed in place
--   saved      the cover at dest is ours (if size and MD5 still match)
--   void       the cover was never put in place
--   reverting  a rename to the backup was recorded but not confirmed
--   reverted   the cover was renamed to backup
--   gone       the cover was already missing when the album was fetched again
--   lost       neither the cover nor its backup matched during recovery
-- Recovery decides pending/reverting from the files: while a cover is still
-- staged (dest .. ".compas-fetch") it was never promoted.

local RECEIPT_PREFIX = "rcpt."
local RECEIPT_HEADER = "CAF-RECEIPT 1"
local RECEIPT_MAX_BYTES = 4096
local RECEIPT_MAX_LINES = 32
local MAX_RECEIPTS = 200
local RECOVERY_RETRY_SECONDS = 30
local RECOVERY_MAX_ATTEMPTS = 20
local RECEIPT_FIELDS = { "id", "state", "dest", "size", "md5", "album", "artist", "created",
    "saved_at", "backup", "reverted_at", "superseded_by" }
local RECEIPT_STATES = { pending = true, saved = true, void = true, reverting = true,
    reverted = true, gone = true, lost = true }

local receipts = {}          -- id -> record (valid records only)
local receipt_keys = 0       -- keys under RECEIPT_PREFIX, valid or not
local receipt_next_id = 1
local receipts_ready = false -- loaded and within bounds
local recovery = {}          -- id -> { next_at, attempts }
local receipt_load_retry_at = 0

local function tracking_available()
    return plugin.has_capability("storage.namespaced") and plugin.has_capability("crypto.md5")
end

local function escape_field(value)
    return (tostring(value):gsub("[%%\t\n\r]", function(c) return string.format("%%%02X", c:byte()) end))
end

local function unescape_field(value)
    return (value:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end))
end

local function encode_receipt(r)
    local lines = { RECEIPT_HEADER }
    for _, k in ipairs(RECEIPT_FIELDS) do
        if r[k] ~= nil then lines[#lines + 1] = k .. "\t" .. escape_field(r[k]) end
    end
    return table.concat(lines, "\n")
end

-- Canonical decimal only: no sign, no leading zero (except "0" itself).
local function whole_number(text, max)
    if type(text) ~= "string" or not text:match("^%d+$") or #text > 12 then return nil end
    if #text > 1 and text:sub(1, 1) == "0" then return nil end
    local n = tonumber(text)
    if not n or n < 0 or (max and n > max) then return nil end
    return n
end

local MAX_RECEIPT_ID = 999999999

-- Only "rcpt.<n>" with canonical n >= 1 is a receipt key; aliases such as
-- "rcpt.01" or "rcpt.0" are never read as receipt 1 or written over it.
local function receipt_id_of(key)
    if type(key) ~= "string" or key:sub(1, #RECEIPT_PREFIX) ~= RECEIPT_PREFIX then return nil end
    local id = whole_number(key:sub(#RECEIPT_PREFIX + 1), MAX_RECEIPT_ID)
    if not id or id < 1 then return nil end
    return id
end

local function backup_name_ok(dest, backup)
    if backup == dest .. BACKUP_SUFFIX then return true end
    local slot = backup:sub(#dest + #BACKUP_SUFFIX + 1):match("^%-(%d)$")
    return backup:sub(1, #dest + #BACKUP_SUFFIX) == dest .. BACKUP_SUFFIX
        and slot ~= nil and tonumber(slot) >= 2 and tonumber(slot) <= MAX_BACKUP_SLOTS
end

-- Which optional fields each state may carry; anything else is rejected.
local REQUIRED_FIELDS = { "id", "state", "dest", "size", "md5", "album", "artist", "created" }
local OPTIONAL_FIELDS = {
    pending = {},
    saved = { saved_at = true },
    void = { saved_at = true },
    reverting = { saved_at = true, backup = true },
    reverted = { saved_at = true, backup = true, reverted_at = true },
    gone = { saved_at = true, superseded_by = true },
    lost = { saved_at = true, backup = true, reverted_at = true },
}

local function text_field_ok(text)
    return type(text) == "string" and text ~= "" and #text <= 1024 and not text:find("[%c]")
end

local function path_field_ok(path)
    return type(path) == "string" and path ~= "" and #path <= MAX_PATH and not path:find("[%c]")
end

-- Parses and validates one stored receipt; anything unexpected (aliased key,
-- repeated or unknown field, missing metadata, a path that is not this
-- album's own sidecar) is rejected and never acted on.
local function decode_receipt(key, value)
    local id = receipt_id_of(key)
    if not id or type(value) ~= "string" or #value > RECEIPT_MAX_BYTES then return nil end
    local r, count = {}, 0
    for line in (value .. "\n"):gmatch("([^\n]*)\n") do
        count = count + 1
        if count > RECEIPT_MAX_LINES then return nil end
        if count == 1 then
            if line ~= RECEIPT_HEADER then return nil end
        else
            local k, v = line:match("^([%l%d_]+)\t(.*)$")
            if not k or r[k] ~= nil then return nil end
            r[k] = unescape_field(v)
        end
    end
    if not RECEIPT_STATES[r.state] then return nil end
    for _, k in ipairs(REQUIRED_FIELDS) do
        if r[k] == nil then return nil end
    end
    local allowed = OPTIONAL_FIELDS[r.state]
    for k in pairs(r) do
        local required = false
        for _, name in ipairs(REQUIRED_FIELDS) do
            if name == k then required = true end
        end
        if not required and not allowed[k] then return nil end
    end
    if receipt_id_of(RECEIPT_PREFIX .. r.id) ~= id then return nil end
    local root = sd_root_dir()
    if not path_field_ok(r.dest) or not path_is_under_root(r.dest, root) then return nil end
    if not text_field_ok(r.album) or not text_field_ok(r.artist) then return nil end
    -- The path must be exactly this album's sidecar name in its folder.
    local name = sanitized_album_name(r.album)
    local dir = album_dir(r.dest)
    if not name or not dir or r.dest ~= dir .. "/" .. name .. ".jpg" then return nil end
    r.size = whole_number(r.size, MAX_IMAGE_BYTES)
    if not r.size or r.size < 1 then return nil end
    if not r.md5:match("^%x+$") or #r.md5 ~= 32 or r.md5 ~= r.md5:lower() then return nil end
    r.created = whole_number(r.created)
    if not r.created or r.created < 1 then return nil end
    for _, k in ipairs({ "saved_at", "reverted_at" }) do
        if r[k] ~= nil then
            r[k] = whole_number(r[k])
            if not r[k] then return nil end
        end
    end
    if r.superseded_by ~= nil then
        r.superseded_by = receipt_id_of(RECEIPT_PREFIX .. r.superseded_by)
        if not r.superseded_by or r.superseded_by <= id then return nil end
    end
    if r.backup ~= nil and (not path_field_ok(r.backup) or not path_is_under_root(r.backup, root)
        or not backup_name_ok(r.dest, r.backup)) then
        return nil
    end
    if (r.state == "reverting" or r.state == "reverted") and not r.backup then return nil end
    if r.state == "reverted" and not r.reverted_at then return nil end
    if r.state == "gone" and not r.superseded_by then return nil end
    r.id = id
    return r
end

local function receipt_key(id) return RECEIPT_PREFIX .. tostring(id) end

-- Largest encoding this cover's receipt can reach in any later state. Checked
-- before anything is downloaded or reserved, so no record can become
-- impossible to store halfway through.
local function receipt_fits(dest, album, artist)
    if not path_field_ok(dest) or not path_is_under_root(dest, sd_root_dir())
        or not text_field_ok(album) or not text_field_ok(artist) then return false end
    local backup = dest .. BACKUP_SUFFIX .. "-" .. MAX_BACKUP_SLOTS
    if not path_field_ok(backup) then return false end
    local base = { id = MAX_RECEIPT_ID - 1, dest = dest, size = MAX_IMAGE_BYTES,
        md5 = string.rep("0", 32), album = album, artist = artist, created = 9999999999 }
    local candidates = {
        { state = "pending" }, { state = "saved", saved_at = 9999999999 },
        { state = "void", saved_at = 9999999999 },
        { state = "reverting", saved_at = 9999999999, backup = backup },
        { state = "reverted", saved_at = 9999999999, backup = backup, reverted_at = 9999999999 },
        { state = "gone", saved_at = 9999999999, superseded_by = MAX_RECEIPT_ID },
        { state = "lost", saved_at = 9999999999, backup = backup, reverted_at = 9999999999 },
    }
    for _, extra in ipairs(candidates) do
        local record = {}
        for k, v in pairs(base) do record[k] = v end
        for k, v in pairs(extra) do record[k] = v end
        local encoded = encode_receipt(record)
        if #encoded > RECEIPT_MAX_BYTES or not decode_receipt(receipt_key(record.id), encoded) then return false end
    end
    return true
end

-- true only when the native call confirmed a durable write.
local function store_receipt(r)
    local value = encode_receipt(r)
    if #value > RECEIPT_MAX_BYTES or not decode_receipt(receipt_key(r.id), value) then return false end
    local ok, stored = pcall(plugin.storage.set, receipt_key(r.id), value)
    return ok and stored == true
end

local function copy_receipt(r)
    local out = {}
    for k, v in pairs(r) do out[k] = v end
    return out
end

local function schedule_recovery(id)
    recovery[id] = recovery[id] or { next_at = 0, attempts = 0 }
end

-- Loads every receipt once, bounded by MAX_RECEIPTS. On any storage error,
-- or more keys than the bound, tracking stays unavailable and no cover is
-- downloaded (fail closed).
local function load_receipts()
    receipts, receipt_keys, receipt_next_id, receipts_ready = {}, 0, 1, false
    if not tracking_available() then return false end
    local ok, keys = pcall(plugin.storage.list, RECEIPT_PREFIX)
    if not ok or type(keys) ~= "table" then return false end
    if #keys > MAX_RECEIPTS then return false end
    for _, key in ipairs(keys) do
        if type(key) == "string" and key:sub(1, #RECEIPT_PREFIX) == RECEIPT_PREFIX then
            receipt_keys = receipt_keys + 1
            -- Ids of unreadable or aliased records ("rcpt.07") are reserved
            -- too, so a new receipt never lands next to an alias of itself.
            local digits = key:sub(#RECEIPT_PREFIX + 1)
            local loose = #digits <= 12 and digits:match("^%d+$") and tonumber(digits) or nil
            if loose and loose >= receipt_next_id then receipt_next_id = loose + 1 end
            local got, value = pcall(plugin.storage.get, key)
            local r = got and decode_receipt(key, value) or nil
            if r then
                receipts[r.id] = r
                if r.state == "pending" or r.state == "reverting" then schedule_recovery(r.id) end
            end
        end
    end
    receipts_ready = true
    return true
end

local function sorted_receipts(filter)
    local out = {}
    for _, r in pairs(receipts) do
        if not filter or filter(r) then out[#out + 1] = r end
    end
    table.sort(out, function(a, b) return a.id > b.id end)
    return out
end

-- A destination whose receipt is still being resolved is left alone.
local function dest_unresolved(dest)
    for id, r in pairs(receipts) do
        if r.dest == dest and (r.state == "pending" or r.state == "reverting" or recovery[id]) then
            return true
        end
    end
    return false
end

-- Automatic fetch never undoes a revert. Only a later download that was
-- actually saved lifts that; pending or void records of failed attempts do not.
local REVERT_STATES = { reverting = true, reverted = true, lost = true }
local SAVED_LIFECYCLE = { saved = true, gone = true }

auto_suppressed = function(dest)
    local latest_revert, latest_saved = 0, 0
    for _, r in pairs(receipts) do
        if r.dest == dest then
            if REVERT_STATES[r.state] and r.id > latest_revert then latest_revert = r.id end
            if SAVED_LIFECYCLE[r.state] and r.id > latest_saved then latest_saved = r.id end
        end
    end
    return latest_revert > 0 and latest_saved < latest_revert
end

-- Recovery of one record from file evidence. Returns true when settled.
local function recover_receipt(r)
    local final = copy_receipt(r)
    local staging = r.dest .. ".compas-fetch"
    local staged_ours = false
    if r.state == "pending" then
        -- Our staged copy still in place means the rename never happened.
        local staged_size, staged_md5, staged_status = file_fingerprint(staging)
        staged_ours = staged_size == r.size and staged_md5 == r.md5
        local size, md5, dest_status = file_fingerprint(r.dest)
        if staged_ours then
            final.state = "void"
        elseif staged_status ~= "unavailable" and size == r.size and md5 == r.md5 then
            -- Promoted. A staging file with other bytes is someone else's.
            final.state = "saved"
            final.saved_at = final.saved_at or os.time()
        elseif staged_status ~= "unavailable" and dest_status ~= "unavailable"
            and (staged_status ~= "missing" or dest_status ~= "missing") then
            final.state = "void"
        else
            return false
        end
    elseif r.state == "reverting" then
        local size, md5, dest_status = file_fingerprint(r.dest)
        if size == r.size and md5 == r.md5 then
            final.state = "saved"
            final.backup = nil
        else
            local backup_status
            size, md5, backup_status = file_fingerprint(r.backup)
            if size == r.size and md5 == r.md5 then
                final.state = "reverted"
                final.reverted_at = final.reverted_at or os.time()
            elseif dest_status ~= "unavailable" and backup_status ~= "unavailable"
                and (dest_status ~= "missing" or backup_status ~= "missing") then
                final.state = "lost"
            else
                return false
            end
        end
    end
    if not store_receipt(final) then return false end
    receipts[r.id] = final
    -- Only our own staged bytes are removed, and only once the void receipt
    -- is durable. A changed or foreign staging file is left as it is.
    if final.state == "void" and staged_ours then os.remove(staging) end
    return true
end

-- One record per call, from the interval, so file reads stay small per tick.
local function recovery_step()
    local now = os.time()
    for id, slot in pairs(recovery) do
        if now >= slot.next_at then
            local r = receipts[id]
            if not r then
                recovery[id] = nil
            elseif recover_receipt(r) then
                recovery[id] = nil
            else
                slot.attempts = slot.attempts + 1
                slot.next_at = now + RECOVERY_RETRY_SECONDS
                -- Unconfirmed after many attempts: the destination stays
                -- blocked for this session; the next load tries again.
                if slot.attempts >= RECOVERY_MAX_ATTEMPTS then slot.next_at = math.huge end
            end
            return
        end
    end
end

-- Frees one slot by deleting the oldest void receipt (a cover that was never
-- placed has nothing to revert).
local function make_receipt_room()
    if receipt_keys < MAX_RECEIPTS then return true end
    local oldest
    for _, r in pairs(receipts) do
        if r.state == "void" and not recovery[r.id] and (not oldest or r.id < oldest.id) then oldest = r end
    end
    if not oldest then return false end
    local ok, deleted = pcall(plugin.storage.delete, receipt_key(oldest.id))
    if not ok or deleted ~= true then return false end
    receipts[oldest.id] = nil
    receipt_keys = receipt_keys - 1
    return true
end

-- Admission check before any network work for a new cover.
local function tracking_refusal(dest, album, artist, allow_own_staging)
    if not tracking_available() then return tr("This player cannot track downloaded covers") end
    if not receipts_ready then return tr("Download history is unavailable; cover not saved") end
    if dest and dest_unresolved(dest) then return tr("Download history for this album is being checked") end
    if dest and not receipt_fits(dest, album, artist) then
        return tr("This album's path is too long to record; cover not saved")
    end
    if receipt_next_id > MAX_RECEIPT_ID then return tr("Download history is full; cover not saved") end
    -- A staging file this plugin did not just write is never overwritten.
    if dest and not allow_own_staging and file_exists(dest .. ".compas-fetch") then
        return tr("A .compas-fetch file is in this album's folder; cover not saved")
    end
    if receipt_keys >= MAX_RECEIPTS then
        for _, r in pairs(receipts) do
            if r.state == "void" and not recovery[r.id] then return nil end
        end
        return tr("Download history is full; cover not saved")
    end
    return nil
end

-- Writes the receipts for a promotion and moves staging to dest. Returns
-- true, or nil and a message. Never leaves a promoted cover without a
-- durable pending (or saved) receipt.
local function commit_tracked(job, staging, body)
    local effective_artist = job.album_artist ~= "" and job.album_artist or job.artist
    local refusal = tracking_refusal(job.dest, job.album, effective_artist, true)
    if refusal then return nil, refusal end
    if not make_receipt_room() then return nil, tr("Download history is full; cover not saved") end
    local id = receipt_next_id
    local key_ok, existing = pcall(plugin.storage.get, receipt_key(id))
    if not key_ok or existing ~= nil then return nil, tr("Download history is unavailable; cover not saved") end
    receipt_next_id = id + 1

    -- An older receipt for this path whose cover has since disappeared is
    -- closed so it can never be matched against the new file.
    for _, old in pairs(receipts) do
        if old.dest == job.dest and old.state == "saved" then
            local closed = copy_receipt(old)
            closed.state, closed.superseded_by = "gone", id
            if not store_receipt(closed) then return nil, tr("Could not record the download; cover not saved") end
            receipts[old.id] = closed
        end
    end

    local r = {
        id = id, state = "pending", dest = job.dest, size = #body, md5 = plugin.md5(body),
        album = job.album, artist = effective_artist,
        created = os.time(),
    }
    receipts[id] = r
    receipt_keys = receipt_keys + 1
    if not store_receipt(r) then
        -- The pending record may or may not have been kept. The staged copy
        -- stays until recovery records it as void, so it is never adopted.
        schedule_recovery(id)
        return nil, tr("Could not record the download; cover not saved")
    end
    if file_exists(job.dest) or not os.rename(staging, job.dest) then
        schedule_recovery(id)
        return nil, tr("Could not save album sidecar")
    end
    local saved = copy_receipt(r)
    saved.state, saved.saved_at = "saved", os.time()
    receipts[id] = saved
    -- A pending receipt is durable; recovery confirms "saved" from the file.
    if not store_receipt(saved) then
        receipts[id] = r
        schedule_recovery(id)
    end
    return true
end

local pump_queue, run_job

local function finish_job(job, ok, message, retry_after)
    if job then job.retry_after = retry_after end
    pending_dest[job.dest] = nil
    busy = false
    if active_job == job then active_job = nil end
    close_job_progress(job)
    if job.pending_item and job.pending_generation == pending_generation then
        local q = job.pending_item
        pending_inflight = nil
        if ok or message == "exists" then
            if ok then request_refresh() end
            pending_delete(q)
            pending_network_until, pending_network_failures = 0, 0
            pending_next_at = os.time() + MB_INTERVAL
        elseif message == "offline" or message == "transient" or message == "rate-limited" then
            pending_defer(q, job.retry_after, message == "rate-limited" or job.retry_after ~= nil, message ~= "rate-limited")
        elseif message == "no-art" or message == "no-match" or message == "incomplete"
            or message == "metadata-mismatch" or message == "track-name-collision"
            or message == "title-collision" or message == "unsafe-name" or message == "untrimmed-album"
            or message == "not-indexed" then
            if message == "no-art" or message == "no-match" or message == "incomplete" then remember_fail(job.key) end
            pending_delete(q)
        else
            pending_defer(q, 300)
        end
        if not job.is_auto then
            if ok then notify_job(job, string.format(tr("Saved %s"), job.dest:match("([^/]+)$")))
            elseif pending_inflight == nil then
                local still_queued = false
                for _, queued_item in ipairs(pending_items) do if queued_item.dest == job.dest then still_queued = true end end
                if still_queued then notify_job(job, tr("Cover request queued for retry"))
                elseif message == "no-art" then notify_job(job, tr("No cover art for this release"))
                elseif message == "no-match" then notify_job(job, tr("Could not match this album conservatively")) end
            end
        end
        pump_queue()
        return
    end
    if ok then
        request_refresh()
        notify_job(job, string.format(tr("Saved %s"), job.dest:match("([^/]+)$")))
    else
        if message == "no-art" or message == "no-match" or message == "incomplete" or message == "offline" then
            remember_fail(job.key)
        end
        if message == "no-match" then
            notify_job(job, tr("Could not match this album conservatively"))
        elseif message == "incomplete" then
            notify_job(job, tr("Too many MusicBrainz matches to choose safely"))
        elseif message == "no-art" then
            notify_job(job, tr("No cover art for this release"))
        elseif message == "exists" then
            notify_job(job, string.format(tr("%s already present"), job.dest:match("([^/]+)$")))
        elseif message == "offline" then
            notify_job(job, tr("Cover fetch failed (network)"))
        elseif message then
            notify_job(job, tr(message))
        end
    end
    pump_queue()
end

local function promote_cover(job, staging, gen, body)
    if pending_dest[job.dest] ~= gen then
        os.remove(staging)
        return
    end
    if file_exists(job.dest) then
        os.remove(staging)
        finish_job(job, false, "exists")
        return
    end
    local f = io.open(staging, "rb")
    if not f then
        finish_job(job, false, "offline")
        return
    end
    local magic = f:read(3)
    f:close()
    local size = file_size(staging)
    if not size or size > MAX_IMAGE_BYTES then
        os.remove(staging)
        finish_job(job, false, "no-art")
        return
    end
    if not magic or magic:byte(1) ~= 0xFF or magic:byte(2) ~= 0xD8 then
        os.remove(staging)
        finish_job(job, false, "no-art")
        return
    end
    if type(body) ~= "string" or #body ~= size then
        local sf = io.open(staging, "rb")
        body = sf and sf:read(size) or nil
        if sf then sf:close() end
        if type(body) ~= "string" or #body ~= size then
            os.remove(staging)
            finish_job(job, false, tr("Could not save album sidecar"))
            return
        end
    end
    local ok, message = commit_tracked(job, staging, body)
    if not ok then
        -- A staged copy whose receipt may exist is left for recovery.
        if not dest_unresolved(job.dest) then os.remove(staging) end
        finish_job(job, false, message)
        return
    end
    finish_job(job, true)
end

-- Writes the already size-capped response body to the staging file, then
-- hands it to the guarded promotion (magic, size, no-overwrite rename).
local function save_image(job, body, gen)
    if pending_dest[job.dest] ~= gen then return end
    if type(body) ~= "string" or body == "" or #body > MAX_IMAGE_BYTES then
        finish_job(job, false, "no-art")
        return
    end
    -- A staged file under an unresolved receipt is recovery evidence; never
    -- overwrite it, and never fetch without a working download history.
    local effective_artist = job.album_artist ~= "" and job.album_artist or job.artist
    local refusal = tracking_refusal(job.dest, job.album, effective_artist)
    if refusal then
        finish_job(job, false, refusal)
        return
    end
    set_stage(job, tr("Saving cover…"))
    local staging = job.dest .. ".compas-fetch"
    if file_exists(staging) then
        finish_job(job, false, tr("A .compas-fetch file is in this album's folder; cover not saved"))
        return
    end
    local f = io.open(staging, "wb")
    if not f then
        finish_job(job, false, tr("Could not save album sidecar"))
        return
    end
    local wrote = f:write(body)
    local closed = f:close()
    if not wrote or not closed then
        os.remove(staging)
        finish_job(job, false, tr("Could not save album sidecar"))
        return
    end
    promote_cover(job, staging, gen, body)
end

-- The thumbnail is fetched with an ordinary GET whose response the native
-- client caps at MAX_IMAGE_BYTES, so the transfer is bounded even without a
-- Content-Length and nothing needs cancelling. CAA answers with redirects to
-- archive.org; each hop is followed here, HTTPS only, at most MAX_REDIRECTS.
local function fetch_image(job, thumb_url, gen)
    set_stage(job, tr("Downloading cover…"))
    local seen = {}
    local redirects = 0

    local function hop(url)
        if pending_dest[job.dest] ~= gen then return end
        url = to_https(url)
        if not url then
            finish_job(job, false, "no-art")
            return
        end
        if seen[url] then
            finish_job(job, false, "no-art")
            return
        end
        seen[url] = true

        local handle, err = plugin.http_request({
            url = url,
            method = "GET",
            headers = { ["User-Agent"] = USER_AGENT, ["Accept"] = "image/jpeg" },
            verify_tls = true,
            max_response_bytes = MAX_IMAGE_BYTES,
            connect_timeout_ms = 10000,
            read_timeout_ms = 15000,
            -- A 500px JPEG from archive.org can need more than 30 s on a slow
            -- link; the native ceiling for this field is five minutes.
            total_timeout_ms = IMAGE_TOTAL_TIMEOUT_MS,
            redirect_limit = 0,
        }, function(status, body, req_err, headers)
            if pending_dest[job.dest] ~= gen then return end
            if req_err then
                finish_job(job, false, req_err == "response_too_large" and "no-art" or "offline", header(headers, "Retry-After"))
                return
            end
            if is_redirect(status) then
                if redirects >= MAX_REDIRECTS then
                    finish_job(job, false, "no-art")
                    return
                end
                redirects = redirects + 1
                local next_url = resolve_reference(url, header(headers, "Location"))
                if not next_url then
                    finish_job(job, false, "no-art")
                    return
                end
                hop(next_url)
                return
            end
            if status == 200 then
                save_image(job, body, gen)
                return
            end
            local transient = status == 429 or status == 408 or status == 425 or status == 401 or status == 403 or (status and status >= 500)
            local retry_after = header(headers, "Retry-After")
            local server_wait = status == 429 or (status and status >= 500 and retry_after ~= nil)
            local kind = server_wait and "rate-limited" or (transient and "transient" or "no-art")
            finish_job(job, false, kind, retry_after)
        end)
        if not handle then
            finish_job(job, false, "offline")
        end
    end

    hop(thumb_url)
end

local function fetch_caa(job, group_id, gen)
    set_stage(job, tr("Checking Cover Art Archive…"))
    -- The release-group listing shows the group's chosen front cover.
    local url = "https://coverartarchive.org/release-group/" .. group_id .. "/"
    local handle, err = http_json(url, 5, function(status, body, req_err, headers)
        if pending_dest[job.dest] ~= gen then return end
        if req_err or status ~= 200 or type(body) ~= "string" then
            local transient = req_err or status == 429 or status == 408 or status == 425 or status == 401 or status == 403 or (status and status >= 500)
            local retry_after = header(headers, "Retry-After")
            local server_wait = status == 429 or (status and status >= 500 and retry_after ~= nil)
            local kind = server_wait and "rate-limited" or (transient and "transient" or "no-art")
            finish_job(job, false, kind, retry_after)
            return
        end
        local listing = decode_json(body)
        local thumb = to_https(thumbnail_url(listing))
        if not thumb then
            finish_job(job, false, "no-art")
            return
        end
        fetch_image(job, thumb, gen)
    end)
    if not handle then
        finish_job(job, false, "offline")
    end
end

run_job = function(job)
    if file_exists(job.dest) then
        finish_job(job, false, "exists")
        return
    end
    generation = generation + 1
    local gen = generation
    active_job = job
    pending_dest[job.dest] = gen
    mb_next_ok = os.time() + MB_INTERVAL

    local artist_q = lucene_escape(job.album_artist ~= "" and job.album_artist or job.artist)
    local album_q = lucene_escape(job.album)
    local query = string.format('releasegroup:"%s" AND artist:"%s"', album_q, artist_q)
    local url = "https://musicbrainz.org/ws/2/release-group/?query=" .. url_encode(query)
        .. "&fmt=json&limit=" .. MB_RESULT_LIMIT .. "&offset=0"

    set_stage(job, tr("Looking up MusicBrainz…"))
    local handle, err = http_json(url, 3, function(status, body, req_err, headers)
        if pending_dest[job.dest] ~= gen then return end
        if not req_err and (status == 503 or status == 429) then
            -- Rate limited: transient, so not remembered as a failure.
            finish_job(job, false, "rate-limited", header(headers, "Retry-After"))
            return
        end
        if req_err or status ~= 200 or type(body) ~= "string" then
            local retry_after = header(headers, "Retry-After")
            local failure
            if req_err then failure = "offline"
            elseif status == 429 or status == 503 then failure = "rate-limited"
            elseif status and status >= 500 then failure = retry_after and "rate-limited" or "transient"
            elseif status == 401 or status == 403 or status == 408 or status == 425 then failure = "transient"
            elseif status and status >= 400 then failure = "no-match"
            else failure = "offline" end
            finish_job(job, false, failure, retry_after)
            return
        end
        local payload = decode_json(body)
        local group_id, reason = pick_release_group(payload, job.artist, job.album, job.album_artist)
        if not group_id then
            finish_job(job, false, reason == "incomplete" and "incomplete" or "no-match")
            return
        end
        fetch_caa(job, group_id, gen)
    end)
    if not handle then
        finish_job(job, false, "offline")
    end
end

pump_queue = function()
    if busy then return end
    if #queue == 0 then return end
    if os.time() < mb_next_ok then return end
    local job = table.remove(queue, 1)
    if pending_dest[job.dest] then
        if job.pending_item then
            pending_inflight = nil
            pending_defer(job.pending_item, 60)
        end
        pump_queue()
        return
    end
    if file_exists(job.dest) then
        close_job_progress(job)
        if job.pending_item then
            pending_inflight = nil
            pending_delete(job.pending_item)
        else
            notify_job(job, string.format(tr("%s already present"), job.dest:match("([^/]+)$")))
        end
        pump_queue()
        return
    end
    local effective_artist = job.album_artist ~= "" and job.album_artist or job.artist
    local refusal = tracking_refusal(job.dest, job.album, effective_artist)
    local suppressed = job.is_auto and not job.manual_requested
        and not (job.pending_item and job.pending_item.explicit) and auto_suppressed(job.dest)
    if refusal or suppressed then
        close_job_progress(job)
        if job.pending_item then
            pending_inflight = nil
            if refusal then pending_defer(job.pending_item, 300) else pending_delete(job.pending_item) end
        elseif refusal then notify_job(job, refusal) end
        pump_queue()
        return
    end
    busy = true
    active_job = job
    run_job(job)
end

enqueue = function(job)
    if not job or not job.dest then return end
    if file_exists(job.dest) then
        if job.pending_item then
            pending_inflight = nil
            pending_delete(job.pending_item)
        else
            notify_job(job, string.format(tr("%s already present"), job.dest:match("([^/]+)$")))
        end
        return
    end
    if failed_recently(job.key) and job.is_auto and not job.pending_item then return end
    if pending_dest[job.dest] then
        if not job.is_auto and active_job and active_job.dest == job.dest then
            local was_manual = active_job.manual_requested
            active_job.manual_requested = true
            if was_manual then
                open_job_progress(active_job, active_status(active_job), nil)
            else
                open_job_progress(active_job, active_job.stage or tr("Cover fetch in progress"), nil)
            end
        end
        return
    end
    for _, queued in ipairs(queue) do
        if queued.dest == job.dest then
            if not job.is_auto then
                if queued.manual_requested then
                    local active_visible = false
                    if active_job and active_job.manual_requested and active_job.progress_handle then
                        active_visible = plugin.update_progress(
                            active_job.progress_handle, active_job.stage or tr("Cover fetch in progress"), nil)
                        if not active_visible then active_job.progress_handle = nil end
                    end
                    if not active_visible then
                        open_job_progress(queued, queued.stage or tr("Cover fetch queued"), nil)
                    end
                    plugin.show_toast(tr("Cover fetch already queued"))
                else
                    queued.manual_requested = true
                    set_stage(queued, tr("Cover fetch queued"))
                end
            end
            return
        end
    end
    queue[#queue + 1] = job
    if not job.is_auto and (busy or os.time() < mb_next_ok) then
        job.stage = tr("Cover fetch queued")
        job.next_status_refresh = os.time() + MANUAL_REFRESH_SECONDS
        if not (active_job and active_job.manual_requested) then
            update_job_progress(job, job.stage, nil)
        else
            plugin.show_toast(job.stage)
        end
    end
    pump_queue()
end

pending_drain = function()
    if not pending_loaded or pending_inflight or busy or #pending_items == 0 or os.time() < pending_next_at
        or os.time() < pending_server_until or os.time() < pending_network_until then return end
    if not receipts_ready or not tracking_available() then return end
    if os.time() - pending_last_attempt < 1 then return end
    pending_last_attempt = os.time()
    local net = pending_network()
    if net and (net.wifi_enabled == false or net.connected == false) then return end
    local q
    for _, item in ipairs(pending_items) do
        if pending_blocked_delete[item.dest] or (item.retry_at or 0) <= os.time() then q = item; break end
    end
    if not q then return end
    if pending_blocked_delete[q.dest] then pending_delete(q); return end
    if file_exists(q.dest) or (not q.explicit and auto_suppressed(q.dest)) then pending_delete(q); return end
    local name = q.dest:match("([^/]+)%.jpg$")
    local dir = album_dir(q.dest)
    for _, ext in ipairs(ALBUM_EXTS) do
        if file_exists(dir .. "/" .. name .. "." .. ext) then pending_delete(q); return end
    end
    local indexed, inspect_err = inspect_library(q.path, q.artist, q.album)
    if not indexed then
        if inspect_err == "metadata-mismatch" or inspect_err == "track-name-collision"
            or inspect_err == "title-collision" or inspect_err == "unsafe-name"
            or inspect_err == "untrimmed-album" then pending_delete(q)
        else pending_defer(q, 300) end
        return
    end
    local row_dir = album_dir(q.path)
    local dest = cover_path(row_dir, indexed.raw_album)
    if dest ~= q.dest or indexed.artist ~= q.artist or indexed.album ~= q.album
        or indexed.album_artist ~= q.album_artist then pending_delete(q); return end
    local job = { path = q.path, artist = q.artist, album = q.album, album_artist = q.album_artist,
        dir = row_dir, dest = q.dest, key = album_key(q.artist, q.album, row_dir),
        is_auto = not q.manual_requested, manual_requested = q.manual_requested == true,
        pending_item = q, pending_generation = pending_generation }
    pending_inflight = q
    enqueue(job)
end
local function fetch_current(is_auto)
    if not plugin.has_capability("network.http.async")
        or not plugin.has_capability("data.json") then
        if not is_auto then plugin.show_toast(tr("This player cannot fetch cover art")) end
        return
    end
    if is_auto then
        local path = plugin.get_current_track_path()
        local _, artist, album = plugin.get_now_playing()
        local quick_key = album_key(artist, album, album_dir(path))
        if last_auto_key == quick_key then return end
        last_auto_key = quick_key
    end
    local job, err = current_album()
    if not job then
        if err == "untrimmed-album" then
            notify(tr("Album tag has leading or trailing spaces; cover not saved"), is_auto)
        else
            notify(tr("Could not identify this indexed album safely"), is_auto)
        end
        return
    end
    job.is_auto = is_auto and true or false
    job.manual_requested = not job.is_auto
    -- Every saved cover needs a receipt, so refuse before any network work.
    local effective_artist = job.album_artist ~= "" and job.album_artist or job.artist
    local refusal = tracking_refusal(job.dest, job.album, effective_artist)
    if refusal then
        notify(refusal, is_auto)
        return
    end
    -- A reverted cover is not fetched again automatically.
    if job.is_auto and (auto_suppressed(job.dest) or failed_recently(job.key)) then return end
    if not pending_add(job, job.is_auto) then return end
    pending_drain()
    if not is_auto then
        for _, item in ipairs(pending_items) do
            if item.dest == job.dest and pending_inflight ~= item then
                local net = pending_network()
                local offline = net and (net.wifi_enabled == false or net.connected == false)
                if offline or os.time() < pending_server_until or os.time() < pending_network_until
                    or item.retry_at > os.time() then item.manual_requested = false end
            end
        end
    end
end

-- ---- Reverting a downloaded cover ----

-- Drops queued fetches for dest so a revert cannot be undone by them.
local function drop_queued(dest)
    for i = #queue, 1, -1 do
        local queued = queue[i]
        if queued.dest == dest then
            table.remove(queue, i)
            close_job_progress(queued)
        end
    end
end

-- Renames one recorded cover to a non-image backup after re-checking that the
-- file is still exactly the one recorded. Returns true or nil, message.
local function revert_receipt(id)
    if not pending_loaded and not load_pending() then
        return nil, tr("Could not check saved cover requests; nothing was changed")
    end
    local r = receipts[id]
    if not r or r.state ~= "saved" or recovery[id] then return nil, tr("This cover cannot be reverted") end
    if active_job and active_job.dest == r.dest then
        return nil, tr("A fetch for this album is running; try again when it finishes")
    end
    local size, md5 = file_fingerprint(r.dest)
    if not size then return nil, tr("The cover is missing; nothing was changed") end
    if size ~= r.size or md5 ~= r.md5 then
        return nil, tr("The cover was changed or replaced; nothing was changed")
    end
    local backup = backup_path(r.dest)
    if not backup or not path_is_under_root(backup, sd_root_dir()) then
        return nil, tr("No free backup name; nothing was changed")
    end
    -- A later explicit fetch may replace a revert, but a request queued
    -- before this revert must not undo the user's new choice.
    for _, queued_item in ipairs(pending_items) do
        if queued_item.dest == r.dest and not pending_delete(queued_item) then
            return nil, tr("Could not clear queued request; nothing was changed")
        end
    end
    drop_queued(r.dest)
    if pending_inflight and pending_inflight.dest == r.dest then pending_inflight = nil end

    local intent = copy_receipt(r)
    intent.state, intent.backup = "reverting", backup
    if not store_receipt(intent) then
        -- It may have been kept; recovery settles it from the files.
        receipts[id] = intent
        schedule_recovery(id)
        return nil, tr("Could not record the revert; nothing was changed")
    end
    receipts[id] = intent
    local renamed = not file_exists(backup) and os.rename(r.dest, backup)
    if not renamed or file_exists(r.dest) or not file_exists(backup) then
        schedule_recovery(id)
        return nil, tr("Could not rename the cover; nothing was changed")
    end
    local done = copy_receipt(intent)
    done.state, done.reverted_at = "reverted", os.time()
    if store_receipt(done) then
        receipts[id] = done
    else
        schedule_recovery(id)
    end
    request_refresh()
    return true, backup
end

local HISTORY_PAGE = 20
local STATE_LABELS = {
    pending = "checking", saved = "saved", void = "not saved", reverting = "checking",
    reverted = "reverted", gone = "missing", lost = "missing",
}

local function short(text, limit)
    text = tostring(text or "")
    if #text <= limit then return text end
    return text:sub(1, limit - 3) .. "..."
end

local function receipt_summary(r)
    return string.format("%s - %s (%s, %s)", short(r.album, 60), short(r.artist, 40),
        os.date("%Y-%m-%d", r.created), tr(STATE_LABELS[r.state] or r.state))
end

local function append_wrapped(items, label, value)
    local prefix = label == "" and "" or (label .. ": ")
    value = tostring(value or "")
    if value == "" then
        items[#items + 1] = { label = prefix, wrap = true }
        return
    end
    local first = true
    while #value > 0 do
        local row_prefix = first and prefix or ""
        local limit = 480 - #row_prefix
        local length = math.min(limit, #value)
        while length > 0 and value:byte(length + 1) and value:byte(length + 1) >= 128
            and value:byte(length + 1) <= 191 do
            length = length - 1
        end
        if length == 0 then length = math.min(limit, #value) end
        local chunk = value:sub(1, length)
        value = value:sub(length + 1)
        items[#items + 1] = { label = row_prefix .. chunk, wrap = true }
        first = false
    end
end

local open_receipt

-- Paginated history, newest first. Only records this plugin wrote are listed.
local function open_history(page, filter, title, replace_handle)
    page = page or 1
    local list = sorted_receipts(filter)
    if not receipts_ready then
        plugin.show_toast(tr("Download history is unavailable"))
        return
    end
    if #list == 0 then
        plugin.show_toast(tr("No downloaded covers recorded"))
        return
    end
    local pages = math.ceil(#list / HISTORY_PAGE)
    if page > pages then page = pages end
    local first = (page - 1) * HISTORY_PAGE + 1
    local items, ids = {}, {}
    for i = first, math.min(first + HISTORY_PAGE - 1, #list) do
        items[#items + 1] = receipt_summary(list[i])
        ids[#items] = list[i].id
    end
    local newer_row, older_row
    if page > 1 then items[#items + 1] = tr("Newer"); newer_row = #items end
    if page < pages then items[#items + 1] = tr("Older"); older_row = #items end
    local list_handle
    local options = replace_handle and { replace = replace_handle } or nil
    if options and plugin.has_capability("ui.list_scroll_reset") then
        options.reset_scroll = true
    end
    list_handle = plugin.show_list((title or tr("Downloaded covers")) .. " " .. page .. "/" .. pages, items, function(index)
        if index == newer_row then
            open_history(page - 1, filter, title, list_handle)
        elseif index == older_row then
            open_history(page + 1, filter, title, list_handle)
        elseif ids[index] then
            open_receipt(ids[index])
        end
    end, options)
end

open_receipt = function(id)
    local r = receipts[id]
    if not r then return end
    local items = {}
    append_wrapped(items, "", r.dest)
    items[#items + 1] = { label = string.format(tr("Album: %s"), short(r.album, 200)), wrap = true }
    items[#items + 1] = { label = string.format(tr("Artist: %s"), short(r.artist, 200)), wrap = true }
    items[#items + 1] = string.format(tr("Recorded: %s"), os.date("%Y-%m-%d %H:%M", r.created))
    items[#items + 1] = string.format(tr("Size: %d bytes"), r.size)
    items[#items + 1] = string.format(tr("Status: %s"), tr(STATE_LABELS[r.state] or r.state))
    if r.backup then append_wrapped(items, tr("Backup"), r.backup) end
    local confirm_row, cancel_row
    if r.state == "saved" and not recovery[id] then
        items[#items + 1] = string.format(tr("Revert: rename to %s"), BACKUP_SUFFIX)
        confirm_row = #items
        items[#items + 1] = tr("Cancel")
        cancel_row = #items
    end
    local used = false
    plugin.show_list(tr("Downloaded cover"), items, function(index)
        if used then return end
        if index == confirm_row then
            used = true
            local ok, detail = revert_receipt(id)
            if ok then
                plugin.show_toast(tr("Cover reverted. Use Reload cover if it still shows"))
            else
                plugin.show_toast(detail)
            end
        elseif index == cancel_row then
            used = true
            plugin.show_toast(tr("No files changed"))
        end
    end)
end

-- Saved covers recorded for the playing track's folder.
local function open_current_album_receipts()
    local job = current_album()
    if not job then
        plugin.show_toast(tr("Play a local track first"))
        return
    end
    local effective_artist = job.album_artist ~= "" and job.album_artist or job.artist
    local matches = sorted_receipts(function(r)
        return r.state == "saved" and r.dest == job.dest and r.album == job.album and r.artist == effective_artist
    end)
    if #matches == 0 then
        plugin.show_toast(tr("No downloaded cover recorded for this album"))
    elseif #matches == 1 then
        open_receipt(matches[1].id)
    else
        open_history(1, function(r)
            return r.state == "saved" and r.dest == job.dest and r.album == job.album and r.artist == effective_artist
        end, tr("This album"))
    end
end

-- ---- Shared generic artwork repair ----
-- The native lookup tries <album>.*, then cover.* and folder.* in the track's
-- folder, then the same names one folder up. Earlier releases of this plugin
-- wrote cover.jpg, which then showed for every album sharing that folder.
-- This repair only lists generic files that the current album would reach
-- before any album-specific file and that another indexed album also reaches.
-- Nothing changes until the user confirms; files are renamed, not deleted.

local function parent_dir(dir)
    local parent = type(dir) == "string" and dir:match("^(.+)/[^/]+$") or nil
    if not parent or parent == "" then return nil end
    return parent
end

-- A folder whose generic art may be repaired: strictly below the SD root.
local function repair_folder_allowed(dir, root)
    return type(dir) == "string" and dir ~= root and path_is_under_root(dir, root)
end

local function album_sidecar_exists(dir, raw_album)
    local name = native_album_name(raw_album)
    if not name then return false end
    for _, ext in ipairs(ALBUM_EXTS) do
        if file_exists(dir .. "/" .. name .. "." .. ext) then return true end
    end
    return false
end

local function generic_files(dir)
    local found = {}
    for _, name in ipairs(GENERIC_NAMES) do
        local path = dir .. "/" .. name
        if regular_file(path) then found[#found + 1] = path end
    end
    return found
end

-- True when an album whose tracks sit in song_dir reaches folder's generic art.
local function reaches_generic(song_dir, raw_album, folder)
    if song_dir == folder then return not album_sidecar_exists(folder, raw_album) end
    if parent_dir(song_dir) ~= folder then return false end
    if album_sidecar_exists(song_dir, raw_album) or #generic_files(song_dir) > 0 then return false end
    return not album_sidecar_exists(folder, raw_album)
end

local function identity_of(song)
    local effective = song.album_artist
    if type(effective) ~= "string" or effective == "" then effective = song.artist end
    return string.lower(song.album) .. "\t" .. string.lower(tostring(effective or ""))
end

local function add_identity(set, key, raw_album, song_dir)
    local entry = set.identities[key]
    if not entry then
        if set.count >= REPAIR_MAX_IDENTITIES then return end
        entry = { raw_album = raw_album, dirs = {} }
        set.identities[key] = entry
        set.count = set.count + 1
    end
    if #entry.dirs >= REPAIR_DIRS_PER_IDENTITY then return end
    for _, d in ipairs(entry.dirs) do
        if d == song_dir then return end
    end
    entry.dirs[#entry.dirs + 1] = song_dir
end

local function shared_with_other_album(set, folder, current_key)
    for key, entry in pairs(set.identities) do
        if key ~= current_key then
            for _, d in ipairs(entry.dirs) do
                if reaches_generic(d, entry.raw_album, folder) then return true end
            end
        end
    end
    return false
end


-- Builds an immutable list of { path, backup } for the current track.
local function build_repair_plan()
    local root = sd_root_dir()
    local path = plugin.get_current_track_path()
    if not path_is_under_root(path, root) then return nil, "not-local" end
    local dir = album_dir(path)
    if not repair_folder_allowed(dir, root) then return nil, "root-folder" end
    local _, now_artist, now_album = plugin.get_now_playing()
    local parent = parent_dir(dir)
    if not repair_folder_allowed(parent, root) then parent = nil end

    local current
    local sets = { [dir] = { identities = {}, count = 0 } }
    if parent then sets[parent] = { identities = {}, count = 0 } end
    local ok, err = protected_scan(function(song)
        if type(song.album) ~= "string" or song.album == "" then return end
        if not path_is_under_root(song.path, root) then return end
        local song_dir = album_dir(song.path)
        if not song_dir then return end
        if song.path == path then
            if current or not names_equal(song.artist, now_artist) or not names_equal(song.album, now_album) then
                return false, "metadata-mismatch"
            end
            current = song
        end
        local key = identity_of(song)
        local up = parent_dir(song_dir)
        for folder, set in pairs(sets) do
            if song_dir == folder or up == folder then add_identity(set, key, song.album, song_dir) end
        end
    end)
    if not ok then return nil, err end
    if not current then return nil, "not-indexed" end
    if plugin.get_current_track_path() ~= path then return nil, "track-changed" end

    local current_key = identity_of(current)
    local plan = { track_path = path, files = {}, skipped = 0 }
    local folders = { dir }
    if parent then folders[2] = parent end
    for _, folder in ipairs(folders) do
        -- The album's own sidecar ends the native search before generic art.
        if album_sidecar_exists(folder, current.album) then break end
        local generics = generic_files(folder)
        if #generics > 0 then
            -- Generic art only this album reaches is its own; leave it.
            if not shared_with_other_album(sets[folder], folder, current_key) then break end
            -- An album titled "Cover" or "Folder" owns that file as its
            -- album-specific sidecar; never offer it.
            local owned = {}
            for _, entry in pairs(sets[folder].identities) do
                local name = native_album_name(entry.raw_album)
                if name then owned[name:lower()] = true end
            end
            for _, file in ipairs(generics) do
                local stem = file:match("([^/]+)%.[^%./]+$")
                local backup = backup_path(file)
                if owned[(stem or ""):lower()] then
                    plan.skipped = plan.skipped + 1
                elseif backup and #file <= MAX_LIST_LABEL then
                    plan.files[#plan.files + 1] = { path = file, backup = backup }
                else
                    plan.skipped = plan.skipped + 1
                end
            end
        end
    end
    return plan
end

local function apply_repair_plan(plan)
    if plan.applied then return 0, 0 end
    plan.applied = true
    local root = sd_root_dir()
    local renamed, failed = 0, 0
    for _, item in ipairs(plan.files) do
        local ok = path_is_under_root(item.path, root) and path_is_under_root(item.backup, root)
            and regular_file(item.path) and not file_exists(item.backup)
            and os.rename(item.path, item.backup)
        if ok and file_exists(item.backup) and not file_exists(item.path) then
            renamed = renamed + 1
        else
            failed = failed + 1
        end
    end
    if renamed > 0 then request_refresh() end
    return renamed, failed
end

local REPAIR_REASONS = {
    ["not-local"] = "Play a local track first",
    ["root-folder"] = "Tracks at the top of the card are not repaired",
    ["not-indexed"] = "Update the music database, then try again",
    ["metadata-mismatch"] = "Could not identify this indexed album safely",
    ["track-changed"] = "The track changed; try again",
    ["scan-limit"] = "Library is too large to check safely",
}

local function open_generic_repair()
    local plan, err = build_repair_plan()
    if not plan then
        plugin.show_toast(tr(REPAIR_REASONS[err] or "Could not check folder artwork"))
        return
    end
    if #plan.files == 0 then
        if plan.skipped > 0 then
            plugin.show_toast(tr("Shared artwork found, but no safe backup name is free"))
        else
            plugin.show_toast(tr("No shared generic artwork affects this album"))
        end
        return
    end
    local items = {}
    for _, item in ipairs(plan.files) do
        items[#items + 1] = { label = item.path, wrap = true }
    end
    local confirm_index = #items + 1
    items[confirm_index] = #plan.files == 1
        and string.format(tr("Rename %d file to %s"), #plan.files, BACKUP_SUFFIX)
        or string.format(tr("Rename %d files to %s"), #plan.files, BACKUP_SUFFIX)
    items[confirm_index + 1] = tr("Cancel")
    plugin.show_list(tr("Shared folder artwork"), items, function(index)
        if index == confirm_index then
            if plan.applied then return end
            local renamed, failed = apply_repair_plan(plan)
            if failed > 0 then
                plugin.show_toast(string.format(tr("Renamed %d, could not rename %d"), renamed, failed))
            else
                plugin.show_toast(string.format(tr("Renamed %d. Use Reload cover if old artwork still shows"), renamed))
            end
        elseif index == confirm_index + 1 and not plan.applied then
            plan.applied = true
            plugin.show_toast(tr("No files changed"))
        end
    end)
end

plugin.on("track_started", function(_, _, _, _, provider)
    if not state.auto then return end
    if provider and provider ~= "" then return end
    fetch_current(true)
end)

plugin.set_interval(1, function()
    local visible_job = active_job and active_job.manual_requested and active_job or nil
    if not visible_job then
        for _, queued in ipairs(queue) do
            if queued.manual_requested then
                visible_job = queued
                break
            end
        end
    end
    if visible_job and visible_job.stage
        and os.time() >= (visible_job.next_status_refresh or 0) then
        visible_job.next_status_refresh = os.time() + MANUAL_REFRESH_SECONDS
        update_job_progress(visible_job, visible_job.stage, nil)
    end
    try_refresh()
    if not pending_loaded and os.time() >= pending_load_retry_at then
        pending_load_retry_at = os.time() + 60
        load_pending()
    end
    if not receipts_ready and tracking_available() and os.time() >= receipt_load_retry_at then
        receipt_load_retry_at = os.time() + RECOVERY_RETRY_SECONDS
        load_receipts()
    end
    recovery_step()
    if not busy then
        pump_queue()
        pending_drain()
    end
end)
if plugin.has_capability("network.status") then
    plugin.on("network_changed", function(info)
        if type(info) == "table" and info.connected then pending_retry_all(true) end
    end)
end

local function open_about()
    plugin.show_list(tr("About Cover Art Fetcher"), {
        tr("Looks up the current album on MusicBrainz and downloads a 500px (or 250px) front JPEG from the Cover Art Archive as <album title>.jpg beside the track."),
        tr("Never overwrites an existing album sidecar. Matching is conservative: indexed track tags must match playback, and sanitized album names must not collide across nearby folders or artists."),
        tr("The Lua API cannot see embedded pictures inside audio files, so those albums may still get a folder sidecar."),
        tr("A generic cover or folder image beside the track, or one folder up, can show for every album there. Repair shared folder artwork lists those files and renames them to .compas-backup only after you confirm."),
        tr("Every cover this plugin saves is recorded with its exact path, size and fingerprint. Downloaded covers lets you revert one: after you confirm, it is renamed to .compas-backup if it is still exactly the file that was saved. Files you added or changed are never touched."),
        tr("Missing-cover requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending cover requests lets you retry or clear them."),
        tr("Automatic mode is off until you enable it. MusicBrainz is limited to one lookup per second."),
    }, function() end)
end

local function open_settings()
    plugin.show_settings_list(tr("Cover Art Fetcher"), {
        {
            type = "row",
            label = tr("Fetch cover for current album"),
            on_select = function() fetch_current(false) end,
        },
        {
            type = "row",
            label = string.format(tr("Pending cover requests (%s)"), pending_loaded and tostring(#pending_items) or tr("unavailable")),
            on_select = function()
                plugin.show_list(tr("Pending cover requests"), {
                    string.format(tr("%d saved request(s)"), #pending_items),
                    pending_inflight and tr("A request is downloading") or tr("Waiting for connection or retry time"),
                    tr("Retry pending downloads"),
                    tr("Clear pending requests…"),
                }, function(index)
                    if index == 3 then
                        pending_retry_all()
                        pending_next_at = math.max(pending_next_at, mb_next_ok)
                    elseif index == 4 then
                        plugin.show_list(tr("Clear pending requests?"), { tr("Keep requests"), tr("Clear requests") }, function(which)
                            if which == 2 then
                                if pending_clear() then plugin.show_toast(tr("Pending requests cleared"))
                                else plugin.show_toast(tr("Could not save queue change")) end
                            end
                        end)
                    end
                end)
            end,
        },
        {
            type = "toggle",
            label = tr("Automatic fetch"),
            value = state.auto,
            on_change = function(on)
                state.auto = on
                save_state()
            end,
        },
        {
            type = "row",
            label = tr("Downloaded covers"),
            on_select = function() open_history(1) end,
        },
        {
            type = "row",
            label = tr("Revert cover for current album"),
            on_select = open_current_album_receipts,
        },
        {
            type = "row",
            label = tr("Repair shared folder artwork"),
            on_select = open_generic_repair,
        },
        {
            type = "row",
            label = tr("How it works"),
            on_select = open_about,
        },
    })
end

load_state()
receipt_load_retry_at = os.time() + RECOVERY_RETRY_SECONDS
load_receipts()
if not load_pending() then plugin.show_toast(tr("Saved cover requests could not be read; check Cover Art Fetcher settings")) end
plugin.register_list_item("music_library", tr("Cover Art Fetcher"), open_settings)
-- Older firmware keeps Settings > Library until it supports player menu rows.
if plugin.has_capability("ui.player_menu") then
    plugin.register_list_item("player", tr("Cover Art Fetcher"), function()
        fetch_current(false)
    end)
end

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        pick_release_group = pick_release_group,
        thumbnail_url = thumbnail_url,
        to_https = to_https,
        resolve_reference = resolve_reference,
        fetch_image = fetch_image,
        album_dir = album_dir,
        cover_path = cover_path,
        current_album = current_album,
        is_absolute_local_path = is_absolute_local_path,
        fetch_current = fetch_current,
        pending_items = function() return pending_items end,
        pending_state = function() return { loaded = pending_loaded, count = #pending_items,
            inflight = pending_inflight ~= nil,
            server_until = pending_server_until } end,
        pending_add = pending_add,
        pending_load = load_pending,
        pending_drain = pending_drain,
        pending_retry_all = pending_retry_all,
        pending_clear = pending_clear,
        pending_defer = pending_defer,
        retry_after_seconds = retry_after_seconds,
        pending_delete = pending_delete,
        pending_path = PENDING_PATH,
        enqueue = enqueue,
        pending_dest = pending_dest,
        queue = queue,
        fail_memory = fail_memory,
        remember_fail = remember_fail,
        failed_recently = failed_recently,
        state = state,
        promote_cover = promote_cover,
        open_generic_repair = open_generic_repair,
        build_repair_plan = build_repair_plan,
        refresh = refresh,
        receipts = function() return receipts end,
        recovery = recovery,
        revert_receipt = revert_receipt,
        open_history = open_history,
        open_receipt = open_receipt,
        open_current_album_receipts = open_current_album_receipts,
        decode_receipt = decode_receipt,
        encode_receipt = encode_receipt,
        MAX_RECEIPTS = MAX_RECEIPTS,
        MAX_IMAGE_BYTES = MAX_IMAGE_BYTES,
    }
end
