-- The one place the plugin version lives; the index builder reads define().
local PLUGIN_VERSION = "1.2.1"
plugin.define({ id = "compas.listenbrainz_scrobbler", name = "ListenBrainz Scrobbler", version = PLUGIN_VERSION, api_min = 19 })

local T = {
  de = {
    ["Could not open text entry. Try again."] = "Texteingabe konnte nicht geöffnet werden. Erneut versuchen.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz hat das Benutzertoken abgelehnt. Gespeicherte Wiedergaben bleiben erhalten.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "ListenBrainz-Warteschlange voll. Die ältesten Wiedergaben blieben erhalten.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "ListenBrainz-Wiedergabe konnte nicht gespeichert werden. Gespeicherte Wiedergaben blieben erhalten.",
    ["Could not save the ListenBrainz token. Try again."] = "ListenBrainz-Token konnte nicht gespeichert werden. Erneut versuchen.",
    ["Could not log out of ListenBrainz. Try again."] = "Abmeldung von ListenBrainz fehlgeschlagen. Erneut versuchen.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Dieser Player kann keine ListenBrainz-Wiedergaben senden. Gespeicherte Wiedergaben bleiben erhalten.",
    ["This player cannot store a ListenBrainz token."] = "Dieser Player kann kein ListenBrainz-Token speichern.",
    ["That token cannot be used."] = "Dieses Token kann nicht verwendet werden.",
    ["This player cannot check a ListenBrainz token."] = "Dieser Player kann kein ListenBrainz-Token prüfen.",
    ["Checking ListenBrainz token..."] = "ListenBrainz-Token wird geprüft...",
    ["Could not reach ListenBrainz."] = "ListenBrainz nicht erreichbar.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz hat dieses Token abgelehnt.",
    ["ListenBrainz token saved."] = "ListenBrainz-Token gespeichert.",
    ["Logged in to ListenBrainz as %s"] = "Bei ListenBrainz angemeldet als %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Konto gespeichert. Tippe auf Scrobbeln, um es zu aktivieren.",
    ["Set ListenBrainz user token"] = "ListenBrainz-Benutzertoken festlegen",
    ["Read token from SD card"] = "Token von SD-Karte lesen",
    ["Delete token file?"] = "Tokendatei löschen?",
    ["Keep the file"] = "Datei behalten",
    ["Delete the file"] = "Datei löschen",
    ["Token file deleted."] = "Tokendatei gelöscht.",
    ["Could not delete the token file."] = "Tokendatei konnte nicht gelöscht werden.",
    ["Token file kept."] = "Tokendatei behalten.",
    ["No ListenBrainz token found in that file."] = "In dieser Datei wurde kein ListenBrainz-Token gefunden.",
    ["Could not read that file."] = "Datei konnte nicht gelesen werden.",
    ["Could not open the file picker. Try again."] = "Dateiauswahl konnte nicht geöffnet werden. Erneut versuchen.",
    ["ListenBrainz user token"] = "ListenBrainz-Benutzertoken",
    ["Log out"] = "Abmelden",
    ["Log out (%s)"] = "Abmelden (%s)",
    ["ListenBrainz Scrobbler"] = "ListenBrainz Scrobbler",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi aus \u{2014} wird bei Verbindung gesendet",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi nicht verbunden \u{2014} wird bei Verbindung gesendet",
    ["Waiting list could not be updated."] = "Warteliste konnte nicht aktualisiert werden.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Gesendet, aber Bereinigung der Warteliste konnte nicht gespeichert werden.",
    ["Could not send scrobble request."] = "Scrobble-Anfrage konnte nicht gesendet werden.",
    ["Waiting to send"] = "Wartet auf Senden",
    ["Not saved yet"] = "Noch nicht gespeichert",
    ["Discarded by you"] = "Von dir verworfen",
    ["Sending…"] = "Senden…",
    ["waiting for Wi-Fi"] = "wartet auf Wi-Fi",
    ["next try %dm"] = "nächster Versuch in %dm",
    ["sent %s"] = "gesendet %s",
    ["Sync now"] = "Jetzt synchronisieren",
    ["Account & settings"] = "Konto & Einstellungen",
    ["Press Back."] = "Zurück drücken.",
    ["Account changed. Nothing changed."] = "Konto geändert. Keine Änderungen vorgenommen.",
    ["Account changed. Nothing discarded."] = "Konto geändert. Nichts verworfen.",
    ["Saved: %s"] = "Gespeichert: %s",
    ["Saved time unavailable"] = "Speicherzeit nicht verfügbar",
    ["Scrobbling"] = "Scrobbeln",
    ["Scrobbling: %s"] = "Scrobbeln: %s",
    ["Scrobbling turned on."] = "Scrobbeln aktiviert.",
    ["Scrobbling turned off."] = "Scrobbeln deaktiviert.",
    ["Could not save scrobbling preference. Try again."] = "Scrobbel-Einstellung konnte nicht gespeichert werden. Erneut versuchen.",
    ["This track: No music playing"] = "Dieser Titel: Keine Musikwiedergabe",
    ["This track: Scrobbling off"] = "Dieser Titel: Scrobbeln aus",
    ["This track: Reading length"] = "Dieser Titel: Dauer wird gelesen",
    ["This track: Too short (<30s)"] = "Dieser Titel: Zu kurz (<30s)",
    ["This track: Playback paused"] = "Dieser Titel: Wiedergabe pausiert",
    ["This track: Counts after %s"] = "Dieser Titel: Zählt nach %s",
    ["This track: This listen not counted"] = "Dieser Titel: Dieses Anhören wird nicht gezählt",
    ["This track: %s"] = "Dieser Titel: %s",
    ["No track playing."] = "Kein Titel wird abgespielt.",
    ["Status: %s"] = "Status: %s",
    ["How Scrobbling Works"] = "So funktioniert Scrobbeln",
    ["Tracks >= 30s only"] = "Nur Titel ab 30s",
    ["Listened 50% or 4 min"] = "50% oder 4 Min. gehört",
    ["Pauses do not count"] = "Pausen zählen nicht",
    ["ListenBrainz not reachable."] = "ListenBrainz nicht erreichbar.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz vorübergehend ausgelastet.",
    ["Status: user token not accepted"] = "Status: Benutzertoken nicht akzeptiert",
    ["Logged in as %s"] = "Angemeldet als %s",
    ["Sent to ListenBrainz"] = "An ListenBrainz gesendet",
    ["ListenBrainz rejected this listen"] = "ListenBrainz hat diese Wiedergabe abgelehnt",
    ["%d listen waiting"] = "%d Wiedergabe wartet",
    ["%d listens waiting"] = "%d Wiedergaben warten",
    ["Waiting listens could not be read"] = "Wartende Wiedergaben konnten nicht gelesen werden",
    ["Waiting listens could not be read. Nothing discarded."] = "Wartende Wiedergaben konnten nicht gelesen werden. Nichts verworfen.",
    ["Waiting listens"] = "Wartende Wiedergaben",
    ["No listens are waiting to send"] = "Keine Wiedergaben warten auf das Senden",
    ["Qualified listens send automatically."] = "Qualifizierte Wiedergaben werden automatisch gesendet.",
    ["%d listens kept for %s"] = "%d Wiedergaben behalten für %s",
    ["Oldest listens are sent first."] = "Älteste Wiedergaben werden zuerst gesendet.",
    ["Send waiting listens now"] = "Wartende Wiedergaben jetzt senden",
    ["Discard waiting listens…"] = "Wartende Wiedergaben verwerfen…",
    ["Discard waiting listens (%d)"] = "Wartende Wiedergaben verwerfen (%d)",
    ["Discard %d listens?"] = "%d Wiedergaben verwerfen?",
    ["Discard %d listens"] = "%d Wiedergaben verwerfen",
    ["Keep waiting listens"] = "Wartende Wiedergaben behalten",
    ["Kept waiting listens."] = "Wartende Wiedergaben behalten.",
    ["Waiting listens discarded."] = "Wartende Wiedergaben verworfen.",
    ["Could not discard listens. Try again."] = "Wartende Wiedergaben konnten nicht verworfen werden. Erneut versuchen.",
    ["Account changed. Open waiting listens again."] = "Konto geändert. Wartende Wiedergaben erneut öffnen.",
    ["Log out?"] = "Abmelden?",
    ["Stay logged in"] = "Angemeldet bleiben",
    ["Log out %s"] = "Abmelden: %s",
    ["Stayed logged in."] = "Angemeldet geblieben.",
    ["Logged out. Waiting listens are kept for this account."] = "Abgemeldet. Wartende Wiedergaben bleiben für dieses Konto erhalten.",
    ["Sending waiting listens…"] = "Wartende Wiedergaben werden gesendet…",
    ["Already sending waiting listens."] = "Wartende Wiedergaben werden bereits gesendet.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Lege dein ListenBrainz-Benutzertoken fest, bevor du wartende Wiedergaben sendest.",
    ["Turn scrobbling on before sending waiting listens."] = "Aktiviere Scrobbeln, bevor du wartende Wiedergaben sendest.",
    ["User token: set"] = "Benutzertoken: festgelegt",
    ["Up to 100 offline listens"] = "Bis zu 100 Offline-Wiedergaben",
    ["Separate queue per account"] = "Eigene Warteschlange pro Konto",
    ["Streams without length are not sent"] = "Streams ohne Länge werden nicht gesendet",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "So funktioniert das ListenBrainz-Scrobbeln:\n\n1. 30-Sekunden-Regel: Titel unter 30 Sekunden werden nicht gescrobbelt.\n\n2. Hörschwelle: Eine Wiedergabe zählt nach der halben Dauer oder 4 Minuten (was zuerst eintritt).\n\n3. Pause & Spulen: Pausierte oder gespulte Zeit zählt nicht zur Schwelle.\n\n4. Offline-Warteschlange: Bis zu 100 Wiedergaben (64 KB) werden offline gespeichert und bei Verbindung gesendet.\n\n5. Kontentrennung: Wartende Wiedergaben werden pro ListenBrainz-Konto aufbewahrt.\n\n6. Unbekannte Länge: Streams ohne bekannte Länge, etwa die meisten Radiosender, werden nicht gesendet.\n\n7. Token: Kopiere auf einem Smartphone oder Computer dein Benutzertoken von listenbrainz.org/settings in eine Textdatei auf der SD-Karte und wähle dann „Token von SD-Karte lesen“.",
  },
  es = {
    ["Could not open text entry. Try again."] = "No se pudo abrir la entrada de texto. Inténtalo de nuevo.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz no aceptó el token de usuario. Se conservan las escuchas guardadas.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "La cola de ListenBrainz está llena. Se conservaron las escuchas más antiguas.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "No se pudo guardar esa escucha de ListenBrainz. Se conservaron las escuchas guardadas.",
    ["Could not save the ListenBrainz token. Try again."] = "No se pudo guardar el token de ListenBrainz. Inténtalo de nuevo.",
    ["Could not log out of ListenBrainz. Try again."] = "No se pudo cerrar sesión en ListenBrainz. Inténtalo de nuevo.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Este reproductor no puede enviar escuchas a ListenBrainz. Se conservan las escuchas guardadas.",
    ["This player cannot store a ListenBrainz token."] = "Este reproductor no puede guardar un token de ListenBrainz.",
    ["That token cannot be used."] = "Ese token no se puede usar.",
    ["This player cannot check a ListenBrainz token."] = "Este reproductor no puede comprobar un token de ListenBrainz.",
    ["Checking ListenBrainz token..."] = "Comprobando token de ListenBrainz...",
    ["Could not reach ListenBrainz."] = "No se pudo conectar con ListenBrainz.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz no aceptó ese token.",
    ["ListenBrainz token saved."] = "Token de ListenBrainz guardado.",
    ["Logged in to ListenBrainz as %s"] = "Sesión iniciada en ListenBrainz como %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Cuenta guardada. Toca Scrobbling para activarlo.",
    ["Set ListenBrainz user token"] = "Configurar token de usuario de ListenBrainz",
    ["Read token from SD card"] = "Leer token desde la tarjeta SD",
    ["Delete token file?"] = "¿Eliminar el archivo del token?",
    ["Keep the file"] = "Conservar el archivo",
    ["Delete the file"] = "Eliminar el archivo",
    ["Token file deleted."] = "Archivo del token eliminado.",
    ["Could not delete the token file."] = "No se pudo eliminar el archivo del token.",
    ["Token file kept."] = "Archivo del token conservado.",
    ["No ListenBrainz token found in that file."] = "No se encontró ningún token de ListenBrainz en ese archivo.",
    ["Could not read that file."] = "No se pudo leer ese archivo.",
    ["Could not open the file picker. Try again."] = "No se pudo abrir el selector de archivos. Inténtalo de nuevo.",
    ["ListenBrainz user token"] = "Token de usuario de ListenBrainz",
    ["Log out"] = "Cerrar sesión",
    ["Log out (%s)"] = "Cerrar sesión (%s)",
    ["ListenBrainz Scrobbler"] = "Scrobbler de ListenBrainz",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi apagado \u{2014} se enviará al conectar",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi no conectado \u{2014} se enviará al conectar",
    ["Waiting list could not be updated."] = "No se pudo actualizar la lista de espera.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Enviado, pero no se pudo guardar la limpieza de la lista de espera.",
    ["Could not send scrobble request."] = "No se pudo enviar la solicitud de scrobble.",
    ["Waiting to send"] = "Esperando para enviar",
    ["Not saved yet"] = "Aún no guardado",
    ["Discarded by you"] = "Descartado por ti",
    ["Sending…"] = "Enviando…",
    ["waiting for Wi-Fi"] = "esperando Wi-Fi",
    ["next try %dm"] = "próximo intento en %dm",
    ["sent %s"] = "enviado %s",
    ["Sync now"] = "Sincronizar ahora",
    ["Account & settings"] = "Cuenta y ajustes",
    ["Press Back."] = "Pulsa Atrás.",
    ["Account changed. Nothing changed."] = "La cuenta ha cambiado. No se modificó nada.",
    ["Account changed. Nothing discarded."] = "La cuenta ha cambiado. No se descartó nada.",
    ["Saved: %s"] = "Guardado: %s",
    ["Saved time unavailable"] = "Hora de guardado no disponible",
    ["Scrobbling"] = "Scrobbling",
    ["Scrobbling: %s"] = "Scrobbling: %s",
    ["Scrobbling turned on."] = "Scrobbling activado.",
    ["Scrobbling turned off."] = "Scrobbling desactivado.",
    ["Could not save scrobbling preference. Try again."] = "No se pudo guardar la preferencia de scrobbling. Inténtalo de nuevo.",
    ["This track: No music playing"] = "Esta pista: No hay música reproduciéndose",
    ["This track: Scrobbling off"] = "Esta pista: Scrobbling desactivado",
    ["This track: Reading length"] = "Esta pista: Leyendo duración",
    ["This track: Too short (<30s)"] = "Esta pista: Demasiado corta (<30s)",
    ["This track: Playback paused"] = "Esta pista: Reproducción en pausa",
    ["This track: Counts after %s"] = "Esta pista: Cuenta tras %s",
    ["This track: This listen not counted"] = "Esta pista: Esta escucha no se cuenta",
    ["This track: %s"] = "Esta pista: %s",
    ["No track playing."] = "No se está reproduciendo ninguna pista.",
    ["Status: %s"] = "Estado: %s",
    ["How Scrobbling Works"] = "Cómo funciona el scrobbling",
    ["Tracks >= 30s only"] = "Solo pistas >= 30s",
    ["Listened 50% or 4 min"] = "50% o 4 min escuchados",
    ["Pauses do not count"] = "Las pausas no cuentan",
    ["ListenBrainz not reachable."] = "No se puede conectar con ListenBrainz.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz está ocupado temporalmente.",
    ["Status: user token not accepted"] = "Estado: token de usuario no aceptado",
    ["Logged in as %s"] = "Sesión iniciada como %s",
    ["Sent to ListenBrainz"] = "Enviado a ListenBrainz",
    ["ListenBrainz rejected this listen"] = "ListenBrainz rechazó esta escucha",
    ["%d listen waiting"] = "%d escucha en espera",
    ["%d listens waiting"] = "%d escuchas en espera",
    ["Waiting listens could not be read"] = "No se pudieron leer las escuchas en espera",
    ["Waiting listens could not be read. Nothing discarded."] = "No se pudieron leer las escuchas en espera. No se descartó nada.",
    ["Waiting listens"] = "Escuchas en espera",
    ["No listens are waiting to send"] = "No hay escuchas esperando para enviar",
    ["Qualified listens send automatically."] = "Las escuchas aptas se envían automáticamente.",
    ["%d listens kept for %s"] = "%d escuchas guardadas para %s",
    ["Oldest listens are sent first."] = "Las escuchas más antiguas se envían primero.",
    ["Send waiting listens now"] = "Enviar escuchas en espera ahora",
    ["Discard waiting listens…"] = "Descartar escuchas en espera…",
    ["Discard waiting listens (%d)"] = "Descartar escuchas en espera (%d)",
    ["Discard %d listens?"] = "¿Descartar %d escuchas?",
    ["Discard %d listens"] = "Descartar %d escuchas",
    ["Keep waiting listens"] = "Conservar escuchas en espera",
    ["Kept waiting listens."] = "Escuchas en espera conservadas.",
    ["Waiting listens discarded."] = "Escuchas en espera descartadas.",
    ["Could not discard listens. Try again."] = "No se pudieron descartar las escuchas. Inténtalo de nuevo.",
    ["Account changed. Open waiting listens again."] = "La cuenta ha cambiado. Abre las escuchas en espera de nuevo.",
    ["Log out?"] = "¿Cerrar sesión?",
    ["Stay logged in"] = "Mantener sesión",
    ["Log out %s"] = "Cerrar sesión de %s",
    ["Stayed logged in."] = "Sesión mantenida.",
    ["Logged out. Waiting listens are kept for this account."] = "Sesión cerrada. Las escuchas en espera se conservan para esta cuenta.",
    ["Sending waiting listens…"] = "Enviando escuchas en espera…",
    ["Already sending waiting listens."] = "Ya se están enviando las escuchas en espera.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Configura tu token de usuario de ListenBrainz antes de enviar las escuchas en espera.",
    ["Turn scrobbling on before sending waiting listens."] = "Activa el scrobbling antes de enviar las escuchas en espera.",
    ["User token: set"] = "Token de usuario: configurado",
    ["Up to 100 offline listens"] = "Hasta 100 escuchas sin conexión",
    ["Separate queue per account"] = "Cola separada por cuenta",
    ["Streams without length are not sent"] = "Las emisiones sin duración no se envían",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Cómo funciona el scrobbling de ListenBrainz:\n\n1. Regla de 30 segundos: Las pistas de menos de 30 segundos no se envían.\n\n2. Umbral de escucha: Una escucha califica tras la mitad de su duración o 4 minutos (lo que ocurra antes).\n\n3. Pausas y búsqueda: El tiempo en pausa o buscando no cuenta para el umbral.\n\n4. Cola sin conexión: Se guardan hasta 100 escuchas (64 KB) y se envían al conectar.\n\n5. Separación por cuenta: Las escuchas en espera se conservan por cuenta de ListenBrainz.\n\n6. Duración desconocida: Las emisiones sin duración conocida, como casi toda la radio, no se envían.\n\n7. Token: En un teléfono u ordenador, copia tu token de usuario de listenbrainz.org/settings en un archivo de texto de la tarjeta SD y usa después “Leer token desde la tarjeta SD”.",
  },
  fi = {
    ["Could not open text entry. Try again."] = "Tekstinsyöttöä ei voitu avata. Yritä uudelleen.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz ei hyväksynyt käyttäjätunnistetta. Tallennetut kuuntelut säilytetään.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "ListenBrainz-jono on täynnä. Vanhimmat tallennetut kuuntelut säilytettiin.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "ListenBrainz-kuuntelua ei voitu tallentaa. Tallennetut kuuntelut säilytettiin.",
    ["Could not save the ListenBrainz token. Try again."] = "ListenBrainz-tunnistetta ei voitu tallentaa. Yritä uudelleen.",
    ["Could not log out of ListenBrainz. Try again."] = "Uloskirjautuminen ListenBrainzista epäonnistui. Yritä uudelleen.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Tämä soitin ei voi lähettää ListenBrainz-kuunteluita. Tallennetut kuuntelut säilytetään.",
    ["This player cannot store a ListenBrainz token."] = "Tämä soitin ei voi tallentaa ListenBrainz-tunnistetta.",
    ["That token cannot be used."] = "Tätä tunnistetta ei voi käyttää.",
    ["This player cannot check a ListenBrainz token."] = "Tämä soitin ei voi tarkistaa ListenBrainz-tunnistetta.",
    ["Checking ListenBrainz token..."] = "Tarkistetaan ListenBrainz-tunnistetta...",
    ["Could not reach ListenBrainz."] = "ListenBrainziin ei saatu yhteyttä.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz ei hyväksynyt tätä tunnistetta.",
    ["ListenBrainz token saved."] = "ListenBrainz-tunniste tallennettu.",
    ["Logged in to ListenBrainz as %s"] = "Kirjauduttu ListenBrainz-palveluun käyttäjänä %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Tili tallennettu. Napauta Skrobblaus ottaaksesi käyttöön.",
    ["Set ListenBrainz user token"] = "Aseta ListenBrainz-käyttäjätunniste",
    ["Read token from SD card"] = "Lue tunniste SD-kortilta",
    ["Delete token file?"] = "Poistetaanko tunnistetiedosto?",
    ["Keep the file"] = "Säilytä tiedosto",
    ["Delete the file"] = "Poista tiedosto",
    ["Token file deleted."] = "Tunnistetiedosto poistettu.",
    ["Could not delete the token file."] = "Tunnistetiedoston poisto epäonnistui.",
    ["Token file kept."] = "Tunnistetiedosto säilytettiin.",
    ["No ListenBrainz token found in that file."] = "Tiedostosta ei löytynyt ListenBrainz-tunnistetta.",
    ["Could not read that file."] = "Tiedostoa ei voitu lukea.",
    ["Could not open the file picker. Try again."] = "Tiedostovalitsinta ei voitu avata. Yritä uudelleen.",
    ["ListenBrainz user token"] = "ListenBrainz-käyttäjätunniste",
    ["Log out"] = "Kirjaudu ulos",
    ["Log out (%s)"] = "Kirjaudu ulos (%s)",
    ["ListenBrainz Scrobbler"] = "ListenBrainz Scrobbler",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi pois päältä \u{2014} lähetetään yhdistettäessä",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Ei Wi-Fi-yhteyttä \u{2014} lähetetään yhdistettäessä",
    ["Waiting list could not be updated."] = "Odotuslistaa ei voitu päivittää.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Lähetetty, mutta odotuslistan siivousta ei voitu tallentaa.",
    ["Could not send scrobble request."] = "Skrobblauspyyntöä ei voitu lähettää.",
    ["Waiting to send"] = "Odottaa lähetystä",
    ["Not saved yet"] = "Ei vielä tallennettu",
    ["Discarded by you"] = "Hylkäsit tämän",
    ["Sending…"] = "Lähetetään…",
    ["waiting for Wi-Fi"] = "odottaa Wi-Fi-yhteyttä",
    ["next try %dm"] = "seuraava yritys %d min",
    ["sent %s"] = "lähetetty %s",
    ["Sync now"] = "Synkronoi nyt",
    ["Account & settings"] = "Tili ja asetukset",
    ["Press Back."] = "Paina Takaisin.",
    ["Account changed. Nothing changed."] = "Tili muuttui. Mitään ei muutettu.",
    ["Account changed. Nothing discarded."] = "Tili muuttui. Mitään ei hylätty.",
    ["Saved: %s"] = "Tallennettu: %s",
    ["Saved time unavailable"] = "Tallennusaika ei saatavilla",
    ["Scrobbling"] = "Skrobblaus",
    ["Scrobbling: %s"] = "Skrobblaus: %s",
    ["Scrobbling turned on."] = "Skrobblaus kytketty päälle.",
    ["Scrobbling turned off."] = "Skrobblaus kytketty pois päältä.",
    ["Could not save scrobbling preference. Try again."] = "Skrobbailuasetusta ei voitu tallentaa. Yritä uudelleen.",
    ["This track: No music playing"] = "Tämä kappale: Musiikkia ei toisteta",
    ["This track: Scrobbling off"] = "Tämä kappale: Skrobblaus pois päältä",
    ["This track: Reading length"] = "Tämä kappale: Luetaan kestoa",
    ["This track: Too short (<30s)"] = "Tämä kappale: Liian lyhyt (<30s)",
    ["This track: Playback paused"] = "Tämä kappale: Toisto keskeytetty",
    ["This track: Counts after %s"] = "Tämä kappale: Lasketaan %s jälkeen",
    ["This track: This listen not counted"] = "Tämä kappale: Tätä kuuntelua ei lasketa",
    ["This track: %s"] = "Tämä kappale: %s",
    ["No track playing."] = "Kappaletta ei toisteta.",
    ["Status: %s"] = "Tila: %s",
    ["How Scrobbling Works"] = "Kuinka skrobblaus toimii",
    ["Tracks >= 30s only"] = "Vain kappaleet >= 30s",
    ["Listened 50% or 4 min"] = "Kuunneltu 50 % tai 4 min",
    ["Pauses do not count"] = "Taukoja ei lasketa",
    ["ListenBrainz not reachable."] = "ListenBrainz ei ole tavoitettavissa.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz on tilapäisesti varattu.",
    ["Status: user token not accepted"] = "Tila: käyttäjätunnistetta ei hyväksytty",
    ["Logged in as %s"] = "Kirjauduttu nimellä %s",
    ["Sent to ListenBrainz"] = "Lähetetty ListenBrainziin",
    ["ListenBrainz rejected this listen"] = "ListenBrainz hylkäsi tämän kuuntelun",
    ["%d listen waiting"] = "%d kuuntelu odottaa",
    ["%d listens waiting"] = "%d kuuntelua odottaa",
    ["Waiting listens could not be read"] = "Odottavia kuunteluita ei voitu lukea",
    ["Waiting listens could not be read. Nothing discarded."] = "Odottavia kuunteluita ei voitu lukea. Mitään ei hylätty.",
    ["Waiting listens"] = "Odottavat kuuntelut",
    ["No listens are waiting to send"] = "Ei lähettämistä odottavia kuunteluita",
    ["Qualified listens send automatically."] = "Kelvolliset kuuntelut lähetetään automaattisesti.",
    ["%d listens kept for %s"] = "%d kuuntelua säilytetty käyttäjälle %s",
    ["Oldest listens are sent first."] = "Vanhimmat kuuntelut lähetetään ensin.",
    ["Send waiting listens now"] = "Lähetä odottavat kuuntelut nyt",
    ["Discard waiting listens…"] = "Hylkää odottavat kuuntelut…",
    ["Discard waiting listens (%d)"] = "Hylkää odottavat kuuntelut (%d)",
    ["Discard %d listens?"] = "Hylätäänkö %d kuuntelua?",
    ["Discard %d listens"] = "Hylkää %d kuuntelua",
    ["Keep waiting listens"] = "Säilytä odottavat kuuntelut",
    ["Kept waiting listens."] = "Odottavat kuuntelut säilytettiin.",
    ["Waiting listens discarded."] = "Odottavat kuuntelut hylätty.",
    ["Could not discard listens. Try again."] = "Kuunteluja ei voitu hylätä. Yritä uudelleen.",
    ["Account changed. Open waiting listens again."] = "Tili muuttui. Avaa odottavat kuuntelut uudelleen.",
    ["Log out?"] = "Kirjaudutaanko ulos?",
    ["Stay logged in"] = "Pysy kirjautuneena",
    ["Log out %s"] = "Kirjaa ulos %s",
    ["Stayed logged in."] = "Pysyttiin kirjautuneena.",
    ["Logged out. Waiting listens are kept for this account."] = "Kirjauduttu ulos. Odottavat kuuntelut säilytetään tälle tilille.",
    ["Sending waiting listens…"] = "Lähetetään odottavia kuunteluita…",
    ["Already sending waiting listens."] = "Odottavia kuunteluita lähetetään jo.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Aseta ListenBrainz-käyttäjätunniste ennen odottavien kuuntelujen lähettämistä.",
    ["Turn scrobbling on before sending waiting listens."] = "Ota skrobblaus käyttöön ennen odottavien kuuntelujen lähettämistä.",
    ["User token: set"] = "Käyttäjätunniste: asetettu",
    ["Up to 100 offline listens"] = "Jopa 100 offline-kuuntelua",
    ["Separate queue per account"] = "Erillinen jono tiliä kohden",
    ["Streams without length are not sent"] = "Virtoja ilman kestoa ei lähetetä",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Miten ListenBrainz-skrobblaus toimii:\n\n1. 30 sekunnin sääntö: Alle 30 sekunnin kappaleita ei skroblata.\n\n2. Kuuntelukynnys: Kuuntelu hyväksytään puolivälissä tai 4 minuutin jälkeen (kumpi täyttyy ensin).\n\n3. Tauot ja kelaus: Tauolla tai kelatessa vietettyä aikaa ei lasketa kynnykseen.\n\n4. Offline-jono: Jopa 100 kuuntelua (64 KB) tallennetaan offline-tilassa ja lähetetään yhdistettäessä.\n\n5. Tilikohtainen erottelu: Odottavat kuuntelut säilytetään erikseen kullekin ListenBrainz-tilille.\n\n6. Tuntematon kesto: Virtoja, joiden kestoa ei tiedetä, kuten useimpia radioasemia, ei lähetetä.\n\n7. Tunniste: Kopioi puhelimella tai tietokoneella käyttäjätunnisteesi osoitteesta listenbrainz.org/settings tekstitiedostoon SD-kortille ja valitse sitten ”Lue tunniste SD-kortilta”.",
  },
  fr = {
    ["Could not open text entry. Try again."] = "Impossible d'ouvrir la saisie de texte. Réessayez.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz a refusé le jeton utilisateur. Les écoutes enregistrées sont conservées.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "La file ListenBrainz est pleine. Les écoutes les plus anciennes ont été conservées.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "Impossible d'enregistrer cette écoute ListenBrainz. Les écoutes enregistrées ont été conservées.",
    ["Could not save the ListenBrainz token. Try again."] = "Impossible d'enregistrer le jeton ListenBrainz. Réessayez.",
    ["Could not log out of ListenBrainz. Try again."] = "Impossible de se déconnecter de ListenBrainz. Réessayez.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Ce lecteur ne peut pas envoyer d'écoutes ListenBrainz. Les écoutes enregistrées sont conservées.",
    ["This player cannot store a ListenBrainz token."] = "Ce lecteur ne peut pas stocker de jeton ListenBrainz.",
    ["That token cannot be used."] = "Ce jeton ne peut pas être utilisé.",
    ["This player cannot check a ListenBrainz token."] = "Ce lecteur ne peut pas vérifier un jeton ListenBrainz.",
    ["Checking ListenBrainz token..."] = "Vérification du jeton ListenBrainz...",
    ["Could not reach ListenBrainz."] = "Impossible de joindre ListenBrainz.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz a refusé ce jeton.",
    ["ListenBrainz token saved."] = "Jeton ListenBrainz enregistré.",
    ["Logged in to ListenBrainz as %s"] = "Connecté à ListenBrainz en tant que %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Compte enregistré. Touchez Scrobble pour l'activer.",
    ["Set ListenBrainz user token"] = "Définir le jeton utilisateur ListenBrainz",
    ["Read token from SD card"] = "Lire le jeton depuis la carte SD",
    ["Delete token file?"] = "Supprimer le fichier du jeton ?",
    ["Keep the file"] = "Garder le fichier",
    ["Delete the file"] = "Supprimer le fichier",
    ["Token file deleted."] = "Fichier du jeton supprimé.",
    ["Could not delete the token file."] = "Impossible de supprimer le fichier du jeton.",
    ["Token file kept."] = "Fichier du jeton conservé.",
    ["No ListenBrainz token found in that file."] = "Aucun jeton ListenBrainz trouvé dans ce fichier.",
    ["Could not read that file."] = "Impossible de lire ce fichier.",
    ["Could not open the file picker. Try again."] = "Impossible d'ouvrir le sélecteur de fichiers. Réessayez.",
    ["ListenBrainz user token"] = "Jeton utilisateur ListenBrainz",
    ["Log out"] = "Se déconnecter",
    ["Log out (%s)"] = "Se déconnecter (%s)",
    ["ListenBrainz Scrobbler"] = "Scrobbler ListenBrainz",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi désactivé \u{2014} envoi dès connexion",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi non connecté \u{2014} envoi dès connexion",
    ["Waiting list could not be updated."] = "Impossible de mettre à jour la file d'attente.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Envoyé, mais nettoyage de la file d'attente non enregistré.",
    ["Could not send scrobble request."] = "Impossible d'envoyer la demande de scrobble.",
    ["Waiting to send"] = "En attente d'envoi",
    ["Not saved yet"] = "Pas encore enregistré",
    ["Discarded by you"] = "Rejeté par vous",
    ["Sending…"] = "Envoi…",
    ["waiting for Wi-Fi"] = "en attente du Wi-Fi",
    ["next try %dm"] = "prochain essai dans %dm",
    ["sent %s"] = "envoyé %s",
    ["Sync now"] = "Synchroniser maintenant",
    ["Account & settings"] = "Compte et réglages",
    ["Press Back."] = "Appuyez sur Retour.",
    ["Account changed. Nothing changed."] = "Compte modifié. Rien n'a changé.",
    ["Account changed. Nothing discarded."] = "Compte modifié. Rien n'a été rejeté.",
    ["Saved: %s"] = "Enregistré : %s",
    ["Saved time unavailable"] = "Heure d'enregistrement indisponible",
    ["Scrobbling"] = "Scrobble",
    ["Scrobbling: %s"] = "Scrobble : %s",
    ["Scrobbling turned on."] = "Scrobble activé.",
    ["Scrobbling turned off."] = "Scrobble désactivé.",
    ["Could not save scrobbling preference. Try again."] = "Impossible d'enregistrer la préférence de scrobble. Réessayez.",
    ["This track: No music playing"] = "Ce morceau : Aucune musique en cours",
    ["This track: Scrobbling off"] = "Ce morceau : Scrobble désactivé",
    ["This track: Reading length"] = "Ce morceau : Lecture de la durée",
    ["This track: Too short (<30s)"] = "Ce morceau : Trop court (<30s)",
    ["This track: Playback paused"] = "Ce morceau : Lecture en pause",
    ["This track: Counts after %s"] = "Ce morceau : Compte après %s",
    ["This track: This listen not counted"] = "Ce morceau : Cette écoute n'est pas comptabilisée",
    ["This track: %s"] = "Ce morceau : %s",
    ["No track playing."] = "Aucun morceau en cours de lecture.",
    ["Status: %s"] = "État : %s",
    ["How Scrobbling Works"] = "Comment fonctionne le scrobble",
    ["Tracks >= 30s only"] = "Morceaux >= 30s uniquement",
    ["Listened 50% or 4 min"] = "50% ou 4 min écoutés",
    ["Pauses do not count"] = "Les pauses ne comptent pas",
    ["ListenBrainz not reachable."] = "ListenBrainz injoignable.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz est temporairement occupé.",
    ["Status: user token not accepted"] = "État : jeton utilisateur non accepté",
    ["Logged in as %s"] = "Connecté en tant que %s",
    ["Sent to ListenBrainz"] = "Envoyé à ListenBrainz",
    ["ListenBrainz rejected this listen"] = "ListenBrainz a rejeté cette écoute",
    ["%d listen waiting"] = "%d écoute en attente",
    ["%d listens waiting"] = "%d écoutes en attente",
    ["Waiting listens could not be read"] = "Impossible de lire les écoutes en attente",
    ["Waiting listens could not be read. Nothing discarded."] = "Impossible de lire les écoutes en attente. Rien n'a été rejeté.",
    ["Waiting listens"] = "Écoutes en attente",
    ["No listens are waiting to send"] = "Aucune écoute en attente d'envoi",
    ["Qualified listens send automatically."] = "Les écoutes éligibles sont envoyées automatiquement.",
    ["%d listens kept for %s"] = "%d écoutes conservées pour %s",
    ["Oldest listens are sent first."] = "Les écoutes les plus anciennes sont envoyées en premier.",
    ["Send waiting listens now"] = "Envoyer les écoutes en attente maintenant",
    ["Discard waiting listens…"] = "Rejeter les écoutes en attente…",
    ["Discard waiting listens (%d)"] = "Rejeter les écoutes en attente (%d)",
    ["Discard %d listens?"] = "Rejeter %d écoutes ?",
    ["Discard %d listens"] = "Rejeter %d écoutes",
    ["Keep waiting listens"] = "Conserver les écoutes en attente",
    ["Kept waiting listens."] = "Écoutes en attente conservées.",
    ["Waiting listens discarded."] = "Écoutes en attente rejetées.",
    ["Could not discard listens. Try again."] = "Impossible de rejeter les écoutes. Réessayez.",
    ["Account changed. Open waiting listens again."] = "Compte modifié. Rouvrez les écoutes en attente.",
    ["Log out?"] = "Se déconnecter ?",
    ["Stay logged in"] = "Rester connecté",
    ["Log out %s"] = "Déconnecter %s",
    ["Stayed logged in."] = "Session maintenue.",
    ["Logged out. Waiting listens are kept for this account."] = "Déconnecté. Les écoutes en attente sont conservées pour ce compte.",
    ["Sending waiting listens…"] = "Envoi des écoutes en attente…",
    ["Already sending waiting listens."] = "Envoi des écoutes en attente déjà en cours.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Définissez votre jeton utilisateur ListenBrainz avant d'envoyer les écoutes en attente.",
    ["Turn scrobbling on before sending waiting listens."] = "Activez le scrobbling avant d'envoyer les écoutes en attente.",
    ["User token: set"] = "Jeton utilisateur : défini",
    ["Up to 100 offline listens"] = "Jusqu'à 100 écoutes hors ligne",
    ["Separate queue per account"] = "File distincte par compte",
    ["Streams without length are not sent"] = "Les flux sans durée ne sont pas envoyés",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Fonctionnement du scrobble ListenBrainz :\n\n1. Règle des 30 secondes : Les morceaux de moins de 30 secondes ne sont pas scrobblés.\n\n2. Seuil d'écoute : Une écoute est validée après la moitié de sa durée ou 4 minutes (au premier des deux).\n\n3. Pauses et recherche : Le temps en pause ou en avance rapide ne compte pas dans le seuil.\n\n4. File hors ligne : Jusqu'à 100 écoutes (64 Ko) enregistrées hors ligne et envoyées dès la connexion.\n\n5. Séparation des comptes : Les écoutes en attente sont conservées par compte ListenBrainz.\n\n6. Durée inconnue : Les flux de durée inconnue, comme la plupart des radios, ne sont pas envoyés.\n\n7. Jeton : sur un téléphone ou un ordinateur, copiez votre jeton utilisateur depuis listenbrainz.org/settings dans un fichier texte sur la carte SD, puis utilisez « Lire le jeton depuis la carte SD ».",
  },
  it = {
    ["Could not open text entry. Try again."] = "Impossibile aprire l'inserimento testo. Riprova.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz non ha accettato il token utente. Gli ascolti salvati vengono mantenuti.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "La coda di ListenBrainz è piena. Gli ascolti salvati più vecchi sono stati mantenuti.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "Impossibile salvare questo ascolto ListenBrainz. Gli ascolti salvati sono stati mantenuti.",
    ["Could not save the ListenBrainz token. Try again."] = "Impossibile salvare il token ListenBrainz. Riprova.",
    ["Could not log out of ListenBrainz. Try again."] = "Impossibile disconnettersi da ListenBrainz. Riprova.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Questo lettore non può inviare ascolti ListenBrainz. Gli ascolti salvati vengono mantenuti.",
    ["This player cannot store a ListenBrainz token."] = "Questo lettore non può memorizzare un token ListenBrainz.",
    ["That token cannot be used."] = "Questo token non può essere usato.",
    ["This player cannot check a ListenBrainz token."] = "Questo lettore non può verificare un token ListenBrainz.",
    ["Checking ListenBrainz token..."] = "Verifica del token ListenBrainz...",
    ["Could not reach ListenBrainz."] = "Impossibile raggiungere ListenBrainz.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz non ha accettato questo token.",
    ["ListenBrainz token saved."] = "Token ListenBrainz salvato.",
    ["Logged in to ListenBrainz as %s"] = "Connesso a ListenBrainz come %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Account salvato. Tocca Scrobbling per attivarlo.",
    ["Set ListenBrainz user token"] = "Imposta token utente ListenBrainz",
    ["Read token from SD card"] = "Leggi token dalla scheda SD",
    ["Delete token file?"] = "Eliminare il file del token?",
    ["Keep the file"] = "Mantieni il file",
    ["Delete the file"] = "Elimina il file",
    ["Token file deleted."] = "File del token eliminato.",
    ["Could not delete the token file."] = "Impossibile eliminare il file del token.",
    ["Token file kept."] = "File del token mantenuto.",
    ["No ListenBrainz token found in that file."] = "Nessun token ListenBrainz trovato in quel file.",
    ["Could not read that file."] = "Impossibile leggere quel file.",
    ["Could not open the file picker. Try again."] = "Impossibile aprire il selettore di file. Riprova.",
    ["ListenBrainz user token"] = "Token utente ListenBrainz",
    ["Log out"] = "Esci",
    ["Log out (%s)"] = "Esci (%s)",
    ["ListenBrainz Scrobbler"] = "Scrobbler ListenBrainz",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi disattivato \u{2014} invio alla connessione",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi non connesso \u{2014} invio alla connessione",
    ["Waiting list could not be updated."] = "Impossibile aggiornare la coda di attesa.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Inviato, ma impossibile salvare la pulizia della coda.",
    ["Could not send scrobble request."] = "Impossibile inviare la richiesta di scrobble.",
    ["Waiting to send"] = "In attesa di invio",
    ["Not saved yet"] = "Non ancora salvato",
    ["Discarded by you"] = "Scartato da te",
    ["Sending…"] = "Invio…",
    ["waiting for Wi-Fi"] = "in attesa del Wi-Fi",
    ["next try %dm"] = "prossimo tentativo tra %dm",
    ["sent %s"] = "inviato %s",
    ["Sync now"] = "Sincronizza ora",
    ["Account & settings"] = "Account e impostazioni",
    ["Press Back."] = "Premi Indietro.",
    ["Account changed. Nothing changed."] = "Account modificato. Nessuna modifica.",
    ["Account changed. Nothing discarded."] = "Account modificato. Nulla è stato scartato.",
    ["Saved: %s"] = "Salvato: %s",
    ["Saved time unavailable"] = "Orario di salvataggio non disponibile",
    ["Scrobbling"] = "Scrobbling",
    ["Scrobbling: %s"] = "Scrobbling: %s",
    ["Scrobbling turned on."] = "Scrobbling attivato.",
    ["Scrobbling turned off."] = "Scrobbling disattivato.",
    ["Could not save scrobbling preference. Try again."] = "Impossibile salvare la preferenza di scrobbling. Riprova.",
    ["This track: No music playing"] = "Questo brano: Nessuna musica in riproduzione",
    ["This track: Scrobbling off"] = "Questo brano: Scrobbling disattivato",
    ["This track: Reading length"] = "Questo brano: Lettura durata",
    ["This track: Too short (<30s)"] = "Questo brano: Troppo breve (<30s)",
    ["This track: Playback paused"] = "Questo brano: Riproduzione in pausa",
    ["This track: Counts after %s"] = "Questo brano: Conta dopo %s",
    ["This track: This listen not counted"] = "Questo brano: Questo ascolto non viene conteggiato",
    ["This track: %s"] = "Questo brano: %s",
    ["No track playing."] = "Nessun brano in riproduzione.",
    ["Status: %s"] = "Stato: %s",
    ["How Scrobbling Works"] = "Come funziona lo scrobbling",
    ["Tracks >= 30s only"] = "Solo brani >= 30s",
    ["Listened 50% or 4 min"] = "Ascoltato al 50% o 4 min",
    ["Pauses do not count"] = "Le pause non contano",
    ["ListenBrainz not reachable."] = "ListenBrainz non raggiungibile.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz temporaneamente occupato.",
    ["Status: user token not accepted"] = "Stato: token utente non accettato",
    ["Logged in as %s"] = "Connesso come %s",
    ["Sent to ListenBrainz"] = "Inviato a ListenBrainz",
    ["ListenBrainz rejected this listen"] = "ListenBrainz ha rifiutato questo ascolto",
    ["%d listen waiting"] = "%d ascolto in attesa",
    ["%d listens waiting"] = "%d ascolti in attesa",
    ["Waiting listens could not be read"] = "Impossibile leggere gli ascolti in attesa",
    ["Waiting listens could not be read. Nothing discarded."] = "Impossibile leggere gli ascolti in attesa. Nulla è stato scartato.",
    ["Waiting listens"] = "Ascolti in attesa",
    ["No listens are waiting to send"] = "Nessun ascolto in attesa di invio",
    ["Qualified listens send automatically."] = "Gli ascolti idonei vengono inviati automaticamente.",
    ["%d listens kept for %s"] = "%d ascolti conservati per %s",
    ["Oldest listens are sent first."] = "Gli ascolti più vecchi vengono inviati prima.",
    ["Send waiting listens now"] = "Invia ascolti in attesa ora",
    ["Discard waiting listens…"] = "Scarta ascolti in attesa…",
    ["Discard waiting listens (%d)"] = "Scarta ascolti in attesa (%d)",
    ["Discard %d listens?"] = "Scartare %d ascolti?",
    ["Discard %d listens"] = "Scarta %d ascolti",
    ["Keep waiting listens"] = "Mantieni ascolti in attesa",
    ["Kept waiting listens."] = "Ascolti in attesa mantenuti.",
    ["Waiting listens discarded."] = "Ascolti in attesa scartati.",
    ["Could not discard listens. Try again."] = "Impossibile scartare gli ascolti. Riprova.",
    ["Account changed. Open waiting listens again."] = "Account modificato. Riapri gli ascolti in attesa.",
    ["Log out?"] = "Uscire?",
    ["Stay logged in"] = "Resta connesso",
    ["Log out %s"] = "Esci da %s",
    ["Stayed logged in."] = "Accesso mantenuto.",
    ["Logged out. Waiting listens are kept for this account."] = "Disconnesso. Gli ascolti in attesa sono conservati per questo account.",
    ["Sending waiting listens…"] = "Invio ascolti in attesa…",
    ["Already sending waiting listens."] = "Invio ascolti in attesa già in corso.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Imposta il token utente ListenBrainz prima di inviare gli ascolti in attesa.",
    ["Turn scrobbling on before sending waiting listens."] = "Attiva lo scrobbling prima di inviare gli ascolti in attesa.",
    ["User token: set"] = "Token utente: impostato",
    ["Up to 100 offline listens"] = "Fino a 100 ascolti offline",
    ["Separate queue per account"] = "Coda separata per account",
    ["Streams without length are not sent"] = "Gli stream senza durata non vengono inviati",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Come funziona lo scrobbling di ListenBrainz:\n\n1. Regola dei 30 secondi: I brani sotto i 30 secondi non vengono inviati.\n\n2. Soglia di ascolto: Un ascolto è valido dopo metà durata o 4 minuti (quello che viene prima).\n\n3. Pause e avanzamento: Il tempo in pausa o ricerca non conta ai fini della soglia.\n\n4. Coda non in linea: Fino a 100 ascolti (64 KB) salvati offline e inviati automaticamente alla connessione.\n\n5. Separazione account: Gli ascolti in attesa sono conservati per ogni account ListenBrainz.\n\n6. Durata sconosciuta: Gli stream di durata sconosciuta, come la maggior parte delle radio, non vengono inviati.\n\n7. Token: da telefono o computer, copia il tuo token utente da listenbrainz.org/settings in un file di testo sulla scheda SD, poi usa “Leggi token dalla scheda SD”.",
  },
  ja = {
    ["Could not open text entry. Try again."] = "テキスト入力を開けませんでした。もう一度お試しください。",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz がユーザートークンを拒否しました。保存済みの再生履歴は保持されます。",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "ListenBrainz のキューが満杯です。最も古い再生履歴を保持しました。",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "ListenBrainz の再生履歴を保存できませんでした。保存済みの履歴は保持されました。",
    ["Could not save the ListenBrainz token. Try again."] = "ListenBrainz トークンを保存できませんでした。もう一度お試しください。",
    ["Could not log out of ListenBrainz. Try again."] = "ListenBrainz からログアウトできませんでした。もう一度お試しください。",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "このプレーヤーは ListenBrainz の再生履歴を送信できません。保存済みの履歴は保持されます。",
    ["This player cannot store a ListenBrainz token."] = "このプレーヤーは ListenBrainz トークンを保存できません。",
    ["That token cannot be used."] = "そのトークンは使用できません。",
    ["This player cannot check a ListenBrainz token."] = "このプレーヤーは ListenBrainz トークンを確認できません。",
    ["Checking ListenBrainz token..."] = "ListenBrainz トークンを確認中...",
    ["Could not reach ListenBrainz."] = "ListenBrainz に接続できませんでした。",
    ["ListenBrainz did not accept that token."] = "ListenBrainz がそのトークンを拒否しました。",
    ["ListenBrainz token saved."] = "ListenBrainz トークンを保存しました。",
    ["Logged in to ListenBrainz as %s"] = "ListenBrainzに%sとしてログインしました",
    ["Account saved. Tap Scrobbling to turn it on."] = "アカウントが保存されました。「スクロブル」をタップしてオンにします。",
    ["Set ListenBrainz user token"] = "ListenBrainz ユーザートークンを設定",
    ["Read token from SD card"] = "SDカードからトークンを読み込む",
    ["Delete token file?"] = "トークンファイルを削除しますか？",
    ["Keep the file"] = "ファイルを残す",
    ["Delete the file"] = "ファイルを削除",
    ["Token file deleted."] = "トークンファイルを削除しました。",
    ["Could not delete the token file."] = "トークンファイルを削除できませんでした。",
    ["Token file kept."] = "トークンファイルを残しました。",
    ["No ListenBrainz token found in that file."] = "そのファイルにListenBrainzトークンが見つかりません。",
    ["Could not read that file."] = "そのファイルを読み込めませんでした。",
    ["Could not open the file picker. Try again."] = "ファイル選択を開けませんでした。もう一度お試しください。",
    ["ListenBrainz user token"] = "ListenBrainz ユーザートークン",
    ["Log out"] = "ログアウト",
    ["Log out (%s)"] = "ログアウト (%s)",
    ["ListenBrainz Scrobbler"] = "ListenBrainz スクブラー",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fiオフ \u{2014} 接続時に送信します",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi未接続 \u{2014} 接続時に送信します",
    ["Waiting list could not be updated."] = "待機リストを更新できませんでした。",
    ["Sent, but waiting-list cleanup could not be saved."] = "送信されましたが、待機リストのクリーンアップを保存できませんでした。",
    ["Could not send scrobble request."] = "スクロブルリクエストを送信できませんでした。",
    ["Waiting to send"] = "送信待ち",
    ["Not saved yet"] = "まだ保存されていません",
    ["Discarded by you"] = "あなたによって破棄されました",
    ["Sending…"] = "送信中…",
    ["waiting for Wi-Fi"] = "Wi-Fi待機中",
    ["next try %dm"] = "次の試行まで %d分",
    ["sent %s"] = "送信日時: %s",
    ["Sync now"] = "今すぐ同期",
    ["Account & settings"] = "アカウントと設定",
    ["Press Back."] = "「戻る」を押してください。",
    ["Account changed. Nothing changed."] = "アカウントが変更されました。何も変更されていません。",
    ["Account changed. Nothing discarded."] = "アカウントが変更されました。何も破棄されていません。",
    ["Saved: %s"] = "保存日時: %s",
    ["Saved time unavailable"] = "保存日時は利用不可",
    ["Scrobbling"] = "スクロブル",
    ["Scrobbling: %s"] = "スクロブル: %s",
    ["Scrobbling turned on."] = "スクロブルをオンにしました。",
    ["Scrobbling turned off."] = "スクロブルをオフにしました。",
    ["Could not save scrobbling preference. Try again."] = "スクロブル設定を保存できませんでした。もう一度お試しください。",
    ["This track: No music playing"] = "この曲: 再生中の音楽はありません",
    ["This track: Scrobbling off"] = "この曲: スクロブルオフ",
    ["This track: Reading length"] = "この曲: 曲の長さを読み取り中",
    ["This track: Too short (<30s)"] = "この曲: 短すぎます (<30秒)",
    ["This track: Playback paused"] = "この曲: 再生一時停止中",
    ["This track: Counts after %s"] = "この曲: %s 後にカウント",
    ["This track: This listen not counted"] = "この曲: この再生はカウントされません",
    ["This track: %s"] = "この曲: %s",
    ["No track playing."] = "再生中の曲はありません。",
    ["Status: %s"] = "状態: %s",
    ["How Scrobbling Works"] = "スクロブルの仕組み",
    ["Tracks >= 30s only"] = "30秒以上の曲のみ",
    ["Listened 50% or 4 min"] = "50%または4分再生",
    ["Pauses do not count"] = "一時停止は含みません",
    ["ListenBrainz not reachable."] = "ListenBrainz にアクセスできません。",
    ["ListenBrainz temporarily busy."] = "ListenBrainz は一時的にビジー状態です。",
    ["Status: user token not accepted"] = "状態: ユーザートークンが受け付けられません",
    ["Logged in as %s"] = "%s としてログイン中",
    ["Sent to ListenBrainz"] = "ListenBrainz に送信済み",
    ["ListenBrainz rejected this listen"] = "ListenBrainz がこの再生履歴を拒否しました",
    ["%d listen waiting"] = "%d件の再生履歴が待機中",
    ["%d listens waiting"] = "%d件の再生履歴が待機中",
    ["Waiting listens could not be read"] = "待機中の再生履歴を読み取れませんでした",
    ["Waiting listens could not be read. Nothing discarded."] = "待機中の再生履歴を読み取れませんでした。何も破棄されていません。",
    ["Waiting listens"] = "待機中の再生履歴",
    ["No listens are waiting to send"] = "送信待ちの再生履歴はありません",
    ["Qualified listens send automatically."] = "条件を満たした再生履歴は自動的に送信されます。",
    ["%d listens kept for %s"] = "%d件の再生履歴を保持 (%s)",
    ["Oldest listens are sent first."] = "最も古い再生履歴から順に送信されます。",
    ["Send waiting listens now"] = "待機中の再生履歴を今すぐ送信",
    ["Discard waiting listens…"] = "待機中の再生履歴を破棄…",
    ["Discard waiting listens (%d)"] = "待機中の再生履歴を破棄 (%d)",
    ["Discard %d listens?"] = "%d件の再生履歴を破棄しますか？",
    ["Discard %d listens"] = "%d件の再生履歴を破棄",
    ["Keep waiting listens"] = "待機中の再生履歴を保持",
    ["Kept waiting listens."] = "待機中の再生履歴を保持しました。",
    ["Waiting listens discarded."] = "待機中の再生履歴を破棄しました。",
    ["Could not discard listens. Try again."] = "再生履歴を破棄できませんでした。もう一度お試しください。",
    ["Account changed. Open waiting listens again."] = "アカウントが変更されました。待機中の再生履歴をもう一度開いてください。",
    ["Log out?"] = "ログアウトしますか？",
    ["Stay logged in"] = "ログインを維持",
    ["Log out %s"] = "%s をログアウト",
    ["Stayed logged in."] = "ログインを維持しました。",
    ["Logged out. Waiting listens are kept for this account."] = "ログアウトしました。このアカウントの待機中の再生履歴は保持されます。",
    ["Sending waiting listens…"] = "待機中の再生履歴を送信中…",
    ["Already sending waiting listens."] = "待機中の再生履歴をすでに送信中です。",
    ["Set your ListenBrainz user token before sending waiting listens."] = "待機中の再生履歴を送信する前に ListenBrainz ユーザートークンを設定してください。",
    ["Turn scrobbling on before sending waiting listens."] = "待機中の再生履歴を送信する前にスクロブルをオンにしてください。",
    ["User token: set"] = "ユーザートークン: 設定済み",
    ["Up to 100 offline listens"] = "最大100件のオフライン再生履歴",
    ["Separate queue per account"] = "アカウントごとの個別キュー",
    ["Streams without length are not sent"] = "長さ不明のストリームは送信されません",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "ListenBrainz スクロブルの仕組み：\n\n1. 30秒ルール：30秒未満のトラックはスクロブルされません。\n\n2. 再生しきい値：曲の半分または4分のいずれか早い方に達すると再生履歴としてカウントされます。\n\n3. 一時停止とシーク：一時停止中やシーク中の時間はしきい値に含まれません。\n\n4. オフラインキュー：最大100件（64 KB）までオフライン保存され、接続時に自動送信されます。\n\n5. アカウント分離：待機中の再生履歴は ListenBrainz アカウントごとに保持されます。\n\n6. 長さ不明：長さが不明なストリーム（ほとんどのラジオなど）は送信されません。\n\n7. トークン：スマートフォンまたはパソコンで listenbrainz.org/settings からユーザートークンをコピーし、SDカード上のテキストファイルに貼り付けてから「SDカードからトークンを読み込む」を使います。",
  },
  nl = {
    ["Could not open text entry. Try again."] = "Tekstinvoer kon niet worden geopend. Probeer opnieuw.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz heeft de gebruikerstoken geweigerd. Opgeslagen luisterbeurten blijven behouden.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "ListenBrainz-wachtrij is vol. De oudste opgeslagen luisterbeurten zijn behouden.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "Kon die ListenBrainz-luisterbeurt niet opslaan. Opgeslagen luisterbeurten zijn behouden.",
    ["Could not save the ListenBrainz token. Try again."] = "Kon de ListenBrainz-token niet opslaan. Probeer opnieuw.",
    ["Could not log out of ListenBrainz. Try again."] = "Kon niet uitloggen bij ListenBrainz. Probeer opnieuw.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Deze speler kan geen ListenBrainz-luisterbeurten verzenden. Opgeslagen luisterbeurten blijven behouden.",
    ["This player cannot store a ListenBrainz token."] = "Deze speler kan geen ListenBrainz-token opslaan.",
    ["That token cannot be used."] = "Die token kan niet worden gebruikt.",
    ["This player cannot check a ListenBrainz token."] = "Deze speler kan geen ListenBrainz-token controleren.",
    ["Checking ListenBrainz token..."] = "ListenBrainz-token controleren...",
    ["Could not reach ListenBrainz."] = "Kon ListenBrainz niet bereiken.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz heeft die token geweigerd.",
    ["ListenBrainz token saved."] = "ListenBrainz-token opgeslagen.",
    ["Logged in to ListenBrainz as %s"] = "Aangemeld bij ListenBrainz als %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Account opgeslagen. Tik op Scrobbelen om in te schakelen.",
    ["Set ListenBrainz user token"] = "ListenBrainz-gebruikerstoken instellen",
    ["Read token from SD card"] = "Token van SD-kaart lezen",
    ["Delete token file?"] = "Tokenbestand verwijderen?",
    ["Keep the file"] = "Bestand bewaren",
    ["Delete the file"] = "Bestand verwijderen",
    ["Token file deleted."] = "Tokenbestand verwijderd.",
    ["Could not delete the token file."] = "Tokenbestand kon niet worden verwijderd.",
    ["Token file kept."] = "Tokenbestand bewaard.",
    ["No ListenBrainz token found in that file."] = "Geen ListenBrainz-token gevonden in dat bestand.",
    ["Could not read that file."] = "Dat bestand kon niet worden gelezen.",
    ["Could not open the file picker. Try again."] = "Bestandskiezer kon niet worden geopend. Probeer opnieuw.",
    ["ListenBrainz user token"] = "ListenBrainz-gebruikerstoken",
    ["Log out"] = "Uitloggen",
    ["Log out (%s)"] = "Uitloggen (%s)",
    ["ListenBrainz Scrobbler"] = "ListenBrainz Scrobbler",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi uit \u{2014} wordt verzonden na verbinding",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Geen Wi-Fi-verbinding \u{2014} wordt verzonden na verbinding",
    ["Waiting list could not be updated."] = "Wachtlijst kon niet worden bijgewerkt.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Verzonden, maar opschonen van wachtlijst kon niet worden opgeslagen.",
    ["Could not send scrobble request."] = "Kon scrobble-verzoek niet verzenden.",
    ["Waiting to send"] = "Wachten op verzending",
    ["Not saved yet"] = "Nog niet opgeslagen",
    ["Discarded by you"] = "Verworpen door jou",
    ["Sending…"] = "Verzenden…",
    ["waiting for Wi-Fi"] = "wachten op Wi-Fi",
    ["next try %dm"] = "volgende poging over %dm",
    ["sent %s"] = "verzonden %s",
    ["Sync now"] = "Nu synchroniseren",
    ["Account & settings"] = "Account en instellingen",
    ["Press Back."] = "Druk op Terug.",
    ["Account changed. Nothing changed."] = "Account gewijzigd. Niets gewijzigd.",
    ["Account changed. Nothing discarded."] = "Account gewijzigd. Niets verworpen.",
    ["Saved: %s"] = "Opgeslagen: %s",
    ["Saved time unavailable"] = "Opslagtijd niet beschikbaar",
    ["Scrobbling"] = "Scrobbelen",
    ["Scrobbling: %s"] = "Scrobbelen: %s",
    ["Scrobbling turned on."] = "Scrobbelen ingeschakeld.",
    ["Scrobbling turned off."] = "Scrobbelen uitgeschakeld.",
    ["Could not save scrobbling preference. Try again."] = "Kon scrobble-voorkeur niet opslaan. Probeer het opnieuw.",
    ["This track: No music playing"] = "Dit nummer: Geen muziek die afspeelt",
    ["This track: Scrobbling off"] = "Dit nummer: Scrobbelen uit",
    ["This track: Reading length"] = "Dit nummer: Duur lezen",
    ["This track: Too short (<30s)"] = "Dit nummer: Te kort (<30s)",
    ["This track: Playback paused"] = "Dit nummer: Afspelen gepauzeerd",
    ["This track: Counts after %s"] = "Dit nummer: Telt na %s",
    ["This track: This listen not counted"] = "Dit nummer: Deze afspeling telt niet mee",
    ["This track: %s"] = "Dit nummer: %s",
    ["No track playing."] = "Er wordt geen nummer afgespeeld.",
    ["Status: %s"] = "Status: %s",
    ["How Scrobbling Works"] = "Hoe scrobbelen werkt",
    ["Tracks >= 30s only"] = "Alleen nummers >= 30s",
    ["Listened 50% or 4 min"] = "50% of 4 min geluisterd",
    ["Pauses do not count"] = "Pauzes tellen niet mee",
    ["ListenBrainz not reachable."] = "ListenBrainz niet bereikbaar.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz tijdelijk bezet.",
    ["Status: user token not accepted"] = "Status: gebruikerstoken niet geaccepteerd",
    ["Logged in as %s"] = "Aangemeld als %s",
    ["Sent to ListenBrainz"] = "Verzonden naar ListenBrainz",
    ["ListenBrainz rejected this listen"] = "ListenBrainz heeft deze luisterbeurt geweigerd",
    ["%d listen waiting"] = "%d luisterbeurt in de wachtrij",
    ["%d listens waiting"] = "%d luisterbeurten in de wachtrij",
    ["Waiting listens could not be read"] = "Wachtende luisterbeurten konden niet worden gelezen",
    ["Waiting listens could not be read. Nothing discarded."] = "Wachtende luisterbeurten konden niet worden gelezen. Niets verworpen.",
    ["Waiting listens"] = "Wachtende luisterbeurten",
    ["No listens are waiting to send"] = "Er wachten geen luisterbeurten om te verzenden",
    ["Qualified listens send automatically."] = "In aanmerking komende luisterbeurten worden automatisch verzonden.",
    ["%d listens kept for %s"] = "%d luisterbeurten bewaard voor %s",
    ["Oldest listens are sent first."] = "Oudste luisterbeurten worden eerst verzonden.",
    ["Send waiting listens now"] = "Wachtende luisterbeurten nu verzenden",
    ["Discard waiting listens…"] = "Wachtende luisterbeurten verwerpen…",
    ["Discard waiting listens (%d)"] = "Wachtende luisterbeurten verwerpen (%d)",
    ["Discard %d listens?"] = "%d luisterbeurten verwerpen?",
    ["Discard %d listens"] = "%d luisterbeurten verwerpen",
    ["Keep waiting listens"] = "Wachtende luisterbeurten bewaren",
    ["Kept waiting listens."] = "Wachtende luisterbeurten bewaard.",
    ["Waiting listens discarded."] = "Wachtende luisterbeurten verworpen.",
    ["Could not discard listens. Try again."] = "Kon luisterbeurten niet verwerpen. Probeer het opnieuw.",
    ["Account changed. Open waiting listens again."] = "Account gewijzigd. Open wachtende luisterbeurten opnieuw.",
    ["Log out?"] = "Uitloggen?",
    ["Stay logged in"] = "Ingelogd blijven",
    ["Log out %s"] = "Log %s uit",
    ["Stayed logged in."] = "Ingelogd gebleven.",
    ["Logged out. Waiting listens are kept for this account."] = "Uitgelogd. Wachtende luisterbeurten worden bewaard voor dit account.",
    ["Sending waiting listens…"] = "Wachtende luisterbeurten verzenden…",
    ["Already sending waiting listens."] = "Wachtende luisterbeurten worden al verzonden.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Stel je ListenBrainz-gebruikerstoken in voordat je wachtende luisterbeurten verzendt.",
    ["Turn scrobbling on before sending waiting listens."] = "Schakel scrobbelen in voordat je wachtende luisterbeurten verzendt.",
    ["User token: set"] = "Gebruikerstoken: ingesteld",
    ["Up to 100 offline listens"] = "Tot 100 offline luisterbeurten",
    ["Separate queue per account"] = "Aparte wachtrij per account",
    ["Streams without length are not sent"] = "Streams zonder lengte worden niet verzonden",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Hoe ListenBrainz-scrobbelen werkt:\n\n1. 30-secondenregel: Nummers onder 30 seconden worden niet gescrobbeld.\n\n2. Luisterdrempel: Een luisterbeurt telt na de helft van de duur of 4 minuten (wat eerst komt).\n\n3. Pauzes & spoelen: Tijd gepauzeerd of spoelend telt niet mee voor de drempel.\n\n4. Offline wachtrij: Tot 100 luisterbeurten (64 KB) offline opgeslagen en automatisch verzonden bij verbinding.\n\n5. Accountscheiding: Wachtende luisterbeurten worden per ListenBrainz-account bewaard.\n\n6. Onbekende lengte: Streams zonder bekende lengte, zoals de meeste radio, worden niet verzonden.\n\n7. Token: kopieer op een telefoon of computer je gebruikerstoken van listenbrainz.org/settings naar een tekstbestand op de SD-kaart en gebruik daarna “Token van SD-kaart lezen”.",
  },
  pt = {
    ["Could not open text entry. Try again."] = "Não foi possível abrir a entrada de texto. Tente novamente.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "O ListenBrainz não aceitou o token de usuário. As reproduções salvas foram mantidas.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "A fila do ListenBrainz está cheia. As reproduções salvas mais antigas foram mantidas.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "Não foi possível salvar essa reprodução do ListenBrainz. As reproduções salvas foram mantidas.",
    ["Could not save the ListenBrainz token. Try again."] = "Não foi possível salvar o token do ListenBrainz. Tente novamente.",
    ["Could not log out of ListenBrainz. Try again."] = "Não foi possível sair do ListenBrainz. Tente novamente.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Este reprodutor não pode enviar reproduções ao ListenBrainz. As reproduções salvas foram mantidas.",
    ["This player cannot store a ListenBrainz token."] = "Este reprodutor não pode armazenar um token do ListenBrainz.",
    ["That token cannot be used."] = "Esse token não pode ser usado.",
    ["This player cannot check a ListenBrainz token."] = "Este reprodutor não pode verificar um token do ListenBrainz.",
    ["Checking ListenBrainz token..."] = "Verificando token do ListenBrainz...",
    ["Could not reach ListenBrainz."] = "Não foi possível conectar ao ListenBrainz.",
    ["ListenBrainz did not accept that token."] = "O ListenBrainz não aceitou esse token.",
    ["ListenBrainz token saved."] = "Token do ListenBrainz salvo.",
    ["Logged in to ListenBrainz as %s"] = "Sessão iniciada no ListenBrainz como %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Conta salva. Toque em Scrobbling para ativá-lo.",
    ["Set ListenBrainz user token"] = "Definir token de usuário do ListenBrainz",
    ["Read token from SD card"] = "Ler token do cartão SD",
    ["Delete token file?"] = "Excluir o arquivo do token?",
    ["Keep the file"] = "Manter o arquivo",
    ["Delete the file"] = "Excluir o arquivo",
    ["Token file deleted."] = "Arquivo do token excluído.",
    ["Could not delete the token file."] = "Não foi possível excluir o arquivo do token.",
    ["Token file kept."] = "Arquivo do token mantido.",
    ["No ListenBrainz token found in that file."] = "Nenhum token do ListenBrainz encontrado nesse arquivo.",
    ["Could not read that file."] = "Não foi possível ler esse arquivo.",
    ["Could not open the file picker. Try again."] = "Não foi possível abrir o seletor de arquivos. Tente novamente.",
    ["ListenBrainz user token"] = "Token de usuário do ListenBrainz",
    ["Log out"] = "Sair",
    ["Log out (%s)"] = "Sair (%s)",
    ["ListenBrainz Scrobbler"] = "Scrobbler do ListenBrainz",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi desligado \u{2014} será enviado ao conectar",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi não conectado \u{2014} será enviado ao conectar",
    ["Waiting list could not be updated."] = "Não foi possível atualizar a fila de espera.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Enviado, mas a limpeza da fila de espera não pôde ser salva.",
    ["Could not send scrobble request."] = "Não foi possível enviar a solicitação de scrobbling.",
    ["Waiting to send"] = "Aguardando envio",
    ["Not saved yet"] = "Ainda não salvo",
    ["Discarded by you"] = "Descartado por você",
    ["Sending…"] = "Enviando…",
    ["waiting for Wi-Fi"] = "aguardando Wi-Fi",
    ["next try %dm"] = "próxima tentativa em %dm",
    ["sent %s"] = "enviado %s",
    ["Sync now"] = "Sincronizar agora",
    ["Account & settings"] = "Conta e ajustes",
    ["Press Back."] = "Pressione Voltar.",
    ["Account changed. Nothing changed."] = "Conta alterada. Nada foi modificado.",
    ["Account changed. Nothing discarded."] = "Conta alterada. Nada foi descartado.",
    ["Saved: %s"] = "Salvo: %s",
    ["Saved time unavailable"] = "Horário salvo indisponível",
    ["Scrobbling"] = "Scrobbling",
    ["Scrobbling: %s"] = "Scrobbling: %s",
    ["Scrobbling turned on."] = "Scrobbling ativado.",
    ["Scrobbling turned off."] = "Scrobbling desativado.",
    ["Could not save scrobbling preference. Try again."] = "Não foi possível salvar a preferência de scrobbling. Tente novamente.",
    ["This track: No music playing"] = "Esta faixa: Nenhuma música tocando",
    ["This track: Scrobbling off"] = "Esta faixa: Scrobbling desativado",
    ["This track: Reading length"] = "Esta faixa: Lendo duração",
    ["This track: Too short (<30s)"] = "Esta faixa: Muito curta (<30s)",
    ["This track: Playback paused"] = "Esta faixa: Reprodução pausada",
    ["This track: Counts after %s"] = "Esta faixa: Conta após %s",
    ["This track: This listen not counted"] = "Esta faixa: Esta reprodução não é contabilizada",
    ["This track: %s"] = "Esta faixa: %s",
    ["No track playing."] = "Nenhuma faixa em reprodução.",
    ["Status: %s"] = "Status: %s",
    ["How Scrobbling Works"] = "Como funciona o scrobbling",
    ["Tracks >= 30s only"] = "Apenas faixas >= 30s",
    ["Listened 50% or 4 min"] = "Ouvido 50% ou 4 min",
    ["Pauses do not count"] = "Pausas não contam",
    ["ListenBrainz not reachable."] = "ListenBrainz inacessível.",
    ["ListenBrainz temporarily busy."] = "O ListenBrainz está temporariamente ocupado.",
    ["Status: user token not accepted"] = "Status: token de usuário não aceito",
    ["Logged in as %s"] = "Conectado como %s",
    ["Sent to ListenBrainz"] = "Enviado para o ListenBrainz",
    ["ListenBrainz rejected this listen"] = "O ListenBrainz rejeitou esta reprodução",
    ["%d listen waiting"] = "%d reprodução em espera",
    ["%d listens waiting"] = "%d reproduções em espera",
    ["Waiting listens could not be read"] = "Não foi possível ler as reproduções em espera",
    ["Waiting listens could not be read. Nothing discarded."] = "Não foi possível ler as reproduções em espera. Nada foi descartado.",
    ["Waiting listens"] = "Reproduções em espera",
    ["No listens are waiting to send"] = "Nenhuma reprodução aguardando envio",
    ["Qualified listens send automatically."] = "Reproduções qualificadas são enviadas automaticamente.",
    ["%d listens kept for %s"] = "%d reproduções mantidas para %s",
    ["Oldest listens are sent first."] = "As reproduções mais antigas são enviadas primeiro.",
    ["Send waiting listens now"] = "Enviar reproduções em espera agora",
    ["Discard waiting listens…"] = "Descartar reproduções em espera…",
    ["Discard waiting listens (%d)"] = "Descartar reproduções em espera (%d)",
    ["Discard %d listens?"] = "Descartar %d reproduções?",
    ["Discard %d listens"] = "Descartar %d reproduções",
    ["Keep waiting listens"] = "Manter reproduções em espera",
    ["Kept waiting listens."] = "Reproduções em espera mantidas.",
    ["Waiting listens discarded."] = "Reproduções em espera descartadas.",
    ["Could not discard listens. Try again."] = "Não foi possível descartar as reproduções. Tente novamente.",
    ["Account changed. Open waiting listens again."] = "Conta alterada. Abra as reproduções em espera novamente.",
    ["Log out?"] = "Sair da conta?",
    ["Stay logged in"] = "Manter sessão iniciada",
    ["Log out %s"] = "Sair de %s",
    ["Stayed logged in."] = "Sessão mantida.",
    ["Logged out. Waiting listens are kept for this account."] = "Sessão encerrada. As reproduções em espera foram mantidas para esta conta.",
    ["Sending waiting listens…"] = "Enviando reproduções em espera…",
    ["Already sending waiting listens."] = "Já enviando as reproduções em espera.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Defina seu token de usuário do ListenBrainz antes de enviar as reproduções em espera.",
    ["Turn scrobbling on before sending waiting listens."] = "Ative o scrobbling antes de enviar as reproduções em espera.",
    ["User token: set"] = "Token de usuário: definido",
    ["Up to 100 offline listens"] = "Até 100 reproduções offline",
    ["Separate queue per account"] = "Fila separada por conta",
    ["Streams without length are not sent"] = "Transmissões sem duração não são enviadas",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Como funciona o scrobbling no ListenBrainz:\n\n1. Regra dos 30 segundos: Faixas com menos de 30 segundos não são registradas.\n\n2. Limite de reprodução: Uma reprodução é válida após metade da duração ou 4 minutos (o que ocorrer primeiro).\n\n3. Pausas e busca: O tempo pausado ou avançando não conta para o limite.\n\n4. Fila offline: Até 100 reproduções (64 KB) salvas offline e enviadas automaticamente ao conectar.\n\n5. Separação de contas: As reproduções em espera são mantidas por conta do ListenBrainz.\n\n6. Duração desconhecida: Transmissões sem duração conhecida, como a maioria das rádios, não são enviadas.\n\n7. Token: em um celular ou computador, copie seu token de usuário de listenbrainz.org/settings para um arquivo de texto no cartão SD e depois use “Ler token do cartão SD”.",
  },
  ru = {
    ["Could not open text entry. Try again."] = "Не удалось открыть ввод текста. Повторите попытку.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz не принял токен пользователя. Сохранённые прослушивания оставлены.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "Очередь ListenBrainz заполнена. Самые старые прослушивания сохранены.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "Не удалось сохранить прослушивание ListenBrainz. Сохранённые прослушивания оставлены.",
    ["Could not save the ListenBrainz token. Try again."] = "Не удалось сохранить токен ListenBrainz. Повторите попытку.",
    ["Could not log out of ListenBrainz. Try again."] = "Не удалось выйти из ListenBrainz. Повторите попытку.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Этот плеер не может отправлять прослушивания ListenBrainz. Сохранённые прослушивания оставлены.",
    ["This player cannot store a ListenBrainz token."] = "Этот плеер не может сохранить токен ListenBrainz.",
    ["That token cannot be used."] = "Этот токен нельзя использовать.",
    ["This player cannot check a ListenBrainz token."] = "Этот плеер не может проверить токен ListenBrainz.",
    ["Checking ListenBrainz token..."] = "Проверка токена ListenBrainz...",
    ["Could not reach ListenBrainz."] = "Не удалось связаться с ListenBrainz.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz не принял этот токен.",
    ["ListenBrainz token saved."] = "Токен ListenBrainz сохранён.",
    ["Logged in to ListenBrainz as %s"] = "Выполнен вход в ListenBrainz как %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Аккаунт сохранен. Нажмите «Скробблинг», чтобы включить его.",
    ["Set ListenBrainz user token"] = "Задать токен пользователя ListenBrainz",
    ["Read token from SD card"] = "Прочитать токен с SD-карты",
    ["Delete token file?"] = "Удалить файл с токеном?",
    ["Keep the file"] = "Оставить файл",
    ["Delete the file"] = "Удалить файл",
    ["Token file deleted."] = "Файл с токеном удалён.",
    ["Could not delete the token file."] = "Не удалось удалить файл с токеном.",
    ["Token file kept."] = "Файл с токеном оставлен.",
    ["No ListenBrainz token found in that file."] = "В этом файле не найден токен ListenBrainz.",
    ["Could not read that file."] = "Не удалось прочитать этот файл.",
    ["Could not open the file picker. Try again."] = "Не удалось открыть выбор файла. Повторите попытку.",
    ["ListenBrainz user token"] = "Токен пользователя ListenBrainz",
    ["Log out"] = "Выйти",
    ["Log out (%s)"] = "Выйти (%s)",
    ["ListenBrainz Scrobbler"] = "Скробблер ListenBrainz",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi выключен \u{2014} отправится при подключении",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi не подключен \u{2014} отправится при подключении",
    ["Waiting list could not be updated."] = "Не удалось обновить список ожидания.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Отправлено, но очистку списка ожидания не удалось сохранить.",
    ["Could not send scrobble request."] = "Не удалось отправить запрос скробблинга.",
    ["Waiting to send"] = "Ожидает отправки",
    ["Not saved yet"] = "Еще не сохранено",
    ["Discarded by you"] = "Отклонено вами",
    ["Sending…"] = "Отправка…",
    ["waiting for Wi-Fi"] = "ожидание Wi-Fi",
    ["next try %dm"] = "след. попытка через %dм",
    ["sent %s"] = "отправлено %s",
    ["Sync now"] = "Синхронизировать сейчас",
    ["Account & settings"] = "Аккаунт и настройки",
    ["Press Back."] = "Нажмите «Назад».",
    ["Account changed. Nothing changed."] = "Аккаунт изменился. Ничего не изменено.",
    ["Account changed. Nothing discarded."] = "Аккаунт изменился. Ничего не удалено.",
    ["Saved: %s"] = "Сохранено: %s",
    ["Saved time unavailable"] = "Время сохранения недоступно",
    ["Scrobbling"] = "Скробблинг",
    ["Scrobbling: %s"] = "Скробблинг: %s",
    ["Scrobbling turned on."] = "Скробблинг включен.",
    ["Scrobbling turned off."] = "Скробблинг выключен.",
    ["Could not save scrobbling preference. Try again."] = "Не удалось сохранить настройки скробблинга. Повторите попытку.",
    ["This track: No music playing"] = "Этот трек: Музыка не играет",
    ["This track: Scrobbling off"] = "Этот трек: Скробблинг выключен",
    ["This track: Reading length"] = "Этот трек: Определение длительности",
    ["This track: Too short (<30s)"] = "Этот трек: Слишком короткий (<30с)",
    ["This track: Playback paused"] = "Этот трек: Воспроизведение приостановлено",
    ["This track: Counts after %s"] = "Этот трек: Засчитается через %s",
    ["This track: This listen not counted"] = "Этот трек: Это прослушивание не засчитано",
    ["This track: %s"] = "Этот трек: %s",
    ["No track playing."] = "Трек не воспроизводится.",
    ["Status: %s"] = "Статус: %s",
    ["How Scrobbling Works"] = "Как работает скробблинг",
    ["Tracks >= 30s only"] = "Только треки >= 30с",
    ["Listened 50% or 4 min"] = "Прослушано 50% или 4 мин",
    ["Pauses do not count"] = "Паузы не считаются",
    ["ListenBrainz not reachable."] = "ListenBrainz недоступен.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz временно занят.",
    ["Status: user token not accepted"] = "Статус: токен пользователя не принят",
    ["Logged in as %s"] = "Вход выполнен как %s",
    ["Sent to ListenBrainz"] = "Отправлено в ListenBrainz",
    ["ListenBrainz rejected this listen"] = "ListenBrainz отклонил это прослушивание",
    ["%d listen waiting"] = "%d прослушивание ожидает",
    ["%d listens waiting"] = "%d прослушиваний ожидают",
    ["Waiting listens could not be read"] = "Не удалось прочитать ожидающие прослушивания",
    ["Waiting listens could not be read. Nothing discarded."] = "Не удалось прочитать ожидающие прослушивания. Ничего не удалено.",
    ["Waiting listens"] = "Ожидающие прослушивания",
    ["No listens are waiting to send"] = "Нет прослушиваний, ожидающих отправки",
    ["Qualified listens send automatically."] = "Подходящие прослушивания отправляются автоматически.",
    ["%d listens kept for %s"] = "%d прослушиваний сохранено для %s",
    ["Oldest listens are sent first."] = "Старые прослушивания отправляются первыми.",
    ["Send waiting listens now"] = "Отправить ожидающие прослушивания сейчас",
    ["Discard waiting listens…"] = "Удалить ожидающие прослушивания…",
    ["Discard waiting listens (%d)"] = "Удалить ожидающие прослушивания (%d)",
    ["Discard %d listens?"] = "Удалить %d прослушиваний?",
    ["Discard %d listens"] = "Удалить %d прослушиваний",
    ["Keep waiting listens"] = "Оставить ожидающие прослушивания",
    ["Kept waiting listens."] = "Ожидающие прослушивания оставлены.",
    ["Waiting listens discarded."] = "Ожидающие прослушивания удалены.",
    ["Could not discard listens. Try again."] = "Не удалось удалить прослушивания. Повторите попытку.",
    ["Account changed. Open waiting listens again."] = "Аккаунт изменился. Откройте ожидающие прослушивания снова.",
    ["Log out?"] = "Выйти?",
    ["Stay logged in"] = "Оставаться в системе",
    ["Log out %s"] = "Выйти из %s",
    ["Stayed logged in."] = "Вход сохранён.",
    ["Logged out. Waiting listens are kept for this account."] = "Выход выполнен. Ожидающие прослушивания сохранены для этого аккаунта.",
    ["Sending waiting listens…"] = "Отправка ожидающих прослушиваний…",
    ["Already sending waiting listens."] = "Ожидающие прослушивания уже отправляются.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Задайте токен пользователя ListenBrainz перед отправкой ожидающих прослушиваний.",
    ["Turn scrobbling on before sending waiting listens."] = "Включите скробблинг перед отправкой ожидающих прослушиваний.",
    ["User token: set"] = "Токен пользователя: задан",
    ["Up to 100 offline listens"] = "До 100 офлайн-прослушиваний",
    ["Separate queue per account"] = "Отдельная очередь для каждого аккаунта",
    ["Streams without length are not sent"] = "Потоки без длины не отправляются",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Как работает скробблинг ListenBrainz:\n\n1. Правило 30 секунд: Треки короче 30 секунд не скробблятся.\n\n2. Порог прослушивания: Прослушивание засчитывается после половины длины или 4 минут (что наступит раньше).\n\n3. Паузы и перемотка: Время на паузе или перемотке не учитывается в пороге.\n\n4. Офлайн-очередь: До 100 прослушиваний (64 КБ) сохраняются офлайн и отправляются при подключении.\n\n5. Разделение аккаунтов: Ожидающие прослушивания хранятся отдельно для каждого аккаунта ListenBrainz.\n\n6. Неизвестная длина: Потоки с неизвестной длиной, например большинство радио, не отправляются.\n\n7. Токен: на телефоне или компьютере скопируйте свой пользовательский токен со страницы listenbrainz.org/settings в текстовый файл на SD-карте, затем выберите «Прочитать токен с SD-карты».",
  },
  uk = {
    ["Could not open text entry. Try again."] = "Не вдалося відкрити введення тексту. Спробуйте ще раз.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz не прийняв токен користувача. Збережені прослуховування залишено.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "Черга ListenBrainz заповнена. Найстаріші прослуховування збережено.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "Не вдалося зберегти прослуховування ListenBrainz. Збережені прослуховування залишено.",
    ["Could not save the ListenBrainz token. Try again."] = "Не вдалося зберегти токен ListenBrainz. Спробуйте ще раз.",
    ["Could not log out of ListenBrainz. Try again."] = "Не вдалося вийти з ListenBrainz. Спробуйте ще раз.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Цей плеєр не може надсилати прослуховування ListenBrainz. Збережені прослуховування залишено.",
    ["This player cannot store a ListenBrainz token."] = "Цей плеєр не може зберегти токен ListenBrainz.",
    ["That token cannot be used."] = "Цей токен не можна використати.",
    ["This player cannot check a ListenBrainz token."] = "Цей плеєр не може перевірити токен ListenBrainz.",
    ["Checking ListenBrainz token..."] = "Перевірка токена ListenBrainz...",
    ["Could not reach ListenBrainz."] = "Не вдалося з'єднатися з ListenBrainz.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz не прийняв цей токен.",
    ["ListenBrainz token saved."] = "Токен ListenBrainz збережено.",
    ["Logged in to ListenBrainz as %s"] = "Увійшли до ListenBrainz як %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Обліковий запис збережено. Торкніться «Скробблінг», щоб увімкнути.",
    ["Set ListenBrainz user token"] = "Встановити токен користувача ListenBrainz",
    ["Read token from SD card"] = "Прочитати токен з SD-картки",
    ["Delete token file?"] = "Видалити файл із токеном?",
    ["Keep the file"] = "Залишити файл",
    ["Delete the file"] = "Видалити файл",
    ["Token file deleted."] = "Файл із токеном видалено.",
    ["Could not delete the token file."] = "Не вдалося видалити файл із токеном.",
    ["Token file kept."] = "Файл із токеном залишено.",
    ["No ListenBrainz token found in that file."] = "У цьому файлі не знайдено токен ListenBrainz.",
    ["Could not read that file."] = "Не вдалося прочитати цей файл.",
    ["Could not open the file picker. Try again."] = "Не вдалося відкрити вибір файлу. Повторіть спробу.",
    ["ListenBrainz user token"] = "Токен користувача ListenBrainz",
    ["Log out"] = "Вийти",
    ["Log out (%s)"] = "Вийти (%s)",
    ["ListenBrainz Scrobbler"] = "Скроблер ListenBrainz",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi вимкнено \u{2014} надішлеться після підключення",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi не підключено \u{2014} надішлеться після підключення",
    ["Waiting list could not be updated."] = "Не вдалося оновити список очікування.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Надіслано, але очищення списку очікування не вдалося зберегти.",
    ["Could not send scrobble request."] = "Не вдалося надіслати запит на скробблінг.",
    ["Waiting to send"] = "Очікує на надсилання",
    ["Not saved yet"] = "Ще не збережено",
    ["Discarded by you"] = "Відкинуто вами",
    ["Sending…"] = "Надсилання…",
    ["waiting for Wi-Fi"] = "очікування Wi-Fi",
    ["next try %dm"] = "наст. спроба через %dхв",
    ["sent %s"] = "надіслано %s",
    ["Sync now"] = "Синхронізувати зараз",
    ["Account & settings"] = "Обліковий запис і налаштування",
    ["Press Back."] = "Натисніть «Назад».",
    ["Account changed. Nothing changed."] = "Обліковий запис змінився. Нічого не змінено.",
    ["Account changed. Nothing discarded."] = "Обліковий запис змінився. Нічого не відкинуто.",
    ["Saved: %s"] = "Збережено: %s",
    ["Saved time unavailable"] = "Час збереження недоступний",
    ["Scrobbling"] = "Скробблінг",
    ["Scrobbling: %s"] = "Скробблінг: %s",
    ["Scrobbling turned on."] = "Скробблінг увімкнено.",
    ["Scrobbling turned off."] = "Скробблінг вимкнено.",
    ["Could not save scrobbling preference. Try again."] = "Не вдалося зберегти налаштування скробблінгу. Спробуйте знову.",
    ["This track: No music playing"] = "Цей трек: Музика не відтворюється",
    ["This track: Scrobbling off"] = "Цей трек: Скробблінг вимкнено",
    ["This track: Reading length"] = "Цей трек: Визначення тривалості",
    ["This track: Too short (<30s)"] = "Цей трек: Занадто короткий (<30с)",
    ["This track: Playback paused"] = "Цей трек: Відтворення призупинено",
    ["This track: Counts after %s"] = "Цей трек: Зарахується через %s",
    ["This track: This listen not counted"] = "Цей трек: Це прослуховування не зараховано",
    ["This track: %s"] = "Цей трек: %s",
    ["No track playing."] = "Жоден трек не відтворюється.",
    ["Status: %s"] = "Статус: %s",
    ["How Scrobbling Works"] = "Як працює скробблінг",
    ["Tracks >= 30s only"] = "Лише треки >= 30с",
    ["Listened 50% or 4 min"] = "Прослухано 50% або 4 хв",
    ["Pauses do not count"] = "Паузи не враховуються",
    ["ListenBrainz not reachable."] = "ListenBrainz недосяжний.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz тимчасово зайнятий.",
    ["Status: user token not accepted"] = "Статус: токен користувача не прийнято",
    ["Logged in as %s"] = "Увійшли як %s",
    ["Sent to ListenBrainz"] = "Надіслано до ListenBrainz",
    ["ListenBrainz rejected this listen"] = "ListenBrainz відхилив це прослуховування",
    ["%d listen waiting"] = "%d прослуховування очікує",
    ["%d listens waiting"] = "%d прослуховувань очікують",
    ["Waiting listens could not be read"] = "Не вдалося прочитати очікувані прослуховування",
    ["Waiting listens could not be read. Nothing discarded."] = "Не вдалося прочитати очікувані прослуховування. Нічого не відкинуто.",
    ["Waiting listens"] = "Очікувані прослуховування",
    ["No listens are waiting to send"] = "Немає прослуховувань, що очікують на надсилання",
    ["Qualified listens send automatically."] = "Відповідні прослуховування надсилаються автоматично.",
    ["%d listens kept for %s"] = "%d прослуховувань збережено для %s",
    ["Oldest listens are sent first."] = "Найстаріші прослуховування надсилаються першими.",
    ["Send waiting listens now"] = "Надіслати очікувані прослуховування зараз",
    ["Discard waiting listens…"] = "Відкинути очікувані прослуховування…",
    ["Discard waiting listens (%d)"] = "Відкинути очікувані прослуховування (%d)",
    ["Discard %d listens?"] = "Відкинути %d прослуховувань?",
    ["Discard %d listens"] = "Відкинути %d прослуховувань",
    ["Keep waiting listens"] = "Залишити очікувані прослуховування",
    ["Kept waiting listens."] = "Очікувані прослуховування залишено.",
    ["Waiting listens discarded."] = "Очікувані прослуховування відкинуто.",
    ["Could not discard listens. Try again."] = "Не вдалося відкинути прослуховування. Спробуйте знову.",
    ["Account changed. Open waiting listens again."] = "Обліковий запис змінився. Відкрийте очікувані прослуховування знову.",
    ["Log out?"] = "Вийти?",
    ["Stay logged in"] = "Залишатися в системі",
    ["Log out %s"] = "Вийти з %s",
    ["Stayed logged in."] = "Вхід збережено.",
    ["Logged out. Waiting listens are kept for this account."] = "Вихід виконано. Очікувані прослуховування збережено для цього облікового запису.",
    ["Sending waiting listens…"] = "Надсилання очікуваних прослуховувань…",
    ["Already sending waiting listens."] = "Очікувані прослуховування вже надсилаються.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Встановіть токен користувача ListenBrainz перед надсиланням очікуваних прослуховувань.",
    ["Turn scrobbling on before sending waiting listens."] = "Увімкніть скробблінг перед надсиланням очікуваних прослуховувань.",
    ["User token: set"] = "Токен користувача: встановлено",
    ["Up to 100 offline listens"] = "До 100 офлайн-прослуховувань",
    ["Separate queue per account"] = "Окрема черга для кожного облікового запису",
    ["Streams without length are not sent"] = "Потоки без тривалості не надсилаються",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Як працює скробблінг ListenBrainz:\n\n1. Правило 30 секунд: Треки менше 30 секунд не скроббляться.\n\n2. Поріг прослуховування: Прослуховування зараховується після половини тривалості або 4 хвилин (що настане раніше).\n\n3. Паузи та перемотування: Час на паузі або перемотуванні не враховується.\n\n4. Офлайн-черга: До 100 прослуховувань (64 КБ) зберігаються офлайн і надсилаються при підключенні.\n\n5. Розділення акаунтів: Очікувані прослуховування зберігаються окремо для кожного облікового запису ListenBrainz.\n\n6. Невідома тривалість: Потоки з невідомою тривалістю, як-от більшість радіо, не надсилаються.\n\n7. Токен: на телефоні або комп’ютері скопіюйте свій токен користувача зі сторінки listenbrainz.org/settings у текстовий файл на SD-картці, потім виберіть «Прочитати токен з SD-картки».",
  },
  vi = {
    ["Could not open text entry. Try again."] = "Không thể mở mục nhập văn bản. Hãy thử lại.",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz không chấp nhận mã người dùng. Các lượt nghe đã lưu vẫn được giữ.",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "Hàng đợi ListenBrainz đã đầy. Các lượt nghe cũ nhất vẫn được giữ.",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "Không thể lưu lượt nghe ListenBrainz đó. Các lượt nghe đã lưu vẫn được giữ.",
    ["Could not save the ListenBrainz token. Try again."] = "Không thể lưu mã ListenBrainz. Hãy thử lại.",
    ["Could not log out of ListenBrainz. Try again."] = "Không thể đăng xuất khỏi ListenBrainz. Hãy thử lại.",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "Máy nghe nhạc này không thể gửi lượt nghe ListenBrainz. Các lượt nghe đã lưu vẫn được giữ.",
    ["This player cannot store a ListenBrainz token."] = "Máy nghe nhạc này không thể lưu mã ListenBrainz.",
    ["That token cannot be used."] = "Không thể dùng mã đó.",
    ["This player cannot check a ListenBrainz token."] = "Máy nghe nhạc này không thể kiểm tra mã ListenBrainz.",
    ["Checking ListenBrainz token..."] = "Đang kiểm tra mã ListenBrainz...",
    ["Could not reach ListenBrainz."] = "Không thể kết nối tới ListenBrainz.",
    ["ListenBrainz did not accept that token."] = "ListenBrainz không chấp nhận mã đó.",
    ["ListenBrainz token saved."] = "Đã lưu mã ListenBrainz.",
    ["Logged in to ListenBrainz as %s"] = "Đã đăng nhập ListenBrainz với tên %s",
    ["Account saved. Tap Scrobbling to turn it on."] = "Đã lưu tài khoản. Nhấn vào Scrobble để bật.",
    ["Set ListenBrainz user token"] = "Đặt mã người dùng ListenBrainz",
    ["Read token from SD card"] = "Đọc mã từ thẻ SD",
    ["Delete token file?"] = "Xóa tệp mã?",
    ["Keep the file"] = "Giữ tệp",
    ["Delete the file"] = "Xóa tệp",
    ["Token file deleted."] = "Đã xóa tệp mã.",
    ["Could not delete the token file."] = "Không thể xóa tệp mã.",
    ["Token file kept."] = "Đã giữ tệp mã.",
    ["No ListenBrainz token found in that file."] = "Không tìm thấy mã ListenBrainz trong tệp đó.",
    ["Could not read that file."] = "Không thể đọc tệp đó.",
    ["Could not open the file picker. Try again."] = "Không thể mở trình chọn tệp. Thử lại.",
    ["ListenBrainz user token"] = "Mã người dùng ListenBrainz",
    ["Log out"] = "Đăng xuất",
    ["Log out (%s)"] = "Đăng xuất (%s)",
    ["ListenBrainz Scrobbler"] = "Trình scrobble ListenBrainz",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi tắt \u{2014} sẽ gửi khi kết nối",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Chưa kết nối Wi-Fi \u{2014} sẽ gửi khi kết nối",
    ["Waiting list could not be updated."] = "Không thể cập nhật danh sách chờ.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Đã gửi, nhưng không thể lưu việc dọn dẹp danh sách chờ.",
    ["Could not send scrobble request."] = "Không thể gửi yêu cầu scrobble.",
    ["Waiting to send"] = "Đang chờ gửi",
    ["Not saved yet"] = "Chưa lưu",
    ["Discarded by you"] = "Bạn đã loại bỏ",
    ["Sending…"] = "Đang gửi…",
    ["waiting for Wi-Fi"] = "đang chờ Wi-Fi",
    ["next try %dm"] = "thử lại sau %d phút",
    ["sent %s"] = "đã gửi lúc %s",
    ["Sync now"] = "Đồng bộ ngay",
    ["Account & settings"] = "Tài khoản & cài đặt",
    ["Press Back."] = "Nhấn Quay lại.",
    ["Account changed. Nothing changed."] = "Tài khoản đã đổi. Không có gì thay đổi.",
    ["Account changed. Nothing discarded."] = "Tài khoản đã đổi. Chưa loại bỏ gì.",
    ["Saved: %s"] = "Đã lưu: %s",
    ["Saved time unavailable"] = "Không có thời gian đã lưu",
    ["Scrobbling"] = "Scrobble",
    ["Scrobbling: %s"] = "Scrobble: %s",
    ["Scrobbling turned on."] = "Đã bật scrobble.",
    ["Scrobbling turned off."] = "Đã tắt scrobble.",
    ["Could not save scrobbling preference. Try again."] = "Không thể lưu tùy chọn scrobble. Hãy thử lại.",
    ["This track: No music playing"] = "Bài này: Không phát nhạc",
    ["This track: Scrobbling off"] = "Bài này: Tắt scrobble",
    ["This track: Reading length"] = "Bài này: Đang đọc thời lượng",
    ["This track: Too short (<30s)"] = "Bài này: Quá ngắn (<30s)",
    ["This track: Playback paused"] = "Bài này: Đã tạm dừng phát",
    ["This track: Counts after %s"] = "Bài này: Tính sau %s",
    ["This track: This listen not counted"] = "Bài này: Lượt nghe này không được tính",
    ["This track: %s"] = "Bài này: %s",
    ["No track playing."] = "Không có bài hát nào đang phát.",
    ["Status: %s"] = "Trạng thái: %s",
    ["How Scrobbling Works"] = "Cách hoạt động của Scrobble",
    ["Tracks >= 30s only"] = "Chỉ bài hát >= 30s",
    ["Listened 50% or 4 min"] = "Đã nghe 50% hoặc 4 phút",
    ["Pauses do not count"] = "Tạm dừng không được tính",
    ["ListenBrainz not reachable."] = "Không thể kết nối với ListenBrainz.",
    ["ListenBrainz temporarily busy."] = "ListenBrainz tạm thời bận.",
    ["Status: user token not accepted"] = "Trạng thái: mã người dùng không được chấp nhận",
    ["Logged in as %s"] = "Đã đăng nhập với tên %s",
    ["Sent to ListenBrainz"] = "Đã gửi tới ListenBrainz",
    ["ListenBrainz rejected this listen"] = "ListenBrainz đã từ chối lượt nghe này",
    ["%d listen waiting"] = "%d lượt nghe đang chờ",
    ["%d listens waiting"] = "%d lượt nghe đang chờ",
    ["Waiting listens could not be read"] = "Không thể đọc các lượt nghe đang chờ",
    ["Waiting listens could not be read. Nothing discarded."] = "Không thể đọc các lượt nghe chờ. Chưa loại bỏ gì.",
    ["Waiting listens"] = "Lượt nghe đang chờ",
    ["No listens are waiting to send"] = "Không có lượt nghe nào đang chờ gửi",
    ["Qualified listens send automatically."] = "Các lượt nghe đủ điều kiện sẽ gửi tự động.",
    ["%d listens kept for %s"] = "%d lượt nghe giữ cho %s",
    ["Oldest listens are sent first."] = "Các lượt nghe cũ nhất được gửi trước.",
    ["Send waiting listens now"] = "Gửi các lượt nghe đang chờ ngay",
    ["Discard waiting listens…"] = "Loại bỏ các lượt nghe đang chờ…",
    ["Discard waiting listens (%d)"] = "Loại bỏ các lượt nghe đang chờ (%d)",
    ["Discard %d listens?"] = "Loại bỏ %d lượt nghe?",
    ["Discard %d listens"] = "Loại bỏ %d lượt nghe",
    ["Keep waiting listens"] = "Giữ các lượt nghe đang chờ",
    ["Kept waiting listens."] = "Đã giữ các lượt nghe đang chờ.",
    ["Waiting listens discarded."] = "Đã loại bỏ các lượt nghe đang chờ.",
    ["Could not discard listens. Try again."] = "Không thể loại bỏ các lượt nghe. Hãy thử lại.",
    ["Account changed. Open waiting listens again."] = "Tài khoản đã đổi. Hãy mở lại các lượt nghe chờ.",
    ["Log out?"] = "Đăng xuất?",
    ["Stay logged in"] = "Tiếp tục đăng nhập",
    ["Log out %s"] = "Đăng xuất %s",
    ["Stayed logged in."] = "Đã giữ đăng nhập.",
    ["Logged out. Waiting listens are kept for this account."] = "Đã đăng xuất. Các lượt nghe đang chờ được giữ lại cho tài khoản này.",
    ["Sending waiting listens…"] = "Đang gửi các lượt nghe đang chờ…",
    ["Already sending waiting listens."] = "Đang gửi các lượt nghe chờ rồi.",
    ["Set your ListenBrainz user token before sending waiting listens."] = "Hãy đặt mã người dùng ListenBrainz trước khi gửi các lượt nghe đang chờ.",
    ["Turn scrobbling on before sending waiting listens."] = "Hãy bật scrobble trước khi gửi các lượt nghe đang chờ.",
    ["User token: set"] = "Mã người dùng: đã đặt",
    ["Up to 100 offline listens"] = "Tối đa 100 lượt nghe ngoại tuyến",
    ["Separate queue per account"] = "Hàng đợi riêng theo tài khoản",
    ["Streams without length are not sent"] = "Luồng không rõ độ dài sẽ không được gửi",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "Cách hoạt động của Scrobble ListenBrainz:\n\n1. Quy tắc 30 giây: Bài hát dưới 30 giây không được scrobble.\n\n2. Ngưỡng nghe: Lượt nghe hợp lệ sau một nửa thời lượng hoặc 4 phút (tùy điều kiện nào đến trước).\n\n3. Tạm dừng & Tua: Thời gian tạm dừng hoặc tua không được tính vào ngưỡng.\n\n4. Hàng đợi ngoại tuyến: Lưu tối đa 100 lượt nghe (64 KB) ngoại tuyến và tự động gửi khi có kết nối.\n\n5. Tách biệt tài khoản: Các lượt nghe chờ được giữ riêng theo từng tài khoản ListenBrainz.\n\n6. Độ dài không xác định: Luồng phát không rõ độ dài, như hầu hết đài radio, sẽ không được gửi.\n\n7. Mã: trên điện thoại hoặc máy tính, hãy sao chép mã người dùng từ listenbrainz.org/settings vào một tệp văn bản trên thẻ SD, rồi dùng “Đọc mã từ thẻ SD”.",
  },
  zh_CN = {
    ["Could not open text entry. Try again."] = "无法打开文本输入。请重试。",
    ["ListenBrainz did not accept the user token. Saved listens are kept."] = "ListenBrainz 未接受该用户令牌。已保存的收听记录已保留。",
    ["ListenBrainz queue is full. The oldest saved listens were kept."] = "ListenBrainz 队列已满。最早保存的收听记录已保留。",
    ["Could not save that ListenBrainz listen. Saved listens were kept."] = "无法保存该 ListenBrainz 收听记录。已保存的记录已保留。",
    ["Could not save the ListenBrainz token. Try again."] = "无法保存 ListenBrainz 令牌。请重试。",
    ["Could not log out of ListenBrainz. Try again."] = "无法退出 ListenBrainz。请重试。",
    ["This player cannot send ListenBrainz listens. Saved listens are kept."] = "此播放器无法发送 ListenBrainz 收听记录。已保存的记录已保留。",
    ["This player cannot store a ListenBrainz token."] = "此播放器无法存储 ListenBrainz 令牌。",
    ["That token cannot be used."] = "该令牌无法使用。",
    ["This player cannot check a ListenBrainz token."] = "此播放器无法检查 ListenBrainz 令牌。",
    ["Checking ListenBrainz token..."] = "正在检查 ListenBrainz 令牌...",
    ["Could not reach ListenBrainz."] = "无法连接到 ListenBrainz。",
    ["ListenBrainz did not accept that token."] = "ListenBrainz 未接受该令牌。",
    ["ListenBrainz token saved."] = "ListenBrainz 令牌已保存。",
    ["Logged in to ListenBrainz as %s"] = "已作为 %s 登录 ListenBrainz",
    ["Account saved. Tap Scrobbling to turn it on."] = "账号已保存。点按“记录播放”以开启。",
    ["Set ListenBrainz user token"] = "设置 ListenBrainz 用户令牌",
    ["Read token from SD card"] = "从 SD 卡读取令牌",
    ["Delete token file?"] = "删除令牌文件？",
    ["Keep the file"] = "保留文件",
    ["Delete the file"] = "删除文件",
    ["Token file deleted."] = "令牌文件已删除。",
    ["Could not delete the token file."] = "无法删除令牌文件。",
    ["Token file kept."] = "令牌文件已保留。",
    ["No ListenBrainz token found in that file."] = "该文件中未找到 ListenBrainz 令牌。",
    ["Could not read that file."] = "无法读取该文件。",
    ["Could not open the file picker. Try again."] = "无法打开文件选择器。请重试。",
    ["ListenBrainz user token"] = "ListenBrainz 用户令牌",
    ["Log out"] = "退出登录",
    ["Log out (%s)"] = "退出登录 (%s)",
    ["ListenBrainz Scrobbler"] = "ListenBrainz 听歌记录器",
    ["Wi-Fi off \u{2014} will send when connected"] = "Wi-Fi 已关闭 \u{2014} 连接后将发送",
    ["Wi-Fi not connected \u{2014} will send when connected"] = "Wi-Fi 未连接 \u{2014} 连接后将发送",
    ["Waiting list could not be updated."] = "无法更新等待列表。",
    ["Sent, but waiting-list cleanup could not be saved."] = "已发送，但无法保存等待列表清理。",
    ["Could not send scrobble request."] = "无法发送记录请求。",
    ["Waiting to send"] = "等待发送",
    ["Not saved yet"] = "尚未保存",
    ["Discarded by you"] = "已由你放弃",
    ["Sending…"] = "正在发送…",
    ["waiting for Wi-Fi"] = "等待 Wi-Fi",
    ["next try %dm"] = "将在 %d 分钟后重试",
    ["sent %s"] = "已发送于 %s",
    ["Sync now"] = "立即同步",
    ["Account & settings"] = "账号与设置",
    ["Press Back."] = "按返回。",
    ["Account changed. Nothing changed."] = "账号已更改。未做任何变更。",
    ["Account changed. Nothing discarded."] = "账号已更改。未丢弃任何内容。",
    ["Saved: %s"] = "已保存：%s",
    ["Saved time unavailable"] = "保存时间不可用",
    ["Scrobbling"] = "记录播放",
    ["Scrobbling: %s"] = "记录播放：%s",
    ["Scrobbling turned on."] = "记录功能已开启。",
    ["Scrobbling turned off."] = "记录功能已关闭。",
    ["Could not save scrobbling preference. Try again."] = "无法保存记录播放偏好设置。请重试。",
    ["This track: No music playing"] = "当前曲目：未播放音乐",
    ["This track: Scrobbling off"] = "当前曲目：记录已关闭",
    ["This track: Reading length"] = "当前曲目：正在读取时长",
    ["This track: Too short (<30s)"] = "当前曲目：太短 (<30秒)",
    ["This track: Playback paused"] = "当前曲目：播放已暂停",
    ["This track: Counts after %s"] = "当前曲目：播放达到 %s 后计入",
    ["This track: This listen not counted"] = "当前曲目：此次聆听不计入",
    ["This track: %s"] = "当前曲目：%s",
    ["No track playing."] = "没有正在播放的曲目。",
    ["Status: %s"] = "状态：%s",
    ["How Scrobbling Works"] = "记录功能运作方式",
    ["Tracks >= 30s only"] = "仅限 >= 30 秒的曲目",
    ["Listened 50% or 4 min"] = "播放满 50% 或 4 分钟",
    ["Pauses do not count"] = "暂停不计入",
    ["ListenBrainz not reachable."] = "无法连接到 ListenBrainz。",
    ["ListenBrainz temporarily busy."] = "ListenBrainz 暂时繁忙。",
    ["Status: user token not accepted"] = "状态：用户令牌未被接受",
    ["Logged in as %s"] = "已作为 %s 登录",
    ["Sent to ListenBrainz"] = "已发送至 ListenBrainz",
    ["ListenBrainz rejected this listen"] = "ListenBrainz 拒绝了此收听记录",
    ["%d listen waiting"] = "%d 条收听记录等待中",
    ["%d listens waiting"] = "%d 条收听记录等待中",
    ["Waiting listens could not be read"] = "无法读取等待中的收听记录",
    ["Waiting listens could not be read. Nothing discarded."] = "无法读取等待中的收听记录。未丢弃任何内容。",
    ["Waiting listens"] = "等待中的收听记录",
    ["No listens are waiting to send"] = "没有等待发送的收听记录",
    ["Qualified listens send automatically."] = "符合条件的收听记录将自动发送。",
    ["%d listens kept for %s"] = "%d 条收听记录已为 %s 保留",
    ["Oldest listens are sent first."] = "较早的收听记录将优先发送。",
    ["Send waiting listens now"] = "立即发送等待中的收听记录",
    ["Discard waiting listens…"] = "丢弃等待中的收听记录…",
    ["Discard waiting listens (%d)"] = "丢弃等待中的收听记录 (%d)",
    ["Discard %d listens?"] = "丢弃 %d 条收听记录？",
    ["Discard %d listens"] = "丢弃 %d 条收听记录",
    ["Keep waiting listens"] = "保留等待中的收听记录",
    ["Kept waiting listens."] = "已保留等待中的收听记录。",
    ["Waiting listens discarded."] = "已丢弃等待中的收听记录。",
    ["Could not discard listens. Try again."] = "无法丢弃收听记录。请重试。",
    ["Account changed. Open waiting listens again."] = "账号已更改。请重新打开等待中的收听记录。",
    ["Log out?"] = "退出登录？",
    ["Stay logged in"] = "保持登录状态",
    ["Log out %s"] = "退出登录 %s",
    ["Stayed logged in."] = "已保持登录状态。",
    ["Logged out. Waiting listens are kept for this account."] = "已退出登录。此账号的等待收听记录已保留。",
    ["Sending waiting listens…"] = "正在发送等待中的收听记录…",
    ["Already sending waiting listens."] = "已经在发送等待中的收听记录。",
    ["Set your ListenBrainz user token before sending waiting listens."] = "发送等待中的收听记录前请先设置 ListenBrainz 用户令牌。",
    ["Turn scrobbling on before sending waiting listens."] = "发送等待中的收听记录前请先开启记录。",
    ["User token: set"] = "用户令牌：已设置",
    ["Up to 100 offline listens"] = "最多 100 条离线收听记录",
    ["Separate queue per account"] = "每个账号独立队列",
    ["Streams without length are not sent"] = "无时长的流媒体不会被发送",
    ["How ListenBrainz Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card."] = "ListenBrainz 记录收听的运作方式：\n\n1. 30 秒规则：短于 30 秒的曲目不予记录。\n\n2. 聆听阈值：播放达到曲目时长的一半或 4 分钟（以先到者为准）即视为有效收听。\n\n3. 暂停与快进：暂停或快进跳转的时间不计入阈值。\n\n4. 离线队列：离线最多保存 100 条收听记录（64 KB），连接网络后自动发送。\n\n5. 账号独立：等待中的收听记录按 ListenBrainz 账号分别保留。\n\n6. 时长未知：时长未知的流媒体（如大多数电台）不会被发送。\n\n7. 令牌：在手机或电脑上，从 listenbrainz.org/settings 复制你的用户令牌，粘贴到 SD 卡上的文本文件中，然后使用“从 SD 卡读取令牌”。",
  },
}
local function tr(s)
  return plugin.tr(s, T)
