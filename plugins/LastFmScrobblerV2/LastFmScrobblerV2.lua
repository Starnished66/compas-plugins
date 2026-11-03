plugin.define({ id = "compas.lastfm_scrobbler_v2", name = "LastFM Scrobbler V2", version = "1.2.0", api_min = 19 })

local T = {
  de = {
    ["LastFM Scrobbler V2"] = "Last.fm-Scrobbler V2",
    ["LastFM Scrobbler V2 Settings"] = "Last.fm-Scrobbler V2 Einstellungen",
    ["Could not remove an old Last.fm file from the SD card"] = "Eine alte Last.fm-Datei auf der SD-Karte konnte nicht gelöscht werden",
    ["Could not open text entry. Try again."] = "Texteingabe konnte nicht geöffnet werden. Erneut versuchen.",
    ["Saved account could not be read. Sign in again."] = "Gespeichertes Konto konnte nicht gelesen werden. Erneut anmelden.",
    ["Last.fm service not configured."] = "Last.fm-Dienst nicht konfiguriert.",
    ["Session expired. Sign in again."] = "Sitzung abgelaufen. Erneut anmelden.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Sitzung abgelaufen; Abmeldung konnte nicht gespeichert werden. Erneut anmelden.",
    ["Last.fm not reachable."] = "Last.fm nicht erreichbar.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi aus — wird bei Verbindung gesendet",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi nicht verbunden — wird bei Verbindung gesendet",
    ["Waiting list could not be updated."] = "Warteliste konnte nicht aktualisiert werden.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Gesendet, aber Bereinigung der Warteliste konnte nicht gespeichert werden.",
    ["Last.fm service problem."] = "Problem mit dem Last.fm-Dienst.",
    ["API key or secret rejected by Last.fm."] = "API-Schlüssel oder Secret von Last.fm abgelehnt.",
    ["API key or secret rejected by Last.fm. Check settings."] = "API-Schlüssel oder Secret von Last.fm abgelehnt. Einstellungen prüfen.",
    ["Last.fm rejected this play"] = "Last.fm hat diese Wiedergabe abgelehnt",
    ["Last.fm temporarily busy."] = "Last.fm vorübergehend ausgelastet.",
    ["Could not send scrobble request."] = "Scrobble-Anfrage konnte nicht gesendet werden.",
    ["Not counted by Last.fm"] = "Nicht gezählt von Last.fm",
    ["Sent to Last.fm"] = "An Last.fm gesendet",
    ["Waiting to send"] = "Wartet auf Senden",
    ["Not saved yet"] = "Noch nicht gespeichert",
    ["Discarded by you"] = "Von dir verworfen",
    ["Check your API key and shared secret in Account settings."] = "Prüfe deinen API-Schlüssel und Shared Secret in den Kontoeinstellungen.",
    ["Sign in before sending waiting plays."] = "Melde dich an, bevor du wartende Wiedergaben sendest.",
    ["Turn scrobbling on before sending waiting plays."] = "Aktiviere Scrobbeln, bevor du wartende Wiedergaben sendest.",
    ["Waiting plays could not be read."] = "Wartende Wiedergaben konnten nicht gelesen werden.",
    ["No plays are waiting to send."] = "Keine Wiedergaben warten auf das Senden.",
    ["Already sending waiting plays."] = "Wartende Wiedergaben werden bereits gesendet.",
    ["Sending waiting plays…"] = "Wartende Wiedergaben werden gesendet…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "Warteliste ist voll oder nicht verfügbar. Wiedergabe noch nicht gespeichert.",
    ["Could not save scrobbling preference. Try again."] = "Scrobbel-Einstellung konnte nicht gespeichert werden. Erneut versuchen.",
    ["API key cannot contain control characters."] = "API-Schlüssel darf keine Steuerzeichen enthalten.",
    ["Use the 32-character API key without spaces."] = "Nutze den 32-stelligen API-Schlüssel ohne Leerzeichen.",
    ["API key saved."] = "API-Schlüssel gespeichert.",
    ["Could not save API key. Try again."] = "API-Schlüssel konnte nicht gespeichert werden. Erneut versuchen.",
    ["API secret cannot contain control characters."] = "API-Secret darf keine Steuerzeichen enthalten.",
    ["Shared secret saved."] = "Shared Secret gespeichert.",
    ["Could not save shared secret. Try again."] = "Shared Secret konnte nicht gespeichert werden. Erneut versuchen.",
    ["Sign-in cancelled."] = "Anmeldung abgebrochen.",
    ["Signing in…"] = "Anmeldung läuft…",
    ["Logging in to Last.fm…"] = "Anmeldung bei Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Konto gespeichert. Tippe auf Scrobbeln, um es zu aktivieren.",
    ["Logged in to Last.fm as %s"] = "Bei Last.fm angemeldet als %s",
    ["Last.fm service problem. Sign in again."] = "Problem mit dem Last.fm-Dienst. Erneut anmelden.",
    ["Could not save session."] = "Sitzung konnte nicht gespeichert werden.",
    ["Username or password incorrect."] = "Benutzername oder Passwort falsch.",
    ["API key suspended by Last.fm."] = "API-Schlüssel von Last.fm gesperrt.",
    ["Last.fm is not reachable. Check network."] = "Last.fm ist nicht erreichbar. Netzwerk prüfen.",
    ["Could not log in to Last.fm. Check details."] = "Anmeldung bei Last.fm fehlgeschlagen. Daten prüfen.",
    ["Could not start login request."] = "Anmeldeanfrage konnte nicht gestartet werden.",
    ["Last.fm API key"] = "Last.fm-API-Schlüssel",
    ["Last.fm Shared Secret"] = "Last.fm Shared Secret",
    ["Last.fm Username"] = "Last.fm-Benutzername",
    ["Last.fm Password"] = "Last.fm-Passwort",
    ["Invalid username."] = "Ungültiger Benutzername.",
    ["Password cannot contain control characters."] = "Passwort darf keine Steuerzeichen enthalten.",
    ["Last.fm setup is already complete."] = "Last.fm-Einrichtung ist bereits abgeschlossen.",
    ["Set up Last.fm"] = "Last.fm einrichten",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Um Musik auf Last.fm zu scrobbeln:\n\n1. Melde dich auf einem Smartphone oder Computer bei Last.fm an.\n\n2. Öffne diese Adresse:\nlast.fm/api/account/create\n\n3. Erstelle eine Anwendung (jeder Name ist möglich).\n\n4. Gib bei Callback-URL http://localhost ein, falls gefragt.\n\n5. Kopiere API-Schlüssel und Shared Secret.\n\nSchließe diese Seite, um sie einzugeben.",
    ["Could not open setup guide."] = "Einrichtungsassistent konnte nicht geöffnet werden.",
    ["Create an app at last.fm/api/account/create"] = "Erstelle eine App unter last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Trage zuerst deine Last.fm-API-Zugangsdaten ein.",
    ["Already signed in to Last.fm."] = "Bereits bei Last.fm angemeldet.",
    ["Sign-in already in progress."] = "Anmeldung läuft bereits.",
    ["Press Back."] = "Zurück drücken.",
    ["Sign out?"] = "Abmelden?",
    ["Keep signed in"] = "Angemeldet bleiben",
    ["Sign out %s"] = "Abmelden: %s",
    ["Kept signed in."] = "Angemeldet geblieben.",
    ["Account changed. Nothing changed."] = "Konto geändert. Keine Änderungen vorgenommen.",
    ["Could not save sign-out. Try again."] = "Abmeldung konnte nicht gespeichert werden. Erneut versuchen.",
    ["Signed out. Waiting plays are kept for this account."] = "Abgemeldet. Wartende Wiedergaben bleiben für dieses Konto erhalten.",
    ["Waiting plays could not be read. Nothing discarded."] = "Wartende Wiedergaben konnten nicht gelesen werden. Nichts verworfen.",
    ["No waiting plays to discard."] = "Keine wartenden Wiedergaben zum Verwerfen.",
    ["Discard %d plays?"] = "%d Wiedergaben verwerfen?",
    ["Keep waiting plays"] = "Wartende Wiedergaben behalten",
    ["Discard %d plays"] = "%d Wiedergaben verwerfen",
    ["Kept waiting plays."] = "Wartende Wiedergaben behalten.",
    ["Account changed. Nothing discarded."] = "Konto geändert. Nichts verworfen.",
    ["Waiting plays discarded."] = "Wartende Wiedergaben verworfen.",
    ["Could not discard plays. Try again."] = "Wiedergaben konnten nicht verworfen werden. Erneut versuchen.",
    ["No account has waiting plays yet."] = "Kein Konto hat bisher wartende Wiedergaben.",
    ["Waiting plays could not be read. Nothing removed."] = "Wartende Wiedergaben konnten nicht gelesen werden. Nichts entfernt.",
    ["Waiting plays"] = "Wartende Wiedergaben",
    ["No plays are waiting to send"] = "Keine Wiedergaben warten auf das Senden",
    ["Qualified plays send automatically."] = "Qualifizierte Wiedergaben werden automatisch gesendet.",
    ["%d plays kept for %s"] = "%d Wiedergaben behalten für %s",
    ["Oldest plays are sent first."] = "Älteste Wiedergaben werden zuerst gesendet.",
    ["Send waiting plays now"] = "Wartende Wiedergaben jetzt senden",
    ["Saved: %s"] = "Gespeichert: %s",
    ["Saved time unavailable"] = "Speicherzeit nicht verfügbar",
    ["Discard waiting plays…"] = "Wartende Wiedergaben verwerfen…",
    ["Account changed. Open waiting plays again."] = "Konto geändert. Wartende Wiedergaben erneut öffnen.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "So funktioniert das Last.fm-Scrobbeln:\n\n1. 30-Sekunden-Regel: Titel unter 30 Sekunden werden nicht gescrobbelt.\n\n2. Hörschwelle: Eine Wiedergabe zählt nach der halben Dauer oder 4 Minuten (was zuerst eintritt).\n\n3. Pause & Spulen: Pausierte oder gespulte Zeit zählt nicht zur Schwelle.\n\n4. Offline-Warteschlange: Bis zu 100 Wiedergaben (64 KB) werden offline gespeichert und bei Verbindung gesendet.\n\n5. Lokaler Ablauf: Dieser Player behält wartende Wiedergaben bis zu 13 Tage.\n\n6. Kontentrennung: Offline-Warteschlangen werden pro Last.fm-Benutzername getrennt gespeichert.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Anmeldung: Compás leitet deine Zugangsdaten über HTTPS an Last.fm weiter; dein Passwort wird niemals gespeichert.",
    ["How Scrobbling Works"] = "So funktioniert Scrobbeln",
    ["Tracks >= 30s only"] = "Nur Titel ab 30s",
    ["Listened 50% or 4 min"] = "50% oder 4 Min. gehört",
    ["Pauses do not count"] = "Pausen zählen nicht",
    ["Up to 100 offline plays"] = "Bis zu 100 Offline-Wiedergaben",
    ["13-day age limit"] = "13 Tage Ablaufzeit",
    ["Separate queue per user"] = "Eigene Warteschlange pro Benutzer",
    ["Credentials forwarded; password never stored"] = "Zugangsdaten weitergeleitet; Passwort nie gespeichert",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Compás-Anmeldedienst leitet Zugangsdaten an Last.fm weiter; Passwort wird nie gespeichert.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Titel >= 30s scrobbeln nach 50% oder 4 Min. 100 Offline-Wiedergaben in Warteschlange.",
    ["API Key: Configured"] = "API-Schlüssel: Konfiguriert",
    ["API Key: Not configured"] = "API-Schlüssel: Nicht konfiguriert",
    ["API Secret: Configured"] = "API-Secret: Konfiguriert",
    ["API Secret: Not configured"] = "API-Secret: Nicht konfiguriert",
    ["Sign In to Last.fm"] = "Bei Last.fm anmelden",
    ["Sign Out (%s)"] = "Abmelden (%s)",
    ["Discard waiting plays (%d)"] = "Wartende Wiedergaben verwerfen (%d)",
    ["Status: Signing in…"] = "Status: Anmeldung läuft…",
    ["Sign-in is currently in progress."] = "Anmeldung läuft derzeit.",
    ["Cancel sign-in"] = "Anmeldung abbrechen",
    ["Account & settings"] = "Konto & Einstellungen",
    ["Status: API key/secret rejected"] = "Status: API-Schlüssel/Secret abgelehnt",
    ["Status: %s"] = "Status: %s",
    ["Signed in as %s"] = "Angemeldet als %s",
    ["This track: No music playing"] = "Dieser Titel: Keine Musikwiedergabe",
    ["This track: Scrobbling off"] = "Dieser Titel: Scrobbeln aus",
    ["This track: Reading length"] = "Dieser Titel: Dauer wird gelesen",
    ["This track: Too short (<30s)"] = "Dieser Titel: Zu kurz (<30s)",
    ["This track: Starts counting next song"] = "Dieser Titel: Zählt ab nächstem Titel",
    ["This track: %s"] = "Dieser Titel: %s",
    ["This track: This listen not counted"] = "Dieser Titel: Dieses Anhören wird nicht gezählt",
    ["This track: Playback paused"] = "Dieser Titel: Wiedergabe pausiert",
    ["This track: Counts after %s"] = "Dieser Titel: Zählt nach %s",
    ["No track playing."] = "Kein Titel wird abgespielt.",
    ["Scrobbling"] = "Scrobbeln",
    ["Scrobbling: %s"] = "Scrobbeln: %s",
    ["Scrobbling\n%s"] = "Scrobbeln\n%s",
    ["Scrobbling turned on."] = "Scrobbeln aktiviert.",
    ["Scrobbling turned off."] = "Scrobbeln deaktiviert.",
    ["Waiting plays could not be read"] = "Wartende Wiedergaben konnten nicht gelesen werden",
    ["%d play waiting"] = "%d Wiedergabe wartet",
    ["%d plays waiting"] = "%d Wiedergaben warten",
    ["Sending…"] = "Senden…",
    ["waiting for Wi-Fi"] = "wartet auf Wi-Fi",
    ["next try %dm"] = "nächster Versuch in %dm",
    ["sent %s"] = "gesendet %s",
    ["Sync now"] = "Jetzt synchronisieren",
  },
  es = {
    ["LastFM Scrobbler V2"] = "Scrobbler de Last.fm V2",
    ["LastFM Scrobbler V2 Settings"] = "Ajustes de Last.fm Scrobbler V2",
    ["Could not remove an old Last.fm file from the SD card"] = "No se pudo eliminar un archivo antiguo de Last.fm de la tarjeta SD",
    ["Could not open text entry. Try again."] = "No se pudo abrir la entrada de texto. Inténtalo de nuevo.",
    ["Saved account could not be read. Sign in again."] = "No se pudo leer la cuenta guardada. Inicia sesión de nuevo.",
    ["Last.fm service not configured."] = "Servicio de Last.fm no configurado.",
    ["Session expired. Sign in again."] = "Sesión caducada. Inicia sesión de nuevo.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Sesión caducada; no se pudo guardar el cierre de sesión. Inicia sesión de nuevo.",
    ["Last.fm not reachable."] = "No se puede conectar con Last.fm.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi apagado — se enviará al conectar",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi no conectado — se enviará al conectar",
    ["Waiting list could not be updated."] = "No se pudo actualizar la lista de espera.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Enviado, pero no se pudo guardar la limpieza de la lista de espera.",
    ["Last.fm service problem."] = "Problema del servicio Last.fm.",
    ["API key or secret rejected by Last.fm."] = "Last.fm rechazó la clave o el secreto de API.",
    ["API key or secret rejected by Last.fm. Check settings."] = "Last.fm rechazó la clave o el secreto de API. Revisa los ajustes.",
    ["Last.fm rejected this play"] = "Last.fm rechazó esta reproducción",
    ["Last.fm temporarily busy."] = "Last.fm está ocupado temporalmente.",
    ["Could not send scrobble request."] = "No se pudo enviar la solicitud de scrobble.",
    ["Not counted by Last.fm"] = "No contabilizado por Last.fm",
    ["Sent to Last.fm"] = "Enviado a Last.fm",
    ["Waiting to send"] = "Esperando para enviar",
    ["Not saved yet"] = "Aún no guardado",
    ["Discarded by you"] = "Descartado por ti",
    ["Check your API key and shared secret in Account settings."] = "Revisa tu clave de API y el secreto compartido en Ajustes de la cuenta.",
    ["Sign in before sending waiting plays."] = "Inicia sesión antes de enviar las reproducciones en espera.",
    ["Turn scrobbling on before sending waiting plays."] = "Activa el scrobbling antes de enviar las reproducciones en espera.",
    ["Waiting plays could not be read."] = "No se pudieron leer las reproducciones en espera.",
    ["No plays are waiting to send."] = "No hay reproducciones esperando para enviar.",
    ["Already sending waiting plays."] = "Ya se están enviando las reproducciones en espera.",
    ["Sending waiting plays…"] = "Enviando reproducciones en espera…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "La lista de espera está llena o no disponible. Reproducción aún no guardada.",
    ["Could not save scrobbling preference. Try again."] = "No se pudo guardar la preferencia de scrobbling. Inténtalo de nuevo.",
    ["API key cannot contain control characters."] = "La clave de API no puede contener caracteres de control.",
    ["Use the 32-character API key without spaces."] = "Usa la clave de API de 32 caracteres sin espacios.",
    ["API key saved."] = "Clave de API guardada.",
    ["Could not save API key. Try again."] = "No se pudo guardar la clave de API. Inténtalo de nuevo.",
    ["API secret cannot contain control characters."] = "El secreto de API no puede contener caracteres de control.",
    ["Shared secret saved."] = "Secreto compartido guardado.",
    ["Could not save shared secret. Try again."] = "No se pudo guardar el secreto compartido. Inténtalo de nuevo.",
    ["Sign-in cancelled."] = "Inicio de sesión cancelado.",
    ["Signing in…"] = "Iniciando sesión…",
    ["Logging in to Last.fm…"] = "Iniciando sesión en Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Cuenta guardada. Toca Scrobbling para activarlo.",
    ["Logged in to Last.fm as %s"] = "Sesión iniciada en Last.fm como %s",
    ["Last.fm service problem. Sign in again."] = "Problema del servicio Last.fm. Inicia sesión de nuevo.",
    ["Could not save session."] = "No se pudo guardar la sesión.",
    ["Username or password incorrect."] = "Usuario o contraseña incorrectos.",
    ["API key suspended by Last.fm."] = "Clave de API suspendida por Last.fm.",
    ["Last.fm is not reachable. Check network."] = "No se puede conectar con Last.fm. Comprueba la red.",
    ["Could not log in to Last.fm. Check details."] = "No se pudo iniciar sesión en Last.fm. Comprueba los datos.",
    ["Could not start login request."] = "No se pudo iniciar la solicitud de acceso.",
    ["Last.fm API key"] = "Clave de API de Last.fm",
    ["Last.fm Shared Secret"] = "Secreto compartido de Last.fm",
    ["Last.fm Username"] = "Usuario de Last.fm",
    ["Last.fm Password"] = "Contraseña de Last.fm",
    ["Invalid username."] = "Nombre de usuario no válido.",
    ["Password cannot contain control characters."] = "La contraseña no puede contener caracteres de control.",
    ["Last.fm setup is already complete."] = "La configuración de Last.fm ya está completa.",
    ["Set up Last.fm"] = "Configurar Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Para hacer scrobbling a Last.fm:\n\n1. En un teléfono u ordenador, inicia sesión en Last.fm.\n\n2. Abre esta dirección:\nlast.fm/api/account/create\n\n3. Crea una aplicación (cualquier nombre sirve).\n\n4. Si te pide callback URL, introduce http://localhost\n\n5. Obtén tu clave de API y el secreto compartido.\n\nCierra esta página para introducirlos.",
    ["Could not open setup guide."] = "No se pudo abrir la guía de configuración.",
    ["Create an app at last.fm/api/account/create"] = "Crea una app en last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Añade primero tus credenciales de API de Last.fm.",
    ["Already signed in to Last.fm."] = "Ya has iniciado sesión en Last.fm.",
    ["Sign-in already in progress."] = "Inicio de sesión ya en curso.",
    ["Press Back."] = "Pulsa Atrás.",
    ["Sign out?"] = "¿Cerrar sesión?",
    ["Keep signed in"] = "Mantener sesión",
    ["Sign out %s"] = "Cerrar sesión de %s",
    ["Kept signed in."] = "Sesión mantenida.",
    ["Account changed. Nothing changed."] = "La cuenta ha cambiado. No se modificó nada.",
    ["Could not save sign-out. Try again."] = "No se pudo guardar el cierre de sesión. Inténtalo de nuevo.",
    ["Signed out. Waiting plays are kept for this account."] = "Sesión cerrada. Las reproducciones en espera se conservan para esta cuenta.",
    ["Waiting plays could not be read. Nothing discarded."] = "No se pudieron leer las reproducciones en espera. No se descartó nada.",
    ["No waiting plays to discard."] = "No hay reproducciones en espera para descartar.",
    ["Discard %d plays?"] = "¿Descartar %d reproducciones?",
    ["Keep waiting plays"] = "Conservar reproducciones en espera",
    ["Discard %d plays"] = "Descartar %d reproducciones",
    ["Kept waiting plays."] = "Reproducciones en espera conservadas.",
    ["Account changed. Nothing discarded."] = "La cuenta ha cambiado. No se descartó nada.",
    ["Waiting plays discarded."] = "Reproducciones en espera descartadas.",
    ["Could not discard plays. Try again."] = "No se pudieron descartar las reproducciones. Inténtalo de nuevo.",
    ["No account has waiting plays yet."] = "Ninguna cuenta tiene reproducciones en espera todavía.",
    ["Waiting plays could not be read. Nothing removed."] = "No se pudieron leer las reproducciones en espera. No se eliminó nada.",
    ["Waiting plays"] = "Reproducciones en espera",
    ["No plays are waiting to send"] = "No hay reproducciones esperando para enviar",
    ["Qualified plays send automatically."] = "Las reproducciones aptas se envían automáticamente.",
    ["%d plays kept for %s"] = "%d reproducciones guardadas para %s",
    ["Oldest plays are sent first."] = "Las reproducciones más antiguas se envían primero.",
    ["Send waiting plays now"] = "Enviar reproducciones en espera ahora",
    ["Saved: %s"] = "Guardado: %s",
    ["Saved time unavailable"] = "Hora de guardado no disponible",
    ["Discard waiting plays…"] = "Descartar reproducciones en espera…",
    ["Account changed. Open waiting plays again."] = "La cuenta ha cambiado. Abre las reproducciones en espera de nuevo.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Cómo funciona el scrobbling de Last.fm:\n\n1. Regla de 30 segundos: Las pistas de menos de 30 segundos no se envían.\n\n2. Umbral de escucha: Una reproducción califica tras la mitad de su duración o 4 minutos (lo que ocurra antes).\n\n3. Pausas y búsqueda: El tiempo en pausa o buscando no cuenta para el umbral.\n\n4. Cola sin conexión: Se guardan hasta 100 reproducciones (64 KB) y se envían al conectar.\n\n5. Caducidad local: Este reproductor conserva las reproducciones hasta 13 días.\n\n6. Separación por cuenta: Las colas sin conexión se guardan por separado según el usuario de Last.fm.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Inicio de sesión: Compás reenvía tus credenciales a Last.fm mediante HTTPS; tu contraseña nunca se guarda.",
    ["How Scrobbling Works"] = "Cómo funciona el scrobbling",
    ["Tracks >= 30s only"] = "Solo pistas >= 30s",
    ["Listened 50% or 4 min"] = "50% o 4 min escuchados",
    ["Pauses do not count"] = "Las pausas no cuentan",
    ["Up to 100 offline plays"] = "Hasta 100 reproducciones sin conexión",
    ["13-day age limit"] = "Límite de 13 días",
    ["Separate queue per user"] = "Cola separada por usuario",
    ["Credentials forwarded; password never stored"] = "Credenciales reenviadas; contraseña nunca guardada",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "El servicio de acceso de Compás reenvía credenciales a Last.fm; la contraseña nunca se guarda.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Pistas >= 30s hacen scrobble tras 50% o 4 min. 100 reproducciones en cola sin conexión.",
    ["API Key: Configured"] = "Clave de API: Configurada",
    ["API Key: Not configured"] = "Clave de API: No configurada",
    ["API Secret: Configured"] = "Secreto de API: Configurado",
    ["API Secret: Not configured"] = "Secreto de API: No configurado",
    ["Sign In to Last.fm"] = "Iniciar sesión en Last.fm",
    ["Sign Out (%s)"] = "Cerrar sesión (%s)",
    ["Discard waiting plays (%d)"] = "Descartar reproducciones en espera (%d)",
    ["Status: Signing in…"] = "Estado: Iniciando sesión…",
    ["Sign-in is currently in progress."] = "El inicio de sesión está actualmente en curso.",
    ["Cancel sign-in"] = "Cancelar inicio de sesión",
    ["Account & settings"] = "Cuenta y ajustes",
    ["Status: API key/secret rejected"] = "Estado: Clave/secreto de API rechazados",
    ["Status: %s"] = "Estado: %s",
    ["Signed in as %s"] = "Sesión iniciada como %s",
    ["This track: No music playing"] = "Esta pista: No hay música reproduciéndose",
    ["This track: Scrobbling off"] = "Esta pista: Scrobbling desactivado",
    ["This track: Reading length"] = "Esta pista: Leyendo duración",
    ["This track: Too short (<30s)"] = "Esta pista: Demasiado corta (<30s)",
    ["This track: Starts counting next song"] = "Esta pista: Empieza a contar en la siguiente canción",
    ["This track: %s"] = "Esta pista: %s",
    ["This track: This listen not counted"] = "Esta pista: Esta escucha no se cuenta",
    ["This track: Playback paused"] = "Esta pista: Reproducción en pausa",
    ["This track: Counts after %s"] = "Esta pista: Cuenta tras %s",
    ["No track playing."] = "No se está reproduciendo ninguna pista.",
    ["Scrobbling"] = "Scrobbling",
    ["Scrobbling: %s"] = "Scrobbling: %s",
    ["Scrobbling\n%s"] = "Scrobbling\n%s",
    ["Scrobbling turned on."] = "Scrobbling activado.",
    ["Scrobbling turned off."] = "Scrobbling desactivado.",
    ["Waiting plays could not be read"] = "No se pudieron leer las reproducciones en espera",
    ["%d play waiting"] = "%d reproducción en espera",
    ["%d plays waiting"] = "%d reproducciones en espera",
    ["Sending…"] = "Enviando…",
    ["waiting for Wi-Fi"] = "esperando Wi-Fi",
    ["next try %dm"] = "próximo intento en %dm",
    ["sent %s"] = "enviado %s",
    ["Sync now"] = "Sincronizar ahora",
  },
  fi = {
    ["LastFM Scrobbler V2"] = "Last.fm-skrobbleri V2",
    ["LastFM Scrobbler V2 Settings"] = "Last.fm-skrobbleri V2 -asetukset",
    ["Could not remove an old Last.fm file from the SD card"] = "Vanhaa Last.fm-tiedostoa ei voitu poistaa SD-kortilta",
    ["Could not open text entry. Try again."] = "Tekstinsyöttöä ei voitu avata. Yritä uudelleen.",
    ["Saved account could not be read. Sign in again."] = "Tallennettua tiliä ei voitu lukea. Kirjaudu uudelleen.",
    ["Last.fm service not configured."] = "Last.fm-palvelua ei ole määritetty.",
    ["Session expired. Sign in again."] = "Istunto vanheni. Kirjaudu uudelleen.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Istunto vanheni; uloskirjautumista ei voitu tallentaa. Kirjaudu uudelleen.",
    ["Last.fm not reachable."] = "Last.fm ei ole tavoitettavissa.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi pois päältä — lähetetään yhdistettäessä",
    ["Wi-Fi not connected — will send when connected"] = "Ei Wi-Fi-yhteyttä — lähetetään yhdistettäessä",
    ["Waiting list could not be updated."] = "Odotuslistaa ei voitu päivittää.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Lähetetty, mutta odotuslistan siivousta ei voitu tallentaa.",
    ["Last.fm service problem."] = "Last.fm-palvelun ongelma.",
    ["API key or secret rejected by Last.fm."] = "Last.fm hylkäsi API-avaimen tai salaisuuden.",
    ["API key or secret rejected by Last.fm. Check settings."] = "Last.fm hylkäsi API-avaimen tai salaisuuden. Tarkista asetukset.",
    ["Last.fm rejected this play"] = "Last.fm hylkäsi tämän toiston",
    ["Last.fm temporarily busy."] = "Last.fm on tilapäisesti varattu.",
    ["Could not send scrobble request."] = "Skrobblauspyyntöä ei voitu lähettää.",
    ["Not counted by Last.fm"] = "Last.fm ei laskenut",
    ["Sent to Last.fm"] = "Lähetetty Last.fm-palveluun",
    ["Waiting to send"] = "Odottaa lähetystä",
    ["Not saved yet"] = "Ei vielä tallennettu",
    ["Discarded by you"] = "Hylkäsit tämän",
    ["Check your API key and shared secret in Account settings."] = "Tarkista API-avain ja jaettu salaisuus tilin asetuksista.",
    ["Sign in before sending waiting plays."] = "Kirjaudu sisään ennen odottavien toistojen lähettämistä.",
    ["Turn scrobbling on before sending waiting plays."] = "Ota skrobblaus käyttöön ennen odottavien toistojen lähettämistä.",
    ["Waiting plays could not be read."] = "Odottavia toistoja ei voitu lukea.",
    ["No plays are waiting to send."] = "Ei lähettämistä odottavia toistoja.",
    ["Already sending waiting plays."] = "Odottavia toistoja lähetetään jo.",
    ["Sending waiting plays…"] = "Lähetetään odottavia toistoja…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "Odotuslista on täysi tai ei saatavilla. Toistoa ei vielä tallennettu.",
    ["Could not save scrobbling preference. Try again."] = "Skrobbailuasetusta ei voitu tallentaa. Yritä uudelleen.",
    ["API key cannot contain control characters."] = "API-avain ei voi sisältää ohjausmerkkejä.",
    ["Use the 32-character API key without spaces."] = "Käytä 32-merkkistä API-avainta ilman välilyöntejä.",
    ["API key saved."] = "API-avain tallennettu.",
    ["Could not save API key. Try again."] = "API-avainta ei voitu tallentaa. Yritä uudelleen.",
    ["API secret cannot contain control characters."] = "API-salaisuus ei voi sisältää ohjausmerkkejä.",
    ["Shared secret saved."] = "Jaettu salaisuus tallennettu.",
    ["Could not save shared secret. Try again."] = "Jaettua salaisuutta ei voitu tallentaa. Yritä uudelleen.",
    ["Sign-in cancelled."] = "Kirjautuminen peruttu.",
    ["Signing in…"] = "Kirjaudutaan sisään…",
    ["Logging in to Last.fm…"] = "Kirjaudutaan Last.fm-palveluun…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Tili tallennettu. Napauta Skrobbailu ottaaksesi käyttöön.",
    ["Logged in to Last.fm as %s"] = "Kirjauduttu Last.fm-palveluun käyttäjänä %s",
    ["Last.fm service problem. Sign in again."] = "Last.fm-palvelun ongelma. Kirjaudu uudelleen.",
    ["Could not save session."] = "Istuntoa ei voitu tallentaa.",
    ["Username or password incorrect."] = "Käyttäjätunnus tai salasana on väärä.",
    ["API key suspended by Last.fm."] = "Last.fm on jäädyttänyt API-avaimen.",
    ["Last.fm is not reachable. Check network."] = "Last.fm ei ole tavoitettavissa. Tarkista verkko.",
    ["Could not log in to Last.fm. Check details."] = "Kirjautuminen Last.fm-palveluun epäonnistui. Tarkista tiedot.",
    ["Could not start login request."] = "Kirjautumispyyntöä ei voitu aloittaa.",
    ["Last.fm API key"] = "Last.fm API -avain",
    ["Last.fm Shared Secret"] = "Last.fm jaettu salaisuus",
    ["Last.fm Username"] = "Last.fm-käyttäjätunnus",
    ["Last.fm Password"] = "Last.fm-salasana",
    ["Invalid username."] = "Virheellinen käyttäjätunnus.",
    ["Password cannot contain control characters."] = "Salasana ei voi sisältää ohjausmerkkejä.",
    ["Last.fm setup is already complete."] = "Last.fm-asennus on jo valmis.",
    ["Set up Last.fm"] = "Määritä Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Skroblataksesi musiikkia Last.fm-palveluun:\n\n1. Kirjaudu Last.fm-palveluun puhelimella tai tietokoneella.\n\n2. Avaa osoite:\nlast.fm/api/account/create\n\n3. Luo sovellus (mikä tahansa nimi käy).\n\n4. Jos kysytään paluuosoitetta (callback URL), syötä http://localhost\n\n5. Hanki API-avain ja jaettu salaisuus.\n\nSulje tämä sivu syöttääksesi ne.",
    ["Could not open setup guide."] = "Käyttöönopasta ei voitu avata.",
    ["Create an app at last.fm/api/account/create"] = "Luo sovellus osoitteessa last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Lisää ensin Last.fm API -tunnuksesi.",
    ["Already signed in to Last.fm."] = "Olet jo kirjautunut Last.fm-palveluun.",
    ["Sign-in already in progress."] = "Kirjautuminen on jo käynnissä.",
    ["Press Back."] = "Paina Takaisin.",
    ["Sign out?"] = "Kirjaudutaanko ulos?",
    ["Keep signed in"] = "Pysy kirjautuneena",
    ["Sign out %s"] = "Kirjaa ulos %s",
    ["Kept signed in."] = "Pysyttiin kirjautuneena.",
    ["Account changed. Nothing changed."] = "Tili muuttui. Mitään ei muutettu.",
    ["Could not save sign-out. Try again."] = "Uloskirjautumista ei voitu tallentaa. Yritä uudelleen.",
    ["Signed out. Waiting plays are kept for this account."] = "Kirjauduttu ulos. Odottavat toistot säilytetään tälle tilille.",
    ["Waiting plays could not be read. Nothing discarded."] = "Odottavia toistoja ei voitu lukea. Mitään ei hylätty.",
    ["No waiting plays to discard."] = "Ei hylättäviä odottavia toistoja.",
    ["Discard %d plays?"] = "Hylätäänkö %d toistoa?",
    ["Keep waiting plays"] = "Säilytä odottavat toistot",
    ["Discard %d plays"] = "Hylkää %d toistoa",
    ["Kept waiting plays."] = "Odottavat toistot säilytetty.",
    ["Account changed. Nothing discarded."] = "Tili muuttui. Mitään ei hylätty.",
    ["Waiting plays discarded."] = "Odottavat toistot hylätty.",
    ["Could not discard plays. Try again."] = "Toistoja ei voitu hylätä. Yritä uudelleen.",
    ["No account has waiting plays yet."] = "Millään tilillä ei ole vielä odottavia toistoja.",
    ["Waiting plays could not be read. Nothing removed."] = "Odottavia toistoja ei voitu lukea. Mitään ei poistettu.",
    ["Waiting plays"] = "Odottavat toistot",
    ["No plays are waiting to send"] = "Ei lähettämistä odottavia toistoja",
    ["Qualified plays send automatically."] = "Kelvolliset toistot lähetetään automaattisesti.",
    ["%d plays kept for %s"] = "%d toistoa säilytetty käyttäjälle %s",
    ["Oldest plays are sent first."] = "Vanhimmat toistot lähetetään ensin.",
    ["Send waiting plays now"] = "Lähetä odottavat toistot nyt",
    ["Saved: %s"] = "Tallennettu: %s",
    ["Saved time unavailable"] = "Tallennusaika ei saatavilla",
    ["Discard waiting plays…"] = "Hylkää odottavat toistot…",
    ["Account changed. Open waiting plays again."] = "Tili muuttui. Avaa odottavat toistot uudelleen.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Miten Last.fm-skrobblaus toimii:\n\n1. 30 sekunnin sääntö: Alle 30 sekunnin kappaleita ei skroblata.\n\n2. Kuuntelukynnys: Toisto hyväksytään puolivälissä tai 4 minuutin jälkeen (kumpi täyttyy ensin).\n\n3. Tauot ja kelaus: Tauolla tai kelatessa vietettyä aikaa ei lasketa kynnykseen.\n\n4. Offline-jono: Jopa 100 toistoa (64 KB) tallennetaan offline-tilassa ja lähetetään yhdistettäessä.\n\n5. Paikallinen vanheneminen: Tämä soitin säilyttää odottavia toistoja enintään 13 päivää.\n\n6. Tilikohtainen erottelu: Offline-jonot tallennetaan erikseen kullekin Last.fm-käyttäjälle.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Kirjautuminen: Compás välittää kirjautumistietosi Last.fm-palveluun HTTPS-yhteydellä; salasanaasi ei koskaan tallenneta.",
    ["How Scrobbling Works"] = "Kuinka skrobblaus toimii",
    ["Tracks >= 30s only"] = "Vain kappaleet >= 30s",
    ["Listened 50% or 4 min"] = "Kuunneltu 50 % tai 4 min",
    ["Pauses do not count"] = "Taukoja ei lasketa",
    ["Up to 100 offline plays"] = "Jopa 100 offline-toistoa",
    ["13-day age limit"] = "13 päivän aikaraja",
    ["Separate queue per user"] = "Erillinen jono käyttäjää kohden",
    ["Credentials forwarded; password never stored"] = "Tunnukset välitetty; salasanaa ei koskaan tallenneta",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Compás-kirjautumispalvelu välittää tunnukset Last.fm-palveluun; salasanaa ei koskaan tallenneta.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Kappaleet >= 30s skroblataan 50 % tai 4 min jälkeen. 100 offline-toistoa jonossa.",
    ["API Key: Configured"] = "API-avain: Määritetty",
    ["API Key: Not configured"] = "API-avain: Ei määritetty",
    ["API Secret: Configured"] = "API-salaisuus: Määritetty",
    ["API Secret: Not configured"] = "API-salaisuus: Ei määritetty",
    ["Sign In to Last.fm"] = "Kirjaudu Last.fm-palveluun",
    ["Sign Out (%s)"] = "Kirjaudu ulos (%s)",
    ["Discard waiting plays (%d)"] = "Hylkää odottavat toistot (%d)",
    ["Status: Signing in…"] = "Tila: Kirjaudutaan sisään…",
    ["Sign-in is currently in progress."] = "Kirjautuminen on parhaillaan käynnissä.",
    ["Cancel sign-in"] = "Peruuta kirjautuminen",
    ["Account & settings"] = "Tili ja asetukset",
    ["Status: API key/secret rejected"] = "Tila: API-avain/salaisuus hylätty",
    ["Status: %s"] = "Tila: %s",
    ["Signed in as %s"] = "Kirjauduttu nimellä %s",
    ["This track: No music playing"] = "Tämä kappale: Musiikkia ei toisteta",
    ["This track: Scrobbling off"] = "Tämä kappale: Skrobblaus pois päältä",
    ["This track: Reading length"] = "Tämä kappale: Luetaan kestoa",
    ["This track: Too short (<30s)"] = "Tämä kappale: Liian lyhyt (<30s)",
    ["This track: Starts counting next song"] = "Tämä kappale: Aloittaa laskennan seuraavasta kappaleesta",
    ["This track: %s"] = "Tämä kappale: %s",
    ["This track: This listen not counted"] = "Tämä kappale: Tätä kuuntelua ei lasketa",
    ["This track: Playback paused"] = "Tämä kappale: Toisto keskeytetty",
    ["This track: Counts after %s"] = "Tämä kappale: Lasketaan %s jälkeen",
    ["No track playing."] = "Kappaletta ei toisteta.",
    ["Scrobbling"] = "Skrobblaus",
    ["Scrobbling: %s"] = "Skrobblaus: %s",
    ["Scrobbling\n%s"] = "Skrobblaus\n%s",
    ["Scrobbling turned on."] = "Skrobblaus kytketty päälle.",
    ["Scrobbling turned off."] = "Skrobblaus kytketty pois päältä.",
    ["Waiting plays could not be read"] = "Odottavia toistoja ei voitu lukea",
    ["%d play waiting"] = "%d toisto odottaa",
    ["%d plays waiting"] = "%d toistoa odottaa",
    ["Sending…"] = "Lähetetään…",
    ["waiting for Wi-Fi"] = "odottaa Wi-Fi-yhteyttä",
    ["next try %dm"] = "seuraava yritys %d min",
    ["sent %s"] = "lähetetty %s",
    ["Sync now"] = "Synkronoi nyt",
  },
  fr = {
    ["LastFM Scrobbler V2"] = "Scrobbler Last.fm V2",
    ["LastFM Scrobbler V2 Settings"] = "Réglages Scrobbler Last.fm V2",
    ["Could not remove an old Last.fm file from the SD card"] = "Impossible de supprimer un ancien fichier Last.fm de la carte SD",
    ["Could not open text entry. Try again."] = "Impossible d'ouvrir la saisie de texte. Réessayez.",
    ["Saved account could not be read. Sign in again."] = "Impossible de lire le compte enregistré. Reconnectez-vous.",
    ["Last.fm service not configured."] = "Service Last.fm non configuré.",
    ["Session expired. Sign in again."] = "Session expirée. Reconnectez-vous.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Session expirée ; déconnexion non enregistrée. Reconnectez-vous.",
    ["Last.fm not reachable."] = "Last.fm injoignable.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi désactivé — envoi dès connexion",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi non connecté — envoi dès connexion",
    ["Waiting list could not be updated."] = "Impossible de mettre à jour la file d'attente.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Envoyé, mais nettoyage de la file d'attente non enregistré.",
    ["Last.fm service problem."] = "Problème du service Last.fm.",
    ["API key or secret rejected by Last.fm."] = "Clé ou secret d'API rejeté par Last.fm.",
    ["API key or secret rejected by Last.fm. Check settings."] = "Clé ou secret d'API rejeté par Last.fm. Vérifiez les réglages.",
    ["Last.fm rejected this play"] = "Last.fm a rejeté cette lecture",
    ["Last.fm temporarily busy."] = "Last.fm est temporairement occupé.",
    ["Could not send scrobble request."] = "Impossible d'envoyer la demande de scrobble.",
    ["Not counted by Last.fm"] = "Non comptabilisé par Last.fm",
    ["Sent to Last.fm"] = "Envoyé à Last.fm",
    ["Waiting to send"] = "En attente d'envoi",
    ["Not saved yet"] = "Pas encore enregistré",
    ["Discarded by you"] = "Rejeté par vous",
    ["Check your API key and shared secret in Account settings."] = "Vérifiez votre clé d'API et secret partagé dans les réglages du compte.",
    ["Sign in before sending waiting plays."] = "Connectez-vous avant d'envoyer les lectures en attente.",
    ["Turn scrobbling on before sending waiting plays."] = "Activez le scrobbling avant d'envoyer les lectures en attente.",
    ["Waiting plays could not be read."] = "Impossible de lire les lectures en attente.",
    ["No plays are waiting to send."] = "Aucune lecture en attente d'envoi.",
    ["Already sending waiting plays."] = "Envoi des lectures en attente déjà en cours.",
    ["Sending waiting plays…"] = "Envoi des lectures en attente…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "File d'attente pleine ou indisponible. Lecture pas encore enregistrée.",
    ["Could not save scrobbling preference. Try again."] = "Impossible d'enregistrer la préférence de scrobble. Réessayez.",
    ["API key cannot contain control characters."] = "La clé d'API ne peut pas contenir de caractères de contrôle.",
    ["Use the 32-character API key without spaces."] = "Utilisez la clé d'API de 32 caractères sans espaces.",
    ["API key saved."] = "Clé d'API enregistrée.",
    ["Could not save API key. Try again."] = "Impossible d'enregistrer la clé d'API. Réessayez.",
    ["API secret cannot contain control characters."] = "Le secret d'API ne peut pas contenir de caractères de contrôle.",
    ["Shared secret saved."] = "Secret partagé enregistré.",
    ["Could not save shared secret. Try again."] = "Impossible d'enregistrer le secret partagé. Réessayez.",
    ["Sign-in cancelled."] = "Connexion annulée.",
    ["Signing in…"] = "Connexion en cours…",
    ["Logging in to Last.fm…"] = "Connexion à Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Compte enregistré. Touchez Scrobbling pour l'activer.",
    ["Logged in to Last.fm as %s"] = "Connecté à Last.fm en tant que %s",
    ["Last.fm service problem. Sign in again."] = "Problème du service Last.fm. Reconnectez-vous.",
    ["Could not save session."] = "Impossible d'enregistrer la session.",
    ["Username or password incorrect."] = "Nom d'utilisateur ou mot de passe incorrect.",
    ["API key suspended by Last.fm."] = "Clé d'API suspendue par Last.fm.",
    ["Last.fm is not reachable. Check network."] = "Last.fm injoignable. Vérifiez le réseau.",
    ["Could not log in to Last.fm. Check details."] = "Impossible de se connecter à Last.fm. Vérifiez vos identifiants.",
    ["Could not start login request."] = "Impossible de lancer la demande de connexion.",
    ["Last.fm API key"] = "Clé d'API Last.fm",
    ["Last.fm Shared Secret"] = "Secret partagé Last.fm",
    ["Last.fm Username"] = "Nom d'utilisateur Last.fm",
    ["Last.fm Password"] = "Mot de passe Last.fm",
    ["Invalid username."] = "Nom d'utilisateur invalide.",
    ["Password cannot contain control characters."] = "Le mot de passe ne peut pas contenir de caractères de contrôle.",
    ["Last.fm setup is already complete."] = "La configuration de Last.fm est déjà terminée.",
    ["Set up Last.fm"] = "Configurer Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Pour scrobbler de la musique sur Last.fm :\n\n1. Sur un téléphone ou ordinateur, connectez-vous à Last.fm.\n\n2. Ouvrez cette adresse :\nlast.fm/api/account/create\n\n3. Créez une application (le nom importe peu).\n\n4. Si demandé pour callback URL, entrez http://localhost\n\n5. Obtenez votre clé d'API et secret partagé.\n\nFermez cette page pour les saisir.",
    ["Could not open setup guide."] = "Impossible d'ouvrir le guide de configuration.",
    ["Create an app at last.fm/api/account/create"] = "Créez une application sur last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Ajoutez d'abord vos identifiants d'API Last.fm.",
    ["Already signed in to Last.fm."] = "Déjà connecté à Last.fm.",
    ["Sign-in already in progress."] = "Connexion déjà en cours.",
    ["Press Back."] = "Appuyez sur Retour.",
    ["Sign out?"] = "Se déconnecter ?",
    ["Keep signed in"] = "Rester connecté",
    ["Sign out %s"] = "Déconnecter %s",
    ["Kept signed in."] = "Session maintenue.",
    ["Account changed. Nothing changed."] = "Compte modifié. Rien n'a changé.",
    ["Could not save sign-out. Try again."] = "Impossible d'enregistrer la déconnexion. Réessayez.",
    ["Signed out. Waiting plays are kept for this account."] = "Déconnecté. Les lectures en attente sont conservées pour ce compte.",
    ["Waiting plays could not be read. Nothing discarded."] = "Impossible de lire les lectures en attente. Rien n'a été rejeté.",
    ["No waiting plays to discard."] = "Aucune lecture en attente à rejeter.",
    ["Discard %d plays?"] = "Rejeter %d lectures ?",
    ["Keep waiting plays"] = "Conserver les lectures en attente",
    ["Discard %d plays"] = "Rejeter %d lectures",
    ["Kept waiting plays."] = "Lectures en attente conservées.",
    ["Account changed. Nothing discarded."] = "Compte modifié. Rien n'a été rejeté.",
    ["Waiting plays discarded."] = "Lectures en attente rejetées.",
    ["Could not discard plays. Try again."] = "Impossible de rejeter les lectures. Réessayez.",
    ["No account has waiting plays yet."] = "Aucun compte n'a encore de lectures en attente.",
    ["Waiting plays could not be read. Nothing removed."] = "Impossible de lire les lectures en attente. Rien n'a été supprimé.",
    ["Waiting plays"] = "Lectures en attente",
    ["No plays are waiting to send"] = "Aucune lecture en attente d'envoi",
    ["Qualified plays send automatically."] = "Les lectures éligibles sont envoyées automatiquement.",
    ["%d plays kept for %s"] = "%d lectures conservées pour %s",
    ["Oldest plays are sent first."] = "Les lectures les plus anciennes sont envoyées en premier.",
    ["Send waiting plays now"] = "Envoyer les lectures en attente maintenant",
    ["Saved: %s"] = "Enregistré : %s",
    ["Saved time unavailable"] = "Heure d'enregistrement indisponible",
    ["Discard waiting plays…"] = "Rejeter les lectures en attente…",
    ["Account changed. Open waiting plays again."] = "Compte modifié. Rouvrez les lectures en attente.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Fonctionnement du scrobble Last.fm :\n\n1. Règle des 30 secondes : Les morceaux de moins de 30 secondes ne sont pas scrobblés.\n\n2. Seuil d'écoute : Une lecture est validée après la moitié de sa durée ou 4 minutes (au premier des deux).\n\n3. Pauses et recherche : Le temps en pause ou en avance rapide ne compte pas dans le seuil.\n\n4. File hors ligne : Jusqu'à 100 lectures (64 Ko) enregistrées hors ligne et envoyées dès la connexion.\n\n5. Expiration locale : Ce lecteur conserve les lectures en attente jusqu'à 13 jours.\n\n6. Séparation des comptes : Les files hors ligne sont stockées séparément par nom d'utilisateur Last.fm.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Connexion : Compás transmet vos identifiants à Last.fm via HTTPS ; votre mot de passe n'est jamais stocké.",
    ["How Scrobbling Works"] = "Comment fonctionne le scrobble",
    ["Tracks >= 30s only"] = "Morceaux >= 30s uniquement",
    ["Listened 50% or 4 min"] = "50% ou 4 min écoutés",
    ["Pauses do not count"] = "Les pauses ne comptent pas",
    ["Up to 100 offline plays"] = "Jusqu'à 100 lectures hors ligne",
    ["13-day age limit"] = "Limite d'âge de 13 jours",
    ["Separate queue per user"] = "File distincte par utilisateur",
    ["Credentials forwarded; password never stored"] = "Identifiants transmis ; mot de passe jamais stocké",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Le service de connexion Compás transmet les identifiants à Last.fm ; mot de passe jamais stocké.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Morceaux >= 30s scrobblés après 50% ou 4 min. 100 lectures en file hors ligne.",
    ["API Key: Configured"] = "Clé d'API : Configurée",
    ["API Key: Not configured"] = "Clé d'API : Non configurée",
    ["API Secret: Configured"] = "Secret d'API : Configuré",
    ["API Secret: Not configured"] = "Secret d'API : Non configuré",
    ["Sign In to Last.fm"] = "Se connecter à Last.fm",
    ["Sign Out (%s)"] = "Se déconnecter (%s)",
    ["Discard waiting plays (%d)"] = "Rejeter les lectures en attente (%d)",
    ["Status: Signing in…"] = "État : Connexion en cours…",
    ["Sign-in is currently in progress."] = "La connexion est actuellement en cours.",
    ["Cancel sign-in"] = "Annuler la connexion",
    ["Account & settings"] = "Compte et réglages",
    ["Status: API key/secret rejected"] = "État : Clé/secret d'API rejeté",
    ["Status: %s"] = "État : %s",
    ["Signed in as %s"] = "Connecté en tant que %s",
    ["This track: No music playing"] = "Ce morceau : Aucune musique en cours",
    ["This track: Scrobbling off"] = "Ce morceau : Scrobble désactivé",
    ["This track: Reading length"] = "Ce morceau : Lecture de la durée",
    ["This track: Too short (<30s)"] = "Ce morceau : Trop court (<30s)",
    ["This track: Starts counting next song"] = "Ce morceau : Comptera dès le prochain morceau",
    ["This track: %s"] = "Ce morceau : %s",
    ["This track: This listen not counted"] = "Ce morceau : Cette écoute n'est pas comptabilisée",
    ["This track: Playback paused"] = "Ce morceau : Lecture en pause",
    ["This track: Counts after %s"] = "Ce morceau : Compte après %s",
    ["No track playing."] = "Aucun morceau en cours de lecture.",
    ["Scrobbling"] = "Scrobble",
    ["Scrobbling: %s"] = "Scrobble : %s",
    ["Scrobbling\n%s"] = "Scrobble\n%s",
    ["Scrobbling turned on."] = "Scrobble activé.",
    ["Scrobbling turned off."] = "Scrobble désactivé.",
    ["Waiting plays could not be read"] = "Impossible de lire les lectures en attente",
    ["%d play waiting"] = "%d lecture en attente",
    ["%d plays waiting"] = "%d lectures en attente",
    ["Sending…"] = "Envoi…",
    ["waiting for Wi-Fi"] = "en attente du Wi-Fi",
    ["next try %dm"] = "prochain essai dans %dm",
    ["sent %s"] = "envoyé %s",
    ["Sync now"] = "Synchroniser maintenant",
  },
  it = {
    ["LastFM Scrobbler V2"] = "Scrobbler Last.fm V2",
    ["LastFM Scrobbler V2 Settings"] = "Impostazioni Scrobbler Last.fm V2",
    ["Could not remove an old Last.fm file from the SD card"] = "Impossibile rimuovere un vecchio file Last.fm dalla scheda SD",
    ["Could not open text entry. Try again."] = "Impossibile aprire l'inserimento testo. Riprova.",
    ["Saved account could not be read. Sign in again."] = "Impossibile leggere l'account salvato. Accedi di nuovo.",
    ["Last.fm service not configured."] = "Servizio Last.fm non configurato.",
    ["Session expired. Sign in again."] = "Sessione scaduta. Accedi di nuovo.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Sessione scaduta; disconnessione non salvata. Accedi di nuovo.",
    ["Last.fm not reachable."] = "Last.fm non raggiungibile.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi disattivato — invio alla connessione",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi non connesso — invio alla connessione",
    ["Waiting list could not be updated."] = "Impossibile aggiornare la coda di attesa.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Inviato, ma impossibile salvare la pulizia della coda.",
    ["Last.fm service problem."] = "Problema del servizio Last.fm.",
    ["API key or secret rejected by Last.fm."] = "Chiave o segreto API rifiutati da Last.fm.",
    ["API key or secret rejected by Last.fm. Check settings."] = "Chiave o segreto API rifiutati da Last.fm. Controlla le impostazioni.",
    ["Last.fm rejected this play"] = "Last.fm ha rifiutato questo ascolto",
    ["Last.fm temporarily busy."] = "Last.fm temporaneamente occupato.",
    ["Could not send scrobble request."] = "Impossibile inviare la richiesta di scrobble.",
    ["Not counted by Last.fm"] = "Non conteggiato da Last.fm",
    ["Sent to Last.fm"] = "Inviato a Last.fm",
    ["Waiting to send"] = "In attesa di invio",
    ["Not saved yet"] = "Non ancora salvato",
    ["Discarded by you"] = "Scartato da te",
    ["Check your API key and shared secret in Account settings."] = "Controlla la chiave API e il segreto condiviso nelle impostazioni account.",
    ["Sign in before sending waiting plays."] = "Accedi prima di inviare gli ascolti in attesa.",
    ["Turn scrobbling on before sending waiting plays."] = "Attiva lo scrobbling prima di inviare gli ascolti in attesa.",
    ["Waiting plays could not be read."] = "Impossibile leggere gli ascolti in attesa.",
    ["No plays are waiting to send."] = "Nessun ascolto in attesa di invio.",
    ["Already sending waiting plays."] = "Invio ascolti in attesa già in corso.",
    ["Sending waiting plays…"] = "Invio ascolti in attesa…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "Coda di attesa piena o non disponibile. Ascolto non ancora salvato.",
    ["Could not save scrobbling preference. Try again."] = "Impossibile salvare la preferenza di scrobbling. Riprova.",
    ["API key cannot contain control characters."] = "La chiave API non può contenere caratteri di controllo.",
    ["Use the 32-character API key without spaces."] = "Usa la chiave API di 32 caratteri senza spazi.",
    ["API key saved."] = "Chiave API salvata.",
    ["Could not save API key. Try again."] = "Impossibile salvare la chiave API. Riprova.",
    ["API secret cannot contain control characters."] = "Il segreto API non può contenere caratteri di controllo.",
    ["Shared secret saved."] = "Segreto condiviso salvato.",
    ["Could not save shared secret. Try again."] = "Impossibile salvare il segreto condiviso. Riprova.",
    ["Sign-in cancelled."] = "Accesso annullato.",
    ["Signing in…"] = "Accesso in corso…",
    ["Logging in to Last.fm…"] = "Accesso a Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Account salvato. Tocca Scrobbling per attivarlo.",
    ["Logged in to Last.fm as %s"] = "Connesso a Last.fm come %s",
    ["Last.fm service problem. Sign in again."] = "Problema del servizio Last.fm. Accedi di nuovo.",
    ["Could not save session."] = "Impossibile salvare la sessione.",
    ["Username or password incorrect."] = "Nome utente o password errati.",
    ["API key suspended by Last.fm."] = "Chiave API sospesa da Last.fm.",
    ["Last.fm is not reachable. Check network."] = "Last.fm non raggiungibile. Controlla la rete.",
    ["Could not log in to Last.fm. Check details."] = "Impossibile accedere a Last.fm. Controlla i dettagli.",
    ["Could not start login request."] = "Impossibile avviare la richiesta di accesso.",
    ["Last.fm API key"] = "Chiave API Last.fm",
    ["Last.fm Shared Secret"] = "Segreto condiviso Last.fm",
    ["Last.fm Username"] = "Nome utente Last.fm",
    ["Last.fm Password"] = "Password Last.fm",
    ["Invalid username."] = "Nome utente non valido.",
    ["Password cannot contain control characters."] = "La password non può contenere caratteri di controllo.",
    ["Last.fm setup is already complete."] = "La configurazione di Last.fm è già completa.",
    ["Set up Last.fm"] = "Configura Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Per fare scrobbling su Last.fm:\n\n1. Su telefono o computer, accedi a Last.fm.\n\n2. Apri questo indirizzo:\nlast.fm/api/account/create\n\n3. Crea un'applicazione (qualsiasi nome va bene).\n\n4. Se richiesta callback URL, inserisci http://localhost\n\n5. Ottieni chiave API e segreto condiviso.\n\nChiudi questa pagina per inserirli.",
    ["Could not open setup guide."] = "Impossibile aprire la guida di configurazione.",
    ["Create an app at last.fm/api/account/create"] = "Crea un'app su last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Aggiungi prima le tue credenziali API di Last.fm.",
    ["Already signed in to Last.fm."] = "Già connesso a Last.fm.",
    ["Sign-in already in progress."] = "Accesso già in corso.",
    ["Press Back."] = "Premi Indietro.",
    ["Sign out?"] = "Disconnettersi?",
    ["Keep signed in"] = "Resta connesso",
    ["Sign out %s"] = "Disconnetti %s",
    ["Kept signed in."] = "Accesso mantenuto.",
    ["Account changed. Nothing changed."] = "Account modificato. Nessuna modifica.",
    ["Could not save sign-out. Try again."] = "Impossibile salvare la disconnessione. Riprova.",
    ["Signed out. Waiting plays are kept for this account."] = "Disconnesso. Gli ascolti in attesa sono conservati per questo account.",
    ["Waiting plays could not be read. Nothing discarded."] = "Impossibile leggere gli ascolti in attesa. Nulla è stato scartato.",
    ["No waiting plays to discard."] = "Nessun ascolto in attesa da scartare.",
    ["Discard %d plays?"] = "Scartare %d ascolti?",
    ["Keep waiting plays"] = "Conserva ascolti in attesa",
    ["Discard %d plays"] = "Scarta %d ascolti",
    ["Kept waiting plays."] = "Ascolti in attesa conservati.",
    ["Account changed. Nothing discarded."] = "Account modificato. Nulla è stato scartato.",
    ["Waiting plays discarded."] = "Ascolti in attesa scartati.",
    ["Could not discard plays. Try again."] = "Impossibile scartare gli ascolti. Riprova.",
    ["No account has waiting plays yet."] = "Nessun account ha ancora ascolti in attesa.",
    ["Waiting plays could not be read. Nothing removed."] = "Impossibile leggere gli ascolti in attesa. Nulla è stato rimosso.",
    ["Waiting plays"] = "Ascolti in attesa",
    ["No plays are waiting to send"] = "Nessun ascolto in attesa di invio",
    ["Qualified plays send automatically."] = "I brani idonei vengono inviati automaticamente.",
    ["%d plays kept for %s"] = "%d ascolti conservati per %s",
    ["Oldest plays are sent first."] = "I brani più vecchi vengono inviati prima.",
    ["Send waiting plays now"] = "Invia ascolti in attesa ora",
    ["Saved: %s"] = "Salvato: %s",
    ["Saved time unavailable"] = "Orario di salvataggio non disponibile",
    ["Discard waiting plays…"] = "Scarta ascolti in attesa…",
    ["Account changed. Open waiting plays again."] = "Account modificato. Riapri gli ascolti in attesa.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Come funziona lo scrobbling di Last.fm:\n\n1. Regola dei 30 secondi: I brani sotto i 30 secondi non vengono inviati.\n\n2. Soglia di ascolto: Un ascolto è valido dopo metà durata o 4 minuti (quello che viene prima).\n\n3. Pause e avanzamento: Il tempo in pausa o ricerca non conta ai fini della soglia.\n\n4. Coda non in linea: Fino a 100 brani (64 KB) salvati offline e inviati automaticamente alla connessione.\n\n5. Scadenza locale: Questo lettore conserva i brani in attesa fino a 13 giorni.\n\n6. Separazione account: Le code offline sono salvate separatamente per ogni utente Last.fm.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Accesso: Compás inoltra le tue credenziali a Last.fm tramite HTTPS; la password non viene mai salvata.",
    ["How Scrobbling Works"] = "Come funziona lo scrobbling",
    ["Tracks >= 30s only"] = "Solo brani >= 30s",
    ["Listened 50% or 4 min"] = "Ascoltato al 50% o 4 min",
    ["Pauses do not count"] = "Le pause non contano",
    ["Up to 100 offline plays"] = "Fino a 100 ascolti offline",
    ["13-day age limit"] = "Limite di 13 giorni",
    ["Separate queue per user"] = "Coda separata per utente",
    ["Credentials forwarded; password never stored"] = "Credenziali inoltrate; password mai salvata",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Il servizio di accesso Compás inoltra le credenziali a Last.fm; la password non viene mai salvata.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Brani >= 30s inviati dopo il 50% o 4 min. 100 ascolti in coda offline.",
    ["API Key: Configured"] = "Chiave API: Configurato",
    ["API Key: Not configured"] = "Chiave API: Non configurato",
    ["API Secret: Configured"] = "Segreto API: Configurato",
    ["API Secret: Not configured"] = "Segreto API: Non configurato",
    ["Sign In to Last.fm"] = "Accedi a Last.fm",
    ["Sign Out (%s)"] = "Disconnettiti (%s)",
    ["Discard waiting plays (%d)"] = "Scarta ascolti in attesa (%d)",
    ["Status: Signing in…"] = "Stato: Accesso in corso…",
    ["Sign-in is currently in progress."] = "L'accesso è attualmente in corso.",
    ["Cancel sign-in"] = "Annulla accesso",
    ["Account & settings"] = "Account e impostazioni",
    ["Status: API key/secret rejected"] = "Stato: Chiave/segreto API rifiutati",
    ["Status: %s"] = "Stato: %s",
    ["Signed in as %s"] = "Connesso come %s",
    ["This track: No music playing"] = "Questo brano: Nessuna musica in riproduzione",
    ["This track: Scrobbling off"] = "Questo brano: Scrobbling disattivato",
    ["This track: Reading length"] = "Questo brano: Lettura durata",
    ["This track: Too short (<30s)"] = "Questo brano: Troppo breve (<30s)",
    ["This track: Starts counting next song"] = "Questo brano: Inizia a contare dal prossimo brano",
    ["This track: %s"] = "Questo brano: %s",
    ["This track: This listen not counted"] = "Questo brano: Questo ascolto non viene conteggiato",
    ["This track: Playback paused"] = "Questo brano: Riproduzione in pausa",
    ["This track: Counts after %s"] = "Questo brano: Conta dopo %s",
    ["No track playing."] = "Nessun brano in riproduzione.",
    ["Scrobbling"] = "Scrobbling",
    ["Scrobbling: %s"] = "Scrobbling: %s",
    ["Scrobbling\n%s"] = "Scrobbling\n%s",
    ["Scrobbling turned on."] = "Scrobbling attivato.",
    ["Scrobbling turned off."] = "Scrobbling disattivato.",
    ["Waiting plays could not be read"] = "Impossibile leggere gli ascolti in attesa",
    ["%d play waiting"] = "%d ascolto in attesa",
    ["%d plays waiting"] = "%d ascolti in attesa",
    ["Sending…"] = "Invio…",
    ["waiting for Wi-Fi"] = "in attesa del Wi-Fi",
    ["next try %dm"] = "prossimo tentativo tra %dm",
    ["sent %s"] = "inviato %s",
    ["Sync now"] = "Sincronizza ora",
  },
  ja = {
    ["LastFM Scrobbler V2"] = "Last.fmスクロブラー V2",
    ["LastFM Scrobbler V2 Settings"] = "Last.fmスクロブラー V2 設定",
    ["Could not remove an old Last.fm file from the SD card"] = "SDカードから古いLast.fmファイルを削除できませんでした",
    ["Could not open text entry. Try again."] = "テキスト入力を開けませんでした。もう一度お試しください。",
    ["Saved account could not be read. Sign in again."] = "保存されたアカウントを読み取れませんでした。再サインインしてください。",
    ["Last.fm service not configured."] = "Last.fmサービスが設定されていません。",
    ["Session expired. Sign in again."] = "セッションが期限切れです。再サインインしてください。",
    ["Session expired; sign-out could not be saved. Sign in again."] = "セッション期限切れ。サインアウトを保存できませんでした。再サインインしてください。",
    ["Last.fm not reachable."] = "Last.fmにアクセスできません。",
    ["Wi-Fi off — will send when connected"] = "Wi-Fiオフ — 接続時に送信します",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi未接続 — 接続時に送信します",
    ["Waiting list could not be updated."] = "待機リストを更新できませんでした。",
    ["Sent, but waiting-list cleanup could not be saved."] = "送信されましたが、待機リストのクリーンアップを保存できませんでした。",
    ["Last.fm service problem."] = "Last.fmサービスの問題です。",
    ["API key or secret rejected by Last.fm."] = "Last.fmにAPIキーまたは共有シークレットが拒否されました。",
    ["API key or secret rejected by Last.fm. Check settings."] = "Last.fmにAPIキーまたは共有シークレットが拒否されました。設定を確認してください。",
    ["Last.fm rejected this play"] = "Last.fmがこの再生を拒否しました",
    ["Last.fm temporarily busy."] = "Last.fmは一時的にビジー状態です。",
    ["Could not send scrobble request."] = "スクロブルリクエストを送信できませんでした。",
    ["Not counted by Last.fm"] = "Last.fmでカウントされませんでした",
    ["Sent to Last.fm"] = "Last.fmに送信済み",
    ["Waiting to send"] = "送信待ち",
    ["Not saved yet"] = "まだ保存されていません",
    ["Discarded by you"] = "あなたによって破棄されました",
    ["Check your API key and shared secret in Account settings."] = "アカウント設定でAPIキーと共有シークレットを確認してください。",
    ["Sign in before sending waiting plays."] = "待機中の再生を送信する前にサインインしてください。",
    ["Turn scrobbling on before sending waiting plays."] = "待機中の再生を送信する前にスクロブルをオンにしてください。",
    ["Waiting plays could not be read."] = "待機中の再生を読み取れませんでした。",
    ["No plays are waiting to send."] = "送信待ちの再生はありません。",
    ["Already sending waiting plays."] = "待機中の再生をすでに送信中です。",
    ["Sending waiting plays…"] = "待機中の再生を送信中…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "待機リストが満杯または利用できません。再生はまだ保存されていません。",
    ["Could not save scrobbling preference. Try again."] = "スクロブル設定を保存できませんでした。もう一度お試しください。",
    ["API key cannot contain control characters."] = "APIキーに制御文字を含めることはできません。",
    ["Use the 32-character API key without spaces."] = "スペースなしの32文字のAPIキーを使用してください。",
    ["API key saved."] = "APIキーを保存しました。",
    ["Could not save API key. Try again."] = "APIキーを保存できませんでした。もう一度お試しください。",
    ["API secret cannot contain control characters."] = "APIシークレットに制御文字を含めることはできません。",
    ["Shared secret saved."] = "共有シークレットを保存しました。",
    ["Could not save shared secret. Try again."] = "共有シークレットを保存できませんでした。もう一度お試しください。",
    ["Sign-in cancelled."] = "サインインをキャンセルしました。",
    ["Signing in…"] = "サインイン中…",
    ["Logging in to Last.fm…"] = "Last.fmにログイン中…",
    ["Account saved. Tap Scrobbling to turn it on."] = "アカウントが保存されました。「スクロブル」をタップしてオンにします。",
    ["Logged in to Last.fm as %s"] = "Last.fmに%sとしてログインしました",
    ["Last.fm service problem. Sign in again."] = "Last.fmサービスの問題です。再サインインしてください。",
    ["Could not save session."] = "セッションを保存できませんでした。",
    ["Username or password incorrect."] = "ユーザー名またはパスワードが正しくありません。",
    ["API key suspended by Last.fm."] = "APIキーがLast.fmによって停止されました。",
    ["Last.fm is not reachable. Check network."] = "Last.fmにアクセスできません。ネットワークを確認してください。",
    ["Could not log in to Last.fm. Check details."] = "Last.fmにログインできませんでした。詳細を確認してください。",
    ["Could not start login request."] = "ログインリクエストを開始できませんでした。",
    ["Last.fm API key"] = "Last.fm APIキー",
    ["Last.fm Shared Secret"] = "Last.fm 共有シークレット",
    ["Last.fm Username"] = "Last.fm ユーザー名",
    ["Last.fm Password"] = "Last.fm パスワード",
    ["Invalid username."] = "無効なユーザー名です。",
    ["Password cannot contain control characters."] = "パスワードに制御文字を含めることはできません。",
    ["Last.fm setup is already complete."] = "Last.fmのセットアップはすでに完了しています。",
    ["Set up Last.fm"] = "Last.fmを設定",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Last.fmに音楽をスクロブルするには：\n\n1. スマホやPCでLast.fmにサインインします。\n\n2. 次のアドレスを開きます：\nlast.fm/api/account/create\n\n3. アプリケーションを作成します（名前は自由です）。\n\n4. コールバックURLを求められたら http://localhost を入力します\n\n5. APIキーと共有シークレットを取得します。\n\nこのページを閉じて入力してください。",
    ["Could not open setup guide."] = "セットアップガイドを開けませんでした。",
    ["Create an app at last.fm/api/account/create"] = "last.fm/api/account/create でアプリを作成してください",
    ["Add your Last.fm API credentials first."] = "最初にLast.fm API認証情報を追加してください。",
    ["Already signed in to Last.fm."] = "すでにLast.fmにサインインしています。",
    ["Sign-in already in progress."] = "すでにサインイン処理中です。",
    ["Press Back."] = "「戻る」を押してください。",
    ["Sign out?"] = "サインアウトしますか？",
    ["Keep signed in"] = "サインインを維持",
    ["Sign out %s"] = "%s をサインアウト",
    ["Kept signed in."] = "サインインを維持しました。",
    ["Account changed. Nothing changed."] = "アカウントが変更されました。何も変更されていません。",
    ["Could not save sign-out. Try again."] = "サインアウトを保存できませんでした。もう一度お試しください。",
    ["Signed out. Waiting plays are kept for this account."] = "サインアウトしました。このアカウントの待機中の再生は保持されます。",
    ["Waiting plays could not be read. Nothing discarded."] = "待機中の再生を読み取れませんでした。何も破棄されていません。",
    ["No waiting plays to discard."] = "破棄する待機中の再生はありません。",
    ["Discard %d plays?"] = "%d件の再生を破棄しますか？",
    ["Keep waiting plays"] = "待機中の再生を保持",
    ["Discard %d plays"] = "%d件の再生を破棄",
    ["Kept waiting plays."] = "待機中の再生を保持しました。",
    ["Account changed. Nothing discarded."] = "アカウントが変更されました。何も破棄されていません。",
    ["Waiting plays discarded."] = "待機中の再生を破棄しました。",
    ["Could not discard plays. Try again."] = "再生を破棄できませんでした。もう一度お試しください。",
    ["No account has waiting plays yet."] = "待機中の再生があるアカウントはまだありません。",
    ["Waiting plays could not be read. Nothing removed."] = "待機中の再生を読み取れませんでした。何も削除されていません。",
    ["Waiting plays"] = "待機中の再生",
    ["No plays are waiting to send"] = "送信待ちの再生はありません",
    ["Qualified plays send automatically."] = "条件を満たした再生は自動的に送信されます。",
    ["%d plays kept for %s"] = "%d件の再生を保持 (%s)",
    ["Oldest plays are sent first."] = "最も古い再生から順に送信されます。",
    ["Send waiting plays now"] = "待機中の再生を今すぐ送信",
    ["Saved: %s"] = "保存日時: %s",
    ["Saved time unavailable"] = "保存日時は利用不可",
    ["Discard waiting plays…"] = "待機中の再生を破棄…",
    ["Account changed. Open waiting plays again."] = "アカウントが変更されました。待機中の再生をもう一度開いてください。",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Last.fm スクロブルの仕組み：\n\n1. 30秒ルール：30秒未満のトラックはスクロブルされません。\n\n2. 再生しきい値：曲の半分または4分のいずれか早い方に達するとカウントされます。\n\n3. 一時停止とシーク：一時停止中やシーク中の時間はしきい値に含まれません。\n\n4. オフラインキュー：最大100件（64 KB）までオフライン保存され、接続時に自動送信されます。\n\n5. 端末内での有効期限：待機中の再生は最大13日間保持されます。\n\n6. アカウント分離：オフラインキューはLast.fmのユーザー名ごとに個別に保存されます。",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. サインイン：Compásは認証情報をHTTPS経由でLast.fmに転送します。パスワードが保存されることはありません。",
    ["How Scrobbling Works"] = "スクロブルの仕組み",
    ["Tracks >= 30s only"] = "30秒以上の曲のみ",
    ["Listened 50% or 4 min"] = "50%または4分再生",
    ["Pauses do not count"] = "一時停止は含みません",
    ["Up to 100 offline plays"] = "最大100件のオフライン再生",
    ["13-day age limit"] = "13日間の有効期限",
    ["Separate queue per user"] = "ユーザーごとの個別キュー",
    ["Credentials forwarded; password never stored"] = "認証情報は転送されパスワードは保存されません",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Compásサインインサービスは認証情報をLast.fmに転送します。パスワードは保存されません。",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "30秒以上の曲は50%または4分でスクロブル。100件のオフライン再生をキュー保存。",
    ["API Key: Configured"] = "APIキー: 設定済み",
    ["API Key: Not configured"] = "APIキー: 未設定",
    ["API Secret: Configured"] = "APIシークレット: 設定済み",
    ["API Secret: Not configured"] = "APIシークレット: 未設定",
    ["Sign In to Last.fm"] = "Last.fmにサインイン",
    ["Sign Out (%s)"] = "サインアウト (%s)",
    ["Discard waiting plays (%d)"] = "待機中の再生を破棄 (%d)",
    ["Status: Signing in…"] = "状態: サインイン中…",
    ["Sign-in is currently in progress."] = "現在サインイン処理中です。",
    ["Cancel sign-in"] = "サインインをキャンセル",
    ["Account & settings"] = "アカウントと設定",
    ["Status: API key/secret rejected"] = "状態: APIキー/シークレットが拒否されました",
    ["Status: %s"] = "状態: %s",
    ["Signed in as %s"] = "%s としてサインイン中",
    ["This track: No music playing"] = "この曲: 再生中の音楽はありません",
    ["This track: Scrobbling off"] = "この曲: スクロブルオフ",
    ["This track: Reading length"] = "この曲: 曲の長さを読み取り中",
    ["This track: Too short (<30s)"] = "この曲: 短すぎます (<30秒)",
    ["This track: Starts counting next song"] = "この曲: 次の曲からカウントを開始します",
    ["This track: %s"] = "この曲: %s",
    ["This track: This listen not counted"] = "この曲: この再生はカウントされません",
    ["This track: Playback paused"] = "この曲: 再生一時停止中",
    ["This track: Counts after %s"] = "この曲: %s 後にカウント",
    ["No track playing."] = "再生中の曲はありません。",
    ["Scrobbling"] = "スクロブル",
    ["Scrobbling: %s"] = "スクロブル: %s",
    ["Scrobbling\n%s"] = "スクロブル\n%s",
    ["Scrobbling turned on."] = "スクロブルをオンにしました。",
    ["Scrobbling turned off."] = "スクロブルをオフにしました。",
    ["Waiting plays could not be read"] = "待機中の再生を読み取れませんでした",
    ["%d play waiting"] = "%d件の再生が待機中",
    ["%d plays waiting"] = "%d件の再生が待機中",
    ["Sending…"] = "送信中…",
    ["waiting for Wi-Fi"] = "Wi-Fi待機中",
    ["next try %dm"] = "次の試行まで %d分",
    ["sent %s"] = "送信日時: %s",
    ["Sync now"] = "今すぐ同期",
  },
  nl = {
    ["LastFM Scrobbler V2"] = "Last.fm-scrobbler V2",
    ["LastFM Scrobbler V2 Settings"] = "Last.fm-scrobbler V2-instellingen",
    ["Could not remove an old Last.fm file from the SD card"] = "Kon een oud Last.fm-bestand niet van de SD-kaart verwijderen",
    ["Could not open text entry. Try again."] = "Kon tekstinvoer niet openen. Probeer het opnieuw.",
    ["Saved account could not be read. Sign in again."] = "Opgeslagen account kon niet worden gelezen. Meld je opnieuw aan.",
    ["Last.fm service not configured."] = "Last.fm-dienst niet geconfigureerd.",
    ["Session expired. Sign in again."] = "Sessie verlopen. Meld je opnieuw aan.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Sessie verlopen; afmelding kon niet worden opgeslagen. Meld je opnieuw aan.",
    ["Last.fm not reachable."] = "Last.fm niet bereikbaar.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi uit — wordt verzonden na verbinding",
    ["Wi-Fi not connected — will send when connected"] = "Geen Wi-Fi-verbinding — wordt verzonden na verbinding",
    ["Waiting list could not be updated."] = "Wachtlijst kon niet worden bijgewerkt.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Verzonden, maar opschonen van wachtlijst kon niet worden opgeslagen.",
    ["Last.fm service problem."] = "Probleem met Last.fm-dienst.",
    ["API key or secret rejected by Last.fm."] = "API-sleutel of geheim geweigerd door Last.fm.",
    ["API key or secret rejected by Last.fm. Check settings."] = "API-sleutel of geheim geweigerd door Last.fm. Controleer instellingen.",
    ["Last.fm rejected this play"] = "Last.fm heeft deze afspeling geweigerd",
    ["Last.fm temporarily busy."] = "Last.fm tijdelijk bezet.",
    ["Could not send scrobble request."] = "Kon scrobble-verzoek niet verzenden.",
    ["Not counted by Last.fm"] = "Niet meegeteld door Last.fm",
    ["Sent to Last.fm"] = "Verzonden naar Last.fm",
    ["Waiting to send"] = "Wachten op verzending",
    ["Not saved yet"] = "Nog niet opgeslagen",
    ["Discarded by you"] = "Verworpen door jou",
    ["Check your API key and shared secret in Account settings."] = "Controleer je API-sleutel en gedeeld geheim in Accountinstellingen.",
    ["Sign in before sending waiting plays."] = "Meld je aan voordat je wachtende afspelingen verzendt.",
    ["Turn scrobbling on before sending waiting plays."] = "Schakel scrobbelen in voordat je wachtende afspelingen verzendt.",
    ["Waiting plays could not be read."] = "Wachtende afspelingen konden niet worden gelezen.",
    ["No plays are waiting to send."] = "Er wachten geen afspelingen om te verzenden.",
    ["Already sending waiting plays."] = "Wachtende afspelingen worden al verzonden.",
    ["Sending waiting plays…"] = "Wachtende afspelingen verzenden…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "Wachtlijst is vol of niet beschikbaar. Afspeling nog niet opgeslagen.",
    ["Could not save scrobbling preference. Try again."] = "Kon scrobble-voorkeur niet opslaan. Probeer het opnieuw.",
    ["API key cannot contain control characters."] = "API-sleutel mag geen besturingstekens bevatten.",
    ["Use the 32-character API key without spaces."] = "Gebruik de 32 tekens lange API-sleutel zonder spaties.",
    ["API key saved."] = "API-sleutel opgeslagen.",
    ["Could not save API key. Try again."] = "Kon API-sleutel niet opslaan. Probeer het opnieuw.",
    ["API secret cannot contain control characters."] = "API-geheim mag geen besturingstekens bevatten.",
    ["Shared secret saved."] = "Gedeeld geheim opgeslagen.",
    ["Could not save shared secret. Try again."] = "Kon gedeeld geheim niet opslaan. Probeer het opnieuw.",
    ["Sign-in cancelled."] = "Aanmelding geannuleerd.",
    ["Signing in…"] = "Aanmelden…",
    ["Logging in to Last.fm…"] = "Aanmelden bij Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Account opgeslagen. Tik op Scrobbelen om in te schakelen.",
    ["Logged in to Last.fm as %s"] = "Aangemeld bij Last.fm als %s",
    ["Last.fm service problem. Sign in again."] = "Probleem met Last.fm-dienst. Meld je opnieuw aan.",
    ["Could not save session."] = "Kon sessie niet opslaan.",
    ["Username or password incorrect."] = "Gebruikersnaam of wachtwoord onjuist.",
    ["API key suspended by Last.fm."] = "API-sleutel geschorst door Last.fm.",
    ["Last.fm is not reachable. Check network."] = "Last.fm is niet bereikbaar. Controleer netwerk.",
    ["Could not log in to Last.fm. Check details."] = "Kon niet aanmelden bij Last.fm. Controleer gegevens.",
    ["Could not start login request."] = "Kon aanmeldverzoek niet starten.",
    ["Last.fm API key"] = "Last.fm-API-sleutel",
    ["Last.fm Shared Secret"] = "Last.fm gedeeld geheim",
    ["Last.fm Username"] = "Last.fm-gebruikersnaam",
    ["Last.fm Password"] = "Last.fm-wachtwoord",
    ["Invalid username."] = "Ongeldige gebruikersnaam.",
    ["Password cannot contain control characters."] = "Wachtwoord mag geen besturingstekens bevatten.",
    ["Last.fm setup is already complete."] = "Last.fm-installatie is al voltooid.",
    ["Set up Last.fm"] = "Last.fm instellen",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Muziek scrobbelen naar Last.fm:\n\n1. Meld je op een telefoon of computer aan bij Last.fm.\n\n2. Open dit adres:\nlast.fm/api/account/create\n\n3. Maak een applicatie aan (elke naam is goed).\n\n4. Voer bij callback-URL desgevraagd http://localhost in\n\n5. Verkrijg je API-sleutel en gedeeld geheim.\n\nSluit deze pagina om ze in te voeren.",
    ["Could not open setup guide."] = "Kon installatiegids niet openen.",
    ["Create an app at last.fm/api/account/create"] = "Maak een app aan op last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Voeg eerst je Last.fm-API-inloggegevens toe.",
    ["Already signed in to Last.fm."] = "Al aangemeld bij Last.fm.",
    ["Sign-in already in progress."] = "Aanmelding is al bezig.",
    ["Press Back."] = "Druk op Terug.",
    ["Sign out?"] = "Afmelden?",
    ["Keep signed in"] = "Aangemeld blijven",
    ["Sign out %s"] = "Meld %s af",
    ["Kept signed in."] = "Aangemeld gebleven.",
    ["Account changed. Nothing changed."] = "Account gewijzigd. Niets gewijzigd.",
    ["Could not save sign-out. Try again."] = "Kon afmelding niet opslaan. Probeer het opnieuw.",
    ["Signed out. Waiting plays are kept for this account."] = "Afgemeld. Wachtende afspelingen worden bewaard voor dit account.",
    ["Waiting plays could not be read. Nothing discarded."] = "Wachtende afspelingen konden niet worden gelezen. Niets verworpen.",
    ["No waiting plays to discard."] = "Geen wachtende afspelingen om te verwerpen.",
    ["Discard %d plays?"] = "%d afspelingen verwerpen?",
    ["Keep waiting plays"] = "Wachtende afspelingen behouden",
    ["Discard %d plays"] = "%d afspelingen verwerpen",
    ["Kept waiting plays."] = "Wachtende afspelingen behouden.",
    ["Account changed. Nothing discarded."] = "Account gewijzigd. Niets verworpen.",
    ["Waiting plays discarded."] = "Wachtende afspelingen verworpen.",
    ["Could not discard plays. Try again."] = "Kon afspelingen niet verwerpen. Probeer het opnieuw.",
    ["No account has waiting plays yet."] = "Geen account heeft nog wachtende afspelingen.",
    ["Waiting plays could not be read. Nothing removed."] = "Wachtende afspelingen konden niet worden gelezen. Niets verwijderd.",
    ["Waiting plays"] = "Wachtende afspelingen",
    ["No plays are waiting to send"] = "Er wachten geen afspelingen om te verzenden",
    ["Qualified plays send automatically."] = "In aanmerking komende afspelingen worden automatisch verzonden.",
    ["%d plays kept for %s"] = "%d afspelingen bewaard voor %s",
    ["Oldest plays are sent first."] = "Oudste afspelingen worden eerst verzonden.",
    ["Send waiting plays now"] = "Wachtende afspelingen nu verzenden",
    ["Saved: %s"] = "Opgeslagen: %s",
    ["Saved time unavailable"] = "Opslagtijd niet beschikbaar",
    ["Discard waiting plays…"] = "Wachtende afspelingen verwerpen…",
    ["Account changed. Open waiting plays again."] = "Account gewijzigd. Open wachtende afspelingen opnieuw.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Hoe Last.fm-scrobbelen werkt:\n\n1. 30-secondenregel: Nummers onder 30 seconden worden niet gescrobbeld.\n\n2. Luisterdrempel: Een afspeling telt na de helft van de duur of 4 minuten (wat eerst komt).\n\n3. Pauzes & spoelen: Tijd gepauzeerd of spoelend telt niet mee voor de drempel.\n\n4. Offline wachtrij: Tot 100 afspelingen (64 KB) offline opgeslagen en automatisch verzonden bij verbinding.\n\n5. Lokale verlooptermijn: Deze speler bewaart wachtende afspelingen tot 13 dagen.\n\n6. Accountscheiding: Offline wachtrijen worden apart opgeslagen per Last.fm-gebruikersnaam.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Aanmelden: Compás stuurt je inloggegevens via HTTPS door naar Last.fm; je wachtwoord wordt nooit opgeslagen.",
    ["How Scrobbling Works"] = "Hoe scrobbelen werkt",
    ["Tracks >= 30s only"] = "Alleen nummers >= 30s",
    ["Listened 50% or 4 min"] = "50% of 4 min geluisterd",
    ["Pauses do not count"] = "Pauzes tellen niet mee",
    ["Up to 100 offline plays"] = "Tot 100 offline afspelingen",
    ["13-day age limit"] = "Limiet van 13 dagen",
    ["Separate queue per user"] = "Aparte wachtrij per gebruiker",
    ["Credentials forwarded; password never stored"] = "Inloggegevens doorgestuurd; wachtwoord nooit opgeslagen",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Compás-aanmelddienst stuurt inloggegevens door naar Last.fm; wachtwoord wordt nooit opgeslagen.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Nummers >= 30s scrobbelen na 50% of 4 min. 100 afspelingen offline in de wachtrij.",
    ["API Key: Configured"] = "API-sleutel: Geconfigureerd",
    ["API Key: Not configured"] = "API-sleutel: Niet geconfigureerd",
    ["API Secret: Configured"] = "API-geheim: Geconfigureerd",
    ["API Secret: Not configured"] = "API-geheim: Niet geconfigureerd",
    ["Sign In to Last.fm"] = "Aanmelden bij Last.fm",
    ["Sign Out (%s)"] = "Afmelden (%s)",
    ["Discard waiting plays (%d)"] = "Wachtende afspelingen verwerpen (%d)",
    ["Status: Signing in…"] = "Status: Aanmelden…",
    ["Sign-in is currently in progress."] = "Aanmelding is momenteel bezig.",
    ["Cancel sign-in"] = "Aanmelden annuleren",
    ["Account & settings"] = "Account en instellingen",
    ["Status: API key/secret rejected"] = "Status: API-sleutel/geheim geweigerd",
    ["Status: %s"] = "Status: %s",
    ["Signed in as %s"] = "Aangemeld als %s",
    ["This track: No music playing"] = "Dit nummer: Geen muziek die afspeelt",
    ["This track: Scrobbling off"] = "Dit nummer: Scrobbelen uit",
    ["This track: Reading length"] = "Dit nummer: Duur lezen",
    ["This track: Too short (<30s)"] = "Dit nummer: Te kort (<30s)",
    ["This track: Starts counting next song"] = "Dit nummer: Begint te tellen bij volgend nummer",
    ["This track: %s"] = "Dit nummer: %s",
    ["This track: This listen not counted"] = "Dit nummer: Deze afspeling telt niet mee",
    ["This track: Playback paused"] = "Dit nummer: Afspelen gepauzeerd",
    ["This track: Counts after %s"] = "Dit nummer: Telt na %s",
    ["No track playing."] = "Er wordt geen nummer afgespeeld.",
    ["Scrobbling"] = "Scrobbelen",
    ["Scrobbling: %s"] = "Scrobbelen: %s",
    ["Scrobbling\n%s"] = "Scrobbelen\n%s",
    ["Scrobbling turned on."] = "Scrobbelen ingeschakeld.",
    ["Scrobbling turned off."] = "Scrobbelen uitgeschakeld.",
    ["Waiting plays could not be read"] = "Wachtende afspelingen konden niet worden gelezen",
    ["%d play waiting"] = "%d afspeling in de wachtrij",
    ["%d plays waiting"] = "%d afspelingen in de wachtrij",
    ["Sending…"] = "Verzenden…",
    ["waiting for Wi-Fi"] = "wachten op Wi-Fi",
    ["next try %dm"] = "volgende poging over %dm",
    ["sent %s"] = "verzonden %s",
    ["Sync now"] = "Nu synchroniseren",
  },
  pt = {
    ["LastFM Scrobbler V2"] = "Scrobbler do Last.fm V2",
    ["LastFM Scrobbler V2 Settings"] = "Ajustes do Scrobbler do Last.fm V2",
    ["Could not remove an old Last.fm file from the SD card"] = "Não foi possível remover um arquivo antigo do Last.fm do cartão SD",
    ["Could not open text entry. Try again."] = "Não foi possível abrir a entrada de texto. Tente novamente.",
    ["Saved account could not be read. Sign in again."] = "Não foi possível ler a conta salva. Inicie sessão novamente.",
    ["Last.fm service not configured."] = "Serviço do Last.fm não configurado.",
    ["Session expired. Sign in again."] = "Sessão expirada. Inicie sessão novamente.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Sessão expirada; o encerramento da sessão não pôde ser salvo. Inicie sessão novamente.",
    ["Last.fm not reachable."] = "Last.fm inacessível.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi desligado — será enviado ao conectar",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi não conectado — será enviado ao conectar",
    ["Waiting list could not be updated."] = "Não foi possível atualizar a fila de espera.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Enviado, mas a limpeza da fila de espera não pôde ser salva.",
    ["Last.fm service problem."] = "Problema no serviço Last.fm.",
    ["API key or secret rejected by Last.fm."] = "Chave de API ou segredo rejeitado pelo Last.fm.",
    ["API key or secret rejected by Last.fm. Check settings."] = "Chave de API ou segredo rejeitado pelo Last.fm. Verifique os ajustes.",
    ["Last.fm rejected this play"] = "O Last.fm rejeitou esta reprodução",
    ["Last.fm temporarily busy."] = "Last.fm temporariamente ocupado.",
    ["Could not send scrobble request."] = "Não foi possível enviar a solicitação de scrobbling.",
    ["Not counted by Last.fm"] = "Não contabilizado pelo Last.fm",
    ["Sent to Last.fm"] = "Enviado para o Last.fm",
    ["Waiting to send"] = "Aguardando envio",
    ["Not saved yet"] = "Ainda não salvo",
    ["Discarded by you"] = "Descartado por você",
    ["Check your API key and shared secret in Account settings."] = "Verifique sua chave de API e o segredo compartilhado nos ajustes da conta.",
    ["Sign in before sending waiting plays."] = "Inicie sessão antes de enviar as reproduções em espera.",
    ["Turn scrobbling on before sending waiting plays."] = "Ative o scrobbling antes de enviar as reproduções em espera.",
    ["Waiting plays could not be read."] = "Não foi possível ler as reproduções em espera.",
    ["No plays are waiting to send."] = "Nenhuma reprodução aguardando envio.",
    ["Already sending waiting plays."] = "Já enviando as reproduções em espera.",
    ["Sending waiting plays…"] = "Enviando reproduções em espera…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "A fila de espera está cheia ou indisponível. Reprodução ainda não salva.",
    ["Could not save scrobbling preference. Try again."] = "Não foi possível salvar a preferência de scrobbling. Tente novamente.",
    ["API key cannot contain control characters."] = "A chave de API não pode conter caracteres de controle.",
    ["Use the 32-character API key without spaces."] = "Use a chave de API de 32 caracteres sem espaços.",
    ["API key saved."] = "Chave de API salva.",
    ["Could not save API key. Try again."] = "Não foi possível salvar a chave de API. Tente novamente.",
    ["API secret cannot contain control characters."] = "O segredo de API não pode conter caracteres de controle.",
    ["Shared secret saved."] = "Segredo compartilhado salvo.",
    ["Could not save shared secret. Try again."] = "Não foi possível salvar o segredo compartilhado. Tente novamente.",
    ["Sign-in cancelled."] = "Início de sessão cancelado.",
    ["Signing in…"] = "Iniciando sessão…",
    ["Logging in to Last.fm…"] = "Iniciando sessão no Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Conta salva. Toque em Scrobbling para ativá-lo.",
    ["Logged in to Last.fm as %s"] = "Sessão iniciada no Last.fm como %s",
    ["Last.fm service problem. Sign in again."] = "Problema no serviço Last.fm. Inicie sessão novamente.",
    ["Could not save session."] = "Não foi possível salvar a sessão.",
    ["Username or password incorrect."] = "Nome de usuário ou senha incorretos.",
    ["API key suspended by Last.fm."] = "Chave de API suspensa pelo Last.fm.",
    ["Last.fm is not reachable. Check network."] = "O Last.fm não está acessível. Verifique a rede.",
    ["Could not log in to Last.fm. Check details."] = "Não foi possível iniciar sessão no Last.fm. Verifique os dados.",
    ["Could not start login request."] = "Não foi possível iniciar a solicitação de login.",
    ["Last.fm API key"] = "Chave de API do Last.fm",
    ["Last.fm Shared Secret"] = "Segredo compartilhado do Last.fm",
    ["Last.fm Username"] = "Usuário do Last.fm",
    ["Last.fm Password"] = "Senha do Last.fm",
    ["Invalid username."] = "Nome de usuário inválido.",
    ["Password cannot contain control characters."] = "A senha não pode conter caracteres de controle.",
    ["Last.fm setup is already complete."] = "A configuração do Last.fm já está concluída.",
    ["Set up Last.fm"] = "Configurar o Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Para fazer scrobbling de música no Last.fm:\n\n1. Em um telefone ou computador, inicie sessão no Last.fm.\n\n2. Abra este endereço:\nlast.fm/api/account/create\n\n3. Crie um aplicativo (qualquer nome serve).\n\n4. Se solicitado URL de retorno, digite http://localhost\n\n5. Obtenha sua chave de API e segredo compartilhado.\n\nFeche esta página para inseri-los.",
    ["Could not open setup guide."] = "Não foi possível abrir o guia de configuração.",
    ["Create an app at last.fm/api/account/create"] = "Crie um aplicativo em last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Adicione primeiro suas credenciais de API do Last.fm.",
    ["Already signed in to Last.fm."] = "Já conectado ao Last.fm.",
    ["Sign-in already in progress."] = "Início de sessão já em andamento.",
    ["Press Back."] = "Pressione Voltar.",
    ["Sign out?"] = "Sair da conta?",
    ["Keep signed in"] = "Manter sessão iniciada",
    ["Sign out %s"] = "Desconectar %s",
    ["Kept signed in."] = "Sessão mantida.",
    ["Account changed. Nothing changed."] = "Conta alterada. Nada foi modificado.",
    ["Could not save sign-out. Try again."] = "Não foi possível salvar o encerramento da sessão. Tente novamente.",
    ["Signed out. Waiting plays are kept for this account."] = "Sessão encerrada. As reproduções em espera foram mantidas para esta conta.",
    ["Waiting plays could not be read. Nothing discarded."] = "Não foi possível ler as reproduções em espera. Nada foi descartado.",
    ["No waiting plays to discard."] = "Nenhuma reprodução em espera para descartar.",
    ["Discard %d plays?"] = "Descartar %d reproduções?",
    ["Keep waiting plays"] = "Manter reproduções em espera",
    ["Discard %d plays"] = "Descartar %d reproduções",
    ["Kept waiting plays."] = "Reproduções em espera mantidas.",
    ["Account changed. Nothing discarded."] = "Conta alterada. Nada foi descartado.",
    ["Waiting plays discarded."] = "Reproduções em espera descartadas.",
    ["Could not discard plays. Try again."] = "Não foi possível descartar as reproduções. Tente novamente.",
    ["No account has waiting plays yet."] = "Nenhuma conta possui reproduções em espera ainda.",
    ["Waiting plays could not be read. Nothing removed."] = "Não foi possível ler as reproduções em espera. Nada foi removido.",
    ["Waiting plays"] = "Reproduções em espera",
    ["No plays are waiting to send"] = "Nenhuma reprodução aguardando envio",
    ["Qualified plays send automatically."] = "Reproduções qualificadas são enviadas automaticamente.",
    ["%d plays kept for %s"] = "%d reproduções mantidas para %s",
    ["Oldest plays are sent first."] = "As reproduções mais antigas são enviadas primeiro.",
    ["Send waiting plays now"] = "Enviar reproduções em espera agora",
    ["Saved: %s"] = "Salvo: %s",
    ["Saved time unavailable"] = "Horário salvo indisponível",
    ["Discard waiting plays…"] = "Descartar reproduções em espera…",
    ["Account changed. Open waiting plays again."] = "Conta alterada. Abra as reproduções em espera novamente.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Como funciona o scrobbling no Last.fm:\n\n1. Regra dos 30 segundos: Faixas com menos de 30 segundos não são registradas.\n\n2. Limite de reprodução: Uma reprodução é válida após metade da duração ou 4 minutos (o que ocorrer primeiro).\n\n3. Pausas e busca: O tempo pausado ou avançando não conta para o limite.\n\n4. Fila offline: Até 100 faixas (64 KB) salvas offline e enviadas automaticamente ao conectar.\n\n5. Expiração local: Este reprodutor mantém reproduções em espera por até 13 dias.\n\n6. Separação de contas: As filas offline são salvas separadamente por usuário do Last.fm.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Início de sessão: O Compás encaminha suas credenciais para o Last.fm por HTTPS; sua senha nunca é armazenada.",
    ["How Scrobbling Works"] = "Como funciona o scrobbling",
    ["Tracks >= 30s only"] = "Apenas faixas >= 30s",
    ["Listened 50% or 4 min"] = "Ouvido 50% ou 4 min",
    ["Pauses do not count"] = "Pausas não contam",
    ["Up to 100 offline plays"] = "Até 100 reproduções offline",
    ["13-day age limit"] = "Limite de 13 dias",
    ["Separate queue per user"] = "Fila separada por usuário",
    ["Credentials forwarded; password never stored"] = "Credenciais encaminhadas; senha nunca armazenada",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "O serviço de login do Compás encaminha credenciais ao Last.fm; a senha nunca é armazenada.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Faixas >= 30s registram após 50% ou 4 min. 100 reproduções na fila offline.",
    ["API Key: Configured"] = "Chave de API: Configurada",
    ["API Key: Not configured"] = "Chave de API: Não configurada",
    ["API Secret: Configured"] = "Segredo de API: Configurado",
    ["API Secret: Not configured"] = "Segredo de API: Não configurado",
    ["Sign In to Last.fm"] = "Entrar no Last.fm",
    ["Sign Out (%s)"] = "Sair (%s)",
    ["Discard waiting plays (%d)"] = "Descartar reproduções em espera (%d)",
    ["Status: Signing in…"] = "Status: Iniciando sessão…",
    ["Sign-in is currently in progress."] = "O início de sessão está em andamento.",
    ["Cancel sign-in"] = "Cancelar início de sessão",
    ["Account & settings"] = "Conta e ajustes",
    ["Status: API key/secret rejected"] = "Status: Chave/segredo de API rejeitado",
    ["Status: %s"] = "Status: %s",
    ["Signed in as %s"] = "Conectado como %s",
    ["This track: No music playing"] = "Esta faixa: Nenhuma música tocando",
    ["This track: Scrobbling off"] = "Esta faixa: Scrobbling desativado",
    ["This track: Reading length"] = "Esta faixa: Lendo duração",
    ["This track: Too short (<30s)"] = "Esta faixa: Muito curta (<30s)",
    ["This track: Starts counting next song"] = "Esta faixa: Começa a contar na próxima música",
    ["This track: %s"] = "Esta faixa: %s",
    ["This track: This listen not counted"] = "Esta faixa: Esta reprodução não é contabilizada",
    ["This track: Playback paused"] = "Esta faixa: Reprodução pausada",
    ["This track: Counts after %s"] = "Esta faixa: Conta após %s",
    ["No track playing."] = "Nenhuma faixa em reprodução.",
    ["Scrobbling"] = "Scrobbling",
    ["Scrobbling: %s"] = "Scrobbling: %s",
    ["Scrobbling\n%s"] = "Scrobbling\n%s",
    ["Scrobbling turned on."] = "Scrobbling ativado.",
    ["Scrobbling turned off."] = "Scrobbling desativado.",
    ["Waiting plays could not be read"] = "Não foi possível ler as reproduções em espera",
    ["%d play waiting"] = "%d reprodução em espera",
    ["%d plays waiting"] = "%d reproduções em espera",
    ["Sending…"] = "Enviando…",
    ["waiting for Wi-Fi"] = "aguardando Wi-Fi",
    ["next try %dm"] = "próxima tentativa em %dm",
    ["sent %s"] = "enviado %s",
    ["Sync now"] = "Sincronizar agora",
  },
  ru = {
    ["LastFM Scrobbler V2"] = "Скробблер Last.fm V2",
    ["LastFM Scrobbler V2 Settings"] = "Настройки Скробблера Last.fm V2",
    ["Could not remove an old Last.fm file from the SD card"] = "Не удалось удалить старый файл Last.fm с карты SD",
    ["Could not open text entry. Try again."] = "Не удалось открыть ввод текста. Повторите попытку.",
    ["Saved account could not be read. Sign in again."] = "Не удалось прочитать сохраненный аккаунт. Войдите снова.",
    ["Last.fm service not configured."] = "Сервис Last.fm не настроен.",
    ["Session expired. Sign in again."] = "Сессия истекла. Войдите снова.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Сессия истекла; выход не удалось сохранить. Войдите снова.",
    ["Last.fm not reachable."] = "Last.fm недоступен.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi выключен — отправится при подключении",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi не подключен — отправится при подключении",
    ["Waiting list could not be updated."] = "Не удалось обновить список ожидания.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Отправлено, но очистку списка ожидания не удалось сохранить.",
    ["Last.fm service problem."] = "Проблема службы Last.fm.",
    ["API key or secret rejected by Last.fm."] = "Ключ или секрет API отклонен Last.fm.",
    ["API key or secret rejected by Last.fm. Check settings."] = "Ключ или секрет API отклонен Last.fm. Проверьте настройки.",
    ["Last.fm rejected this play"] = "Last.fm отклонил это воспроизведение",
    ["Last.fm temporarily busy."] = "Last.fm временно занят.",
    ["Could not send scrobble request."] = "Не удалось отправить запрос скробблинга.",
    ["Not counted by Last.fm"] = "Не учтено Last.fm",
    ["Sent to Last.fm"] = "Отправлено на Last.fm",
    ["Waiting to send"] = "Ожидает отправки",
    ["Not saved yet"] = "Еще не сохранено",
    ["Discarded by you"] = "Отклонено вами",
    ["Check your API key and shared secret in Account settings."] = "Проверьте ключ API и общий секрет в настройках аккаунта.",
    ["Sign in before sending waiting plays."] = "Войдите перед отправкой ожидающих воспроизведений.",
    ["Turn scrobbling on before sending waiting plays."] = "Включите скробблинг перед отправкой ожидающих воспроизведений.",
    ["Waiting plays could not be read."] = "Не удалось прочитать ожидающие воспроизведения.",
    ["No plays are waiting to send."] = "Нет воспроизведений, ожидающих отправки.",
    ["Already sending waiting plays."] = "Ожидающие воспроизведения уже отправляются.",
    ["Sending waiting plays…"] = "Отправка ожидающих воспроизведений…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "Список ожидания полон или недоступен. Воспроизведение еще не сохранено.",
    ["Could not save scrobbling preference. Try again."] = "Не удалось сохранить настройки скробблинга. Повторите попытку.",
    ["API key cannot contain control characters."] = "Ключ API не должен содержать управляющие символы.",
    ["Use the 32-character API key without spaces."] = "Используйте 32-значный ключ API без пробелов.",
    ["API key saved."] = "Ключ API сохранен.",
    ["Could not save API key. Try again."] = "Не удалось сохранить ключ API. Повторите попытку.",
    ["API secret cannot contain control characters."] = "Секрет API не должен содержать управляющие символы.",
    ["Shared secret saved."] = "Общий секрет сохранен.",
    ["Could not save shared secret. Try again."] = "Не удалось сохранить общий секрет. Повторите попытку.",
    ["Sign-in cancelled."] = "Вход отменен.",
    ["Signing in…"] = "Вход…",
    ["Logging in to Last.fm…"] = "Вход в Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Аккаунт сохранен. Нажмите «Скробблинг», чтобы включить его.",
    ["Logged in to Last.fm as %s"] = "Выполнен вход в Last.fm как %s",
    ["Last.fm service problem. Sign in again."] = "Проблема службы Last.fm. Войдите снова.",
    ["Could not save session."] = "Не удалось сохранить сессию.",
    ["Username or password incorrect."] = "Неверное имя пользователя или пароль.",
    ["API key suspended by Last.fm."] = "Ключ API заблокирован Last.fm.",
    ["Last.fm is not reachable. Check network."] = "Last.fm недоступен. Проверьте сеть.",
    ["Could not log in to Last.fm. Check details."] = "Не удалось войти в Last.fm. Проверьте данные.",
    ["Could not start login request."] = "Не удалось запустить запрос входа.",
    ["Last.fm API key"] = "Ключ API Last.fm",
    ["Last.fm Shared Secret"] = "Общий секрет Last.fm",
    ["Last.fm Username"] = "Имя пользователя Last.fm",
    ["Last.fm Password"] = "Пароль Last.fm",
    ["Invalid username."] = "Недопустимое имя пользователя.",
    ["Password cannot contain control characters."] = "Пароль не должен содержать управляющие символы.",
    ["Last.fm setup is already complete."] = "Настройка Last.fm уже завершена.",
    ["Set up Last.fm"] = "Настроить Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Для скробблинга музыки на Last.fm:\n\n1. На телефоне или компьютере войдите в Last.fm.\n\n2. Откройте адрес:\nlast.fm/api/account/create\n\n3. Создайте приложение (любое название).\n\n4. Если запрашивается callback URL, введите http://localhost\n\n5. Получите ключ API и общий секрет.\n\nЗакройте эту страницу для их ввода.",
    ["Could not open setup guide."] = "Не удалось открыть руководство по настройке.",
    ["Create an app at last.fm/api/account/create"] = "Создайте приложение на last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Сначала добавьте учетные данные API Last.fm.",
    ["Already signed in to Last.fm."] = "Вы уже вошли в Last.fm.",
    ["Sign-in already in progress."] = "Вход уже выполняется.",
    ["Press Back."] = "Нажмите «Назад».",
    ["Sign out?"] = "Выйти?",
    ["Keep signed in"] = "Оставаться в системе",
    ["Sign out %s"] = "Выйти из %s",
    ["Kept signed in."] = "Вход сохранен.",
    ["Account changed. Nothing changed."] = "Аккаунт изменился. Ничего не изменено.",
    ["Could not save sign-out. Try again."] = "Не удалось сохранить выход. Повторите попытку.",
    ["Signed out. Waiting plays are kept for this account."] = "Выход выполнен. Ожидающие воспроизведения сохранены для этого аккаунта.",
    ["Waiting plays could not be read. Nothing discarded."] = "Не удалось прочитать ожидающие воспроизведения. Ничего не удалено.",
    ["No waiting plays to discard."] = "Нет ожидающих воспроизведений для удаления.",
    ["Discard %d plays?"] = "Удалить %d воспроизведений?",
    ["Keep waiting plays"] = "Оставить ожидающие воспроизведения",
    ["Discard %d plays"] = "Удалить %d воспроизведений",
    ["Kept waiting plays."] = "Ожидающие воспроизведения сохранены.",
    ["Account changed. Nothing discarded."] = "Аккаунт изменился. Ничего не удалено.",
    ["Waiting plays discarded."] = "Ожидающие воспроизведения удалены.",
    ["Could not discard plays. Try again."] = "Не удалось удалить воспроизведения. Повторите попытку.",
    ["No account has waiting plays yet."] = "Ни у одного аккаунта пока нет ожидающих воспроизведений.",
    ["Waiting plays could not be read. Nothing removed."] = "Не удалось прочитать ожидающие воспроизведения. Ничего не удалено.",
    ["Waiting plays"] = "Ожидающие воспроизведения",
    ["No plays are waiting to send"] = "Нет воспроизведений, ожидающих отправки",
    ["Qualified plays send automatically."] = "Подходящие воспроизведения отправляются автоматически.",
    ["%d plays kept for %s"] = "%d воспроизведений сохранено для %s",
    ["Oldest plays are sent first."] = "Старые воспроизведения отправляются первыми.",
    ["Send waiting plays now"] = "Отправить ожидающие воспроизведения сейчас",
    ["Saved: %s"] = "Сохранено: %s",
    ["Saved time unavailable"] = "Время сохранения недоступно",
    ["Discard waiting plays…"] = "Удалить ожидающие воспроизведения…",
    ["Account changed. Open waiting plays again."] = "Аккаунт изменился. Откройте ожидающие воспроизведения снова.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Как работает скробблинг Last.fm:\n\n1. Правило 30 секунд: Треки короче 30 секунд не скробблятся.\n\n2. Порог прослушивания: Воспроизведение засчитывается после половины длины или 4 минут (что наступит раньше).\n\n3. Паузы и перемотка: Время на паузе или перемотке не учитывается в пороге.\n\n4. Офлайн-очередь: До 100 воспроизведений (64 КБ) сохраняются офлайн и отправляются при подключении.\n\n5. Срок хранения: Этот плеер хранит ожидающие воспроизведения до 13 дней.\n\n6. Разделение аккаунтов: Офлайн-очереди хранятся отдельно для каждого пользователя Last.fm.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Вход: Compás передает ваши учетные данные на Last.fm по HTTPS; пароль никогда не сохраняется.",
    ["How Scrobbling Works"] = "Как работает скробблинг",
    ["Tracks >= 30s only"] = "Только треки >= 30с",
    ["Listened 50% or 4 min"] = "Прослушано 50% или 4 мин",
    ["Pauses do not count"] = "Паузы не считаются",
    ["Up to 100 offline plays"] = "До 100 офлайн-воспроизведений",
    ["13-day age limit"] = "Срок хранения 13 дней",
    ["Separate queue per user"] = "Отдельная очередь для каждого пользователя",
    ["Credentials forwarded; password never stored"] = "Учетные данные переданы; пароль не сохраняется",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Служба входа Compás передает данные на Last.fm; пароль никогда не сохраняется.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Треки >= 30с скробблятся после 50% или 4 мин. 100 воспроизведений в офлайн-очереди.",
    ["API Key: Configured"] = "Ключ API: Настроен",
    ["API Key: Not configured"] = "Ключ API: Не настроен",
    ["API Secret: Configured"] = "Секрет API: Настроен",
    ["API Secret: Not configured"] = "Секрет API: Не настроен",
    ["Sign In to Last.fm"] = "Войти в Last.fm",
    ["Sign Out (%s)"] = "Выйти (%s)",
    ["Discard waiting plays (%d)"] = "Удалить ожидающие воспроизведения (%d)",
    ["Status: Signing in…"] = "Статус: Вход…",
    ["Sign-in is currently in progress."] = "Вход в настоящее время выполняется.",
    ["Cancel sign-in"] = "Отменить вход",
    ["Account & settings"] = "Аккаунт и настройки",
    ["Status: API key/secret rejected"] = "Статус: Ключ/секрет API отклонен",
    ["Status: %s"] = "Статус: %s",
    ["Signed in as %s"] = "Вход выполнен как %s",
    ["This track: No music playing"] = "Этот трек: Музыка не играет",
    ["This track: Scrobbling off"] = "Этот трек: Скробблинг выключен",
    ["This track: Reading length"] = "Этот трек: Определение длительности",
    ["This track: Too short (<30s)"] = "Этот трек: Слишком короткий (<30с)",
    ["This track: Starts counting next song"] = "Этот трек: Начнет считать со следующей песни",
    ["This track: %s"] = "Этот трек: %s",
    ["This track: This listen not counted"] = "Этот трек: Это прослушивание не засчитано",
    ["This track: Playback paused"] = "Этот трек: Воспроизведение приостановлено",
    ["This track: Counts after %s"] = "Этот трек: Засчитается через %s",
    ["No track playing."] = "Трек не воспроизводится.",
    ["Scrobbling"] = "Скробблинг",
    ["Scrobbling: %s"] = "Скробблинг: %s",
    ["Scrobbling\n%s"] = "Скробблинг\n%s",
    ["Scrobbling turned on."] = "Скробблинг включен.",
    ["Scrobbling turned off."] = "Скробблинг выключен.",
    ["Waiting plays could not be read"] = "Не удалось прочитать ожидающие воспроизведения",
    ["%d play waiting"] = "%d воспроизведение ожидает",
    ["%d plays waiting"] = "%d воспроизведений ожидают",
    ["Sending…"] = "Отправка…",
    ["waiting for Wi-Fi"] = "ожидание Wi-Fi",
    ["next try %dm"] = "след. попытка через %dм",
    ["sent %s"] = "отправлено %s",
    ["Sync now"] = "Синхронизировать сейчас",
  },
  uk = {
    ["LastFM Scrobbler V2"] = "Скроблер Last.fm V2",
    ["LastFM Scrobbler V2 Settings"] = "Налаштування скроблера Last.fm V2",
    ["Could not remove an old Last.fm file from the SD card"] = "Не вдалося вилучити старий файл Last.fm з картки SD",
    ["Could not open text entry. Try again."] = "Не вдалося відкрити введення тексту. Спробуйте знову.",
    ["Saved account could not be read. Sign in again."] = "Не вдалося прочитати збережений обліковий запис. Увійдіть знову.",
    ["Last.fm service not configured."] = "Служба Last.fm не налаштована.",
    ["Session expired. Sign in again."] = "Сеанс минув. Увійдіть знову.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Сеанс минув; вихід не вдалося зберегти. Увійдіть знову.",
    ["Last.fm not reachable."] = "Last.fm недосяжний.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi вимкнено — надішлеться після підключення",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi не підключено — надішлеться після підключення",
    ["Waiting list could not be updated."] = "Не вдалося оновити список очікування.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Надіслано, але очищення списку очікування не вдалося зберегти.",
    ["Last.fm service problem."] = "Проблема служби Last.fm.",
    ["API key or secret rejected by Last.fm."] = "Ключ або секрет API відхилено Last.fm.",
    ["API key or secret rejected by Last.fm. Check settings."] = "Ключ або секрет API відхилено Last.fm. Перевірте налаштування.",
    ["Last.fm rejected this play"] = "Last.fm відхилив це відтворення",
    ["Last.fm temporarily busy."] = "Last.fm тимчасово зайнятий.",
    ["Could not send scrobble request."] = "Не вдалося надіслати запит на скробблінг.",
    ["Not counted by Last.fm"] = "Не зараховано Last.fm",
    ["Sent to Last.fm"] = "Надіслано на Last.fm",
    ["Waiting to send"] = "Очікує на надсилання",
    ["Not saved yet"] = "Ще не збережено",
    ["Discarded by you"] = "Відкинуто вами",
    ["Check your API key and shared secret in Account settings."] = "Перевірте ключ API та спільний секрет у налаштуваннях облікового запису.",
    ["Sign in before sending waiting plays."] = "Увійдіть перед надсиланням очікуваних відтворень.",
    ["Turn scrobbling on before sending waiting plays."] = "Увімкніть скробблінг перед надсиланням очікуваних відтворень.",
    ["Waiting plays could not be read."] = "Не вдалося прочитати очікувані відтворення.",
    ["No plays are waiting to send."] = "Немає відтворень, що очікують на надсилання.",
    ["Already sending waiting plays."] = "Очікувані відтворення вже надсилаються.",
    ["Sending waiting plays…"] = "Надсилання очікуваних відтворень…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "Список очікування заповнений або недоступний. Відтворення ще не збережено.",
    ["Could not save scrobbling preference. Try again."] = "Не вдалося зберегти налаштування скробблінгу. Спробуйте знову.",
    ["API key cannot contain control characters."] = "Ключ API не може містити керуючі символи.",
    ["Use the 32-character API key without spaces."] = "Використовуйте 32-значний ключ API без пробілів.",
    ["API key saved."] = "Ключ API збережено.",
    ["Could not save API key. Try again."] = "Не вдалося зберегти ключ API. Спробуйте знову.",
    ["API secret cannot contain control characters."] = "Секрет API не може містити керуючі символи.",
    ["Shared secret saved."] = "Спільний секрет збережено.",
    ["Could not save shared secret. Try again."] = "Не вдалося зберегти спільний секрет. Спробуйте знову.",
    ["Sign-in cancelled."] = "Вхід скасовано.",
    ["Signing in…"] = "Вхід…",
    ["Logging in to Last.fm…"] = "Вхід до Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Обліковий запис збережено. Торкніться «Скробблінг», щоб увімкнути.",
    ["Logged in to Last.fm as %s"] = "Увійшли до Last.fm як %s",
    ["Last.fm service problem. Sign in again."] = "Проблема служби Last.fm. Увійдіть знову.",
    ["Could not save session."] = "Не вдалося зберегти сеанс.",
    ["Username or password incorrect."] = "Неправильне ім'я користувача або пароль.",
    ["API key suspended by Last.fm."] = "Ключ API призупинено Last.fm.",
    ["Last.fm is not reachable. Check network."] = "Last.fm недосяжний. Перевірте мережу.",
    ["Could not log in to Last.fm. Check details."] = "Не вдалося увійти до Last.fm. Перевірте дані.",
    ["Could not start login request."] = "Не вдалося розпочати запит на вхід.",
    ["Last.fm API key"] = "Ключ API Last.fm",
    ["Last.fm Shared Secret"] = "Спільний секрет Last.fm",
    ["Last.fm Username"] = "Ім'я користувача Last.fm",
    ["Last.fm Password"] = "Пароль Last.fm",
    ["Invalid username."] = "Неприпустиме ім'я користувача.",
    ["Password cannot contain control characters."] = "Пароль не може містити керуючі символи.",
    ["Last.fm setup is already complete."] = "Налаштування Last.fm уже завершено.",
    ["Set up Last.fm"] = "Налаштувати Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Щоб скробблити музику на Last.fm:\n\n1. На телефоні або комп'ютері увійдіть до Last.fm.\n\n2. Відкрийте адресу:\nlast.fm/api/account/create\n\n3. Створіть застосунок (будь-яка назва підійде).\n\n4. Якщо запитується зворотна адреса (callback URL), введіть http://localhost\n\n5. Отримайте ключ API та спільний секрет.\n\nЗакрийте цю сторінку для їхнього введення.",
    ["Could not open setup guide."] = "Не вдалося відкрити посібник із налаштування.",
    ["Create an app at last.fm/api/account/create"] = "Створіть застосунок на last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Спочатку додайте облікові дані API Last.fm.",
    ["Already signed in to Last.fm."] = "Вже здійснено вхід до Last.fm.",
    ["Sign-in already in progress."] = "Вхід уже триває.",
    ["Press Back."] = "Натисніть «Назад».",
    ["Sign out?"] = "Вийти?",
    ["Keep signed in"] = "Залишатися в системі",
    ["Sign out %s"] = "Вийти з %s",
    ["Kept signed in."] = "Вхід збережено.",
    ["Account changed. Nothing changed."] = "Обліковий запис змінився. Нічого не змінено.",
    ["Could not save sign-out. Try again."] = "Не вдалося зберегти вихід. Спробуйте знову.",
    ["Signed out. Waiting plays are kept for this account."] = "Вихід виконано. Очікувані відтворення збережено для цього облікового запису.",
    ["Waiting plays could not be read. Nothing discarded."] = "Не вдалося прочитати очікувані відтворення. Нічого не відкинуто.",
    ["No waiting plays to discard."] = "Немає очікуваних відтворень для відкидання.",
    ["Discard %d plays?"] = "Відкинути %d відтворень?",
    ["Keep waiting plays"] = "Залишити очікувані відтворення",
    ["Discard %d plays"] = "Відкинути %d відтворень",
    ["Kept waiting plays."] = "Очікувані відтворення збережено.",
    ["Account changed. Nothing discarded."] = "Обліковий запис змінився. Нічого не відкинуто.",
    ["Waiting plays discarded."] = "Очікувані відтворення відкинуто.",
    ["Could not discard plays. Try again."] = "Не вдалося відкинути відтворення. Спробуйте знову.",
    ["No account has waiting plays yet."] = "Жоден обліковий запис ще не має очікуваних відтворень.",
    ["Waiting plays could not be read. Nothing removed."] = "Не вдалося прочитати очікувані відтворення. Нічого не вилучено.",
    ["Waiting plays"] = "Очікувані відтворення",
    ["No plays are waiting to send"] = "Немає відтворень, що очікують на надсилання",
    ["Qualified plays send automatically."] = "Відповідні відтворення надсилаються автоматично.",
    ["%d plays kept for %s"] = "%d відтворень збережено для %s",
    ["Oldest plays are sent first."] = "Найстаріші відтворення надсилаються першими.",
    ["Send waiting plays now"] = "Надіслати очікувані відтворення зараз",
    ["Saved: %s"] = "Збережено: %s",
    ["Saved time unavailable"] = "Час збереження недоступний",
    ["Discard waiting plays…"] = "Відкинути очікувані відтворення…",
    ["Account changed. Open waiting plays again."] = "Обліковий запис змінився. Відкрийте очікувані відтворення знову.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Як працює скробблінг Last.fm:\n\n1. Правило 30 секунд: Треки менше 30 секунд не скроббляться.\n\n2. Поріг прослуховування: Відтворення зараховується після половини тривалості або 4 хвилин (що настане раніше).\n\n3. Паузи та перемотування: Час на паузі або перемотуванні не враховується.\n\n4. Офлайн-черга: До 100 відтворень (64 КБ) зберігаються офлайн і надсилаються при підключенні.\n\n5. Локальне зберігання: Цей плеєр зберігає очікувані відтворення до 13 днів.\n\n6. Розділення акаунтів: Офлайн-черги зберігаються окремо для кожного користувача Last.fm.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Вхід: Compás передає ваші облікові дані до Last.fm через HTTPS; ваш пароль ніколи не зберігається.",
    ["How Scrobbling Works"] = "Як працює скробблінг",
    ["Tracks >= 30s only"] = "Лише треки >= 30с",
    ["Listened 50% or 4 min"] = "Прослухано 50% або 4 хв",
    ["Pauses do not count"] = "Паузи не враховуються",
    ["Up to 100 offline plays"] = "До 100 офлайн-відтворень",
    ["13-day age limit"] = "Термін зберігання 13 днів",
    ["Separate queue per user"] = "Окрема черга для кожного користувача",
    ["Credentials forwarded; password never stored"] = "Дані передано; пароль ніколи не зберігається",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Служба входу Compás передає дані до Last.fm; пароль ніколи не зберігається.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Треки >= 30с скроббляться після 50% або 4 хв. 100 відтворень у черзі офлайн.",
    ["API Key: Configured"] = "Ключ API: Налаштовано",
    ["API Key: Not configured"] = "Ключ API: Не налаштовано",
    ["API Secret: Configured"] = "Секрет API: Налаштовано",
    ["API Secret: Not configured"] = "Секрет API: Не налаштовано",
    ["Sign In to Last.fm"] = "Увійти до Last.fm",
    ["Sign Out (%s)"] = "Вийти (%s)",
    ["Discard waiting plays (%d)"] = "Відкинути очікувані відтворення (%d)",
    ["Status: Signing in…"] = "Статус: Вхід…",
    ["Sign-in is currently in progress."] = "Зараз триває вхід.",
    ["Cancel sign-in"] = "Скасувати вхід",
    ["Account & settings"] = "Обліковий запис і налаштування",
    ["Status: API key/secret rejected"] = "Статус: Ключ/секрет API відхилено",
    ["Status: %s"] = "Статус: %s",
    ["Signed in as %s"] = "Увійшли як %s",
    ["This track: No music playing"] = "Цей трек: Музика не відтворюється",
    ["This track: Scrobbling off"] = "Цей трек: Скробблінг вимкнено",
    ["This track: Reading length"] = "Цей трек: Визначення тривалості",
    ["This track: Too short (<30s)"] = "Цей трек: Занадто короткий (<30с)",
    ["This track: Starts counting next song"] = "Цей трек: Почне лічити з наступної пісні",
    ["This track: %s"] = "Цей трек: %s",
    ["This track: This listen not counted"] = "Цей трек: Це прослуховування не зараховано",
    ["This track: Playback paused"] = "Цей трек: Відтворення призупинено",
    ["This track: Counts after %s"] = "Цей трек: Зарахується через %s",
    ["No track playing."] = "Жоден трек не відтворюється.",
    ["Scrobbling"] = "Скробблінг",
    ["Scrobbling: %s"] = "Скробблінг: %s",
    ["Scrobbling\n%s"] = "Скробблінг\n%s",
    ["Scrobbling turned on."] = "Скробблінг увімкнено.",
    ["Scrobbling turned off."] = "Скробблінг вимкнено.",
    ["Waiting plays could not be read"] = "Не вдалося прочитати очікувані відтворення",
    ["%d play waiting"] = "%d відтворення очікує",
    ["%d plays waiting"] = "%d відтворень очікують",
    ["Sending…"] = "Надсилання…",
    ["waiting for Wi-Fi"] = "очікування Wi-Fi",
    ["next try %dm"] = "наст. спроба через %dхв",
    ["sent %s"] = "надіслано %s",
    ["Sync now"] = "Синхронізувати зараз",
  },
  vi = {
    ["LastFM Scrobbler V2"] = "Last.fm Scrobbler V2",
    ["LastFM Scrobbler V2 Settings"] = "Cài đặt Last.fm Scrobbler V2",
    ["Could not remove an old Last.fm file from the SD card"] = "Không thể xóa tệp Last.fm cũ khỏi thẻ SD",
    ["Could not open text entry. Try again."] = "Không mở được ô nhập văn bản. Hãy thử lại.",
    ["Saved account could not be read. Sign in again."] = "Không thể đọc tài khoản đã lưu. Hãy đăng nhập lại.",
    ["Last.fm service not configured."] = "Dịch vụ Last.fm chưa được định cấu hình.",
    ["Session expired. Sign in again."] = "Phiên đã hết hạn. Hãy đăng nhập lại.",
    ["Session expired; sign-out could not be saved. Sign in again."] = "Phiên đã hết hạn; không thể lưu đăng xuất. Hãy đăng nhập lại.",
    ["Last.fm not reachable."] = "Không thể kết nối với Last.fm.",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi tắt — sẽ gửi khi kết nối",
    ["Wi-Fi not connected — will send when connected"] = "Chưa kết nối Wi-Fi — sẽ gửi khi kết nối",
    ["Waiting list could not be updated."] = "Không thể cập nhật danh sách chờ.",
    ["Sent, but waiting-list cleanup could not be saved."] = "Đã gửi, nhưng không thể lưu việc dọn dẹp danh sách chờ.",
    ["Last.fm service problem."] = "Sự cố dịch vụ Last.fm.",
    ["API key or secret rejected by Last.fm."] = "Khóa hoặc mã bí mật API bị Last.fm từ chối.",
    ["API key or secret rejected by Last.fm. Check settings."] = "Khóa hoặc mã bí mật API bị Last.fm từ chối. Hãy kiểm tra cài đặt.",
    ["Last.fm rejected this play"] = "Last.fm đã từ chối lượt nghe này",
    ["Last.fm temporarily busy."] = "Last.fm tạm thời bận.",
    ["Could not send scrobble request."] = "Không thể gửi yêu cầu scrobble.",
    ["Not counted by Last.fm"] = "Last.fm không tính",
    ["Sent to Last.fm"] = "Đã gửi tới Last.fm",
    ["Waiting to send"] = "Đang chờ gửi",
    ["Not saved yet"] = "Chưa lưu",
    ["Discarded by you"] = "Bạn đã loại bỏ",
    ["Check your API key and shared secret in Account settings."] = "Kiểm tra khóa API và mã bí mật chia sẻ trong Cài đặt tài khoản.",
    ["Sign in before sending waiting plays."] = "Hãy đăng nhập trước khi gửi các lượt nghe đang chờ.",
    ["Turn scrobbling on before sending waiting plays."] = "Hãy bật scrobble trước khi gửi các lượt nghe đang chờ.",
    ["Waiting plays could not be read."] = "Không thể đọc các lượt nghe đang chờ.",
    ["No plays are waiting to send."] = "Không có lượt nghe nào đang chờ gửi.",
    ["Already sending waiting plays."] = "Đang gửi các lượt nghe chờ rồi.",
    ["Sending waiting plays…"] = "Đang gửi các lượt nghe đang chờ…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "Danh sách chờ đã đầy hoặc không khả dụng. Lượt nghe chưa được lưu.",
    ["Could not save scrobbling preference. Try again."] = "Không thể lưu tùy chọn scrobble. Hãy thử lại.",
    ["API key cannot contain control characters."] = "Khóa API không được chứa ký tự điều khiển.",
    ["Use the 32-character API key without spaces."] = "Sử dụng khóa API 32 ký tự không có dấu cách.",
    ["API key saved."] = "Đã lưu khóa API.",
    ["Could not save API key. Try again."] = "Không thể lưu khóa API. Hãy thử lại.",
    ["API secret cannot contain control characters."] = "Mã bí mật API không được chứa ký tự điều khiển.",
    ["Shared secret saved."] = "Đã lưu mã bí mật chia sẻ.",
    ["Could not save shared secret. Try again."] = "Không thể lưu mã bí mật chia sẻ. Hãy thử lại.",
    ["Sign-in cancelled."] = "Đã hủy đăng nhập.",
    ["Signing in…"] = "Đang đăng nhập…",
    ["Logging in to Last.fm…"] = "Đang đăng nhập vào Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "Đã lưu tài khoản. Nhấn vào Scrobble để bật.",
    ["Logged in to Last.fm as %s"] = "Đã đăng nhập Last.fm với tên %s",
    ["Last.fm service problem. Sign in again."] = "Sự cố dịch vụ Last.fm. Hãy đăng nhập lại.",
    ["Could not save session."] = "Không thể lưu phiên.",
    ["Username or password incorrect."] = "Tên người dùng hoặc mật khẩu không đúng.",
    ["API key suspended by Last.fm."] = "Khóa API bị Last.fm đình chỉ.",
    ["Last.fm is not reachable. Check network."] = "Không thể kết nối Last.fm. Hãy kiểm tra mạng.",
    ["Could not log in to Last.fm. Check details."] = "Không thể đăng nhập Last.fm. Hãy kiểm tra thông tin.",
    ["Could not start login request."] = "Không thể bắt đầu yêu cầu đăng nhập.",
    ["Last.fm API key"] = "Khóa API Last.fm",
    ["Last.fm Shared Secret"] = "Mã bí mật chia sẻ Last.fm",
    ["Last.fm Username"] = "Tên người dùng Last.fm",
    ["Last.fm Password"] = "Mật khẩu Last.fm",
    ["Invalid username."] = "Tên người dùng không hợp lệ.",
    ["Password cannot contain control characters."] = "Mật khẩu không được chứa ký tự điều khiển.",
    ["Last.fm setup is already complete."] = "Thiết lập Last.fm đã hoàn tất.",
    ["Set up Last.fm"] = "Thiết lập Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "Để scrobble nhạc lên Last.fm:\n\n1. Đăng nhập vào Last.fm trên điện thoại hoặc máy tính.\n\n2. Mở địa chỉ này:\nlast.fm/api/account/create\n\n3. Tạo một ứng dụng (tên bất kỳ đều được).\n\n4. Nếu được hỏi URL gọi lại, nhập http://localhost\n\n5. Lấy Khóa API và Mã bí mật chia sẻ.\n\nĐóng trang này để nhập chúng.",
    ["Could not open setup guide."] = "Không thể mở hướng dẫn thiết lập.",
    ["Create an app at last.fm/api/account/create"] = "Tạo ứng dụng tại last.fm/api/account/create",
    ["Add your Last.fm API credentials first."] = "Hãy thêm thông tin xác thực API Last.fm trước.",
    ["Already signed in to Last.fm."] = "Đã đăng nhập vào Last.fm rồi.",
    ["Sign-in already in progress."] = "Đang trong quá trình đăng nhập rồi.",
    ["Press Back."] = "Nhấn Quay lại.",
    ["Sign out?"] = "Đăng xuất?",
    ["Keep signed in"] = "Tiếp tục đăng nhập",
    ["Sign out %s"] = "Đăng xuất %s",
    ["Kept signed in."] = "Đã giữ đăng nhập.",
    ["Account changed. Nothing changed."] = "Tài khoản đã đổi. Không có gì thay đổi.",
    ["Could not save sign-out. Try again."] = "Không thể lưu việc đăng xuất. Hãy thử lại.",
    ["Signed out. Waiting plays are kept for this account."] = "Đã đăng xuất. Các lượt nghe đang chờ được giữ lại cho tài khoản này.",
    ["Waiting plays could not be read. Nothing discarded."] = "Không thể đọc các lượt nghe chờ. Chưa loại bỏ gì.",
    ["No waiting plays to discard."] = "Không có lượt nghe chờ nào để loại bỏ.",
    ["Discard %d plays?"] = "Loại bỏ %d lượt nghe?",
    ["Keep waiting plays"] = "Giữ lại các lượt nghe đang chờ",
    ["Discard %d plays"] = "Loại bỏ %d lượt nghe",
    ["Kept waiting plays."] = "Đã giữ lại các lượt nghe đang chờ.",
    ["Account changed. Nothing discarded."] = "Tài khoản đã đổi. Chưa loại bỏ gì.",
    ["Waiting plays discarded."] = "Đã loại bỏ các lượt nghe đang chờ.",
    ["Could not discard plays. Try again."] = "Không thể loại bỏ các lượt nghe. Hãy thử lại.",
    ["No account has waiting plays yet."] = "Chưa có tài khoản nào có lượt nghe đang chờ.",
    ["Waiting plays could not be read. Nothing removed."] = "Không thể đọc các lượt nghe chờ. Chưa xóa gì.",
    ["Waiting plays"] = "Lượt nghe đang chờ",
    ["No plays are waiting to send"] = "Không có lượt nghe nào đang chờ gửi",
    ["Qualified plays send automatically."] = "Các lượt nghe đủ điều kiện sẽ gửi tự động.",
    ["%d plays kept for %s"] = "%d lượt nghe giữ cho %s",
    ["Oldest plays are sent first."] = "Các lượt nghe cũ nhất được gửi trước.",
    ["Send waiting plays now"] = "Gửi các lượt nghe đang chờ ngay",
    ["Saved: %s"] = "Đã lưu: %s",
    ["Saved time unavailable"] = "Không có thời gian đã lưu",
    ["Discard waiting plays…"] = "Loại bỏ các lượt nghe đang chờ…",
    ["Account changed. Open waiting plays again."] = "Tài khoản đã đổi. Hãy mở lại các lượt nghe chờ.",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Cách hoạt động của Scrobble Last.fm:\n\n1. Quy tắc 30 giây: Bài hát dưới 30 giây không được scrobble.\n\n2. Ngưỡng nghe: Lượt nghe hợp lệ sau một nửa thời lượng hoặc 4 phút (tùy điều kiện nào đến trước).\n\n3. Tạm dừng & Tua: Thời gian tạm dừng hoặc tua không được tính vào ngưỡng.\n\n4. Hàng đợi ngoại tuyến: Lưu tối đa 100 lượt nghe (64 KB) ngoại tuyến và tự động gửi khi có kết nối.\n\n5. Hạn cục bộ: Trình phát này giữ các lượt nghe chờ tối đa 13 ngày.\n\n6. Tách biệt tài khoản: Hàng đợi ngoại tuyến được lưu riêng theo từng tên người dùng Last.fm.",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. Đăng nhập: Compás chuyển tiếp thông tin xác thực của bạn tới Last.fm qua HTTPS; mật khẩu không bao giờ được lưu trữ.",
    ["How Scrobbling Works"] = "Cách hoạt động của Scrobble",
    ["Tracks >= 30s only"] = "Chỉ bài hát >= 30s",
    ["Listened 50% or 4 min"] = "Đã nghe 50% hoặc 4 phút",
    ["Pauses do not count"] = "Tạm dừng không được tính",
    ["Up to 100 offline plays"] = "Tối đa 100 lượt nghe ngoại tuyến",
    ["13-day age limit"] = "Thời hạn tối đa 13 ngày",
    ["Separate queue per user"] = "Hàng đợi riêng theo người dùng",
    ["Credentials forwarded; password never stored"] = "Chuyển tiếp thông tin xác thực; không lưu mật khẩu",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Dịch vụ đăng nhập Compás chuyển tiếp thông tin tới Last.fm; không lưu mật khẩu.",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = "Bài hát >= 30s scrobble sau 50% hoặc 4 phút. 100 lượt nghe lưu ngoại tuyến.",
    ["API Key: Configured"] = "Khóa API: Đã định cấu hình",
    ["API Key: Not configured"] = "Khóa API: Chưa định cấu hình",
    ["API Secret: Configured"] = "Mã bí mật API: Đã định cấu hình",
    ["API Secret: Not configured"] = "Mã bí mật API: Chưa định cấu hình",
    ["Sign In to Last.fm"] = "Đăng nhập vào Last.fm",
    ["Sign Out (%s)"] = "Đăng xuất (%s)",
    ["Discard waiting plays (%d)"] = "Loại bỏ các lượt nghe đang chờ (%d)",
    ["Status: Signing in…"] = "Trạng thái: Đang đăng nhập…",
    ["Sign-in is currently in progress."] = "Hiện đang trong quá trình đăng nhập.",
    ["Cancel sign-in"] = "Hủy đăng nhập",
    ["Account & settings"] = "Tài khoản & cài đặt",
    ["Status: API key/secret rejected"] = "Trạng thái: Khóa/mã bí mật API bị từ chối",
    ["Status: %s"] = "Trạng thái: %s",
    ["Signed in as %s"] = "Đã đăng nhập với tên %s",
    ["This track: No music playing"] = "Bài này: Không phát nhạc",
    ["This track: Scrobbling off"] = "Bài này: Tắt scrobble",
    ["This track: Reading length"] = "Bài này: Đang đọc thời lượng",
    ["This track: Too short (<30s)"] = "Bài này: Quá ngắn (<30s)",
    ["This track: Starts counting next song"] = "Bài này: Bắt đầu tính từ bài tiếp theo",
    ["This track: %s"] = "Bài này: %s",
    ["This track: This listen not counted"] = "Bài này: Lượt nghe này không được tính",
    ["This track: Playback paused"] = "Bài này: Đã tạm dừng phát",
    ["This track: Counts after %s"] = "Bài này: Tính sau %s",
    ["No track playing."] = "Không có bài hát nào đang phát.",
    ["Scrobbling"] = "Scrobble",
    ["Scrobbling: %s"] = "Scrobble: %s",
    ["Scrobbling\n%s"] = "Scrobble\n%s",
    ["Scrobbling turned on."] = "Đã bật scrobble.",
    ["Scrobbling turned off."] = "Đã tắt scrobble.",
    ["Waiting plays could not be read"] = "Không thể đọc các lượt nghe đang chờ",
    ["%d play waiting"] = "%d lượt nghe đang chờ",
    ["%d plays waiting"] = "%d lượt nghe đang chờ",
    ["Sending…"] = "Đang gửi…",
    ["waiting for Wi-Fi"] = "đang chờ Wi-Fi",
    ["next try %dm"] = "thử lại sau %d phút",
    ["sent %s"] = "đã gửi lúc %s",
    ["Sync now"] = "Đồng bộ ngay",
  },
  zh_CN = {
    ["LastFM Scrobbler V2"] = "Last.fm 播放记录器 V2",
    ["LastFM Scrobbler V2 Settings"] = "Last.fm 播放记录器 V2 设置",
    ["Could not remove an old Last.fm file from the SD card"] = "无法从 SD 卡删除旧的 Last.fm 文件",
    ["Could not open text entry. Try again."] = "无法打开文本输入。请重试。",
    ["Saved account could not be read. Sign in again."] = "无法读取已保存的账号。请重新登录。",
    ["Last.fm service not configured."] = "Last.fm 服务未配置。",
    ["Session expired. Sign in again."] = "会话已过期。请重新登录。",
    ["Session expired; sign-out could not be saved. Sign in again."] = "会话已过期；无法保存退出登录。请重新登录。",
    ["Last.fm not reachable."] = "无法连接到 Last.fm。",
    ["Wi-Fi off — will send when connected"] = "Wi-Fi 已关闭 — 连接后将发送",
    ["Wi-Fi not connected — will send when connected"] = "Wi-Fi 未连接 — 连接后将发送",
    ["Waiting list could not be updated."] = "无法更新等待列表。",
    ["Sent, but waiting-list cleanup could not be saved."] = "已发送，但无法保存等待列表清理。",
    ["Last.fm service problem."] = "Last.fm 服务出现问题。",
    ["API key or secret rejected by Last.fm."] = "Last.fm 拒绝了 API 密钥或密钥口令。",
    ["API key or secret rejected by Last.fm. Check settings."] = "Last.fm 拒绝了 API 密钥或密钥口令。请检查设置。",
    ["Last.fm rejected this play"] = "Last.fm 拒绝了此播放记录",
    ["Last.fm temporarily busy."] = "Last.fm 暂时繁忙。",
    ["Could not send scrobble request."] = "无法发送记录请求。",
    ["Not counted by Last.fm"] = "未被 Last.fm 计入",
    ["Sent to Last.fm"] = "已发送至 Last.fm",
    ["Waiting to send"] = "等待发送",
    ["Not saved yet"] = "尚未保存",
    ["Discarded by you"] = "已由你放弃",
    ["Check your API key and shared secret in Account settings."] = "请在账号设置中检查你的 API 密钥和共享密钥。",
    ["Sign in before sending waiting plays."] = "发送等待中的播放记录前请先登录。",
    ["Turn scrobbling on before sending waiting plays."] = "发送等待中的播放记录前请先开启记录。",
    ["Waiting plays could not be read."] = "无法读取等待中的播放记录。",
    ["No plays are waiting to send."] = "没有等待发送的播放记录。",
    ["Already sending waiting plays."] = "已经在发送等待中的播放记录。",
    ["Sending waiting plays…"] = "正在发送等待中的播放记录…",
    ["Waiting list is full or unavailable. Play not saved yet."] = "等待列表已满或不可用。播放记录尚未保存。",
    ["Could not save scrobbling preference. Try again."] = "无法保存记录播放偏好设置。请重试。",
    ["API key cannot contain control characters."] = "API 密钥不能包含控制字符。",
    ["Use the 32-character API key without spaces."] = "请使用不含空格的 32 位 API 密钥。",
    ["API key saved."] = "API 密钥已保存。",
    ["Could not save API key. Try again."] = "无法保存 API 密钥。请重试。",
    ["API secret cannot contain control characters."] = "API 密钥口令不能包含控制字符。",
    ["Shared secret saved."] = "共享密钥已保存。",
    ["Could not save shared secret. Try again."] = "无法保存共享密钥。请重试。",
    ["Sign-in cancelled."] = "已取消登录。",
    ["Signing in…"] = "正在登录…",
    ["Logging in to Last.fm…"] = "正在登录 Last.fm…",
    ["Account saved. Tap Scrobbling to turn it on."] = "账号已保存。点按“记录”以开启。",
    ["Logged in to Last.fm as %s"] = "已作为 %s 登录 Last.fm",
    ["Last.fm service problem. Sign in again."] = "Last.fm 服务出现问题。请重新登录。",
    ["Could not save session."] = "无法保存会话。",
    ["Username or password incorrect."] = "用户名或密码不正确。",
    ["API key suspended by Last.fm."] = "API 密钥已被 Last.fm 暂停。",
    ["Last.fm is not reachable. Check network."] = "无法连接到 Last.fm。请检查网络。",
    ["Could not log in to Last.fm. Check details."] = "无法登录 Last.fm。请检查详细信息。",
    ["Could not start login request."] = "无法启动登录请求。",
    ["Last.fm API key"] = "Last.fm API 密钥",
    ["Last.fm Shared Secret"] = "Last.fm 共享密钥",
    ["Last.fm Username"] = "Last.fm 用户名",
    ["Last.fm Password"] = "Last.fm 密码",
    ["Invalid username."] = "用户名无效。",
    ["Password cannot contain control characters."] = "密码不能包含控制字符。",
    ["Last.fm setup is already complete."] = "Last.fm 设置已完成。",
    ["Set up Last.fm"] = "设置 Last.fm",
    ["To scrobble music to Last.fm:\n\n1. On a phone or computer, sign in to Last.fm.\n\n2. Open this address:\nlast.fm/api/account/create\n\n3. Create an application (any name is fine).\n\n4. If asked for callback URL, enter http://localhost\n\n5. Obtain your API Key and Shared Secret.\n\nClose this page to enter them."] = "若要将音乐记录到 Last.fm：\n\n1. 在手机或电脑上登录 Last.fm。\n\n2. 打开此网址：\nlast.fm/api/account/create\n\n3. 创建一个应用程序（名称随意）。\n\n4. 如要求提供回调 URL，请输入 http://localhost\n\n5. 获取你的 API 密钥和共享密钥。\n\n关闭此页面以输入它们。",
    ["Could not open setup guide."] = "无法打开设置指南。",
    ["Create an app at last.fm/api/account/create"] = "请在 last.fm/api/account/create 创建应用",
    ["Add your Last.fm API credentials first."] = "请先添加你的 Last.fm API 凭据。",
    ["Already signed in to Last.fm."] = "已登录 Last.fm。",
    ["Sign-in already in progress."] = "登录已在进行中。",
    ["Press Back."] = "按返回。",
    ["Sign out?"] = "退出登录？",
    ["Keep signed in"] = "保持登录状态",
    ["Sign out %s"] = "退出登录 %s",
    ["Kept signed in."] = "已保持登录状态。",
    ["Account changed. Nothing changed."] = "账号已更改。未做任何变更。",
    ["Could not save sign-out. Try again."] = "无法保存退出登录。请重试。",
    ["Signed out. Waiting plays are kept for this account."] = "已退出登录。此账号的等待播放记录已保留。",
    ["Waiting plays could not be read. Nothing discarded."] = "无法读取等待中的播放记录。未丢弃任何内容。",
    ["No waiting plays to discard."] = "没有可丢弃的等待播放记录。",
    ["Discard %d plays?"] = "丢弃 %d 条播放记录？",
    ["Keep waiting plays"] = "保留等待中的播放记录",
    ["Discard %d plays"] = "丢弃 %d 条播放记录",
    ["Kept waiting plays."] = "已保留等待中的播放记录。",
    ["Account changed. Nothing discarded."] = "账号已更改。未丢弃任何内容。",
    ["Waiting plays discarded."] = "已丢弃等待中的播放记录。",
    ["Could not discard plays. Try again."] = "无法丢弃播放记录。请重试。",
    ["No account has waiting plays yet."] = "尚无账号有等待中的播放记录。",
    ["Waiting plays could not be read. Nothing removed."] = "无法读取等待中的播放记录。未移除任何内容。",
    ["Waiting plays"] = "等待中的播放记录",
    ["No plays are waiting to send"] = "没有等待发送的播放记录",
    ["Qualified plays send automatically."] = "符合条件的播放记录将自动发送。",
    ["%d plays kept for %s"] = "%d 条播放记录已为 %s 保留",
    ["Oldest plays are sent first."] = "较早的播放记录将优先发送。",
    ["Send waiting plays now"] = "立即发送等待中的播放记录",
    ["Saved: %s"] = "已保存：%s",
    ["Saved time unavailable"] = "保存时间不可用",
    ["Discard waiting plays…"] = "丢弃等待中的播放记录…",
    ["Account changed. Open waiting plays again."] = "账号已更改。请重新打开等待中的播放记录。",
    ["How Last.fm Scrobbling Works:\n\n1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n6. Account Separation: Offline queues are stored separately per Last.fm username."] = "Last.fm 记录播放的运作方式：\n\n1. 30 秒规则：短于 30 秒的曲目不予记录。\n\n2. 聆听阈值：播放达到曲目时长的一半或 4 分钟（以先到者为准）即视为有效播放。\n\n3. 暂停与快进：暂停或快进跳转的时间不计入阈值。\n\n4. 离线队列：离线最多保存 100 条播放记录（64 KB），连接网络后自动发送。\n\n5. 本地过期：此播放器最多保留等待播放记录 13 天。\n\n6. 账号独立：离线队列按 Last.fm 用户名分别存储。",
    ["7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."] = "7. 登录：Compás 通过 HTTPS 将你的凭据转发至 Last.fm；绝不会存储你的密码。",
    ["How Scrobbling Works"] = "记录功能运作方式",
    ["Tracks >= 30s only"] = "仅限 >= 30 秒的曲目",
    ["Listened 50% or 4 min"] = "播放满 50% 或 4 分钟",
    ["Pauses do not count"] = "暂停不计入",
    ["Up to 100 offline plays"] = "最多 100 条离线记录",
    ["13-day age limit"] = "13 天期限限制",
    ["Separate queue per user"] = "每个用户独立队列",
    ["Credentials forwarded; password never stored"] = "凭据已转发；密码绝不存储",
    ["Compás sign-in service forwards credentials to Last.fm; password never stored."] = "Compás 登录服务将凭据转发至 Last.fm；绝不存储密码。",
    ["Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."] = ">= 30 秒的曲目在播放 50% 或 4 分钟后记录。离线队列最多 100 条。",
    ["API Key: Configured"] = "API 密钥：已配置",
    ["API Key: Not configured"] = "API 密钥：未配置",
    ["API Secret: Configured"] = "API 密钥口令：已配置",
    ["API Secret: Not configured"] = "API 密钥口令：未配置",
    ["Sign In to Last.fm"] = "登录 Last.fm",
    ["Sign Out (%s)"] = "退出登录 (%s)",
    ["Discard waiting plays (%d)"] = "丢弃等待中的播放记录 (%d)",
    ["Status: Signing in…"] = "状态：正在登录…",
    ["Sign-in is currently in progress."] = "登录目前正在进行中。",
    ["Cancel sign-in"] = "取消登录",
    ["Account & settings"] = "账号与设置",
    ["Status: API key/secret rejected"] = "状态：API 密钥/口令已被拒绝",
    ["Status: %s"] = "状态：%s",
    ["Signed in as %s"] = "已作为 %s 登录",
    ["This track: No music playing"] = "当前曲目：未播放音乐",
    ["This track: Scrobbling off"] = "当前曲目：记录已关闭",
    ["This track: Reading length"] = "当前曲目：正在读取时长",
    ["This track: Too short (<30s)"] = "当前曲目：太短 (<30秒)",
    ["This track: Starts counting next song"] = "当前曲目：从下一首歌曲开始计入",
    ["This track: %s"] = "当前曲目：%s",
    ["This track: This listen not counted"] = "当前曲目：此次聆听不计入",
    ["This track: Playback paused"] = "当前曲目：播放已暂停",
    ["This track: Counts after %s"] = "当前曲目：播放达到 %s 后计入",
    ["No track playing."] = "没有正在播放的曲目。",
    ["Scrobbling"] = "记录播放",
    ["Scrobbling: %s"] = "记录播放：%s",
    ["Scrobbling\n%s"] = "记录播放\n%s",
    ["Scrobbling turned on."] = "记录功能已开启。",
    ["Scrobbling turned off."] = "记录功能已关闭。",
    ["Waiting plays could not be read"] = "无法读取等待中的播放记录",
    ["%d play waiting"] = "%d 条播放记录等待中",
    ["%d plays waiting"] = "%d 条播放记录等待中",
    ["Sending…"] = "正在发送…",
    ["waiting for Wi-Fi"] = "等待 Wi-Fi",
    ["next try %dm"] = "将在 %d 分钟后重试",
    ["sent %s"] = "已发送于 %s",
    ["Sync now"] = "立即同步",
  },
}
local function tr(s)
  return plugin.tr(s, T)
