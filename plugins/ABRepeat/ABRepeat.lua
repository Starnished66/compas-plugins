plugin.define({
    id = "example.ab_repeat",
    name = "A-B Repeat",
    version = "1.2.0",
    api_min = 19,
})

local T = {
    de = {
        ["A-B Repeat"] = "A-B-Wiederholung",
        ["Warning: timer slots full; loop active in audio engine"] = "Warnung: Timer-Plätze voll; Schleife im Audio-Engine aktiv",
        ["Player lacks playback.ab_loop capability"] = "Player unterstützt playback.ab_loop nicht",
        ["Playback is paused or stopped (must be playing)"] = "Wiedergabe pausiert oder gestoppt (muss laufen)",
        ["Playback format query not supported"] = "Abfrage des Wiedergabeformats nicht unterstützt",
        ["No active audio format loaded"] = "Kein aktives Audioformat geladen",
        ["Streaming audio cannot be looped"] = "Streaming-Audio kann nicht wiederholt werden",
        ["DSD tracks cannot be looped"] = "DSD-Titel können nicht wiederholt werden",
        ["unknown"] = "unbekannt",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Nicht unterstützter Codec (%s): FLAC oder PCM (WAV/AIFF/CAF) erforderlich",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Nicht unterstützte Bittiefe (%d-Bit): maximal 16-Bit unterstützt",
        ["Playback speed must be 1.0x (currently %s)"] = "Geschwindigkeit muss 1.0x sein (aktuell %s)",
        ["Crossfade must be disabled in Sound settings"] = "Überblenden muss in den Toneinstellungen deaktiviert sein",
        ["Track duration must be positive and finite"] = "Titeldauer muss positiv und endlich sein",
        ["Track path mismatch with active playback"] = "Titelpfad stimmt nicht mit aktiver Wiedergabe überein",
        ["Track playback generation mismatch (reloaded or changed)"] = "Titel wurde neu geladen oder gewechselt",
        ["Cannot loop: %s"] = "Schleife nicht möglich: %s",
        ["Loop points belong to a different track"] = "Schleifenpunkte gehören zu einem anderen Titel",
        ["Both Point A and Point B must be marked"] = "Sowohl Punkt A als auch Punkt B müssen gesetzt sein",
        ["Point B must be greater than Point A"] = "Punkt B muss nach Punkt A liegen",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "Punkt B (%.2fs) überschreitet Titeldauer (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "A-B-Schleife aktiv: %s -> %s",
        ["Loop rejected by audio engine"] = "Schleife vom Audio-Engine abgelehnt",
        ["A-B loop disengaged (points preserved)"] = "A-B-Schleife beendet (Punkte behalten)",
        ["A-B loop points cleared"] = "A-B-Schleifenpunkte gelöscht",
        ["Cannot mark point: playback is idle or paused"] = "Punkt nicht setzbar: Wiedergabe pausiert oder gestoppt",
        ["Cannot mark point: no active track loaded"] = "Punkt nicht setzbar: kein aktiver Titel geladen",
        ["Track duration unknown; cannot set loop point"] = "Titeldauer unbekannt; Punkt kann nicht gesetzt werden",
        ["Invalid playback position"] = "Ungültige Wiedergabeposition",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "Position (%.2fs) überschreitet Dauer (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "Punkt A auf %s gesetzt (Punkt B zurückgesetzt)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Punkt A auf %s gesetzt (Punkt B zurückgesetzt; nicht dauerhaft gespeichert)",
        ["Point A set to %s"] = "Punkt A auf %s gesetzt",
        ["Point A set to %s (not remembered across restarts)"] = "Punkt A auf %s gesetzt (nicht dauerhaft gespeichert)",
        ["Point B (%s) must be after Point A (%s)"] = "Punkt B (%s) muss nach Punkt A (%s) liegen",
        ["Point B set to %s"] = "Punkt B auf %s gesetzt",
        ["Point B set to %s (not remembered across restarts)"] = "Punkt B auf %s gesetzt (nicht dauerhaft gespeichert)",
        ["Cannot set point: playback is idle or paused"] = "Punkt nicht setzbar: Wiedergabe pausiert oder gestoppt",
        ["No active track loaded"] = "Kein aktiver Titel geladen",
        ["Point A (seconds)"] = "Punkt A (Sekunden)",
        ["Rejected: playback became paused or idle"] = "Abgelehnt: Wiedergabe wurde pausiert oder gestoppt",
        ["Rejected: track changed while entering point"] = "Abgelehnt: Titel während der Eingabe gewechselt",
        ["Rejected: track reloaded while entering point"] = "Abgelehnt: Titel während der Eingabe neu geladen",
        ["Invalid Point A: enter non-negative finite seconds"] = "Ungültiger Punkt A: nicht-negative Sekunden eingeben",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "Punkt A (%.2fs) überschreitet Titeldauer (%.2fs)",
        ["Point B (seconds)"] = "Punkt B (Sekunden)",
        ["Invalid Point B: enter positive finite seconds"] = "Ungültiger Punkt B: positive Sekunden eingeben",
        ["About A-B Repeat"] = "Über A-B-Wiederholung",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "A-B-Wiederholung bietet samplegenaue Übungsschleifen.",
        ["Looping executes natively in the audio engine frame processor."] = "Die Schleife läuft nativ im Frame-Prozessor der Audio-Engine.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Unterstützt lokale FLAC-, WAV-, AIFF- und CAF-Dateien bis 16-Bit.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "Geschwindigkeit muss 1.0x sein und Überblenden deaktiviert.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Punkte sind an den jeweiligen Titel und seine Dauer gebunden.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Pause, Spulen oder Titelwechsel beenden die Schleife; Punkte bleiben erhalten.",
        ["No continuous seeking is performed from Lua timers."] = "Es erfolgt kein kontinuierliches Spulen über Lua-Timer.",
        ["Status: Active (%s - %s)"] = "Status: Aktiv (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Status: Bereit (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Status: Unvollständig (A: %s, B: --)",
        ["Status: Not configured"] = "Status: Nicht konfiguriert",
        ["Disengage Loop"] = "Schleife beenden",
        ["Engage Loop"] = "Schleife starten",
        ["Mark Point A (Current Time)"] = "Punkt A setzen (aktuelle Zeit)",
        ["Mark Point B (Current Time)"] = "Punkt B setzen (aktuelle Zeit)",
        ["Edit Point A (Numeric)..."] = "Punkt A eingeben (numerisch)...",
        ["Edit Point B (Numeric)..."] = "Punkt B eingeben (numerisch)...",
        ["Clear Loop Points"] = "Schleifenpunkte löschen",
    },
    es = {
        ["A-B Repeat"] = "Repetición A-B",
        ["Warning: timer slots full; loop active in audio engine"] = "Aviso: temporizadores llenos; bucle activo en el motor de audio",
        ["Player lacks playback.ab_loop capability"] = "El reproductor no soporta playback.ab_loop",
        ["Playback is paused or stopped (must be playing)"] = "La reproducción está en pausa o detenida (debe estar sonando)",
        ["Playback format query not supported"] = "Consulta de formato de reproducción no soportada",
        ["No active audio format loaded"] = "No hay formato de audio activo cargado",
        ["Streaming audio cannot be looped"] = "El audio en streaming no admite bucle",
        ["DSD tracks cannot be looped"] = "Las pistas DSD no admiten bucle",
        ["unknown"] = "desconocido",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Códec no soportado (%s): el bucle requiere FLAC o PCM (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Profundidad de bits no soportada (%d bits): límite de 16 bits o menos",
        ["Playback speed must be 1.0x (currently %s)"] = "La velocidad debe ser 1.0x (actualmente %s)",
        ["Crossfade must be disabled in Sound settings"] = "El fundido debe estar desactivado en Ajustes de sonido",
        ["Track duration must be positive and finite"] = "La duración de la pista debe ser positiva y finita",
        ["Track path mismatch with active playback"] = "La ruta de la pista no coincide con la reproducción activa",
        ["Track playback generation mismatch (reloaded or changed)"] = "La pista se recargó o cambió",
        ["Cannot loop: %s"] = "No se puede repetir: %s",
        ["Loop points belong to a different track"] = "Los puntos del bucle pertenecen a otra pista",
        ["Both Point A and Point B must be marked"] = "Debes marcar tanto el Punto A como el Punto B",
        ["Point B must be greater than Point A"] = "El Punto B debe ser mayor que el Punto A",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "El Punto B (%.2fs) supera la duración de la pista (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "Bucle A-B activado: %s -> %s",
        ["Loop rejected by audio engine"] = "Bucle rechazado por el motor de audio",
        ["A-B loop disengaged (points preserved)"] = "Bucle A-B desactivado (puntos conservados)",
        ["A-B loop points cleared"] = "Puntos del bucle A-B borrados",
        ["Cannot mark point: playback is idle or paused"] = "No se puede marcar el punto: reproducción detenida o en pausa",
        ["Cannot mark point: no active track loaded"] = "No se puede marcar el punto: no hay pista activa",
        ["Track duration unknown; cannot set loop point"] = "Duración desconocida; no se puede fijar el punto",
        ["Invalid playback position"] = "Posición de reproducción no válida",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "La posición (%.2fs) supera la duración (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "Punto A fijado en %s (Punto B reiniciado)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Punto A fijado en %s (Punto B reiniciado; no se guardará al reiniciar)",
        ["Point A set to %s"] = "Punto A fijado en %s",
        ["Point A set to %s (not remembered across restarts)"] = "Punto A fijado en %s (no se guardará al reiniciar)",
        ["Point B (%s) must be after Point A (%s)"] = "El Punto B (%s) debe ser posterior al Punto A (%s)",
        ["Point B set to %s"] = "Punto B fijado en %s",
        ["Point B set to %s (not remembered across restarts)"] = "Punto B fijado en %s (no se guardará al reiniciar)",
        ["Cannot set point: playback is idle or paused"] = "No se puede fijar el punto: reproducción detenida o en pausa",
        ["No active track loaded"] = "No hay pista activa cargada",
        ["Point A (seconds)"] = "Punto A (segundos)",
        ["Rejected: playback became paused or idle"] = "Rechazado: la reproducción se pausó o detuvo",
        ["Rejected: track changed while entering point"] = "Rechazado: la pista cambió al introducir el punto",
        ["Rejected: track reloaded while entering point"] = "Rechazado: la pista se recargó al introducir el punto",
        ["Invalid Point A: enter non-negative finite seconds"] = "Punto A no válido: introduce segundos finitos no negativos",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "El Punto A (%.2fs) supera la duración de la pista (%.2fs)",
        ["Point B (seconds)"] = "Punto B (segundos)",
        ["Invalid Point B: enter positive finite seconds"] = "Punto B no válido: introduce segundos finitos positivos",
        ["About A-B Repeat"] = "Acerca de Repetición A-B",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "Repetición A-B ofrece bucles de práctica con precisión de muestra.",
        ["Looping executes natively in the audio engine frame processor."] = "El bucle se ejecuta de forma nativa en el motor de audio.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Admite audio local FLAC, WAV, AIFF y CAF de hasta 16 bits.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "La velocidad debe ser 1.0x y el fundido estar desactivado.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Los puntos se vinculan a cada pista y se limitan a su duración.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "El bucle se desactiva al pausar, buscar o cambiar de pista, pero tus puntos se conservan.",
        ["No continuous seeking is performed from Lua timers."] = "No se realizan búsquedas continuas mediante temporizadores Lua.",
        ["Status: Active (%s - %s)"] = "Estado: Activo (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Estado: Listo (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Estado: Incompleto (A: %s, B: --)",
        ["Status: Not configured"] = "Estado: Sin configurar",
        ["Disengage Loop"] = "Desactivar bucle",
        ["Engage Loop"] = "Activar bucle",
        ["Mark Point A (Current Time)"] = "Marcar Punto A (tiempo actual)",
        ["Mark Point B (Current Time)"] = "Marcar Punto B (tiempo actual)",
        ["Edit Point A (Numeric)..."] = "Editar Punto A (numérico)...",
        ["Edit Point B (Numeric)..."] = "Editar Punto B (numérico)...",
        ["Clear Loop Points"] = "Borrar puntos de bucle",
    },
    fi = {
        ["A-B Repeat"] = "A-B-toisto",
        ["Warning: timer slots full; loop active in audio engine"] = "Varoitus: ajastinpaikat täynnä; silmukka aktiivinen äänimoottorissa",
        ["Player lacks playback.ab_loop capability"] = "Soitin ei tue playback.ab_loop-toimintoa",
        ["Playback is paused or stopped (must be playing)"] = "Toisto on tauolla tai pysäytetty (oltava käynnissä)",
        ["Playback format query not supported"] = "Toistomuodon kyselyä ei tueta",
        ["No active audio format loaded"] = "Aktiivista äänimuotoa ei ole ladattu",
        ["Streaming audio cannot be looped"] = "Suoratoistoääntä ei voi silmukoida",
        ["DSD tracks cannot be looped"] = "DSD-kappaleita ei voi silmukoida",
        ["unknown"] = "tuntematon",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Koodekkia (%s) ei tueta: vaatii FLAC- tai PCM-muodon (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Bittisyvyyttä (%d-bit) ei tueta: enintään 16-bit sallittu",
        ["Playback speed must be 1.0x (currently %s)"] = "Toistonopeuden on oltava 1.0x (nyt %s)",
        ["Crossfade must be disabled in Sound settings"] = "Ristiinhäivytys on poistettava käytöstä ääniasetuksissa",
        ["Track duration must be positive and finite"] = "Kappaleen keston on oltava positiivinen ja äärellinen",
        ["Track path mismatch with active playback"] = "Kappaleen polku ei täsmää aktiiviseen toistoon",
        ["Track playback generation mismatch (reloaded or changed)"] = "Kappale ladattiin uudelleen tai vaihtui",
        ["Cannot loop: %s"] = "Silmukka ei onnistu: %s",
        ["Loop points belong to a different track"] = "Silmukkapisteet kuuluvat eri kappaleelle",
        ["Both Point A and Point B must be marked"] = "Sekä piste A että piste B on merkittävä",
        ["Point B must be greater than Point A"] = "Pisteen B on oltava pisteen A jälkeen",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "Piste B (%.2fs) ylittää kappaleen keston (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "A-B-silmukka käytössä: %s -> %s",
        ["Loop rejected by audio engine"] = "Äänimoottori hylkäsi silmukan",
        ["A-B loop disengaged (points preserved)"] = "A-B-silmukka poistettu käytöstä (pisteet säilytetty)",
        ["A-B loop points cleared"] = "A-B-silmukkapisteet tyhjennetty",
        ["Cannot mark point: playback is idle or paused"] = "Pistettä ei voi merkitä: toisto on pysäytetty tai tauolla",
        ["Cannot mark point: no active track loaded"] = "Pistettä ei voi merkitä: ei aktiivista kappaletta",
        ["Track duration unknown; cannot set loop point"] = "Kappaleen kesto tuntematon; pistettä ei voi asettaa",
        ["Invalid playback position"] = "Virheellinen toistosijainti",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "Sijainti (%.2fs) ylittää keston (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "Piste A asetettu kohtaan %s (piste B nollattu)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Piste A asetettu kohtaan %s (piste B nollattu; ei säily uudelleenkäynnistyksessä)",
        ["Point A set to %s"] = "Piste A asetettu kohtaan %s",
        ["Point A set to %s (not remembered across restarts)"] = "Piste A asetettu kohtaan %s (ei säily uudelleenkäynnistyksessä)",
        ["Point B (%s) must be after Point A (%s)"] = "Pisteen B (%s) on oltava pisteen A (%s) jälkeen",
        ["Point B set to %s"] = "Piste B asetettu kohtaan %s",
        ["Point B set to %s (not remembered across restarts)"] = "Piste B asetettu kohtaan %s (ei säily uudelleenkäynnistyksessä)",
        ["Cannot set point: playback is idle or paused"] = "Pistettä ei voi asettaa: toisto on pysäytetty tai tauolla",
        ["No active track loaded"] = "Ei aktiivista kappaletta ladattuna",
        ["Point A (seconds)"] = "Piste A (sekuntia)",
        ["Rejected: playback became paused or idle"] = "Hylätty: toisto meni tauolle tai pysähtyi",
        ["Rejected: track changed while entering point"] = "Hylätty: kappale vaihtui syötön aikana",
        ["Rejected: track reloaded while entering point"] = "Hylätty: kappale ladattiin uudelleen syötön aikana",
        ["Invalid Point A: enter non-negative finite seconds"] = "Virheellinen piste A: anna ei-negatiivinen sekuntiluku",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "Piste A (%.2fs) ylittää kappaleen keston (%.2fs)",
        ["Point B (seconds)"] = "Piste B (sekuntia)",
        ["Invalid Point B: enter positive finite seconds"] = "Virheellinen piste B: anna positiivinen sekuntiluku",
        ["About A-B Repeat"] = "Tietoja A-B-toistosta",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "A-B-toisto tarjoaa näytetarkan harjoittelusilmukan.",
        ["Looping executes natively in the audio engine frame processor."] = "Silmukka suoritetaan natiivisti äänimoottorissa.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Tukee paikallisia FLAC-, WAV-, AIFF- ja CAF-tiedostoja 16 bittiin asti.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "Toistonopeuden on oltava 1.0x ja ristiinhäivytyksen poissa käytöstä.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Silmukkapisteet on sidottu kappaleeseen ja sen kestoon.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Tauko, kelaus tai kappaleen vaihto lopettaa silmukan, mutta pisteet säilyvät.",
        ["No continuous seeking is performed from Lua timers."] = "Lua-ajastimilla ei tehdä jatkuvaa kelausta.",
        ["Status: Active (%s - %s)"] = "Tila: Aktiivinen (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Tila: Valmis (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Tila: Keskeneräinen (A: %s, B: --)",
        ["Status: Not configured"] = "Tila: Ei määritetty",
        ["Disengage Loop"] = "Poista silmukka käytöstä",
        ["Engage Loop"] = "Ota silmukka käyttöön",
        ["Mark Point A (Current Time)"] = "Merkitse piste A (nykyhetki)",
        ["Mark Point B (Current Time)"] = "Merkitse piste B (nykyhetki)",
        ["Edit Point A (Numeric)..."] = "Muokkaa pistettä A (numeerinen)...",
        ["Edit Point B (Numeric)..."] = "Muokkaa pistettä B (numeerinen)...",
        ["Clear Loop Points"] = "Tyhjennä silmukkapisteet",
    },
    fr = {
        ["A-B Repeat"] = "Répétition A-B",
        ["Warning: timer slots full; loop active in audio engine"] = "Attention : minuteries pleines ; boucle active dans le moteur audio",
        ["Player lacks playback.ab_loop capability"] = "Le lecteur ne prend pas en charge playback.ab_loop",
        ["Playback is paused or stopped (must be playing)"] = "Lecture en pause ou arrêtée (doit être en cours)",
        ["Playback format query not supported"] = "Requête du format de lecture non prise en charge",
        ["No active audio format loaded"] = "Aucun format audio actif chargé",
        ["Streaming audio cannot be looped"] = "L'audio en streaming ne peut pas être bouclé",
        ["DSD tracks cannot be looped"] = "Les pistes DSD ne peuvent pas être bouclées",
        ["unknown"] = "inconnu",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Codec non pris en charge (%s) : FLAC ou PCM (WAV/AIFF/CAF) requis",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Profondeur (%d bits) non prise en charge : limité à 16 bits max.",
        ["Playback speed must be 1.0x (currently %s)"] = "La vitesse doit être 1.0x (actuellement %s)",
        ["Crossfade must be disabled in Sound settings"] = "Le fondu enchaîné doit être désactivé dans les réglages du son",
        ["Track duration must be positive and finite"] = "La durée du titre doit être positive et finie",
        ["Track path mismatch with active playback"] = "Le chemin du titre ne correspond pas à la lecture active",
        ["Track playback generation mismatch (reloaded or changed)"] = "Le titre a été rechargé ou modifié",
        ["Cannot loop: %s"] = "Boucle impossible : %s",
        ["Loop points belong to a different track"] = "Les points de boucle appartiennent à un autre titre",
        ["Both Point A and Point B must be marked"] = "Les points A et B doivent tous deux être marqués",
        ["Point B must be greater than Point A"] = "Le point B doit être supérieur au point A",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "Le point B (%.2fs) dépasse la durée du titre (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "Boucle A-B activée : %s -> %s",
        ["Loop rejected by audio engine"] = "Boucle refusée par le moteur audio",
        ["A-B loop disengaged (points preserved)"] = "Boucle A-B désactivée (points conservés)",
        ["A-B loop points cleared"] = "Points de boucle A-B effacés",
        ["Cannot mark point: playback is idle or paused"] = "Impossible de marquer le point : lecture en pause ou arrêtée",
        ["Cannot mark point: no active track loaded"] = "Impossible de marquer le point : aucun titre actif",
        ["Track duration unknown; cannot set loop point"] = "Durée inconnue ; impossible de définir le point",
        ["Invalid playback position"] = "Position de lecture invalide",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "La position (%.2fs) dépasse la durée (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "Point A défini à %s (point B réinitialisé)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Point A défini à %s (point B réinitialisé ; non mémorisé au redémarrage)",
        ["Point A set to %s"] = "Point A défini à %s",
        ["Point A set to %s (not remembered across restarts)"] = "Point A défini à %s (non mémorisé au redémarrage)",
        ["Point B (%s) must be after Point A (%s)"] = "Le point B (%s) doit être après le point A (%s)",
        ["Point B set to %s"] = "Point B défini à %s",
        ["Point B set to %s (not remembered across restarts)"] = "Point B défini à %s (non mémorisé au redémarrage)",
        ["Cannot set point: playback is idle or paused"] = "Impossible de définir le point : lecture en pause ou arrêtée",
        ["No active track loaded"] = "Aucun titre actif chargé",
        ["Point A (seconds)"] = "Point A (secondes)",
        ["Rejected: playback became paused or idle"] = "Refusé : la lecture a été mise en pause ou arrêtée",
        ["Rejected: track changed while entering point"] = "Refusé : le titre a changé pendant la saisie",
        ["Rejected: track reloaded while entering point"] = "Refusé : le titre a été rechargé pendant la saisie",
        ["Invalid Point A: enter non-negative finite seconds"] = "Point A invalide : entrez un nombre de secondes non négatif",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "Le point A (%.2fs) dépasse la durée du titre (%.2fs)",
        ["Point B (seconds)"] = "Point B (secondes)",
        ["Invalid Point B: enter positive finite seconds"] = "Point B invalide : entrez un nombre de secondes positif",
        ["About A-B Repeat"] = "À propos de Répétition A-B",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "Répétition A-B offre un bouclage précis à l'échantillon près.",
        ["Looping executes natively in the audio engine frame processor."] = "La boucle s'exécute nativement dans le moteur audio.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Prend en charge les fichiers locaux FLAC, WAV, AIFF et CAF jusqu'à 16 bits.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "La vitesse doit être 1.0x et le fondu enchaîné désactivé.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Les points sont liés au titre et limités par sa durée.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Pause, recherche ou changement de titre arrêtent la boucle, mais vos points sont gardés.",
        ["No continuous seeking is performed from Lua timers."] = "Aucune recherche continue n'est effectuée via des minuteries Lua.",
        ["Status: Active (%s - %s)"] = "État : Actif (%s - %s)",
        ["Status: Ready (%s - %s)"] = "État : Prêt (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "État : Incomplet (A : %s, B : --)",
        ["Status: Not configured"] = "État : Non configuré",
        ["Disengage Loop"] = "Désactiver la boucle",
        ["Engage Loop"] = "Activer la boucle",
        ["Mark Point A (Current Time)"] = "Marquer le point A (temps actuel)",
        ["Mark Point B (Current Time)"] = "Marquer le point B (temps actuel)",
        ["Edit Point A (Numeric)..."] = "Modifier le point A (numérique)...",
        ["Edit Point B (Numeric)..."] = "Modifier le point B (numérique)...",
        ["Clear Loop Points"] = "Effacer les points de boucle",
    },
    it = {
        ["A-B Repeat"] = "Ripetizione A-B",
        ["Warning: timer slots full; loop active in audio engine"] = "Avviso: slot timer pieni; loop attivo nel motore audio",
        ["Player lacks playback.ab_loop capability"] = "Il lettore non supporta playback.ab_loop",
        ["Playback is paused or stopped (must be playing)"] = "Riproduzione in pausa o ferma (deve essere in corso)",
        ["Playback format query not supported"] = "Interrogazione del formato di riproduzione non supportata",
        ["No active audio format loaded"] = "Nessun formato audio attivo caricato",
        ["Streaming audio cannot be looped"] = "L'audio in streaming non può essere messo in loop",
        ["DSD tracks cannot be looped"] = "I brani DSD non possono essere messi in loop",
        ["unknown"] = "sconosciuto",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Codec non supportato (%s): richiesto FLAC o PCM (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Profondità bit non supportata (%d-bit): limite di 16-bit o meno",
        ["Playback speed must be 1.0x (currently %s)"] = "La velocità deve essere 1.0x (attuale %s)",
        ["Crossfade must be disabled in Sound settings"] = "La dissolvenza incrociata deve essere disattivata nelle impostazioni audio",
        ["Track duration must be positive and finite"] = "La durata del brano deve essere positiva e finita",
        ["Track path mismatch with active playback"] = "Il percorso del brano non corrisponde alla riproduzione attiva",
        ["Track playback generation mismatch (reloaded or changed)"] = "Il brano è stato ricaricato o cambiato",
        ["Cannot loop: %s"] = "Loop impossibile: %s",
        ["Loop points belong to a different track"] = "I punti di loop appartengono a un altro brano",
        ["Both Point A and Point B must be marked"] = "Entrambi i punti A e B devono essere impostati",
        ["Point B must be greater than Point A"] = "Il punto B deve essere maggiore del punto A",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "Il punto B (%.2fs) supera la durata del brano (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "Loop A-B attivato: %s -> %s",
        ["Loop rejected by audio engine"] = "Loop rifiutato dal motore audio",
        ["A-B loop disengaged (points preserved)"] = "Loop A-B disattivato (punti mantenuti)",
        ["A-B loop points cleared"] = "Punti del loop A-B cancellati",
        ["Cannot mark point: playback is idle or paused"] = "Impossibile segnare il punto: riproduzione ferma o in pausa",
        ["Cannot mark point: no active track loaded"] = "Impossibile segnare il punto: nessun brano attivo",
        ["Track duration unknown; cannot set loop point"] = "Durata brano sconosciuta; impossibile impostare il punto",
        ["Invalid playback position"] = "Posizione di riproduzione non valida",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "La posizione (%.2fs) supera la durata (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "Punto A impostato a %s (Punto B azzerato)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Punto A impostato a %s (Punto B azzerato; non salvato al riavvio)",
        ["Point A set to %s"] = "Punto A impostato a %s",
        ["Point A set to %s (not remembered across restarts)"] = "Punto A impostato a %s (non salvato al riavvio)",
        ["Point B (%s) must be after Point A (%s)"] = "Il punto B (%s) deve essere dopo il punto A (%s)",
        ["Point B set to %s"] = "Punto B impostato a %s",
        ["Point B set to %s (not remembered across restarts)"] = "Punto B impostato a %s (non salvato al riavvio)",
        ["Cannot set point: playback is idle or paused"] = "Impossibile impostare il punto: riproduzione ferma o in pausa",
        ["No active track loaded"] = "Nessun brano attivo caricato",
        ["Point A (seconds)"] = "Punto A (secondi)",
        ["Rejected: playback became paused or idle"] = "Rifiutato: la riproduzione è stata messa in pausa o fermata",
        ["Rejected: track changed while entering point"] = "Rifiutato: il brano è cambiato durante l'inserimento",
        ["Rejected: track reloaded while entering point"] = "Rifiutato: il brano è stato ricaricato durante l'inserimento",
        ["Invalid Point A: enter non-negative finite seconds"] = "Punto A non valido: inserisci secondi non negativi",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "Il punto A (%.2fs) supera la durata del brano (%.2fs)",
        ["Point B (seconds)"] = "Punto B (secondi)",
        ["Invalid Point B: enter positive finite seconds"] = "Punto B non valido: inserisci secondi positivi",
        ["About A-B Repeat"] = "Informazioni su Ripetizione A-B",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "Ripetizione A-B offre un loop di pratica preciso al campione.",
        ["Looping executes natively in the audio engine frame processor."] = "Il loop viene eseguito nativamente nel motore audio.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Supporta audio locale FLAC, WAV, AIFF e CAF fino a 16-bit.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "La velocità deve essere 1.0x e la dissolvenza incrociata disattivata.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "I punti di loop sono legati al brano e limitati dalla sua durata.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Pausa, ricerca o cambio brano disattivano il loop, ma i punti restano salvati.",
        ["No continuous seeking is performed from Lua timers."] = "Non viene eseguita alcuna ricerca continua tramite timer Lua.",
        ["Status: Active (%s - %s)"] = "Stato: Attivo (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Stato: Pronto (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Stato: Incompleto (A: %s, B: --)",
        ["Status: Not configured"] = "Stato: Non configurato",
        ["Disengage Loop"] = "Disattiva loop",
        ["Engage Loop"] = "Attiva loop",
        ["Mark Point A (Current Time)"] = "Segna punto A (tempo attuale)",
        ["Mark Point B (Current Time)"] = "Segna punto B (tempo attuale)",
        ["Edit Point A (Numeric)..."] = "Modifica punto A (numerico)...",
        ["Edit Point B (Numeric)..."] = "Modifica punto B (numerico)...",
        ["Clear Loop Points"] = "Cancella punti di loop",
    },
    ja = {
        ["A-B Repeat"] = "A-B リピート",
        ["Warning: timer slots full; loop active in audio engine"] = "警告: タイマー枠の上限です。ループはエンジン内で有効です",
        ["Player lacks playback.ab_loop capability"] = "プレーヤーが playback.ab_loop に対応していません",
        ["Playback is paused or stopped (must be playing)"] = "一時停止または停止中です (再生中のみ可能)",
        ["Playback format query not supported"] = "再生フォーマットの取得に対応していません",
        ["No active audio format loaded"] = "有効なオーディオフォーマットがありません",
        ["Streaming audio cannot be looped"] = "ストリーミング音源はループできません",
        ["DSD tracks cannot be looped"] = "DSD トラックはループできません",
        ["unknown"] = "不明",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "非対応コーデック (%s): FLAC または PCM (WAV/AIFF/CAF) が必要です",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "非対応ビット深度 (%d-bit): 16-bit 以下のみ対応しています",
        ["Playback speed must be 1.0x (currently %s)"] = "再生速度は 1.0x である必要があります (現在 %s)",
        ["Crossfade must be disabled in Sound settings"] = "サウンド設定でクロスフェードを無効にしてください",
        ["Track duration must be positive and finite"] = "曲の長さは正の有限値である必要があります",
        ["Track path mismatch with active playback"] = "曲のパスが現在の再生と一致しません",
        ["Track playback generation mismatch (reloaded or changed)"] = "曲が再読み込みまたは変更されました",
        ["Cannot loop: %s"] = "ループできません: %s",
        ["Loop points belong to a different track"] = "ループ地点が別の曲のものです",
        ["Both Point A and Point B must be marked"] = "A 地点と B 地点の両方を設定してください",
        ["Point B must be greater than Point A"] = "B 地点は A 地点より後にしてください",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "B 地点 (%.2f秒) が曲の長さ (%.2f秒) を超えています",
        ["A-B Loop engaged: %s -> %s"] = "A-B ループ開始: %s -> %s",
        ["Loop rejected by audio engine"] = "オーディオエンジンがループを拒否しました",
        ["A-B loop disengaged (points preserved)"] = "A-B ループ解除 (地点は保持)",
        ["A-B loop points cleared"] = "A-B ループ地点を消去しました",
        ["Cannot mark point: playback is idle or paused"] = "地点を設定できません: 停止中または一時停止中です",
        ["Cannot mark point: no active track loaded"] = "地点を設定できません: 曲が読み込まれていません",
        ["Track duration unknown; cannot set loop point"] = "曲の長さが不明なため地点を設定できません",
        ["Invalid playback position"] = "無効な再生位置です",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "位置 (%.2f秒) が曲の長さ (%.2f秒) を超えています",
        ["Point A set to %s (Point B reset)"] = "A 地点を %s に設定 (B 地点をリセット)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "A 地点を %s に設定 (B 地点をリセット・再起動後は保持されません)",
        ["Point A set to %s"] = "A 地点を %s に設定",
        ["Point A set to %s (not remembered across restarts)"] = "A 地点を %s に設定 (再起動後は保持されません)",
        ["Point B (%s) must be after Point A (%s)"] = "B 地点 (%s) は A 地点 (%s) より後にしてください",
        ["Point B set to %s"] = "B 地点を %s に設定",
        ["Point B set to %s (not remembered across restarts)"] = "B 地点を %s に設定 (再起動後は保持されません)",
        ["Cannot set point: playback is idle or paused"] = "地点を設定できません: 停止中または一時停止中です",
        ["No active track loaded"] = "曲が読み込まれていません",
        ["Point A (seconds)"] = "A 地点 (秒)",
        ["Rejected: playback became paused or idle"] = "キャンセル: 再生が一時停止または停止しました",
        ["Rejected: track changed while entering point"] = "キャンセル: 入力中に曲が変わりました",
        ["Rejected: track reloaded while entering point"] = "キャンセル: 入力中に曲が再読み込みされました",
        ["Invalid Point A: enter non-negative finite seconds"] = "無効な A 地点: 0 以上の秒数を入力してください",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "A 地点 (%.2f秒) が曲の長さ (%.2f秒) を超えています",
        ["Point B (seconds)"] = "B 地点 (秒)",
        ["Invalid Point B: enter positive finite seconds"] = "無効な B 地点: 正の秒数を入力してください",
        ["About A-B Repeat"] = "A-B リピートについて",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "A-B リピートはサンプル精度の練習用ループ機能を提供します。",
        ["Looping executes natively in the audio engine frame processor."] = "ループはオーディオエンジン内でネイティブに処理されます。",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "16-bit 以下のローカル FLAC、WAV、AIFF、CAF に対応しています。",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "再生速度 1.0x かつクロスフェード無効が必要です。",
        ["Loop points are linked to the specific track and bounded by its duration."] = "ループ地点は曲ごとに紐付けられ、曲の長さ内に制限されます。",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "一時停止・シーク・曲変更でループは解除されますが、地点は保持されます。",
        ["No continuous seeking is performed from Lua timers."] = "Lua タイマーによる連続シークは行いません。",
        ["Status: Active (%s - %s)"] = "状態: 有効 (%s - %s)",
        ["Status: Ready (%s - %s)"] = "状態: 準備完了 (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "状態: 未完了 (A: %s, B: --)",
        ["Status: Not configured"] = "状態: 未設定",
        ["Disengage Loop"] = "ループを解除",
        ["Engage Loop"] = "ループを開始",
        ["Mark Point A (Current Time)"] = "A 地点を記録 (現在位置)",
        ["Mark Point B (Current Time)"] = "B 地点を記録 (現在位置)",
        ["Edit Point A (Numeric)..."] = "A 地点を数値で編集...",
        ["Edit Point B (Numeric)..."] = "B 地点を数値で編集...",
        ["Clear Loop Points"] = "ループ地点を消去",
    },
    nl = {
        ["A-B Repeat"] = "A-B herhalen",
        ["Warning: timer slots full; loop active in audio engine"] = "Waarschuwing: timers vol; lus actief in audio-engine",
        ["Player lacks playback.ab_loop capability"] = "Speler ondersteunt playback.ab_loop niet",
        ["Playback is paused or stopped (must be playing)"] = "Afspelen is gepauzeerd of gestopt (moet afspelen)",
        ["Playback format query not supported"] = "Opvragen afspeelformaat niet ondersteund",
        ["No active audio format loaded"] = "Geen actief audioformaat geladen",
        ["Streaming audio cannot be looped"] = "Streaming-audio kan niet worden herhaald",
        ["DSD tracks cannot be looped"] = "DSD-nummers kunnen niet worden herhaald",
        ["unknown"] = "onbekend",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Niet-ondersteunde codec (%s): vereist FLAC of PCM (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Niet-ondersteunde bitdiepte (%d-bit): maximaal 16-bit",
        ["Playback speed must be 1.0x (currently %s)"] = "Afspeelsnelheid moet 1.0x zijn (nu %s)",
        ["Crossfade must be disabled in Sound settings"] = "Crossfade moet uitgeschakeld zijn in geluidsinstellingen",
        ["Track duration must be positive and finite"] = "Nummerduur moet positief en eindig zijn",
        ["Track path mismatch with active playback"] = "Pad komt niet overeen met actief nummer",
        ["Track playback generation mismatch (reloaded or changed)"] = "Nummer is herladen of gewijzigd",
        ["Cannot loop: %s"] = "Kan niet herhalen: %s",
        ["Loop points belong to a different track"] = "Luspunten horen bij een ander nummer",
        ["Both Point A and Point B must be marked"] = "Zowel punt A als punt B moeten zijn ingesteld",
        ["Point B must be greater than Point A"] = "Punt B moet na punt A liggen",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "Punt B (%.2fs) overschrijdt nummerduur (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "A-B-lus actief: %s -> %s",
        ["Loop rejected by audio engine"] = "Lus geweigerd door audio-engine",
        ["A-B loop disengaged (points preserved)"] = "A-B-lus gestopt (punten behouden)",
        ["A-B loop points cleared"] = "A-B-luspunten gewist",
        ["Cannot mark point: playback is idle or paused"] = "Kan punt niet markeren: afspelen is gestopt of gepauzeerd",
        ["Cannot mark point: no active track loaded"] = "Kan punt niet markeren: geen actief nummer geladen",
        ["Track duration unknown; cannot set loop point"] = "Nummerduur onbekend; kan luspunt niet instellen",
        ["Invalid playback position"] = "Ongeldige afspeelpositie",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "Positie (%.2fs) overschrijdt duur (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "Punt A ingesteld op %s (punt B gereset)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Punt A ingesteld op %s (punt B gereset; niet onthouden na herstart)",
        ["Point A set to %s"] = "Punt A ingesteld op %s",
        ["Point A set to %s (not remembered across restarts)"] = "Punt A ingesteld op %s (niet onthouden na herstart)",
        ["Point B (%s) must be after Point A (%s)"] = "Punt B (%s) moet na punt A (%s) liggen",
        ["Point B set to %s"] = "Punt B ingesteld op %s",
        ["Point B set to %s (not remembered across restarts)"] = "Punt B ingesteld op %s (niet onthouden na herstart)",
        ["Cannot set point: playback is idle or paused"] = "Kan punt niet instellen: afspelen is gestopt of gepauzeerd",
        ["No active track loaded"] = "Geen actief nummer geladen",
        ["Point A (seconds)"] = "Punt A (seconden)",
        ["Rejected: playback became paused or idle"] = "Geweigerd: afspelen werd gepauzeerd of gestopt",
        ["Rejected: track changed while entering point"] = "Geweigerd: nummer gewijzigd tijdens invoer",
        ["Rejected: track reloaded while entering point"] = "Geweigerd: nummer herladen tijdens invoer",
        ["Invalid Point A: enter non-negative finite seconds"] = "Ongeldig punt A: voer niet-negatieve seconden in",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "Punt A (%.2fs) overschrijdt nummerduur (%.2fs)",
        ["Point B (seconds)"] = "Punt B (seconden)",
        ["Invalid Point B: enter positive finite seconds"] = "Ongeldig punt B: voer positieve seconden in",
        ["About A-B Repeat"] = "Over A-B herhalen",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "A-B herhalen biedt sample-nauwkeurige oefenlussen.",
        ["Looping executes natively in the audio engine frame processor."] = "De lus draait direct in de frameprocessor van de audio-engine.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Ondersteunt lokale FLAC-, WAV-, AIFF- en CAF-audio tot 16-bit.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "Afspeelsnelheid moet 1.0x zijn en crossfade uitgeschakeld.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Luspunten zijn gekoppeld aan het nummer en begrensd door de duur.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Pauze, spoelen of ander nummer stopt de lus, maar je punten blijven bewaard.",
        ["No continuous seeking is performed from Lua timers."] = "Er wordt niet continu gespoeld vanuit Lua-timers.",
        ["Status: Active (%s - %s)"] = "Status: Actief (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Status: Gereed (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Status: Onvolledig (A: %s, B: --)",
        ["Status: Not configured"] = "Status: Niet ingesteld",
        ["Disengage Loop"] = "Lus uitschakelen",
        ["Engage Loop"] = "Lus inschakelen",
        ["Mark Point A (Current Time)"] = "Punt A markeren (huidige tijd)",
        ["Mark Point B (Current Time)"] = "Punt B markeren (huidige tijd)",
        ["Edit Point A (Numeric)..."] = "Punt A bewerken (numeriek)...",
        ["Edit Point B (Numeric)..."] = "Punt B bewerken (numeriek)...",
        ["Clear Loop Points"] = "Luspunten wissen",
    },
    pt = {
        ["A-B Repeat"] = "Repetição A-B",
        ["Warning: timer slots full; loop active in audio engine"] = "Aviso: temporizadores cheios; loop ativo no motor de áudio",
        ["Player lacks playback.ab_loop capability"] = "O reprodutor não suporta playback.ab_loop",
        ["Playback is paused or stopped (must be playing)"] = "A reprodução está pausada ou parada (deve estar tocando)",
        ["Playback format query not supported"] = "Consulta de formato de reprodução não suportada",
        ["No active audio format loaded"] = "Nenhum formato de áudio ativo carregado",
        ["Streaming audio cannot be looped"] = "Áudio de streaming não pode ser repetido em loop",
        ["DSD tracks cannot be looped"] = "Faixas DSD não podem ser repetidas em loop",
        ["unknown"] = "desconhecido",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Codec não suportado (%s): requer FLAC ou PCM (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Profundidade de bits não suportada (%d-bit): limite de 16-bit ou menos",
        ["Playback speed must be 1.0x (currently %s)"] = "A velocidade deve ser 1.0x (atualmente %s)",
        ["Crossfade must be disabled in Sound settings"] = "O crossfade deve estar desativado nas configurações de som",
        ["Track duration must be positive and finite"] = "A duração da faixa deve ser positiva e finita",
        ["Track path mismatch with active playback"] = "O caminho da faixa não corresponde à reprodução ativa",
        ["Track playback generation mismatch (reloaded or changed)"] = "A faixa foi recarregada ou alterada",
        ["Cannot loop: %s"] = "Não é possível repetir: %s",
        ["Loop points belong to a different track"] = "Os pontos do loop pertencem a outra faixa",
        ["Both Point A and Point B must be marked"] = "Tanto o Ponto A quanto o Ponto B devem ser marcados",
        ["Point B must be greater than Point A"] = "O Ponto B deve ser maior que o Ponto A",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "O Ponto B (%.2fs) excede a duração da faixa (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "Loop A-B ativado: %s -> %s",
        ["Loop rejected by audio engine"] = "Loop recusado pelo motor de áudio",
        ["A-B loop disengaged (points preserved)"] = "Loop A-B desativado (pontos mantidos)",
        ["A-B loop points cleared"] = "Pontos do loop A-B limpos",
        ["Cannot mark point: playback is idle or paused"] = "Não é possível marcar o ponto: reprodução parada ou pausada",
        ["Cannot mark point: no active track loaded"] = "Não é possível marcar o ponto: nenhuma faixa ativa",
        ["Track duration unknown; cannot set loop point"] = "Duração desconhecida; não é possível definir o ponto",
        ["Invalid playback position"] = "Posição de reprodução inválida",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "A posição (%.2fs) excede a duração (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "Ponto A definido em %s (Ponto B redefinido)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Ponto A definido em %s (Ponto B redefinido; não salvo ao reiniciar)",
        ["Point A set to %s"] = "Ponto A definido em %s",
        ["Point A set to %s (not remembered across restarts)"] = "Ponto A definido em %s (não salvo ao reiniciar)",
        ["Point B (%s) must be after Point A (%s)"] = "O Ponto B (%s) deve ser após o Ponto A (%s)",
        ["Point B set to %s"] = "Ponto B definido em %s",
        ["Point B set to %s (not remembered across restarts)"] = "Ponto B definido em %s (não salvo ao reiniciar)",
        ["Cannot set point: playback is idle or paused"] = "Não é possível definir o ponto: reprodução parada ou pausada",
        ["No active track loaded"] = "Nenhuma faixa ativa carregada",
        ["Point A (seconds)"] = "Ponto A (segundos)",
        ["Rejected: playback became paused or idle"] = "Recusado: a reprodução foi pausada ou parada",
        ["Rejected: track changed while entering point"] = "Recusado: a faixa mudou durante a digitação",
        ["Rejected: track reloaded while entering point"] = "Recusado: a faixa foi recarregada durante a digitação",
        ["Invalid Point A: enter non-negative finite seconds"] = "Ponto A inválido: insira segundos não negativos",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "O Ponto A (%.2fs) excede a duração da faixa (%.2fs)",
        ["Point B (seconds)"] = "Ponto B (segundos)",
        ["Invalid Point B: enter positive finite seconds"] = "Ponto B inválido: insira segundos positivos",
        ["About A-B Repeat"] = "Sobre a Repetição A-B",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "A Repetição A-B oferece loops de prática com precisão de amostra.",
        ["Looping executes natively in the audio engine frame processor."] = "O loop é executado nativamente no motor de áudio.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Suporta áudio local FLAC, WAV, AIFF e CAF de até 16 bits.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "A velocidade deve ser 1.0x e o crossfade deve estar desativado.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Os pontos ficam vinculados à faixa e limitados pela sua duração.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Pausar, avançar ou trocar de faixa desativa o loop, mas seus pontos são mantidos.",
        ["No continuous seeking is performed from Lua timers."] = "Nenhuma busca contínua é feita por temporizadores Lua.",
        ["Status: Active (%s - %s)"] = "Status: Ativo (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Status: Pronto (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Status: Incompleto (A: %s, B: --)",
        ["Status: Not configured"] = "Status: Não configurado",
        ["Disengage Loop"] = "Desativar loop",
        ["Engage Loop"] = "Ativar loop",
        ["Mark Point A (Current Time)"] = "Marcar Ponto A (tempo atual)",
        ["Mark Point B (Current Time)"] = "Marcar Ponto B (tempo atual)",
        ["Edit Point A (Numeric)..."] = "Editar Ponto A (numérico)...",
        ["Edit Point B (Numeric)..."] = "Editar Ponto B (numérico)...",
        ["Clear Loop Points"] = "Limpar pontos de loop",
    },
    ru = {
        ["A-B Repeat"] = "Повтор A-B",
        ["Warning: timer slots full; loop active in audio engine"] = "Внимание: слоты таймеров заняты; петля активна в аудиодвижке",
        ["Player lacks playback.ab_loop capability"] = "Плеер не поддерживает playback.ab_loop",
        ["Playback is paused or stopped (must be playing)"] = "Воспроизведение на паузе или остановлено (должно играть)",
        ["Playback format query not supported"] = "Запрос формата воспроизведения не поддерживается",
        ["No active audio format loaded"] = "Нет активного аудиоформата",
        ["Streaming audio cannot be looped"] = "Потоковое аудио нельзя зациклить",
        ["DSD tracks cannot be looped"] = "Треки DSD нельзя зациклить",
        ["unknown"] = "неизвестно",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Неподдерживаемый кодек (%s): требуется FLAC или PCM (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Неподдерживаемая разрядность (%d бит): максимум 16 бит",
        ["Playback speed must be 1.0x (currently %s)"] = "Скорость должна быть 1.0x (сейчас %s)",
        ["Crossfade must be disabled in Sound settings"] = "Кроссфейд должен быть отключён в настройках звука",
        ["Track duration must be positive and finite"] = "Длительность трека должна быть положительной и конечной",
        ["Track path mismatch with active playback"] = "Путь трека не совпадает с текущим воспроизведением",
        ["Track playback generation mismatch (reloaded or changed)"] = "Трек был перезагружен или изменён",
        ["Cannot loop: %s"] = "Невозможно зациклить: %s",
        ["Loop points belong to a different track"] = "Точки петли принадлежат другому треку",
        ["Both Point A and Point B must be marked"] = "Должны быть отмечены обе точки A и B",
        ["Point B must be greater than Point A"] = "Точка B должна быть больше точки A",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "Точка B (%.2f с) превышает длительность трека (%.2f с)",
        ["A-B Loop engaged: %s -> %s"] = "Петля A-B включена: %s -> %s",
        ["Loop rejected by audio engine"] = "Петля отклонена аудиодвижком",
        ["A-B loop disengaged (points preserved)"] = "Петля A-B отключена (точки сохранены)",
        ["A-B loop points cleared"] = "Точки петли A-B очищены",
        ["Cannot mark point: playback is idle or paused"] = "Нельзя отметить точку: воспроизведение остановлено или на паузе",
        ["Cannot mark point: no active track loaded"] = "Нельзя отметить точку: нет активного трека",
        ["Track duration unknown; cannot set loop point"] = "Длительность неизвестна; нельзя задать точку",
        ["Invalid playback position"] = "Недопустимая позиция воспроизведения",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "Позиция (%.2f с) превышает длительность (%.2f с)",
        ["Point A set to %s (Point B reset)"] = "Точка A: %s (точка B сброшена)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Точка A: %s (точка B сброшена; не сохранится после перезапуска)",
        ["Point A set to %s"] = "Точка A: %s",
        ["Point A set to %s (not remembered across restarts)"] = "Точка A: %s (не сохранится после перезапуска)",
        ["Point B (%s) must be after Point A (%s)"] = "Точка B (%s) должна быть после точки A (%s)",
        ["Point B set to %s"] = "Точка B: %s",
        ["Point B set to %s (not remembered across restarts)"] = "Точка B: %s (не сохранится после перезапуска)",
        ["Cannot set point: playback is idle or paused"] = "Нельзя задать точку: воспроизведение остановлено или на паузе",
        ["No active track loaded"] = "Нет активного трека",
        ["Point A (seconds)"] = "Точка A (секунды)",
        ["Rejected: playback became paused or idle"] = "Отклонено: воспроизведение встало на паузу или остановлено",
        ["Rejected: track changed while entering point"] = "Отклонено: трек сменился во время ввода",
        ["Rejected: track reloaded while entering point"] = "Отклонено: трек перезагрузился во время ввода",
        ["Invalid Point A: enter non-negative finite seconds"] = "Неверная точка A: введите неотрицательное число секунд",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "Точка A (%.2f с) превышает длительность трека (%.2f с)",
        ["Point B (seconds)"] = "Точка B (секунды)",
        ["Invalid Point B: enter positive finite seconds"] = "Неверная точка B: введите положительное число секунд",
        ["About A-B Repeat"] = "О повторе A-B",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "Повтор A-B обеспечивает зацикливание с точностью до сэмпла.",
        ["Looping executes natively in the audio engine frame processor."] = "Петля выполняется нативно в аудиодвижке.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Поддерживаются локальные файлы FLAC, WAV, AIFF и CAF до 16 бит.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "Скорость должна быть 1.0x, а кроссфейд отключён.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Точки привязаны к конкретному треку и ограничены его длительностью.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Пауза, перемотка или смена трека снимают петлю, но точки сохраняются.",
        ["No continuous seeking is performed from Lua timers."] = "Непрерывная перемотка по таймерам Lua не используется.",
        ["Status: Active (%s - %s)"] = "Статус: Активен (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Статус: Готов (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Статус: Неполный (A: %s, B: --)",
        ["Status: Not configured"] = "Статус: Не настроен",
        ["Disengage Loop"] = "Выключить петлю",
        ["Engage Loop"] = "Включить петлю",
        ["Mark Point A (Current Time)"] = "Отметить точку A (текущее время)",
        ["Mark Point B (Current Time)"] = "Отметить точку B (текущее время)",
        ["Edit Point A (Numeric)..."] = "Изменить точку A (число)...",
        ["Edit Point B (Numeric)..."] = "Изменить точку B (число)...",
        ["Clear Loop Points"] = "Очистить точки петли",
    },
    uk = {
        ["A-B Repeat"] = "Повтор A-B",
        ["Warning: timer slots full; loop active in audio engine"] = "Увага: слоти таймерів зайняті; петля активна в аудіорушії",
        ["Player lacks playback.ab_loop capability"] = "Плеєр не підтримує playback.ab_loop",
        ["Playback is paused or stopped (must be playing)"] = "Відтворення на паузі або зупинено (має грати)",
        ["Playback format query not supported"] = "Запит формату відтворення не підтримується",
        ["No active audio format loaded"] = "Немає активного аудіоформату",
        ["Streaming audio cannot be looped"] = "Потокове аудіо не можна зациклити",
        ["DSD tracks cannot be looped"] = "Треки DSD не можна зациклити",
        ["unknown"] = "невідомо",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Непідтримуваний кодек (%s): потрібен FLAC або PCM (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Непідтримувана розрядність (%d біт): максимум 16 біт",
        ["Playback speed must be 1.0x (currently %s)"] = "Швидкість має бути 1.0x (зараз %s)",
        ["Crossfade must be disabled in Sound settings"] = "Кросфейд має бути вимкнено в налаштуваннях звуку",
        ["Track duration must be positive and finite"] = "Тривалість треку має бути додатною та скінченною",
        ["Track path mismatch with active playback"] = "Шлях треку не збігається з поточним відтворенням",
        ["Track playback generation mismatch (reloaded or changed)"] = "Трек було перезавантажено або змінено",
        ["Cannot loop: %s"] = "Неможливо зациклити: %s",
        ["Loop points belong to a different track"] = "Точки петлі належать іншому треку",
        ["Both Point A and Point B must be marked"] = "Мають бути позначені обидві точки A і B",
        ["Point B must be greater than Point A"] = "Точка B має бути більшою за точку A",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "Точка B (%.2f с) перевищує тривалість треку (%.2f с)",
        ["A-B Loop engaged: %s -> %s"] = "Петлю A-B увімкнено: %s -> %s",
        ["Loop rejected by audio engine"] = "Петлю відхилено аудіорушієм",
        ["A-B loop disengaged (points preserved)"] = "Петлю A-B вимкнено (точки збережено)",
        ["A-B loop points cleared"] = "Точки петлі A-B очищено",
        ["Cannot mark point: playback is idle or paused"] = "Не можна позначити точку: відтворення зупинено або на паузі",
        ["Cannot mark point: no active track loaded"] = "Не можна позначити точку: немає активного треку",
        ["Track duration unknown; cannot set loop point"] = "Тривалість невідома; не можна задати точку",
        ["Invalid playback position"] = "Неприпустима позиція відтворення",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "Позиція (%.2f с) перевищує тривалість (%.2f с)",
        ["Point A set to %s (Point B reset)"] = "Точка A: %s (точку B скинуто)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Точка A: %s (точку B скинуто; не збережеться після перезапуску)",
        ["Point A set to %s"] = "Точка A: %s",
        ["Point A set to %s (not remembered across restarts)"] = "Точка A: %s (не збережеться після перезапуску)",
        ["Point B (%s) must be after Point A (%s)"] = "Точка B (%s) має бути після точки A (%s)",
        ["Point B set to %s"] = "Точка B: %s",
        ["Point B set to %s (not remembered across restarts)"] = "Точка B: %s (не збережеться після перезапуску)",
        ["Cannot set point: playback is idle or paused"] = "Не можна задати точку: відтворення зупинено або на паузі",
        ["No active track loaded"] = "Немає активного треку",
        ["Point A (seconds)"] = "Точка A (секунди)",
        ["Rejected: playback became paused or idle"] = "Відхилено: відтворення стало на паузу або зупинилося",
        ["Rejected: track changed while entering point"] = "Відхилено: трек змінився під час введення",
        ["Rejected: track reloaded while entering point"] = "Відхилено: трек перезавантажився під час введення",
        ["Invalid Point A: enter non-negative finite seconds"] = "Невірна точка A: введіть невід'ємне число секунд",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "Точка A (%.2f с) перевищує тривалість треку (%.2f с)",
        ["Point B (seconds)"] = "Точка B (секунди)",
        ["Invalid Point B: enter positive finite seconds"] = "Невірна точка B: введіть додатне число секунд",
        ["About A-B Repeat"] = "Про повтор A-B",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "Повтор A-B забезпечує зациклення з точністю до семпла.",
        ["Looping executes natively in the audio engine frame processor."] = "Петля виконується нативно в аудіорушії.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Підтримуються локальні файли FLAC, WAV, AIFF і CAF до 16 біт.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "Швидкість має бути 1.0x, а кросфейд вимкнено.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Точки прив'язані до конкретного треку й обмежені його тривалістю.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Пауза, перемотування чи зміна треку вимикають петлю, але точки зберігаються.",
        ["No continuous seeking is performed from Lua timers."] = "Безперервне перемотування за таймерами Lua не використовується.",
        ["Status: Active (%s - %s)"] = "Статус: Активний (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Статус: Готовий (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Статус: Неповний (A: %s, B: --)",
        ["Status: Not configured"] = "Статус: Не налаштовано",
        ["Disengage Loop"] = "Вимкнути петлю",
        ["Engage Loop"] = "Увімкнути петлю",
        ["Mark Point A (Current Time)"] = "Позначити точку A (поточний час)",
        ["Mark Point B (Current Time)"] = "Позначити точку B (поточний час)",
        ["Edit Point A (Numeric)..."] = "Змінити точку A (число)...",
        ["Edit Point B (Numeric)..."] = "Змінити точку B (число)...",
        ["Clear Loop Points"] = "Очистити точки петлі",
    },
    vi = {
        ["A-B Repeat"] = "Lặp A-B",
        ["Warning: timer slots full; loop active in audio engine"] = "Cảnh báo: hết bộ hẹn giờ; vòng lặp vẫn chạy trong bộ âm thanh",
        ["Player lacks playback.ab_loop capability"] = "Máy phát không hỗ trợ playback.ab_loop",
        ["Playback is paused or stopped (must be playing)"] = "Đang tạm dừng hoặc dừng (phải đang phát)",
        ["Playback format query not supported"] = "Không hỗ trợ truy vấn định dạng phát",
        ["No active audio format loaded"] = "Chưa tải định dạng âm thanh nào",
        ["Streaming audio cannot be looped"] = "Không thể lặp âm thanh trực tuyến",
        ["DSD tracks cannot be looped"] = "Không thể lặp bài DSD",
        ["unknown"] = "không rõ",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "Codec không hỗ trợ (%s): cần FLAC hoặc PCM (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "Độ sâu bit không hỗ trợ (%d-bit): giới hạn tối đa 16-bit",
        ["Playback speed must be 1.0x (currently %s)"] = "Tốc độ phát phải là 1.0x (hiện tại %s)",
        ["Crossfade must be disabled in Sound settings"] = "Phải tắt chuyển mượt (Crossfade) trong cài đặt âm thanh",
        ["Track duration must be positive and finite"] = "Thời lượng bài phải dương và hữu hạn",
        ["Track path mismatch with active playback"] = "Đường dẫn bài không khớp với bài đang phát",
        ["Track playback generation mismatch (reloaded or changed)"] = "Bài hát đã được tải lại hoặc thay đổi",
        ["Cannot loop: %s"] = "Không thể lặp: %s",
        ["Loop points belong to a different track"] = "Điểm lặp thuộc về bài hát khác",
        ["Both Point A and Point B must be marked"] = "Phải đánh dấu cả Điểm A và Điểm B",
        ["Point B must be greater than Point A"] = "Điểm B phải lớn hơn Điểm A",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "Điểm B (%.2fs) vượt quá thời lượng bài (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "Đã bật lặp A-B: %s -> %s",
        ["Loop rejected by audio engine"] = "Bộ xử lý âm thanh từ chối vòng lặp",
        ["A-B loop disengaged (points preserved)"] = "Đã tắt lặp A-B (giữ nguyên các điểm)",
        ["A-B loop points cleared"] = "Đã xóa các điểm lặp A-B",
        ["Cannot mark point: playback is idle or paused"] = "Không thể đánh dấu: đang dừng hoặc tạm dừng",
        ["Cannot mark point: no active track loaded"] = "Không thể đánh dấu: chưa có bài hát đang phát",
        ["Track duration unknown; cannot set loop point"] = "Không rõ thời lượng bài; không thể đặt điểm lặp",
        ["Invalid playback position"] = "Vị trí phát không hợp lệ",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "Vị trí (%.2fs) vượt quá thời lượng (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "Đã đặt Điểm A tại %s (đặt lại Điểm B)",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "Đã đặt Điểm A tại %s (đặt lại Điểm B; không lưu sau khi khởi động lại)",
        ["Point A set to %s"] = "Đã đặt Điểm A tại %s",
        ["Point A set to %s (not remembered across restarts)"] = "Đã đặt Điểm A tại %s (không lưu sau khi khởi động lại)",
        ["Point B (%s) must be after Point A (%s)"] = "Điểm B (%s) phải sau Điểm A (%s)",
        ["Point B set to %s"] = "Đã đặt Điểm B tại %s",
        ["Point B set to %s (not remembered across restarts)"] = "Đã đặt Điểm B tại %s (không lưu sau khi khởi động lại)",
        ["Cannot set point: playback is idle or paused"] = "Không thể đặt điểm: đang dừng hoặc tạm dừng",
        ["No active track loaded"] = "Chưa tải bài hát nào",
        ["Point A (seconds)"] = "Điểm A (giây)",
        ["Rejected: playback became paused or idle"] = "Bị từ chối: nhạc đã tạm dừng hoặc dừng",
        ["Rejected: track changed while entering point"] = "Bị từ chối: bài hát đã đổi khi đang nhập",
        ["Rejected: track reloaded while entering point"] = "Bị từ chối: bài hát đã tải lại khi đang nhập",
        ["Invalid Point A: enter non-negative finite seconds"] = "Điểm A không hợp lệ: hãy nhập số giây không âm",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "Điểm A (%.2fs) vượt quá thời lượng bài (%.2fs)",
        ["Point B (seconds)"] = "Điểm B (giây)",
        ["Invalid Point B: enter positive finite seconds"] = "Điểm B không hợp lệ: hãy nhập số giây dương",
        ["About A-B Repeat"] = "Giới thiệu Lặp A-B",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "Lặp A-B cung cấp vòng lặp luyện tập chính xác đến từng mẫu.",
        ["Looping executes natively in the audio engine frame processor."] = "Vòng lặp chạy trực tiếp trong bộ xử lý khung âm thanh.",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "Hỗ trợ tệp FLAC, WAV, AIFF và CAF nội bộ lên đến 16-bit.",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "Tốc độ phát phải là 1.0x và phải tắt chuyển mượt.",
        ["Loop points are linked to the specific track and bounded by its duration."] = "Điểm lặp gắn với từng bài hát và giới hạn theo thời lượng bài.",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "Tạm dừng, tua hoặc đổi bài sẽ tắt vòng lặp nhưng vẫn giữ các điểm.",
        ["No continuous seeking is performed from Lua timers."] = "Không dùng bộ hẹn giờ Lua để tua liên tục.",
        ["Status: Active (%s - %s)"] = "Trạng thái: Đang bật (%s - %s)",
        ["Status: Ready (%s - %s)"] = "Trạng thái: Sẵn sàng (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "Trạng thái: Chưa đủ (A: %s, B: --)",
        ["Status: Not configured"] = "Trạng thái: Chưa đặt",
        ["Disengage Loop"] = "Tắt vòng lặp",
        ["Engage Loop"] = "Bật vòng lặp",
        ["Mark Point A (Current Time)"] = "Đánh dấu Điểm A (thời gian hiện tại)",
        ["Mark Point B (Current Time)"] = "Đánh dấu Điểm B (thời gian hiện tại)",
        ["Edit Point A (Numeric)..."] = "Sửa Điểm A (nhập số)...",
        ["Edit Point B (Numeric)..."] = "Sửa Điểm B (nhập số)...",
        ["Clear Loop Points"] = "Xóa các điểm lặp",
    },
    zh_CN = {
        ["A-B Repeat"] = "A-B 复读",
        ["Warning: timer slots full; loop active in audio engine"] = "警告：定时器已满；循环已在音频引擎中生效",
        ["Player lacks playback.ab_loop capability"] = "播放器不支持 playback.ab_loop",
        ["Playback is paused or stopped (must be playing)"] = "播放已暂停或停止（需处于播放状态）",
        ["Playback format query not supported"] = "不支持查询播放格式",
        ["No active audio format loaded"] = "未加载活动音频格式",
        ["Streaming audio cannot be looped"] = "流媒体音频不支持循环",
        ["DSD tracks cannot be looped"] = "DSD 曲目不支持循环",
        ["unknown"] = "未知",
        ["Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"] = "不支持的编码 (%s)：仅支持 FLAC 或 PCM (WAV/AIFF/CAF)",
        ["Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"] = "不支持的位深 (%d-bit)：仅限 16-bit 及以下",
        ["Playback speed must be 1.0x (currently %s)"] = "播放速度必须为 1.0x（当前为 %s）",
        ["Crossfade must be disabled in Sound settings"] = "需在声音设置中关闭淡入淡出",
        ["Track duration must be positive and finite"] = "曲目时长必须为正且有限",
        ["Track path mismatch with active playback"] = "曲目路径与当前播放不匹配",
        ["Track playback generation mismatch (reloaded or changed)"] = "曲目已重新加载或更换",
        ["Cannot loop: %s"] = "无法循环：%s",
        ["Loop points belong to a different track"] = "循环点属于其他曲目",
        ["Both Point A and Point B must be marked"] = "必须同时标记 A 点和 B 点",
        ["Point B must be greater than Point A"] = "B 点必须大于 A 点",
        ["Point B (%.2fs) exceeds track duration (%.2fs)"] = "B 点 (%.2fs) 超出曲目时长 (%.2fs)",
        ["A-B Loop engaged: %s -> %s"] = "A-B 循环已开启：%s -> %s",
        ["Loop rejected by audio engine"] = "音频引擎拒绝了循环请求",
        ["A-B loop disengaged (points preserved)"] = "A-B 循环已关闭（保留标记点）",
        ["A-B loop points cleared"] = "已清除 A-B 循环点",
        ["Cannot mark point: playback is idle or paused"] = "无法标记：播放已停止或暂停",
        ["Cannot mark point: no active track loaded"] = "无法标记：未加载活动曲目",
        ["Track duration unknown; cannot set loop point"] = "曲目时长未知，无法设置循环点",
        ["Invalid playback position"] = "播放位置无效",
        ["Position (%.2fs) exceeds duration (%.2fs)"] = "位置 (%.2fs) 超出时长 (%.2fs)",
        ["Point A set to %s (Point B reset)"] = "A 点设为 %s（B 点已重置）",
        ["Point A set to %s (Point B reset; not remembered across restarts)"] = "A 点设为 %s（B 点已重置；重启后不保留）",
        ["Point A set to %s"] = "A 点设为 %s",
        ["Point A set to %s (not remembered across restarts)"] = "A 点设为 %s（重启后不保留）",
        ["Point B (%s) must be after Point A (%s)"] = "B 点 (%s) 必须在 A 点 (%s) 之后",
        ["Point B set to %s"] = "B 点设为 %s",
        ["Point B set to %s (not remembered across restarts)"] = "B 点设为 %s（重启后不保留）",
        ["Cannot set point: playback is idle or paused"] = "无法设置：播放已停止或暂停",
        ["No active track loaded"] = "未加载活动曲目",
        ["Point A (seconds)"] = "A 点（秒）",
        ["Rejected: playback became paused or idle"] = "已取消：播放已暂停或停止",
        ["Rejected: track changed while entering point"] = "已取消：输入期间曲目已更换",
        ["Rejected: track reloaded while entering point"] = "已取消：输入期间曲目已重新加载",
        ["Invalid Point A: enter non-negative finite seconds"] = "A 点无效：请输入非负秒数",
        ["Point A (%.2fs) exceeds track duration (%.2fs)"] = "A 点 (%.2fs) 超出曲目时长 (%.2fs)",
        ["Point B (seconds)"] = "B 点（秒）",
        ["Invalid Point B: enter positive finite seconds"] = "B 点无效：请输入正秒数",
        ["About A-B Repeat"] = "关于 A-B 复读",
        ["A-B Repeat practice looper provides sample-accurate looping."] = "A-B 复读提供采样级精度的练习循环。",
        ["Looping executes natively in the audio engine frame processor."] = "循环在音频引擎帧处理器中原生执行。",
        ["Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."] = "支持最高 16-bit 的本地 FLAC、WAV、AIFF 和 CAF 音频。",
        ["Playback speed must be 1.0x and crossfade must be disabled."] = "播放速度须为 1.0x 且需关闭淡入淡出。",
        ["Loop points are linked to the specific track and bounded by its duration."] = "循环点与曲目绑定，并受曲目时长限制。",
        ["Engine loop clears on pause, seek, or track changes, but your points are kept."] = "暂停、跳转或切歌会退出循环，但标记点会保留。",
        ["No continuous seeking is performed from Lua timers."] = "不使用 Lua 定时器进行连续跳转。",
        ["Status: Active (%s - %s)"] = "状态：生效中 (%s - %s)",
        ["Status: Ready (%s - %s)"] = "状态：就绪 (%s - %s)",
        ["Status: Incomplete (A: %s, B: --)"] = "状态：未完成 (A: %s, B: --)",
        ["Status: Not configured"] = "状态：未配置",
        ["Disengage Loop"] = "关闭循环",
        ["Engage Loop"] = "开启循环",
        ["Mark Point A (Current Time)"] = "标记 A 点（当前时间）",
        ["Mark Point B (Current Time)"] = "标记 B 点（当前时间）",
        ["Edit Point A (Numeric)..."] = "编辑 A 点（输入数值）...",
        ["Edit Point B (Numeric)..."] = "编辑 B 点（输入数值）...",
        ["Clear Loop Points"] = "清除循环点",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

-- Practice looper utilizing native gapless A-B repeat.
-- Loop wrapping runs directly in the audio engine at decoder frame boundaries;
-- this plugin does not perform any timer-based seek approximations.
-- Supports finite local lossless audio (FLAC, WAV, AIFF, CAF) up to 16-bit PCM
-- at normal 1.0x playback speed with crossfade disabled.

local point_a = nil
local point_b = nil
local tracked_path = nil
local tracked_generation = nil
local poll_timer = nil

local function is_finite_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function get_track_storage_key(path, suffix)
    if not path or path == "" then return nil end
    local hash = plugin.md5 and plugin.md5(path)
    if type(hash) ~= "string" or hash == "" then return nil end
    return "ab_" .. suffix .. "_" .. hash
end

local function load_saved_points_for_track(path)
    point_a = nil
    point_b = nil
    tracked_path = path
    local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
    tracked_generation = cur_fmt and cur_fmt.generation or nil
    if not path or not plugin.storage then return end

    local key_a = get_track_storage_key(path, "a")
    local key_b = get_track_storage_key(path, "b")
    if key_a then
        local ok_a, val_a = pcall(function() return plugin.storage.get(key_a) end)
        if ok_a and val_a then
            local num = tonumber(val_a)
            if is_finite_number(num) and num >= 0 then point_a = num end
        end
    end
    if key_b then
        local ok_b, val_b = pcall(function() return plugin.storage.get(key_b) end)
        if ok_b and val_b then
            local num = tonumber(val_b)
            if is_finite_number(num) and num >= 0 then point_b = num end
        end
    end
end

local function persist_point_a(val)
    point_a = val
    if not tracked_path or not plugin.storage or not plugin.storage.set then
        return false
    end
    local key_a = get_track_storage_key(tracked_path, "a")
    if not key_a then return false end
    if is_finite_number(val) then
        local ok, res = pcall(function()
            return plugin.storage.set(key_a, string.format("%.3f", val))
        end)
        if not ok or not res then
            return false
        end
        return true
    else
        pcall(function()
            plugin.storage.delete(key_a)
        end)
        return true
    end
end

local function persist_point_b(val)
    point_b = val
    if not tracked_path or not plugin.storage or not plugin.storage.set then
        return false
    end
    local key_b = get_track_storage_key(tracked_path, "b")
    if not key_b then return false end
    if is_finite_number(val) then
        local ok, res = pcall(function()
            return plugin.storage.set(key_b, string.format("%.3f", val))
        end)
        if not ok or not res then
            return false
        end
        return true
    else
        pcall(function()
            plugin.storage.delete(key_b)
        end)
        return true
    end
end

local function stop_polling()
    if poll_timer then
        plugin.clear_interval(poll_timer)
        poll_timer = nil
    end
end

local function start_polling()
    if poll_timer then return end
    -- Wrap in pcall: timer slot exhaustion (8 max globally) can raise a native Lua error.
    local ok, handle = pcall(plugin.set_interval, 1, function()
        local loop = plugin.get_ab_loop and plugin.get_ab_loop()
        if not loop then
            -- Native loop was cleared by playback engine (seek, stop, eof); stop polling
            stop_polling()
        end
    end)
    if ok and handle then
        poll_timer = handle
    else
        poll_timer = nil
        plugin.show_toast(tr("Warning: timer slots full; loop active in audio engine"))
    end
end

-- Validate current playback eligibility for native A-B looping.
local function validate_playback_compatibility()
    if not plugin.has_capability or not plugin.has_capability("playback.ab_loop") then
        return false, tr("Player lacks playback.ab_loop capability")
    end
    if not plugin.is_playing or not plugin.is_playing() then
        return false, tr("Playback is paused or stopped (must be playing)")
    end
    if not plugin.get_playback_format then
        return false, tr("Playback format query not supported")
    end
    local fmt = plugin.get_playback_format()
    if not fmt then
        return false, tr("No active audio format loaded")
    end
    if fmt.is_stream then
        return false, tr("Streaming audio cannot be looped")
    end
    if fmt.is_dsd then
        return false, tr("DSD tracks cannot be looped")
    end
    -- Practice looper remains lossless only <= 16 bits.
    -- Codec must be FLAC or PCM (WAV, AIFF, CAF are handled as pcm).
    if fmt.codec ~= "flac" and fmt.codec ~= "pcm" then
        return false, string.format(tr("Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)"), fmt.codec or tr("unknown"))
    end
    if not fmt.bit_depth or fmt.bit_depth <= 0 or fmt.bit_depth > 16 then
        return false, string.format(tr("Unsupported bit depth (%d-bit): looper is limited to 16-bit or less"), fmt.bit_depth or 0)
    end
    local speed = fmt.playback_speed
    if speed == nil and plugin.get_playback_speed then
        speed = plugin.get_playback_speed()
    end
    if not is_finite_number(speed) or speed ~= 1.0 then
        return false, string.format(tr("Playback speed must be 1.0x (currently %s)"), tostring(speed or tr("unknown")))
    end
    local crossfade = fmt.crossfade_enabled
    if crossfade == nil and plugin.get_crossfade then
        crossfade = plugin.get_crossfade()
    end
    if crossfade then
        return false, tr("Crossfade must be disabled in Sound settings")
    end
    if not is_finite_number(fmt.duration_seconds) or fmt.duration_seconds <= 0 then
        return false, tr("Track duration must be positive and finite")
    end
    if tracked_path and fmt.path and tracked_path ~= fmt.path then
        return false, tr("Track path mismatch with active playback")
    end
    if tracked_generation and fmt.generation and tracked_generation ~= fmt.generation then
        return false, tr("Track playback generation mismatch (reloaded or changed)")
    end
    return true
end

local function format_time(seconds)
    if not seconds or seconds < 0 then return "--:--" end
    local mins = math.floor(seconds / 60)
    local secs = seconds - (mins * 60)
    return string.format("%d:%05.2f", mins, secs)
end

local open_menu -- forward declaration

local function activate_loop()
    local ok, reason = validate_playback_compatibility()
    if not ok then
        plugin.show_toast(string.format(tr("Cannot loop: %s"), reason))
        return false
    end
    local cur = plugin.get_current_track_path and plugin.get_current_track_path()
    if not cur or cur ~= tracked_path then
        plugin.show_toast(tr("Loop points belong to a different track"))
        return false
    end
    if not point_a or not point_b then
        plugin.show_toast(tr("Both Point A and Point B must be marked"))
        return false
    end
    if point_b <= point_a then
        plugin.show_toast(tr("Point B must be greater than Point A"))
        return false
    end
    local dur = plugin.get_duration and plugin.get_duration() or 0
    if dur > 0 and point_b > dur then
        plugin.show_toast(string.format(tr("Point B (%.2fs) exceeds track duration (%.2fs)"), point_b, dur))
        return false
    end

    local accepted = plugin.set_ab_loop(point_a, point_b)
    if accepted then
        start_polling()
        plugin.show_toast(string.format(tr("A-B Loop engaged: %s -> %s"), format_time(point_a), format_time(point_b)))
        if open_menu then open_menu(true) end
        return true
    else
        plugin.show_toast(tr("Loop rejected by audio engine"))
        return false
    end
end

local function disengage_loop()
    if plugin.clear_ab_loop then
        plugin.clear_ab_loop()
    end
    stop_polling()
    plugin.show_toast(tr("A-B loop disengaged (points preserved)"))
    if open_menu then open_menu(true) end
end

local function clear_all_points()
    if plugin.clear_ab_loop then
        plugin.clear_ab_loop()
    end
    stop_polling()
    persist_point_a(nil)
    persist_point_b(nil)
    plugin.show_toast(tr("A-B loop points cleared"))
    if open_menu then open_menu(true) end
end

local function mark_point_a_now()
    if not plugin.is_playing or not plugin.is_playing() then
        plugin.show_toast(tr("Cannot mark point: playback is idle or paused"))
        return
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    local cur = (fmt and fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
    if not cur or cur == "" then
        plugin.show_toast(tr("Cannot mark point: no active track loaded"))
        return
    end
    local dur = (fmt and fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or 0
    if not is_finite_number(dur) or dur <= 0 then
        plugin.show_toast(tr("Track duration unknown; cannot set loop point"))
        return
    end
    local pos = plugin.get_position and plugin.get_position()
    if not is_finite_number(pos) or pos < 0 then
        plugin.show_toast(tr("Invalid playback position"))
        return
    end
    if pos > dur then
        plugin.show_toast(string.format(tr("Position (%.2fs) exceeds duration (%.2fs)"), pos, dur))
        return
    end

    if cur ~= tracked_path or (fmt and fmt.generation and fmt.generation ~= tracked_generation) then
        load_saved_points_for_track(cur)
    end
    tracked_path = cur
    tracked_generation = fmt and fmt.generation or nil

    pos = math.floor(pos * 1000 + 0.5) / 1000
    if pos > dur then pos = dur end

    local saved = persist_point_a(pos)
    if point_b and point_b <= point_a then
        persist_point_b(nil)
        if saved then
            plugin.show_toast(string.format(tr("Point A set to %s (Point B reset)"), format_time(pos)))
        else
            plugin.show_toast(string.format(tr("Point A set to %s (Point B reset; not remembered across restarts)"), format_time(pos)))
        end
    else
        if saved then
            plugin.show_toast(string.format(tr("Point A set to %s"), format_time(pos)))
        else
            plugin.show_toast(string.format(tr("Point A set to %s (not remembered across restarts)"), format_time(pos)))
        end
    end

    local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
    if current_loop then
        if point_a and point_b and point_b > point_a then
            activate_loop()
        else
            disengage_loop()
        end
    elseif open_menu then
        open_menu(true)
    end
end

local function mark_point_b_now()
    if not plugin.is_playing or not plugin.is_playing() then
        plugin.show_toast(tr("Cannot mark point: playback is idle or paused"))
        return
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    local cur = (fmt and fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
    if not cur or cur == "" then
        plugin.show_toast(tr("Cannot mark point: no active track loaded"))
        return
    end
    local dur = (fmt and fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or 0
    if not is_finite_number(dur) or dur <= 0 then
        plugin.show_toast(tr("Track duration unknown; cannot set loop point"))
        return
    end
    local pos = plugin.get_position and plugin.get_position()
    if not is_finite_number(pos) or pos < 0 then
        plugin.show_toast(tr("Invalid playback position"))
        return
    end
    if pos > dur then
        plugin.show_toast(string.format(tr("Position (%.2fs) exceeds duration (%.2fs)"), pos, dur))
        return
    end

    if cur ~= tracked_path or (fmt and fmt.generation and fmt.generation ~= tracked_generation) then
        load_saved_points_for_track(cur)
    end

    pos = math.floor(pos * 1000 + 0.5) / 1000
    if pos > dur then pos = dur end

    if point_a and pos <= point_a then
        plugin.show_toast(string.format(tr("Point B (%s) must be after Point A (%s)"), format_time(pos), format_time(point_a)))
        return
    end

    tracked_path = cur
    tracked_generation = fmt and fmt.generation or nil

    local saved = persist_point_b(pos)
    if saved then
        plugin.show_toast(string.format(tr("Point B set to %s"), format_time(pos)))
    else
        plugin.show_toast(string.format(tr("Point B set to %s (not remembered across restarts)"), format_time(pos)))
    end

    local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
    if current_loop then
        if point_a and point_b and point_b > point_a then
            activate_loop()
        else
            disengage_loop()
        end
    elseif open_menu then
        open_menu(true)
    end
end

local function edit_point_a_text()
    if not plugin.show_text_input then return end
    if not plugin.is_playing or not plugin.is_playing() then
        plugin.show_toast(tr("Cannot set point: playback is idle or paused"))
        return
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    local cur = (fmt and fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
    if not cur or cur == "" then
        plugin.show_toast(tr("No active track loaded"))
        return
    end
    local dur = (fmt and fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or 0
    if not is_finite_number(dur) or dur <= 0 then
        plugin.show_toast(tr("Track duration unknown; cannot set loop point"))
        return
    end
    local captured_path = cur
    local captured_gen = fmt and fmt.generation or nil
    local captured_dur = dur

    if cur ~= tracked_path or (captured_gen and captured_gen ~= tracked_generation) then
        load_saved_points_for_track(cur)
    end

    local init = point_a and string.format("%.3f", point_a) or "0.000"
    plugin.show_text_input(tr("Point A (seconds)"), init, false, function(text)
        if not plugin.is_playing or not plugin.is_playing() then
            plugin.show_toast(tr("Rejected: playback became paused or idle"))
            return
        end
        local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
        local active_path = (cur_fmt and cur_fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
        if not active_path or active_path ~= captured_path then
            plugin.show_toast(tr("Rejected: track changed while entering point"))
            return
        end
        if not cur_fmt or not captured_gen or cur_fmt.generation ~= captured_gen then
            plugin.show_toast(tr("Rejected: track reloaded while entering point"))
            return
        end
        local val = tonumber(text)
        if not is_finite_number(val) or val < 0 then
            plugin.show_toast(tr("Invalid Point A: enter non-negative finite seconds"))
            return
        end
        local active_dur = (cur_fmt and cur_fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or captured_dur
        if not is_finite_number(active_dur) or active_dur <= 0 then
            plugin.show_toast(tr("Track duration unknown; cannot set loop point"))
            return
        end
        if val > active_dur then
            plugin.show_toast(string.format(tr("Point A (%.2fs) exceeds track duration (%.2fs)"), val, active_dur))
            return
        end
        val = math.floor(val * 1000 + 0.5) / 1000
        if val > active_dur then val = active_dur end

        tracked_path = captured_path
        tracked_generation = captured_gen
        local saved = persist_point_a(val)
        if point_b and point_b <= point_a then
            persist_point_b(nil)
            if saved then
                plugin.show_toast(string.format(tr("Point A set to %s (Point B reset)"), format_time(val)))
            else
                plugin.show_toast(string.format(tr("Point A set to %s (Point B reset; not remembered across restarts)"), format_time(val)))
            end
        else
            if saved then
                plugin.show_toast(string.format(tr("Point A set to %s"), format_time(val)))
            else
                plugin.show_toast(string.format(tr("Point A set to %s (not remembered across restarts)"), format_time(val)))
            end
        end

        local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
        if current_loop then
            if point_a and point_b and point_b > point_a then
                activate_loop()
            else
                disengage_loop()
            end
        elseif open_menu then
            open_menu(true)
        end
    end)
end

local function edit_point_b_text()
    if not plugin.show_text_input then return end
    if not plugin.is_playing or not plugin.is_playing() then
        plugin.show_toast(tr("Cannot set point: playback is idle or paused"))
        return
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    local cur = (fmt and fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
    if not cur or cur == "" then
        plugin.show_toast(tr("No active track loaded"))
        return
    end
    local dur = (fmt and fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or 0
    if not is_finite_number(dur) or dur <= 0 then
        plugin.show_toast(tr("Track duration unknown; cannot set loop point"))
        return
    end
    local captured_path = cur
    local captured_gen = fmt and fmt.generation or nil
    local captured_dur = dur

    if cur ~= tracked_path or (captured_gen and captured_gen ~= tracked_generation) then
        load_saved_points_for_track(cur)
    end

    local init = point_b and string.format("%.3f", point_b) or (point_a and string.format("%.3f", point_a + 5) or "10.000")
    plugin.show_text_input(tr("Point B (seconds)"), init, false, function(text)
        if not plugin.is_playing or not plugin.is_playing() then
            plugin.show_toast(tr("Rejected: playback became paused or idle"))
            return
        end
        local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
        local active_path = (cur_fmt and cur_fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
        if not active_path or active_path ~= captured_path then
            plugin.show_toast(tr("Rejected: track changed while entering point"))
            return
        end
        if not cur_fmt or not captured_gen or cur_fmt.generation ~= captured_gen then
            plugin.show_toast(tr("Rejected: track reloaded while entering point"))
            return
        end
        local val = tonumber(text)
        if not is_finite_number(val) or val <= 0 then
            plugin.show_toast(tr("Invalid Point B: enter positive finite seconds"))
            return
        end
        local active_dur = (cur_fmt and cur_fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or captured_dur
        if not is_finite_number(active_dur) or active_dur <= 0 then
            plugin.show_toast(tr("Track duration unknown; cannot set loop point"))
            return
        end
        if val > active_dur then
            plugin.show_toast(string.format(tr("Point B (%.2fs) exceeds track duration (%.2fs)"), val, active_dur))
            return
        end
        val = math.floor(val * 1000 + 0.5) / 1000
        if val > active_dur then val = active_dur end
        if point_a and val <= point_a then
            plugin.show_toast(string.format(tr("Point B (%s) must be after Point A (%s)"), format_time(val), format_time(point_a)))
            return
        end

        tracked_path = captured_path
        tracked_generation = captured_gen
        local saved = persist_point_b(val)
        if saved then
            plugin.show_toast(string.format(tr("Point B set to %s"), format_time(val)))
        else
            plugin.show_toast(string.format(tr("Point B set to %s (not remembered across restarts)"), format_time(val)))
        end

        local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
        if current_loop then
            if point_a and point_b and point_b > point_a then
                activate_loop()
            else
                disengage_loop()
            end
        elseif open_menu then
            open_menu(true)
        end
    end)
end

local function show_about()
    if not plugin.show_list then return end
    plugin.show_list(tr("About A-B Repeat"), {
        tr("A-B Repeat practice looper provides sample-accurate looping."),
        tr("Looping executes natively in the audio engine frame processor."),
        tr("Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit."),
        tr("Playback speed must be 1.0x and crossfade must be disabled."),
        tr("Loop points are linked to the specific track and bounded by its duration."),
        tr("Engine loop clears on pause, seek, or track changes, but your points are kept."),
        tr("No continuous seeking is performed from Lua timers."),
    }, function() end)
end

open_menu = function(update)
    local cur = plugin.get_current_track_path and plugin.get_current_track_path()
    if cur and cur ~= tracked_path then
        load_saved_points_for_track(cur)
    end

    local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
    local is_active = (current_loop ~= nil)

    local status_text
    if is_active then
        status_text = string.format(tr("Status: Active (%s - %s)"), format_time(current_loop.start), format_time(current_loop.finish))
    elseif point_a and point_b then
        status_text = string.format(tr("Status: Ready (%s - %s)"), format_time(point_a), format_time(point_b))
    elseif point_a then
        status_text = string.format(tr("Status: Incomplete (A: %s, B: --)"), format_time(point_a))
    else
        status_text = tr("Status: Not configured")
    end

    local items = {
        {
            type = "row",
            label = status_text,
            on_select = function()
                plugin.show_toast(status_text)
            end,
        },
        {
            type = "row",
            label = is_active and tr("Disengage Loop") or tr("Engage Loop"),
            on_select = function()
                if is_active then
                    disengage_loop()
                else
                    activate_loop()
                end
            end,
        },
        {
            type = "row",
            label = tr("Mark Point A (Current Time)"),
            on_select = mark_point_a_now,
        },
        {
            type = "row",
            label = tr("Mark Point B (Current Time)"),
            on_select = mark_point_b_now,
        },
        {
            type = "row",
            label = tr("Edit Point A (Numeric)..."),
            on_select = edit_point_a_text,
        },
        {
            type = "row",
            label = tr("Edit Point B (Numeric)..."),
            on_select = edit_point_b_text,
        },
        {
            type = "row",
            label = tr("Clear Loop Points"),
            on_select = clear_all_points,
        },
        {
            type = "row",
            label = tr("About A-B Repeat"),
            on_select = show_about,
        },
    }

    if plugin.show_settings_list then
        plugin.show_settings_list(tr("A-B Repeat"), items, { update = true })
    end
end

-- Initialize stored state for currently loaded track (if any)
local initial_track = plugin.get_current_track_path and plugin.get_current_track_path()
load_saved_points_for_track(initial_track)

-- React to playback events: pause, stop, track changes natively clear the loop.
-- Native invalidations must clear owned active polling.
if plugin.on then
    plugin.on("paused", function()
        stop_polling()
    end)
    plugin.on("stopped", function()
        stop_polling()
    end)
    plugin.on("track_started", function()
        stop_polling()
        local new_track = plugin.get_current_track_path and plugin.get_current_track_path()
        load_saved_points_for_track(new_track)
    end)
end

if plugin.register_list_item then
    plugin.register_list_item("playback", tr("A-B Repeat"), function()
        open_menu(false)
    end)
end