end

-- ListenBrainz scrobbler. The user token lives only in plugin.secrets.
-- Playback state and the waiting listens live in plugin.storage, kept per
-- ListenBrainz account so they survive logging out.
-- Listens follow ListenBrainz's rule: at least 30 seconds long, and played
-- for half the track or 4 minutes, whichever is less. Pauses and forward
-- seeks do not count. Unknown-duration streams (typical radio) are skipped.

local VALIDATE_URL = "https://api.listenbrainz.org/1/validate-token"
local SUBMIT_URL = "https://api.listenbrainz.org/1/submit-listens"
local CLIENT_NAME = "Compas"
local CLIENT_VERSION = PLUGIN_VERSION
local QUEUE_MAX_RECORDS = 100
local QUEUE_MAX_BYTES = 65536
local MAX_BACKOFF = 300
local USER_AGENT = "Compas/1.0"
local REQUEST_TIMEOUTS = { connect_timeout_ms = 8000, read_timeout_ms = 12000, total_timeout_ms = 20000 }

-- Status texts. They double as translation keys.
local NETWORK_ERROR = "ListenBrainz not reachable."
local BUSY_ERROR = "ListenBrainz temporarily busy."
local LIST_ERROR = "Waiting list could not be updated."
local CLEANUP_ERROR = "Sent, but waiting-list cleanup could not be saved."
local SEND_ERROR = "Could not send scrobble request."
local OFFLINE_OFF = "Wi-Fi off \u{2014} will send when connected"
local OFFLINE_NO_LINK = "Wi-Fi not connected \u{2014} will send when connected"
local DELIVERY_WAITING = "Waiting to send"
local DELIVERY_SENT = "Sent to ListenBrainz"
local DELIVERY_REJECTED = "ListenBrainz rejected this listen"
local DELIVERY_UNSAVED = "Not saved yet"
local DELIVERY_DISCARDED = "Discarded by you"