end

-- Last.fm scrobbler with guided setup, queue inspection, and bounded offline queue.

local API_URL = "https://ws.audioscrobbler.com/2.0/"
local GATEWAY_URL = "https://lastfm.compasplayer.org"
local LEGACY_STATE_PATH = plugin.sd_root() .. "/.plugins/.lastfm_scrobbler_v2_state"
local LEGACY_QUEUE_PATH = plugin.sd_root() .. "/.plugins/.lastfm_scrobbler_v2_queue"
local QUEUE_MAX_RECORDS = 100
local QUEUE_MAX_BYTES = 65536
local QUEUE_MAX_AGE = 13 * 24 * 60 * 60
local REQUEST_TIMEOUTS = { connect_timeout_ms = 8000, read_timeout_ms = 12000, total_timeout_ms = 20000 }
local TEMPORARY_ERRORS = { ["11"] = true, ["16"] = true, ["29"] = true }
local CREDENTIAL_ERRORS = { ["10"] = true, ["13"] = true, ["26"] = true }

-- Queue sync backoff and status tracking
local sync_failures, next_sync_at = 0, 0
local credentials_rejected = false
local credential_generation = 0
local persistent_error = nil
local login_in_flight = false
local login_progress_handle = nil
local session_expired = false
local next_expiry_clear_at = 0

