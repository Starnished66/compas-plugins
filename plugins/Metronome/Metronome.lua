plugin.define({
    id = "example.metronome",
    name = "Metronome",
    version = "1.5.0",
    api_min = 19,
})

local T = {
    de = {
        ["Single notes (no subdivision)"] = "Einzelnoten (keine Unterteilung)",
        ["Eighth notes (2)"] = "Achtelnoten (2)",
        ["Eighth-note triplets (3)"] = "Achteltriolen (3)",
        ["Sixteenth notes (4)"] = "Sechzehntelnoten (4)",
        ["Quintuplets (5)"] = "Quintolen (5)",
        ["Sixteenth sextuplets (6)"] = "Sechzehntelsextolen (6)",
        ["Swing eighths (long-short 2:1)"] = "Swing-Achtel (lang-kurz 2:1)",
        ["Could not write the click file"] = "Klickdatei konnte nicht geschrieben werden",
        ["Could not create the click folder"] = "Klickordner konnte nicht erstellt werden",
        ["Could not play the click file"] = "Klickdatei konnte nicht abgespielt werden",
        ["Metronome stopped"] = "Metronom gestoppt",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "Metronom konnte nicht wiederholen. Überblenden und Geschwindigkeit ausschalten.",
        ["Metronome stopped: its loop was cleared"] = "Metronom gestoppt: Schleife wurde aufgehoben",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Timer-Plätze voll; Metronom setzt nach Pausen evtl. nicht fort",
        ["Could not start the metronome"] = "Metronom konnte nicht gestartet werden",
        ["This player cannot loop audio natively"] = "Dieser Player kann Audio nicht nativ wiederholen",
        ["quarter notes"] = "Viertelnoten",
        ["dotted quarter notes"] = "punktierte Viertelnoten",
        ["eighth notes"] = "Achtelnoten",
        ["Single notes"] = "Einzelnoten",
        ["Eighths"] = "Achtel",
        ["Triplets"] = "Triolen",
        ["Sixteenths"] = "Sechzehntel",
        ["Quintuplets"] = "Quintolen",
        ["Sextuplets"] = "Sextolen",
        ["Swing"] = "Swing",
        ["Dotted quarter"] = "Punktierte Viertel",
        ["Eighth"] = "Achtel",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Beim Starten des Metronoms wird die Wiedergabe pausiert; Warteschlange und aktuelle Wiedergabe bleiben erhalten. Beim Stoppen kann die Musik fortgesetzt werden.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "Der Klicktakt wird vom Player nativ wiederholt, sodass das Timing samplegenau ist. Musikwiedergabe beendet das Metronom.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Beim Starten des Metronoms wird die aktuelle Wiedergabe ersetzt. Beim Stoppen können vorheriger Titel und Position fortgesetzt werden; die Warteschlange wird nicht wiederhergestellt.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "Der Klicktakt ist eine WAV-Datei, die nativ in Schleife abgespielt wird, sodass das Timing samplegenau ist. Pausieren, Spulen, Titelwechsel oder Aktivieren von Überblenden/Geschwindigkeit beendet die Schleife.",
        ["About Metronome"] = "Über Metronom",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "Das Tempo zählt %s. In 6/8, 9/8 und 12/8 können punktierte Viertelnoten statt Achteln gezählt werden.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "Stufe 0 schaltet einen Ton aus. Wenn Schlag 1 betonen aus ist, nutzt Schlag 1 den normalen Schlagton.",
        ["Crossfade and playback speed are not affected."] = "Überblenden und Wiedergabegeschwindigkeit bleiben unberührt.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "Überblenden wird während des Metronoms ausgeschaltet und beim Stoppen wiederhergestellt.",
        ["Time signature"] = "Taktart",
        ["Eighth notes"] = "Achtelnoten",
        ["Dotted quarter notes"] = "Punktierte Viertelnoten",
        ["Count tempo in"] = "Tempo zählen in",
        ["Subdivision"] = "Unterteilung",
        ["Tap tempo is not available on this system"] = "Tap-Tempo ist auf diesem System nicht verfügbar",
        ["Keep tapping"] = "Weiter tippen",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Tempo-Anpassungen",
        ["Time signature: %s"] = "Taktart: %s",
        ["Count tempo in: dotted quarter notes"] = "Tempo zählen in: punktierten Viertelnoten",
        ["Count tempo in: eighth notes"] = "Tempo zählen in: Achtelnoten",
        ["Subdivision: %s"] = "Unterteilung: %s",
        ["Accent beat 1"] = "Schlag 1 betonen",
        ["Rhythm"] = "Rhythmus",
        ["Accent level"] = "Betonungslautstärke",
        ["Beat level"] = "Schlaglautstärke",
        ["Subdivision level"] = "Unterteilungslautstärke",
        ["Sound levels"] = "Lautstärken",
        ["Resume music on stop"] = "Musik beim Stoppen fortsetzen",
        ["Resume previous track on stop"] = "Vorherigen Titel beim Stoppen fortsetzen",
        ["Playback & about"] = "Wiedergabe & Info",
        ["Stop"] = "Stopp",
        ["Start"] = "Start",
        ["Tempo"] = "Tempo",
        ["Tap tempo"] = "Tap-Tempo",
        ["Sound"] = "Klang",
        ["Options"] = "Optionen",
        ["Metronome"] = "Metronom",
    },
    es = {
        ["Single notes (no subdivision)"] = "Notas simples (sin subdivisión)",
        ["Eighth notes (2)"] = "Corcheas (2)",
        ["Eighth-note triplets (3)"] = "Tresillos de corchea (3)",
        ["Sixteenth notes (4)"] = "Semicorcheas (4)",
        ["Quintuplets (5)"] = "Quintillos (5)",
        ["Sixteenth sextuplets (6)"] = "Seisillos de semicorchea (6)",
        ["Swing eighths (long-short 2:1)"] = "Corcheas swing (largo-corto 2:1)",
        ["Could not write the click file"] = "No se pudo escribir el archivo de clic",
        ["Could not create the click folder"] = "No se pudo crear la carpeta de clic",
        ["Could not play the click file"] = "No se pudo reproducir el archivo de clic",
        ["Metronome stopped"] = "Metrónomo detenido",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "El metrónomo no pudo repetir en bucle. Desactiva el fundido y la velocidad de reproducción.",
        ["Metronome stopped: its loop was cleared"] = "Metrónomo detenido: se borró su bucle",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Ranuras de temporizador llenas; el metrónomo podría no recuperarse tras pausas",
        ["Could not start the metronome"] = "No se pudo iniciar el metrónomo",
        ["This player cannot loop audio natively"] = "Este reproductor no puede repetir audio en bucle de forma nativa",
        ["quarter notes"] = "negras",
        ["dotted quarter notes"] = "negras con puntillo",
        ["eighth notes"] = "corcheas",
        ["Single notes"] = "Notas simples",
        ["Eighths"] = "Corcheas",
        ["Triplets"] = "Tresillos",
        ["Sixteenths"] = "Semicorcheas",
        ["Quintuplets"] = "Quintillos",
        ["Sextuplets"] = "Seisillos",
        ["Swing"] = "Swing",
        ["Dotted quarter"] = "Negra con puntillo",
        ["Eighth"] = "Corchea",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Al iniciar el metrónomo se pausa lo que suena; tu cola y Reproduciendo ahora se mantienen igual. Al detenerlo puede reanudar la música.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "El reproductor repite el compás de clic de forma nativa con precisión de muestra. Reproducir música detiene el metrónomo.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Iniciar el metrónomo reemplaza lo que suena. Al detenerlo puede reanudar la pista y posición anteriores; la cola anterior no se restaura.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "El compás de clic es un archivo WAV repetido en bucle nativo con precisión de muestra. Pausar, buscar, cambiar de pista o activar el fundido o la velocidad termina el bucle.",
        ["About Metronome"] = "Acerca de Metrónomo",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "El tempo cuenta %s. En 6/8, 9/8 y 12/8 puedes contar negras con puntillo en lugar de corcheas.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "El nivel 0 apaga un sonido. Con Acentuar tiempo 1 desactivado, el tiempo 1 usa el sonido normal.",
        ["Crossfade and playback speed are not affected."] = "El fundido y la velocidad de reproducción no se ven afectados.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "El fundido se desactiva mientras funciona el metrónomo y se restaura al detenerse.",
        ["Time signature"] = "Compás",
        ["Eighth notes"] = "Corcheas",
        ["Dotted quarter notes"] = "Negras con puntillo",
        ["Count tempo in"] = "Contar tempo en",
        ["Subdivision"] = "Subdivisión",
        ["Tap tempo is not available on this system"] = "El tempo por toques no está disponible en este sistema",
        ["Keep tapping"] = "Sigue tocando",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Ajustes de tempo",
        ["Time signature: %s"] = "Compás: %s",
        ["Count tempo in: dotted quarter notes"] = "Contar tempo en: negras con puntillo",
        ["Count tempo in: eighth notes"] = "Contar tempo en: corcheas",
        ["Subdivision: %s"] = "Subdivisión: %s",
        ["Accent beat 1"] = "Acentuar tiempo 1",
        ["Rhythm"] = "Ritmo",
        ["Accent level"] = "Nivel de acento",
        ["Beat level"] = "Nivel de pulso",
        ["Subdivision level"] = "Nivel de subdivisión",
        ["Sound levels"] = "Niveles de sonido",
        ["Resume music on stop"] = "Reanudar música al detener",
        ["Resume previous track on stop"] = "Reanudar pista anterior al detener",
        ["Playback & about"] = "Reproducción e info",
        ["Stop"] = "Detener",
        ["Start"] = "Iniciar",
        ["Tempo"] = "Tempo",
        ["Tap tempo"] = "Tempo por toques",
        ["Sound"] = "Sonido",
        ["Options"] = "Opciones",
        ["Metronome"] = "Metrónomo",
    },
    fi = {
        ["Single notes (no subdivision)"] = "Yksittäiset iskut (ei jakoa)",
        ["Eighth notes (2)"] = "Kahdeksasosanuotit (2)",
        ["Eighth-note triplets (3)"] = "Kahdeksasosatriolit (3)",
        ["Sixteenth notes (4)"] = "Kuudestoistaosanuotit (4)",
        ["Quintuplets (5)"] = "Kvintolit (5)",
        ["Sixteenth sextuplets (6)"] = "Kuudestoistaosasekstoolit (6)",
        ["Swing eighths (long-short 2:1)"] = "Swing-kahdeksasosat (pitkä-lyhyt 2:1)",
        ["Could not write the click file"] = "Klikkitiedostoa ei voitu kirjoittaa",
        ["Could not create the click folder"] = "Klikkikansiota ei voitu luoda",
        ["Could not play the click file"] = "Klikkitiedostoa ei voitu toistaa",
        ["Metronome stopped"] = "Metronomi pysähtyi",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "Metronomin silmukka epäonnistui. Poista ristiinhäivytys ja toistonopeus käytöstä.",
        ["Metronome stopped: its loop was cleared"] = "Metronomi pysähtyi: silmukka tyhjennettiin",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Ajastinpaikat ovat täynnä; metronomi ei ehkä palaudu tauoista",
        ["Could not start the metronome"] = "Metronomia ei voitu käynnistää",
        ["This player cannot loop audio natively"] = "Tämä soitin ei tue natiivia äänisilmukkaa",
        ["quarter notes"] = "neljäsosanuotteja",
        ["dotted quarter notes"] = "pisteellisiä neljäsosanuotteja",
        ["eighth notes"] = "kahdeksasosanuotteja",
        ["Single notes"] = "Yksittäiset",
        ["Eighths"] = "Kahdeksasosat",
        ["Triplets"] = "Triolit",
        ["Sixteenths"] = "Kuudestoistaosat",
        ["Quintuplets"] = "Kvintolit",
        ["Sextuplets"] = "Sekstoolit",
        ["Swing"] = "Swing",
        ["Dotted quarter"] = "Pisteellinen neljäsosa",
        ["Eighth"] = "Kahdeksasosa",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Metronomin käynnistys keskeyttää toiston; jono ja Nyt soi säilyvät ennallaan. Pysäytettäessä musiikki voidaan jatkaa.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "Soitin toistaa klikkitahtia natiivina silmukkana näytteen tarkkuudella. Musiikin toisto lopettaa metronomin.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Metronomin käynnistys korvaa nykyisen toiston. Pysäytettäessä edellinen kappale ja kohta voidaan palauttaa; jonoa ei palauteta.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "Klikkitahti on WAV-tiedosto, jota soitin toistaa natiivissa silmukassa näytteen tarkkuudella. Tauko, kelaus, kappaleen vaihto tai ristiinhäivytys/toistonopeus lopettaa silmukan.",
        ["About Metronome"] = "Tietoja metronomista",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "Tempo laskee %s. Tahtilajeissa 6/8, 9/8 ja 12/8 voit laskea pisteellisiä neljäsosia kahdeksasosien sijaan.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "Taso 0 mykistää äänen. Kun Korosta iskua 1 on pois, isku 1 käyttää perusiskun ääntä.",
        ["Crossfade and playback speed are not affected."] = "Ristiinhäivytykseen ja toistonopeuteen ei vaikuteta.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "Ristiinhäivytys kytketään pois metronomin ajaksi ja palautetaan sen pysähtyessä.",
        ["Time signature"] = "Tahtilaji",
        ["Eighth notes"] = "Kahdeksasosanuotit",
        ["Dotted quarter notes"] = "Pisteelliset neljäsosanuotit",
        ["Count tempo in"] = "Laske tempo",
        ["Subdivision"] = "Alajako",
        ["Tap tempo is not available on this system"] = "Tap-tempo ei ole käytettävissä tässä järjestelmässä",
        ["Keep tapping"] = "Jatka naputtelua",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Tempon säätö",
        ["Time signature: %s"] = "Tahtilaji: %s",
        ["Count tempo in: dotted quarter notes"] = "Laske tempo: pisteelliset neljäsosat",
        ["Count tempo in: eighth notes"] = "Laske tempo: kahdeksasosat",
        ["Subdivision: %s"] = "Alajako: %s",
        ["Accent beat 1"] = "Korosta iskua 1",
        ["Rhythm"] = "Rytmi",
        ["Accent level"] = "Korostuksen taso",
        ["Beat level"] = "Iskun taso",
        ["Subdivision level"] = "Alajaon taso",
        ["Sound levels"] = "Äänitasot",
        ["Resume music on stop"] = "Jatka musiikkia pysäytettäessä",
        ["Resume previous track on stop"] = "Jatka edellistä kappaletta pysäytettäessä",
        ["Playback & about"] = "Toisto ja tiedot",
        ["Stop"] = "Pysäytä",
        ["Start"] = "Käynnistä",
        ["Tempo"] = "Tempo",
        ["Tap tempo"] = "Tap-tempo",
        ["Sound"] = "Ääni",
        ["Options"] = "Asetukset",
        ["Metronome"] = "Metronomi",
    },
    fr = {
        ["Single notes (no subdivision)"] = "Notes simples (sans subdivision)",
        ["Eighth notes (2)"] = "Croches (2)",
        ["Eighth-note triplets (3)"] = "Triolets de croches (3)",
        ["Sixteenth notes (4)"] = "Doubles croches (4)",
        ["Quintuplets (5)"] = "Quintolets (5)",
        ["Sixteenth sextuplets (6)"] = "Sextolets de doubles croches (6)",
        ["Swing eighths (long-short 2:1)"] = "Croches swing (long-court 2:1)",
        ["Could not write the click file"] = "Impossible d'écrire le fichier de clic",
        ["Could not create the click folder"] = "Impossible de créer le dossier de clic",
        ["Could not play the click file"] = "Impossible de lire le fichier de clic",
        ["Metronome stopped"] = "Métronome arrêté",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "Le métronome n'a pas pu boucler. Désactivez le fondu et la vitesse de lecture.",
        ["Metronome stopped: its loop was cleared"] = "Métronome arrêté : sa boucle a été effacée",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Plus de minuteries disponibles ; le métronome peut ne pas reprendre après une pause",
        ["Could not start the metronome"] = "Impossible de démarrer le métronome",
        ["This player cannot loop audio natively"] = "Ce lecteur ne peut pas boucler l'audio nativement",
        ["quarter notes"] = "noires",
        ["dotted quarter notes"] = "noires pointées",
        ["eighth notes"] = "croches",
        ["Single notes"] = "Notes simples",
        ["Eighths"] = "Croches",
        ["Triplets"] = "Triolets",
        ["Sixteenths"] = "Doubles croches",
        ["Quintuplets"] = "Quintolets",
        ["Sextuplets"] = "Sextolets",
        ["Swing"] = "Swing",
        ["Dotted quarter"] = "Noire pointée",
        ["Eighth"] = "Croche",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Démarrer le métronome met la lecture en pause ; votre file d'attente et Lecture en cours restent intactes. À l'arrêt, la musique peut reprendre.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "La mesure de clic est bouclée nativement par le lecteur avec une précision à l'échantillon. Lire de la musique arrête le métronome.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Démarrer le métronome remplace la lecture en cours. À l'arrêt, la piste et la position précédentes peuvent reprendre ; la file n'est pas restaurée.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "La mesure de clic est un fichier WAV lu et bouclé nativement avec une précision à l'échantillon. Mettre en pause, chercher, changer de piste ou activer le fondu ou la vitesse arrête la boucle.",
        ["About Metronome"] = "À propos du métronome",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "Le tempo compte des %s. En 6/8, 9/8 et 12/8, vous pouvez compter des noires pointées au lieu de croches.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "Le niveau 0 coupe un son. Si Accentuer le temps 1 est désactivé, le temps 1 utilise le son normal.",
        ["Crossfade and playback speed are not affected."] = "Le fondu enchaîné et la vitesse de lecture ne sont pas affectés.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "Le fondu est désactivé pendant que le métronome tourne et restauré à l'arrêt.",
        ["Time signature"] = "Signature rythmique",
        ["Eighth notes"] = "Croches",
        ["Dotted quarter notes"] = "Noires pointées",
        ["Count tempo in"] = "Compter le tempo en",
        ["Subdivision"] = "Subdivision",
        ["Tap tempo is not available on this system"] = "Tap tempo n'est pas disponible sur ce système",
        ["Keep tapping"] = "Continuez à taper",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Ajustements du tempo",
        ["Time signature: %s"] = "Signature rythmique : %s",
        ["Count tempo in: dotted quarter notes"] = "Compter le tempo en : noires pointées",
        ["Count tempo in: eighth notes"] = "Compter le tempo en : croches",
        ["Subdivision: %s"] = "Subdivision : %s",
        ["Accent beat 1"] = "Accentuer le temps 1",
        ["Rhythm"] = "Rythme",
        ["Accent level"] = "Volume de l'accent",
        ["Beat level"] = "Volume du temps",
        ["Subdivision level"] = "Volume de subdivision",
        ["Sound levels"] = "Niveaux sonores",
        ["Resume music on stop"] = "Reprendre la musique à l'arrêt",
        ["Resume previous track on stop"] = "Reprendre la piste précédente à l'arrêt",
        ["Playback & about"] = "Lecture et infos",
        ["Stop"] = "Arrêter",
        ["Start"] = "Démarrer",
        ["Tempo"] = "Tempo",
        ["Tap tempo"] = "Tap tempo",
        ["Sound"] = "Son",
        ["Options"] = "Options",
        ["Metronome"] = "Métronome",
    },
    it = {
        ["Single notes (no subdivision)"] = "Note singole (nessuna suddivisione)",
        ["Eighth notes (2)"] = "Crome (2)",
        ["Eighth-note triplets (3)"] = "Terzine di crome (3)",
        ["Sixteenth notes (4)"] = "Semicrome (4)",
        ["Quintuplets (5)"] = "Quintine (5)",
        ["Sixteenth sextuplets (6)"] = "Sestine di semicrome (6)",
        ["Swing eighths (long-short 2:1)"] = "Crome swing (lungo-corto 2:1)",
        ["Could not write the click file"] = "Impossibile scrivere il file del clic",
        ["Could not create the click folder"] = "Impossibile creare la cartella del clic",
        ["Could not play the click file"] = "Impossibile riprodurre il file del clic",
        ["Metronome stopped"] = "Metronomo fermato",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "Il metronomo non può ripetersi. Disattiva dissolvenza e velocità di riproduzione.",
        ["Metronome stopped: its loop was cleared"] = "Metronomo fermato: il loop è stato rimosso",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Slot timer esauriti; il metronomo potrebbe non riprendere dalle pause",
        ["Could not start the metronome"] = "Impossibile avviare il metronomo",
        ["This player cannot loop audio natively"] = "Questo lettore non può ripetere l'audio nativamente",
        ["quarter notes"] = "semiminime",
        ["dotted quarter notes"] = "semiminime col punto",
        ["eighth notes"] = "crome",
        ["Single notes"] = "Note singole",
        ["Eighths"] = "Crome",
        ["Triplets"] = "Terzine",
        ["Sixteenths"] = "Semicrome",
        ["Quintuplets"] = "Quintine",
        ["Sextuplets"] = "Sestine",
        ["Swing"] = "Swing",
        ["Dotted quarter"] = "Semiminima col punto",
        ["Eighth"] = "Croma",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Avviando il metronomo la riproduzione va in pausa; coda e In riproduzione restano invariati. Allo stop la musica può riprendere.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "La battuta del clic è ripetuta nativamente dal lettore con precisione al campione. Riprodurre musica ferma il metronomo.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Avviare il metronomo sostituisce la riproduzione attuale. Allo stop può riprendere brano e posizione precedenti; la coda non viene ripristinata.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "La battuta del clic è un file WAV riprodotto e ripetuto nativamente con precisione al campione. Mettere in pausa, cercare, cambiare brano o attivare dissolvenza/velocità interrompe il loop.",
        ["About Metronome"] = "Informazioni sul metronomo",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "Il tempo conta %s. In 6/8, 9/8 e 12/8 puoi contare semiminime col punto invece di crome.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "Il livello 0 disattiva un suono. Con Accenta battito 1 disattivato, il battito 1 usa il suono normale.",
        ["Crossfade and playback speed are not affected."] = "Dissolvenza e velocità di riproduzione non subiscono modifiche.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "La dissolvenza viene disattivata mentre il metronomo è in funzione e ripristinata allo stop.",
        ["Time signature"] = "Indicazione di tempo",
        ["Eighth notes"] = "Crome",
        ["Dotted quarter notes"] = "Semiminime col punto",
        ["Count tempo in"] = "Conta il tempo in",
        ["Subdivision"] = "Suddivisione",
        ["Tap tempo is not available on this system"] = "Tap tempo non disponibile su questo sistema",
        ["Keep tapping"] = "Continua a toccare",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Regolazioni tempo",
        ["Time signature: %s"] = "Indicazione di tempo: %s",
        ["Count tempo in: dotted quarter notes"] = "Conta il tempo in: semiminime col punto",
        ["Count tempo in: eighth notes"] = "Conta il tempo in: crome",
        ["Subdivision: %s"] = "Suddivisione: %s",
        ["Accent beat 1"] = "Accenta battito 1",
        ["Rhythm"] = "Ritmo",
        ["Accent level"] = "Volume accento",
        ["Beat level"] = "Volume battito",
        ["Subdivision level"] = "Volume suddivisione",
        ["Sound levels"] = "Livelli sonori",
        ["Resume music on stop"] = "Riprendi musica allo stop",
        ["Resume previous track on stop"] = "Riprendi brano precedente allo stop",
        ["Playback & about"] = "Riproduzione e info",
        ["Stop"] = "Ferma",
        ["Start"] = "Avvia",
        ["Tempo"] = "Tempo",
        ["Tap tempo"] = "Tap tempo",
        ["Sound"] = "Suono",
        ["Options"] = "Opzioni",
        ["Metronome"] = "Metronomo",
    },
    ja = {
        ["Single notes (no subdivision)"] = "分割なし (1)",
        ["Eighth notes (2)"] = "8分音符 (2)",
        ["Eighth-note triplets (3)"] = "3連符 (3)",
        ["Sixteenth notes (4)"] = "16分音符 (4)",
        ["Quintuplets (5)"] = "5連符 (5)",
        ["Sixteenth sextuplets (6)"] = "6連符 (6)",
        ["Swing eighths (long-short 2:1)"] = "スウィング8分 (2:1)",
        ["Could not write the click file"] = "クリック音声を書き込めませんでした",
        ["Could not create the click folder"] = "クリック用フォルダを作成できませんでした",
        ["Could not play the click file"] = "クリック音声を再生できませんでした",
        ["Metronome stopped"] = "メトロノームを停止しました",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "ループ再生できませんでした。クロスフェードと再生速度をオフにしてください。",
        ["Metronome stopped: its loop was cleared"] = "メトロノーム停止: ループが解除されました",
        ["Timer slots are full; the metronome may not recover from pauses"] = "タイマー枠が上限に達したため、一時停止から復帰できない場合があります",
        ["Could not start the metronome"] = "メトロノームを開始できませんでした",
        ["This player cannot loop audio natively"] = "このプレーヤーはネイティブループに対応していません",
        ["quarter notes"] = "4分音符",
        ["dotted quarter notes"] = "付点4分音符",
        ["eighth notes"] = "8分音符",
        ["Single notes"] = "分割なし",
        ["Eighths"] = "8分音符",
        ["Triplets"] = "3連符",
        ["Sixteenths"] = "16分音符",
        ["Quintuplets"] = "5連符",
        ["Sextuplets"] = "6連符",
        ["Swing"] = "スウィング",
        ["Dotted quarter"] = "付点4分音符",
        ["Eighth"] = "8分音符",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "メトロノームを開始すると再生中の曲は一時停止し、キューと再生中画面はそのまま保たれます。停止時に音楽を再開できます。",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "クリック小節はプレーヤー本体でループ再生されるため、サンプル単位で正確です。音楽を再生するとメトロノームは終了します。",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "メトロノームを開始すると現在の再生が置き換わります。停止時に前の曲と再生位置を再開できますが、前のキューは復元されません。",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "クリック小節は WAV ファイルとしてネイティブループ再生されるため、サンプル単位で正確です。一時停止、シーク、曲変更、クロスフェードや再生速度のオンでループが終了します。",
        ["About Metronome"] = "メトロノームについて",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "テンポは%s単位です。6/8、9/8、12/8拍子では8分音符の代わりに付点4分音符でカウントできます。",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "レベル 0 で消音になります。「1拍目を強調」がオフのとき、1拍目は通常の拍音になります。",
        ["Crossfade and playback speed are not affected."] = "クロスフェードと再生速度には影響しません。",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "クロスフェードはメトロノーム動作中にオフになり、停止時に元に戻ります。",
        ["Time signature"] = "拍子",
        ["Eighth notes"] = "8分音符",
        ["Dotted quarter notes"] = "付点4分音符",
        ["Count tempo in"] = "テンポの単位",
        ["Subdivision"] = "分割",
        ["Tap tempo is not available on this system"] = "このシステムではタップテンポを利用できません",
        ["Keep tapping"] = "続けてタップしてください",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "テンポ微調整",
        ["Time signature: %s"] = "拍子: %s",
        ["Count tempo in: dotted quarter notes"] = "テンポの単位: 付点4分音符",
        ["Count tempo in: eighth notes"] = "テンポの単位: 8分音符",
        ["Subdivision: %s"] = "分割: %s",
        ["Accent beat 1"] = "1拍目を強調",
        ["Rhythm"] = "リズム",
        ["Accent level"] = "アクセント音量",
        ["Beat level"] = "ビート音量",
        ["Subdivision level"] = "分割音量",
        ["Sound levels"] = "音量バランス",
        ["Resume music on stop"] = "停止時に音楽を再開",
        ["Resume previous track on stop"] = "停止時に前の曲を再開",
        ["Playback & about"] = "再生と情報",
        ["Stop"] = "停止",
        ["Start"] = "開始",
        ["Tempo"] = "テンポ",
        ["Tap tempo"] = "タップテンポ",
        ["Sound"] = "サウンド",
        ["Options"] = "オプション",
        ["Metronome"] = "メトロノーム",
    },
    nl = {
        ["Single notes (no subdivision)"] = "Enkele noten (geen onderverdeling)",
        ["Eighth notes (2)"] = "Achtste noten (2)",
        ["Eighth-note triplets (3)"] = "Achtste triolen (3)",
        ["Sixteenth notes (4)"] = "Zestiende noten (4)",
        ["Quintuplets (5)"] = "Kwintolen (5)",
        ["Sixteenth sextuplets (6)"] = "Zestiende sextolen (6)",
        ["Swing eighths (long-short 2:1)"] = "Swing-achtsten (lang-kort 2:1)",
        ["Could not write the click file"] = "Kon klikbestand niet schrijven",
        ["Could not create the click folder"] = "Kon klikmap niet aanmaken",
        ["Could not play the click file"] = "Kon klikbestand niet afspelen",
        ["Metronome stopped"] = "Metronoom gestopt",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "Metronoom kon niet herhalen. Schakel crossfade en afspeelsnelheid uit.",
        ["Metronome stopped: its loop was cleared"] = "Metronoom gestopt: lus is gewist",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Timerslots zijn vol; de metronoom herstelt mogelijk niet na pauzes",
        ["Could not start the metronome"] = "Kon metronoom niet starten",
        ["This player cannot loop audio natively"] = "Deze speler kan audio niet standaard in een lus afspelen",
        ["quarter notes"] = "kwartnoten",
        ["dotted quarter notes"] = "gepuncteerde kwartnoten",
        ["eighth notes"] = "achtste noten",
        ["Single notes"] = "Enkele noten",
        ["Eighths"] = "Achtsten",
        ["Triplets"] = "Triolen",
        ["Sixteenths"] = "Zestienden",
        ["Quintuplets"] = "Kwintolen",
        ["Sextuplets"] = "Sextolen",
        ["Swing"] = "Swing",
        ["Dotted quarter"] = "Gepuncteerde kwart",
        ["Eighth"] = "Achtste",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Bij het starten van de metronoom wordt het afspelen gepauzeerd; je wachtrij en Nu speelt blijven behouden. Bij stoppen kan de muziek worden hervat.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "De klikmaat wordt door de speler zelf in een lus herhaald voor sample-nauwkeurige timing. Muziek afspelen stopt de metronoom.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Het starten van de metronoom vervangt wat er speelt. Bij stoppen kunnen het vorige nummer en de positie worden hervat; de wachtrij wordt niet hersteld.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "De klikmaat is een WAV-bestand dat door de speler zelf in een lus wordt afgespeeld voor sample-nauwkeurige timing. Pauzeren, spoelen, van nummer wisselen of crossfade/afspeelsnelheid inschakelen beëindigt de lus.",
        ["About Metronome"] = "Over Metronoom",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "Het tempo telt %s. In 6/8, 9/8 en 12/8 kun je gepuncteerde kwartnoten tellen in plaats van achtsten.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "Niveau 0 zet een geluid uit. Als Tel 1 accentueren uit staat, gebruikt tel 1 het normale telgeluid.",
        ["Crossfade and playback speed are not affected."] = "Crossfade en afspeelsnelheid worden niet beïnvloed.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "Crossfade wordt uitgeschakeld zolang de metronoom loopt en hersteld zodra deze stopt.",
        ["Time signature"] = "Maatsoort",
        ["Eighth notes"] = "Achtste noten",
        ["Dotted quarter notes"] = "Gepuncteerde kwartnoten",
        ["Count tempo in"] = "Tempo tellen in",
        ["Subdivision"] = "Onderverdeling",
        ["Tap tempo is not available on this system"] = "Tap-tempo is niet beschikbaar op dit systeem",
        ["Keep tapping"] = "Blijf tikken",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Tempo-aanpassingen",
        ["Time signature: %s"] = "Maatsoort: %s",
        ["Count tempo in: dotted quarter notes"] = "Tempo tellen in: gepuncteerde kwartnoten",
        ["Count tempo in: eighth notes"] = "Tempo tellen in: achtste noten",
        ["Subdivision: %s"] = "Onderverdeling: %s",
        ["Accent beat 1"] = "Tel 1 accentueren",
        ["Rhythm"] = "Ritme",
        ["Accent level"] = "Accentniveau",
        ["Beat level"] = "Telniveau",
        ["Subdivision level"] = "Onderverdelingsniveau",
        ["Sound levels"] = "Geluidsniveaus",
        ["Resume music on stop"] = "Muziek hervatten bij stoppen",
        ["Resume previous track on stop"] = "Vorig nummer hervatten bij stoppen",
        ["Playback & about"] = "Afspelen & info",
        ["Stop"] = "Stop",
        ["Start"] = "Start",
        ["Tempo"] = "Tempo",
        ["Tap tempo"] = "Tap-tempo",
        ["Sound"] = "Geluid",
        ["Options"] = "Opties",
        ["Metronome"] = "Metronoom",
    },
    pt = {
        ["Single notes (no subdivision)"] = "Notas simples (sem subdivisão)",
        ["Eighth notes (2)"] = "Colcheias (2)",
        ["Eighth-note triplets (3)"] = "Tercinas de colcheia (3)",
        ["Sixteenth notes (4)"] = "Semicolcheias (4)",
        ["Quintuplets (5)"] = "Quiálteras de 5 (5)",
        ["Sixteenth sextuplets (6)"] = "Sextinas de semicolcheia (6)",
        ["Swing eighths (long-short 2:1)"] = "Colcheias swing (longo-curto 2:1)",
        ["Could not write the click file"] = "Não foi possível gravar o arquivo de clique",
        ["Could not create the click folder"] = "Não foi possível criar a pasta de clique",
        ["Could not play the click file"] = "Não foi possível reproduzir o arquivo de clique",
        ["Metronome stopped"] = "Metrônomo parado",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "O metrônomo não pôde repetir em loop. Desative o crossfade e a velocidade de reprodução.",
        ["Metronome stopped: its loop was cleared"] = "Metrônomo parado: o loop foi limpo",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Os temporizadores estão cheios; o metrônomo pode não se recuperar de pausas",
        ["Could not start the metronome"] = "Não foi possível iniciar o metrônomo",
        ["This player cannot loop audio natively"] = "Este reprodutor não pode repetir áudio em loop nativamente",
        ["quarter notes"] = "seminimas",
        ["dotted quarter notes"] = "semínimas pontuadas",
        ["eighth notes"] = "colcheias",
        ["Single notes"] = "Notas simples",
        ["Eighths"] = "Colcheias",
        ["Triplets"] = "Tercinas",
        ["Sixteenths"] = "Semicolcheias",
        ["Quintuplets"] = "Quintinas",
        ["Sextuplets"] = "Sextinas",
        ["Swing"] = "Swing",
        ["Dotted quarter"] = "Semínima pontuada",
        ["Eighth"] = "Colcheia",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Iniciar o metrônomo pausa o que está tocando; sua fila e Tocando agora permanecem como estavam. Ao parar, ele pode retomar a música.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "O compasso de clique é repetido nativamente pelo reprodutor com precisão de amostra. Reproduzir música encerra o metrônomo.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Iniciar o metrônomo substitui o que está tocando. Ao parar, pode retomar a faixa e posição anteriores; a fila anterior não é restaurada.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "O compasso de clique é um arquivo WAV reproduzido em loop nativo com precisão de amostra. Pausar, buscar, mudar de faixa ou ativar crossfade ou velocidade encerra o loop.",
        ["About Metronome"] = "Sobre o Metrônomo",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "O andamento conta %s. Em 6/8, 9/8 e 12/8 você pode contar semínimas pontuadas em vez de colcheias.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "O nível 0 desliga um som. Com Acentuar tempo 1 desativado, o tempo 1 usa o som normal.",
        ["Crossfade and playback speed are not affected."] = "O crossfade e a velocidade de reprodução não são afetados.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "O crossfade é desativado enquanto o metrônomo funciona e restaurado quando ele para.",
        ["Time signature"] = "Fórmula de compasso",
        ["Eighth notes"] = "Colcheias",
        ["Dotted quarter notes"] = "Semínimas pontuadas",
        ["Count tempo in"] = "Contar andamento em",
        ["Subdivision"] = "Subdivisão",
        ["Tap tempo is not available on this system"] = "Tap tempo não está disponível neste sistema",
        ["Keep tapping"] = "Continue tocando",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Ajustes de andamento",
        ["Time signature: %s"] = "Fórmula de compasso: %s",
        ["Count tempo in: dotted quarter notes"] = "Contar andamento em: semínimas pontuadas",
        ["Count tempo in: eighth notes"] = "Contar andamento em: colcheias",
        ["Subdivision: %s"] = "Subdivisão: %s",
        ["Accent beat 1"] = "Acentuar tempo 1",
        ["Rhythm"] = "Ritmo",
        ["Accent level"] = "Nível do acento",
        ["Beat level"] = "Nível da batida",
        ["Subdivision level"] = "Nível da subdivisão",
        ["Sound levels"] = "Niveís de som",
        ["Resume music on stop"] = "Retomar música ao parar",
        ["Resume previous track on stop"] = "Retomar faixa anterior ao parar",
        ["Playback & about"] = "Reprodução e sobre",
        ["Stop"] = "Parar",
        ["Start"] = "Iniciar",
        ["Tempo"] = "Andamento",
        ["Tap tempo"] = "Tap tempo",
        ["Sound"] = "Som",
        ["Options"] = "Opções",
        ["Metronome"] = "Metrônomo",
    },
    ru = {
        ["Single notes (no subdivision)"] = "Одиночные доли (без деления)",
        ["Eighth notes (2)"] = "Восьмые (2)",
        ["Eighth-note triplets (3)"] = "Триоли восьмыми (3)",
        ["Sixteenth notes (4)"] = "Шестнадцатые (4)",
        ["Quintuplets (5)"] = "Квинтоли (5)",
        ["Sixteenth sextuplets (6)"] = "Секстоли шестнадцатыми (6)",
        ["Swing eighths (long-short 2:1)"] = "Свинг восьмыми (2:1)",
        ["Could not write the click file"] = "Не удалось записать файл клика",
        ["Could not create the click folder"] = "Не удалось создать папку для клика",
        ["Could not play the click file"] = "Не удалось воспроизвести файл клика",
        ["Metronome stopped"] = "Метроном остановлен",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "Не удалось зациклить метроном. Отключите кроссфейд и изменение скорости.",
        ["Metronome stopped: its loop was cleared"] = "Метроном остановлен: цикл был сброшен",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Слоты таймеров заняты; метроном может не возобновиться после паузы",
        ["Could not start the metronome"] = "Не удалось запустить метроном",
        ["This player cannot loop audio natively"] = "Этот плеер не поддерживает нативное зацикливание аудио",
        ["quarter notes"] = "четвертные ноты",
        ["dotted quarter notes"] = "четвертные с точкой",
        ["eighth notes"] = "восьмые ноты",
        ["Single notes"] = "Без деления",
        ["Eighths"] = "Восьмые",
        ["Triplets"] = "Триоли",
        ["Sixteenths"] = "Шестнадцатые",
        ["Quintuplets"] = "Квинтоли",
        ["Sextuplets"] = "Секстоли",
        ["Swing"] = "Свинг",
        ["Dotted quarter"] = "Четверть с точкой",
        ["Eighth"] = "Восьмая",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Запуск метронома ставит музыку на паузу; очередь и экран воспроизведения сохраняются. При остановке музыка может продолжиться.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "Такт метронома зацикливается плеером нативно с точностью до сэмпла. Запуск музыки останавливает метроном.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Запуск метронома заменяет текущее воспроизведение. При остановке можно вернуть предыдущий трек и позицию; очередь не восстанавливается.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "Такт метронома — это WAV-файл, зацикленный нативно с точностью до сэмпла. Пауза, перемотка, смена трека или включение кроссфейда/скорости прерывает цикл.",
        ["About Metronome"] = "О метрономе",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "Темп считает %s. В размерах 6/8, 9/8 и 12/8 можно считать четвертями с точкой вместо восьмых.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "Уровень 0 отключает звук. Если акцент 1-й доли выключен, 1-я доля звучит как обычная.",
        ["Crossfade and playback speed are not affected."] = "Кроссфейд и скорость воспроизведения не затрагиваются.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "Кроссфейд отключается на время работы метронома и восстанавливается при остановке.",
        ["Time signature"] = "Размер такта",
        ["Eighth notes"] = "Восьмые ноты",
        ["Dotted quarter notes"] = "Четвертные с точкой",
        ["Count tempo in"] = "Считать темп в",
        ["Subdivision"] = "Дробление доли",
        ["Tap tempo is not available on this system"] = "Настукивание темпа недоступно в этой системе",
        ["Keep tapping"] = "Продолжайте нажимать",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Подстройка темпа",
        ["Time signature: %s"] = "Размер такта: %s",
        ["Count tempo in: dotted quarter notes"] = "Считать темп в: четвертях с точкой",
        ["Count tempo in: eighth notes"] = "Считать темп в: восьмых",
        ["Subdivision: %s"] = "Дробление: %s",
        ["Accent beat 1"] = "Акцент на 1-ю долю",
        ["Rhythm"] = "Ритм",
        ["Accent level"] = "Громкость акцента",
        ["Beat level"] = "Громкость доли",
        ["Subdivision level"] = "Громкость дробления",
        ["Sound levels"] = "Уровни громкости",
        ["Resume music on stop"] = "Возобновить музыку при остановке",
        ["Resume previous track on stop"] = "Вернуть прошлый трек при остановке",
        ["Playback & about"] = "Воспроизведение и справка",
        ["Stop"] = "Стоп",
        ["Start"] = "Старт",
        ["Tempo"] = "Темп",
        ["Tap tempo"] = "Настучать темп",
        ["Sound"] = "Звук",
        ["Options"] = "Параметры",
        ["Metronome"] = "Метроном",
    },
    uk = {
        ["Single notes (no subdivision)"] = "Одиночні долі (без поділу)",
        ["Eighth notes (2)"] = "Восьмі (2)",
        ["Eighth-note triplets (3)"] = "Тріолі восьмими (3)",
        ["Sixteenth notes (4)"] = "Шістнадцяті (4)",
        ["Quintuplets (5)"] = "Квінтолі (5)",
        ["Sixteenth sextuplets (6)"] = "Секстолі шістнадцятими (6)",
        ["Swing eighths (long-short 2:1)"] = "Свінг восьмими (2:1)",
        ["Could not write the click file"] = "Не вдалося записати файл кліку",
        ["Could not create the click folder"] = "Не вдалося створити теку для кліку",
        ["Could not play the click file"] = "Не вдалося відтворити файл кліку",
        ["Metronome stopped"] = "Метроном зупинено",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "Не вдалося зациклити метроном. Вимкніть кросфейд і швидкість відтворення.",
        ["Metronome stopped: its loop was cleared"] = "Метроном зупинено: цикл було скинуто",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Слоти таймерів зайняті; метроном може не відновитися після паузи",
        ["Could not start the metronome"] = "Не вдалося запустити метроном",
        ["This player cannot loop audio natively"] = "Цей плеєр не підтримує нативне зациклення аудіо",
        ["quarter notes"] = "чвертні ноти",
        ["dotted quarter notes"] = "чвертні з крапкою",
        ["eighth notes"] = "восьмі ноти",
        ["Single notes"] = "Без поділу",
        ["Eighths"] = "Восьмі",
        ["Triplets"] = "Тріолі",
        ["Sixteenths"] = "Шістнадцяті",
        ["Quintuplets"] = "Квінтолі",
        ["Sextuplets"] = "Секстолі",
        ["Swing"] = "Свінг",
        ["Dotted quarter"] = "Чверть із крапкою",
        ["Eighth"] = "Восьма",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Запуск метронома ставить музику на паузу; черга та екран відтворення зберігаються. При зупинці музика може продовжитися.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "Такт метронома зациклюється плеєром нативно з точністю до семпла. Запуск музики зупиняє метроном.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Запуск метронома замінює поточне відтворення. При зупинці можна повернути попередній трек і позицію; черга не відновлюється.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "Такт метронома — це WAV-файл, зациклений нативно з точністю до семпла. Пауза, перемотування, зміна треку або увімкнення кросфейду/швидкості перериває цикл.",
        ["About Metronome"] = "Про метроном",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "Темп рахує %s. У розмірах 6/8, 9/8 і 12/8 можна рахувати чвертями з крапкою замість восьмих.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "Рівень 0 вимикає звук. Якщо акцент 1-ї долі вимкнено, 1-ша доля звучить як звичайна.",
        ["Crossfade and playback speed are not affected."] = "Кросфейд і швидкість відтворення не зачіпаються.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "Кросфейд вимикається на час роботи метронома і відновлюється при зупинці.",
        ["Time signature"] = "Розмір такту",
        ["Eighth notes"] = "Восьмі ноти",
        ["Dotted quarter notes"] = "Чвертні з крапкою",
        ["Count tempo in"] = "Рахувати темп у",
        ["Subdivision"] = "Поділ долі",
        ["Tap tempo is not available on this system"] = "Настукування темпу недоступне в цій системі",
        ["Keep tapping"] = "Продовжуйте натискати",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Підстроювання темпу",
        ["Time signature: %s"] = "Розмір такту: %s",
        ["Count tempo in: dotted quarter notes"] = "Рахувати темп у: чвертях із крапкою",
        ["Count tempo in: eighth notes"] = "Рахувати темп у: восьмих",
        ["Subdivision: %s"] = "Поділ: %s",
        ["Accent beat 1"] = "Акцент на 1-шу долю",
        ["Rhythm"] = "Ритм",
        ["Accent level"] = "Гучність акценту",
        ["Beat level"] = "Гучність долі",
        ["Subdivision level"] = "Гучність поділу",
        ["Sound levels"] = "Рівні гучності",
        ["Resume music on stop"] = "Відновити музику при зупинці",
        ["Resume previous track on stop"] = "Повернути минулий трек при зупинці",
        ["Playback & about"] = "Відтворення та довідка",
        ["Stop"] = "Стоп",
        ["Start"] = "Старт",
        ["Tempo"] = "Темп",
        ["Tap tempo"] = "Настукати темп",
        ["Sound"] = "Звук",
        ["Options"] = "Параметри",
        ["Metronome"] = "Метроном",
    },
    vi = {
        ["Single notes (no subdivision)"] = "Nốt đơn (không chia nhỏ)",
        ["Eighth notes (2)"] = "Nốt móc đơn (2)",
        ["Eighth-note triplets (3)"] = "Liên ba móc đơn (3)",
        ["Sixteenth notes (4)"] = "Nốt móc kép (4)",
        ["Quintuplets (5)"] = "Liên năm (5)",
        ["Sixteenth sextuplets (6)"] = "Liên sáu móc kép (6)",
        ["Swing eighths (long-short 2:1)"] = "Móc đơn swing (dài-ngắn 2:1)",
        ["Could not write the click file"] = "Không thể ghi tệp tiếng nhịp",
        ["Could not create the click folder"] = "Không thể tạo thư mục tiếng nhịp",
        ["Could not play the click file"] = "Không thể phát tệp tiếng nhịp",
        ["Metronome stopped"] = "Đã dừng máy đếm nhịp",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "Máy đếm nhịp không thể lặp. Hãy tắt chuyển mượt và tốc độ phát.",
        ["Metronome stopped: its loop was cleared"] = "Đã dừng máy đếm nhịp: vòng lặp bị xóa",
        ["Timer slots are full; the metronome may not recover from pauses"] = "Đã hết bộ hẹn giờ; máy đếm nhịp có thể không tự chạy lại sau khi tạm dừng",
        ["Could not start the metronome"] = "Không thể bật máy đếm nhịp",
        ["This player cannot loop audio natively"] = "Máy nghe nhạc này không hỗ trợ lặp âm thanh gốc",
        ["quarter notes"] = "nốt đen",
        ["dotted quarter notes"] = "nốt đen chấm dôi",
        ["eighth notes"] = "nốt móc đơn",
        ["Single notes"] = "Nốt đơn",
        ["Eighths"] = "Móc đơn",
        ["Triplets"] = "Liên ba",
        ["Sixteenths"] = "Móc kép",
        ["Quintuplets"] = "Liên năm",
        ["Sextuplets"] = "Liên sáu",
        ["Swing"] = "Swing",
        ["Dotted quarter"] = "Đen chấm dôi",
        ["Eighth"] = "Móc đơn",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "Bật máy đếm nhịp sẽ tạm dừng nhạc đang phát; hàng đợi và Đang phát vẫn giữ nguyên. Khi dừng có thể phát tiếp nhạc.",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "Ô nhịp được máy phát lặp trực tiếp nên chuẩn xác từng mẫu âm thanh. Phát nhạc sẽ tắt máy đếm nhịp.",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "Bật máy đếm nhịp sẽ thay thế bài đang phát. Khi dừng có thể phát lại bài và vị trí trước đó; hàng đợi cũ không được khôi phục.",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "Ô nhịp là tệp WAV được lặp trực tiếp chuẩn xác từng mẫu âm thanh. Tạm dừng, tua, đổi bài hoặc bật chuyển mượt/tốc độ phát sẽ kết thúc vòng lặp.",
        ["About Metronome"] = "Giới thiệu Máy đếm nhịp",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "Nhịp độ đếm theo %s. Ở nhịp 6/8, 9/8 và 12/8, bạn có thể đếm nốt đen chấm dôi thay vì móc đơn.",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "Mức 0 sẽ tắt âm. Khi tắt Nhấn phách 1, phách 1 dùng âm phách thường.",
        ["Crossfade and playback speed are not affected."] = "Chuyển mượt và tốc độ phát không bị ảnh hưởng.",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "Chuyển mượt được tắt khi máy đếm nhịp chạy và khôi phục khi dừng.",
        ["Time signature"] = "Số chỉ nhịp",
        ["Eighth notes"] = "Nốt móc đơn",
        ["Dotted quarter notes"] = "Nốt đen chấm dôi",
        ["Count tempo in"] = "Đếm nhịp theo",
        ["Subdivision"] = "Chia nhỏ phách",
        ["Tap tempo is not available on this system"] = "Chức năng gõ nhịp không khả dụng trên hệ thống này",
        ["Keep tapping"] = "Hãy tiếp tục gõ",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "Chỉnh nhịp độ",
        ["Time signature: %s"] = "Số chỉ nhịp: %s",
        ["Count tempo in: dotted quarter notes"] = "Đếm nhịp theo: nốt đen chấm dôi",
        ["Count tempo in: eighth notes"] = "Đếm nhịp theo: nốt móc đơn",
        ["Subdivision: %s"] = "Chia nhỏ: %s",
        ["Accent beat 1"] = "Nhấn phách 1",
        ["Rhythm"] = "Tiết tấu",
        ["Accent level"] = "Âm lượng phách nhấn",
        ["Beat level"] = "Âm lượng phách",
        ["Subdivision level"] = "Âm lượng chia nhỏ",
        ["Sound levels"] = "Mức âm lượng",
        ["Resume music on stop"] = "Phát tiếp nhạc khi dừng",
        ["Resume previous track on stop"] = "Phát lại bài trước khi dừng",
        ["Playback & about"] = "Phát lại & giới thiệu",
        ["Stop"] = "Dừng",
        ["Start"] = "Bắt đầu",
        ["Tempo"] = "Nhịp độ",
        ["Tap tempo"] = "Gõ nhịp",
        ["Sound"] = "Âm thanh",
        ["Options"] = "Tùy chọn",
        ["Metronome"] = "Máy đếm nhịp",
    },
    zh_CN = {
        ["Single notes (no subdivision)"] = "单音 (无细分)",
        ["Eighth notes (2)"] = "八分音符 (2)",
        ["Eighth-note triplets (3)"] = "八分三连音 (3)",
        ["Sixteenth notes (4)"] = "十六分音符 (4)",
        ["Quintuplets (5)"] = "五连音 (5)",
        ["Sixteenth sextuplets (6)"] = "十六分六连音 (6)",
        ["Swing eighths (long-short 2:1)"] = "摇摆八分音符 (长-短 2:1)",
        ["Could not write the click file"] = "无法写入节拍音频文件",
        ["Could not create the click folder"] = "无法创建节拍文件夹",
        ["Could not play the click file"] = "无法播放节拍音频文件",
        ["Metronome stopped"] = "节拍器已停止",
        ["Metronome could not loop. Turn off crossfade and playback speed."] = "节拍器无法循环。请关闭淡入淡出和变速播放。",
        ["Metronome stopped: its loop was cleared"] = "节拍器已停止：循环已清除",
        ["Timer slots are full; the metronome may not recover from pauses"] = "定时器已满；节拍器暂停后可能无法恢复",
        ["Could not start the metronome"] = "无法启动节拍器",
        ["This player cannot loop audio natively"] = "此播放器不支持原生音频循环",
        ["quarter notes"] = "四分音符",
        ["dotted quarter notes"] = "附点四分音符",
        ["eighth notes"] = "八分音符",
        ["Single notes"] = "单音",
        ["Eighths"] = "八分音符",
        ["Triplets"] = "三连音",
        ["Sixteenths"] = "十六分音符",
        ["Quintuplets"] = "五连音",
        ["Sextuplets"] = "六连音",
        ["Swing"] = "摇摆",
        ["Dotted quarter"] = "附点四分",
        ["Eighth"] = "八分",
        ["Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."] = "启动节拍器会暂停当前播放；播放队列和正在播放保持不变。停止时可恢复音乐播放。",
        ["The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."] = "节拍小节由播放器原生循环，计时精确到采样。播放音乐会结束节拍器。",
        ["Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."] = "启动节拍器会替换当前播放内容。停止时可恢复上一首曲目及位置，但不会恢复之前的队列。",
        ["The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."] = "节拍小节是由播放器原生循环播放的 WAV 文件，计时精确到采样。暂停、快进快退、切歌或开启淡入淡出/变速播放会结束循环。",
        ["About Metronome"] = "关于节拍器",
        ["Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."] = "速度按%s计数。在 6/8、9/8 和 12/8 拍中，你可以按附点四分音符而非八分音符计数。",
        ["Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."] = "音量设为 0 会静音。关闭“重音第 1 拍”时，第 1 拍使用普通拍音。",
        ["Crossfade and playback speed are not affected."] = "淡入淡出和播放速度不受影响。",
        ["Crossfade is switched off while the metronome runs and restored when it stops."] = "节拍器运行时会关闭淡入淡出，停止时恢复。",
        ["Time signature"] = "拍号",
        ["Eighth notes"] = "八分音符",
        ["Dotted quarter notes"] = "附点四分音符",
        ["Count tempo in"] = "速度计数单位",
        ["Subdivision"] = "细分",
        ["Tap tempo is not available on this system"] = "此系统不支持点按测速",
        ["Keep tapping"] = "请继续点按",
        ["%s%d BPM → %d BPM"] = "%s%d BPM → %d BPM",
        ["Tempo adjustments"] = "速度调整",
        ["Time signature: %s"] = "拍号: %s",
        ["Count tempo in: dotted quarter notes"] = "速度计数单位: 附点四分音符",
        ["Count tempo in: eighth notes"] = "速度计数单位: 八分音符",
        ["Subdivision: %s"] = "细分: %s",
        ["Accent beat 1"] = "重音第 1 拍",
        ["Rhythm"] = "节奏",
        ["Accent level"] = "重音音量",
        ["Beat level"] = "节拍音量",
        ["Subdivision level"] = "细分音量",
        ["Sound levels"] = "音量设置",
        ["Resume music on stop"] = "停止时恢复音乐",
        ["Resume previous track on stop"] = "停止时恢复上一曲目",
        ["Playback & about"] = "播放与关于",
        ["Stop"] = "停止",
        ["Start"] = "开始",
        ["Tempo"] = "速度",
        ["Tap tempo"] = "点按测速",
        ["Sound"] = "声音",
        ["Options"] = "选项",
        ["Metronome"] = "节拍器",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

-- Metronome with sample-accurate timing and no native code.
--
-- Plugin timers fire at most once a second, so clicks cannot be timed from
-- Lua. Instead the plugin renders a few bars of clicks into a 16-bit stereo
-- PCM WAV file with every click at its exact sample offset, plays it with
-- plugin.play_file() and loops it with the native A-B loop
-- (plugin.set_ab_loop), which wraps inside the audio thread without
-- reopening the output.
--
-- Timing: a pulse is one counted beat and lasts 60 / bpm seconds. A click at
-- pulse k, subdivision position s/d, is placed at frame
--     round((k * d + s) * rate * 60 / (d * bpm))
-- computed in integers (round half up), so no error accumulates. The loop is
-- an integer number of bars (at least MIN_LOOP_SEC seconds) and its length is
-- round(bars * pulses * rate * 60 / bpm) frames. The file carries a short
-- silent tail past the loop end, because the player rejects a loop end at or
-- beyond the file length, and it converts seconds to frames by truncation, so
-- the end is requested half a frame late: (loop_frames + 0.5) / rate.
--
-- Players with the "audio.loop" capability repeat the bar with
-- plugin.audio_loop_start() instead: the bar is exactly one loop long, it
-- never becomes the current track, and music is only paused, so the queue and
-- Now Playing are untouched. Older players fall back to playing the file as a
-- track: the previous track and position can be resumed on stop, but not the
-- previous queue.

local MIN_LOOP_SEC = 3
local TAIL_DIV = 4              -- silent tail after the loop: rate / TAIL_DIV frames
local LONG_LOOP_SEC = 10        -- longer loops are rendered at LOW_RATE to keep the file small
local HIGH_RATE, LOW_RATE = 44100, 22050
local BPM_MIN, BPM_MAX = 20, 300
local ARM_GIVE_UP_TICKS = 10
local REARM_GIVE_UP_TICKS = 5
local TAP_GAP = 2.0
local TAP_KEEP = 5
local DEBOUNCE = 1.5

local SOUNDS = {
    accent = { freq = 2000, ms = 30, key = "lvl_accent" },
    beat   = { freq = 1250, ms = 25, key = "lvl_beat" },
    sub    = { freq = 800,  ms = 15, key = "lvl_sub" },
}

-- d is the number of equal slots per beat, pos the slots that sound.
local SUBS = {
    { id = "none",        name = "Single notes (no subdivision)", d = 1, pos = { 0 } },
    { id = "eighths",     name = "Eighth notes (2)",              d = 2, pos = { 0, 1 } },
    { id = "triplets",    name = "Eighth-note triplets (3)",      d = 3, pos = { 0, 1, 2 } },
    { id = "sixteenths",  name = "Sixteenth notes (4)",           d = 4, pos = { 0, 1, 2, 3 } },
    { id = "quintuplets", name = "Quintuplets (5)",               d = 5, pos = { 0, 1, 2, 3, 4 } },
    { id = "sextuplets",  name = "Sixteenth sextuplets (6)",      d = 6, pos = { 0, 1, 2, 3, 4, 5 } },
    { id = "swing",       name = "Swing eighths (long-short 2:1)", d = 3, pos = { 0, 2 } },
}

local DEFAULTS = {
    bpm = 120, num = 4, den = 4, count = "eighth", sub = "none",
    accent_on = 1, lvl_accent = 10, lvl_beat = 8, lvl_sub = 6, restore = 1,
}

local sd_root = plugin.sd_root and plugin.sd_root() or "."
local DIR = sd_root .. "/.metronome"
local FILES = { DIR .. "/metronome_a.wav", DIR .. "/metronome_b.wav" }

------------------------------------------------------------------------
-- Settings

local cfg = {}

local function loop_supported()
    return plugin.has_capability and plugin.has_capability("audio.loop") and
        plugin.audio_loop_start ~= nil
end

-- Plays without opening Now Playing where the player supports it, so the
-- metronome screen stays in front.
local function play_here(path)
    if plugin.has_capability and plugin.has_capability("playback.stay_on_screen") then
        plugin.play_file(path, { open_player = false })
    else
        plugin.play_file(path)
    end
end

local function store_get(key)
    if not plugin.storage then return nil end
    local ok, value = pcall(plugin.storage.get, key)
    if ok then return value end
    return nil
end

local function store_set(key, value)
    if not plugin.storage then return end
    pcall(plugin.storage.set, key, tostring(value))
end

local function store_delete(key)
    if not plugin.storage then return end
    pcall(plugin.storage.delete, key)
end

local function clamp_int(value, lo, hi, default)
    local n = tonumber(value)
    if not n or n ~= n then return default end
    n = math.tointeger(math.floor(n + 0.5))
    if not n then return default end
    if n < lo then return lo end
    if n > hi then return hi end
    return n
end

local function find_sub(id)
    for _, sub in ipairs(SUBS) do
        if sub.id == id then return sub end
    end
    return SUBS[1]
end

local function compound_capable(num, den)
    return den == 8 and num % 3 == 0
end

local function sanitize()
    cfg.bpm = clamp_int(cfg.bpm, BPM_MIN, BPM_MAX, DEFAULTS.bpm)
    cfg.num = clamp_int(cfg.num, 1, 12, DEFAULTS.num)
    cfg.den = (tonumber(cfg.den) == 8) and 8 or 4
    cfg.sub = find_sub(cfg.sub).id
    cfg.accent_on = clamp_int(cfg.accent_on, 0, 1, 1)
    cfg.restore = clamp_int(cfg.restore, 0, 1, 1)
    cfg.lvl_accent = clamp_int(cfg.lvl_accent, 0, 10, DEFAULTS.lvl_accent)
    cfg.lvl_beat = clamp_int(cfg.lvl_beat, 0, 10, DEFAULTS.lvl_beat)
    cfg.lvl_sub = clamp_int(cfg.lvl_sub, 0, 10, DEFAULTS.lvl_sub)
    if cfg.count ~= "dotted" or not compound_capable(cfg.num, cfg.den) then cfg.count = "eighth" end
end

local function load_settings()
    for key, default in pairs(DEFAULTS) do
        local stored = store_get(key)
        if stored == nil or stored == "" then cfg[key] = default else cfg[key] = stored end
    end
    sanitize()
end

local function save_settings()
    sanitize()
    for key in pairs(DEFAULTS) do store_set(key, cfg[key]) end
end

------------------------------------------------------------------------
-- Rendering

-- Builds the click schedule and loop length for a configuration. Pure
-- integer arithmetic; see the header comment for the formulas.
local function build_plan(c, exact)
    local pulses = c.num
    if c.den == 8 and c.count == "dotted" and c.num % 3 == 0 then pulses = c.num // 3 end
    local per_bar_x60 = 60 * pulses
    local bars = (MIN_LOOP_SEC * c.bpm + per_bar_x60 - 1) // per_bar_x60
    if bars < 1 then bars = 1 end
    local loop_sec = bars * pulses * 60 / c.bpm
    local rate = loop_sec > LONG_LOOP_SEC and LOW_RATE or HIGH_RATE
    local sub = find_sub(c.sub)
    local d = sub.d
    local events = {}
    for k = 0, bars * pulses - 1 do
        for _, s in ipairs(sub.pos) do
            local kind
            if s ~= 0 then
                kind = "sub"
            elseif k % pulses == 0 and c.accent_on == 1 then
                kind = "accent"
            else
                kind = "beat"
            end
            if c[SOUNDS[kind].key] > 0 then
                events[#events + 1] = {
                    frame = (2 * (k * d + s) * rate * 60 + d * c.bpm) // (2 * d * c.bpm),
                    kind = kind,
                }
            end
        end
    end
    local loop_frames = (2 * bars * pulses * rate * 60 + c.bpm) // (2 * c.bpm)
    return {
        rate = rate, bars = bars, pulses = pulses, events = events,
        loop_frames = loop_frames,
        total_frames = exact and loop_frames or loop_frames + rate // TAIL_DIV,
        loop_end = (loop_frames + 0.5) / rate,
    }
end

-- A short sine burst with a fast attack and exponential decay, 16-bit stereo.
local function render_click(freq, ms, level, rate)
    local n = (rate * ms + 500) // 1000
    local amp = 0.9 * level / 10 * 32767
    local tau = n / 7
    local att = math.max(4, rate // 2000)
    local parts = {}
    local pack, exp, cos, floor = string.pack, math.exp, math.cos, math.floor
    local w = 2 * math.pi * freq / rate
    for i = 0, n - 1 do
        local env = exp(-i / tau)
        if i < att then env = env * (i + 1) / att end
        local v = floor(amp * env * cos(w * i) + 0.5)
        parts[i + 1] = pack("<i2i2", v, v)
    end
    return table.concat(parts)
end

local ZERO_BLOCK = string.rep("\0", 65536)

local function wav_header(rate, frames)
    local data = frames * 4
    return string.pack("<c4I4c4c4I4I2I2I4I4I2I2c4I4",
        "RIFF", 36 + data, "WAVE", "fmt ", 16, 1, 2, rate, rate * 4, 4, 16, "data", data)
end

local function write_wav(path, plan, c)
    local clicks = {}
    for kind, sound in pairs(SOUNDS) do
        if c[sound.key] > 0 then
            clicks[kind] = render_click(sound.freq, sound.ms, c[sound.key], plan.rate)
        end
    end
    local tmp = path .. ".tmp"
    local f = io.open(tmp, "wb")
    if not f then return false, tr("Could not write the click file") end
    local ok = f:write(wav_header(plan.rate, plan.total_frames)) ~= nil
    local pos = 0
    local function silence(frames)
        local bytes = frames * 4
        while ok and bytes >= #ZERO_BLOCK do
            ok = f:write(ZERO_BLOCK) ~= nil
            bytes = bytes - #ZERO_BLOCK
        end
        if ok and bytes > 0 then ok = f:write(string.rep("\0", bytes)) ~= nil end
    end
    local events = plan.events
    for i = 1, #events do
        local e = events[i]
        silence(e.frame - pos)
        local nxt = events[i + 1] and events[i + 1].frame or plan.loop_frames
        local click = clicks[e.kind]
        local frames = #click // 4
        if frames > nxt - e.frame then
            frames = nxt - e.frame
            click = click:sub(1, frames * 4)
        end
        if ok then ok = f:write(click) ~= nil end
        pos = e.frame + frames
    end
    silence(plan.total_frames - pos)
    local closed = f:close()
    if not ok or not closed then
        os.remove(tmp)
        return false, tr("Could not write the click file")
    end
    os.remove(path)
    if not os.rename(tmp, path) then
        os.remove(tmp)
        return false, tr("Could not write the click file")
    end
    return true
end

------------------------------------------------------------------------
-- Run state

local run = { running = false }
local restore_pending = nil     -- { path, pos } to seek after the previous track starts
local timer = nil
local tap_times = {}
local open_menu

local function cleanup_files()
    for _, path in ipairs(FILES) do
        os.remove(path)
        os.remove(path .. ".tmp")
    end
end

local function stop_timer()
    if timer and plugin.clear_interval then plugin.clear_interval(timer) end
    timer = nil
end

local function uptime()
    local f = io.open("/proc/uptime", "r")
    if not f then return nil end
    local text = f:read("l")
    f:close()
    return tonumber(text and text:match("^(%d+%.?%d*)"))
end

local function now()
    return uptime() or os.time()
end

local function restore_crossfade()
    if store_get("xfade") == "1" then
        if plugin.set_crossfade then pcall(plugin.set_crossfade, true) end
        store_delete("xfade")
    end
end

local function clear_prev()
    store_delete("prev_path")
    store_delete("prev_pos")
end

-- Ends the run. restore: resume the previous track. stop_audio: stop the
-- player when the metronome file is still the current track.
local function finish(restore, stop_audio)
    if not run.running then return end
    local path = run.path
    run.running = false
    stop_timer()
    if run.loop then
        if plugin.audio_loop_active() then plugin.audio_loop_stop() end
        if restore and run.paused_music and plugin.is_paused() then plugin.toggle_pause() end
        cleanup_files()
        run = { running = false }
        return
    end
    local current = plugin.get_current_track_path and plugin.get_current_track_path()
    if current == path and plugin.get_ab_loop and plugin.get_ab_loop() and plugin.clear_ab_loop then
        plugin.clear_ab_loop()
    end
    local prev_path, prev_pos = store_get("prev_path"), tonumber(store_get("prev_pos")) or 0
    if restore and current == path and prev_path and prev_path ~= "" then
        restore_pending = { path = prev_path, pos = prev_pos }
        play_here(prev_path)
    elseif stop_audio and current == path then
        plugin.stop()
    end
    cleanup_files()
    restore_crossfade()
    clear_prev()
    run = { running = false }
end

local function try_arm()
    if not run.running or not plugin.set_ab_loop then return false end
    if plugin.get_current_track_path() ~= run.path then return false end
    if not plugin.is_playing() then return false end
    local pos = plugin.get_position() or 0
    if pos >= run.loop_end - 0.3 then
        -- Too late to arm without running into the tail: start the file again.
        run.pending = true
        run.ticks = 0
        play_here(run.path)
        return false
    end
    if plugin.set_ab_loop(0, run.loop_end) then
        run.armed = true
        run.pending = false
        run.need_rearm = false
        run.ticks = 0
        if run.old_path then
            os.remove(run.old_path)
            run.old_path = nil
        end
        return true
    end
    return false
end

-- Renders the bar for the current settings and plays it.
local function launch()
    local plan = build_plan(cfg, run.loop)
    local ok_dir, dir_err = true, nil
    if plugin.mkdir then ok_dir, dir_err = plugin.mkdir(DIR) end
    if not ok_dir then return false, tr("Could not create the click folder") end
    local index = (run.index or 0) % 2 + 1
    local path = FILES[index]
    local ok, err = write_wav(path, plan, cfg)
    if not ok then return false, err end
    run.old_path = run.running and run.path or nil
    run.index = index
    run.path = path
    run.loop_end = plan.loop_end
    run.armed, run.pending, run.need_rearm, run.ticks = false, true, false, 0
    run.dirty = nil
    run.running = true
    if run.loop then
        if not plugin.audio_loop_start(path) then return false, tr("Could not play the click file") end
        run.pending = false
        if run.old_path then
            os.remove(run.old_path)
            run.old_path = nil
        end
        return true
    end
    play_here(path)
    return true
end

local function on_tick()
    if not run.running then
        stop_timer()
        return
    end
    if run.loop then
        if not plugin.audio_loop_active() then
            finish(false, false)
            plugin.show_toast(tr("Metronome stopped"))
            return
        end
        if run.dirty and now() - run.dirty >= DEBOUNCE then
            local ok, err = launch()
            if not ok then
                finish(false, true)
                plugin.show_toast(err or tr("Metronome stopped"))
            end
        end
        return
    end
    local current = plugin.get_current_track_path()
    if run.pending then
        run.ticks = (run.ticks or 0) + 1
        if current == run.path and try_arm() then return end
        if run.ticks > ARM_GIVE_UP_TICKS then
            finish(false, true)
            plugin.show_toast(tr("Metronome could not loop. Turn off crossfade and playback speed."))
        end
        return
    end
    if current ~= run.path or not (plugin.is_playing() or plugin.is_paused()) then
        finish(false, false)
        plugin.show_toast(tr("Metronome stopped"))
        return
    end
    if plugin.is_paused() then return end
    if run.need_rearm then
        run.ticks = (run.ticks or 0) + 1
        if not try_arm() and run.ticks > REARM_GIVE_UP_TICKS then
            finish(false, true)
            plugin.show_toast(tr("Metronome stopped"))
        end
        return
    end
    if not plugin.get_ab_loop() then
        finish(false, true)
        plugin.show_toast(tr("Metronome stopped: its loop was cleared"))
        return
    end
    if run.dirty and now() - run.dirty >= DEBOUNCE then
        local ok, err = launch()
        if not ok then
            finish(false, true)
            plugin.show_toast(err or tr("Metronome stopped"))
        end
    end
end

local function start_timer()
    if timer or not plugin.set_interval then return end
    local ok, handle = pcall(plugin.set_interval, 1, on_tick)
    if ok and handle then
        timer = handle
    else
        plugin.show_toast(tr("Timer slots are full; the metronome may not recover from pauses"))
    end
end

local function capture_previous()
    local current = plugin.get_current_track_path and plugin.get_current_track_path()
    clear_prev()
    if not current or current == "" or current:find("^%a+://") then return end
    if current:sub(1, #DIR + 1) == DIR .. "/" then return end
    if not (plugin.is_playing() or plugin.is_paused()) then return end
    store_set("prev_path", current)
    store_set("prev_pos", string.format("%.3f", plugin.get_position() or 0))
end

local function start_metronome()
    if run.running then return true end
    if loop_supported() then
        run = { running = false, loop = true, paused_music = plugin.is_playing() }
        local ok, err = launch()
        if not ok then
            run = { running = false }
            cleanup_files()
            plugin.show_toast(err or tr("Could not start the metronome"))
            return false
        end
        start_timer()
        return true
    end
    if not plugin.has_capability("playback.ab_loop") then
        plugin.show_toast(tr("This player cannot loop audio natively"))
        return false
    end
    if run.running then return true end
    capture_previous()
    if plugin.get_crossfade and plugin.get_crossfade() and plugin.set_crossfade then
        store_set("xfade", "1")
        plugin.set_crossfade(false)
    end
    run = { running = false }
    local ok, err = launch()
    if not ok then
        run = { running = false }
        cleanup_files()
        restore_crossfade()
        clear_prev()
        plugin.show_toast(err or tr("Could not start the metronome"))
        return false
    end
    start_timer()
    return true
end

local function stop_metronome()
    finish(cfg.restore == 1, true)
end

-- Applies a settings change to a running metronome. Tempo changes are
-- debounced so repeated taps or steps restart the loop only once.
local function settings_changed(debounce)
    save_settings()
    if not run.running then return end
    if debounce then
        run.dirty = now()
        return
    end
    local ok, err = launch()
    if not ok then
        finish(false, true)
        plugin.show_toast(err or tr("Metronome stopped"))
    end
end

------------------------------------------------------------------------
-- Events

if plugin.on then
    plugin.on("track_started", function()
        local current = plugin.get_current_track_path()
        if restore_pending and current == restore_pending.path then
            local target = restore_pending.pos
            restore_pending = nil
            if target > 1 then plugin.seek(target) end
            return
        end
        if not run.running or run.loop then return end
        if current == run.path then
            if run.pending then try_arm() end
        elseif not run.pending then
            finish(false, false)
        end
    end)
    plugin.on("paused", function()
        if run.running and not run.loop and not run.pending then run.need_rearm = true end
    end)
    plugin.on("resumed", function()
        if run.running and not run.loop and not run.pending and run.need_rearm then
            run.ticks = 0
            try_arm()
        end
    end)
    plugin.on("stopped", function()
        if run.running and not run.loop and not run.pending then finish(false, false) end
    end)
end

------------------------------------------------------------------------
-- UI

local function meter_label()
    return cfg.num .. "/" .. cfg.den
end

local function tempo_unit()
    if cfg.den == 4 then return tr("quarter notes") end
    if cfg.count == "dotted" then return tr("dotted quarter notes") end
    return tr("eighth notes")
end

local function rhythm_summary()
    local sub = {
        none = tr("Single notes"), eighths = tr("Eighths"), triplets = tr("Triplets"),
        sixteenths = tr("Sixteenths"), quintuplets = tr("Quintuplets"),
        sextuplets = tr("Sextuplets"), swing = tr("Swing"),
    }
    local summary = meter_label()
    if cfg.den == 8 then
        summary = summary .. " · " .. (cfg.count == "dotted" and tr("Dotted quarter") or tr("Eighth"))
    end
    return summary .. " · " .. sub[cfg.sub]
end

local open_tempo_steps, open_rhythm, open_levels, open_playback

local function show_about()
    local playback
    if loop_supported() then
        playback = {
            { label = tr("Starting the metronome pauses what is playing; your queue and Now Playing stay as they were. On stop it can resume the music."), wrap = true },
            { label = tr("The click bar is looped natively by the player, so timing is sample accurate. Playing music ends the metronome."), wrap = true },
        }
    else
        playback = {
            { label = tr("Starting the metronome replaces what is playing. On stop it can resume the previous track and position; the previous queue is not restored."), wrap = true },
            { label = tr("The click bar is a WAV file played by the player and looped natively, so timing is sample accurate. Pausing, seeking, changing track or turning on crossfade or playback speed ends the loop."), wrap = true },
        }
    end
    plugin.show_list(tr("About Metronome"), {
        playback[1],
        playback[2],
        { label = string.format(tr("Tempo counts %s. In 6/8, 9/8 and 12/8 you can count dotted quarter notes instead of eighths."), tempo_unit()), wrap = true },
        { label = tr("Level 0 turns a sound off. With Accent beat 1 off, beat 1 uses the beat sound."), wrap = true },
        { label = loop_supported() and tr("Crossfade and playback speed are not affected.") or
            tr("Crossfade is switched off while the metronome runs and restored when it stops."), wrap = true },
    }, function() end)
end

local function choose_meter()
    local items, selected = {}, 1
    for _, den in ipairs({ 4, 8 }) do
        for num = 1, 12 do
            items[#items + 1] = num .. "/" .. den
            if num == cfg.num and den == cfg.den then selected = #items end
        end
    end
    plugin.show_list(tr("Time signature"), items, function(index)
        local den = index > 12 and 8 or 4
        local num = (index - 1) % 12 + 1
        if num == cfg.num and den == cfg.den then return end
        cfg.num, cfg.den = num, den
        if not compound_capable(num, den) then cfg.count = "eighth" end
        settings_changed(false)
        open_menu(true)
        open_rhythm(true)
    end, { selected = selected })
end

local function choose_counting()
    local items = { tr("Eighth notes"), tr("Dotted quarter notes") }
    plugin.show_list(tr("Count tempo in"), items, function(index)
        local count = index == 2 and "dotted" or "eighth"
        if count == cfg.count then return end
        cfg.count = count
        settings_changed(false)
        open_menu(true)
        open_rhythm(true)
    end, { selected = cfg.count == "dotted" and 2 or 1 })
end

local function choose_subdivision()
    local items, selected = {}, 1
    for i, sub in ipairs(SUBS) do
        items[i] = tr(sub.name)
        if sub.id == cfg.sub then selected = i end
    end
    plugin.show_list(tr("Subdivision"), items, function(index)
        if SUBS[index].id == cfg.sub then return end
        cfg.sub = SUBS[index].id
        settings_changed(false)
        open_menu(true)
        open_rhythm(true)
    end, { selected = selected })
end

local function set_bpm(value, debounce, redraw)
    local bpm = clamp_int(value, BPM_MIN, BPM_MAX, cfg.bpm)
    if bpm == cfg.bpm then return end
    cfg.bpm = bpm
    settings_changed(debounce)
    if redraw then redraw() end
end

local function tap_tempo()
    local t = uptime()
    if not t then
        plugin.show_toast(tr("Tap tempo is not available on this system"))
        return
    end
    if #tap_times > 0 and t - tap_times[#tap_times] > TAP_GAP then tap_times = {} end
    tap_times[#tap_times + 1] = t
    while #tap_times > TAP_KEEP do table.remove(tap_times, 1) end
    if #tap_times < 2 then
        plugin.show_toast(tr("Keep tapping"))
        return
    end
    local average = (tap_times[#tap_times] - tap_times[1]) / (#tap_times - 1)
    if average <= 0 then return end
    local bpm = math.floor(60 / average + 0.5)
    if bpm < BPM_MIN then bpm = BPM_MIN end
    if bpm > BPM_MAX then bpm = BPM_MAX end
    if bpm ~= cfg.bpm then
        cfg.bpm = bpm
        settings_changed(true)
    end
    open_menu(true)
end

local function level_slider(label, key)
    return {
        type = "slider", label = label, min = 0, max = 10, value = cfg[key],
        on_change = function(value)
            cfg[key] = value
            settings_changed(false)
            open_menu(true)
            open_levels(true)
        end,
    }
end

open_tempo_steps = function(update)
    local items = {}
    for _, step in ipairs({ -10, -1, 1, 10 }) do
        local target = clamp_int(cfg.bpm + step, BPM_MIN, BPM_MAX, cfg.bpm)
        items[#items + 1] = {
            type = "row",
            label = string.format(tr("%s%d BPM → %d BPM"), step > 0 and "+" or "", step, target),
            on_select = function()
                set_bpm(cfg.bpm + step, true, function()
                    open_menu(true)
                    open_tempo_steps(true)
                end)
            end,
        }
    end
    plugin.show_settings_list(tr("Tempo adjustments"), items, update and { update = true } or nil)
end

open_rhythm = function(update)
    local items = {
        { type = "row", label = string.format(tr("Time signature: %s"), meter_label()), on_select = choose_meter },
    }
    if compound_capable(cfg.num, cfg.den) then
        items[#items + 1] = {
            type = "row",
            label = cfg.count == "dotted" and tr("Count tempo in: dotted quarter notes") or tr("Count tempo in: eighth notes"),
            on_select = choose_counting,
        }
    end
    items[#items + 1] = { type = "row", label = string.format(tr("Subdivision: %s"), tr(find_sub(cfg.sub).name)), on_select = choose_subdivision, wrap = true }
    items[#items + 1] = {
        type = "toggle", label = tr("Accent beat 1"), value = cfg.accent_on == 1,
        on_change = function(value)
            cfg.accent_on = value and 1 or 0
            settings_changed(false)
            open_menu(true)
            open_rhythm(true)
        end,
    }
    plugin.show_settings_list(tr("Rhythm"), items, update and { update = true } or nil)
end

open_levels = function(update)
    local items = {
        level_slider(tr("Accent level"), "lvl_accent"),
        level_slider(tr("Beat level"), "lvl_beat"),
        level_slider(tr("Subdivision level"), "lvl_sub"),
    }
    plugin.show_settings_list(tr("Sound levels"), items, update and { update = true } or nil)
end

open_playback = function(update)
    local items = {
        {
            type = "toggle", label = loop_supported() and tr("Resume music on stop") or tr("Resume previous track on stop"), value = cfg.restore == 1,
            on_change = function(value)
                cfg.restore = value and 1 or 0
                save_settings()
                open_playback(true)
            end,
        },
        { type = "row", label = tr("About Metronome"), on_select = show_about },
    }
    plugin.show_settings_list(tr("Playback & about"), items, update and { update = true } or nil)
end

open_menu = function(update)
    local items = {
        {
            type = "row",
            label = run.running and tr("Stop") or tr("Start"),
            icon = run.running and "Metronome/stop.png" or "Metronome/play.png",
            on_select = function()
                if run.running then stop_metronome() else start_metronome() end
                open_menu(true)
            end,
        },
        {
            type = "slider", label = tr("Tempo"), min = BPM_MIN, max = BPM_MAX, value = cfg.bpm,
            icon = "Metronome/sliders-horizontal.png",
            on_change = function(value) set_bpm(value, false, function() open_menu(true) end) end,
        },
        { type = "row", label = tr("Tempo"), icon = "Metronome/sliders-horizontal.png", on_select = function() open_tempo_steps(false) end },
        { type = "row", label = tr("Tap tempo"), icon = "Metronome/hand-tap.png", on_select = tap_tempo },
        { type = "row", label = tr("Rhythm"), icon = "Metronome/music-notes.png", on_select = function() open_rhythm(false) end },
        { type = "row", label = tr("Sound"), icon = "Metronome/speaker-high.png", on_select = function() open_levels(false) end },
        { type = "row", label = tr("Options"), icon = "Metronome/gear-six.png", on_select = function() open_playback(false) end },
    }
    local markers = build_plan(cfg).pulses
    plugin.show_settings_list(tr("Metronome"), items, {
        update = update == true,
        layout = "dashboard",
        markers = markers,
        accent_first = cfg.accent_on == 1,
        active = run.running,
        detail = rhythm_summary(),
    })
end

------------------------------------------------------------------------
-- Startup

load_settings()

local function adopt_or_sweep()
    local current = plugin.get_current_track_path and plugin.get_current_track_path()
    for i, path in ipairs(FILES) do
        if current == path then
            local loop = plugin.get_ab_loop and plugin.get_ab_loop()
            local plan = build_plan(cfg)
            run = {
                running = true, index = i, path = path,
                loop_end = loop and loop.finish or plan.loop_end,
                armed = loop ~= nil, pending = false, need_rearm = loop == nil, ticks = 0,
            }
            start_timer()
            return
        end
    end
    cleanup_files()
    restore_crossfade()
    clear_prev()
end
adopt_or_sweep()

if plugin.register_list_item then
    local icon = { icon = "Metronome.png" }
    local function open() open_menu(false) end
    -- More only. Its four plugin rows are shared, so fall back to Playback &
    -- Controls when More is full or missing rather than leave no way in.
    local in_more = plugin.has_capability and plugin.has_capability("ui.more_menu") and
        pcall(plugin.register_list_item, "more", tr("Metronome"), open, icon)
    if not in_more then plugin.register_list_item("playback", tr("Metronome"), open, icon) end
end