local can_secrets = plugin.has_capability("storage.secrets") and plugin.has_capability("storage.secrets_get")
local can_http = plugin.has_capability("network.http.async")
local can_json = plugin.has_capability("data.json")
local can_pick = plugin.has_capability("ui.file_picker") and plugin.pick_file ~= nil
local can_delete = plugin.has_capability("filesystem.file_ops") and plugin.file_delete ~= nil

local state = {
  enabled = plugin.storage.get("enabled", "0") == "1",
  user_name = nil, -- set from the account record below
}

-- The last account that logged in. Its waiting listens outlive a log out.
local last_user = plugin.storage.get("last_user")
if last_user == "" then last_user = nil end

local auth_hold = plugin.storage.get("auth_hold") == "1"
local account_generation = 1
local validation_generation = 0
local failures, next_sync_at = 0, 0
-- ListenBrainz's Retry-After: nothing resets it early.
local rate_limited_until = 0
local last_failure_network = false
local last_error = nil
local inflight = nil
local current = nil
local queue_full_told = false
local queue_write_told = false
local missing_api_told = false
local refresh_main_list = function() end
local current_main_handle = nil
local main_refresh_pending = false

local function trim(value)
  return (tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function clip(value)
  local text = trim(value)
  if #text > 200 then text = text:sub(1, 200) end
  return text
end

local function truncate(value, max_len)
  local text = tostring(value or ""):gsub("%c", " ")
  if #text <= max_len then return text end
  local cut = max_len - 1
  while cut > 0 do
    local next_byte = text:byte(cut + 1)
    if not next_byte or next_byte < 128 or next_byte > 191 then break end
    cut = cut - 1
  end
  return text:sub(1, cut) .. "…"
end

local function format_time(seconds)
  seconds = math.max(0, math.floor(seconds or 0))
  return string.format("%d:%02d", seconds // 60, seconds % 60)
end

local function format_last_sent(ts)
  ts = tonumber(ts)
  if not ts or ts <= 0 then return nil end
  local fmt = (os.time() - ts) > 86400 and "%m-%d %H:%M" or "%H:%M"
  local ok, text = pcall(os.date, fmt, ts)
  return ok and text or nil
end

local function url_encode(value)
  return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

local function url_decode(value)
  return (value or ""):gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
end

-- The token and the account it belongs to are one secret, "name<TAB>token",
-- so a write leaves either the old pair or the new one, never a mix. 1.1 kept
-- the token alone (user_token) and the name in storage; that is still read.
local function read_account()
  if not can_secrets then return nil, nil end
  local record = plugin.secrets.get("account")
  if type(record) == "string" then
    local name, token = record:match("^([^\t]*)\t(.+)$")
    if token then return token, name ~= "" and name or nil end
  end
  local token = plugin.secrets.get("user_token")
  if type(token) ~= "string" or token == "" then return nil, nil end
  local name = plugin.storage.get("user_name")
  return token, (type(name) == "string" and name ~= "") and name or nil
end

local function current_token()
  return (read_account())
end

-- Stores the pair, or logs out with nil. A write can land and still return
-- false, so success is what storage holds afterwards.
local function save_account(token, name)
  if token then
    plugin.secrets.set("account", (name or "") .. "\t" .. token)
    local stored_token, stored_name = read_account()
    if stored_token ~= token or stored_name ~= name then return false end
  else
    plugin.secrets.delete("account")
    plugin.secrets.delete("user_token")
    if read_account() then return false end
  end
  -- The 1.1 copies are no longer read once the record holds the account.
  plugin.secrets.delete("user_token")
  plugin.storage.delete("user_name")
  return true
end

local function remember_user(name)
  state.user_name = name
  if name and name ~= last_user then
    last_user = name
    plugin.storage.set("last_user", name)
  end
end
remember_user(select(2, read_account()))

local function token_shape_ok(token)
  return type(token) == "string" and #token >= 10 and #token <= 200 and token:match("^[%w%-%.%_%~]+$") ~= nil
end

local function save_enabled()
  return plugin.storage.set("enabled", state.enabled and "1" or "0") == true
end

local function show_input(title, callback)
  local ok = plugin.show_text_input(title, nil, true, callback)
  if not ok then plugin.show_toast(tr("Could not open text entry. Try again.")) end
  return ok
end

local function encode_json(value)
  if not can_json then return nil, "json" end
  return plugin.json_encode(value)
end

local function decode_json(text)
  if not can_json or type(text) ~= "string" then return nil, "json" end
  return plugin.json_decode(text)
end

local function is_active()
  return plugin.is_playing() and not plugin.is_paused()
end

-- Network awareness (API 18). Players without it keep plain backoff.
local function network_state()
  if type(plugin.network_status) ~= "function" then return nil end
  if not plugin.has_capability("network.status") then return nil end
  local ok, st = pcall(plugin.network_status)
  if ok and type(st) == "table" then return st end
  return nil
end

-- Wi-Fi switched off: the one state that stays accurate with the screen off,
-- so sends are hard-skipped.
local function wifi_disabled()
  local st = network_state()
  return st ~= nil and st.wifi_enabled == false
end

-- Wi-Fi on but not associated. This can be stale while the screen is off, so
-- it never blocks a send; it only stops failures from growing the backoff.
local function link_down()
  local st = network_state()
  return st ~= nil and st.wifi_enabled ~= false and st.connected == false
end

local function offline_text()
  if wifi_disabled() then return tr(OFFLINE_OFF) end
  return tr(OFFLINE_NO_LINK)
end

-- Waiting listens are stored per account: the user name, or the token while
-- no name is known yet (the key older versions used).
local function queue_id(token)
  if state.user_name then return plugin.md5(state.user_name:lower()) end
  if token then return plugin.md5(token) end
  if last_user then return plugin.md5(last_user:lower()) end
  return nil
end

local function queue_key(id)
  return "queue_" .. id
end

local function sent_key(id)
  return "sent_" .. id
end

local function format_line(item)
  return table.concat({
    item.id,
    tostring(item.listened_at),
    tostring(item.duration_ms),
    item.hold == 1 and "1" or "0",
    url_encode(item.artist),
    url_encode(item.track),
    url_encode(item.release or ""),
  }, "\t")
end

local function parse_line(line)
  local id, timestamp, duration, hold, artist, track, release =
    line:match("^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)$")
  timestamp, duration = tonumber(timestamp), tonumber(duration)
  if not id or id == "" or not timestamp or timestamp <= 0 or not duration or duration <= 0 then
    return nil
  end
  artist, track, release = url_decode(artist), url_decode(track), url_decode(release)
  if artist == "" or track == "" then return nil end
  return {
    id = id,
    listened_at = timestamp,
    duration_ms = duration,
    hold = hold == "1" and 1 or 0,
    artist = artist,
    track = track,
    release = release,
  }
end

-- A line that does not parse is kept verbatim. Saving never drops those bytes.
local function load_queue(key)
  local raw = plugin.storage.get(key, "")
  if type(raw) ~= "string" or #raw > QUEUE_MAX_BYTES then return nil end
  local items, kept = {}, {}
  if raw == "" then return items, kept end
  for line in raw:gmatch("([^\n]+)") do
    local item = parse_line(line)
    if item then
      items[#items + 1] = item
      if #items > QUEUE_MAX_RECORDS then return nil end
    else
      kept[#kept + 1] = line
    end
  end
  return items, kept
end

-- The stored text for a queue, or nil when it would break a limit.
local function queue_raw(items, kept)
  if #items > QUEUE_MAX_RECORDS then return nil end
  local lines = {}
  for i = 1, #kept do lines[#lines + 1] = kept[i] end
  for i = 1, #items do lines[#lines + 1] = format_line(items[i]) end
  local raw = table.concat(lines, "\n")
  if #raw > QUEUE_MAX_BYTES then return nil end
  return raw
end

local function save_queue(key, items, kept)
  local raw = queue_raw(items, kept or {})
  if not raw then return false end
  -- An empty queue is no key; one already missing needs no delete.
  if raw == "" then return plugin.storage.get(key) == nil or plugin.storage.delete(key) == true end
  return plugin.storage.set(key, raw) == true
end

local function load_sent(id)
  local set = {}
  local raw = plugin.storage.get(sent_key(id), "")
  if type(raw) ~= "string" then return set end
  for line in raw:gmatch("([^\n]+)") do set[line] = true end
  return set
end

local function save_sent(id, set)
  local ids = {}
  for item_id in pairs(set) do ids[#ids + 1] = item_id end
  table.sort(ids)
  if #ids > QUEUE_MAX_RECORDS then
    local trimmed = {}
    for i = #ids - QUEUE_MAX_RECORDS + 1, #ids do trimmed[#trimmed + 1] = ids[i] end
    ids = trimmed
  end
  return plugin.storage.set(sent_key(id), table.concat(ids, "\n")) == true
end

-- False when the waiting listens could not be removed; they stay as they were.
local function clear_queue(id)
  if not save_queue(queue_key(id), {}) then return false end
  plugin.storage.delete(sent_key(id))
  return true
end

-- The queues of the current (or last) account: its own, and the queue
-- version 1.1 kept under the token. That one is sent with the same token and
-- never moves; 1.1 listens still waiting when that token is replaced stay
-- stored under it.
local function account_queue_ids(token)
  local ids = {}
  local own = queue_id(token)
  if own then ids[1] = own end
  if token and plugin.md5(token) ~= own then ids[#ids + 1] = plugin.md5(token) end
  return ids
end

-- Every waiting listen of the account, oldest queue first; nil if unreadable.
local function account_listens(token)
  local all = {}
  for _, id in ipairs(account_queue_ids(token)) do
    local items = load_queue(queue_key(id))
    if not items then return nil end
    for _, item in ipairs(items) do all[#all + 1] = item end
  end
  return all
end

local function queued_count()
  local items = account_listens(current_token())
  return items and #items or nil
end

local function request(method, url, token, body, callback)
  local headers = { ["User-Agent"] = USER_AGENT }
  if token then headers.Authorization = "Token " .. token end
  local options = {
    url = url,
    method = method,
    headers = headers,
    verify_tls = true,
    max_response_bytes = 16384,
    connect_timeout_ms = REQUEST_TIMEOUTS.connect_timeout_ms,
    read_timeout_ms = REQUEST_TIMEOUTS.read_timeout_ms,
    total_timeout_ms = REQUEST_TIMEOUTS.total_timeout_ms,
    redirect_limit = 0,
  }
  if body then
    options.body = body
    options.content_type = "application/json"
  end
  return plugin.http_request(options, callback)
end

local function hold_auth()
  if auth_hold then return end
  auth_hold = true
  plugin.storage.set("auth_hold", "1")
  plugin.show_toast(tr("ListenBrainz did not accept the user token. Saved listens are kept."))
  refresh_main_list()
end

local function header_value(headers, name)
  if type(headers) ~= "table" then return nil end
  local want = name:lower()
  for key, value in pairs(headers) do
    if type(key) == "string" and key:lower() == want then return value end
  end
  return nil
end

-- Retry-After is honored only as a numeric delay. HTTP dates fall back to
-- the normal backoff. The wait stays inside 1..3600 seconds.
local function retry_after_seconds(headers)
  local raw = header_value(headers, "Retry-After")
  local seconds = nil
  if type(raw) == "number" then
    seconds = raw
  elseif type(raw) == "string" and raw:match("^%d+$") then
    seconds = tonumber(raw)
  end
  if not seconds then return nil end
  if seconds < 1 then seconds = 1 end
  if seconds > 3600 then seconds = 3600 end
  return seconds
end

local function reset_backoff()
  failures, next_sync_at = 0, 0
  last_failure_network = false
  last_error = nil
end

-- Failures back off 15 s doubling up to MAX_BACKOFF. A network failure while
-- the link is down waits the long fallback instead: network_changed sends at
-- once on reconnect, so the backoff need not grow.
local function sync_failed(reason, retry_after)
  last_failure_network = (reason == NETWORK_ERROR)
  local fallback = last_failure_network and link_down()
  if not fallback then failures = failures + 1 end
  local delay = retry_after or (fallback and MAX_BACKOFF) or math.min(15 * 2 ^ (failures - 1), MAX_BACKOFF)
  next_sync_at = os.time() + delay
  -- The delay is shown live on the queue row, never baked into this text.
  last_error = reason
end

-- Shared by queue sends and playing_now. True when the reply was a failure
-- that is already handled; false for any other status.
local function note_failure(status, err, headers)
  if err or not status or status < 100 then
    if wifi_disabled() then
      -- Wi-Fi went off mid-request: wait for network_changed.
      if last_error == NETWORK_ERROR then last_error = nil end
    else
      sync_failed(NETWORK_ERROR)
    end
  elseif status == 401 then
    hold_auth()
  elseif status == 429 then
    sync_failed(BUSY_ERROR, retry_after_seconds(headers))
    rate_limited_until = math.max(rate_limited_until, next_sync_at)
  elseif status >= 500 then
    sync_failed(BUSY_ERROR)
  else
    return false
  end
  return true
end

local function tell_queue_full()
  if queue_full_told then return end
  queue_full_told = true
  plugin.show_toast(tr("ListenBrainz queue is full. The oldest saved listens were kept."))
end

local function tell_queue_write()
  if queue_write_told then return end
  queue_write_told = true
  plugin.show_toast(tr("Could not save that ListenBrainz listen. Saved listens were kept."))
end

local function payload_for(item, kind)
  local metadata = {
    artist_name = item.artist,
    track_name = item.track,
    additional_info = {
      duration_ms = item.duration_ms,
      submission_client = CLIENT_NAME,
      submission_client_version = CLIENT_VERSION,
    },
  }
  if item.release and item.release ~= "" then metadata.release_name = item.release end
  local entry = { track_metadata = metadata }
  if kind ~= "playing_now" then entry.listened_at = item.listened_at end
  return { listen_type = kind, payload = { entry } }
end

local function cancel_inflight()
  if inflight and inflight.handle then plugin.cancel(inflight.handle) end
  inflight = nil
end

-- Cancel the running send and ignore any reply that is still on its way.
local function cancel_account_requests()
  account_generation = account_generation + 1
  cancel_inflight()
end

local function reset_account_state()
  auth_hold = false
  plugin.storage.delete("auth_hold")
  reset_backoff()
end

-- Log in with a token (and the user name ListenBrainz gave for it), or log
-- out with nil. Waiting listens stay in storage under their account.
-- Returns false and a message when the change could not be stored.
local function switch_account(new_token, user_name)
  if user_name == "" then user_name = nil end
  local old_token, old_name = read_account()
  local saved = true
  if old_token ~= new_token or (user_name and user_name ~= old_name) then
    saved = save_account(new_token, user_name)
  end
  -- Follow what storage holds, whichever way a failed write went.
  local token, name = read_account()
  if token ~= old_token then
    validation_generation = validation_generation + 1
    cancel_account_requests()
    if current then current.submitted = true end
  end
  remember_user(name)
  if token == new_token then reset_account_state() end
  if saved or (token == new_token and old_token == new_token) then return true end
  return false, new_token and tr("Could not save the ListenBrainz token. Try again.")
    or tr("Could not log out of ListenBrainz. Try again.")
end

local sync_queue

-- Record the delivery state of the listen shown on the main screen.
local function mark_delivery(ctx, text)
  local snap = current
  if snap and snap.record and snap.record.id == ctx.id and snap.delivery_qid == ctx.qid then
    snap.delivery = text
  end
end

local function submit_succeeded(ctx)
  local sent = load_sent(ctx.qid)
  sent[ctx.id] = true
  if not save_sent(ctx.qid, sent) then return sync_failed(LIST_ERROR) end
  local items, kept = load_queue(ctx.key)
  if not items then return sync_failed(LIST_ERROR) end
  local remain = {}
  for i = 1, #items do
    if items[i].id ~= ctx.id then remain[#remain + 1] = items[i] end
  end
  if not save_queue(ctx.key, remain, kept) then return sync_failed(CLEANUP_ERROR) end
  reset_backoff()
  plugin.storage.set("last_sent_at", tostring(os.time()))
  mark_delivery(ctx, DELIVERY_SENT)
  sync_queue()
end

-- ListenBrainz refused this listen (4xx other than 401/429): sending it again
-- cannot help, so it leaves the waiting list, as LastFM Scrobbler V2 does.
local function submit_rejected(ctx)
  local items, kept = load_queue(ctx.key)
  if not items then return sync_failed(LIST_ERROR) end
  local remain = {}
  for i = 1, #items do
    if items[i].id ~= ctx.id then remain[#remain + 1] = items[i] end
  end
  if not save_queue(ctx.key, remain, kept) then return sync_failed(LIST_ERROR) end
  mark_delivery(ctx, DELIVERY_REJECTED)
  sync_queue()
end

local function apply_submit_result(ctx, status, err, headers)
  if inflight and inflight.id == ctx.id and inflight.generation == ctx.generation then
    inflight = nil
  end
  if ctx.generation ~= account_generation or current_token() ~= ctx.token then return end
  if not note_failure(status, err, headers) then
    if status >= 200 and status < 300 then
      submit_succeeded(ctx)
    elseif status >= 400 and status < 500 then
      submit_rejected(ctx)
    else
      sync_failed(BUSY_ERROR)
    end
  end
  refresh_main_list()
end

-- The next listen to send. Listens already sent but not yet cleaned up, and
-- listens version 1.1 held after a rejection, are removed on the way.
local function next_listen(key, qid)
  local items, kept = load_queue(key)
  if not items then return nil end
  local sent = load_sent(qid)
  local remain = {}
  for i = 1, #items do
    if not sent[items[i].id] and items[i].hold ~= 1 then remain[#remain + 1] = items[i] end
  end
  if #remain ~= #items and not save_queue(key, remain, kept) then return nil end
  return remain[1]
end

local function start_send(ctx, body)
  inflight = { id = ctx.id, generation = ctx.generation }
  local handle = request("POST", SUBMIT_URL, ctx.token, body, function(status, _, err, headers)
    apply_submit_result(ctx, status, err, headers)
  end)
  local mine = inflight and inflight.id == ctx.id and inflight.generation == ctx.generation
  if not mine then return end
  if handle then
    inflight.handle = handle
  else
    inflight = nil
    sync_failed(SEND_ERROR)
  end
  refresh_main_list()
end

local function can_start_send()
  if inflight or auth_hold or not state.enabled then return false end
  if os.time() < next_sync_at or os.time() < rate_limited_until then return false end
  -- Never start a send while Wi-Fi is switched off.
  if wifi_disabled() then return false end
  if not can_http or not can_json then
    if not missing_api_told then
      missing_api_told = true
      plugin.show_toast(tr("This player cannot send ListenBrainz listens. Saved listens are kept."))
    end
    return false
  end
  return true
end

sync_queue = function()
  if not can_start_send() then return end
  local token = current_token()
  if not token then return end
  for _, qid in ipairs(account_queue_ids(token)) do
    local key = queue_key(qid)
    local item = next_listen(key, qid)
    if item then
      local body = encode_json(payload_for(item, "single"))
      if not body then return sync_failed(SEND_ERROR) end
      return start_send({ id = item.id, key = key, qid = qid, token = token, generation = account_generation }, body)
    end
  end
end

local function enqueue(record, qid)
  if record.artist == "" or record.track == "" or not record.listened_at or record.listened_at <= 0 then
    return false
  end
  local key = queue_key(qid)
  local items, kept = load_queue(key)
  if not items then return false end
  if record.id then
    for i = 1, #items do
      if items[i].id == record.id then return true end
    end
  else
    local sequence = (tonumber(plugin.storage.get("sequence", "0")) or 0) + 1
    if sequence > 1000000 then sequence = 1 end
    if not plugin.storage.set("sequence", tostring(sequence)) then
      tell_queue_write()
      return false
    end
    record.id = tostring(record.listened_at) .. "-" .. tostring(sequence)
  end
  if #items >= QUEUE_MAX_RECORDS then
    tell_queue_full()
    return false
  end
  items[#items + 1] = {
    id = record.id,
    listened_at = record.listened_at,
    duration_ms = record.duration_ms,
    hold = 0,
    artist = record.artist,
    track = record.track,
    release = record.release or "",
  }
  if not save_queue(key, items, kept) then
    tell_queue_write()
    return false
  end
  return true
end

local function threshold(duration)
  local half = duration / 2
  if half < 240 then return half end
  return 240
end

local function metadata_ok(artist, track)
  return artist ~= "" and track ~= ""
end

local function consider(snap)
  if not snap or snap.submitted or not state.enabled then return end
  if not metadata_ok(snap.artist, snap.track) or snap.duration < 30 then return end
  if snap.listened < threshold(snap.duration) then return end
  local token = current_token()
  if not token then return end
  local duration_ms = math.floor(snap.duration * 1000)
  if duration_ms <= 0 or duration_ms > 2073600000 then return end
  snap.record = snap.record or {
    listened_at = snap.started,
    artist = snap.artist,
    track = snap.track,
    release = snap.release,
    duration_ms = duration_ms,
  }
  local qid = queue_id(token)
  if enqueue(snap.record, qid) then
    snap.submitted = true
    snap.delivery, snap.delivery_qid = DELIVERY_WAITING, qid
    refresh_main_list()
    if not auth_hold then sync_queue() end
  elseif snap.delivery ~= DELIVERY_UNSAVED then
    snap.delivery = DELIVERY_UNSAVED
    refresh_main_list()
  end
end

-- Credit the position change since the last sample, never more than the
-- seconds that actually passed, and never a backward or forward jump.
local function rebase(snap, count_previous)
  if not snap then return end
  local now = os.time()
  local pos = tonumber(plugin.get_position()) or 0
  if count_previous and state.enabled then
    local elapsed = now - (snap.last_poll or now)
    if elapsed > 0 and elapsed <= 30 then
      local delta = pos - (snap.last_pos or pos)
      if delta < 0 then delta = 0 end
      if delta > elapsed then delta = elapsed end
      snap.listened = snap.listened + delta
    end
  end
  snap.last_poll = now
  snap.last_pos = pos
end

local function send_playing_now(snap)
  -- Only while it really plays; the 5 s poll sends it once playback resumes.
  if snap.now_sent or not state.enabled or not is_active() or auth_hold or not can_http or not can_json then return end
  if os.time() < next_sync_at or os.time() < rate_limited_until or wifi_disabled() then return end
  if not metadata_ok(snap.artist, snap.track) or snap.duration < 30 then return end
  local token = current_token()
  if not token then return end
  local duration_ms = math.floor(snap.duration * 1000)
  local body = encode_json(payload_for({
    artist = snap.artist,
    track = snap.track,
    release = snap.release,
    duration_ms = duration_ms,
  }, "playing_now"))
  if not body then return end
  snap.now_sent = true
  local generation = account_generation
  local handle = request("POST", SUBMIT_URL, token, body, function(status, _, err, headers)
    if generation ~= account_generation or current_token() ~= token then return end
    -- A reply proves the connection works again.
    if not note_failure(status, err, headers) and status == 200 and last_failure_network then
      reset_backoff()
    end
    refresh_main_list()
  end)
  if not handle then snap.now_sent = false end
end

local function refresh_duration(snap)
  if snap.duration >= 30 or snap.record then return end
  local duration = tonumber(plugin.get_duration()) or 0
  if duration >= 30 then snap.duration = duration end
end

-- Start tracking a song. Used by track_started and by a song that was
-- already playing when the plugin loaded.
-- `picked_up`: the song was already playing, so it began `pos` seconds ago.
-- At a real track start the position can still be the previous song's.
local function begin_track(title, artist, album, duration_seconds, picked_up)
  local now = os.time()
  local pos = tonumber(plugin.get_position()) or 0
  if pos < 0 then pos = 0 end
  current = {
    artist = clip(artist),
    track = clip(title),
    release = clip(album),
    duration = tonumber(duration_seconds) or 0,
    started = picked_up and now - math.floor(pos) or now,
    listened = 0,
    active = is_active(),
    last_poll = now,
    last_pos = pos,
    submitted = false,
  }
  send_playing_now(current)
  sync_queue()
  refresh_main_list()
end

plugin.on("track_started", function(title, artist, album, duration_seconds)
  if current then
    rebase(current, current.active)
    current.active = false
    consider(current)
  end
  begin_track(title, artist, album, duration_seconds)
end)

local function finish_stretch()
  if not current then return end
  rebase(current, current.active)
  current.active = false
  consider(current)
end

local function finish_stretch_and_refresh()
  finish_stretch()
  refresh_main_list()
end

plugin.on("paused", finish_stretch_and_refresh)
plugin.on("stopped", finish_stretch_and_refresh)
plugin.on("suspending", finish_stretch)

plugin.on("resumed", function()
  if not current then return end
  rebase(current, false)
  current.active = true
  refresh_main_list()
end)

-- Connectivity came back (or may have, after sleep): send promptly. The
-- backoff is dropped only if the last failure was a network one; rate-limit
-- and storage backoffs stay, and sync_queue() still honours them.
local function network_back()
  if wifi_disabled() then return end
  if last_failure_network then reset_backoff() end
  if state.enabled then sync_queue() end
  refresh_main_list()
end

if type(plugin.network_status) == "function" then
  pcall(plugin.on, "network_changed", function(info)
    if type(info) == "table" and info.connected then
      network_back()
    else
      refresh_main_list()
    end
  end)
end
-- Fallbacks for players without network_changed, and for Wi-Fi that stayed
-- up across sleep while the old backoff was still ticking.
pcall(plugin.on, "system_resumed", function()
  if current then
    rebase(current, false)
    current.active = is_active()
  end
  network_back()
end)
pcall(plugin.on, "screen_woke", function()
  if next_sync_at > 0 then network_back() end
end)

local last_backoff_refresh = 0

plugin.set_interval(5, function()
  -- A real change while a child screen was open is drawn once on return.
  if main_refresh_pending then refresh_main_list() end
  if current then
    -- `was_active` is the stretch since the previous sample. Pause, stop and
    -- a new track sample that stretch themselves and clear `active`, so a
    -- later poll does not add it again.
    local was_active = current.active
    current.active = is_active()
    rebase(current, was_active)
    local had_duration = current.duration
    refresh_duration(current)
    if current.duration ~= had_duration then main_refresh_pending = true end
    if current.duration >= 30 and not current.now_sent then send_playing_now(current) end
    consider(current)
  end
  sync_queue()
  -- The queue row shows "next try Nm": redraw at most once a minute while
  -- backing off (the fingerprint check skips it if nothing changed).
  if next_sync_at > os.time() and os.time() - last_backoff_refresh >= 60 then
    last_backoff_refresh = os.time()
    refresh_main_list()
  end
end)

local set_scrobbling

local function validate_token(token, on_saved)
  if not can_secrets then
    plugin.show_toast(tr("This player cannot store a ListenBrainz token."))
    return
  end
  if not token_shape_ok(token) then
    plugin.show_toast(tr("That token cannot be used."))
    return
  end
  if not can_http or not can_json then
    plugin.show_toast(tr("This player cannot check a ListenBrainz token."))
    return
  end
  validation_generation = validation_generation + 1
  local validation_id = validation_generation
  local generation = account_generation
  plugin.show_toast(tr("Checking ListenBrainz token..."))
  local handle = request("GET", VALIDATE_URL, token, nil, function(status, body, err)
    if validation_id ~= validation_generation or generation ~= account_generation then return end
    if err or status ~= 200 or type(body) ~= "string" then
      plugin.show_toast(tr("Could not reach ListenBrainz."))
      return
    end
    local data = decode_json(body)
    -- Invalid tokens are often HTTP 200 with valid=false.
    if type(data) ~= "table" or data.valid ~= true then
      plugin.show_toast(tr("ListenBrainz did not accept that token."))
      return
    end
    local user_name = nil
    if type(data.user_name) == "string" then
      user_name = clip(data.user_name)
      if user_name == token or user_name:find("%c") then user_name = nil end
    end
    -- Scrobbling turns on at login only while the user has never chosen.
    local never_chosen = plugin.storage.get("enabled") == nil
    local ok, message = switch_account(token, user_name)
    if ok then
      local toast = user_name and string.format(tr("Logged in to ListenBrainz as %s"), user_name) or tr("ListenBrainz token saved.")
      local enabling = never_chosen and not state.enabled
      if not enabling or set_scrobbling(true, tr("Account saved. Tap Scrobbling to turn it on.")) then
        plugin.show_toast(toast)
      end
      sync_queue()
    else
      plugin.show_toast(message)
    end
    refresh_main_list()
    if ok and on_saved then on_saved() end
  end)
  if not handle then plugin.show_toast(tr("Could not reach ListenBrainz.")) end
end

local function prompt_token(on_saved)
  show_input(tr("ListenBrainz user token"), function(value)
    if value == nil or trim(value) == "" then return end
    validate_token(trim(value), on_saved)
  end)
end

-- fail_message replaces the generic toast when the preference cannot be saved.
set_scrobbling = function(value, fail_message)
  if value then
    state.enabled = true
    if not save_enabled() then
      state.enabled = false
      plugin.show_toast(fail_message or tr("Could not save scrobbling preference. Try again."))
      return false
    end
    if current then
      rebase(current, false)
      current.active = is_active()
    end
    reset_backoff()
    sync_queue()
  else
    if current then
      rebase(current, current.active)
      consider(current)
      current.submitted = true
      current.active = false
    end
    state.enabled = false
    if not save_enabled() then
      plugin.show_toast(tr("Could not save scrobbling preference. Try again."))
    end
  end
  refresh_main_list()
  return true
end

-- Show the outcome of a confirmation in place of its two rows.
local function finish_confirmation(handle, title, message)
  plugin.show_toast(message)
  if handle and plugin.has_capability("ui.list_update") and plugin.is_list_showing(handle) then
    local text = message .. " " .. tr("Press Back.")
    -- Wrapped, so a long outcome is not cut at the screen edge.
    local row = plugin.has_capability("ui.list_wrap") and { label = text, wrap = true } or text
    plugin.show_list(title, { row }, function() end, { replace = handle })
  end
end

local open_settings_screen
local is_main_showing

local UUID_PATTERN = "%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x"

-- ListenBrainz tokens are UUIDs, so take the first one in the text. A file
-- holding nothing but one other token-shaped word is used as it is.
local function token_from_text(text)
  text = text:gsub("^\239\187\191", "")
  local uuid = text:match("%f[%w]" .. UUID_PATTERN .. "%f[^%w]")
  if uuid then return uuid end
  local only = trim(text)
  if token_shape_ok(only) then return only end
  return nil
end

-- Returns the token in the file, or nil and "read" or "none".
local function read_token_file(path)
  local file = io.open(path, "rb")
  if not file then return nil, "read" end
  local text = file:read(4096)
  file:close()
  if not text then return nil, "read" end
  return token_from_text(text) or nil, "none"
end

-- After a token was saved, offer to remove the file so it does not stay on the card.
local function confirm_delete_token_file(path)
  if not can_delete then return end
  local title = tr("Delete token file?")
  local done, handle = false, nil
  handle = plugin.show_list(title, { tr("Keep the file"), tr("Delete the file") }, function(idx)
    if done or (idx ~= 1 and idx ~= 2) then return end
    done = true
    if idx == 1 then finish_confirmation(handle, title, tr("Token file kept.")); return end
    local called, started = pcall(plugin.file_delete, path, function(result)
      local ok = result and result.failed == 0 and not result.stopped
      finish_confirmation(handle, title, ok and tr("Token file deleted.") or tr("Could not delete the token file."))
    end)
    if not (called and started) then finish_confirmation(handle, title, tr("Could not delete the token file.")) end
  end)
end

-- Pick a text file on the SD card and use the token inside it.
local function read_token_from_sd(on_saved)
  local opened = plugin.pick_file(nil, function(path)
    if not path then return end
    local token, why = read_token_file(path)
    if not token then
      plugin.show_toast(why == "read" and tr("Could not read that file.") or tr("No ListenBrainz token found in that file."))
      return
    end
    validate_token(token, function()
      -- From the main screen, only offer while the user is still on it.
      if on_saved then
        on_saved()
      elseif not is_main_showing() then
        return
      end
      confirm_delete_token_file(path)
    end)
  end)
  if not opened then plugin.show_toast(tr("Could not open the file picker. Try again.")) end
end

local function confirm_log_out()
  if not current_token() then return end
  local name, generation = state.user_name or "", account_generation
  local title = tr("Log out?")
  local done, handle = false, nil
  handle = plugin.show_list(title, { tr("Stay logged in"), string.format(tr("Log out %s"), truncate(name, 20)) }, function(idx)
    if done or (idx ~= 1 and idx ~= 2) then return end
    done = true
    if idx == 1 then finish_confirmation(handle, title, tr("Stayed logged in.")); return end
    if generation ~= account_generation or name ~= (state.user_name or "") then
      finish_confirmation(handle, title, tr("Account changed. Nothing changed.")); return
    end
    local ok, message = switch_account(nil, nil)
    if not ok then finish_confirmation(handle, title, message); return end
    finish_confirmation(handle, title, tr("Logged out. Waiting listens are kept for this account."))
    refresh_main_list()
    open_settings_screen()
  end)
end

local function confirm_discard_queue()
  local qid = queue_id(current_token())
  if not qid then return end
  local ids = account_queue_ids(current_token())
  local items = account_listens(current_token())
  if not items then plugin.show_toast(tr("Waiting listens could not be read. Nothing discarded.")); return end
  local count = #items
  if count == 0 then plugin.show_toast(tr("No listens are waiting to send")); return end
  local generation, done, handle = account_generation, false, nil
  local title = string.format(tr("Discard %d listens?"), count)
  handle = plugin.show_list(title, { tr("Keep waiting listens"), string.format(tr("Discard %d listens"), count) }, function(idx)
    if done or (idx ~= 1 and idx ~= 2) then return end
    done = true
    if idx == 1 then finish_confirmation(handle, title, tr("Kept waiting listens.")); return end
    if generation ~= account_generation or qid ~= queue_id(current_token()) then
      finish_confirmation(handle, title, tr("Account changed. Nothing discarded.")); return
    end
    -- Cancel and invalidate every reply before emptying the queue.
    cancel_account_requests()
    for _, id in ipairs(ids) do
      if not clear_queue(id) then
        finish_confirmation(handle, title, tr("Could not discard listens. Try again."))
        sync_queue()
        return
      end
    end
    if current and current.delivery_qid and current.delivery ~= DELIVERY_SENT then
      for _, id in ipairs(ids) do
        if current.delivery_qid == id then current.delivery = DELIVERY_DISCARDED end
      end
    end
    finish_confirmation(handle, title, tr("Waiting listens discarded."))
    refresh_main_list()
  end)
end

local function can_send_now()
  return current_token() ~= nil and not auth_hold and state.enabled
end

local function retry_now()
  if auth_hold then
    plugin.show_toast(tr("ListenBrainz did not accept the user token. Saved listens are kept."))
    return
  end
  if not current_token() then
    plugin.show_toast(tr("Set your ListenBrainz user token before sending waiting listens."))
    return
  end
  if not state.enabled then plugin.show_toast(tr("Turn scrobbling on before sending waiting listens.")); return end
  local count = queued_count()
  if count == nil then plugin.show_toast(tr("Waiting listens could not be read")); return end
  if count == 0 then plugin.show_toast(tr("No listens are waiting to send")); return end
  if inflight then plugin.show_toast(tr("Already sending waiting listens.")); return end
  if wifi_disabled() then plugin.show_toast(offline_text()); return end
  reset_backoff()
  plugin.show_toast(tr("Sending waiting listens…"))
  sync_queue()
  refresh_main_list()
end

local function open_queue_list()
  local qid = queue_id(current_token())
  if not qid then return end
  local items = account_listens(current_token())
  if not items then plugin.show_toast(tr("Waiting listens could not be read")); return end
  local labels, actions = {}, {}
  local function add(label, action)
    labels[#labels + 1], actions[#actions + 1] = label, action
  end
  if #items == 0 then
    add(tr("No listens are waiting to send"), function() plugin.show_toast(tr("Qualified listens send automatically.")) end)
  else
    add(string.format(tr("%d listens kept for %s"), #items, truncate(state.user_name or last_user or "", 20)),
      function() plugin.show_toast(tr("Oldest listens are sent first.")) end)
    if can_send_now() then add(tr("Send waiting listens now"), retry_now) end
    for i, item in ipairs(items) do
      local timestamp = item.listened_at
      add(string.format("%d. %s - %s", i, truncate(item.artist, 20), truncate(item.track, 20)), function()
        local ok, time_text = pcall(os.date, "!%Y-%m-%d %H:%M UTC", timestamp)
        plugin.show_toast(ok and time_text and string.format(tr("Saved: %s"), time_text) or tr("Saved time unavailable"))
      end)
    end
    add(tr("Discard waiting listens…"), confirm_discard_queue)
  end
  plugin.show_list(tr("Waiting listens"), labels, function(idx)
    if qid ~= queue_id(current_token()) then
      plugin.show_toast(tr("Account changed. Open waiting listens again."))
      return
    end
    if actions[idx] then actions[idx]() end
  end)
end

local function open_how_it_works()
  local text = tr("How ListenBrainz Scrobbling Works:\n\n"
    .. "1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n"
    .. "2. Listening Threshold: A listen qualifies after half its length or 4 minutes, whichever comes first.\n\n"
    .. "3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n"
    .. "4. Offline Queue: Up to 100 listens (64 KB) are saved offline and sent automatically when connected.\n\n"
    .. "5. Account Separation: Waiting listens are kept per ListenBrainz account.\n\n"
    .. "6. Unknown Length: Streams without a known length, such as most radio, are not sent.\n\n"
    .. "7. Token: On a phone or computer, copy your user token from listenbrainz.org/settings into a text file on the SD card, then use Read token from SD card.")
  if plugin.has_capability("ui.text_view") and plugin.show_text_view then
    if plugin.show_text_view(tr("How Scrobbling Works"), text) ~= false then return end
  end
  plugin.show_list(tr("How Scrobbling Works"), {
    tr("Tracks >= 30s only"),
    tr("Listened 50% or 4 min"),
    tr("Pauses do not count"),
    tr("Up to 100 offline listens"),
    tr("Separate queue per account"),
    tr("Streams without length are not sent"),
  }, function() end)
end

open_settings_screen = function()
  local has_token = current_token() ~= nil
  local rows = {
    {
      type = "row",
      label = has_token and tr("User token: set") or tr("Set ListenBrainz user token"),
      on_select = function() prompt_token(open_settings_screen) end,
    },
  }
  if can_pick then
    rows[#rows + 1] = {
      type = "row",
      label = tr("Read token from SD card"),
      on_select = function() read_token_from_sd(open_settings_screen) end,
    }
  end
  if has_token then
    local label = tr("Log out")
    if state.user_name then label = string.format(tr("Log out (%s)"), truncate(state.user_name, 18)) end
    rows[#rows + 1] = { type = "row", label = label, on_select = confirm_log_out }
  end
  local count = queued_count()
  if count and count > 0 then
    rows[#rows + 1] = {
      type = "row",
      label = string.format(tr("Discard waiting listens (%d)"), count),
      on_select = confirm_discard_queue,
    }
  end
  rows[#rows + 1] = { type = "row", label = tr("How Scrobbling Works"), on_select = open_how_it_works }
  plugin.show_settings_list(tr("Account & settings"), rows, { update = true })
end

is_main_showing = function()
  if not current_main_handle or not plugin.has_capability("ui.list_showing") then return false end
  return plugin.is_list_showing(current_main_handle)
end

local function main_status(count)
  local offline = state.enabled and count and count > 0 and (wifi_disabled() or link_down())
  if last_error and (last_error ~= NETWORK_ERROR or not offline) then
    return string.format(tr("Status: %s"), truncate(tr(last_error), 45)), tr(last_error)
  elseif offline then
    return offline_text(), offline_text()
  end
  local who = state.user_name or "?"
  return string.format(tr("Logged in as %s"), truncate(who, 20)), string.format(tr("Logged in as %s"), who)
end

local function track_label()
  local snap = current
  if not snap or snap.track == "" then return tr("This track: No music playing") end
  if not state.enabled then return tr("This track: Scrobbling off") end
  if snap.duration <= 0 then return tr("This track: Reading length") end
  if snap.duration < 30 then return tr("This track: Too short (<30s)") end
  if snap.delivery then return string.format(tr("This track: %s"), tr(snap.delivery)) end
  if snap.submitted then return tr("This track: This listen not counted") end
  if not is_active() then return tr("This track: Playback paused") end
  return string.format(tr("This track: Counts after %s"), format_time(threshold(snap.duration)))
end

local function show_track_progress()
  local snap = current
  if not snap or snap.track == "" then
    plugin.show_toast(tr("No track playing."))
    return
  end
  plugin.show_toast(string.format("%s - %s (%s / %s)", truncate(snap.artist, 25), truncate(snap.track, 25),
    format_time(snap.listened), format_time(threshold(snap.duration))))
end

local function scrobbling_label()
  local label = state.enabled and "On" or "Off"
  if plugin.has_capability("ui.list_wrap") then return tr("Scrobbling") .. "\n" .. label end
  return string.format(tr("Scrobbling: %s"), label)
end

local function queue_label(count)
  if count == nil then return tr("Waiting listens could not be read") end
  local parts = {
    count == 1 and string.format(tr("%d listen waiting"), count) or string.format(tr("%d listens waiting"), count),
  }
  local remaining = next_sync_at - os.time()
  if count > 0 then
    if inflight then
      parts[#parts + 1] = tr("Sending…")
    elseif state.enabled and wifi_disabled() then
      parts[#parts + 1] = tr("waiting for Wi-Fi")
    elseif remaining > 0 then
      parts[#parts + 1] = string.format(tr("next try %dm"), math.max(1, math.ceil(remaining / 60)))
    end
  end
  local last_sent = format_last_sent(plugin.storage.get("last_sent_at", ""))
  if last_sent then parts[#parts + 1] = string.format(tr("sent %s"), last_sent) end
  return table.concat(parts, " \u{b7} ")
end

-- The rows of the main screen with what each one does.
local function build_main_menu()
  local items, actions = {}, {}
  local function add(label, action)
    items[#items + 1], actions[#actions + 1] = label, action
  end
  if not current_token() or auth_hold then
    if auth_hold then
      add(tr("Status: user token not accepted"), function()
        plugin.show_toast(tr("ListenBrainz did not accept the user token. Saved listens are kept."))
      end)
    end
    add(tr("Set ListenBrainz user token"), function() prompt_token() end)
    if can_pick then add(tr("Read token from SD card"), function() read_token_from_sd() end) end
    -- Signed out, the settings screen would only repeat these rows and How.
    if auth_hold then add(tr("Account & settings"), open_settings_screen)
    else add(tr("How Scrobbling Works"), open_how_it_works) end
    return items, actions
  end
  local count = queued_count()
  local status_label, status_toast = main_status(count)
  add(status_label, function() plugin.show_toast(status_toast) end)
  add(track_label(), show_track_progress)
  add(scrobbling_label(), function()
    local desired = not state.enabled
    if set_scrobbling(desired) then
      plugin.show_toast(desired and tr("Scrobbling turned on.") or tr("Scrobbling turned off."))
    end
  end)
  add(queue_label(count), open_queue_list)
  if count and count > 0 and can_send_now() then add(tr("Sync now"), retry_now) end
  add(tr("Account & settings"), open_settings_screen)
  return items, actions
end

local current_main_actions = nil
local last_menu_fingerprint = nil

local function render_main_items(items)
  if not plugin.has_capability("ui.list_wrap") then return items end
  local rows = {}
  for i, label in ipairs(items) do rows[i] = { label = label, wrap = true } end
  return rows
end

local function on_main_select(index)
  if current_main_actions and current_main_actions[index] then current_main_actions[index]() end
end

-- Redraw the main screen in place, only when its rows changed.
refresh_main_list = function()
  main_refresh_pending = true
  if not current_main_handle then return end
  if plugin.has_capability("ui.list_update") and is_main_showing() then
    local items, actions = build_main_menu()
    local fingerprint = table.concat(items, "\31")
    if fingerprint == last_menu_fingerprint then
      main_refresh_pending = false
      current_main_actions = actions
      return
    end
    local new_handle = plugin.show_list(tr("ListenBrainz Scrobbler"), render_main_items(items), on_main_select,
      { replace = current_main_handle })
    if new_handle then
      main_refresh_pending = false
      last_menu_fingerprint = fingerprint
      current_main_actions = actions
      current_main_handle = new_handle
    end
  end
end

local function open_main_list()
  local items, actions = build_main_menu()
  last_menu_fingerprint = table.concat(items, "\31")
  current_main_actions = actions
  current_main_handle = plugin.show_list(tr("ListenBrainz Scrobbler"), render_main_items(items), on_main_select)
  main_refresh_pending = false
end

plugin.register_list_item("playback", tr("ListenBrainz Scrobbler"), open_main_list)

if not auth_hold then sync_queue() end

-- A song may already be playing when the plugin loads. Time listened
-- counts from now; the listen timestamp is when the song really began.
if plugin.get_current_track_path() then
  local title, artist, album, duration = plugin.get_now_playing()
  if title and title ~= "" then
    begin_track(title, artist, album, duration, true)
  end
end

if rawget(_G, "COMPAS_PLUGIN_TEST") then
  _G.COMPAS_PLUGIN_UNDER_TEST = {
    open_menu = open_main_list,
    listened = function() return current and current.listened or 0 end,
    submitted = function() return current and current.submitted == true end,
    generation = function() return account_generation end,
    translations = T,
    queued_count = queued_count,
    confirm_log_out = confirm_log_out,
    confirm_discard_queue = confirm_discard_queue,
    open_queue_list = open_queue_list,
    open_settings_screen = open_settings_screen,
    open_how_it_works = open_how_it_works,
    validate_token = validate_token,
  }
end