local function same_account(a, b)
  return type(a) == "string" and type(b) == "string" and a:lower() == b:lower()
end

local function has_secrets()
  return type(plugin.secrets) == "table" and type(plugin.secrets.get) == "function"
    and type(plugin.secrets.set) == "function"
end

local function get_secret(key)
  if has_secrets() then
    local val = plugin.secrets.get(key)
    if val and val ~= "" then return val end
  end
  return plugin.storage.get(key, "")
end

local function set_secret(key, value)
  if has_secrets() then
    local ok = plugin.secrets.set(key, value)
    if ok then
      plugin.storage.delete(key)
      return true
    end
    return false
  end
  return plugin.storage.set(key, value)
end

local function delete_secret(key)
  if has_secrets() then
    pcall(function() plugin.secrets.delete(key) end)
  end
  plugin.storage.delete(key)
end

-- Move stored secret and session into plugin.secrets if available.
-- If migration write fails, retain in storage as fallback.
if has_secrets() then
  local stored_secret = plugin.storage.get("api_secret")
  if stored_secret and stored_secret ~= "" then
    local sec = plugin.secrets.get("api_secret")
    if not sec or sec == "" then
      if plugin.secrets.set("api_secret", stored_secret) then
        plugin.storage.delete("api_secret")
      end
    else
      plugin.storage.delete("api_secret")
    end
  end

  local stored_session = plugin.storage.get("session_key")
  if stored_session and stored_session ~= "" then
    local sess = plugin.secrets.get("session_key")
    if not sess or sess == "" then
      if plugin.secrets.set("session_key", stored_session) then
        plugin.storage.delete("session_key")
      end
    else
      plugin.storage.delete("session_key")
    end
  end
end

local API_KEY = plugin.storage.get("api_key", "")
local API_SECRET = get_secret("api_secret")
local state = {
  enabled = plugin.storage.get("enabled", "0") == "1",
  session_key = get_secret("session_key"),
  username = plugin.storage.get("username"),
}
if state.session_key == "" then state.session_key = nil end
if state.username == "" then state.username = nil end

-- Commit username and session together. A signed-out record takes precedence
-- over legacy copies even if their deletion fails; they cannot revive a login.
local auth_record = get_secret("auth_record")
local auth_record_exists = auth_record ~= ""
if has_secrets() and type(plugin.secrets.exists) == "function" then
  auth_record_exists = auth_record_exists or plugin.secrets.exists("auth_record")
end
local last_username = state.username
if auth_record_exists then
  state.session_key, state.username = nil, nil
  local name, key = auth_record:match("^1\n([^\n]+)\n([^\n]+)$")
  if name and key and #name <= 255 and #key <= 256
      and not name:find("%c") and not key:find("%c") then
    state.username, state.session_key, last_username = name, key, name
  else
    local previous = auth_record:match("^0\n([^\n]*)$")
    if previous and #previous <= 255 and not previous:find("%c") then
      last_username = previous ~= "" and previous or nil
    else
      persistent_error = "Saved account could not be read. Sign in again."
    end
  end
end
local legacy_account_username = nil

local function remove_legacy_file(path)
  if os.remove(path) then return end
  local f = io.open(path, "r")
  if f then
    f:close()
    plugin.show_toast(tr("Could not remove an old Last.fm file from the SD card"))
  end
end

local legacy_state_done = plugin.storage.get("legacy_state_done") == "1"
if legacy_state_done then
  remove_legacy_file(LEGACY_STATE_PATH)
elseif not state.session_key and not auth_record_exists then
  local f = io.open(LEGACY_STATE_PATH, "r")
  if f then
    local enabled_line = f:read("*l")
    local session_line = f:read("*l")
    local username_line = f:read("*l")
    f:close()
    if session_line and session_line ~= "" and set_secret("session_key", session_line) then
      state.session_key = session_line
      state.username = username_line
      legacy_account_username = username_line
      plugin.storage.set("username", username_line or "")
      plugin.storage.set("enabled", enabled_line == "1" and "1" or "0")
      state.enabled = enabled_line == "1"
      if plugin.storage.set("legacy_queue_account", username_line or "")
          and plugin.storage.set("legacy_state_done", "1") then
        remove_legacy_file(LEGACY_STATE_PATH)
      end
    end
  end
else
  local legacy = io.open(LEGACY_STATE_PATH, "r")
  if legacy then
    legacy:read("*l")
    legacy:read("*l")
    legacy_account_username = legacy:read("*l")
    legacy:close()
    if plugin.storage.set("legacy_queue_account", legacy_account_username or "")
        and plugin.storage.set("legacy_state_done", "1") then
      remove_legacy_file(LEGACY_STATE_PATH)
    end
  end
end

local had_account = auth_record_exists or state.session_key ~= nil
local enable_pending = false
last_username = state.username or last_username

local function session_record(key, username)
  if type(key) ~= "string" or type(username) ~= "string" or key == "" or username == ""
      or #key > 256 or #username > 255 or key:find("%c") or username:find("%c") then return nil end
  return "1\n" .. username .. "\n" .. key
end

-- Older values remain usable if the atomic migration cannot be saved.
if not auth_record_exists and state.session_key and state.username then
  local record = session_record(state.session_key, state.username)
  if record and set_secret("auth_record", record) then
    auth_record_exists = true
    delete_secret("session_key")
    plugin.storage.delete("username")
  end
end

local function is_gateway_token(token)
  return type(token) == "string" and token:sub(1, 4) == "cg1_"
end

local function get_gateway_url()
  if not GATEWAY_URL:match("^https://[^/]+") or GATEWAY_URL:find("[%s%c?#@]") then return nil end
  local base = GATEWAY_URL:gsub("/+$", "")
  if base:match("/v1/lastfm$") then
    return base
  end
  return base .. "/v1/lastfm"
end

local function uses_gateway()
  if state.session_key and is_gateway_token(state.session_key) then
    return true
  end
  if state.session_key then
    return false
  end
  if API_KEY ~= "" or API_SECRET ~= "" then
    return false
  end
  return GATEWAY_URL ~= ""
end

local function service_ready()
  if uses_gateway() then
    return get_gateway_url() ~= nil
  else
    return API_KEY ~= "" and API_SECRET ~= ""
  end
end


if is_gateway_token(state.session_key) and not get_gateway_url() and not persistent_error then
  persistent_error = "Last.fm service not configured."
end

local function save_enabled()
  return plugin.storage.set("enabled", state.enabled and "1" or "0")
end

local function save_session(session_key, username)
  local record = session_record(session_key, username)
  if not record or not set_secret("auth_record", record) then return false end
  state.session_key, state.username, last_username = session_key, username, username
  session_expired = false
  auth_record_exists = true
  delete_secret("session_key")
  plugin.storage.delete("username")
  return true
end

local function clear_session()
  local name = state.username or last_username or ""
  if #name > 255 or name:find("%c") then name = "" end
  if not set_secret("auth_record", "0\n" .. name) then return false end
  auth_record_exists = true
  last_username = name ~= "" and name or nil
  state.session_key, state.username = nil, nil
  session_expired = false
  delete_secret("session_key")
  plugin.storage.delete("username")
  return true
end

local function invalidate_session()
  session_expired = true
  next_expiry_clear_at = os.time() + 30
  if clear_session() then
    persistent_error = "Session expired. Sign in again."
  else
    -- Keep the same stored/in-memory pair, but never use a revoked token.
    persistent_error = "Session expired; sign-out could not be saved. Sign in again."
  end
end

local function url_encode(value)
  return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

local function build_query(params)
  local parts = {}
  for k, v in pairs(params) do
    if v ~= nil then table.insert(parts, url_encode(k) .. "=" .. url_encode(v)) end
  end
  return table.concat(parts, "&")
end

local function sign(params)
  local keys = {}
  for k in pairs(params) do table.insert(keys, k) end
  table.sort(keys)
  local concat = ""
  for _, k in ipairs(keys) do concat = concat .. k .. tostring(params[k]) end
  return plugin.md5(concat .. (API_SECRET or ""))
end

local function api_call(params, callback)
  local use_gw = false
  if params and params.sk then
    use_gw = is_gateway_token(params.sk)
  else
    use_gw = uses_gateway()
  end

  local url
  local req_params = {}
  if params then
    for k, v in pairs(params) do req_params[k] = v end
  end

  if use_gw then
    url = get_gateway_url()
    if not url then return nil end
    req_params.api_key = nil
    req_params.api_sig = nil
  else
    url = API_URL
    req_params.api_key = API_KEY
    req_params.api_sig = sign(req_params)
  end

  local options = {
    url = url,
    method = "POST",
    headers = { ["User-Agent"] = "Compas-LastFmScrobbler/1.7" },
    body = build_query(req_params),
    content_type = "application/x-www-form-urlencoded",
    verify_tls = true,
    max_response_bytes = 262144,
    connect_timeout_ms = REQUEST_TIMEOUTS.connect_timeout_ms,
    read_timeout_ms = REQUEST_TIMEOUTS.read_timeout_ms,
    total_timeout_ms = REQUEST_TIMEOUTS.total_timeout_ms,
  }
  return plugin.http_request(options, callback)
end

local active_requests = {}
local active_request_tokens = {}
local account_generation = 0
local queue_sync_token = nil

local function cancel_request(kind)
  local handle = active_requests[kind]
  if handle then
    plugin.cancel(handle)
    active_requests[kind] = nil
  end
  active_request_tokens[kind] = nil
end

local function tracked_api_call(kind, params, callback)
  cancel_request(kind)
  local token = {}
  active_request_tokens[kind] = token
  local handle = api_call(params, function(...)
    if active_request_tokens[kind] ~= token then return end
    active_request_tokens[kind] = nil
    active_requests[kind] = nil
    callback(...)
  end)
  if handle and active_request_tokens[kind] == token then
    active_requests[kind] = handle
  elseif not handle and active_request_tokens[kind] == token then
    active_request_tokens[kind] = nil
  end
  return handle
end

local function cancel_account_requests()
  account_generation = account_generation + 1
  for kind in pairs(active_requests) do cancel_request(kind) end
  queue_sync_token = nil
  login_in_flight = false
  if login_progress_handle and plugin.close_progress then
    plugin.close_progress(login_progress_handle)
    login_progress_handle = nil
  end
end

local function trim(str)
  return str and str:match("^%s*(.-)%s*$") or ""
end

local function truncate(str, max_len)
  str = tostring(str or "")
  str = str:gsub("%c", " ")
  if #str <= max_len then return str end
  local cut = max_len - 1
  while cut > 0 do
    local next_byte = str:byte(cut + 1)
    if not next_byte or next_byte < 128 or next_byte > 191 then break end
    cut = cut - 1
  end
  return str:sub(1, cut) .. "…"
end

local function format_time(seconds)
  seconds = math.max(0, math.floor(seconds or 0))
  local m = math.floor(seconds / 60)
  local s = seconds % 60
  return string.format("%d:%02d", m, s)
end

local function show_input(title, initial, secret, callback)
  local ok = plugin.show_text_input(title, initial, secret, callback)
  if not ok then plugin.show_toast(tr("Could not open text entry. Try again.")) end
  return ok
end

-- Queue data is one bounded storage value per account.
local function queue_key(username)
  return "queue_" .. plugin.md5((username or ""):lower())
end

local function queue_encode(value)
  return url_encode(value or "")
end

local function queue_decode(value)
  return (value or ""):gsub("%%(%x%x)", function(hex) return string.char(tonumber(hex, 16)) end)
end

local function parse_queue_line(line)
  local id, timestamp, duration, artist, title, album = line:match("^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)$")
  if not id then return nil end
  timestamp, duration = tonumber(timestamp), tonumber(duration)
  if not timestamp or timestamp <= 0 then return nil end
  return { id = id, timestamp = timestamp, duration = duration or 0,
    artist = queue_decode(artist), title = queue_decode(title), album = queue_decode(album) }
end

local function queue_line(item)
  return table.concat({ item.id, tostring(item.timestamp), tostring(item.duration),
    queue_encode(item.artist), queue_encode(item.title), queue_encode(item.album) }, "\t")
end

local function load_queue(key)
  local raw = plugin.storage.get(key, "")
  if #raw > QUEUE_MAX_BYTES then return nil end
  local items, dropped = {}, false
  for line in raw:gmatch("([^\n]+)") do
    local item = parse_queue_line(line)
    if item and item.timestamp >= os.time() - QUEUE_MAX_AGE then
      items[#items + 1] = item
      if #items > QUEUE_MAX_RECORDS then return nil end
    else
      dropped = true
    end
  end
  return items, dropped
end

local function save_queue(key, items)
  local lines = {}
  for i = 1, #items do lines[i] = queue_line(items[i]) end
  local raw = table.concat(lines, "\n")
  if #items > QUEUE_MAX_RECORDS or #raw > QUEUE_MAX_BYTES then return false end
  return plugin.storage.set(key, raw)
end

local function get_queued_count(username)
  if not username or username == "" then return 0 end
  local items = load_queue(queue_key(username))
  return items and #items or nil
end

local LEGACY_QUEUE_READ_BYTES = 262144
local function migrate_legacy_queue()
  if plugin.storage.get("legacy_queue_done") == "1" then
    plugin.storage.delete("legacy_queue_account")
    remove_legacy_file(LEGACY_QUEUE_PATH)
    return
  end
  local account = legacy_account_username or plugin.storage.get("legacy_queue_account")
  local f = io.open(LEGACY_QUEUE_PATH, "r")
  if not f then
    if account then plugin.storage.delete("legacy_queue_account") end
    return
  end
  if not account or account == "" then f:close(); return end
  local size = f:seek("end") or 0
  local start = math.max(0, size - LEGACY_QUEUE_READ_BYTES)
  f:seek("set", start)
  local body = f:read(LEGACY_QUEUE_READ_BYTES) or ""
  f:close()
  if start > 0 then
    body = body:match("^[^\n]*\n(.*)$") or ""
  end

  local key = queue_key(account)
  local items = load_queue(key)
  if not items then return end
  local legacy = {}
  for line in body:gmatch("([^\n]+)") do
    local timestamp, duration, artist, title, album = line:match("^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)$")
    timestamp, duration = tonumber(timestamp), tonumber(duration)
    if timestamp and timestamp >= os.time() - QUEUE_MAX_AGE and artist and title and album then
      legacy[#legacy + 1] = {
        id = "legacy-" .. tostring(timestamp) .. "-" .. plugin.md5(artist .. "\t" .. title),
        timestamp = timestamp,
        duration = duration or 0,
        artist = queue_decode(artist),
        title = queue_decode(title),
        album = queue_decode(album),
      }
    end
  end
  local bytes = 0
  local present = {}
  for _, item in ipairs(items) do
    bytes = bytes + #queue_line(item) + 1
    present[item.id] = true
  end
  local take = {}
  for i = #legacy, 1, -1 do
    if present[legacy[i].id] then goto continue end
    local line_bytes = #queue_line(legacy[i]) + 1
    if #items + #take >= QUEUE_MAX_RECORDS or bytes + line_bytes > QUEUE_MAX_BYTES then break end
    bytes = bytes + line_bytes
    table.insert(take, 1, legacy[i])
    ::continue::
  end
  for _, item in ipairs(take) do items[#items + 1] = item end
  if save_queue(key, items) and plugin.storage.set("legacy_queue_done", "1") then
    plugin.storage.delete("legacy_queue_account")
    remove_legacy_file(LEGACY_QUEUE_PATH)
  end
end

migrate_legacy_queue()

local sent_ids = {}

local function enqueue_scrobble(item, username)
  if not item.timestamp or item.timestamp <= 0 or item.artist == "" or item.title == "" then return false end
  local key = queue_key(username)
  local items = load_queue(key)
  if not items then return false end
  if item.id and sent_ids[item.id] then return true end
  if item.id then
    for _, queued in ipairs(items) do
      if queued.id == item.id then return true end
    end
  end
  if #items >= QUEUE_MAX_RECORDS then return false end
  if not item.id then
    local sequence_key = key .. "_sequence"
    local sequence = (tonumber(plugin.storage.get(sequence_key, "0")) or 0) + 1
    if not plugin.storage.set(sequence_key, tostring(sequence)) then return false end
    item.id = tostring(item.timestamp) .. "-" .. tostring(sequence)
  end
  items[#items + 1] = item
  return save_queue(key, items)
end

-- Network awareness (player API 18). On older players none of this exists and
-- the plugin behaves as before: no offline detection, backoff only.
local MAX_BACKOFF = 300
local NETWORK_ERROR = "Last.fm not reachable."
local OFFLINE_OFF = "Wi-Fi off \u{2014} will send when connected"
local OFFLINE_NO_LINK = "Wi-Fi not connected \u{2014} will send when connected"

local function network_state()
  if type(plugin.network_status) ~= "function" then return nil end
  if plugin.has_capability and not plugin.has_capability("network.status") then return nil end
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

local last_failure_network = false

local function sync_failed(reason)
  reason = reason or "Waiting list could not be updated."
  last_failure_network = (reason == NETWORK_ERROR)
  -- A stale "not connected" can hold plays back for at most MAX_BACKOFF.
  local delay
  if last_failure_network and link_down() then
    -- No link: network_changed will trigger an immediate send on reconnect,
    -- so just wait out the long fallback without growing the backoff.
    delay = MAX_BACKOFF
  else
    sync_failures = sync_failures + 1
    delay = math.min(15 * 2 ^ (sync_failures - 1), MAX_BACKOFF)
  end
  next_sync_at = os.time() + delay
  -- The delay is shown live on the queue row, never baked into this text.
  persistent_error = reason
end

local function format_last_sent(ts)
  ts = tonumber(ts)
  if not ts or ts <= 0 then return nil end
  local fmt = (os.time() - ts) > 86400 and "%m-%d %H:%M" or "%H:%M"
  local ok, text = pcall(os.date, fmt, ts)
  return ok and text or nil
end

local function remove_queued(key, id)
  local latest = load_queue(key)
  if not latest then return false end
  for i, queued in ipairs(latest) do
    if queued.id == id then
      table.remove(latest, i)
      return save_queue(key, latest)
    end
  end
  return true
end

-- UI handle and safe refresh declarations
local current_main_handle = nil
local main_refresh_pending = false
local refresh_main_list
local current_record, current_record_account, current_delivery

local sync_queue
sync_queue = function()
  if session_expired then
    if os.time() >= next_expiry_clear_at then
      next_expiry_clear_at = os.time() + 30
      if clear_session() then
        persistent_error = "Session expired. Sign in again."
        if refresh_main_list then refresh_main_list() end
      end
    end
    return
  end
  if not service_ready() then
    if is_gateway_token(state.session_key) and not get_gateway_url() then
      persistent_error = "Last.fm service not configured."
      if refresh_main_list then refresh_main_list() end
    end
    return
  end
  if queue_sync_token or os.time() < next_sync_at or credentials_rejected
      or not (state.enabled and state.session_key and state.username) then return end
  -- Wi-Fi switched off: nothing to try.
  if wifi_disabled() then return end
  local pending_import = plugin.storage.get("legacy_queue_account")
  if pending_import and pending_import:lower() == state.username:lower()
      and plugin.storage.get("legacy_queue_done") ~= "1" then return end
  local account_name = state.username
  local key = queue_key(account_name)
  local items, dropped = load_queue(key)
  if not items then return end
  if dropped and not save_queue(key, items) then return end
  while items[1] and sent_ids[items[1].id] do
    if not remove_queued(key, items[1].id) then
      sync_failed("Waiting list could not be updated.")
      if refresh_main_list then refresh_main_list() end
      return
    end
    table.remove(items, 1)
  end
  local item = items[1]
  if not item then return end

  local token = {}
  queue_sync_token = token
  local generation = account_generation
  local sent_with_credentials = credential_generation
  local handle = api_call({ method = "track.scrobble", sk = state.session_key, track = item.title,
    artist = item.artist, album = item.album ~= "" and item.album or nil,
    timestamp = tostring(item.timestamp), duration = tostring(math.floor(item.duration)) },
    function(status, body, request_error)
      if queue_sync_token == token then
        queue_sync_token = nil
        active_requests.queue = nil
      end
      if generation ~= account_generation then return end
      if request_error or not body then
        if wifi_disabled() then
          -- Wi-Fi was switched off mid-request: wait for network_changed.
          if persistent_error == NETWORK_ERROR then persistent_error = nil end
        else
          sync_failed(NETWORK_ERROR)
        end
        if refresh_main_list then refresh_main_list() end
        return
      end
      if status == 200 and body:match('status="ok"') then
        sync_failures, next_sync_at = 0, 0
        last_failure_network = false
        persistent_error = nil
        plugin.storage.set("last_sent_at", tostring(os.time()))
        sent_ids[item.id] = true
        if current_record and current_record.id == item.id and same_account(current_record_account, account_name) then
          local ignored = body:match('<ignoredMessage[^>]*code="(%d+)"')
          current_delivery = ignored and ignored ~= "0" and "Not counted by Last.fm" or "Sent to Last.fm"
        end
        if remove_queued(key, item.id) then
          if refresh_main_list then refresh_main_list() end
          sync_queue()
        else
          sync_failed("Sent, but waiting-list cleanup could not be saved.")
          if refresh_main_list then refresh_main_list() end
        end
        return
      end
      local code = body:match('<error code="(%d+)"')
      if code and CREDENTIAL_ERRORS[code] then
        if uses_gateway() then
          sync_failed("Last.fm service problem.")
          plugin.show_toast(tr("Last.fm service problem."))
        else
          if sent_with_credentials == credential_generation then
            credentials_rejected = true
            persistent_error = "API key or secret rejected by Last.fm."
            plugin.show_toast(tr("API key or secret rejected by Last.fm. Check settings."))
          end
        end
      elseif code == "9" then
        cancel_account_requests()
        invalidate_session()
        plugin.show_toast(tr(persistent_error))
      elseif code and not TEMPORARY_ERRORS[code] then
        if current_record and current_record.id == item.id and same_account(current_record_account, account_name) then
          current_delivery = "Last.fm rejected this play"
        end
        sent_ids[item.id] = true
        if not remove_queued(key, item.id) then sync_failed("Waiting list could not be updated.") end
        if refresh_main_list then refresh_main_list() end
        sync_queue()
        return
      else
        sync_failed("Last.fm temporarily busy.")
      end
      if refresh_main_list then refresh_main_list() end
    end)
  if handle then
    if queue_sync_token == token then
      active_requests.queue = handle
      -- Show "Sending…" on the main screen.
      if refresh_main_list then refresh_main_list() end
    end
  else
    if queue_sync_token == token then queue_sync_token = nil end
    sync_failed("Could not send scrobble request.")
    if refresh_main_list then refresh_main_list() end
  end
end

local function retry_now()
  if not service_ready() then
    if uses_gateway() then
      persistent_error = "Last.fm service not configured."
      plugin.show_toast(tr("Last.fm service not configured."))
      if refresh_main_list then refresh_main_list() end
    else
      plugin.show_toast(tr("Check your API key and shared secret in Account settings."))
    end
    return
  end
  if credentials_rejected then
    plugin.show_toast(tr("Check your API key and shared secret in Account settings."))
    return
  end
  if session_expired or not state.session_key then plugin.show_toast(tr("Sign in before sending waiting plays.")); return end
  if not state.enabled then plugin.show_toast(tr("Turn scrobbling on before sending waiting plays.")); return end
  local count = get_queued_count(state.username)
  if count == nil then plugin.show_toast(tr("Waiting plays could not be read.")); return end
  if count == 0 then plugin.show_toast(tr("No plays are waiting to send.")); return end
  if queue_sync_token then plugin.show_toast(tr("Already sending waiting plays.")); return end
  if wifi_disabled() then plugin.show_toast(offline_text()); return end
  sync_failures, next_sync_at, persistent_error = 0, 0, nil
  plugin.show_toast(tr("Sending waiting plays…"))
  sync_queue()
  if refresh_main_list then refresh_main_list() end
end

local current_title, current_artist, current_album, current_duration = nil, nil, nil, 0
local track_start_time = 0
local listened_seconds = 0
local playing_since = nil

local function listened_now()
  local open = playing_since and math.max(0, os.time() - playing_since) or 0
  return listened_seconds + open
end

local function close_stretch()
  listened_seconds = listened_now()
  playing_since = nil
end
local scrobbled_this_track = false
current_record = nil
local current_account = nil

local function save_current_play()
  local account = current_account
  if scrobbled_this_track or not state.enabled or not account or not current_title or not current_artist
      or current_duration < 30 or listened_now() < math.min(current_duration / 2, 240) then return end
  current_record = current_record or { timestamp = track_start_time, artist = current_artist,
    title = current_title, album = current_album or "", duration = current_duration }
  if enqueue_scrobble(current_record, account) then
    scrobbled_this_track = true
    current_record_account, current_delivery = account, "Waiting to send"
    if persistent_error == "Waiting list is full or unavailable. Play not saved yet." then persistent_error = nil end
    if refresh_main_list then refresh_main_list() end
    sync_queue()
  else
    current_delivery = "Not saved yet"
    persistent_error = "Waiting list is full or unavailable. Play not saved yet."
    if refresh_main_list then refresh_main_list() end
  end
end

local function update_now_playing()
  if not service_ready() then
    if is_gateway_token(state.session_key) and not get_gateway_url() then
      persistent_error = "Last.fm service not configured."
    end
    return
  end
  if credentials_rejected or session_expired or not (state.enabled and state.session_key and current_title and current_artist) then return end
  local generation = account_generation
  local sent_with_credentials = credential_generation
  tracked_api_call("now_playing", { method = "track.updateNowPlaying", sk = state.session_key,
    track = current_title, artist = current_artist, album = current_album ~= "" and current_album or nil,
    duration = tostring(math.floor(current_duration)) }, function(status, body, request_error)
      if generation ~= account_generation then return end
      if not request_error and status == 200 and body then
        local code = body:match('<error code="(%d+)"')
        if code == "9" then
          cancel_account_requests()
          invalidate_session()
          plugin.show_toast(tr(persistent_error))
          if refresh_main_list then refresh_main_list() end
        elseif code and CREDENTIAL_ERRORS[code] then
          if uses_gateway() then
            persistent_error = "Last.fm service problem."
            plugin.show_toast(tr(persistent_error))
            if refresh_main_list then refresh_main_list() end
          else
            if sent_with_credentials == credential_generation then
              credentials_rejected = true
              persistent_error = "API key or secret rejected by Last.fm."
              plugin.show_toast(tr("API key or secret rejected by Last.fm. Check settings."))
              if refresh_main_list then refresh_main_list() end
            end
          end
        end
      end
    end)
end

plugin.on("track_started", function(title, artist, album, duration_seconds)
  close_stretch()
  save_current_play()
  current_title, current_artist, current_album, current_duration = title, artist, album, duration_seconds or 0
  current_account = not session_expired and state.session_key and state.username or nil
  track_start_time = os.time()
  listened_seconds = 0
  playing_since = state.enabled and plugin.is_playing() and os.time() or nil
  scrobbled_this_track, current_record = false, nil
  current_record_account, current_delivery = nil, nil
  update_now_playing()
  sync_queue()
  if refresh_main_list then refresh_main_list() end
end)

local last_backoff_refresh = 0

plugin.set_interval(5, function()
  -- A real change while a child was open is rendered once after returning.
  -- This is not a periodic redraw of the dashboard or a ticking countdown.
  if main_refresh_pending and refresh_main_list then refresh_main_list() end
  if plugin.is_playing() and state.enabled then
    if not playing_since then playing_since = os.time() end
  elseif playing_since then
    close_stretch()
  end
  if not state.enabled then
    return
  end
  sync_queue()
  -- The queue row shows "next try Nm": redraw at most once a minute while
  -- backing off (the fingerprint check skips it if nothing changed).
  if next_sync_at > os.time() and os.time() - last_backoff_refresh >= 60 then
    last_backoff_refresh = os.time()
    if refresh_main_list then refresh_main_list() end
  end
  if not current_title or not current_artist or scrobbled_this_track then
    return
  end
  if current_duration <= 0 then
    current_duration = plugin.get_duration() or 0
    if current_duration > 0 then main_refresh_pending = true end
  end
  if current_duration < 30 then
    return
  end
  if listened_now() >= math.min(current_duration / 2, 240) then
    save_current_play()
  end
end)

-- Connectivity came back (or may have, after sleep): send promptly. The
-- backoff is dropped only if the last failure was a network one; rate-limit,
-- service and storage backoffs stay, and sync_queue() still honours them.
local function network_back()
  if wifi_disabled() then return end
  if last_failure_network then
    sync_failures, next_sync_at = 0, 0
    if persistent_error == NETWORK_ERROR then persistent_error = nil end
  end
  if state.enabled then sync_queue() end
  if refresh_main_list then refresh_main_list() end
end

if type(plugin.network_status) == "function" then
  pcall(plugin.on, "network_changed", function(info)
    if type(info) == "table" and info.connected then
      network_back()
    elseif refresh_main_list then
      refresh_main_list()
    end
  end)
end
-- Fallbacks for players without network_changed, and for Wi-Fi that stayed
-- up across sleep while the old backoff was still ticking.
pcall(plugin.on, "system_resumed", network_back)
pcall(plugin.on, "screen_woke", function()
  if next_sync_at > 0 then network_back() end
end)

local function set_scrobbling(value)
  if not plugin.storage.set("enabled", value and "1" or "0") then
    plugin.show_toast(tr("Could not save scrobbling preference. Try again."))
    return false
  end
  state.enabled = value
  enable_pending = false
  if not value then
    close_stretch()
    scrobbled_this_track = true
  else
    listened_seconds = 0
    playing_since = plugin.is_playing() and os.time() or nil
    sync_failures, next_sync_at = 0, 0
    sync_queue()
  end
  if refresh_main_list then refresh_main_list() end
  return true
end

local function playback_paused()
  close_stretch()
  if refresh_main_list then refresh_main_list() end
end
plugin.on("paused", playback_paused)
plugin.on("stopped", playback_paused)
plugin.on("resumed", function()
  if state.enabled and not playing_since then playing_since = os.time() end
  if refresh_main_list then refresh_main_list() end
end)

local function prompt_api_key(on_success)
  show_input(tr("Last.fm API key"), nil, false, function(value)
    if value == nil or value == "" then return end
    local trimmed = trim(value)
    if trimmed == "" or trimmed:find("%c") then
      plugin.show_toast(tr("API key cannot contain control characters."))
      return
    end
    if #trimmed ~= 32 or trimmed:find("%s") then
      plugin.show_toast(tr("Use the 32-character API key without spaces."))
      return
    end
    if plugin.storage.set("api_key", trimmed) then
      API_KEY = trimmed
      credentials_rejected = false
      credential_generation = credential_generation + 1
      cancel_account_requests()
      plugin.show_toast(tr("API key saved."))
      if refresh_main_list then refresh_main_list() end
      if on_success then on_success() end
    else
      plugin.show_toast(tr("Could not save API key. Try again."))
    end
  end)
end

local function prompt_api_secret(on_success)
  show_input(tr("Last.fm Shared Secret"), nil, true, function(value)
    if value == nil or value == "" then return end
    local trimmed = trim(value)
    if trimmed == "" or trimmed:find("%c") then
      plugin.show_toast(tr("API secret cannot contain control characters."))
      return
    end
    if set_secret("api_secret", trimmed) then
      API_SECRET = trimmed
      credentials_rejected = false
      credential_generation = credential_generation + 1
      cancel_account_requests()
      plugin.show_toast(tr("Shared secret saved."))
      if refresh_main_list then refresh_main_list() end
      if on_success then on_success() end
    else
      plugin.show_toast(tr("Could not save shared secret. Try again."))
    end
  end)
end

local function cancel_login()
  if not login_in_flight then return end
  cancel_request("login")
  account_generation = account_generation + 1
  login_in_flight = false
  if login_progress_handle and plugin.close_progress then
    plugin.close_progress(login_progress_handle)
    login_progress_handle = nil
  end
  plugin.show_toast(tr("Sign-in cancelled."))
  if refresh_main_list then refresh_main_list() end
end

local function do_login(username, password)
  cancel_account_requests()
  local generation = account_generation
  local route_is_gateway = uses_gateway()
  login_in_flight = true

  local progress_handle = nil
  if plugin.has_capability and plugin.has_capability("ui.progress") and plugin.show_progress then
    progress_handle = plugin.show_progress("Last.fm", tr("Signing in…"))
  end
  login_progress_handle = progress_handle

  plugin.show_toast(tr("Logging in to Last.fm…"))
  if refresh_main_list then refresh_main_list() end

  local handle = tracked_api_call("login", {
    method = "auth.getMobileSession",
    username = username,
    password = password
  }, function(status, body, request_error)
    if login_progress_handle and plugin.close_progress then
      plugin.close_progress(login_progress_handle)
      login_progress_handle = nil
    end
    login_in_flight = false

    if generation ~= account_generation then
      if refresh_main_list then refresh_main_list() end
      return
    end

    if not request_error and status == 200 and body and body:match('status="ok"') then
      local key = body:match("<key>([^<]+)</key>")
      local canon_name = body:match("<name>([^<]+)</name>")
      if canon_name then
        canon_name = trim(canon_name)
        if canon_name == "" or #canon_name > 255 or canon_name:find("%c") then
          canon_name = username
        end
      else
        canon_name = username
      end

      local valid_key = false
      if route_is_gateway then
        valid_key = key and #key == 47 and key:match("^cg1_[A-Za-z0-9_%-]+$") ~= nil
      else
        valid_key = key ~= nil and #key <= 256 and not key:find("%c")
      end

      local switching_account = current_account and current_account:lower() ~= canon_name:lower()
      if valid_key and save_session(key, canon_name) then
        if switching_account then
          scrobbled_this_track = true
          current_record, current_record_account, current_delivery = nil, nil, nil
        end
        if not had_account or enable_pending then
          state.enabled = true
          if not save_enabled() then
            state.enabled, enable_pending = false, true
            plugin.show_toast(tr("Account saved. Tap Scrobbling to turn it on."))
          else
            enable_pending = false
          end
          listened_seconds = 0
          playing_since = plugin.is_playing() and os.time() or nil
        end
        had_account = true
        sync_failures, next_sync_at = 0, 0
        credentials_rejected = false
        persistent_error = nil
        plugin.show_toast(string.format(tr("Logged in to Last.fm as %s"), canon_name))
        sync_queue()
        if refresh_main_list then refresh_main_list() end
        return
      else
        persistent_error = route_is_gateway and not valid_key and "Last.fm service problem. Sign in again." or "Could not save session."
        plugin.show_toast(tr(persistent_error))
        if refresh_main_list then refresh_main_list() end
        return
      end
    end

    local code = body and body:match('<error code="(%d+)"')
    if code == "4" then
      persistent_error = "Username or password incorrect."
      plugin.show_toast(tr(persistent_error))
    elseif code and CREDENTIAL_ERRORS[code] or code == "26" then
      if route_is_gateway then
        persistent_error = "Last.fm service problem."
        plugin.show_toast(tr(persistent_error))
      else
        credentials_rejected = true
        if code == "26" then
          persistent_error = "API key suspended by Last.fm."
        else
          persistent_error = "API key or secret rejected by Last.fm."
        end
        plugin.show_toast(tr(persistent_error))
      end
    elseif request_error or not status or status == 0 or status >= 500 then
      persistent_error = "Last.fm is not reachable. Check network."
      plugin.show_toast(tr(persistent_error))
    else
      persistent_error = "Could not log in to Last.fm. Check details."
      plugin.show_toast(tr(persistent_error))
    end
    if refresh_main_list then refresh_main_list() end
  end)

  if not handle then
    if login_progress_handle and plugin.close_progress then
      plugin.close_progress(login_progress_handle)
      login_progress_handle = nil
    end
    login_in_flight = false
    persistent_error = route_is_gateway and not get_gateway_url() and "Last.fm service not configured." or "Could not start login request."
    plugin.show_toast(tr(persistent_error))
    if refresh_main_list then refresh_main_list() end
  end
end

local setup_generation = 0

local start_login

local function start_guided_setup()
  if uses_gateway() then
    start_login()
    return
  end
  setup_generation = setup_generation + 1
  local my_generation = setup_generation
  local owner_handle = current_main_handle

  local function step_login()
    if session_expired or not state.session_key then
      show_input(tr("Last.fm Username"), nil, false, function(username)
        if not username or username == "" then return end
        local trimmed_user = trim(username)
        if trimmed_user == "" or trimmed_user:find("%c") then
          plugin.show_toast(tr("Invalid username."))
          return
        end
        show_input(tr("Last.fm Password"), nil, true, function(password)
          if not password or password == "" then return end
          if password:find("%c") then
            plugin.show_toast(tr("Password cannot contain control characters."))
            return
          end
          do_login(trimmed_user, password)
        end)
      end)
    else
      plugin.show_toast(tr("Last.fm setup is already complete."))
      if refresh_main_list then refresh_main_list() end
    end
  end

  local function step_secret()
    if API_SECRET == "" then
      prompt_api_secret(step_login)
    else
      step_login()
    end
  end

  local function step_key()
    if API_KEY == "" then
      prompt_api_key(step_secret)
    else
      step_secret()
    end
  end

  if API_KEY == "" and API_SECRET == "" then
    local setup_text = tr("To scrobble music to Last.fm:\n\n"
      .. "1. On a phone or computer, sign in to Last.fm.\n\n"
      .. "2. Open this address:\nlast.fm/api/account/create\n\n"
      .. "3. Create an application (any name is fine).\n\n"
      .. "4. If asked for callback URL, enter http://localhost\n\n"
      .. "5. Obtain your API Key and Shared Secret.\n\n"
      .. "Close this page to enter them.")

    if owner_handle and plugin.has_capability and plugin.has_capability("ui.text_view")
        and plugin.has_capability("ui.list_showing") and plugin.is_list_showing and plugin.show_text_view then
      local shown = plugin.show_text_view(tr("Set up Last.fm"), setup_text, {
        on_close = function()
          if my_generation ~= setup_generation then return end
          if owner_handle and plugin.has_capability and plugin.has_capability("ui.list_showing") and plugin.is_list_showing then
            if not plugin.is_list_showing(owner_handle) then return end
          end
          step_key()
        end
      })
      if shown == false then
        plugin.show_toast(tr("Could not open setup guide."))
        return
      end
    else
      plugin.show_toast(tr("Create an app at last.fm/api/account/create"))
      step_key()
    end
  else
    step_key()
  end
end

start_login = function()
  if uses_gateway() then
    if not get_gateway_url() then
      persistent_error = "Last.fm service not configured."
      plugin.show_toast(tr("Last.fm service not configured."))
      if refresh_main_list then refresh_main_list() end
      return
    end
  else
    if API_KEY == "" or API_SECRET == "" then
      plugin.show_toast(tr("Add your Last.fm API credentials first."))
      start_guided_setup()
      return
    end
  end
  if state.session_key and not session_expired then
    plugin.show_toast(tr("Already signed in to Last.fm."))
    if refresh_main_list then refresh_main_list() end
    return
  end
  if login_in_flight then
    plugin.show_toast(tr("Sign-in already in progress."))
    return
  end
  show_input(tr("Last.fm Username"), nil, false, function(username)
    if not username or username == "" then return end
    local trimmed_user = trim(username)
    if trimmed_user == "" or trimmed_user:find("%c") then
      plugin.show_toast(tr("Invalid username."))
      return
    end
    show_input(tr("Last.fm Password"), nil, true, function(password)
      if not password or password == "" then return end
      if password:find("%c") then
        plugin.show_toast(tr("Password cannot contain control characters."))
        return
      end
      do_login(trimmed_user, password)
    end)
  end)
end

local function finish_confirmation(handle, title, message)
  plugin.show_toast(message)
  if handle and plugin.has_capability and plugin.has_capability("ui.list_update")
      and plugin.is_list_showing and plugin.is_list_showing(handle) then
    plugin.show_list(title, { message .. " " .. tr("Press Back.") }, function() end, { replace = handle })
  end
end

local function confirm_sign_out()
  if not state.session_key then return end
  local username, generation = state.username, account_generation
  local done, handle = false, nil
  handle = plugin.show_list(tr("Sign out?"), { tr("Keep signed in"), string.format(tr("Sign out %s"), truncate(username, 20)) }, function(idx)
    if done or (idx ~= 1 and idx ~= 2) then return end
    done = true
    if idx == 1 then finish_confirmation(handle, tr("Sign out?"), tr("Kept signed in.")); return end
    if generation ~= account_generation or username ~= state.username then
      finish_confirmation(handle, tr("Sign out?"), tr("Account changed. Nothing changed.")); return
    end
    cancel_account_requests()
    if not clear_session() then
      finish_confirmation(handle, tr("Sign out?"), tr("Could not save sign-out. Try again."))
      return
    end
    close_stretch()
    scrobbled_this_track = true
    finish_confirmation(handle, tr("Sign out?"), tr("Signed out. Waiting plays are kept for this account."))
    if refresh_main_list then refresh_main_list() end
  end)
end

local function confirm_discard_queue()
  local username = state.username or last_username
  if not username or username == "" then return end
  local count = get_queued_count(username)
  if count == nil then plugin.show_toast(tr("Waiting plays could not be read. Nothing discarded.")); return end
  if count == 0 then plugin.show_toast(tr("No waiting plays to discard.")); return end
  local generation, done, handle = account_generation, false, nil
  local title = string.format(tr("Discard %d plays?"), count)
  handle = plugin.show_list(title, { tr("Keep waiting plays"), string.format(tr("Discard %d plays"), count) }, function(idx)
    if done or (idx ~= 1 and idx ~= 2) then return end
    done = true
    if idx == 1 then finish_confirmation(handle, title, tr("Kept waiting plays.")); return end
    if generation ~= account_generation or not same_account(username, state.username or last_username) then
      finish_confirmation(handle, title, tr("Account changed. Nothing discarded.")); return
    end
    -- Cancel and invalidate every reply before replacing the current account's queue.
    cancel_account_requests()
    if save_queue(queue_key(username), {}) then
      if current_record_account == username and current_record then current_delivery = "Discarded by you" end
      finish_confirmation(handle, title, tr("Waiting plays discarded."))
      if refresh_main_list then refresh_main_list() end
    else
      finish_confirmation(handle, title, tr("Could not discard plays. Try again."))
    end
  end)
end

local function open_queue_list()
  local username = state.username or last_username
  if not username then plugin.show_toast(tr("No account has waiting plays yet.")); return end
  local items = load_queue(queue_key(username))
  if not items then plugin.show_toast(tr("Waiting plays could not be read. Nothing removed.")); return end
  local labels, actions = {}, {}
  local function add(label, action)
    labels[#labels + 1], actions[#actions + 1] = label, action
  end
  if #items == 0 then
    add(tr("No plays are waiting to send"), function() plugin.show_toast(tr("Qualified plays send automatically.")) end)
  else
    add(string.format(tr("%d plays kept for %s"), #items, truncate(username, 20)), function() plugin.show_toast(tr("Oldest plays are sent first.")) end)
    if same_account(state.username, username) and not session_expired and state.session_key and state.enabled and not credentials_rejected then
      add(tr("Send waiting plays now"), retry_now)
    end
    for i, item in ipairs(items) do
      local title, artist, timestamp = item.title, item.artist, item.timestamp
      add(string.format("%d. %s - %s", i, truncate(artist, 20), truncate(title, 20)), function()
        local ok, time_text = pcall(os.date, "!%Y-%m-%d %H:%M UTC", timestamp)
        plugin.show_toast(ok and time_text and string.format(tr("Saved: %s"), time_text) or tr("Saved time unavailable"))
      end)
    end
    add(tr("Discard waiting plays…"), confirm_discard_queue)
  end
  plugin.show_list(tr("Waiting plays"), labels, function(idx)
    if not same_account(username, state.username or last_username) then plugin.show_toast(tr("Account changed. Open waiting plays again.")); return end
    if actions[idx] then actions[idx]() end
  end)
end

local function open_how_it_works()
  local text = tr("How Last.fm Scrobbling Works:\n\n"
    .. "1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n"
    .. "2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n"
    .. "3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n"
    .. "4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n"
    .. "5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n"
    .. "6. Account Separation: Offline queues are stored separately per Last.fm username.")

  if uses_gateway() then
    text = text .. "\n\n" .. tr("7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored.")
  end

  if plugin.has_capability and plugin.has_capability("ui.text_view") and plugin.show_text_view then
    local shown = plugin.show_text_view(tr("How Scrobbling Works"), text)
    if shown ~= false then return end
  end

  if plugin.show_list then
    local lines = {
      tr("Tracks >= 30s only"),
      tr("Listened 50% or 4 min"),
      tr("Pauses do not count"),
      tr("Up to 100 offline plays"),
      tr("13-day age limit"),
      tr("Separate queue per user"),
    }
    if uses_gateway() then
      lines[#lines + 1] = tr("Credentials forwarded; password never stored")
    end
    plugin.show_list(tr("How Scrobbling Works"), lines, function() end)
  else
    if uses_gateway() then
      plugin.show_toast(tr("Compás sign-in service forwards credentials to Last.fm; password never stored."))
    else
      plugin.show_toast(tr("Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline."))
    end
  end
end

local function open_settings_screen()
  local rows = {}
  if not uses_gateway() then
    rows[#rows + 1] = {
      type = "row",
      label = API_KEY ~= "" and tr("API Key: Configured") or tr("API Key: Not configured"),
      on_select = function()
        prompt_api_key(function()
          if plugin.has_capability and plugin.has_capability("ui.list_update") then
            open_settings_screen()
          end
        end)
      end
    }
    rows[#rows + 1] = {
      type = "row",
      label = API_SECRET ~= "" and tr("API Secret: Configured") or tr("API Secret: Not configured"),
      on_select = function()
        prompt_api_secret(function()
          if plugin.has_capability and plugin.has_capability("ui.list_update") then
            open_settings_screen()
          end
        end)
      end
    }
  end

  if state.session_key then
    if session_expired then
      rows[#rows + 1] = { type = "row", label = tr("Sign In to Last.fm"), on_select = start_login }
    end
    rows[#rows + 1] = {
      type = "row",
      label = string.format(tr("Sign Out (%s)"), truncate(state.username or "", 18)),
      on_select = function()
        confirm_sign_out()
      end
    }
  else
    rows[#rows + 1] = {
      type = "row",
      label = tr("Sign In to Last.fm"),
      on_select = function()
        start_login()
      end
    }
  end

  local count = get_queued_count(state.username)
  if count and count > 0 then
    rows[#rows + 1] = {
      type = "row",
      label = string.format(tr("Discard waiting plays (%d)"), count),
      on_select = function()
        confirm_discard_queue()
      end
    }
  end

  rows[#rows + 1] = {
    type = "row",
    label = tr("How Scrobbling Works"),
    on_select = function()
      open_how_it_works()
    end
  }

  plugin.show_settings_list(tr("LastFM Scrobbler V2 Settings"), rows, { update = true })
end

local function is_main_showing()
  if not current_main_handle then return false end
  if plugin.has_capability and plugin.has_capability("ui.list_showing") and plugin.is_list_showing then
    return plugin.is_list_showing(current_main_handle)
  end
  return false
end

local function build_main_menu()
  local items = {}
  local actions = {}

  local function add_row(label, action)
    items[#items + 1] = label
    actions[#actions + 1] = action
  end

  -- 1. Busy Status + Cancel (<= 3 rows)
  if login_in_flight then
    add_row(tr("Status: Signing in…"), function()
      plugin.show_toast(tr("Sign-in is currently in progress."))
    end)
    add_row(tr("Cancel sign-in"), function()
      cancel_login()
    end)
    add_row(tr("Account & settings"), function()
      open_settings_screen()
    end)
    return items, actions
  end

  -- 2. First use / Missing credentials (<= 3 rows)
  if not uses_gateway() and (API_KEY == "" or API_SECRET == "") then
    if API_KEY == "" and API_SECRET == "" then
      add_row(tr("Set up Last.fm"), function()
        start_guided_setup()
      end)
      add_row(tr("How Scrobbling Works"), function()
        open_how_it_works()
      end)
    else
      add_row(tr("Continue setup"), function()
        start_guided_setup()
      end)
      add_row(tr("Account & settings"), function()
        open_settings_screen()
      end)
      add_row(tr("How Scrobbling Works"), function()
        open_how_it_works()
      end)
    end
    return items, actions
  end

  -- 3. Configured signed out (<= 3 rows)
  if session_expired or not state.session_key then
    if credentials_rejected then
      add_row(tr("Status: API key/secret rejected"), function()
        plugin.show_toast(tr("API key or secret rejected by Last.fm. Check settings."))
      end)
    elseif persistent_error and persistent_error ~= "" then
      add_row(string.format(tr("Status: %s"), truncate(tr(persistent_error), 40)), function()
        start_login()
      end)
    else
      add_row(tr("Sign In to Last.fm"), function()
        start_login()
      end)
    end
    add_row(tr("Account & settings"), function()
      open_settings_screen()
    end)
    add_row(tr("How Scrobbling Works"), function()
      open_how_it_works()
    end)
    return items, actions
  end

  -- 4. Connected daily (5 rows; a 6th, "Sync now", only while plays wait)
  local count = get_queued_count(state.username)
  local offline_waiting = state.enabled and count and count > 0 and (wifi_disabled() or link_down())
  local status_label, status_toast
  if credentials_rejected then
    status_label = tr("Status: API key/secret rejected")
    status_toast = tr("API key or secret rejected by Last.fm.")
  elseif persistent_error and persistent_error ~= "" and persistent_error ~= NETWORK_ERROR then
    status_label = string.format(tr("Status: %s"), truncate(tr(persistent_error), 45))
    status_toast = tr(persistent_error)
  elseif offline_waiting then
    status_label = offline_text()
    status_toast = offline_text()
  elseif persistent_error and persistent_error ~= "" then
    status_label = string.format(tr("Status: %s"), truncate(tr(persistent_error), 45))
    status_toast = tr(persistent_error)
  else
    status_label = string.format(tr("Signed in as %s"), truncate(state.username or "", 20))
    status_toast = string.format(tr("Signed in as %s"), state.username or tr("unknown"))
  end
  add_row(status_label, function() plugin.show_toast(status_toast) end)

  local track_label
  if not current_title or current_title == "" then
    track_label = tr("This track: No music playing")
  elseif not state.enabled then
    track_label = tr("This track: Scrobbling off")
  elseif current_duration <= 0 then
    track_label = tr("This track: Reading length")
  elseif current_duration < 30 then
    track_label = tr("This track: Too short (<30s)")
  elseif not same_account(current_account, state.username) then
    track_label = tr("This track: Starts counting next song")
  elseif current_delivery then
    track_label = string.format(tr("This track: %s"), tr(current_delivery))
  elseif scrobbled_this_track then
    track_label = tr("This track: This listen not counted")
  elseif not plugin.is_playing() then
    track_label = tr("This track: Playback paused")
  else
    local thresh = math.min(current_duration / 2, 240)
    track_label = string.format(tr("This track: Counts after %s"), format_time(thresh))
  end
  add_row(track_label, function()
    if current_title and current_title ~= "" then
      local thresh = math.min(current_duration / 2, 240)
      plugin.show_toast(string.format("%s - %s (%s / %s)",
        truncate(current_artist or "", 25), truncate(current_title or "", 25),
        format_time(listened_now()), format_time(thresh)))
    else
      plugin.show_toast(tr("No track playing."))
    end
  end)

  -- The main screen is a live-updating show_list (handle + replace), which
  -- has no switch row; on wrapped lists the state is the row's native muted
  -- secondary line, as in the player's own Settings rows.
  local scrobbling_state = state.enabled and tr("On") or tr("Off")
  local wrapped = plugin.has_capability and plugin.has_capability("ui.list_wrap")
  add_row(wrapped and (tr("Scrobbling") .. "\n" .. scrobbling_state) or string.format(tr("Scrobbling: %s"), scrobbling_state), function()
    local desired = not state.enabled
    if set_scrobbling(desired) then
      plugin.show_toast(desired and tr("Scrobbling turned on.") or tr("Scrobbling turned off."))
      refresh_main_list()
    end
  end)

  local queue_label
  if count == nil then
    queue_label = tr("Waiting plays could not be read")
  else
    queue_label = count == 1 and string.format(tr("%d play waiting"), count) or string.format(tr("%d plays waiting"), count)
    local remaining = next_sync_at - os.time()
    if count > 0 then
      if queue_sync_token then
        queue_label = queue_label .. " \u{b7} " .. tr("Sending…")
      elseif state.enabled and wifi_disabled() then
        queue_label = queue_label .. " \u{b7} " .. tr("waiting for Wi-Fi")
      elseif remaining > 0 and not credentials_rejected then
        queue_label = queue_label .. " \u{b7} " .. string.format(tr("next try %dm"), math.max(1, math.ceil(remaining / 60)))
      end
    end
    local last_sent = format_last_sent(plugin.storage.get("last_sent_at", ""))
    if last_sent then queue_label = queue_label .. " \u{b7} " .. string.format(tr("sent %s"), last_sent) end
  end
  add_row(queue_label, open_queue_list)

  if count and count > 0 and state.enabled and state.session_key and not session_expired
      and not credentials_rejected then
    add_row(tr("Sync now"), retry_now)
  end

  add_row(tr("Account & settings"), function()
    open_settings_screen()
  end)

  return items, actions
end

local current_main_actions = nil
local last_menu_fingerprint = nil

local function render_main_items(items)
  if not (plugin.has_capability and plugin.has_capability("ui.list_wrap")) then return items end
  local rows = {}
  for i, label in ipairs(items) do
    rows[i] = { label = label, wrap = true }
  end
  return rows
end

local function on_main_select(index)
  if current_main_actions and current_main_actions[index] then
    current_main_actions[index]()
  end
end

refresh_main_list = function()
  main_refresh_pending = true
  if not current_main_handle then return end
  if plugin.has_capability and plugin.has_capability("ui.list_update") and is_main_showing() then
    local items, actions = build_main_menu()
    local fingerprint = table.concat(items, "\31")
    if fingerprint == last_menu_fingerprint then
      main_refresh_pending = false
      current_main_actions = actions
      return
    end
    local new_handle = plugin.show_list(tr("LastFM Scrobbler V2"), render_main_items(items), on_main_select, { replace = current_main_handle })
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
  current_main_handle = plugin.show_list(tr("LastFM Scrobbler V2"), render_main_items(items), on_main_select)
  main_refresh_pending = false
end

plugin.register_list_item("playback", tr("LastFM Scrobbler V2"), open_main_list)

if not credentials_rejected and state.enabled and state.session_key then
  sync_queue()
end
