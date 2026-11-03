plugin.define({
    id = "compas.track_inspector",
    name = "Track Inspector",
    version = "1.6.0",
    api_min = 19,
})

local T = {
    de = {
        [" · bypassed"] = " · umgangen",
        [" · normal"] = " · normal",
        [" · stored; overridden by MSEB"] = " · gespeichert; durch MSEB überschrieben",
        [" · time stretch active"] = " · Time-Stretch aktiv",
        ["%d bytes"] = "%d Bytes",
        ["%d channels"] = "%d Kanäle",
        ["%d kbps"] = "%d kbit/s",
        ["%d%% strength"] = "%d%% Stärke",
        ["%d-bit"] = "%d-Bit",
        ["%d:%02d (%d s)"] = "%d:%02d (%d s)",
        ["%s elapsed"] = "%s vergangen",
        ["%s · format unavailable"] = "%s · Format nicht verfügbar",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (Mono)",
        ["2 (Stereo)"] = "2 (Stereo)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (Komprimiert: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (Little-Endian PCM)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Aktives Ausgabeformat: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Aktives Ausgabeformat: Nicht verfügbar bei inaktivem Ausgang",
        ["Album artist: %s"] = "Albumkünstler: %s",
        ["Album: %s"] = "Album: %s",
        ["An EQ band's enabled state is unknown."] = "Aktivierungsstatus eines EQ-Bands ist unbekannt.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Ein aktives EQ-Band hat einen unbekannten Filtertyp; Wirkung unklar.",
        ["An enabled EQ filter has unknown gain."] = "Ein aktiver EQ-Filter hat eine unbekannte Verstärkung.",
        ["Applied ReplayGain: %s"] = "Angewendetes ReplayGain: %s",
        ["Artist: %s"] = "Künstler: %s",
        ["Audio engine format: %s · %s"] = "Audio-Engine-Format: %s · %s",
        ["Audio engine format: Unknown"] = "Audio-Engine-Format: Unbekannt",
        ["Audio engine is idle; no active playback stream to inspect."] = "Audio-Engine ist inaktiv; kein aktiver Wiedergabe-Stream vorhanden.",
        ["Audio engine output: %s · %s"] = "Audio-Engine-Ausgabe: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Audio-Engine-Resampling: %s Quelle auf %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Audioformat: Unbekannt (kein aktiver Decoder-Snapshot)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Band %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Bittiefe: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Bittiefe erweitert: Quelle %d-Bit -> Ausgabe %d-Bit (mögliches Padding oder Dither; Bit-Transparenz ungeprüft).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Bittiefen-Kürzung: Quelle %d-Bit -> Ausgabe %d-Bit (Dithering oder Genauigkeitsverlust).",
        ["Bitrate: %s"] = "Bitrate: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth kann Audio verändern",
        ["Bluetooth codec: %s"] = "Bluetooth-Codec: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "Bluetooth-Codierung kann das Audio verändern (%s); die Ausgabe des Empfängers ist hier nicht sichtbar.",
        ["Bypassed"] = "Umgangen",
        ["Change or unknown detail"] = "Änderung oder unbekanntes Detail",
        ["Changes detected or information unavailable"] = "Änderungen erkannt oder Information nicht verfügbar",
        ["Changes to this setting take effect with the next track."] = "Änderungen werden mit dem nächsten Titel wirksam.",
        ["Channels: %s"] = "Kanäle: %s",
        ["Codec: %s"] = "Codec: %s",
        ["Could not open file picker. Please try again."] = "Dateiauswahl konnte nicht geöffnet werden. Bitte erneut versuchen.",
        ["Could not open file picker: %s"] = "Dateiauswahl konnte nicht geöffnet werden: %s",
        ["Could not open file: %s"] = "Datei konnte nicht geöffnet werden: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade ist aktiv; der Player meldet nicht, ob Tracks gerade gemischt werden.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Crossfade-Einstellung: %s · Mischzustand nicht offengelegt",
        ["Crossfeed angle: %.1f°"] = "Crossfeed-Winkel: %.1f°",
        ["Crossfeed delay: none"] = "Crossfeed-Verzögerung: Keine",
        ["DSD audio"] = "DSD-Audio",
        ["DSD carrier rate: %s · expected %s"] = "DSD-Trägerrate: %s · erwartet %s",
        ["DSD converted to PCM at %s"] = "DSD konvertiert in PCM mit %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD wird in PCM gewandelt; nachfolgende Klangeinstellungen beeinflussen die Wiedergabe.",
        ["DSD playback: converted to PCM"] = "DSD-Wiedergabe: in PCM konvertiert",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "DSD-Stream in PCM konvertiert (Dezimation aktiv; kein natives DSD-Direct-Passthrough).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "DSD-over-PCM-Träger ist aktiv; PCM-Verarbeitung wird umgangen",
        ["DSD-over-PCM carrier: %s"] = "DSD-over-PCM-Träger: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "DSD-over-PCM-Wiedergabe umgeht den Equalizer und andere PCM-Verarbeitung.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "DSD-zu-PCM-Dezimation aktiv: DSD-Bitstrom wird in PCM gewandelt und durchläuft PCM-DSP-Filter.",
        ["Detail: %s"] = "Detail: %s",
        ["Disabled"] = "Deaktiviert",
        ["DoP active but codec is not DSD."] = "DoP aktiv, aber Codec ist nicht DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "DoP-Trägertiefe unzureichend: %s erhalten (24-Bit-Träger erforderlich).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "DoP-Träger-Framing: %s 1-Bit DSD in %s %s PCM-Frames gepackt; PCM-DSP-Kette umgangen.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "DoP-Trägerrate unpassend: Erwartet %.1f kHz für DSD, erhalten %s.",
        ["Duration: %s"] = "Dauer: %s",
        ["EQ bands configuration missing."] = "EQ-Band-Konfiguration fehlt.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Digitaler EQ-Preamp aktiv: %+.2f dB.",
        ["EQ preamp gain is unknown or invalid."] = "EQ-Preamp-Verstärkung ist unbekannt oder ungültig.",
        ["Enabled equalizer bands: %d / 10"] = "Aktive EQ-Bänder: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Aktive EQ-Bänder: Nicht vollständig gemeldet",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Codierung: Komprimiertes Audio · Verlustfreiheit nicht durch Header bestätigt",
        ["Encoding: Lossless compressed audio"] = "Codierung: Verlustfrei komprimiertes Audio",
        ["Equalizer bands"] = "Equalizer-Bänder",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "Equalizer-Bypass überspringt auch Preamp, Stereobreite, Crossfeed und Filter.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Equalizer-Bypass aktiv; Preamp, Stereobreite und Filter übersprungen. Crossfeed bleibt unabhängig.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Equalizer-Bypass aktiv; Preamp, Stereobreite, Crossfeed und Bandfilter werden übersprungen.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "Equalizer-Bypass überspringt Preamp, Stereobreite und Filter; Crossfeed bleibt unabhängig.",
        ["Equalizer details unavailable"] = "Equalizer-Details nicht verfügbar",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Equalizer-Status nicht verfügbar; flacher DSP-Weg kann nicht geprüft werden.",
        ["Equalizer: %s"] = "Equalizer: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Geschätzte Container-Bitrate: %s (inkl. Overhead/Metadaten)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Datei-Header: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Dateiauswahl nicht verfügbar. Firmware aktualisieren, um lokale Dateien zu prüfen.",
        ["File size: %s"] = "Dateigröße: %s",
        ["File: %s"] = "Datei: %s",
        ["Final device format: Not available from the player"] = "Endgültiges Geräteformat: Vom Player nicht verfügbar",
        ["Final device format: Not reported by the player"] = "Endgültiges Geräteformat: Vom Player nicht gemeldet",
        ["Format: %s"] = "Format: %s",
        ["Gapless playback: %s"] = "Gapless-Wiedergabe: %s",
        ["Genre: %s"] = "Genre: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Header-Parsing-Status: Nicht unterstützt / Fehlerhaft",
        ["Headphone crossfeed is active at %.2f strength."] = "Kopfhörer-Crossfeed ist mit Stärke %.2f aktiv.",
        ["Headphone crossfeed state is unknown."] = "Kopfhörer-Crossfeed-Status ist unbekannt.",
        ["Headphone crossfeed: %s%s"] = "Kopfhörer-Crossfeed: %s%s",
        ["High shelf"] = "High-Shelf",
        ["In order"] = "Der Reihe nach",
        ["Inspect a file"] = "Datei prüfen",
        ["Inspector settings"] = "Inspector-Einstellungen",
        ["Invalid file path"] = "Ungültiger Dateipfad",
        ["Length: %s · %s"] = "Länge: %s · %s",
        ["Live or unknown length"] = "Live oder unbekannte Länge",
        ["Local file"] = "Lokale Datei",
        ["Local file details"] = "Lokale Dateidetails",
        ["Local output format: %s · %s"] = "Lokales Ausgabeformat: %s · %s",
        ["Lossless compression"] = "Verlustfreie Kompression",
        ["Lossy"] = "Verlustbehaftet",
        ["Low shelf"] = "Low-Shelf",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "Fehlerhaftes AIFF: ungültige Audioparameter",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "Fehlerhaftes AIFF: COMM-Chunk fehlt oder ist verkürzt",
        ["Malformed FLAC: STREAMINFO block length too small"] = "Fehlerhaftes FLAC: STREAMINFO-Blocklänge zu klein",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "Fehlerhaftes FLAC: Erster Metadatenblock muss STREAMINFO sein",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "Fehlerhaftes FLAC: ungültige Audioparameter in STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "Fehlerhaftes WAV: ungültige Audioparameter",
        ["Malformed WAV: missing or truncated fmt chunk"] = "Fehlerhaftes WAV: fmt-Chunk fehlt oder ist verkürzt",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Manuelle EQ-Bänder, Preamp und Stereobreite werden durch aktives Standard-MSEB überschrieben.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Mono",
        ["Native DoP bypasses stock MSEB during playback."] = "Natives DoP umgeht Standard-MSEB während der Wiedergabe.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "Nativer DoP-Hardware-Stream umgeht PCM-Equalizer, Standard-MSEB, Stereobreite und Software-Lautstärke.",
        ["Neutral"] = "Neutral",
        ["No"] = "Nein",
        ["No Active Playback"] = "Keine aktive Wiedergabe",
        ["No changes detected (wired DoP candidate)"] = "Keine Änderungen erkannt (kabelgebundener DoP-Kandidat)",
        ["No changes detected (wired PCM candidate)"] = "Keine Änderungen erkannt (kabelgebundener PCM-Kandidat)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "Keine Änderungen in beobachtbaren Wiedergabestufen erkannt. Hardware-Zertifizierung aus diesem Snapshot nicht möglich.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "Keine Änderungen in beobachtbaren Wiedergabestufen erkannt. Dies ist ein Kandidat, kein Beweis für physische Hardwareausgabe.",
        ["Not classified by this inspector"] = "Nicht von diesem Inspector klassifiziert",
        ["Not reported"] = "Nicht gemeldet",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Hinweis: Prüfung auf lokale WAV-, FLAC-, AIFF-Header beschränkt. Andere Formate werden nicht aus Dateiendung geraten.",
        ["One-bit DSD audio"] = "1-Bit-DSD-Audio",
        ["Opus"] = "Opus",
        ["Other observation"] = "Weitere Beobachtung",
        ["Output active: %s"] = "Ausgang aktiv: %s",
        ["Output bit depth is unknown or invalid."] = "Ausgabe-Bittiefe ist unbekannt oder ungültig.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Bittiefe weicht ab: Audio-Engine %d-Bit -> gemeldet %d-Bit.",
        ["Output details"] = "Ausgabedetails",
        ["Output details unavailable"] = "Ausgabedetails nicht verfügbar",
        ["Output device"] = "Ausgabegerät",
        ["Output is inactive"] = "Ausgang ist inaktiv",
        ["Output is inactive or its state is unknown."] = "Ausgang ist inaktiv oder Zustand unbekannt.",
        ["Output rate matches engine: %s"] = "Ausgaberate entspricht Engine: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Ausgabe ist USB-DAC: externe USB-Endpunkt-Wandlung und Hardware-Mixer sind ungeprüft; PCM-Übereinstimmung beweist keine Bit-Perfektion.",
        ["Output route: %s · %s"] = "Ausgabeweg: %s · %s",
        ["Output sample rate is unknown or invalid."] = "Ausgabe-Abtastrate ist unbekannt oder ungültig.",
        ["Output sink DoP flag is not active."] = "DoP-Flag des Ausgabegeräts ist nicht aktiv.",
        ["PCM audio"] = "PCM-Audio",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "Parametrischer EQ hat %d aktive Bänder; Filter und Peak-Schutz können Samples auch bei flachem Verlauf beeinflussen.",
        ["Path is outside SD root"] = "Pfad liegt außerhalb der SD-Karte",
        ["Paused"] = "Pausiert",
        ["Peaking"] = "Peaking",
        ["Per album"] = "Pro Album",
        ["Per track"] = "Pro Titel",
        ["Play mode: %s"] = "Wiedergabemodus: %s",
        ["Playback details"] = "Wiedergabedetails",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Wiedergabegeschwindigkeit geändert: %.4fx (Time-Stretching-DSP aktiv).",
        ["Playback speed state unavailable or invalid."] = "Wiedergabegeschwindigkeit-Status nicht verfügbar oder ungültig.",
        ["Playback speed: %s"] = "Wiedergabegeschwindigkeit: %s",
        ["Playback: %s · %s"] = "Wiedergabe: %s · %s",
        ["Player output rate: %s · %s"] = "Player-Ausgaberate: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Player-Lautstärke: %s · unabhängig von Software-Verstärkung",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "Gemeldete Ausgaberate weicht von Quelle ab: %d Hz -> %d Hz.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "Gemeldete Ausgaberate weicht vom DoP-Träger ab: %d Hz vs %.0f Hz.",
        ["Please close the other file picker and try again."] = "Bitte andere Dateiauswahl schließen und erneut versuchen.",
        ["Preamp gain: %s%s"] = "Preamp-Verstärkung: %s%s",
        ["Refresh output details"] = "Ausgabedetails aktualisieren",
        ["Refresh playback details"] = "Wiedergabedetails aktualisieren",
        ["Refresh signal path check"] = "Signalwegprüfung aktualisieren",
        ["Refresh sound details"] = "Klangdetails aktualisieren",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Remote-Streams unterstützen keine direkte Header-Prüfung; Format stammt vom Decoder",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (Lautstärkeanpassung): %s · aktueller Titel angewendet: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "ReplayGain-Skalierung angewendet: %+.2f dB.",
        ["ReplayGain state unavailable."] = "ReplayGain-Status nicht verfügbar.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain wurde als aktiv gemeldet, aber Pegelwert ist unbekannt.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Resampling aktiv: Quelle %d Hz -> Ausgabe %d Hz.",
        ["Result: %s"] = "Ergebnis: %s",
        ["Route: %s"] = "Ausgabeweg: %s",
        ["Sample Rate: %s"] = "Abtastrate: %s",
        ["Show full file paths"] = "Vollständige Dateipfade anzeigen",
        ["Show music library tags"] = "Musikbibliothek-Tags anzeigen",
        ["Signal check"] = "Signalprüfung",
        ["Software audio gain: %s"] = "Software-Audioverstärkung: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Software-Lautstärke bei Unity-Gain (1.00 / 0.0 dB - keine digitale PCM-Skalierung).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Software-Lautstärke skaliert: %.6fx (%s digitale Anpassung).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Software-Lautstärkestatus nicht verfügbar; Unity-Gain kann nicht geprüft werden.",
        ["Sound processing"] = "Klangverarbeitung",
        ["Source and audio engine rates match: %s"] = "Raten von Quelle und Audio-Engine stimmen überein: %s",
        ["Source audio: %s · %s · %s"] = "Quellaudio: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "Quell-Bittiefe ist unbekannt oder verlustbehaftet (keine native PCM-Tiefe).",
        ["Source channels count is unknown or invalid."] = "Quell-Kanalanzahl ist unbekannt oder ungültig.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "Quell-Codec ist verlustbehaftet (%s): Verlustbehaftete Dekodierung kann kein Bit-Perfect garantieren.",
        ["Source codec is unknown."] = "Quell-Codec ist unbekannt.",
        ["Source quality: %s"] = "Quellqualität: %s",
        ["Source sample rate is unknown or invalid."] = "Quell-Abtastrate ist unbekannt oder ungültig.",
        ["Source: %s · %s"] = "Quelle: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Wiedergabe starten/fortsetzen, um das Live-Format des Decoders zu prüfen.",
        ["State unknown"] = "Status unbekannt",
        ["Stereo width is unknown or invalid."] = "Stereobreite ist unbekannt oder ungültig.",
        ["Stereo width processing is active: %.4f."] = "Stereobreiten-Verarbeitung ist aktiv: %.4f.",
        ["Stereo width: %s%s"] = "Stereobreite: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "Standard-MSEB überschreibt manuelle EQ-Bänder, Preamp und Stereobreite; Crossfeed bleibt unabhängig.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "Standard-MSEB-Verarbeitung ist mit nicht-neutralen Einstellungen aktiv.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Standard-MSEB-Werte unvollständig/ungültig; neutraler PCM-Weg kann nicht geprüft werden.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Standard-MSEB-Status nicht verfügbar; PCM-Signalweg kann nicht geprüft werden.",
        ["Stock MSEB: %s"] = "Standard-MSEB: %s",
        ["Stream name or endpoint: %s"] = "Stream-Name oder Endpunkt: %s",
        ["The active output route is unknown."] = "Der aktive Ausgabeweg ist unbekannt.",
        ["The external device's final conversion and output format are not visible here."] = "Endgültige Wandlung und Ausgabeformat des externen Geräts sind hier nicht sichtbar.",
        ["The full equalizer band state is unavailable."] = "Vollständiger EQ-Band-Status ist nicht verfügbar.",
        ["The local output format is not reported by the player."] = "Das lokale Ausgabeformat wird vom Player nicht gemeldet.",
        ["The player cannot compare the engine and output sample rates."] = "Der Player kann Engine- und Ausgabe-Abtastraten nicht vergleichen.",
        ["The player reports different engine and output sample rates."] = "Der Player meldet unterschiedliche Raten für Engine und Ausgabe.",
        ["The remote device's final output format is not visible here."] = "Das endgültige Ausgabeformat des Remote-Geräts ist hier nicht sichtbar.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "Der Snapshot zeigt Änderungen oder bietet nicht genug Information für einen unveränderten Signalweg.",
        ["This firmware does not expose a live equalizer snapshot."] = "Diese Firmware stellt keinen Live-Equalizer-Snapshot bereit.",
        ["This firmware does not expose a live output snapshot."] = "Diese Firmware stellt keinen Live-Ausgabe-Snapshot bereit.",
        ["Title: %s"] = "Titel: %s",
        ["Track Inspector"] = "Track Inspector",
        ["Track and file details"] = "Titel- und Dateidetails",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Verkürzter FLAC STREAMINFO-Header (weniger als 42 Bytes)",
        ["Truncated file header (less than 12 bytes)"] = "Verkürzter Datei-Header (weniger als 12 Bytes)",
        ["Type: Uncompressed PCM"] = "Typ: Unkomprimiertes PCM",
        ["USB audio"] = "USB-Audio",
        ["USB audio output is selected"] = "USB-Audioausgabe ist ausgewählt",
        ["USB output cannot be fully checked"] = "USB-Ausgabe kann nicht vollständig geprüft werden",
        ["Uncompressed PCM"] = "Unkomprimiertes PCM",
        ["Unknown"] = "Unbekannt",
        ["Unknown (mode not reported)"] = "Unbekannt (Modus nicht gemeldet)",
        ["Unknown / Negotiating"] = "Unbekannt / Verhandlung",
        ["Unknown / not reported"] = "Unbekannt / nicht gemeldet",
        ["Unknown filter"] = "Unbekannter Filter",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Unbekanntes Header-Format (Prüfung auf WAV, FLAC, AIFF beschränkt; Formate werden nicht aus Dateiendung abgeleitet)",
        ["Unknown route"] = "Unbekannter Ausgabeweg",
        ["View all equalizer bands"] = "Alle EQ-Bänder anzeigen",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (Komprimiert erweiterbar: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (Komprimiert: Format 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (Erweiterbares Float)",
        ["WAV (Extensible PCM)"] = "WAV (Erweiterbares PCM)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (PCM-Ganzzahl)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "WavPack-Modus (Lossless/Hybrid) und Korrekturdatei-Status nicht gemeldet.",
        ["Wider or narrower stereo"] = "Breiteres oder schmaleres Stereo",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Kabelausgang",
        ["Wired output is selected"] = "Kabelausgang ist ausgewählt",
        ["Yes"] = "Ja",
        ["active"] = "aktiv",
        ["amount unknown"] = "Wert unbekannt",
        ["differs from the engine"] = "weicht von Engine ab",
        ["forward-only"] = "nur vorwärts",
        ["gain unknown"] = "Verstärkung unbekannt",
        ["matches the engine"] = "entspricht der Engine",
        ["seek status unknown"] = "Spulstatus unbekannt",
        ["seekable"] = "spulbar",
        ["standby"] = "Standby",
        ["status unknown"] = "Status unbekannt",
        ["unity (0 dB)"] = "Unity (0 dB)",
    },
    es = {
        [" · bypassed"] = " · omitido",
        [" · normal"] = " · normal",
        [" · stored; overridden by MSEB"] = " · guardado; anulado por MSEB",
        [" · time stretch active"] = " · estiramiento temporal activo",
        ["%d bytes"] = "%d bytes",
        ["%d channels"] = "%d canales",
        ["%d kbps"] = "%d kbps",
        ["%d%% strength"] = "%d%% intensidad",
        ["%d-bit"] = "%d bits",
        ["%d:%02d (%d s)"] = "%d:%02d (%d s)",
        ["%s elapsed"] = "%s transcurrido",
        ["%s · format unavailable"] = "%s · formato no disponible",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (Mono)",
        ["2 (Stereo)"] = "2 (Estéreo)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (Comprimido: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (PCM Little-Endian)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Formato de salida activo: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Formato de salida activo: No disponible mientras la salida esté inactiva",
        ["Album artist: %s"] = "Artista del álbum: %s",
        ["Album: %s"] = "Álbum: %s",
        ["An EQ band's enabled state is unknown."] = "El estado de activación de una banda de EQ es desconocido.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Una banda de EQ activa tiene un tipo de filtro no reconocido; su efecto es desconocido.",
        ["An enabled EQ filter has unknown gain."] = "Un filtro de EQ activado tiene ganancia desconocida.",
        ["Applied ReplayGain: %s"] = "ReplayGain aplicado: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Audio engine format: %s · %s"] = "Formato del motor de audio: %s · %s",
        ["Audio engine format: Unknown"] = "Formato del motor de audio: Desconocido",
        ["Audio engine is idle; no active playback stream to inspect."] = "El motor de audio está inactivo; no hay flujo de reproducción que inspeccionar.",
        ["Audio engine output: %s · %s"] = "Salida del motor de audio: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Remuestreo del motor de audio: origen %s a %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Formato de audio: Desconocido (sin captura activa del decodificador)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Banda %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Profundidad de bits: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Profundidad de bits ampliada: origen %d bits -> salida %d bits (posible relleno o dither; transparencia no verificada).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Truncamiento de bits: origen %d bits -> salida %d bits (dithering o pérdida de precisión).",
        ["Bitrate: %s"] = "Tasa de bits: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth puede alterar el audio",
        ["Bluetooth codec: %s"] = "Códec Bluetooth: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "La codificación Bluetooth puede alterar el audio (%s); la salida final del receptor no es visible aquí.",
        ["Bypassed"] = "Omitido",
        ["Change or unknown detail"] = "Cambio o detalle desconocido",
        ["Changes detected or information unavailable"] = "Cambios detectados o información no disponible",
        ["Changes to this setting take effect with the next track."] = "Los cambios se aplicarán con la siguiente pista.",
        ["Channels: %s"] = "Canales: %s",
        ["Codec: %s"] = "Códec: %s",
        ["Could not open file picker. Please try again."] = "No se pudo abrir el selector de archivos. Inténtalo de nuevo.",
        ["Could not open file picker: %s"] = "No se pudo abrir el selector de archivos: %s",
        ["Could not open file: %s"] = "No se pudo abrir el archivo: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade está activado; el reproductor no informa si las pistas se están mezclando ahora.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Ajuste de crossfade: %s · el estado de mezcla no se expone",
        ["Crossfeed angle: %.1f°"] = "Ángulo de crossfeed: %.1f°",
        ["Crossfeed delay: none"] = "Retardo de crossfeed: ninguno",
        ["DSD audio"] = "Audio DSD",
        ["DSD carrier rate: %s · expected %s"] = "Frecuencia portadora DSD: %s · esperada %s",
        ["DSD converted to PCM at %s"] = "DSD convertido a PCM a %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD se convierte a PCM; los ajustes de sonido inferiores pueden afectar la reproducción.",
        ["DSD playback: converted to PCM"] = "Reproducción DSD: convertida a PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "Flujo DSD convertido a PCM (diezmado activo; no es paso directo DSD nativo).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "La portadora DSD-over-PCM está activa; el procesamiento PCM se omite",
        ["DSD-over-PCM carrier: %s"] = "Portadora DSD-over-PCM: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "La reproducción DSD-over-PCM omite el ecualizador y demás procesamiento PCM.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "Diezmado DSD a PCM activo: el flujo DSD se convierte a PCM y se somete a filtrado DSP PCM.",
        ["Detail: %s"] = "Detalle: %s",
        ["Disabled"] = "Desactivado",
        ["DoP active but codec is not DSD."] = "DoP activo pero el códec no es DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "Profundidad de portadora DoP insuficiente: se obtuvo %s (requiere portadora de 24 bits).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "Empaquetado DoP: flujo DSD de 1 bit en %s empaquetado en tramas PCM %s %s; cadena DSP PCM omitida.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "Frecuencia portadora DoP no coincide: se esperaba %.1f kHz para DSD, se obtuvo %s.",
        ["Duration: %s"] = "Duración: %s",
        ["EQ bands configuration missing."] = "Falta la configuración de las bandas de EQ.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Ganancia de preamp digital EQ activa: %+.2f dB.",
        ["EQ preamp gain is unknown or invalid."] = "La ganancia del preamplificador EQ es desconocida o no válida.",
        ["Enabled equalizer bands: %d / 10"] = "Bandas de EQ activadas: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Bandas de EQ activadas: No reportadas por completo",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Codificación: Audio comprimido · no confirmado sin pérdidas por la cabecera",
        ["Encoding: Lossless compressed audio"] = "Codificación: Audio comprimido sin pérdidas",
        ["Equalizer bands"] = "Bandas del ecualizador",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "El bypass de EQ también omite preamp, ancho estéreo, crossfeed y filtros.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Bypass de EQ activo; preamp, ancho estéreo y filtros omitidos. Crossfeed sigue independiente.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Bypass de EQ activo; se omiten preamp, ancho estéreo, crossfeed y filtros.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "El bypass de EQ omite preamp, ancho estéreo y filtros; crossfeed sigue independiente.",
        ["Equalizer details unavailable"] = "Detalles del ecualizador no disponibles",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Estado del ecualizador no disponible; no se puede verificar una ruta DSP plana.",
        ["Equalizer: %s"] = "Ecualizador: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Tasa de bits estimada del contenedor: %s (incluye contenedor y metadatos)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Cabecera de archivo: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Selector de archivos no disponible. Actualiza el firmware para inspeccionar un archivo.",
        ["File size: %s"] = "Tamaño del archivo: %s",
        ["File: %s"] = "Archivo: %s",
        ["Final device format: Not available from the player"] = "Formato final del dispositivo: No disponible desde el reproductor",
        ["Final device format: Not reported by the player"] = "Formato final del dispositivo: No reportado por el reproductor",
        ["Format: %s"] = "Formato: %s",
        ["Gapless playback: %s"] = "Reproducción continua (gapless): %s",
        ["Genre: %s"] = "Género: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Estado de análisis de cabecera: No compatible / Mal formado",
        ["Headphone crossfeed is active at %.2f strength."] = "Crossfeed para audífonos activo con intensidad %.2f.",
        ["Headphone crossfeed state is unknown."] = "El estado de crossfeed para audífonos es desconocido.",
        ["Headphone crossfeed: %s%s"] = "Crossfeed de audífonos: %s%s",
        ["High shelf"] = "Paso alto (high shelf)",
        ["In order"] = "En orden",
        ["Inspect a file"] = "Inspeccionar un archivo",
        ["Inspector settings"] = "Ajustes del inspector",
        ["Invalid file path"] = "Ruta de archivo no válida",
        ["Length: %s · %s"] = "Duración: %s · %s",
        ["Live or unknown length"] = "En vivo o duración desconocida",
        ["Local file"] = "Archivo local",
        ["Local file details"] = "Detalles del archivo local",
        ["Local output format: %s · %s"] = "Formato de salida local: %s · %s",
        ["Lossless compression"] = "Compresión sin pérdidas",
        ["Lossy"] = "Con pérdidas",
        ["Low shelf"] = "Paso bajo (low shelf)",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "AIFF mal formado: parámetros de audio no válidos",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "AIFF mal formado: falta fragmento COMM o está truncado",
        ["Malformed FLAC: STREAMINFO block length too small"] = "FLAC mal formado: longitud de bloque STREAMINFO demasiado pequeña",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "FLAC mal formado: el primer bloque de metadatos debe ser STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "FLAC mal formado: parámetros de audio no válidos en STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "WAV mal formado: parámetros de audio no válidos",
        ["Malformed WAV: missing or truncated fmt chunk"] = "WAV mal formado: falta fragmento fmt o está truncado",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Las bandas de EQ manual, preamp y ancho estéreo son anuladas por MSEB mientras esté activado.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Mono",
        ["Native DoP bypasses stock MSEB during playback."] = "DoP nativo omite MSEB durante la reproducción.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "El flujo DoP nativo por hardware omite el ecualizador PCM, MSEB, ancho estéreo y volumen por software.",
        ["Neutral"] = "Neutro",
        ["No"] = "No",
        ["No Active Playback"] = "Sin reproducción activa",
        ["No changes detected (wired DoP candidate)"] = "Sin cambios detectados (candidato DoP cableado)",
        ["No changes detected (wired PCM candidate)"] = "Sin cambios detectados (candidato PCM cableado)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "Sin cambios en las etapas observables. La certificación física de hardware no está disponible en esta captura.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "Sin cambios en las etapas observables. Es un candidato, no una prueba de la salida física del hardware.",
        ["Not classified by this inspector"] = "No clasificado por este inspector",
        ["Not reported"] = "No reportado",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Nota: Inspección limitada a cabeceras locales WAV, FLAC, AIFF. Otros formatos se indican como desconocidos sin inferir por extensión.",
        ["One-bit DSD audio"] = "Audio DSD de 1 bit",
        ["Opus"] = "Opus",
        ["Other observation"] = "Otra observación",
        ["Output active: %s"] = "Salida activa: %s",
        ["Output bit depth is unknown or invalid."] = "La profundidad de bits de salida es desconocida o no válida.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "La profundidad difiere: motor de audio %d bits -> salida reportada %d bits.",
        ["Output details"] = "Detalles de salida",
        ["Output details unavailable"] = "Detalles de salida no disponibles",
        ["Output device"] = "Dispositivo de salida",
        ["Output is inactive"] = "La salida está inactiva",
        ["Output is inactive or its state is unknown."] = "La salida está inactiva o su estado es desconocido.",
        ["Output rate matches engine: %s"] = "Frecuencia de salida coincide con el motor: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Salida a DAC USB: conversión en punto final y mezclador de hardware sin verificar; coincidir en PCM no demuestra salida bit-perfect.",
        ["Output route: %s · %s"] = "Ruta de salida: %s · %s",
        ["Output sample rate is unknown or invalid."] = "La frecuencia de muestreo de salida es desconocida o no válida.",
        ["Output sink DoP flag is not active."] = "La bandera DoP del destino de salida no está activa.",
        ["PCM audio"] = "Audio PCM",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "El EQ paramétrico tiene %d banda(s) activada(s); el filtrado y la protección de picos pueden afectar las muestras.",
        ["Path is outside SD root"] = "La ruta está fuera de la raíz SD",
        ["Paused"] = "En pausa",
        ["Peaking"] = "Campana (peaking)",
        ["Per album"] = "Por álbum",
        ["Per track"] = "Por pista",
        ["Play mode: %s"] = "Modo de reproducción: %s",
        ["Playback details"] = "Detalles de reproducción",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Velocidad de reproducción modificada: %.4fx (DSP de estiramiento temporal activo).",
        ["Playback speed state unavailable or invalid."] = "Estado de velocidad de reproducción no disponible o no válido.",
        ["Playback speed: %s"] = "Velocidad de reproducción: %s",
        ["Playback: %s · %s"] = "Reproducción: %s · %s",
        ["Player output rate: %s · %s"] = "Frecuencia de salida del reproductor: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Volumen del reproductor: %s · independiente de la ganancia por software",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "La frecuencia de salida reportada difiere del origen: %d Hz -> %d Hz.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "La frecuencia de salida reportada no coincide con la portadora DoP: %d Hz frente a %.0f Hz.",
        ["Please close the other file picker and try again."] = "Cierra el otro selector de archivos e inténtalo de nuevo.",
        ["Preamp gain: %s%s"] = "Ganancia de preamp: %s%s",
        ["Refresh output details"] = "Refrescar detalles de salida",
        ["Refresh playback details"] = "Refrescar detalles de reproducción",
        ["Refresh signal path check"] = "Refrescar comprobación de ruta de señal",
        ["Refresh sound details"] = "Refrescar detalles de sonido",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Los flujos remotos no admiten inspección directa de cabecera; formato proporcionado por el decodificador",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (ajuste de volumen): %s · aplicado en pista actual: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "Escalado ReplayGain aplicado: %+.2f dB.",
        ["ReplayGain state unavailable."] = "Estado de ReplayGain no disponible.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain se reportó como aplicado, pero su ganancia es desconocida.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Remuestreo activo: origen %d Hz -> salida %d Hz.",
        ["Result: %s"] = "Resultado: %s",
        ["Route: %s"] = "Ruta: %s",
        ["Sample Rate: %s"] = "Frecuencia de muestreo: %s",
        ["Show full file paths"] = "Mostrar rutas de archivo completas",
        ["Show music library tags"] = "Mostrar etiquetas de la biblioteca",
        ["Signal check"] = "Comprobación de señal",
        ["Software audio gain: %s"] = "Ganancia de audio por software: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Volumen por software en ganancia unitaria (1.00 / 0.0 dB; sin escalado digital PCM).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Escalado de volumen por software activo: %.6fx (%s de modificación digital).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Estado de volumen por software no disponible; no se puede verificar ganancia unitaria.",
        ["Sound processing"] = "Procesamiento de sonido",
        ["Source and audio engine rates match: %s"] = "Frecuencias de origen y motor coinciden: %s",
        ["Source audio: %s · %s · %s"] = "Audio de origen: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "La profundidad de bits de origen es desconocida o con pérdidas (sin profundidad PCM original).",
        ["Source channels count is unknown or invalid."] = "El número de canales de origen es desconocido o no válido.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "El códec de origen es con pérdidas (%s): la decodificación no puede certificar reproducción bit-perfect.",
        ["Source codec is unknown."] = "El códec de origen es desconocido.",
        ["Source quality: %s"] = "Calidad de origen: %s",
        ["Source sample rate is unknown or invalid."] = "La frecuencia de muestreo de origen es desconocida o no válida.",
        ["Source: %s · %s"] = "Origen: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Inicia o reanuda la reproducción para inspeccionar el formato del decodificador.",
        ["State unknown"] = "Estado desconocido",
        ["Stereo width is unknown or invalid."] = "El ancho estéreo es desconocido o no válido.",
        ["Stereo width processing is active: %.4f."] = "Procesamiento de ancho estéreo activo: %.4f.",
        ["Stereo width: %s%s"] = "Ancho estéreo: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "MSEB anula las bandas de EQ manual, preamp y ancho estéreo; crossfeed sigue independiente.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "El procesamiento MSEB está activado con ajustes no neutros.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Ajustes de MSEB incompletos o no válidos; no se puede verificar una ruta PCM neutra.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Estado de MSEB no disponible; no se puede verificar la ruta de procesamiento PCM.",
        ["Stock MSEB: %s"] = "MSEB integrado: %s",
        ["Stream name or endpoint: %s"] = "Nombre o endpoint del flujo: %s",
        ["The active output route is unknown."] = "La ruta de salida activa es desconocida.",
        ["The external device's final conversion and output format are not visible here."] = "La conversión y formato final del dispositivo externo no son visibles aquí.",
        ["The full equalizer band state is unavailable."] = "El estado completo de las bandas del ecualizador no está disponible.",
        ["The local output format is not reported by the player."] = "El reproductor no reporta el formato de salida local.",
        ["The player cannot compare the engine and output sample rates."] = "El reproductor no puede comparar las frecuencias de motor y salida.",
        ["The player reports different engine and output sample rates."] = "El reproductor reporta frecuencias de muestreo distintas entre motor y salida.",
        ["The remote device's final output format is not visible here."] = "El formato de salida final del dispositivo remoto no es visible aquí.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "La captura muestra cambios o carece de información para verificar una ruta de señal inalterada.",
        ["This firmware does not expose a live equalizer snapshot."] = "Este firmware no expone una captura del ecualizador en vivo.",
        ["This firmware does not expose a live output snapshot."] = "Este firmware no expone una captura de salida en vivo.",
        ["Title: %s"] = "Título: %s",
        ["Track Inspector"] = "Inspector de pistas",
        ["Track and file details"] = "Detalles de pista y archivo",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Cabecera STREAMINFO de FLAC truncada (menos de 42 bytes)",
        ["Truncated file header (less than 12 bytes)"] = "Cabecera de archivo truncada (menos de 12 bytes)",
        ["Type: Uncompressed PCM"] = "Tipo: PCM sin comprimir",
        ["USB audio"] = "Audio USB",
        ["USB audio output is selected"] = "Salida de audio USB seleccionada",
        ["USB output cannot be fully checked"] = "La salida USB no se puede comprobar por completo",
        ["Uncompressed PCM"] = "PCM sin comprimir",
        ["Unknown"] = "Desconocido",
        ["Unknown (mode not reported)"] = "Desconocido (modo no reportado)",
        ["Unknown / Negotiating"] = "Desconocido / Negociando",
        ["Unknown / not reported"] = "Desconocido / no reportado",
        ["Unknown filter"] = "Filtro desconocido",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Formato de cabecera desconocido (inspección limitada a WAV, FLAC, AIFF; no se deduce de la extensión)",
        ["Unknown route"] = "Ruta desconocida",
        ["View all equalizer bands"] = "Ver todas las bandas del ecualizador",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (Comprimido extensible: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (Comprimido: formato 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (Float extensible)",
        ["WAV (Extensible PCM)"] = "WAV (PCM extensible)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (PCM entero)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "Modo sin pérdida o híbrido de WavPack y archivo de corrección no reportados.",
        ["Wider or narrower stereo"] = "Estéreo ampliado o reducido",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Salida cableada",
        ["Wired output is selected"] = "Salida cableada seleccionada",
        ["Yes"] = "Sí",
        ["active"] = "activo",
        ["amount unknown"] = "cantidad desconocida",
        ["differs from the engine"] = "difiere del motor",
        ["forward-only"] = "solo avance",
        ["gain unknown"] = "ganancia desconocida",
        ["matches the engine"] = "coincide con el motor",
        ["seek status unknown"] = "estado de búsqueda desconocido",
        ["seekable"] = "con búsqueda",
        ["standby"] = "en espera",
        ["status unknown"] = "estado desconocido",
        ["unity (0 dB)"] = "unitaria (0 dB)",
    },
    fi = {
        [" · bypassed"] = " · ohitettu",
        [" · normal"] = " · normaali",
        [" · stored; overridden by MSEB"] = " · tallennettu; MSEB ohittaa",
        [" · time stretch active"] = " · aikavenytys aktiivinen",
        ["%d bytes"] = "%d tavua",
        ["%d channels"] = "%d kanavaa",
        ["%d kbps"] = "%d kb/s",
        ["%d%% strength"] = "%d%% voimakkuus",
        ["%d-bit"] = "%d-bittinen",
        ["%d:%02d (%d s)"] = "%d:%02d (%d s)",
        ["%s elapsed"] = "%s kulunut",
        ["%s · format unavailable"] = "%s · muoto ei saatavilla",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (Mono)",
        ["2 (Stereo)"] = "2 (Stereo)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (Pakattu: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (Little-Endian PCM)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Aktiivinen ulostulomuoto: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Aktiivinen ulostulomuoto: Ei saatavilla, kun lähtö ei ole aktiivinen",
        ["Album artist: %s"] = "Albumin artisti: %s",
        ["Album: %s"] = "Albumi: %s",
        ["An EQ band's enabled state is unknown."] = "EQ-kaistan käyttötila on tuntematon.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Käytössä olevalla EQ-kaistalla on tunnistamaton suodatintyyppi; vaikutus tuntematon.",
        ["An enabled EQ filter has unknown gain."] = "Käytössä olevalla EQ-suodattimella on tuntematon vahvistus.",
        ["Applied ReplayGain: %s"] = "Sovellettu ReplayGain: %s",
        ["Artist: %s"] = "Artisti: %s",
        ["Audio engine format: %s · %s"] = "Äänimoottorin muoto: %s · %s",
        ["Audio engine format: Unknown"] = "Äänimoottorin muoto: Tuntematon",
        ["Audio engine is idle; no active playback stream to inspect."] = "Äänimoottori on lepotilassa; ei tarkastettavaa toistovirtaa.",
        ["Audio engine output: %s · %s"] = "Äänimoottorin ulostulo: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Äänimoottorin uudelleennäytteistys: lähde %s -> %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Äänimuoto: Tuntematon (ei aktiivista purkajan tilannekuvaa)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Kaista %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Bittisyvyys: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Bittisyvyyttä laajennettu: lähde %d-bittinen -> ulostulo %d-bittinen (mahdollinen täyte tai dither; läpinäkyvyyttä ei vahvistettu).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Bittisyvyyden katkaisu: lähde %d-bittinen -> ulostulo %d-bittinen (ditheröinti tai tarkkuuden heikkeneminen).",
        ["Bitrate: %s"] = "Bittinopeus: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth voi muuttaa ääntä",
        ["Bluetooth codec: %s"] = "Bluetooth-koodekki: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "Bluetooth-koodaus voi muuttaa ääntä (%s); vastaanottavan laitteen lopullinen ulostulo ei näy tässä.",
        ["Bypassed"] = "Ohitettu",
        ["Change or unknown detail"] = "Muutos tai tuntematon yksityiskohta",
        ["Changes detected or information unavailable"] = "Muutoksia havaittu tai tietoja ei saatavilla",
        ["Changes to this setting take effect with the next track."] = "Muutokset tulevat voimaan seuraavassa kappaleessa.",
        ["Channels: %s"] = "Kanavat: %s",
        ["Codec: %s"] = "Koodekki: %s",
        ["Could not open file picker. Please try again."] = "Tiedostonvalitsinta ei voitu avata. Yritä uudelleen.",
        ["Could not open file picker: %s"] = "Tiedostonvalitsinta ei voitu avata: %s",
        ["Could not open file: %s"] = "Tiedostoa ei voitu avata: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade on käytössä; soitin ei ilmoita, miksataanko kappaleita parhaillaan.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Crossfade-asetus: %s · nykyistä miksaustilaa ei näytetä",
        ["Crossfeed angle: %.1f°"] = "Crossfeed-kulma: %.1f°",
        ["Crossfeed delay: none"] = "Crossfeed-viive: ei mitään",
        ["DSD audio"] = "DSD-ääni",
        ["DSD carrier rate: %s · expected %s"] = "DSD-kantoaallon taajuus: %s · odotettu %s",
        ["DSD converted to PCM at %s"] = "DSD muunnettu PCM:ksi taajuudella %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD muunnetaan PCM:ksi; alla olevat ääniasetukset voivat vaikuttaa toistoon.",
        ["DSD playback: converted to PCM"] = "DSD-toisto: muunnettu PCM:ksi",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "DSD-virta muunnettu PCM:ksi (desimointi aktiivinen; ei natiivi suora DSD-läpivienti).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "DSD-over-PCM-kantoaalto on aktiivinen; PCM-käsittely ohitetaan",
        ["DSD-over-PCM carrier: %s"] = "DSD-over-PCM-kantoaalto: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "DSD-over-PCM-toisto ohittaa taajuuskorjaimen ja muun PCM-käsittelyn.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "DSD-PCM-desimointi aktiivinen: DSD-bittivirta muunnetaan PCM:ksi ja siihen sovelletaan PCM-DSP-suodatusta.",
        ["Detail: %s"] = "Yksityiskohta: %s",
        ["Disabled"] = "Pois käytöstä",
        ["DoP active but codec is not DSD."] = "DoP on aktiivinen, mutta koodekki ei ole DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "DoP-kantoaallon bittisyvyys riittämätön: saatiin %s (vaatii 24-bittisen kantoaallon).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "DoP-kehystys: %s 1-bittinen DSD-virta pakattu %s %s PCM-kantoaaltokehyksiin; PCM-DSP ohitettu.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "DoP-kantoaallon taajuus ei täsmää: odotettiin %.1f kHz DSD:lle, saatiin %s.",
        ["Duration: %s"] = "Kesto: %s",
        ["EQ bands configuration missing."] = "EQ-kaistojen määritykset puuttuvat.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Digitaalinen EQ-esivahvistus aktiivinen: %+.2f dB.",
        ["EQ preamp gain is unknown or invalid."] = "EQ:n esivahvistuksen vahvistus on tuntematon tai virheellinen.",
        ["Enabled equalizer bands: %d / 10"] = "Käytössä olevat EQ-kaistat: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Käytössä olevat EQ-kaistat: Ei ilmoitettu kokonaan",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Koodaus: Pakattu ääni · otsake ei vahvista häviöttömyyttä",
        ["Encoding: Lossless compressed audio"] = "Koodaus: Häviöttömästi pakattu ääni",
        ["Equalizer bands"] = "Taajuuskorjaimen kaistat",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "Taajuuskorjaimen ohitus ohittaa myös esivahvistuksen, stereoleveyden, crossfeedin ja suodattimet.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Taajuuskorjaimen ohitus on aktiivinen; esivahvistus, stereoleveys ja suodattimet ohitetaan. Crossfeed säilyy itsenäisenä.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Taajuuskorjaimen ohitus on aktiivinen; esivahvistus, stereoleveys, crossfeed ja suodattimet ohitetaan.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "Taajuuskorjaimen ohitus ohittaa esivahvistuksen, stereoleveyden ja suodattimet; crossfeed säilyy itsenäisenä.",
        ["Equalizer details unavailable"] = "Taajuuskorjaimen tiedot eivät ole saatavilla",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Taajuuskorjaimen tila ei ole saatavilla; tasaista DSP-polkua ei voida vahvistaa.",
        ["Equalizer: %s"] = "Taajuuskorjain: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Arvioitu säilön bittinopeus: %s (sisältää säilön/metatiedot)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Tiedosto-otsake: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Tiedostonvalitsin ei käytettävissä. Päivitä laiteohjelmisto tiedoston tarkastamiseksi.",
        ["File size: %s"] = "Tiedostokoko: %s",
        ["File: %s"] = "Tiedosto: %s",
        ["Final device format: Not available from the player"] = "Laitteen lopullinen muoto: Ei saatavilla soittimesta",
        ["Final device format: Not reported by the player"] = "Laitteen lopullinen muoto: Soitin ei ilmoittanut",
        ["Format: %s"] = "Muoto: %s",
        ["Gapless playback: %s"] = "Saumaton toisto (gapless): %s",
        ["Genre: %s"] = "Tyylilaji: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Otsakkeen jäsennystila: Ei tuettu / Virheellinen",
        ["Headphone crossfeed is active at %.2f strength."] = "Kuulokkeiden crossfeed on aktiivinen voimakkuudella %.2f.",
        ["Headphone crossfeed state is unknown."] = "Kuulokkeiden crossfeed-tila on tuntematon.",
        ["Headphone crossfeed: %s%s"] = "Kuulokkeiden crossfeed: %s%s",
        ["High shelf"] = "Ylähylly (high shelf)",
        ["In order"] = "Järjestyksessä",
        ["Inspect a file"] = "Tarkasta tiedosto",
        ["Inspector settings"] = "Tarkastajan asetukset",
        ["Invalid file path"] = "Virheellinen tiedostopolku",
        ["Length: %s · %s"] = "Kesto: %s · %s",
        ["Live or unknown length"] = "Suora tai tuntematon pituus",
        ["Local file"] = "Paikallinen tiedosto",
        ["Local file details"] = "Paikallisen tiedoston tiedot",
        ["Local output format: %s · %s"] = "Paikallinen ulostulomuoto: %s · %s",
        ["Lossless compression"] = "Häviötön pakkaus",
        ["Lossy"] = "Häviöllinen",
        ["Low shelf"] = "Alahylly (low shelf)",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "Virheellinen AIFF: virheelliset ääniparametrit",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "Virheellinen AIFF: COMM-lohko puuttuu tai on katkennut",
        ["Malformed FLAC: STREAMINFO block length too small"] = "Virheellinen FLAC: STREAMINFO-lohkon pituus on liian pieni",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "Virheellinen FLAC: ensimmäisen metatietolohkon on oltava STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "Virheellinen FLAC: virheelliset ääniparametrit STREAMINFOssa",
        ["Malformed WAV: invalid audio parameters"] = "Virheellinen WAV: virheelliset ääniparametrit",
        ["Malformed WAV: missing or truncated fmt chunk"] = "Virheellinen WAV: fmt-lohko puuttuu tai on katkennut",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Vakio-MSEB ohittaa manuaaliset EQ-kaistat, esivahvistuksen ja stereoleveyden ollessaan käytössä.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Mono",
        ["Native DoP bypasses stock MSEB during playback."] = "Natiivi DoP ohittaa vakio-MSEB:n toiston aikana.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "Natiivi DoP-laitteistovirta ohittaa PCM-taajuuskorjaimen, vakio-MSEB:n, stereoleveyden ja ohjelmiston äänenvoimakkuuden.",
        ["Neutral"] = "Neutraali",
        ["No"] = "Ei",
        ["No Active Playback"] = "Ei aktiivista toistoa",
        ["No changes detected (wired DoP candidate)"] = "Muutoksia ei havaittu (langallinen DoP-kandidaatti)",
        ["No changes detected (wired PCM candidate)"] = "Muutoksia ei havaittu (langallinen PCM-kandidaatti)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "Havaittavissa toistovaiheissa ei havaittu muutoksia. Laitteistosertifiointia ei voida antaa tämän tilannekuvan perusteella.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "Havaittavissa toistovaiheissa ei havaittu muutoksia. Tämä on ehdokas, ei todiste fyysisestä laitteistolähdöstä.",
        ["Not classified by this inspector"] = "Ei luokiteltu tämän tarkastajan toimesta",
        ["Not reported"] = "Ei ilmoitettu",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Huomautus: Tarkastus rajoittuu paikallisiin WAV-, FLAC- ja AIFF-otsakkeisiin. Muita muotoja ei arvata tiedostopäätteestä.",
        ["One-bit DSD audio"] = "1-bittinen DSD-ääni",
        ["Opus"] = "Opus",
        ["Other observation"] = "Muu huomio",
        ["Output active: %s"] = "Lähtö aktiivinen: %s",
        ["Output bit depth is unknown or invalid."] = "Ulostulon bittisyvyys on tuntematon tai virheellinen.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Bittisyvyys eroaa: äänimoottori %d-bittinen -> soittimen ilmoittama %d-bittinen.",
        ["Output details"] = "Ulostulon tiedot",
        ["Output details unavailable"] = "Ulostulon tiedot eivät ole saatavilla",
        ["Output device"] = "Lähtölaite",
        ["Output is inactive"] = "Lähtö ei ole aktiivinen",
        ["Output is inactive or its state is unknown."] = "Lähtö ei ole aktiivinen tai sen tila on tuntematon.",
        ["Output rate matches engine: %s"] = "Ulostulotaajuus vastaa moottoria: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Lähtöreitti on USB-DAC: ulkoisen USB-päätepisteen muunnosta ja laitteistomikseriä ei ole vahvistettu; pelkät täsmäävät PCM-kentät eivät takaa bit-perfect-toistoa.",
        ["Output route: %s · %s"] = "Lähtöreitti: %s · %s",
        ["Output sample rate is unknown or invalid."] = "Ulostulon näytetaajuus on tuntematon tai virheellinen.",
        ["Output sink DoP flag is not active."] = "Lähtölaitteen DoP-lippu ei ole aktiivinen.",
        ["PCM audio"] = "PCM-ääni",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "Parametrisessa EQ:ssa on %d käytössä olevaa kaistaa; suodatus ja huippusuojaus voivat vaikuttaa näytteisiin.",
        ["Path is outside SD root"] = "Polku on SD-kortin juuren ulkopuolella",
        ["Paused"] = "Tauolla",
        ["Peaking"] = "Kello (peaking)",
        ["Per album"] = "Albumeittain",
        ["Per track"] = "Kappaleittain",
        ["Play mode: %s"] = "Toistotila: %s",
        ["Playback details"] = "Toiston tiedot",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Toistonopeutta muutettu: %.4fx (aikavenytys-DSP aktiivinen).",
        ["Playback speed state unavailable or invalid."] = "Toistonopeuden tila ei ole saatavilla tai se on virheellinen.",
        ["Playback speed: %s"] = "Toistonopeus: %s",
        ["Playback: %s · %s"] = "Toisto: %s · %s",
        ["Player output rate: %s · %s"] = "Soittimen ulostulotaajuus: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Soittimen äänenvoimakkuus: %s · erillään ohjelmistovahvistuksesta",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "Soittimen ilmoittama ulostulotaajuus eroaa lähteestä: %d Hz -> %d Hz.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "Soittimen ilmoittama ulostulotaajuus ei täsmää DoP-kantoaaltoon: %d Hz vs %.0f Hz.",
        ["Please close the other file picker and try again."] = "Sulje toinen tiedostonvalitsin ja yritä uudelleen.",
        ["Preamp gain: %s%s"] = "Esivahvistuksen vahvistus: %s%s",
        ["Refresh output details"] = "Päivitä ulostulon tiedot",
        ["Refresh playback details"] = "Päivitä toiston tiedot",
        ["Refresh signal path check"] = "Päivitä signaalipolun tarkistus",
        ["Refresh sound details"] = "Päivitä ääniasetusten tiedot",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Verkkovirrat eivät tue suoraa tiedosto-otsakkeen tarkastusta; muoto saadaan purkajan tilannekuvasta",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (äänenvoimakkuuden tasaus): %s · nykyisessä kappaleessa: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "ReplayGain-skaalaus käytössä: %+.2f dB.",
        ["ReplayGain state unavailable."] = "ReplayGain-tila ei ole saatavilla.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain on ilmoitettu käytetyksi, mutta sen vahvistusmäärää ei tunneta.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Uudelleennäytteistys aktiivinen: lähde %d Hz -> ulostulo %d Hz.",
        ["Result: %s"] = "Tulos: %s",
        ["Route: %s"] = "Reitti: %s",
        ["Sample Rate: %s"] = "Näytetaajuus: %s",
        ["Show full file paths"] = "Näytä täydet tiedostopolut",
        ["Show music library tags"] = "Näytä musiikkikirjaston tunnisteet",
        ["Signal check"] = "Signaalin tarkistus",
        ["Software audio gain: %s"] = "Ohjelmiston äänenvahvistus: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Ohjelmiston äänenvoimakkuus ykkösvahvistuksessa (1.00 / 0.0 dB - ei digitaalista PCM-skaalausta).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Ohjelmiston äänenvoimakkuuden skaalaus aktiivinen: %.6fx (%s digitaalinen muutos).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Ohjelmiston äänenvoimakkuuden tila ei ole saatavilla; ykkösvahvistusta ei voi varmistaa.",
        ["Sound processing"] = "Äänenkäsittely",
        ["Source and audio engine rates match: %s"] = "Lähteen ja äänimoottorin taajuudet täsmäävät: %s",
        ["Source audio: %s · %s · %s"] = "Lähdeääni: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "Lähteen bittisyvyys on tuntematon tai häviöllinen (ei alkuperäistä PCM-syvyyttä).",
        ["Source channels count is unknown or invalid."] = "Lähteen kanavamäärä on tuntematon tai virheellinen.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "Lähdekoodekki on häviöllinen (%s): häviöllinen purku ei voi taata alkuperäisen PCM-masterin bit-perfect-toistoa.",
        ["Source codec is unknown."] = "Lähdekoodekki on tuntematon.",
        ["Source quality: %s"] = "Lähteen laatu: %s",
        ["Source sample rate is unknown or invalid."] = "Lähteen näytetaajuus on tuntematon tai virheellinen.",
        ["Source: %s · %s"] = "Lähde: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Aloita tai jatka toistoa tarkastaaksesi purkajan reaaliaikaisen muodon.",
        ["State unknown"] = "Tila tuntematon",
        ["Stereo width is unknown or invalid."] = "Stereoleveys on tuntematon tai virheellinen.",
        ["Stereo width processing is active: %.4f."] = "Stereoleveyden käsittely on aktiivinen: %.4f.",
        ["Stereo width: %s%s"] = "Stereoleveys: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "Vakio-MSEB ohittaa tallennetut EQ-kaistat, esivahvistuksen ja stereoleveyden; crossfeed säilyy itsenäisenä.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "Vakio-MSEB-käsittely on käytössä ei-neutraaleilla asetuksilla.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Vakio-MSEB-asetukset ovat puutteellisia tai virheellisiä; neutraalia PCM-polkua ei voi vahvistaa.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Vakio-MSEB:n tila ei ole saatavilla; PCM-käsittelypolkua ei voida varmistaa.",
        ["Stock MSEB: %s"] = "Vakio-MSEB: %s",
        ["Stream name or endpoint: %s"] = "Suoratoiston nimi tai päätepiste: %s",
        ["The active output route is unknown."] = "Aktiivinen lähtöreitti on tuntematon.",
        ["The external device's final conversion and output format are not visible here."] = "Ulkoisen laitteen lopullinen muunnos ja ulostulomuoto eivät näy tässä.",
        ["The full equalizer band state is unavailable."] = "Taajuuskorjaimen kaistojen täysi tila ei ole saatavilla.",
        ["The local output format is not reported by the player."] = "Soitin ei ilmoita paikallista ulostulomuotoa.",
        ["The player cannot compare the engine and output sample rates."] = "Soitin ei voi verrata moottorin ja ulostulon näytetaajuuksia.",
        ["The player reports different engine and output sample rates."] = "Soitin ilmoittaa erilaiset näytetaajuudet moottorille ja ulostulolle.",
        ["The remote device's final output format is not visible here."] = "Etälaitteen lopullinen ulostulomuoto ei näy tässä.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "Tilannekuva osoittaa muutoksen tai siitä puuttuu tietoa muuttumattoman signaalipolun vahvistamiseksi.",
        ["This firmware does not expose a live equalizer snapshot."] = "Tämä laiteohjelmisto ei tarjoa reaaliaikaista taajuuskorjaimen tilannekuvaa.",
        ["This firmware does not expose a live output snapshot."] = "Tämä laiteohjelmisto ei tarjoa reaaliaikaista ulostulon tilannekuvaa.",
        ["Title: %s"] = "Kappale: %s",
        ["Track Inspector"] = "Kappaletarkastaja",
        ["Track and file details"] = "Kappaleen ja tiedoston tiedot",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Katkennut FLAC STREAMINFO -otsake (alle 42 tavua)",
        ["Truncated file header (less than 12 bytes)"] = "Katkennut tiedosto-otsake (alle 12 tavua)",
        ["Type: Uncompressed PCM"] = "Tyyppi: Pakkaamaton PCM",
        ["USB audio"] = "USB-ääni",
        ["USB audio output is selected"] = "USB-äänilähtö on valittu",
        ["USB output cannot be fully checked"] = "USB-lähtöä ei voi tarkistaa täysin",
        ["Uncompressed PCM"] = "Pakkaamaton PCM",
        ["Unknown"] = "Tuntematon",
        ["Unknown (mode not reported)"] = "Tuntematon (tilaa ei ilmoitettu)",
        ["Unknown / Negotiating"] = "Tuntematon / Neuvotellaan",
        ["Unknown / not reported"] = "Tuntematon / ei ilmoitettu",
        ["Unknown filter"] = "Tuntematon suodatin",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Tuntematon otsakemuoto (tarkastus rajoittuu WAV-, FLAC- ja AIFF-otsakkeisiin; muotoa ei päätellä päätteestä)",
        ["Unknown route"] = "Tuntematon reitti",
        ["View all equalizer bands"] = "Näytä kaikki taajuuskorjaimen kaistat",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (Pakattu laajennettava: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (Pakattu: muoto 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (Laajennettava Float)",
        ["WAV (Extensible PCM)"] = "WAV (Laajennettava PCM)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (PCM-kokonaisluku)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "WavPackin häviötöntä tai hybriditilaa ja korjaustiedoston tilaa ei ole ilmoitettu.",
        ["Wider or narrower stereo"] = "Leveämpi tai kapeampi stereo",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Langallinen lähtö",
        ["Wired output is selected"] = "Langallinen lähtö on valittu",
        ["Yes"] = "Kyllä",
        ["active"] = "aktiivinen",
        ["amount unknown"] = "määrä tuntematon",
        ["differs from the engine"] = "eroaa moottorista",
        ["forward-only"] = "vain eteenpäin",
        ["gain unknown"] = "vahvistus tuntematon",
        ["matches the engine"] = "vastaa moottoria",
        ["seek status unknown"] = "kelaustila tuntematon",
        ["seekable"] = "kelattavissa",
        ["standby"] = "valmiustila",
        ["status unknown"] = "tila tuntematon",
        ["unity (0 dB)"] = "ykkönen (0 dB)",
    },
    fr = {
        [" · bypassed"] = " · contourné",
        [" · normal"] = " · normal",
        [" · stored; overridden by MSEB"] = " · mémorisé ; remplacé par MSEB",
        [" · time stretch active"] = " · étirement temporel actif",
        ["%d bytes"] = "%d octets",
        ["%d channels"] = "%d canaux",
        ["%d kbps"] = "%d kbps",
        ["%d%% strength"] = "%d%% intensité",
        ["%d-bit"] = "%d bits",
        ["%d:%02d (%d s)"] = "%d:%02d (%d s)",
        ["%s elapsed"] = "%s écoulé",
        ["%s · format unavailable"] = "%s · format indisponible",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (Mono)",
        ["2 (Stereo)"] = "2 (Stéréo)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (Compressé : %s)",
        ["AIFC (Float)"] = "AIFC (Flottant)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (PCM Little-Endian)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Format de sortie actif : %s · %s",
        ["Active output format: Not available while output is inactive"] = "Format de sortie actif : Non disponible lorsque la sortie est inactive",
        ["Album artist: %s"] = "Artiste de l'album : %s",
        ["Album: %s"] = "Album : %s",
        ["An EQ band's enabled state is unknown."] = "L'état d'activation d'une bande EQ est inconnu.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Une bande EQ activée a un type de filtre non reconnu ; son effet est inconnu.",
        ["An enabled EQ filter has unknown gain."] = "Un filtre EQ activé a un gain inconnu.",
        ["Applied ReplayGain: %s"] = "ReplayGain appliqué : %s",
        ["Artist: %s"] = "Artiste : %s",
        ["Audio engine format: %s · %s"] = "Format du moteur audio : %s · %s",
        ["Audio engine format: Unknown"] = "Format du moteur audio : Inconnu",
        ["Audio engine is idle; no active playback stream to inspect."] = "Le moteur audio est inactif ; aucun flux de lecture à inspecter.",
        ["Audio engine output: %s · %s"] = "Sortie du moteur audio : %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Rééchantillonnage du moteur audio : source %s vers %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Format audio : Inconnu (aucune capture active du décodeur)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Bande %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Profondeur de bits : %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Profondeur de bits étendue : source %d bits -> sortie %d bits (remplissage ou dither possible ; transparence non vérifiée).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Tronquage de bits : source %d bits -> sortie %d bits (dithering ou perte de précision).",
        ["Bitrate: %s"] = "Débit : %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth peut modifier l'audio",
        ["Bluetooth codec: %s"] = "Codec Bluetooth : %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "L'encodage Bluetooth peut modifier l'audio (%s) ; la sortie finale de l'appareil récepteur n'est pas visible ici.",
        ["Bypassed"] = "Contourné",
        ["Change or unknown detail"] = "Changement ou détail inconnu",
        ["Changes detected or information unavailable"] = "Changements détectés ou informations indisponibles",
        ["Changes to this setting take effect with the next track."] = "Les modifications prendront effet avec la piste suivante.",
        ["Channels: %s"] = "Canaux : %s",
        ["Codec: %s"] = "Codec : %s",
        ["Could not open file picker. Please try again."] = "Impossible d'ouvrir le sélecteur de fichiers. Veuillez réessayer.",
        ["Could not open file picker: %s"] = "Impossible d'ouvrir le sélecteur de fichiers : %s",
        ["Could not open file: %s"] = "Impossible d'ouvrir le fichier : %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade activé ; le lecteur ne signale pas si les pistes sont actuellement mixées.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Paramètre de crossfade : %s · état de mixage non exposé",
        ["Crossfeed angle: %.1f°"] = "Angle du crossfeed : %.1f°",
        ["Crossfeed delay: none"] = "Délai crossfeed : aucun",
        ["DSD audio"] = "Audio DSD",
        ["DSD carrier rate: %s · expected %s"] = "Taux porteur DSD : %s · attendu %s",
        ["DSD converted to PCM at %s"] = "DSD converti en PCM à %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "Le DSD est converti en PCM ; les paramètres audio ci-dessous peuvent affecter la lecture.",
        ["DSD playback: converted to PCM"] = "Lecture DSD : convertie en PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "Flux DSD converti en PCM (décimation active ; pas de transmission directe DSD native).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "Porteuse DSD-over-PCM active ; traitement PCM contourné",
        ["DSD-over-PCM carrier: %s"] = "Porteuse DSD-over-PCM : %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "La lecture DSD-over-PCM contourne l'égaliseur et les autres traitements PCM.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "Décimation DSD vers PCM active : le flux DSD est converti en PCM et soumis au filtrage DSP PCM.",
        ["Detail: %s"] = "Détail : %s",
        ["Disabled"] = "Désactivé",
        ["DoP active but codec is not DSD."] = "DoP actif mais le codec n'est pas DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "Profondeur de porteuse DoP insuffisante : obtenu %s (porteuse 24 bits requise).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "Tramage DoP : flux DSD 1 bit %s encapsulé dans des trames porteuses PCM %s %s ; chaîne DSP PCM contournée.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "Incohérence du taux porteur DoP : attendu %.1f kHz pour DSD, obtenu %s.",
        ["Duration: %s"] = "Durée : %s",
        ["EQ bands configuration missing."] = "Configuration des bandes EQ manquante.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Gain du préampli numérique EQ actif : %+.2f dB.",
        ["EQ preamp gain is unknown or invalid."] = "Le gain du préampli EQ est inconnu ou invalide.",
        ["Enabled equalizer bands: %d / 10"] = "Bandes d'égaliseur activées : %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Bandes d'égaliseur activées : Non signalées en totalité",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Encodage : Audio compressé · absence de perte non confirmée par cet en-tête",
        ["Encoding: Lossless compressed audio"] = "Encodage : Audio compressé sans perte",
        ["Equalizer bands"] = "Bandes de l'égaliseur",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "Le contournement de l'égaliseur ignore également le préampli, la largeur stéréo, le crossfeed et les filtres.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Contournement de l'égaliseur actif ; préampli, largeur stéréo et filtres ignorés. Le crossfeed reste indépendant.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Contournement de l'égaliseur actif ; préampli, largeur stéréo, crossfeed et filtres ignorés.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "Le contournement de l'égaliseur ignore le préampli, la largeur stéréo et les filtres ; le crossfeed reste indépendant.",
        ["Equalizer details unavailable"] = "Détails de l'égaliseur indisponibles",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "État de l'égaliseur indisponible ; impossible de vérifier un chemin DSP plat.",
        ["Equalizer: %s"] = "Égaliseur : %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Débit estimé du conteneur : %s (inclut métadonnées et conteneur)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "En-tête de fichier : %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Sélecteur de fichiers indisponible. Mettez à jour le micrologiciel pour inspecter un fichier local.",
        ["File size: %s"] = "Taille du fichier : %s",
        ["File: %s"] = "Fichier : %s",
        ["Final device format: Not available from the player"] = "Format final de l'appareil : Non disponible depuis le lecteur",
        ["Final device format: Not reported by the player"] = "Format final de l'appareil : Non signalé par le lecteur",
        ["Format: %s"] = "Format : %s",
        ["Gapless playback: %s"] = "Lecture sans blanc (gapless) : %s",
        ["Genre: %s"] = "Genre : %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "État d'analyse de l'en-tête : Non supporté / Malformé",
        ["Headphone crossfeed is active at %.2f strength."] = "Crossfeed casque actif avec une intensité de %.2f.",
        ["Headphone crossfeed state is unknown."] = "L'état du crossfeed casque est inconnu.",
        ["Headphone crossfeed: %s%s"] = "Crossfeed casque : %s%s",
        ["High shelf"] = "Plateau haut (high shelf)",
        ["In order"] = "Dans l'ordre",
        ["Inspect a file"] = "Inspecter un fichier",
        ["Inspector settings"] = "Paramètres de l'inspecteur",
        ["Invalid file path"] = "Chemin de fichier invalide",
        ["Length: %s · %s"] = "Durée : %s · %s",
        ["Live or unknown length"] = "Direct ou durée inconnue",
        ["Local file"] = "Fichier local",
        ["Local file details"] = "Détails du fichier local",
        ["Local output format: %s · %s"] = "Format de sortie local : %s · %s",
        ["Lossless compression"] = "Compression sans perte",
        ["Lossy"] = "Avec perte",
        ["Low shelf"] = "Plateau bas (low shelf)",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "AIFF malformé : paramètres audio invalides",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "AIFF malformé : bloc COMM manquant ou tronqué",
        ["Malformed FLAC: STREAMINFO block length too small"] = "FLAC malformé : longueur du bloc STREAMINFO trop petite",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "FLAC malformé : le premier bloc de métadonnées doit être STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "FLAC malformé : paramètres audio invalides dans STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "WAV malformé : paramètres audio invalides",
        ["Malformed WAV: missing or truncated fmt chunk"] = "WAV malformé : bloc fmt manquant ou tronqué",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Bandes d'égaliseur manuel, préampli et largeur stéréo remplacés par le MSEB par défaut tant qu'il est activé.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Mono",
        ["Native DoP bypasses stock MSEB during playback."] = "Le DoP natif contourne le MSEB par défaut pendant la lecture.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "Le flux matériel DoP natif contourne l'égaliseur PCM, le MSEB par défaut, la largeur stéréo et le volume logiciel.",
        ["Neutral"] = "Neutre",
        ["No"] = "Non",
        ["No Active Playback"] = "Aucune lecture active",
        ["No changes detected (wired DoP candidate)"] = "Aucun changement détecté (candidat DoP filaire)",
        ["No changes detected (wired PCM candidate)"] = "Aucun changement détecté (candidat PCM filaire)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "Aucune modification détectée dans les étapes observables. La certification matérielle n'est pas possible depuis cette capture.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "Aucun changement détecté dans les étapes observables. C'est un candidat, pas une preuve de la sortie matérielle physique.",
        ["Not classified by this inspector"] = "Non classifié par cet inspecteur",
        ["Not reported"] = "Non signalé",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Remarque : Inspection limitée aux en-têtes locaux WAV, FLAC, AIFF. Autres formats signalés inconnus sans deviner d'après l'extension.",
        ["One-bit DSD audio"] = "Audio DSD 1 bit",
        ["Opus"] = "Opus",
        ["Other observation"] = "Autre observation",
        ["Output active: %s"] = "Sortie active : %s",
        ["Output bit depth is unknown or invalid."] = "La profondeur de bits de sortie est inconnue ou invalide.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Profondeur de sortie différente : moteur audio %d bits -> signalé %d bits.",
        ["Output details"] = "Détails de sortie",
        ["Output details unavailable"] = "Détails de sortie indisponibles",
        ["Output device"] = "Périphérique de sortie",
        ["Output is inactive"] = "La sortie est inactive",
        ["Output is inactive or its state is unknown."] = "La sortie est inactive ou son état est inconnu.",
        ["Output rate matches engine: %s"] = "Taux de sortie conforme au moteur : %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Sortie DAC USB : conversion du point de terminaison et mixeur matériel non vérifiés ; la correspondance PCM seule ne prouve pas une sortie bit-perfect.",
        ["Output route: %s · %s"] = "Route de sortie : %s · %s",
        ["Output sample rate is unknown or invalid."] = "Le taux d'échantillonnage de sortie est inconnu ou invalide.",
        ["Output sink DoP flag is not active."] = "Le drapeau DoP du récepteur de sortie n'est pas actif.",
        ["PCM audio"] = "Audio PCM",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "L'égaliseur paramétrique a %d bande(s) activée(s) ; le filtrage et la protection de crête peuvent affecter les échantillons.",
        ["Path is outside SD root"] = "Le chemin est hors de la racine SD",
        ["Paused"] = "En pause",
        ["Peaking"] = "Cloche (peaking)",
        ["Per album"] = "Par album",
        ["Per track"] = "Par piste",
        ["Play mode: %s"] = "Mode de lecture : %s",
        ["Playback details"] = "Détails de lecture",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Vitesse de lecture modifiée : %.4fx (DSP d'étirement temporel actif).",
        ["Playback speed state unavailable or invalid."] = "État de la vitesse de lecture indisponible ou invalide.",
        ["Playback speed: %s"] = "Vitesse de lecture : %s",
        ["Playback: %s · %s"] = "Lecture : %s · %s",
        ["Player output rate: %s · %s"] = "Taux de sortie du lecteur : %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Volume du lecteur : %s · séparé du gain audio logiciel",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "Le taux de sortie signalé diffère de la source : %d Hz -> %d Hz.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "Le taux de sortie signalé ne correspond pas à la porteuse DoP : %d Hz contre %.0f Hz.",
        ["Please close the other file picker and try again."] = "Veuillez fermer l'autre sélecteur de fichiers et réessayer.",
        ["Preamp gain: %s%s"] = "Gain du préampli : %s%s",
        ["Refresh output details"] = "Actualiser les détails de sortie",
        ["Refresh playback details"] = "Actualiser les détails de lecture",
        ["Refresh signal path check"] = "Actualiser la vérification du signal",
        ["Refresh sound details"] = "Actualiser les détails audio",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Les flux distants ne permettent pas l'inspection directe d'en-tête ; format fourni par le décodeur",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (égalisation de volume) : %s · appliqué sur la piste : %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "Mise à l'échelle ReplayGain appliquée : %+.2f dB.",
        ["ReplayGain state unavailable."] = "État ReplayGain indisponible.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain signalé comme appliqué, mais la valeur du gain est inconnue.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Rééchantillonnage actif : source %d Hz -> sortie %d Hz.",
        ["Result: %s"] = "Résultat : %s",
        ["Route: %s"] = "Route : %s",
        ["Sample Rate: %s"] = "Taux d'échantillonnage : %s",
        ["Show full file paths"] = "Afficher les chemins complets des fichiers",
        ["Show music library tags"] = "Afficher les tags de la bibliothèque musicale",
        ["Signal check"] = "Vérification du signal",
        ["Software audio gain: %s"] = "Gain audio logiciel : %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Volume logiciel au gain unitaire (1.00 / 0.0 dB - aucune mise à l'échelle numérique PCM).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Mise à l'échelle du volume logiciel active : %.6fx (%s de modification numérique).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "État du volume logiciel indisponible ; impossible de vérifier le gain unitaire.",
        ["Sound processing"] = "Traitement audio",
        ["Source and audio engine rates match: %s"] = "Taux source et moteur audio identiques : %s",
        ["Source audio: %s · %s · %s"] = "Audio source : %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "La profondeur de bits source est inconnue ou avec perte (pas de profondeur PCM d'origine).",
        ["Source channels count is unknown or invalid."] = "Le nombre de canaux source est inconnu ou invalide.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "Le codec source est avec perte (%s) : le décodage avec perte ne peut garantir une reproduction bit-perfect.",
        ["Source codec is unknown."] = "Le codec source est inconnu.",
        ["Source quality: %s"] = "Qualité source : %s",
        ["Source sample rate is unknown or invalid."] = "Le taux d'échantillonnage source est inconnu ou invalide.",
        ["Source: %s · %s"] = "Source : %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Lancez ou reprenez la lecture pour inspecter le format en direct du décodeur.",
        ["State unknown"] = "État inconnu",
        ["Stereo width is unknown or invalid."] = "La largeur stéréo est inconnue ou invalide.",
        ["Stereo width processing is active: %.4f."] = "Traitement de la largeur stéréo actif : %.4f.",
        ["Stereo width: %s%s"] = "Largeur stéréo : %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "Le MSEB par défaut remplace les bandes EQ manuelles, le préampli et la largeur stéréo ; le crossfeed reste indépendant.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "Le traitement MSEB par défaut est activé avec des paramètres non neutres.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Paramètres MSEB incomplets ou invalides ; impossible de vérifier un chemin PCM neutre.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "État MSEB par défaut indisponible ; impossible de vérifier le chemin de traitement PCM.",
        ["Stock MSEB: %s"] = "MSEB par défaut : %s",
        ["Stream name or endpoint: %s"] = "Nom du flux ou point de terminaison : %s",
        ["The active output route is unknown."] = "La route de sortie active est inconnue.",
        ["The external device's final conversion and output format are not visible here."] = "La conversion finale et le format de sortie de l'appareil externe ne sont pas visibles ici.",
        ["The full equalizer band state is unavailable."] = "L'état complet des bandes de l'égaliseur n'est pas disponible.",
        ["The local output format is not reported by the player."] = "Le format de sortie local n'est pas signalé par le lecteur.",
        ["The player cannot compare the engine and output sample rates."] = "Le lecteur ne peut pas comparer les taux d'échantillonnage moteur et sortie.",
        ["The player reports different engine and output sample rates."] = "Le lecteur signale des taux d'échantillonnage différents entre moteur et sortie.",
        ["The remote device's final output format is not visible here."] = "Le format de sortie final de l'appareil distant n'est pas visible ici.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "La capture indique une modification ou manque d'informations pour vérifier l'intégrité du signal.",
        ["This firmware does not expose a live equalizer snapshot."] = "Ce micrologiciel n'expose pas de capture de l'égaliseur en direct.",
        ["This firmware does not expose a live output snapshot."] = "Ce micrologiciel n'expose pas de capture de sortie en direct.",
        ["Title: %s"] = "Titre : %s",
        ["Track Inspector"] = "Inspecteur de piste",
        ["Track and file details"] = "Détails de la piste et du fichier",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "En-tête STREAMINFO FLAC tronqué (moins de 42 octets)",
        ["Truncated file header (less than 12 bytes)"] = "En-tête de fichier tronqué (moins de 12 octets)",
        ["Type: Uncompressed PCM"] = "Type : PCM non compressé",
        ["USB audio"] = "Audio USB",
        ["USB audio output is selected"] = "Sortie audio USB sélectionnée",
        ["USB output cannot be fully checked"] = "La sortie USB ne peut pas être entièrement vérifiée",
        ["Uncompressed PCM"] = "PCM non compressé",
        ["Unknown"] = "Inconnu",
        ["Unknown (mode not reported)"] = "Inconnu (mode non signalé)",
        ["Unknown / Negotiating"] = "Inconnu / Négociation",
        ["Unknown / not reported"] = "Inconnu / non signalé",
        ["Unknown filter"] = "Filtre inconnu",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Format d'en-tête inconnu (inspection limitée aux en-têtes WAV, FLAC, AIFF ; formats non déduits de l'extension)",
        ["Unknown route"] = "Route inconnue",
        ["View all equalizer bands"] = "Afficher toutes les bandes de l'égaliseur",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (Extensible compressé : 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (Compressé : format 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (Flottant extensible)",
        ["WAV (Extensible PCM)"] = "WAV (PCM extensible)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Flottant)",
        ["WAV (PCM Integer)"] = "WAV (PCM entier)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "Mode WavPack sans perte ou hybride et état du fichier de correction non signalés.",
        ["Wider or narrower stereo"] = "Stéréo plus large ou plus étroite",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Sortie filaire",
        ["Wired output is selected"] = "Sortie filaire sélectionnée",
        ["Yes"] = "Oui",
        ["active"] = "actif",
        ["amount unknown"] = "valeur inconnue",
        ["differs from the engine"] = "diffère du moteur",
        ["forward-only"] = "avance seule",
        ["gain unknown"] = "gain inconnu",
        ["matches the engine"] = "correspond au moteur",
        ["seek status unknown"] = "état de recherche inconnu",
        ["seekable"] = "recherche possible",
        ["standby"] = "en veille",
        ["status unknown"] = "état inconnu",
        ["unity (0 dB)"] = "unitaire (0 dB)",
    },
    it = {
        [" · bypassed"] = " · bypassato",
        [" · normal"] = " · normale",
        [" · stored; overridden by MSEB"] = " · memorizzato; sovrascritto da MSEB",
        [" · time stretch active"] = " · time stretch attivo",
        ["%d bytes"] = "%d byte",
        ["%d channels"] = "%d canali",
        ["%d kbps"] = "%d kbps",
        ["%d%% strength"] = "%d%% intensità",
        ["%d-bit"] = "%d bit",
        ["%d:%02d (%d s)"] = "%d:%02d (%d s)",
        ["%s elapsed"] = "%s trascorso",
        ["%s · format unavailable"] = "%s · formato non disponibile",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (Mono)",
        ["2 (Stereo)"] = "2 (Stereo)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (Compresso: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (PCM Little-Endian)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Formato uscita attivo: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Formato uscita attivo: Non disponibile quando l'uscita è inattiva",
        ["Album artist: %s"] = "Artista album: %s",
        ["Album: %s"] = "Album: %s",
        ["An EQ band's enabled state is unknown."] = "Lo stato di abilitazione di una banda EQ è sconosciuto.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Una banda EQ abilitata ha un tipo di filtro sconosciuto; effetto non noto.",
        ["An enabled EQ filter has unknown gain."] = "Un filtro EQ abilitato ha un guadagno sconosciuto.",
        ["Applied ReplayGain: %s"] = "ReplayGain applicato: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Audio engine format: %s · %s"] = "Formato motore audio: %s · %s",
        ["Audio engine format: Unknown"] = "Formato motore audio: Sconosciuto",
        ["Audio engine is idle; no active playback stream to inspect."] = "Il motore audio è inattivo; nessun flusso di riproduzione da ispezionare.",
        ["Audio engine output: %s · %s"] = "Uscita motore audio: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Ricampionamento motore audio: sorgente %s a %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Formato audio: Sconosciuto (nessuna istantanea attiva del decoder)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Banda %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Profondità di bit: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Profondità bit espansa: sorgente %d bit -> uscita %d bit (possibile padding o dither; trasparenza non verificata).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Troncamento bit: sorgente %d bit -> uscita %d bit (dithering o perdita di precisione).",
        ["Bitrate: %s"] = "Bitrate: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth può modificare l'audio",
        ["Bluetooth codec: %s"] = "Codec Bluetooth: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "La codifica Bluetooth può modificare l'audio (%s); l'uscita finale del dispositivo ricevente non è visibile qui.",
        ["Bypassed"] = "Bypassato",
        ["Change or unknown detail"] = "Modifica o dettaglio sconosciuto",
        ["Changes detected or information unavailable"] = "Modifiche rilevate o informazioni non disponibili",
        ["Changes to this setting take effect with the next track."] = "Le modifiche avranno effetto con la traccia successiva.",
        ["Channels: %s"] = "Canali: %s",
        ["Codec: %s"] = "Codec: %s",
        ["Could not open file picker. Please try again."] = "Impossibile aprire il selettore file. Riprova.",
        ["Could not open file picker: %s"] = "Impossibile aprire il selettore file: %s",
        ["Could not open file: %s"] = "Impossibile aprire il file: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade abilitato; il lettore non segnala se le tracce sono attualmente in fase di mixaggio.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Impostazione crossfade: %s · stato di mixaggio non esposto",
        ["Crossfeed angle: %.1f°"] = "Angolo crossfeed: %.1f°",
        ["Crossfeed delay: none"] = "Ritardo crossfeed: nessuno",
        ["DSD audio"] = "Audio DSD",
        ["DSD carrier rate: %s · expected %s"] = "Frequenza portante DSD: %s · previsto %s",
        ["DSD converted to PCM at %s"] = "DSD convertito in PCM a %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD è convertito in PCM; le impostazioni audio sottostanti possono influire sulla riproduzione.",
        ["DSD playback: converted to PCM"] = "Riproduzione DSD: convertita in PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "Flusso DSD convertito in PCM (decimazione attiva; non è passthrough DSD nativo diretto).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "Portante DSD-over-PCM attiva; elaborazione PCM bypassata",
        ["DSD-over-PCM carrier: %s"] = "Portante DSD-over-PCM: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "La riproduzione DSD-over-PCM bypassa l'equalizzatore e altre elaborazioni PCM.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "Decimazione da DSD a PCM attiva: il flusso DSD è convertito in PCM e soggetto ai filtri DSP PCM.",
        ["Detail: %s"] = "Dettaglio: %s",
        ["Disabled"] = "Disattivato",
        ["DoP active but codec is not DSD."] = "DoP attivo ma il codec non è DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "Profondità portante DoP insufficiente: ottenuto %s (richiede portante a 24 bit).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "Framing portante DoP: flusso DSD a 1 bit %s inserito in frame portanti PCM %s %s; catena DSP PCM bypassata.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "Discrepanza frequenza portante DoP: previsto %.1f kHz per DSD, ottenuto %s.",
        ["Duration: %s"] = "Durata: %s",
        ["EQ bands configuration missing."] = "Configurazione bande EQ mancante.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Guadagno preamplificatore digitale EQ attivo: %+.2f dB.",
        ["EQ preamp gain is unknown or invalid."] = "Il guadagno preamplificatore EQ è sconosciuto o non valido.",
        ["Enabled equalizer bands: %d / 10"] = "Bande equalizzatore abilitate: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Bande equalizzatore abilitate: Non completamente segnalate",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Codifica: Audio compresso · compressione senza perdita non confermata dall'intestazione",
        ["Encoding: Lossless compressed audio"] = "Codifica: Audio compresso senza perdita",
        ["Equalizer bands"] = "Bande equalizzatore",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "Il bypass dell'equalizzatore salta anche preamplificazione, ampiezza stereo, crossfeed e filtri.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Bypass equalizzatore attivo; preamplificazione, ampiezza stereo e filtri saltati. Il crossfeed resta indipendente.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Bypass equalizzatore attivo; preamplificazione, ampiezza stereo, crossfeed e filtri vengono saltati.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "Il bypass dell'equalizzatore salta preamplificazione, ampiezza stereo e filtri; il crossfeed resta indipendente.",
        ["Equalizer details unavailable"] = "Dettagli equalizzatore non disponibili",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Stato equalizzatore non disponibile; impossibile verificare un percorso DSP lineare.",
        ["Equalizer: %s"] = "Equalizzatore: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Bitrate stimato contenitore: %s (include overhead contenitore/metadati)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Intestazione file: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Selettore file non disponibile. Aggiorna il firmware per ispezionare un file locale.",
        ["File size: %s"] = "Dimensione file: %s",
        ["File: %s"] = "File: %s",
        ["Final device format: Not available from the player"] = "Formato finale del dispositivo: Non disponibile dal lettore",
        ["Final device format: Not reported by the player"] = "Formato finale del dispositivo: Non segnalato dal lettore",
        ["Format: %s"] = "Formato: %s",
        ["Gapless playback: %s"] = "Riproduzione senza pause (gapless): %s",
        ["Genre: %s"] = "Genere: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Stato analisi intestazione: Non supportato / Non valido",
        ["Headphone crossfeed is active at %.2f strength."] = "Crossfeed per cuffie attivo con intensità %.2f.",
        ["Headphone crossfeed state is unknown."] = "Lo stato del crossfeed per cuffie è sconosciuto.",
        ["Headphone crossfeed: %s%s"] = "Crossfeed cuffie: %s%s",
        ["High shelf"] = "High shelf",
        ["In order"] = "In ordine",
        ["Inspect a file"] = "Ispeziona un file",
        ["Inspector settings"] = "Impostazioni inspector",
        ["Invalid file path"] = "Percorso file non valido",
        ["Length: %s · %s"] = "Durata: %s · %s",
        ["Live or unknown length"] = "Dal vivo o durata sconosciuta",
        ["Local file"] = "File locale",
        ["Local file details"] = "Dettagli file locale",
        ["Local output format: %s · %s"] = "Formato uscita locale: %s · %s",
        ["Lossless compression"] = "Compressione senza perdita",
        ["Lossy"] = "Con perdita",
        ["Low shelf"] = "Low shelf",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "AIFF non valido: parametri audio non validi",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "AIFF non valido: blocco COMM mancante o troncato",
        ["Malformed FLAC: STREAMINFO block length too small"] = "FLAC non valido: lunghezza blocco STREAMINFO troppo piccola",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "FLAC non valido: il primo blocco metadati deve essere STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "FLAC non valido: parametri audio non validi in STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "WAV non valido: parametri audio non validi",
        ["Malformed WAV: missing or truncated fmt chunk"] = "WAV non valido: blocco fmt mancante o troncato",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Bande EQ manuali, preamplificazione e ampiezza stereo sono sostituite dall'MSEB predefinito se attivo.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Mono",
        ["Native DoP bypasses stock MSEB during playback."] = "Il DoP nativo bypassa l'MSEB predefinito durante la riproduzione.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "Il flusso hardware DoP nativo bypassa l'equalizzatore PCM, l'MSEB predefinito, l'ampiezza stereo e il volume software.",
        ["Neutral"] = "Neutro",
        ["No"] = "No",
        ["No Active Playback"] = "Nessuna riproduzione attiva",
        ["No changes detected (wired DoP candidate)"] = "Nessuna modifica rilevata (candidato DoP cablato)",
        ["No changes detected (wired PCM candidate)"] = "Nessuna modifica rilevata (candidato PCM cablato)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "Nessuna modifica rilevata negli stadi osservabili. La certificazione hardware non è verificabile da questa istantanea.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "Nessuna modifica rilevata negli stadi osservabili. È un candidato, non una prova dell'uscita hardware fisica.",
        ["Not classified by this inspector"] = "Non classificato da questo inspector",
        ["Not reported"] = "Non segnalato",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Nota: Ispezione limitata alle intestazioni WAV, FLAC, AIFF locali. Altri formati non vengono dedotti dall'estensione.",
        ["One-bit DSD audio"] = "Audio DSD a 1 bit",
        ["Opus"] = "Opus",
        ["Other observation"] = "Altra osservazione",
        ["Output active: %s"] = "Uscita attiva: %s",
        ["Output bit depth is unknown or invalid."] = "La profondità di bit di uscita è sconosciuta o non valida.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Profondità di uscita diversa: motore audio %d bit -> segnalato %d bit.",
        ["Output details"] = "Dettagli uscita",
        ["Output details unavailable"] = "Dettagli uscita non disponibili",
        ["Output device"] = "Dispositivo di uscita",
        ["Output is inactive"] = "L'uscita è inattiva",
        ["Output is inactive or its state is unknown."] = "L'uscita è inattiva o il suo stato è sconosciuto.",
        ["Output rate matches engine: %s"] = "Frequenza uscita corrisponde al motore: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Uscita DAC USB: conversione endpoint USB e mixer hardware non verificati; i soli campi PCM non provano l'uscita bit-perfect.",
        ["Output route: %s · %s"] = "Route di uscita: %s · %s",
        ["Output sample rate is unknown or invalid."] = "La frequenza di campionamento di uscita è sconosciuta o non valida.",
        ["Output sink DoP flag is not active."] = "Il flag DoP dell'uscita non è attivo.",
        ["PCM audio"] = "Audio PCM",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "L'equalizzatore parametrico ha %d bande abilitate; filtri e protezione picchi possono alterare i campioni.",
        ["Path is outside SD root"] = "Il percorso è esterno alla radice SD",
        ["Paused"] = "In pausa",
        ["Peaking"] = "Campana (peaking)",
        ["Per album"] = "Per album",
        ["Per track"] = "Per traccia",
        ["Play mode: %s"] = "Modalità di riproduzione: %s",
        ["Playback details"] = "Dettagli riproduzione",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Velocità di riproduzione modificata: %.4fx (DSP time-stretch attivo).",
        ["Playback speed state unavailable or invalid."] = "Stato velocità di riproduzione non disponibile o non valido.",
        ["Playback speed: %s"] = "Velocità di riproduzione: %s",
        ["Playback: %s · %s"] = "Riproduzione: %s · %s",
        ["Player output rate: %s · %s"] = "Frequenza uscita lettore: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Volume lettore: %s · separato dal guadagno audio software",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "La frequenza di uscita segnalata differisce dalla sorgente: %d Hz -> %d Hz.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "La frequenza di uscita segnalata non corrisponde alla portante DoP: %d Hz vs %.0f Hz.",
        ["Please close the other file picker and try again."] = "Chiudi l'altro selettore file e riprova.",
        ["Preamp gain: %s%s"] = "Guadagno preamplificatore: %s%s",
        ["Refresh output details"] = "Aggiorna dettagli uscita",
        ["Refresh playback details"] = "Aggiorna dettagli riproduzione",
        ["Refresh signal path check"] = "Aggiorna controllo percorso segnale",
        ["Refresh sound details"] = "Aggiorna dettagli audio",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "I flussi remoti non supportano l'ispezione diretta dell'intestazione; formato fornito dal decoder",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (adattamento volume): %s · traccia corrente applicata: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "Scalatura ReplayGain applicata: %+.2f dB.",
        ["ReplayGain state unavailable."] = "Stato ReplayGain non disponibile.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain segnalato come applicato, ma il guadagno è sconosciuto.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Ricampionamento attivo: sorgente %d Hz -> uscita %d Hz.",
        ["Result: %s"] = "Risultato: %s",
        ["Route: %s"] = "Route: %s",
        ["Sample Rate: %s"] = "Frequenza di campionamento: %s",
        ["Show full file paths"] = "Mostra percorsi file completi",
        ["Show music library tags"] = "Mostra tag della libreria musicale",
        ["Signal check"] = "Controllo segnale",
        ["Software audio gain: %s"] = "Guadagno audio software: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Volume software a guadagno unitario (1.00 / 0.0 dB - nessuna alterazione digitale PCM).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Scalatura volume software attiva: %.6fx (%s di modifica digitale).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Stato volume software non disponibile; impossibile verificare il guadagno unitario.",
        ["Sound processing"] = "Elaborazione audio",
        ["Source and audio engine rates match: %s"] = "Frequenze sorgente e motore audio corrispondono: %s",
        ["Source audio: %s · %s · %s"] = "Audio sorgente: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "La profondità di bit sorgente è sconosciuta o con perdita (nessuna profondità PCM originale).",
        ["Source channels count is unknown or invalid."] = "Il numero di canali sorgente è sconosciuto o non valido.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "Il codec sorgente è con perdita (%s): la decodifica con perdita non può certificare una riproduzione bit-perfect.",
        ["Source codec is unknown."] = "Il codec sorgente è sconosciuto.",
        ["Source quality: %s"] = "Qualità sorgente: %s",
        ["Source sample rate is unknown or invalid."] = "La frequenza di campionamento sorgente è sconosciuta o non valida.",
        ["Source: %s · %s"] = "Sorgente: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Avvia o riprendi la riproduzione per ispezionare il formato del decoder.",
        ["State unknown"] = "Stato sconosciuto",
        ["Stereo width is unknown or invalid."] = "L'ampiezza stereo è sconosciuta o non valida.",
        ["Stereo width processing is active: %.4f."] = "Elaborazione ampiezza stereo attiva: %.4f.",
        ["Stereo width: %s%s"] = "Ampiezza stereo: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "L'MSEB predefinito sovrascrive le bande EQ manuali, la preamplificazione e l'ampiezza stereo; crossfeed indipendente.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "L'elaborazione MSEB predefinita è abilitata con impostazioni non neutre.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Impostazioni MSEB incomplete o non valide; impossibile verificare un percorso PCM neutro.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Stato MSEB predefinito non disponibile; impossibile verificare il percorso di elaborazione PCM.",
        ["Stock MSEB: %s"] = "MSEB predefinito: %s",
        ["Stream name or endpoint: %s"] = "Nome del flusso o endpoint: %s",
        ["The active output route is unknown."] = "La route di uscita attiva è sconosciuta.",
        ["The external device's final conversion and output format are not visible here."] = "La conversione finale e il formato di uscita del dispositivo esterno non sono visibili qui.",
        ["The full equalizer band state is unavailable."] = "Lo stato completo delle bande dell'equalizzatore non è disponibile.",
        ["The local output format is not reported by the player."] = "Il formato di uscita locale non è segnalato dal lettore.",
        ["The player cannot compare the engine and output sample rates."] = "Il lettore non può confrontare le frequenze di campionamento del motore e dell'uscita.",
        ["The player reports different engine and output sample rates."] = "Il lettore segnala frequenze di campionamento diverse tra motore e uscita.",
        ["The remote device's final output format is not visible here."] = "Il formato di uscita finale del dispositivo remoto non è visibile qui.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "L'istantanea mostra una modifica o mancano informazioni per verificare un percorso inalterato.",
        ["This firmware does not expose a live equalizer snapshot."] = "Questo firmware non espone un'istantanea dell'equalizzatore in tempo reale.",
        ["This firmware does not expose a live output snapshot."] = "Questo firmware non espone un'istantanea dell'uscita in tempo reale.",
        ["Title: %s"] = "Titolo: %s",
        ["Track Inspector"] = "Inspector traccia",
        ["Track and file details"] = "Dettagli traccia e file",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Intestazione FLAC STREAMINFO troncata (meno di 42 byte)",
        ["Truncated file header (less than 12 bytes)"] = "Intestazione file troncata (meno di 12 byte)",
        ["Type: Uncompressed PCM"] = "Tipo: PCM non compresso",
        ["USB audio"] = "Audio USB",
        ["USB audio output is selected"] = "Uscita audio USB selezionata",
        ["USB output cannot be fully checked"] = "L'uscita USB non può essere verificata completamente",
        ["Uncompressed PCM"] = "PCM non compresso",
        ["Unknown"] = "Sconosciuto",
        ["Unknown (mode not reported)"] = "Sconosciuto (modalità non segnalata)",
        ["Unknown / Negotiating"] = "Sconosciuto / Negoziazione",
        ["Unknown / not reported"] = "Sconosciuto / non segnalato",
        ["Unknown filter"] = "Filtro sconosciuto",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Formato intestazione sconosciuto (ispezione limitata a WAV, FLAC, AIFF; formati non dedotti dall'estensione)",
        ["Unknown route"] = "Route sconosciuta",
        ["View all equalizer bands"] = "Visualizza tutte le bande equalizzatore",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (Compresso estensibile: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (Compresso: formato 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (Float estensibile)",
        ["WAV (Extensible PCM)"] = "WAV (PCM estensibile)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (PCM intero)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "Modalità WavPack lossless o ibrida e stato file di correzione non segnalati.",
        ["Wider or narrower stereo"] = "Stereo più ampio o più stretto",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Uscita cablata",
        ["Wired output is selected"] = "Uscita cablata selezionata",
        ["Yes"] = "Sì",
        ["active"] = "attivo",
        ["amount unknown"] = "quantità sconosciuta",
        ["differs from the engine"] = "differisce dal motore",
        ["forward-only"] = "solo avanti",
        ["gain unknown"] = "guadagno sconosciuto",
        ["matches the engine"] = "corrisponde al motore",
        ["seek status unknown"] = "stato posizionamento sconosciuto",
        ["seekable"] = "posizionabile",
        ["standby"] = "in attesa",
        ["status unknown"] = "stato sconosciuto",
        ["unity (0 dB)"] = "unitario (0 dB)",
    },
    ja = {
        [" · bypassed"] = " · バイパス",
        [" · normal"] = " · 標準",
        [" · stored; overridden by MSEB"] = " · 保存済み (MSEBにより無効)",
        [" · time stretch active"] = " · タイムストレッチ有効",
        ["%d bytes"] = "%d バイト",
        ["%d channels"] = "%d チャンネル",
        ["%d kbps"] = "%d kbps",
        ["%d%% strength"] = "%d%% 強度",
        ["%d-bit"] = "%d ビット",
        ["%d:%02d (%d s)"] = "%d:%02d (%d 秒)",
        ["%s elapsed"] = "%s 経過",
        ["%s · format unavailable"] = "%s · 形式利用不可",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (モノラル)",
        ["2 (Stereo)"] = "2 (ステレオ)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (圧縮: %s)",
        ["AIFC (Float)"] = "AIFC (浮動小数点)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (リトルエンディアン PCM)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "アクティブ出力形式: %s · %s",
        ["Active output format: Not available while output is inactive"] = "アクティブ出力形式: 出力が非アクティブな間は利用できません",
        ["Album artist: %s"] = "アルバムアーティスト: %s",
        ["Album: %s"] = "アルバム: %s",
        ["An EQ band's enabled state is unknown."] = "EQバンドの有効状態が不明です。",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "有効なEQバンドに認識できないフィルター形式があります。効果は不明です。",
        ["An enabled EQ filter has unknown gain."] = "有効なEQフィルターのゲインが不明です。",
        ["Applied ReplayGain: %s"] = "適用されたReplayGain: %s",
        ["Artist: %s"] = "アーティスト: %s",
        ["Audio engine format: %s · %s"] = "オーディオエンジン形式: %s · %s",
        ["Audio engine format: Unknown"] = "オーディオエンジン形式: 不明",
        ["Audio engine is idle; no active playback stream to inspect."] = "オーディオエンジンはアイドル状態です。検査対象の再生ストリームがありません。",
        ["Audio engine output: %s · %s"] = "オーディオエンジン出力: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "オーディオエンジンリサンプリング: ソース %s から %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "オーディオ形式: 不明 (アクティブなデコーダー情報なし)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "バンド %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "ビット深度: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "ビット深度拡張: ソース %d ビット -> 出力 %d ビット (パディングやディザの可能性。ビット透過性は未検証)。",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "ビット深度の切り捨て: ソース %d ビット -> 出力 %d ビット (ディザリングまたは精度の低下)。",
        ["Bitrate: %s"] = "ビットレート: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetoothにより音声が変化する可能性があります",
        ["Bluetooth codec: %s"] = "Bluetoothコーデック: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "Bluetoothエンコードにより音声が変化する可能性があります (%s)。受信機器の最終出力はここでは確認できません。",
        ["Bypassed"] = "バイパス",
        ["Change or unknown detail"] = "変更点または未確認の詳細",
        ["Changes detected or information unavailable"] = "変更が検出されたか、情報が取得できません",
        ["Changes to this setting take effect with the next track."] = "この設定の変更は次のトラックから有効になります。",
        ["Channels: %s"] = "チャンネル: %s",
        ["Codec: %s"] = "コーデック: %s",
        ["Could not open file picker. Please try again."] = "ファイル選択を開けませんでした。もう一度お試しください。",
        ["Could not open file picker: %s"] = "ファイル選択を開けませんでした: %s",
        ["Could not open file: %s"] = "ファイルを開けませんでした: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "クロスフェードが有効です。トラックが現在ミキシング中かどうかは報告されません。",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "クロスフェード設定: %s · 現在のミキシング状態は非公開",
        ["Crossfeed angle: %.1f°"] = "Crossfeed角度: %.1f°",
        ["Crossfeed delay: none"] = "Crossfeed遅延: なし",
        ["DSD audio"] = "DSD オーディオ",
        ["DSD carrier rate: %s · expected %s"] = "DSDキャリアレート: %s · 期待値 %s",
        ["DSD converted to PCM at %s"] = "DSDをPCMに変換 (%s)",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSDはPCMに変換されます。以下のサウンド設定が再生に影響する場合があります。",
        ["DSD playback: converted to PCM"] = "DSD再生: PCMに変換中",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "DSDストリームがPCMに変換されました (デシメーション有効。ネイティブDSD直接パススルーではありません)。",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "DSD-over-PCMキャリアが有効です。PCM処理はバイパスされます",
        ["DSD-over-PCM carrier: %s"] = "DSD-over-PCMキャリア: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "DSD-over-PCM再生はイコライザーおよびその他のPCM処理をバイパスします。",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "DSDからPCMへのデシメーションが有効: DSDビットストリームはPCMに変換され、PCM DSPフィルタリングの対象となります。",
        ["Detail: %s"] = "詳細: %s",
        ["Disabled"] = "無効",
        ["DoP active but codec is not DSD."] = "DoPがアクティブですがコーデックがDSDではありません。",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "DoPキャリア深度が不足しています: %s (24ビットキャリアが必要)。",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "DoPキャリアフレーミング: %s 1ビットDSDストリームが %s %s PCMキャリアフレームにカプセル化。PCM DSPはバイパスされます。",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "DoPキャリアレートの不一致: DSDでは %.1f kHz が必要ですが、%s を受信しました。",
        ["Duration: %s"] = "再生時間: %s",
        ["EQ bands configuration missing."] = "EQバンド設定が見つかりません。",
        ["EQ digital preamp gain active: %+.2f dB."] = "EQデジタルプリアンプゲイン有効: %+.2f dB。",
        ["EQ preamp gain is unknown or invalid."] = "EQプリアンプゲインが不明または無効です。",
        ["Enabled equalizer bands: %d / 10"] = "有効なEQバンド: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "有効なEQバンド: 完全には報告されていません",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "エンコード: 圧縮オーディオ · ロスレス性はヘッダーから未確認",
        ["Encoding: Lossless compressed audio"] = "エンコード: 可逆圧縮オーディオ",
        ["Equalizer bands"] = "イコライザーバンド",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "イコライザーバイパスはプリアンプ、ステレオ幅、Crossfeed、フィルターもスキップします。",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "イコライザーバイパスが有効: プリアンプ、ステレオ幅、バンドフィルターはスキップ。Crossfeedは独立して動作します。",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "イコライザーバイパスが有効: プリアンプ、ステレオ幅、Crossfeed、バンドフィルターはスキップされます。",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "イコライザーバイパスはプリアンプ、ステレオ幅、フィルターをスキップします。Crossfeedは独立して動作します。",
        ["Equalizer details unavailable"] = "イコライザー詳細が利用できません",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "イコライザーの状態が取得できないため、フラットなDSP経路を確認できません。",
        ["Equalizer: %s"] = "イコライザー: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "推定コンテナビットレート: %s (コンテナ/メタデータオーバーヘッドを含む)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "ファイルヘッダー: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "ファイル選択を利用できません。ローカルファイルを検査するにはファームウェアを更新してください。",
        ["File size: %s"] = "ファイルサイズ: %s",
        ["File: %s"] = "ファイル: %s",
        ["Final device format: Not available from the player"] = "最終デバイス形式: プレーヤーから取得できません",
        ["Final device format: Not reported by the player"] = "最終デバイス形式: プレーヤーから報告されていません",
        ["Format: %s"] = "形式: %s",
        ["Gapless playback: %s"] = "ギャップレス再生: %s",
        ["Genre: %s"] = "ジャンル: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "ヘッダー解析ステータス: 非対応 / 不正な形式",
        ["Headphone crossfeed is active at %.2f strength."] = "ヘッドホンCrossfeedが強度 %.2f で有効です。",
        ["Headphone crossfeed state is unknown."] = "ヘッドホンのCrossfeed状態が不明です。",
        ["Headphone crossfeed: %s%s"] = "ヘッドホンCrossfeed: %s%s",
        ["High shelf"] = "ハイシェルフ",
        ["In order"] = "順番通り",
        ["Inspect a file"] = "ファイルを検査",
        ["Inspector settings"] = "インスペクター設定",
        ["Invalid file path"] = "無効なファイルパス",
        ["Length: %s · %s"] = "長さ: %s · %s",
        ["Live or unknown length"] = "ライブまたは長さ不明",
        ["Local file"] = "ローカルファイル",
        ["Local file details"] = "ローカルファイル詳細",
        ["Local output format: %s · %s"] = "ローカル出力形式: %s · %s",
        ["Lossless compression"] = "可逆圧縮",
        ["Lossy"] = "非可逆",
        ["Low shelf"] = "ローシェルフ",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "不正なAIFF: 無効なオーディオパラメータ",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "不正なAIFF: COMMチャンクが存在しないか不完全です",
        ["Malformed FLAC: STREAMINFO block length too small"] = "不正なFLAC: STREAMINFOブロック長が小さすぎます",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "不正なFLAC: 最初のメタデータブロックはSTREAMINFOである必要があります",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "不正なFLAC: STREAMINFO内のオーディオパラメータが無効です",
        ["Malformed WAV: invalid audio parameters"] = "不正なWAV: 無効なオーディオパラメータ",
        ["Malformed WAV: missing or truncated fmt chunk"] = "不正なWAV: fmtチャンクが存在しないか不完全です",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "手動EQバンド、プリアンプ、ステレオ幅は、標準MSEBが有効な間オーバーライドされます。",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "モノラル",
        ["Native DoP bypasses stock MSEB during playback."] = "ネイティブDoP再生中は標準MSEBがバイパスされます。",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "ネイティブDoPハードウェアストリームは、PCMイコライザー、標準MSEB、ステレオ幅、ソフトウェア音量をバイパスします。",
        ["Neutral"] = "ニュートラル",
        ["No"] = "いいえ",
        ["No Active Playback"] = "アクティブな再生がありません",
        ["No changes detected (wired DoP candidate)"] = "変更は検出されませんでした (有線DoP候補)",
        ["No changes detected (wired PCM candidate)"] = "変更は検出されませんでした (有線PCM候補)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "確認可能な再生ステージに変更は検出されませんでした。この情報から物理ハードウェア出力を証明することはできません。",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "確認可能な再生ステージに変更は検出されませんでした。これは候補であり、物理ハードウェア出力の証明ではありません。",
        ["Not classified by this inspector"] = "このインスペクターでは未分類です",
        ["Not reported"] = "未報告",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "注: 検査はローカルのWAV、FLAC、AIFFヘッダーに限定されます。他の形式は拡張子から推測せず不明と報告されます。",
        ["One-bit DSD audio"] = "1ビット DSD オーディオ",
        ["Opus"] = "Opus",
        ["Other observation"] = "その他の観察事項",
        ["Output active: %s"] = "出力アクティブ: %s",
        ["Output bit depth is unknown or invalid."] = "出力ビット深度が不明または無効です。",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "出力ビット深度が異なります: オーディオエンジン %d ビット -> プレーヤー報告 %d ビット。",
        ["Output details"] = "出力詳細",
        ["Output details unavailable"] = "出力詳細が利用できません",
        ["Output device"] = "出力デバイス",
        ["Output is inactive"] = "出力が非アクティブです",
        ["Output is inactive or its state is unknown."] = "出力が非アクティブまたは状態が不明です。",
        ["Output rate matches engine: %s"] = "出力レートがエンジンと一致: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "出力ルートはUSB DACです。外部USBエンドポイント変換とミキサー形式は未検証のため、PCM一致だけではビットパーフェクト出力を証明できません。",
        ["Output route: %s · %s"] = "出力ルート: %s · %s",
        ["Output sample rate is unknown or invalid."] = "出力サンプリングレートが不明または無効です。",
        ["Output sink DoP flag is not active."] = "出力シンクのDoPフラグがアクティブではありません。",
        ["PCM audio"] = "PCM オーディオ",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "パラメトリックEQで %d 個のバンドが有効です。フラット応答であってもフィルター処理やピーク保護がサンプルに影響する場合があります。",
        ["Path is outside SD root"] = "パスがSDルートの外部です",
        ["Paused"] = "一時停止",
        ["Peaking"] = "ピーキング",
        ["Per album"] = "アルバムごと",
        ["Per track"] = "トラックごと",
        ["Play mode: %s"] = "再生モード: %s",
        ["Playback details"] = "再生詳細",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "再生速度が変更されています: %.4fx (タイムストレッチDSP有効)。",
        ["Playback speed state unavailable or invalid."] = "再生速度の状態が取得できないか無効です。",
        ["Playback speed: %s"] = "再生速度: %s",
        ["Playback: %s · %s"] = "再生: %s · %s",
        ["Player output rate: %s · %s"] = "プレーヤー出力レート: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "プレーヤー音量: %s · ソフトウェア音声ゲインとは別枠",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "報告された出力レートがソースと異なります: %d Hz -> %d Hz。",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "報告された出力レートがDoPキャリアと一致しません: %d Hz vs %.0f Hz。",
        ["Please close the other file picker and try again."] = "別のファイル選択を閉じてからもう一度お試しください。",
        ["Preamp gain: %s%s"] = "プリアンプゲイン: %s%s",
        ["Refresh output details"] = "出力詳細を更新",
        ["Refresh playback details"] = "再生詳細を更新",
        ["Refresh signal path check"] = "信号経路チェックを更新",
        ["Refresh sound details"] = "サウンド詳細を更新",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "リモートストリームはヘッダー直接検査に未対応です。フォーマットはデコーダー情報から取得されます",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (音量マッチング): %s · 現在のトラックに適用: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "ReplayGainスケーリング適用中: %+.2f dB。",
        ["ReplayGain state unavailable."] = "ReplayGainの状態が取得できません。",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGainが適用されていると報告されましたが、ゲイン量は不明です。",
        ["Resampling active: source %d Hz -> output %d Hz."] = "リサンプリング有効: ソース %d Hz -> 出力 %d Hz。",
        ["Result: %s"] = "結果: %s",
        ["Route: %s"] = "ルート: %s",
        ["Sample Rate: %s"] = "サンプリングレート: %s",
        ["Show full file paths"] = "完全なファイルパスを表示",
        ["Show music library tags"] = "音楽ライブラリのタグを表示",
        ["Signal check"] = "信号チェック",
        ["Software audio gain: %s"] = "ソフトウェア音声ゲイン: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "ソフトウェア音量はユニティゲインです (1.00 / 0.0 dB - デジタルPCMスケーリングなし)。",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "ソフトウェア音量スケーリング有効: %.6fx (%s デジタル変更)。",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "ソフトウェア音量の状態が取得できないため、ユニティゲインを確認できません。",
        ["Sound processing"] = "サウンド処理",
        ["Source and audio engine rates match: %s"] = "ソースとオーディオエンジンのレートが一致: %s",
        ["Source audio: %s · %s · %s"] = "ソースオーディオ: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "ソースのビット深度が不明または非可逆です (元のPCM深度がありません)。",
        ["Source channels count is unknown or invalid."] = "ソースチャンネル数が不明または無効です。",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "ソースコーデックは非可逆です (%s): 非可逆デコードでは元のPCMマスターのビットパーフェクト再生を保証できません。",
        ["Source codec is unknown."] = "ソースコーデックが不明です。",
        ["Source quality: %s"] = "ソース品質: %s",
        ["Source sample rate is unknown or invalid."] = "ソースサンプリングレートが不明または無効です。",
        ["Source: %s · %s"] = "ソース: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "再生を開始または再開して、デコーダーのライブ形式を検査します。",
        ["State unknown"] = "状態不明",
        ["Stereo width is unknown or invalid."] = "ステレオ幅が不明または無効です。",
        ["Stereo width processing is active: %.4f."] = "ステレオ幅処理が有効です: %.4f。",
        ["Stereo width: %s%s"] = "ステレオ幅: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "標準MSEBは保存された手動EQバンド、プリアンプ、ステレオ幅をオーバーライドします。Crossfeedは独立して動作します。",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "標準MSEB処理が非ニュートラルな設定で有効になっています。",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "標準MSEB設定が不完全または無効です。ニュートラルなPCM経路を確認できません。",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "標準MSEBの状態が取得できません。PCM処理経路を確認できません。",
        ["Stock MSEB: %s"] = "標準MSEB: %s",
        ["Stream name or endpoint: %s"] = "ストリーム名またはエンドポイント: %s",
        ["The active output route is unknown."] = "アクティブな出力ルートが不明です。",
        ["The external device's final conversion and output format are not visible here."] = "外部機器の最終変換および出力形式はここでは確認できません。",
        ["The full equalizer band state is unavailable."] = "完全なイコライザーバンドの状態が取得できません。",
        ["The local output format is not reported by the player."] = "ローカル出力形式はプレーヤーから報告されていません。",
        ["The player cannot compare the engine and output sample rates."] = "プレーヤーはエンジンと出力のサンプリングレートを比較できません。",
        ["The player reports different engine and output sample rates."] = "プレーヤーが報告するエンジンと出力のサンプリングレートが異なります。",
        ["The remote device's final output format is not visible here."] = "リモート機器の最終出力形式はここでは確認できません。",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "スナップショットに変更が検出されたか、信号経路の無変更を検証するための情報が不足しています。",
        ["This firmware does not expose a live equalizer snapshot."] = "このファームウェアはイコライザーのライブ情報を公開していません。",
        ["This firmware does not expose a live output snapshot."] = "このファームウェアは出力のライブ情報を公開していません。",
        ["Title: %s"] = "タイトル: %s",
        ["Track Inspector"] = "トラックインスペクター",
        ["Track and file details"] = "トラックとファイルの詳細",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "FLAC STREAMINFOヘッダーが切り詰められています (42バイト未満)",
        ["Truncated file header (less than 12 bytes)"] = "ファイルヘッダーが切り詰められています (12バイト未満)",
        ["Type: Uncompressed PCM"] = "種類: 非圧縮 PCM",
        ["USB audio"] = "USB オーディオ",
        ["USB audio output is selected"] = "USBオーディオ出力が選択されています",
        ["USB output cannot be fully checked"] = "USB出力を完全に検証することはできません",
        ["Uncompressed PCM"] = "非圧縮 PCM",
        ["Unknown"] = "不明",
        ["Unknown (mode not reported)"] = "不明 (モード未報告)",
        ["Unknown / Negotiating"] = "不明 / 交渉中",
        ["Unknown / not reported"] = "不明 / 未報告",
        ["Unknown filter"] = "不明なフィルター",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "不明なヘッダー形式 (検査はWAV、FLAC、AIFFヘッダーに限定。拡張子からは推測されません)",
        ["Unknown route"] = "不明なルート",
        ["View all equalizer bands"] = "すべてのEQバンドを表示",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (圧縮拡張: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (圧縮: 形式 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (拡張浮動小数点)",
        ["WAV (Extensible PCM)"] = "WAV (拡張 PCM)",
        ["WAV (IEEE Float)"] = "WAV (IEEE 浮動小数点)",
        ["WAV (PCM Integer)"] = "WAV (PCM 整数)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "WavPackのロスレス/ハイブリッドモードおよび補正ファイルの状態が未報告です。",
        ["Wider or narrower stereo"] = "広域または狭域ステレオ",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "有線出力",
        ["Wired output is selected"] = "有線出力が選択されています",
        ["Yes"] = "はい",
        ["active"] = "アクティブ",
        ["amount unknown"] = "値不明",
        ["differs from the engine"] = "エンジンと異なります",
        ["forward-only"] = "前方のみ",
        ["gain unknown"] = "ゲイン不明",
        ["matches the engine"] = "エンジンと一致",
        ["seek status unknown"] = "シーク状態不明",
        ["seekable"] = "シーク可能",
        ["standby"] = "スタンバイ",
        ["status unknown"] = "状態不明",
        ["unity (0 dB)"] = "ユニティ (0 dB)",
    },
    nl = {
        [" · bypassed"] = " · omzeild",
        [" · normal"] = " · normaal",
        [" · stored; overridden by MSEB"] = " · opgeslagen; overschreven door MSEB",
        [" · time stretch active"] = " · time-stretch actief",
        ["%d bytes"] = "%d bytes",
        ["%d channels"] = "%d kanalen",
        ["%d kbps"] = "%d kbps",
        ["%d%% strength"] = "%d%% sterkte",
        ["%d-bit"] = "%d-bit",
        ["%d:%02d (%d s)"] = "%d:%02d (%d s)",
        ["%s elapsed"] = "%s verstreken",
        ["%s · format unavailable"] = "%s · formaat niet beschikbaar",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (Mono)",
        ["2 (Stereo)"] = "2 (Stereo)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (Gecomprimeerd: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (Little-Endian PCM)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Actief uitvoerformaat: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Actief uitvoerformaat: Niet beschikbaar terwijl uitvoer inactief is",
        ["Album artist: %s"] = "Albumartiest: %s",
        ["Album: %s"] = "Album: %s",
        ["An EQ band's enabled state is unknown."] = "Ingeschakelde status van een EQ-band is onbekend.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Een ingeschakelde EQ-band heeft een onbekend filtertype; effect is onbekend.",
        ["An enabled EQ filter has unknown gain."] = "Een ingeschakeld EQ-filter heeft onbekende versterking.",
        ["Applied ReplayGain: %s"] = "Toegepaste ReplayGain: %s",
        ["Artist: %s"] = "Artiest: %s",
        ["Audio engine format: %s · %s"] = "Audio-engine-formaat: %s · %s",
        ["Audio engine format: Unknown"] = "Audio-engine-formaat: Onbekend",
        ["Audio engine is idle; no active playback stream to inspect."] = "Audio-engine is inactief; geen actieve weergavestream om te inspecteren.",
        ["Audio engine output: %s · %s"] = "Audio-engine-uitvoer: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Audio-engine-resampling: %s bron naar %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Audioformaat: Onbekend (geen actieve decoder-momentopname)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Band %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Bitdiepte: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Bitdiepte uitgebreid: bron %d-bit -> uitvoer %d-bit (mogelijke opvulling of dither; transparantie niet geverifieerd).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Bitdiepte afgekapt: bron %d-bit -> uitvoer %d-bit (dithering of precisieverlies).",
        ["Bitrate: %s"] = "Bitrate: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth kan audio wijzigen",
        ["Bluetooth codec: %s"] = "Bluetooth-codec: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "Bluetooth-codering kan de audio wijzigen (%s); de uiteindelijke uitvoer van het ontvangende apparaat is hier niet zichtbaar.",
        ["Bypassed"] = "Omzeild",
        ["Change or unknown detail"] = "Wijziging of onbekend detail",
        ["Changes detected or information unavailable"] = "Wijzigingen gedetecteerd of informatie niet beschikbaar",
        ["Changes to this setting take effect with the next track."] = "Wijzigingen worden van kracht bij het volgende nummer.",
        ["Channels: %s"] = "Kanalen: %s",
        ["Codec: %s"] = "Codec: %s",
        ["Could not open file picker. Please try again."] = "Kon bestandskiezer niet openen. Probeer het opnieuw.",
        ["Could not open file picker: %s"] = "Kon bestandskiezer niet openen: %s",
        ["Could not open file: %s"] = "Kan bestand niet openen: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade is ingeschakeld; de speler meldt niet of nummers momenteel worden gemixt.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Crossfade-instelling: %s · huidige mengstatus niet zichtbaar",
        ["Crossfeed angle: %.1f°"] = "Crossfeed-hoek: %.1f°",
        ["Crossfeed delay: none"] = "Crossfeed-vertraging: geen",
        ["DSD audio"] = "DSD-audio",
        ["DSD carrier rate: %s · expected %s"] = "DSD-dragersnelheid: %s · verwacht %s",
        ["DSD converted to PCM at %s"] = "DSD geconverteerd naar PCM op %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD wordt geconverteerd naar PCM; de onderstaande geluidsinstellingen kunnen de weergave beïnvloeden.",
        ["DSD playback: converted to PCM"] = "DSD-weergave: geconverteerd naar PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "DSD-stream geconverteerd naar PCM (decimatie actief; geen native directe DSD-passthrough).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "DSD-over-PCM-drager is actief; PCM-verwerking wordt omzeild",
        ["DSD-over-PCM carrier: %s"] = "DSD-over-PCM-drager: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "DSD-over-PCM-weergave omzeilt de equalizer en andere PCM-verwerking.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "DSD-naar-PCM-decimatie actief: DSD-bitstream wordt geconverteerd naar PCM en ondergaat PCM-DSP-filtering.",
        ["Detail: %s"] = "Detail: %s",
        ["Disabled"] = "Uitgeschakeld",
        ["DoP active but codec is not DSD."] = "DoP actief maar codec is geen DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "DoP-dragerdiepte onvoldoende: kreeg %s (vereist 24-bit drager).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "DoP-dragerframing: %s 1-bit DSD-stream verpakt in %s %s PCM-dragerframes; PCM-DSP-keten omzeild.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "DoP-dragersnelheid komt niet overeen: verwacht %.1f kHz voor DSD, kreeg %s.",
        ["Duration: %s"] = "Duur: %s",
        ["EQ bands configuration missing."] = "Configuratie van EQ-banden ontbreekt.",
        ["EQ digital preamp gain active: %+.2f dB."] = "EQ digitale voorversterkingsversterking actief: %+.2f dB.",
        ["EQ preamp gain is unknown or invalid."] = "EQ-voorversterkingsversterking is onbekend of ongeldig.",
        ["Enabled equalizer bands: %d / 10"] = "Ingeschakelde EQ-banden: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Ingeschakelde EQ-banden: Niet volledig gemeld",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Codering: Gecomprimeerde audio · losslessness niet bevestigd door deze header",
        ["Encoding: Lossless compressed audio"] = "Codering: Lossless gecomprimeerde audio",
        ["Equalizer bands"] = "Equalizerbanden",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "Equalizer-bypass slaat ook voorversterking, stereobreedte, crossfeed en filters over.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Equalizer-bypass actief; voorversterking, stereobreedte en filters overgeslagen. Crossfeed blijft onafhankelijk.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Equalizer-bypass actief; voorversterking, stereobreedte, crossfeed en filters worden overgeslagen.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "Equalizer-bypass slaat voorversterking, stereobreedte en filters over; crossfeed blijft onafhankelijk.",
        ["Equalizer details unavailable"] = "Equalizerdetails niet beschikbaar",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Equalizerstatus niet beschikbaar; kan vlak DSP-pad niet verifiëren.",
        ["Equalizer: %s"] = "Equalizer: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Geschatte containerbitrate: %s (inclusief container/metadata-overhead)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Bestandsheader: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Bestandskiezer niet beschikbaar. Werk de firmware bij om een lokaal bestand te inspecteren.",
        ["File size: %s"] = "Bestandsgrootte: %s",
        ["File: %s"] = "Bestand: %s",
        ["Final device format: Not available from the player"] = "Uiteindelijk apparaatformaat: Niet beschikbaar via de speler",
        ["Final device format: Not reported by the player"] = "Uiteindelijk apparaatformaat: Niet gemeld door de speler",
        ["Format: %s"] = "Formaat: %s",
        ["Gapless playback: %s"] = "Gapless afspelen: %s",
        ["Genre: %s"] = "Genre: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Header-parsestatus: Niet ondersteund / Ongeldig",
        ["Headphone crossfeed is active at %.2f strength."] = "Hoofdtelefoon-crossfeed is actief met sterkte %.2f.",
        ["Headphone crossfeed state is unknown."] = "Hoofdtelefoon-crossfeedstatus is onbekend.",
        ["Headphone crossfeed: %s%s"] = "Hoofdtelefoon-crossfeed: %s%s",
        ["High shelf"] = "High-shelf",
        ["In order"] = "Op volgorde",
        ["Inspect a file"] = "Bestand inspecteren",
        ["Inspector settings"] = "Inspector-instellingen",
        ["Invalid file path"] = "Ongeldig bestandspad",
        ["Length: %s · %s"] = "Lengte: %s · %s",
        ["Live or unknown length"] = "Live of onbekende lengte",
        ["Local file"] = "Lokaal bestand",
        ["Local file details"] = "Lokale bestandsdetails",
        ["Local output format: %s · %s"] = "Lokaal uitvoerformaat: %s · %s",
        ["Lossless compression"] = "Lossless compressie",
        ["Lossy"] = "Lossy",
        ["Low shelf"] = "Low-shelf",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "Ongeldig AIFF: ongeldige audioparameters",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "Ongeldig AIFF: COMM-blok ontbreekt of is afgekapt",
        ["Malformed FLAC: STREAMINFO block length too small"] = "Ongeldig FLAC: STREAMINFO-bloklengte te klein",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "Ongeldig FLAC: eerste metadatablok moet STREAMINFO zijn",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "Ongeldig FLAC: ongeldige audioparameters in STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "Ongeldig WAV: ongeldige audioparameters",
        ["Malformed WAV: missing or truncated fmt chunk"] = "Ongeldig WAV: fmt-blok ontbreekt of is afgekapt",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Handmatige EQ-banden, voorversterking en stereobreedte worden overschreven door standaard MSEB zolang ingeschakeld.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Mono",
        ["Native DoP bypasses stock MSEB during playback."] = "Native DoP omzeilt standaard MSEB tijdens afspelen.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "Native DoP-hardwarestream omzeilt PCM-equalizer, standaard MSEB, stereobreedte en softwarevolume.",
        ["Neutral"] = "Neutraal",
        ["No"] = "Nee",
        ["No Active Playback"] = "Geen actieve weergave",
        ["No changes detected (wired DoP candidate)"] = "Geen wijzigingen gedetecteerd (bekabelde DoP-kandidaat)",
        ["No changes detected (wired PCM candidate)"] = "Geen wijzigingen gedetecteerd (bekabelde PCM-kandidaat)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "Geen wijzigingen gedetecteerd in waarneembare fasen. Hardwarecertificering is niet beschikbaar via deze momentopname.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "Geen wijzigingen gedetecteerd in waarneembare fasen. Dit is een kandidaat, geen bewijs van fysieke hardware-uitvoer.",
        ["Not classified by this inspector"] = "Niet geclassificeerd door deze inspector",
        ["Not reported"] = "Niet gemeld",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Opmerking: Inspectie beperkt tot lokale WAV-, FLAC-, AIFF-headers. Andere formaten worden niet geraden op basis van extensie.",
        ["One-bit DSD audio"] = "1-bit DSD-audio",
        ["Opus"] = "Opus",
        ["Other observation"] = "Overige waarneming",
        ["Output active: %s"] = "Uitvoer actief: %s",
        ["Output bit depth is unknown or invalid."] = "Uitvoerbitdiepte is onbekend of ongeldig.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Uitvoerdiepte verschilt: audio-engine %d-bit -> speler meldt %d-bit.",
        ["Output details"] = "Uitvoerdetails",
        ["Output details unavailable"] = "Uitvoerdetails niet beschikbaar",
        ["Output device"] = "Uitvoerapparaat",
        ["Output is inactive"] = "Uitgang is inactief",
        ["Output is inactive or its state is unknown."] = "Uitgang is inactief of status is onbekend.",
        ["Output rate matches engine: %s"] = "Uitvoersnelheid komt overeen met engine: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Uitvoerroute is USB-DAC: externe USB-conversie en hardwaremixer zijn niet geverifieerd; overeenkomende PCM bewijst geen bit-perfecte uitvoer.",
        ["Output route: %s · %s"] = "Uitvoerroute: %s · %s",
        ["Output sample rate is unknown or invalid."] = "Uitgangssamplersnelheid is onbekend of ongeldig.",
        ["Output sink DoP flag is not active."] = "DoP-vlag van uitvoerapparaat is niet actief.",
        ["PCM audio"] = "PCM-audio",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "Parametrische EQ heeft %d ingeschakelde band(en); filtering en piekbeveiliging kunnen samples beïnvloeden.",
        ["Path is outside SD root"] = "Pad ligt buiten SD-root",
        ["Paused"] = "Gepauzeerd",
        ["Peaking"] = "Peaking",
        ["Per album"] = "Per album",
        ["Per track"] = "Per nummer",
        ["Play mode: %s"] = "Afspeelmodus: %s",
        ["Playback details"] = "Afspeeldetails",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Afspeelsnelheid gewijzigd: %.4fx (time-stretching-DSP actief).",
        ["Playback speed state unavailable or invalid."] = "Afspeelsnelheidsstatus niet beschikbaar of ongeldig.",
        ["Playback speed: %s"] = "Afspeelsnelheid: %s",
        ["Playback: %s · %s"] = "Weergave: %s · %s",
        ["Player output rate: %s · %s"] = "Speleruitvoersnelheid: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Spelervolume: %s · los van software-audioversterking",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "Speler meldt afwijkende uitvoersnelheid van bron: %d Hz -> %d Hz.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "Speleruitvoersnelheid komt niet overeen met DoP-drager: %d Hz vs %.0f Hz.",
        ["Please close the other file picker and try again."] = "Sluit de andere bestandskiezer en probeer het opnieuw.",
        ["Preamp gain: %s%s"] = "Voorversterkingsversterking: %s%s",
        ["Refresh output details"] = "Uitvoerdetails vernieuwen",
        ["Refresh playback details"] = "Afspeeldetails vernieuwen",
        ["Refresh signal path check"] = "Signaalpadcontrole vernieuwen",
        ["Refresh sound details"] = "Geluidsdetails vernieuwen",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Externe streams ondersteunen geen directe header-inspectie; formaat geleverd door decoder",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (luidheidsaanpassing): %s · huidige nummer toegepast: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "ReplayGain-schaling toegepast: %+.2f dB.",
        ["ReplayGain state unavailable."] = "ReplayGain-status niet beschikbaar.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain is gemeld als toegepast, maar de versterkingswaarde is onbekend.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Resampling actief: bron %d Hz -> uitvoer %d Hz.",
        ["Result: %s"] = "Resultaat: %s",
        ["Route: %s"] = "Route: %s",
        ["Sample Rate: %s"] = "Samplefrequentie: %s",
        ["Show full file paths"] = "Volledige bestandspaden weergeven",
        ["Show music library tags"] = "Muziekbibliotheektags weergeven",
        ["Signal check"] = "Signaalcontrole",
        ["Software audio gain: %s"] = "Software-audioversterking: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Softwarevolume op unity gain (1.00 / 0.0 dB - geen digitale PCM-schaling).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Softwarevolumeschaling actief: %.6fx (%s digitale wijziging).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Softwarevolumestatus niet beschikbaar; kan unity gain niet verifiëren.",
        ["Sound processing"] = "Geluidsverwerking",
        ["Source and audio engine rates match: %s"] = "Bron- en audio-enginesnelheden komen overeen: %s",
        ["Source audio: %s · %s · %s"] = "Bronaudio: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "Bronbitdiepte is onbekend of lossy (geen originele PCM-diepte).",
        ["Source channels count is unknown or invalid."] = "Aantal bronkanalen is onbekend of ongeldig.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "Broncodec is lossy (%s): lossy decodering kan geen bit-perfecte weergave garanderen.",
        ["Source codec is unknown."] = "Broncodec is onbekend.",
        ["Source quality: %s"] = "Bronkwaliteit: %s",
        ["Source sample rate is unknown or invalid."] = "Béronsamplersnelheid is onbekend of ongeldig.",
        ["Source: %s · %s"] = "Bron: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Start of hervat het afspelen om het live-formaat van de decoder te inspecteren.",
        ["State unknown"] = "Status onbekend",
        ["Stereo width is unknown or invalid."] = "Stereobreedte is onbekend of ongeldig.",
        ["Stereo width processing is active: %.4f."] = "Stereobreedteverwerking is actief: %.4f.",
        ["Stereo width: %s%s"] = "Stereobreedte: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "Standaard MSEB overschrijft handmatige EQ-banden, voorversterking en stereobreedte; crossfeed blijft onafhankelijk.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "Standaard MSEB-verwerking is ingeschakeld met niet-neutrale instellingen.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Standaard MSEB-instellingen zijn onvolledig of ongeldig; kan neutraal PCM-pad niet verifiëren.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Standaard MSEB-status is niet beschikbaar; kan het PCM-verwerkingspad niet verifiëren.",
        ["Stock MSEB: %s"] = "Standaard MSEB: %s",
        ["Stream name or endpoint: %s"] = "Streamnaam of eindpunt: %s",
        ["The active output route is unknown."] = "De actieve uitvoerroute is onbekend.",
        ["The external device's final conversion and output format are not visible here."] = "Uiteindelijke conversie en uitvoerformaat van extern apparaat zijn hier niet zichtbaar.",
        ["The full equalizer band state is unavailable."] = "Volledige status van equalizerbanden is niet beschikbaar.",
        ["The local output format is not reported by the player."] = "Het lokale uitvoerformaat wordt niet gemeld door de speler.",
        ["The player cannot compare the engine and output sample rates."] = "De speler kan de samplefrequenties van engine en uitvoer niet vergelijken.",
        ["The player reports different engine and output sample rates."] = "De speler meldt verschillende samplefrequenties voor engine en uitvoer.",
        ["The remote device's final output format is not visible here."] = "Het uiteindelijke uitvoerformaat van het externe apparaat is hier niet zichtbaar.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "De momentopname toont een wijziging of biedt onvoldoende informatie om een ongewijzigd signaalpad te verifiëren.",
        ["This firmware does not expose a live equalizer snapshot."] = "Deze firmware biedt geen live equalizer-momentopname.",
        ["This firmware does not expose a live output snapshot."] = "Deze firmware biedt geen live uitvoermomentopname.",
        ["Title: %s"] = "Titel: %s",
        ["Track Inspector"] = "Track Inspector",
        ["Track and file details"] = "Nummer- en bestandsdetails",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Afgekapt FLAC STREAMINFO-header (minder dan 42 bytes)",
        ["Truncated file header (less than 12 bytes)"] = "Afgekapt bestandsheader (minder dan 12 bytes)",
        ["Type: Uncompressed PCM"] = "Type: Ongecomprimeerde PCM",
        ["USB audio"] = "USB-audio",
        ["USB audio output is selected"] = "USB-audio-uitvoer is geselecteerd",
        ["USB output cannot be fully checked"] = "USB-uitvoer kan niet volledig worden gecontroleerd",
        ["Uncompressed PCM"] = "Ongecomprimeerde PCM",
        ["Unknown"] = "Onbekend",
        ["Unknown (mode not reported)"] = "Onbekend (modus niet gemeld)",
        ["Unknown / Negotiating"] = "Onbekend / Onderhandelen",
        ["Unknown / not reported"] = "Onbekend / niet gemeld",
        ["Unknown filter"] = "Onbekend filter",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Onbekend headerformaat (inspectie beperkt tot WAV, FLAC, AIFF; formaten worden niet afgeleid uit extensie)",
        ["Unknown route"] = "Onbekende route",
        ["View all equalizer bands"] = "Alle equalizerbanden bekijken",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (Gecomprimeerd uitbreidbaar: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (Gecomprimeerd: formaat 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (Uitbreidbaar Float)",
        ["WAV (Extensible PCM)"] = "WAV (Uitbreidbaar PCM)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (PCM geheel getal)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "WavPack lossless- of hybridemodus en status van correctiebestand niet gemeld.",
        ["Wider or narrower stereo"] = "Bredere of smallere stereo",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Bekabelde uitvoer",
        ["Wired output is selected"] = "Bekabelde uitvoer is geselecteerd",
        ["Yes"] = "Ja",
        ["active"] = "actief",
        ["amount unknown"] = "waarde onbekend",
        ["differs from the engine"] = "wijkt af van engine",
        ["forward-only"] = "alleen vooruit",
        ["gain unknown"] = "versterking onbekend",
        ["matches the engine"] = "komt overeen met engine",
        ["seek status unknown"] = "spoelstatus onbekend",
        ["seekable"] = "spoelbaar",
        ["standby"] = "stand-by",
        ["status unknown"] = "status onbekend",
        ["unity (0 dB)"] = "unity (0 dB)",
    },
    pt = {
        [" · bypassed"] = " · ignorado",
        [" · normal"] = " · normal",
        [" · stored; overridden by MSEB"] = " · armazenado; substituído por MSEB",
        [" · time stretch active"] = " · extensão temporal ativa",
        ["%d bytes"] = "%d bytes",
        ["%d channels"] = "%d canais",
        ["%d kbps"] = "%d kbps",
        ["%d%% strength"] = "%d%% intensidade",
        ["%d-bit"] = "%d bits",
        ["%d:%02d (%d s)"] = "%d:%02d (%d s)",
        ["%s elapsed"] = "%s decorrido",
        ["%s · format unavailable"] = "%s · formato indisponível",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (Mono)",
        ["2 (Stereo)"] = "2 (Estéreo)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (Comprimido: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (PCM Little-Endian)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Formato de saída ativo: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Formato de saída ativo: Não disponível enquanto a saída estiver inativa",
        ["Album artist: %s"] = "Artista do álbum: %s",
        ["Album: %s"] = "Álbum: %s",
        ["An EQ band's enabled state is unknown."] = "O estado ativado de uma banda de EQ é desconhecido.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Uma banda de EQ ativada tem tipo de filtro não reconhecido; efeito desconhecido.",
        ["An enabled EQ filter has unknown gain."] = "Um filtro de EQ ativado tem ganho desconhecido.",
        ["Applied ReplayGain: %s"] = "ReplayGain aplicado: %s",
        ["Artist: %s"] = "Artista: %s",
        ["Audio engine format: %s · %s"] = "Formato do mecanismo de áudio: %s · %s",
        ["Audio engine format: Unknown"] = "Formato do mecanismo de áudio: Desconhecido",
        ["Audio engine is idle; no active playback stream to inspect."] = "O mecanismo de áudio está inativo; nenhum fluxo de reprodução ativo para inspecionar.",
        ["Audio engine output: %s · %s"] = "Saída do mecanismo de áudio: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Reamostragem do mecanismo de áudio: origem %s para %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Formato de áudio: Desconhecido (nenhuma captura ativa do decodificador)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Banda %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Profundidade de bits: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Profundidade de bits expandida: origem %d bits -> saída %d bits (possível preenchimento ou dither; transparência não verificada).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Truncamento de bits: origem %d bits -> saída %d bits (dithering ou perda de precisão).",
        ["Bitrate: %s"] = "Taxa de bits: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth pode alterar o áudio",
        ["Bluetooth codec: %s"] = "Codec Bluetooth: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "A codificação Bluetooth pode alterar o áudio (%s); a saída final do dispositivo receptor não é visível aqui.",
        ["Bypassed"] = "Ignorado",
        ["Change or unknown detail"] = "Alteração ou detalhe desconhecido",
        ["Changes detected or information unavailable"] = "Alterações detectadas ou informações indisponíveis",
        ["Changes to this setting take effect with the next track."] = "As alterações entrarão em vigor com a próxima faixa.",
        ["Channels: %s"] = "Canais: %s",
        ["Codec: %s"] = "Codec: %s",
        ["Could not open file picker. Please try again."] = "Não foi possível abrir o seletor de arquivos. Tente novamente.",
        ["Could not open file picker: %s"] = "Não foi possível abrir o seletor de arquivos: %s",
        ["Could not open file: %s"] = "Não foi possível abrir o arquivo: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "O crossfade está ativado; o reprodutor não informa se as faixas estão sendo mixadas agora.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Configuração de crossfade: %s · estado de mixagem não exposto",
        ["Crossfeed angle: %.1f°"] = "Ângulo do crossfeed: %.1f°",
        ["Crossfeed delay: none"] = "Atraso do crossfeed: nenhum",
        ["DSD audio"] = "Áudio DSD",
        ["DSD carrier rate: %s · expected %s"] = "Taxa da portadora DSD: %s · esperado %s",
        ["DSD converted to PCM at %s"] = "DSD convertido para PCM a %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD é convertido para PCM; as configurações de som abaixo podem afetar a reprodução.",
        ["DSD playback: converted to PCM"] = "Reprodução DSD: convertida para PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "Fluxo DSD convertido para PCM (decimação ativa; não é passthrough direto DSD nativo).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "A portadora DSD-over-PCM está ativa; o processamento PCM é ignorado",
        ["DSD-over-PCM carrier: %s"] = "Portadora DSD-over-PCM: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "A reprodução DSD-over-PCM ignora o equalizador e outros processamentos PCM.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "Decimação DSD para PCM ativa: o fluxo DSD é convertido para PCM e sujeito à filtragem DSP PCM.",
        ["Detail: %s"] = "Detalhe: %s",
        ["Disabled"] = "Desativado",
        ["DoP active but codec is not DSD."] = "DoP ativo, mas o codec não é DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "Profundidade da portadora DoP insuficiente: obtido %s (requer portadora de 24 bits).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "Encapsulamento DoP: fluxo DSD de 1 bit %s empacotado em quadros PCM %s %s; cadeia DSP PCM ignorada.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "Incompatibilidade de taxa da portadora DoP: esperado %.1f kHz para DSD, obtido %s.",
        ["Duration: %s"] = "Duração: %s",
        ["EQ bands configuration missing."] = "Configuração das bandas de EQ ausente.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Ganho do pré-amplificador digital de EQ ativo: %+.2f dB.",
        ["EQ preamp gain is unknown or invalid."] = "O ganho do pré-amplificador de EQ é desconhecido ou inválido.",
        ["Enabled equalizer bands: %d / 10"] = "Bandas de EQ ativadas: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Bandas de EQ ativadas: Não totalmente informadas",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Codificação: Áudio comprimido · ausência de perdas não confirmada pelo cabeçalho",
        ["Encoding: Lossless compressed audio"] = "Codificação: Áudio comprimido sem perdas",
        ["Equalizer bands"] = "Bandas do equalizador",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "O bypass do equalizador também ignora pré-amplificador, largura estéreo, crossfeed e filtros.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Bypass do equalizador ativo; pré-amplificador, largura estéreo e filtros ignorados. O crossfeed permanece independente.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Bypass do equalizador ativo; pré-amplificador, largura estéreo, crossfeed e filtros são ignorados.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "O bypass do equalizador ignora pré-amplificador, largura estéreo e filtros; crossfeed permanece independente.",
        ["Equalizer details unavailable"] = "Detalhes do equalizador indisponíveis",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Estado do equalizador indisponível; não é possível verificar caminho DSP plano.",
        ["Equalizer: %s"] = "Equalizador: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Taxa de bits estimada do contêiner: %s (inclui contêiner/metadados)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Cabeçalho do arquivo: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Seletor de arquivos indisponível. Atualize o firmware para inspecionar um arquivo local.",
        ["File size: %s"] = "Tamanho do arquivo: %s",
        ["File: %s"] = "Arquivo: %s",
        ["Final device format: Not available from the player"] = "Formato final do dispositivo: Não disponível no reprodutor",
        ["Final device format: Not reported by the player"] = "Formato final do dispositivo: Não informado pelo reprodutor",
        ["Format: %s"] = "Formato: %s",
        ["Gapless playback: %s"] = "Reprodução sem pausas (gapless): %s",
        ["Genre: %s"] = "Gênero: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Status de análise do cabeçalho: Não suportado / Malformado",
        ["Headphone crossfeed is active at %.2f strength."] = "Crossfeed para fones ativo com intensidade %.2f.",
        ["Headphone crossfeed state is unknown."] = "O estado do crossfeed para fones é desconhecido.",
        ["Headphone crossfeed: %s%s"] = "Crossfeed para fones: %s%s",
        ["High shelf"] = "High shelf",
        ["In order"] = "Em ordem",
        ["Inspect a file"] = "Inspecionar um arquivo",
        ["Inspector settings"] = "Ajustes do inspetor",
        ["Invalid file path"] = "Caminho de arquivo inválido",
        ["Length: %s · %s"] = "Duração: %s · %s",
        ["Live or unknown length"] = "Ao vivo ou duração desconhecida",
        ["Local file"] = "Arquivo local",
        ["Local file details"] = "Detalhes do arquivo local",
        ["Local output format: %s · %s"] = "Formato de saída local: %s · %s",
        ["Lossless compression"] = "Compressão sem perdas",
        ["Lossy"] = "Com perdas",
        ["Low shelf"] = "Low shelf",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "AIFF malformado: parâmetros de áudio inválidos",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "AIFF malformado: bloco COMM ausente ou truncado",
        ["Malformed FLAC: STREAMINFO block length too small"] = "FLAC malformado: tamanho do bloco STREAMINFO pequeno demais",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "FLAC malformado: o primeiro bloco de metadados deve ser STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "FLAC malformado: parâmetros de áudio inválidos em STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "WAV malformado: parâmetros de áudio inválidos",
        ["Malformed WAV: missing or truncated fmt chunk"] = "WAV malformado: bloco fmt ausente ou truncado",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Bandas de EQ manual, pré-amplificador e largura estéreo são substituídos pelo MSEB padrão enquanto ativado.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Mono",
        ["Native DoP bypasses stock MSEB during playback."] = "DoP nativo ignora o MSEB padrão durante a reprodução.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "O fluxo de hardware DoP nativo ignora o equalizador PCM, o MSEB padrão, a largura estéreo e o volume por software.",
        ["Neutral"] = "Neutro",
        ["No"] = "Não",
        ["No Active Playback"] = "Nenhuma reprodução ativa",
        ["No changes detected (wired DoP candidate)"] = "Nenhuma alteração detectada (candidato DoP com fio)",
        ["No changes detected (wired PCM candidate)"] = "Nenhuma alteração detectada (candidato PCM com fio)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "Nenhuma alteração detectada nos estágios observáveis. A certificação de hardware não está disponível por esta captura.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "Nenhuma alteração detectada nos estágios observáveis. Este é um candidato, não uma prova da saída física do hardware.",
        ["Not classified by this inspector"] = "Não classificado por este inspetor",
        ["Not reported"] = "Não informado",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Nota: Inspeção limitada a cabeçalhos locais WAV, FLAC, AIFF. Outros formatos são relatados como desconhecidos sem deduzir pela extensão.",
        ["One-bit DSD audio"] = "Áudio DSD de 1 bit",
        ["Opus"] = "Opus",
        ["Other observation"] = "Outra observação",
        ["Output active: %s"] = "Saída ativa: %s",
        ["Output bit depth is unknown or invalid."] = "A profundidade de bits de saída é desconhecida ou inválida.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Profundidade diferente: mecanismo de áudio %d bits -> reprodutor relata %d bits.",
        ["Output details"] = "Detalhes de saída",
        ["Output details unavailable"] = "Detalhes de saída indisponíveis",
        ["Output device"] = "Dispositivo de saída",
        ["Output is inactive"] = "A saída está inativa",
        ["Output is inactive or its state is unknown."] = "A saída está inativa ou seu estado é desconhecido.",
        ["Output rate matches engine: %s"] = "Taxa de saída corresponde ao mecanismo: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Saída em DAC USB: conversão externa USB e mixer de hardware não verificados; campos PCM correspondentes não comprovam saída bit-perfect.",
        ["Output route: %s · %s"] = "Rota de saída: %s · %s",
        ["Output sample rate is unknown or invalid."] = "A taxa de amostragem de saída é desconhecida ou inválida.",
        ["Output sink DoP flag is not active."] = "A flag DoP do destino de saída não está ativa.",
        ["PCM audio"] = "Áudio PCM",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "O EQ paramétrico tem %d banda(s) ativada(s); filtros e proteção contra picos podem afetar as amostras.",
        ["Path is outside SD root"] = "O caminho está fora da raiz do SD",
        ["Paused"] = "Pausado",
        ["Peaking"] = "Pico (peaking)",
        ["Per album"] = "Por álbum",
        ["Per track"] = "Por faixa",
        ["Play mode: %s"] = "Modo de reprodução: %s",
        ["Playback details"] = "Detalhes da reprodução",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Velocidade de reprodução modificada: %.4fx (DSP de extensão temporal ativo).",
        ["Playback speed state unavailable or invalid."] = "Estado da velocidade de reprodução indisponível ou inválido.",
        ["Playback speed: %s"] = "Velocidade de reprodução: %s",
        ["Playback: %s · %s"] = "Reprodução: %s · %s",
        ["Player output rate: %s · %s"] = "Taxa de saída do reprodutor: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Volume do reprodutor: %s · separado do ganho de áudio por software",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "A taxa de saída informada difere da origem: %d Hz -> %d Hz.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "A taxa de saída informada não corresponde à portadora DoP: %d Hz vs %.0f Hz.",
        ["Please close the other file picker and try again."] = "Feche o outro seletor de arquivos e tente novamente.",
        ["Preamp gain: %s%s"] = "Ganho do pré-amplificador: %s%s",
        ["Refresh output details"] = "Atualizar detalhes de saída",
        ["Refresh playback details"] = "Atualizar detalhes da reprodução",
        ["Refresh signal path check"] = "Atualizar verificação do sinal",
        ["Refresh sound details"] = "Atualizar detalhes do som",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Transmissões remotas não suportam inspeção direta de cabeçalho; formato obtido pelo decodificador",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (nivelamento de volume): %s · faixa atual aplicada: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "Escala de ReplayGain aplicada: %+.2f dB.",
        ["ReplayGain state unavailable."] = "Estado do ReplayGain indisponível.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain foi informado como aplicado, mas seu ganho é desconhecido.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Reamostragem ativa: origem %d Hz -> saída %d Hz.",
        ["Result: %s"] = "Resultado: %s",
        ["Route: %s"] = "Rota: %s",
        ["Sample Rate: %s"] = "Taxa de amostragem: %s",
        ["Show full file paths"] = "Mostrar caminhos completos dos arquivos",
        ["Show music library tags"] = "Mostrar tags da biblioteca de música",
        ["Signal check"] = "Verificação de sinal",
        ["Software audio gain: %s"] = "Ganho de áudio por software: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Volume por software em ganho unitário (1.00 / 0.0 dB - sem escala digital PCM).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Escala de volume por software ativa: %.6fx (%s de modificação digital).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Estado do volume por software indisponível; não é possível verificar ganho unitário.",
        ["Sound processing"] = "Processamento de som",
        ["Source and audio engine rates match: %s"] = "Taxas de origem e do mecanismo correspondem: %s",
        ["Source audio: %s · %s · %s"] = "Áudio de origem: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "A profundidade de bits de origem é desconhecida ou lossy (sem profundidade PCM original).",
        ["Source channels count is unknown or invalid."] = "A contagem de canais de origem é desconhecida ou inválida.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "O codec de origem é lossy (%s): decodificação com perdas não garante reprodução bit-perfect.",
        ["Source codec is unknown."] = "O codec de origem é desconhecido.",
        ["Source quality: %s"] = "Qualidade de origem: %s",
        ["Source sample rate is unknown or invalid."] = "A taxa de amostragem de origem é desconhecida ou inválida.",
        ["Source: %s · %s"] = "Origem: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Inicie ou retome a reprodução para inspecionar o formato ao vivo do decodificador.",
        ["State unknown"] = "Estado desconhecido",
        ["Stereo width is unknown or invalid."] = "A largura estéreo é desconhecida ou inválida.",
        ["Stereo width processing is active: %.4f."] = "Processamento de largura estéreo ativo: %.4f.",
        ["Stereo width: %s%s"] = "Largura estéreo: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "O MSEB padrão substitui as bandas de EQ manual, pré-amplificador e largura estéreo; crossfeed permanece independente.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "O processamento MSEB padrão está ativado com configurações não neutras.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Configurações do MSEB incompletas ou inválidas; não é possível verificar caminho PCM neutro.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Estado do MSEB padrão indisponível; não é possível verificar o caminho de processamento PCM.",
        ["Stock MSEB: %s"] = "MSEB padrão: %s",
        ["Stream name or endpoint: %s"] = "Nome da transmissão ou endpoint: %s",
        ["The active output route is unknown."] = "A rota de saída ativa é desconhecida.",
        ["The external device's final conversion and output format are not visible here."] = "A conversão final e o formato de saída do dispositivo externo não são visíveis aqui.",
        ["The full equalizer band state is unavailable."] = "O estado completo das bandas do equalizador não está disponível.",
        ["The local output format is not reported by the player."] = "O formato de saída local não é informado pelo reprodutor.",
        ["The player cannot compare the engine and output sample rates."] = "O reprodutor não pode comparar as taxas de amostragem do mecanismo e da saída.",
        ["The player reports different engine and output sample rates."] = "O reprodutor relata taxas de amostragem diferentes para o mecanismo e a saída.",
        ["The remote device's final output format is not visible here."] = "O formato de saída final do dispositivo remoto não é visível aqui.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "A captura mostra alterações ou não possui informações para verificar um caminho inalterado.",
        ["This firmware does not expose a live equalizer snapshot."] = "Este firmware não expõe uma captura do equalizador em tempo real.",
        ["This firmware does not expose a live output snapshot."] = "Este firmware não expõe uma captura de saída em tempo real.",
        ["Title: %s"] = "Título: %s",
        ["Track Inspector"] = "Inspetor de faixas",
        ["Track and file details"] = "Detalhes da faixa e do arquivo",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Cabeçalho STREAMINFO do FLAC truncado (menos de 42 bytes)",
        ["Truncated file header (less than 12 bytes)"] = "Cabeçalho de arquivo truncado (menos de 12 bytes)",
        ["Type: Uncompressed PCM"] = "Tipo: PCM não comprimido",
        ["USB audio"] = "Áudio USB",
        ["USB audio output is selected"] = "Saída de áudio USB selecionada",
        ["USB output cannot be fully checked"] = "A saída USB não pode ser totalmente verificada",
        ["Uncompressed PCM"] = "PCM não comprimido",
        ["Unknown"] = "Desconhecido",
        ["Unknown (mode not reported)"] = "Desconhecido (modo não informado)",
        ["Unknown / Negotiating"] = "Desconhecido / Negociando",
        ["Unknown / not reported"] = "Desconhecido / não informado",
        ["Unknown filter"] = "Filtro desconhecido",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Formato de cabeçalho desconhecido (inspeção limitada a WAV, FLAC, AIFF; formatos não deduzidos da extensão)",
        ["Unknown route"] = "Rota desconhecida",
        ["View all equalizer bands"] = "Ver todas as bandas do equalizador",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (Comprimido extensível: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (Comprimido: formato 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (Float extensível)",
        ["WAV (Extensible PCM)"] = "WAV (PCM extensível)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (PCM inteiro)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "Modo lossless ou híbrido do WavPack e arquivo de correção não informados.",
        ["Wider or narrower stereo"] = "Estéreo mais amplo ou estreito",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Saída com fio",
        ["Wired output is selected"] = "Saída com fio selecionada",
        ["Yes"] = "Sim",
        ["active"] = "ativo",
        ["amount unknown"] = "valor desconhecido",
        ["differs from the engine"] = "difere do mecanismo",
        ["forward-only"] = "somente avanço",
        ["gain unknown"] = "ganho desconhecido",
        ["matches the engine"] = "corresponde ao mecanismo",
        ["seek status unknown"] = "status de busca desconhecido",
        ["seekable"] = "com busca",
        ["standby"] = "em espera",
        ["status unknown"] = "status desconhecido",
        ["unity (0 dB)"] = "unitário (0 dB)",
    },
    ru = {
        [" · bypassed"] = " · обойдено",
        [" · normal"] = " · обычная",
        [" · stored; overridden by MSEB"] = " · сохранено; переопределено MSEB",
        [" · time stretch active"] = " · тайм-стретчинг активен",
        ["%d bytes"] = "%d байт",
        ["%d channels"] = "%d каналов",
        ["%d kbps"] = "%d кбит/с",
        ["%d%% strength"] = "%d%% интенсивность",
        ["%d-bit"] = "%d бит",
        ["%d:%02d (%d s)"] = "%d:%02d (%d с)",
        ["%s elapsed"] = "%s прошло",
        ["%s · format unavailable"] = "%s · формат недоступен",
        ["-inf dB"] = "-inf дБ",
        ["1 (Mono)"] = "1 (Моно)",
        ["2 (Stereo)"] = "2 (Стерео)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (сжатый: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (Little-Endian PCM)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Активный формат вывода: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Активный формат вывода: Недоступно, пока выход неактивен",
        ["Album artist: %s"] = "Исполнитель альбома: %s",
        ["Album: %s"] = "Альбом: %s",
        ["An EQ band's enabled state is unknown."] = "Состояние активности полосы EQ неизвестно.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Включенная полоса EQ имеет неизвестный тип фильтра; эффект неясен.",
        ["An enabled EQ filter has unknown gain."] = "Включенный фильтр EQ имеет неизвестное усиление.",
        ["Applied ReplayGain: %s"] = "Примененный ReplayGain: %s",
        ["Artist: %s"] = "Исполнитель: %s",
        ["Audio engine format: %s · %s"] = "Формат аудиодвижка: %s · %s",
        ["Audio engine format: Unknown"] = "Формат аудиодвижка: Неизвестно",
        ["Audio engine is idle; no active playback stream to inspect."] = "Аудиодвижок неактивен; нет активного потока для проверки.",
        ["Audio engine output: %s · %s"] = "Вывод аудиодвижка: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Ресемплинг аудиодвижка: источник %s в %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Аудиоформат: Неизвестно (нет активного снимка декодера)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Полоса %d · %s · %s Гц · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Разрядность: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Разрядность расширена: источник %d бит -> выход %d бит (возможен паддинг или дизеринг; прозрачность не подтверждена).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Усечение разрядности: источник %d бит -> выход %d бит (дизеринг или потеря точности).",
        ["Bitrate: %s"] = "Битрейт: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth может изменить звук",
        ["Bluetooth codec: %s"] = "Кодек Bluetooth: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "Кодирование Bluetooth может изменить звук (%s); конечный вывод принимающего устройства здесь не виден.",
        ["Bypassed"] = "Обойдено",
        ["Change or unknown detail"] = "Изменение или неизвестная деталь",
        ["Changes detected or information unavailable"] = "Обнаружены изменения или информация недоступна",
        ["Changes to this setting take effect with the next track."] = "Изменения вступят в силу со следующего трека.",
        ["Channels: %s"] = "Каналы: %s",
        ["Codec: %s"] = "Кодек: %s",
        ["Could not open file picker. Please try again."] = "Не удалось открыть выбор файлов. Попробуйте еще раз.",
        ["Could not open file picker: %s"] = "Не удалось открыть выбор файлов: %s",
        ["Could not open file: %s"] = "Не удалось открыть файл: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade включен; плеер не сообщает, микшируются ли треки в данный момент.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Настройка Crossfade: %s · текущее микширование не отображается",
        ["Crossfeed angle: %.1f°"] = "Угол crossfeed: %.1f°",
        ["Crossfeed delay: none"] = "Задержка crossfeed: нет",
        ["DSD audio"] = "Аудио DSD",
        ["DSD carrier rate: %s · expected %s"] = "Частота несущей DSD: %s · ожидалось %s",
        ["DSD converted to PCM at %s"] = "DSD преобразован в PCM на %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD преобразуется в PCM; приведенные ниже настройки звука могут влиять на воспроизведение.",
        ["DSD playback: converted to PCM"] = "Воспроизведение DSD: преобразовано в PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "Поток DSD преобразован в PCM (активна децимация; не прямой нативный DSD).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "Несущая DSD-over-PCM активна; обработка PCM обойдена",
        ["DSD-over-PCM carrier: %s"] = "Несущая DSD-over-PCM: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "Воспроизведение DSD-over-PCM обходит эквалайзер и другую обработку PCM.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "Активна децимация DSD в PCM: поток DSD конвертируется в PCM и проходит обработку PCM DSP.",
        ["Detail: %s"] = "Детали: %s",
        ["Disabled"] = "Отключено",
        ["DoP active but codec is not DSD."] = "DoP активен, но кодек не DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "Недостаточная глубина несущей DoP: получено %s (требуется 24-битная несущая).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "Фрейминг DoP: 1-битный поток DSD %s упакован в кадры несущей PCM %s %s; DSP-цепь PCM обойдена.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "Несоответствие частоты несущей DoP: ожидалось %.1f кГц для DSD, получено %s.",
        ["Duration: %s"] = "Длительность: %s",
        ["EQ bands configuration missing."] = "Конфигурация полос EQ отсутствует.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Активно цифровое усиление преампа EQ: %+.2f дБ.",
        ["EQ preamp gain is unknown or invalid."] = "Усиление преампа EQ неизвестно или недопустимо.",
        ["Enabled equalizer bands: %d / 10"] = "Включено полос эквалайзера: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Включено полос эквалайзера: Не сообщается полностью",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Кодирование: Сжатое аудио · сжатие без потерь не подтверждено заголовком",
        ["Encoding: Lossless compressed audio"] = "Кодирование: Сжатое аудио без потерь",
        ["Equalizer bands"] = "Полосы эквалайзера",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "Байпас эквалайзера также пропускает преамп, ширину стерео, crossfeed и фильтры.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Байпас эквалайзера активен; преамп, ширина стерео и фильтры пропущены. Crossfeed остается независимым.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Байпас эквалайзера активен; преамп, ширина стерео, crossfeed и фильтры пропущены.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "Байпас эквалайзера пропускает преамп, ширину стерео и фильтры; crossfeed остается независимым.",
        ["Equalizer details unavailable"] = "Сведения об эквалайзере недоступны",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Состояние эквалайзера недоступно; невозможно подтвердить линейный путь DSP.",
        ["Equalizer: %s"] = "Эквалайзер: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Примерный битрейт контейнера: %s (включает накладные расходы контейнера)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Заголовок файла: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Выбор файлов недоступен. Обновите прошивку для проверки локального файла.",
        ["File size: %s"] = "Размер файла: %s",
        ["File: %s"] = "Файл: %s",
        ["Final device format: Not available from the player"] = "Окончательный формат устройства: Недоступно из плеера",
        ["Final device format: Not reported by the player"] = "Окончательный формат устройства: Не сообщается плеером",
        ["Format: %s"] = "Формат: %s",
        ["Gapless playback: %s"] = "Воспроизведение без пауз (gapless): %s",
        ["Genre: %s"] = "Жанр: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Анализ заголовка: Не поддерживается / Поврежден",
        ["Headphone crossfeed is active at %.2f strength."] = "Crossfeed для наушников активен с силой %.2f.",
        ["Headphone crossfeed state is unknown."] = "Состояние crossfeed для наушников неизвестно.",
        ["Headphone crossfeed: %s%s"] = "Crossfeed для наушников: %s%s",
        ["High shelf"] = "High-shelf",
        ["In order"] = "По порядку",
        ["Inspect a file"] = "Проверить файл",
        ["Inspector settings"] = "Настройки инспектора",
        ["Invalid file path"] = "Недопустимый путь к файлу",
        ["Length: %s · %s"] = "Длина: %s · %s",
        ["Live or unknown length"] = "Прямой эфир или неизвестная длина",
        ["Local file"] = "Локальный файл",
        ["Local file details"] = "Сведения о локальном файле",
        ["Local output format: %s · %s"] = "Локальный формат вывода: %s · %s",
        ["Lossless compression"] = "Сжатие без потерь",
        ["Lossy"] = "С потерями",
        ["Low shelf"] = "Low-shelf",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "Поврежденный AIFF: недопустимые аудиопараметры",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "Поврежденный AIFF: блок COMM отсутствует или усечен",
        ["Malformed FLAC: STREAMINFO block length too small"] = "Поврежденный FLAC: длина блока STREAMINFO слишком мала",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "Поврежденный FLAC: первым блоком метаданных должен быть STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "Поврежденный FLAC: недопустимые аудиопараметры в STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "Поврежденный WAV: недопустимые аудиопараметры",
        ["Malformed WAV: missing or truncated fmt chunk"] = "Поврежденный WAV: блок fmt отсутствует или усечен",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Полосы ручного эквалайзера, преамп и ширина стерео переопределяются стандартным MSEB, пока он включен.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Моно",
        ["Native DoP bypasses stock MSEB during playback."] = "Нативный DoP обходит стандартный MSEB при воспроизведении.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "Нативный аппаратный поток DoP обходит эквалайзер PCM, стандартный MSEB, ширину стерео и программную громкость.",
        ["Neutral"] = "Нейтрально",
        ["No"] = "Нет",
        ["No Active Playback"] = "Нет активного воспроизведения",
        ["No changes detected (wired DoP candidate)"] = "Изменения не обнаружены (проводной кандидат DoP)",
        ["No changes detected (wired PCM candidate)"] = "Изменения не обнаружены (проводной кандидат PCM)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "В наблюдаемых стадиях изменений не обнаружено. Аппаратная сертификация недоступна из этого снимка.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "В наблюдаемых стадиях изменений не обнаружено. Это кандидат, а не подтверждение физического вывода устройства.",
        ["Not classified by this inspector"] = "Не классифицировано этим инспектором",
        ["Not reported"] = "Не сообщается",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Примечание: Проверка только локальных заголовков WAV, FLAC, AIFF. Другие форматы не угадываются по расширению.",
        ["One-bit DSD audio"] = "1-битное аудио DSD",
        ["Opus"] = "Opus",
        ["Other observation"] = "Другое наблюдение",
        ["Output active: %s"] = "Выход активен: %s",
        ["Output bit depth is unknown or invalid."] = "Выходная разрядность неизвестна или недопустима.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Разрядность отличается: аудиодвижок %d бит -> плеер сообщает %d бит.",
        ["Output details"] = "Сведения о выводе",
        ["Output details unavailable"] = "Сведения о выводе недоступны",
        ["Output device"] = "Устройство вывода",
        ["Output is inactive"] = "Выход неактивен",
        ["Output is inactive or its state is unknown."] = "Выход неактивен или его состояние неизвестно.",
        ["Output rate matches engine: %s"] = "Частота вывода совпадает с движком: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Вывод на USB-ЦАП: преобразование конечной точки USB и аппаратный микшер не проверены; совпадение полей PCM не гарантирует bit-perfect.",
        ["Output route: %s · %s"] = "Маршрут вывода: %s · %s",
        ["Output sample rate is unknown or invalid."] = "Выходная частота дискретизации неизвестна или недопустима.",
        ["Output sink DoP flag is not active."] = "Флаг DoP приемника вывода не активен.",
        ["PCM audio"] = "Аудио PCM",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "Параметрический EQ имеет %d активных полос; фильтрация и защита от пиков могут влиять на сэмплы.",
        ["Path is outside SD root"] = "Путь находится вне корня SD-карты",
        ["Paused"] = "Пауза",
        ["Peaking"] = "Колокол (peaking)",
        ["Per album"] = "По альбомам",
        ["Per track"] = "По трекам",
        ["Play mode: %s"] = "Режим воспроизведения: %s",
        ["Playback details"] = "Сведения о воспроизведении",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Скорость воспроизведения изменена: %.4fx (активен DSP тайм-стретчинга).",
        ["Playback speed state unavailable or invalid."] = "Состояние скорости воспроизведения недоступно или недопустимо.",
        ["Playback speed: %s"] = "Скорость воспроизведения: %s",
        ["Playback: %s · %s"] = "Воспроизведение: %s · %s",
        ["Player output rate: %s · %s"] = "Частота вывода плеера: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Громкость плеера: %s · отдельно от программного усиления",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "Сообщенная частота вывода отличается от источника: %d Гц -> %d Гц.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "Выходная частота не совпадает с несущей DoP: %d Гц против %.0f Гц.",
        ["Please close the other file picker and try again."] = "Закройте другое окно выбора файлов и повторите попытку.",
        ["Preamp gain: %s%s"] = "Усиление преампа: %s%s",
        ["Refresh output details"] = "Обновить сведения о выводе",
        ["Refresh playback details"] = "Обновить сведения о воспроизведении",
        ["Refresh signal path check"] = "Обновить проверку пути сигнала",
        ["Refresh sound details"] = "Обновить сведения о звуке",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Удаленные потоки не поддерживают проверку заголовка; формат получен из декодера",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (выравнивание громкости): %s · применено к треку: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "Применено выравнивание ReplayGain: %+.2f дБ.",
        ["ReplayGain state unavailable."] = "Состояние ReplayGain недоступно.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain отмечен как примененный, но величина усиления неизвестна.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Ресемплинг активен: источник %d Гц -> выход %d Гц.",
        ["Result: %s"] = "Результат: %s",
        ["Route: %s"] = "Маршрут: %s",
        ["Sample Rate: %s"] = "Частота дискретизации: %s",
        ["Show full file paths"] = "Показывать полные пути к файлам",
        ["Show music library tags"] = "Показывать теги медиатеки",
        ["Signal check"] = "Проверка сигнала",
        ["Software audio gain: %s"] = "Программное усиление звука: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Программная громкость на единичном усилении (1.00 / 0.0 дБ - без цифрового масштабирования PCM).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Программное масштабирование громкости активно: %.6fx (%s цифровая модификация).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Состояние программной громкости недоступно; невозможно проверить единичное усиление.",
        ["Sound processing"] = "Обработка звука",
        ["Source and audio engine rates match: %s"] = "Частоты источника и аудиодвижка совпадают: %s",
        ["Source audio: %s · %s · %s"] = "Исходный звук: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "Разрядность источника неизвестна или сжата с потерями (нет исходной глубины PCM).",
        ["Source channels count is unknown or invalid."] = "Число исходных каналов неизвестно или недопустимо.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "Исходный кодек с потерями (%s): декодирование с потерями не гарантирует точность bit-perfect.",
        ["Source codec is unknown."] = "Исходный кодек неизвестен.",
        ["Source quality: %s"] = "Качество источника: %s",
        ["Source sample rate is unknown or invalid."] = "Исходная частота дискретизации неизвестна или недопустима.",
        ["Source: %s · %s"] = "Источник: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Запустите или возобновите воспроизведение для проверки живого формата декодера.",
        ["State unknown"] = "Состояние неизвестно",
        ["Stereo width is unknown or invalid."] = "Ширина стерео неизвестна или недопустима.",
        ["Stereo width processing is active: %.4f."] = "Обработка ширины стерео активна: %.4f.",
        ["Stereo width: %s%s"] = "Ширина стерео: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "Стандартный MSEB переопределяет ручные полосы EQ, преамп и ширину стерео; crossfeed независим.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "Обработка стандартного MSEB включена с ненейтральными настройками.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Настройки MSEB неполны или недействительны; невозможно подтвердить нейтральный путь PCM.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Состояние стандартного MSEB недоступно; невозможно проверить путь обработки PCM.",
        ["Stock MSEB: %s"] = "Стандартный MSEB: %s",
        ["Stream name or endpoint: %s"] = "Имя потока или адрес: %s",
        ["The active output route is unknown."] = "Активный маршрут вывода неизвестен.",
        ["The external device's final conversion and output format are not visible here."] = "Окончательное преобразование и формат вывода внешнего устройства здесь не видны.",
        ["The full equalizer band state is unavailable."] = "Полное состояние полос эквалайзера недоступно.",
        ["The local output format is not reported by the player."] = "Локальный формат вывода не сообщается плеером.",
        ["The player cannot compare the engine and output sample rates."] = "Плеер не может сравнить частоты дискретизации движка и выхода.",
        ["The player reports different engine and output sample rates."] = "Плеер сообщает о разных частотах дискретизации движка и выхода.",
        ["The remote device's final output format is not visible here."] = "Окончательный формат вывода удаленного устройства здесь не виден.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "Снимок показывает изменение или не содержит достаточно данных для подтверждения неизменности сигнала.",
        ["This firmware does not expose a live equalizer snapshot."] = "Эта прошивка не предоставляет живой снимок эквалайзера.",
        ["This firmware does not expose a live output snapshot."] = "Эта прошивка не предоставляет живой снимок вывода.",
        ["Title: %s"] = "Название: %s",
        ["Track Inspector"] = "Инспектор треков",
        ["Track and file details"] = "Сведения о треке и файле",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Усеченный заголовок FLAC STREAMINFO (менее 42 байт)",
        ["Truncated file header (less than 12 bytes)"] = "Усеченный заголовок файла (менее 12 байт)",
        ["Type: Uncompressed PCM"] = "Тип: Несжатый PCM",
        ["USB audio"] = "Аудио USB",
        ["USB audio output is selected"] = "Выбран вывод USB-аудио",
        ["USB output cannot be fully checked"] = "Вывод USB не может быть полностью проверен",
        ["Uncompressed PCM"] = "Несжатый PCM",
        ["Unknown"] = "Неизвестно",
        ["Unknown (mode not reported)"] = "Неизвестно (режим не сообщается)",
        ["Unknown / Negotiating"] = "Неизвестно / Согласование",
        ["Unknown / not reported"] = "Неизвестно / не сообщается",
        ["Unknown filter"] = "Неизвестный фильтр",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Неизвестный формат заголовка (проверка только для WAV, FLAC, AIFF; формат не определяется по расширению)",
        ["Unknown route"] = "Неизвестный маршрут",
        ["View all equalizer bands"] = "Показать все полосы эквалайзера",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (сжатый расширяемый: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (сжатый: формат 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (расширяемый Float)",
        ["WAV (Extensible PCM)"] = "WAV (расширяемый PCM)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (целочисленный PCM)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "Режим WavPack (lossless или hybrid) и файл коррекции не сообщаются.",
        ["Wider or narrower stereo"] = "Расширенное или суженное стерео",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Проводной выход",
        ["Wired output is selected"] = "Выбран проводной выход",
        ["Yes"] = "Да",
        ["active"] = "активно",
        ["amount unknown"] = "величина неизвестна",
        ["differs from the engine"] = "отличается от движка",
        ["forward-only"] = "только вперед",
        ["gain unknown"] = "усиление неизвестно",
        ["matches the engine"] = "совпадает с движком",
        ["seek status unknown"] = "статус перемотки неизвестен",
        ["seekable"] = "с перемоткой",
        ["standby"] = "в ожидании",
        ["status unknown"] = "статус неизвестен",
        ["unity (0 dB)"] = "единичное (0 дБ)",
    },
    uk = {
        [" · bypassed"] = " · обійдено",
        [" · normal"] = " · звичайна",
        [" · stored; overridden by MSEB"] = " · збережено; перекрито MSEB",
        [" · time stretch active"] = " · тайм-стретчинг активний",
        ["%d bytes"] = "%d байтів",
        ["%d channels"] = "%d каналів",
        ["%d kbps"] = "%d кбіт/с",
        ["%d%% strength"] = "%d%% інтенсивність",
        ["%d-bit"] = "%d біт",
        ["%d:%02d (%d s)"] = "%d:%02d (%d с)",
        ["%s elapsed"] = "%s минуло",
        ["%s · format unavailable"] = "%s · формат недоступний",
        ["-inf dB"] = "-inf дБ",
        ["1 (Mono)"] = "1 (Моно)",
        ["2 (Stereo)"] = "2 (Стерео)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (стиснений: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (Little-Endian PCM)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Активний формат виводу: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Активний формат виводу: Недоступно, поки вихід неактивний",
        ["Album artist: %s"] = "Виконавець альбому: %s",
        ["Album: %s"] = "Альбом: %s",
        ["An EQ band's enabled state is unknown."] = "Стан увімкнення смуги EQ невідомий.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Увімкнена смуга EQ має невідомий тип фільтра; ефект незрозумілий.",
        ["An enabled EQ filter has unknown gain."] = "Увімкнений фільтр EQ має невідоме підсилення.",
        ["Applied ReplayGain: %s"] = "Застосований ReplayGain: %s",
        ["Artist: %s"] = "Виконавець: %s",
        ["Audio engine format: %s · %s"] = "Формат аудіорушія: %s · %s",
        ["Audio engine format: Unknown"] = "Формат аудіорушія: Невідомо",
        ["Audio engine is idle; no active playback stream to inspect."] = "Аудіорушій неактивний; немає активного потоку для перевірки.",
        ["Audio engine output: %s · %s"] = "Вивід аудіорушія: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Ресемплінг аудіорушія: джерело %s у %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Аудіоформат: Невідомо (немає активного знімка декодера)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Смуга %d · %s · %s Гц · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Розрядність: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Розрядність розширена: джерело %d біт -> вихід %d біт (можливий падінг або дизеринг; прозорість не підтверджена).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Обрізання розрядності: джерело %d біт -> вихід %d біт (дизеринг або втрата точності).",
        ["Bitrate: %s"] = "Бітрейт: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth може змінити звук",
        ["Bluetooth codec: %s"] = "Кодек Bluetooth: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "Кодування Bluetooth може змінити звук (%s); кінцевий вивід приймача тут не видно.",
        ["Bypassed"] = "Обійдено",
        ["Change or unknown detail"] = "Зміна або невідома деталь",
        ["Changes detected or information unavailable"] = "Виявлено зміни або інформація недоступна",
        ["Changes to this setting take effect with the next track."] = "Зміни набудуть чинності з наступного треку.",
        ["Channels: %s"] = "Канали: %s",
        ["Codec: %s"] = "Кодек: %s",
        ["Could not open file picker. Please try again."] = "Не вдалося відкрити вибір файлів. Спробуйте ще раз.",
        ["Could not open file picker: %s"] = "Не вдалося відкрити вибір файлів: %s",
        ["Could not open file: %s"] = "Не вдалося відкрити файл: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade увімкнений; програвач не повідомляє, чи мікшуються треки зараз.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Налаштування Crossfade: %s · поточне мікшування не відображається",
        ["Crossfeed angle: %.1f°"] = "Кут crossfeed: %.1f°",
        ["Crossfeed delay: none"] = "Затримка crossfeed: немає",
        ["DSD audio"] = "Аудіо DSD",
        ["DSD carrier rate: %s · expected %s"] = "Частота носія DSD: %s · очікувалося %s",
        ["DSD converted to PCM at %s"] = "DSD перетворено на PCM на %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD перетворюється на PCM; наведені нижче налаштування звуку можуть впливати на відтворення.",
        ["DSD playback: converted to PCM"] = "Відтворення DSD: перетворено на PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "Потік DSD перетворено на PCM (активна децимація; не прямий нативний DSD).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "Носій DSD-over-PCM активний; обробка PCM обійдена",
        ["DSD-over-PCM carrier: %s"] = "Носій DSD-over-PCM: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "Відтворення DSD-over-PCM обходить еквалайзер та іншу обробку PCM.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "Активна децимація DSD в PCM: потік DSD перетворюється на PCM і проходить обробку PCM DSP.",
        ["Detail: %s"] = "Деталі: %s",
        ["Disabled"] = "Вимкнено",
        ["DoP active but codec is not DSD."] = "DoP активний, але кодек не DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "Недостатня глибина носія DoP: отримано %s (потрібен 24-бітний носій).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "Фреймінг DoP: 1-бітний потік DSD %s упаковано в кадри носія PCM %s %s; ланцюг DSP PCM обійдено.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "Невідповідність частоти носія DoP: очікувалося %.1f кГц для DSD, отримано %s.",
        ["Duration: %s"] = "Тривалість: %s",
        ["EQ bands configuration missing."] = "Конфігурація смуг EQ відсутня.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Активне цифрове підсилення преампа EQ: %+.2f дБ.",
        ["EQ preamp gain is unknown or invalid."] = "Підсилення преампа EQ невідоме або неприпустиме.",
        ["Enabled equalizer bands: %d / 10"] = "Увімкнено смуг еквалайзера: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Увімкнено смуг еквалайзера: Не повідомляється повністю",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Кодування: Стиснене аудіо · стиснення без втрат не підтверджено заголовком",
        ["Encoding: Lossless compressed audio"] = "Кодування: Стиснене аудіо без втрат",
        ["Equalizer bands"] = "Смуги еквалайзера",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "Байпас еквалайзера також пропускає преамп, ширину стерео, crossfeed та фільтри.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Байпас еквалайзера активний; преамп, ширина стерео та фільтри пропущені. Crossfeed залишається незалежним.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Байпас еквалайзера активний; преамп, ширина стерео, crossfeed та фільтри пропущені.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "Байпас еквалайзера пропускає преамп, ширину стерео та фільтри; crossfeed залишається незалежним.",
        ["Equalizer details unavailable"] = "Відомості про еквалайзер недоступні",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Стан еквалайзера недоступний; неможливо підтвердити лінійний шлях DSP.",
        ["Equalizer: %s"] = "Еквалайзер: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Орієнтовний бітрейт контейнера: %s (включає накладні витрати контейнера)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Заголовок файлу: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Вибір файлів недоступний. Оновіть прошивку для перевірки локального файлу.",
        ["File size: %s"] = "Розмір файлу: %s",
        ["File: %s"] = "Файл: %s",
        ["Final device format: Not available from the player"] = "Остаточний формат пристрою: Недоступно з програвача",
        ["Final device format: Not reported by the player"] = "Остаточний формат пристрою: Не повідомляється програвачем",
        ["Format: %s"] = "Формат: %s",
        ["Gapless playback: %s"] = "Відтворення без пауз (gapless): %s",
        ["Genre: %s"] = "Жанр: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Аналіз заголовка: Не підтримується / Пошкоджений",
        ["Headphone crossfeed is active at %.2f strength."] = "Crossfeed для навушників активний із силою %.2f.",
        ["Headphone crossfeed state is unknown."] = "Стан crossfeed для навушників невідомий.",
        ["Headphone crossfeed: %s%s"] = "Crossfeed для навушників: %s%s",
        ["High shelf"] = "High-shelf",
        ["In order"] = "По порядку",
        ["Inspect a file"] = "Перевірити файл",
        ["Inspector settings"] = "Налаштування інспектора",
        ["Invalid file path"] = "Неприпустимий шлях до файлу",
        ["Length: %s · %s"] = "Тривалість: %s · %s",
        ["Live or unknown length"] = "Прямий ефір або невідома тривалість",
        ["Local file"] = "Локальний файл",
        ["Local file details"] = "Відомості про локальний файл",
        ["Local output format: %s · %s"] = "Локальний формат виводу: %s · %s",
        ["Lossless compression"] = "Стиснення без втрат",
        ["Lossy"] = "З втратами",
        ["Low shelf"] = "Low-shelf",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "Пошкоджений AIFF: неприпустимі параметри аудіо",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "Пошкоджений AIFF: блок COMM відсутній або обрізаний",
        ["Malformed FLAC: STREAMINFO block length too small"] = "Пошкоджений FLAC: довжина блоку STREAMINFO занадто мала",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "Пошкоджений FLAC: першим блоком метаданих має бути STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "Пошкоджений FLAC: неприпустимі параметри аудіо в STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "Пошкоджений WAV: неприпустимі параметри аудіо",
        ["Malformed WAV: missing or truncated fmt chunk"] = "Пошкоджений WAV: блок fmt відсутній або обрізаний",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Смуги ручного еквалайзера, преамп і ширина стерео перекриваються стандартним MSEB, доки він увімкнений.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Моно",
        ["Native DoP bypasses stock MSEB during playback."] = "Нативний DoP обходить стандартний MSEB під час відтворення.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "Нативний апаратний потік DoP обходить еквалайзер PCM, стандартний MSEB, ширину стерео та програмну гучність.",
        ["Neutral"] = "Нейтрально",
        ["No"] = "Ні",
        ["No Active Playback"] = "Немає активного відтворення",
        ["No changes detected (wired DoP candidate)"] = "Змін не виявлено (дротовий кандидат DoP)",
        ["No changes detected (wired PCM candidate)"] = "Змін не виявлено (дротовий кандидат PCM)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "У спостережуваних стадіях змін не виявлено. Апаратна сертифікація недоступна з цього знімка.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "У спостережуваних стадіях змін не виявлено. Це кандидат, а не доказ фізичного виводу обладнання.",
        ["Not classified by this inspector"] = "Не класифіковано цим інспектором",
        ["Not reported"] = "Не повідомляється",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Примітка: Перевірка лише локальних заголовків WAV, FLAC, AIFF. Інші формати не визначаються за розширенням.",
        ["One-bit DSD audio"] = "1-бітне аудіо DSD",
        ["Opus"] = "Opus",
        ["Other observation"] = "Інше спостереження",
        ["Output active: %s"] = "Вихід активний: %s",
        ["Output bit depth is unknown or invalid."] = "Вихідна розрядність невідома або неприпустима.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Розрядність відрізняється: аудіорушій %d біт -> програвач повідомляє %d біт.",
        ["Output details"] = "Відомості про вивід",
        ["Output details unavailable"] = "Відомості про вивід недоступні",
        ["Output device"] = "Пристрій виводу",
        ["Output is inactive"] = "Вихід неактивний",
        ["Output is inactive or its state is unknown."] = "Вихід неактивний або його стан невідомий.",
        ["Output rate matches engine: %s"] = "Частота виводу збігається з рушієм: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Вивід на USB-ЦАП: перетворення USB і апаратний мікшер не перевірені; збіг полів PCM не гарантує bit-perfect.",
        ["Output route: %s · %s"] = "Маршрут виводу: %s · %s",
        ["Output sample rate is unknown or invalid."] = "Вихідна частота дискретизації невідома або неприпустима.",
        ["Output sink DoP flag is not active."] = "Прапорець DoP приймача виводу не активний.",
        ["PCM audio"] = "Аудіо PCM",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "Параметричний EQ має %d активних смуг; фільтрація та захист від піків можуть впливати на семпли.",
        ["Path is outside SD root"] = "Шлях за межами кореня SD-карти",
        ["Paused"] = "Пауза",
        ["Peaking"] = "Дзвін (peaking)",
        ["Per album"] = "За альбомами",
        ["Per track"] = "За треками",
        ["Play mode: %s"] = "Режим відтворення: %s",
        ["Playback details"] = "Відомості про відтворення",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Швидкість відтворення змінена: %.4fx (активний DSP тайм-стретчингу).",
        ["Playback speed state unavailable or invalid."] = "Стан швидкості відтворення недоступний або неприпустимий.",
        ["Playback speed: %s"] = "Швидкість відтворення: %s",
        ["Playback: %s · %s"] = "Відтворення: %s · %s",
        ["Player output rate: %s · %s"] = "Частота виводу програвача: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Гучність програвача: %s · окремо від програмного підсилення",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "Повідомлена частота виводу відрізняється від джерела: %d Гц -> %d Гц.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "Вихідна частота не збігається з носієм DoP: %d Гц проти %.0f Гц.",
        ["Please close the other file picker and try again."] = "Закрийте інше вікно вибору файлів і повторіть спробу.",
        ["Preamp gain: %s%s"] = "Підсилення преампа: %s%s",
        ["Refresh output details"] = "Оновити відомості про вивід",
        ["Refresh playback details"] = "Оновити відомості про відтворення",
        ["Refresh signal path check"] = "Оновити перевірку шляху сигналу",
        ["Refresh sound details"] = "Оновити відомості про звук",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Віддалені потоки не підтримують перевірку заголовка; формат надано декодером",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (вирівнювання гучності): %s · застосовано до треку: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "Застосовано вирівнювання ReplayGain: %+.2f дБ.",
        ["ReplayGain state unavailable."] = "Стан ReplayGain недоступний.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain позначений як застосований, але величина підсилення невідома.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Ресемплінг активний: джерело %d Гц -> вихід %d Гц.",
        ["Result: %s"] = "Результат: %s",
        ["Route: %s"] = "Маршрут: %s",
        ["Sample Rate: %s"] = "Частота дискретизації: %s",
        ["Show full file paths"] = "Показувати повні шляхи до файлів",
        ["Show music library tags"] = "Показувати теги медіатеки",
        ["Signal check"] = "Перевірка сигналу",
        ["Software audio gain: %s"] = "Програмне підсилення звуку: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Програмна гучність на одиничному підсиленні (1.00 / 0.0 дБ - без цифрового масштабування PCM).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Програмне масштабування гучності активне: %.6fx (%s цифрова модифікація).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Стан програмної гучності недоступний; неможливо перевірити одиничне підсилення.",
        ["Sound processing"] = "Обробка звуку",
        ["Source and audio engine rates match: %s"] = "Частоти джерела та аудіорушія збігаються: %s",
        ["Source audio: %s · %s · %s"] = "Вихідне аудіо: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "Розрядність джерела невідома або зі стисненням з втратами (немає вихідної глибини PCM).",
        ["Source channels count is unknown or invalid."] = "Кількість вихідних каналів невідома або неприпустима.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "Вихідний кодек із втратами (%s): декодування з втратами не гарантує точність bit-perfect.",
        ["Source codec is unknown."] = "Вихідний кодек невідомий.",
        ["Source quality: %s"] = "Якість джерела: %s",
        ["Source sample rate is unknown or invalid."] = "Вихідна частота дискретизації невідома або неприпустима.",
        ["Source: %s · %s"] = "Джерело: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Запустіть або відновіть відтворення для перевірки живого формату декодера.",
        ["State unknown"] = "Стан невідомий",
        ["Stereo width is unknown or invalid."] = "Ширина стерео невідома або неприпустима.",
        ["Stereo width processing is active: %.4f."] = "Обробка ширини стерео активна: %.4f.",
        ["Stereo width: %s%s"] = "Ширина стерео: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "Стандартний MSEB перекриває ручні смуги EQ, преамп і ширину стерео; crossfeed незалежний.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "Обробка стандартного MSEB увімкнена з ненейтральними налаштуваннями.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Налаштування MSEB неповні або недійсні; неможливо підтвердити нейтральний шлях PCM.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Стан стандартного MSEB недоступний; неможливо перевірити шлях обробки PCM.",
        ["Stock MSEB: %s"] = "Стандартний MSEB: %s",
        ["Stream name or endpoint: %s"] = "Назва потоку або адреса: %s",
        ["The active output route is unknown."] = "Активний маршрут виводу невідомий.",
        ["The external device's final conversion and output format are not visible here."] = "Остаточне перетворення та формат виводу зовнішнього пристрою тут не видно.",
        ["The full equalizer band state is unavailable."] = "Повний стан смуг еквалайзера недоступний.",
        ["The local output format is not reported by the player."] = "Локальний формат виводу не повідомляється програвачем.",
        ["The player cannot compare the engine and output sample rates."] = "Програвач не може порівняти частоти дискретизації рушія та виходу.",
        ["The player reports different engine and output sample rates."] = "Програвач повідомляє про різні частоти дискретизації рушія та виходу.",
        ["The remote device's final output format is not visible here."] = "Остаточний формат виводу віддаленого пристрою тут не видно.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "Знімок показує зміну або не містить достатньо даних для підтвердження незмінності сигналу.",
        ["This firmware does not expose a live equalizer snapshot."] = "Ця прошивка не надає живого знімка еквалайзера.",
        ["This firmware does not expose a live output snapshot."] = "Ця прошивка не надає живого знімка виводу.",
        ["Title: %s"] = "Назва: %s",
        ["Track Inspector"] = "Інспектор треків",
        ["Track and file details"] = "Відомості про трек і файл",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Обрізаний заголовок FLAC STREAMINFO (менше 42 байтів)",
        ["Truncated file header (less than 12 bytes)"] = "Обрізаний заголовок файлу (менше 12 байтів)",
        ["Type: Uncompressed PCM"] = "Тип: Нестиснений PCM",
        ["USB audio"] = "Аудіо USB",
        ["USB audio output is selected"] = "Вибрано вивід USB-аудіо",
        ["USB output cannot be fully checked"] = "Вивід USB не може бути повністю перевірений",
        ["Uncompressed PCM"] = "Нестиснений PCM",
        ["Unknown"] = "Невідомо",
        ["Unknown (mode not reported)"] = "Невідомо (режим не повідомляється)",
        ["Unknown / Negotiating"] = "Невідомо / Узгодження",
        ["Unknown / not reported"] = "Невідомо / не повідомляється",
        ["Unknown filter"] = "Невідомий фільтр",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Невідомий формат заголовка (перевірка лише для WAV, FLAC, AIFF; формат не визначається за розширенням)",
        ["Unknown route"] = "Невідомий маршрут",
        ["View all equalizer bands"] = "Показати всі смуги еквалайзера",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (стиснений розширюваний: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (стиснений: формат 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (розширюваний Float)",
        ["WAV (Extensible PCM)"] = "WAV (розширюваний PCM)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (цілочисельний PCM)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "Режим WavPack (lossless або гібридний) і стан файлу корекції не повідомляються.",
        ["Wider or narrower stereo"] = "Розширене або звужене стерео",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Дротовий вихід",
        ["Wired output is selected"] = "Вибрано дротовий вихід",
        ["Yes"] = "Так",
        ["active"] = "активно",
        ["amount unknown"] = "величина невідома",
        ["differs from the engine"] = "відрізняється від рушія",
        ["forward-only"] = "лише вперед",
        ["gain unknown"] = "підсилення невідоме",
        ["matches the engine"] = "збігається з рушієм",
        ["seek status unknown"] = "стан перемотування невідомий",
        ["seekable"] = "з перемотуванням",
        ["standby"] = "в очікуванні",
        ["status unknown"] = "стан невідомий",
        ["unity (0 dB)"] = "одиничне (0 дБ)",
    },
    vi = {
        [" · bypassed"] = " · đã bỏ qua",
        [" · normal"] = " · bình thường",
        [" · stored; overridden by MSEB"] = " · đã lưu; bị MSEB ghi đè",
        [" · time stretch active"] = " · giãn thời gian đang bật",
        ["%d bytes"] = "%d byte",
        ["%d channels"] = "%d kênh",
        ["%d kbps"] = "%d kbps",
        ["%d%% strength"] = "%d%% cường độ",
        ["%d-bit"] = "%d-bit",
        ["%d:%02d (%d s)"] = "%d:%02d (%d giây)",
        ["%s elapsed"] = "Đã qua %s",
        ["%s · format unavailable"] = "%s · không có định dạng",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (Đơn âm)",
        ["2 (Stereo)"] = "2 (Âm thanh nổi)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (Nén: %s)",
        ["AIFC (Float)"] = "AIFC (Float)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (PCM Little-Endian)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "Định dạng đầu ra hoạt động: %s · %s",
        ["Active output format: Not available while output is inactive"] = "Định dạng đầu ra hoạt động: Không có sẵn khi đầu ra không hoạt động",
        ["Album artist: %s"] = "Nghệ sĩ album: %s",
        ["Album: %s"] = "Album: %s",
        ["An EQ band's enabled state is unknown."] = "Trạng thái bật của một dải EQ không rõ.",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "Một dải EQ đang bật có loại bộ lọc không nhận dạng được; không rõ hiệu ứng.",
        ["An enabled EQ filter has unknown gain."] = "Bộ lọc EQ đang bật có độ lợi không rõ.",
        ["Applied ReplayGain: %s"] = "ReplayGain đã áp dụng: %s",
        ["Artist: %s"] = "Nghệ sĩ: %s",
        ["Audio engine format: %s · %s"] = "Định dạng bộ máy âm thanh: %s · %s",
        ["Audio engine format: Unknown"] = "Định dạng bộ máy âm thanh: Không rõ",
        ["Audio engine is idle; no active playback stream to inspect."] = "Bộ máy âm thanh đang rảnh; không có luồng phát lại nào để kiểm tra.",
        ["Audio engine output: %s · %s"] = "Đầu ra bộ máy âm thanh: %s · %s",
        ["Audio engine resampling: %s source to %s"] = "Lấy mẫu lại của bộ máy âm thanh: nguồn %s sang %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "Định dạng âm thanh: Không rõ (không có ảnh chụp bộ giải mã)",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "Dải %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "Độ sâu bit: %s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "Mở rộng độ sâu bit: nguồn %d-bit -> đầu ra %d-bit (có thể đệm hoặc dither; chưa xác minh tính trong suốt).",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "Cắt giảm độ sâu bit: nguồn %d-bit -> đầu ra %d-bit (dithering hoặc mất độ chính xác).",
        ["Bitrate: %s"] = "Tốc độ bit: %s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth có thể làm đổi âm thanh",
        ["Bluetooth codec: %s"] = "Bộ giải mã Bluetooth: %s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "Mã hóa Bluetooth có thể làm đổi âm thanh (%s); đầu ra cuối của thiết bị nhận không hiển thị ở đây.",
        ["Bypassed"] = "Đã bỏ qua",
        ["Change or unknown detail"] = "Thay đổi hoặc chi tiết không rõ",
        ["Changes detected or information unavailable"] = "Đã phát hiện thay đổi hoặc không có thông tin",
        ["Changes to this setting take effect with the next track."] = "Thay đổi cài đặt này có hiệu lực từ bài tiếp theo.",
        ["Channels: %s"] = "Kênh: %s",
        ["Codec: %s"] = "Bộ giải mã: %s",
        ["Could not open file picker. Please try again."] = "Không thể mở bộ chọn tệp. Vui lòng thử lại.",
        ["Could not open file picker: %s"] = "Không thể mở bộ chọn tệp: %s",
        ["Could not open file: %s"] = "Không thể mở tệp: %s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "Crossfade đang bật; trình phát không báo cáo liệu các bài hát có đang được trộn hay không.",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "Cài đặt Crossfade: %s · trạng thái trộn hiện tại không hiển thị",
        ["Crossfeed angle: %.1f°"] = "Góc crossfeed: %.1f°",
        ["Crossfeed delay: none"] = "Độ trễ crossfeed: không có",
        ["DSD audio"] = "Âm thanh DSD",
        ["DSD carrier rate: %s · expected %s"] = "Tần số sóng mang DSD: %s · dự kiến %s",
        ["DSD converted to PCM at %s"] = "DSD được chuyển sang PCM tại %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD được chuyển sang PCM; các cài đặt âm thanh bên dưới có thể ảnh hưởng đến phát lại.",
        ["DSD playback: converted to PCM"] = "Phát lại DSD: chuyển đổi sang PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "Luồng DSD được chuyển đổi sang PCM (đang giảm mẫu; không phải truyền thẳng DSD gốc).",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "Sóng mang DSD-over-PCM đang bật; bỏ qua xử lý PCM",
        ["DSD-over-PCM carrier: %s"] = "Sóng mang DSD-over-PCM: %s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "Phát lại DSD-over-PCM bỏ qua bộ cân bằng và các xử lý PCM khác.",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "Đang giảm mẫu DSD sang PCM: luồng DSD được chuyển sang PCM và chịu lọc DSP PCM.",
        ["Detail: %s"] = "Chi tiết: %s",
        ["Disabled"] = "Đã tắt",
        ["DoP active but codec is not DSD."] = "DoP đang hoạt động nhưng bộ giải mã không phải là DSD.",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "Độ sâu sóng mang DoP không đủ: nhận được %s (yêu cầu sóng mang 24-bit).",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "Đóng khung DoP: luồng DSD 1-bit %s được đóng gói vào khung mang PCM %s %s; bỏ qua chuỗi DSP PCM.",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "Tần số sóng mang DoP không khớp: dự kiến %.1f kHz cho DSD, nhận được %s.",
        ["Duration: %s"] = "Thời lượng: %s",
        ["EQ bands configuration missing."] = "Thiếu cấu hình các dải EQ.",
        ["EQ digital preamp gain active: %+.2f dB."] = "Độ lợi tiền khuếch đại kỹ thuật số EQ đang bật: %+.2f dB.",
        ["EQ preamp gain is unknown or invalid."] = "Độ lợi tiền khuếch đại EQ không rõ hoặc không hợp lệ.",
        ["Enabled equalizer bands: %d / 10"] = "Dải bộ cân bằng đang bật: %d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "Dải bộ cân bằng đang bật: Không được báo cáo đầy đủ",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "Mã hóa: Âm thanh nén · tiêu đề chưa xác nhận không mất dữ liệu",
        ["Encoding: Lossless compressed audio"] = "Mã hóa: Âm thanh nén không mất dữ liệu",
        ["Equalizer bands"] = "Các dải bộ cân bằng",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "Bỏ qua bộ cân bằng cũng bỏ qua tiền khuếch đại, độ rộng nổi, crossfeed và bộ lọc.",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "Bỏ qua bộ cân bằng âm đang hoạt động; bỏ qua tiền khuếch đại, độ rộng nổi và bộ lọc. Crossfeed vẫn độc lập.",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "Bỏ qua bộ cân bằng âm đang hoạt động; bỏ qua tiền khuếch đại, độ rộng nổi, crossfeed và bộ lọc.",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "Bỏ qua bộ cân bằng sẽ bỏ qua tiền khuếch đại, độ rộng nổi và bộ lọc; crossfeed vẫn độc lập.",
        ["Equalizer details unavailable"] = "Chi tiết bộ cân bằng không có sẵn",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "Trạng thái cân bằng âm không có sẵn; không thể xác minh đường dẫn DSP phẳng.",
        ["Equalizer: %s"] = "Bộ cân bằng: %s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "Tốc độ bit ước tính của vùng chứa: %s (bao gồm phần mào đầu vùng chứa/siêu dữ liệu)",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "Tiêu đề tệp: %s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "Bộ chọn tệp không có sẵn. Cập nhật phần sụn để kiểm tra tệp cục bộ.",
        ["File size: %s"] = "Kích thước tệp: %s",
        ["File: %s"] = "Tệp: %s",
        ["Final device format: Not available from the player"] = "Định dạng thiết bị cuối: Không có sẵn từ trình phát",
        ["Final device format: Not reported by the player"] = "Định dạng thiết bị cuối: Trình phát không báo cáo",
        ["Format: %s"] = "Định dạng: %s",
        ["Gapless playback: %s"] = "Phát liền mạch (gapless): %s",
        ["Genre: %s"] = "Thể loại: %s",
        ["Header Parsing Status: Unsupported / Malformed"] = "Trạng thái phân tích tiêu đề: Không hỗ trợ / Bị lỗi",
        ["Headphone crossfeed is active at %.2f strength."] = "Crossfeed tai nghe đang hoạt động với cường độ %.2f.",
        ["Headphone crossfeed state is unknown."] = "Trạng thái crossfeed tai nghe không rõ.",
        ["Headphone crossfeed: %s%s"] = "Crossfeed tai nghe: %s%s",
        ["High shelf"] = "Kệ cao (high shelf)",
        ["In order"] = "Theo thứ tự",
        ["Inspect a file"] = "Kiểm tra một tệp",
        ["Inspector settings"] = "Cài đặt bộ kiểm tra",
        ["Invalid file path"] = "Đường dẫn tệp không hợp lệ",
        ["Length: %s · %s"] = "Độ dài: %s · %s",
        ["Live or unknown length"] = "Trực tiếp hoặc độ dài không rõ",
        ["Local file"] = "Tệp cục bộ",
        ["Local file details"] = "Chi tiết tệp cục bộ",
        ["Local output format: %s · %s"] = "Định dạng đầu ra cục bộ: %s · %s",
        ["Lossless compression"] = "Nén không mất dữ liệu",
        ["Lossy"] = "Có mất dữ liệu",
        ["Low shelf"] = "Kệ trầm (low shelf)",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "AIFF bị lỗi: thông số âm thanh không hợp lệ",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "AIFF bị lỗi: thiếu hoặc bị cắt đoạn COMM",
        ["Malformed FLAC: STREAMINFO block length too small"] = "FLAC bị lỗi: độ dài khối STREAMINFO quá nhỏ",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "FLAC bị lỗi: khối siêu dữ liệu đầu tiên phải là STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "FLAC bị lỗi: thông số âm thanh không hợp lệ trong STREAMINFO",
        ["Malformed WAV: invalid audio parameters"] = "WAV bị lỗi: thông số âm thanh không hợp lệ",
        ["Malformed WAV: missing or truncated fmt chunk"] = "WAV bị lỗi: thiếu hoặc bị cắt đoạn fmt",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "Các dải EQ thủ công, tiền khuếch đại và độ rộng nổi bị ghi đè bởi MSEB mặc định khi đang bật.",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "Đơn âm",
        ["Native DoP bypasses stock MSEB during playback."] = "DoP gốc bỏ qua MSEB mặc định trong khi phát lại.",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "Luồng phần cứng DoP gốc bỏ qua bộ cân bằng PCM, MSEB mặc định, độ rộng nổi và âm lượng phần mềm.",
        ["Neutral"] = "Trung tính",
        ["No"] = "Không",
        ["No Active Playback"] = "Không có phát lại đang hoạt động",
        ["No changes detected (wired DoP candidate)"] = "Không phát hiện thay đổi (ứng viên DoP có dây)",
        ["No changes detected (wired PCM candidate)"] = "Không phát hiện thay đổi (ứng viên PCM có dây)",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "Không phát hiện thay đổi trong các giai đoạn quan sát được. Không thể chứng nhận phần cứng từ ảnh chụp này.",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "Không phát hiện thay đổi trong các giai đoạn quan sát được. Đây là ứng viên, không phải bằng chứng về đầu ra phần cứng vật lý.",
        ["Not classified by this inspector"] = "Không được phân loại bởi bộ kiểm tra này",
        ["Not reported"] = "Không được báo cáo",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "Lưu ý: Chỉ kiểm tra tiêu đề WAV, FLAC, AIFF cục bộ. Định dạng khác được báo không rõ mà không đoán từ phần mở rộng.",
        ["One-bit DSD audio"] = "Âm thanh DSD 1-bit",
        ["Opus"] = "Opus",
        ["Other observation"] = "Quan sát khác",
        ["Output active: %s"] = "Đầu ra đang hoạt động: %s",
        ["Output bit depth is unknown or invalid."] = "Độ sâu bit đầu ra không rõ hoặc không hợp lệ.",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "Độ sâu bit đầu ra khác nhau: bộ máy %d-bit -> trình phát báo %d-bit.",
        ["Output details"] = "Chi tiết đầu ra",
        ["Output details unavailable"] = "Chi tiết đầu ra không có sẵn",
        ["Output device"] = "Thiết bị đầu ra",
        ["Output is inactive"] = "Đầu ra không hoạt động",
        ["Output is inactive or its state is unknown."] = "Đầu ra không hoạt động hoặc trạng thái không rõ.",
        ["Output rate matches engine: %s"] = "Tần số đầu ra khớp với bộ máy: %s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "Đầu ra là USB DAC: chưa xác minh chuyển đổi đầu cuối USB và bộ trộn phần cứng; chỉ khớp PCM không chứng minh được bit-perfect.",
        ["Output route: %s · %s"] = "Tuyến đầu ra: %s · %s",
        ["Output sample rate is unknown or invalid."] = "Tần số lấy mẫu đầu ra không rõ hoặc không hợp lệ.",
        ["Output sink DoP flag is not active."] = "Cờ DoP của thiết bị đầu ra không hoạt động.",
        ["PCM audio"] = "Âm thanh PCM",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "EQ tham số có %d dải đang bật; xử lý bộ lọc và bảo vệ đỉnh có thể ảnh hưởng đến mẫu.",
        ["Path is outside SD root"] = "Đường dẫn nằm ngoài thư mục gốc SD",
        ["Paused"] = "Đã tạm dừng",
        ["Peaking"] = "Đỉnh (peaking)",
        ["Per album"] = "Theo album",
        ["Per track"] = "Theo bài",
        ["Play mode: %s"] = "Chế độ phát: %s",
        ["Playback details"] = "Chi tiết phát lại",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "Tốc độ phát lại đã đổi: %.4fx (DSP kéo giãn thời gian đang bật).",
        ["Playback speed state unavailable or invalid."] = "Trạng thái tốc độ phát lại không có sẵn hoặc không hợp lệ.",
        ["Playback speed: %s"] = "Tốc độ phát lại: %s",
        ["Playback: %s · %s"] = "Phát lại: %s · %s",
        ["Player output rate: %s · %s"] = "Tần số đầu ra trình phát: %s · %s",
        ["Player volume: %s · separate from software audio gain"] = "Âm lượng trình phát: %s · tách biệt khỏi độ lợi phần mềm",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "Tần số đầu ra trình phát báo khác nguồn: %d Hz -> %d Hz.",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "Tần số đầu ra trình phát báo không khớp sóng mang DoP: %d Hz so với %.0f Hz.",
        ["Please close the other file picker and try again."] = "Vui lòng đóng bộ chọn tệp khác và thử lại.",
        ["Preamp gain: %s%s"] = "Độ lợi tiền khuếch đại: %s%s",
        ["Refresh output details"] = "Làm mới chi tiết đầu ra",
        ["Refresh playback details"] = "Làm mới chi tiết phát lại",
        ["Refresh signal path check"] = "Làm mới kiểm tra đường dẫn tín hiệu",
        ["Refresh sound details"] = "Làm mới chi tiết âm thanh",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "Luồng từ xa không hỗ trợ kiểm tra tiêu đề tệp; định dạng do bộ giải mã cung cấp",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain (khớp độ lớn): %s · đã áp dụng bài hiện tại: %s",
        ["ReplayGain scaling applied: %+.2f dB."] = "Đã áp dụng tỷ lệ hóa ReplayGain: %+.2f dB.",
        ["ReplayGain state unavailable."] = "Trạng thái ReplayGain không có sẵn.",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain được báo cáo đã áp dụng, nhưng độ lợi không rõ.",
        ["Resampling active: source %d Hz -> output %d Hz."] = "Đang lấy mẫu lại: nguồn %d Hz -> đầu ra %d Hz.",
        ["Result: %s"] = "Kết quả: %s",
        ["Route: %s"] = "Tuyến: %s",
        ["Sample Rate: %s"] = "Tần số lấy mẫu: %s",
        ["Show full file paths"] = "Hiện đường dẫn tệp đầy đủ",
        ["Show music library tags"] = "Hiện thẻ thư viện nhạc",
        ["Signal check"] = "Kiểm tra tín hiệu",
        ["Software audio gain: %s"] = "Độ lợi âm thanh phần mềm: %s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "Âm lượng phần mềm ở độ lợi 1.0 (1.00 / 0.0 dB - không tỷ lệ hóa PCM kỹ thuật số).",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "Đang tỷ lệ hóa âm lượng phần mềm: %.6fx (%s sửa đổi kỹ thuật số).",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "Trạng thái âm lượng phần mềm không có sẵn; không thể xác minh độ lợi 1.0.",
        ["Sound processing"] = "Xử lý âm thanh",
        ["Source and audio engine rates match: %s"] = "Tần số nguồn và bộ máy âm thanh khớp nhau: %s",
        ["Source audio: %s · %s · %s"] = "Âm thanh nguồn: %s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "Độ sâu bit nguồn không rõ hoặc mất dữ liệu (không có độ sâu PCM gốc).",
        ["Source channels count is unknown or invalid."] = "Số kênh nguồn không rõ hoặc không hợp lệ.",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "Bộ giải mã nguồn có mất dữ liệu (%s): giải mã mất dữ liệu không thể chứng nhận phát lại bit-perfect.",
        ["Source codec is unknown."] = "Bộ giải mã nguồn không rõ.",
        ["Source quality: %s"] = "Chất lượng nguồn: %s",
        ["Source sample rate is unknown or invalid."] = "Tần số lấy mẫu nguồn không rõ hoặc không hợp lệ.",
        ["Source: %s · %s"] = "Nguồn: %s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "Bắt đầu hoặc tiếp tục phát lại để kiểm tra định dạng trực tiếp của bộ giải mã.",
        ["State unknown"] = "Trạng thái không rõ",
        ["Stereo width is unknown or invalid."] = "Độ rộng âm thanh nổi không rõ hoặc không hợp lệ.",
        ["Stereo width processing is active: %.4f."] = "Xử lý độ rộng âm thanh nổi đang bật: %.4f.",
        ["Stereo width: %s%s"] = "Độ rộng âm thanh nổi: %s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "MSEB mặc định ghi đè dải EQ thủ công, tiền khuếch đại và độ rộng nổi; crossfeed vẫn độc lập.",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "Xử lý MSEB mặc định được bật với các cài đặt không trung tính.",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "Cài đặt MSEB không đầy đủ hoặc không hợp lệ; không thể xác minh đường dẫn PCM trung tính.",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "Trạng thái MSEB mặc định không có sẵn; không thể xác minh đường dẫn xử lý PCM.",
        ["Stock MSEB: %s"] = "MSEB mặc định: %s",
        ["Stream name or endpoint: %s"] = "Tên luồng hoặc điểm cuối: %s",
        ["The active output route is unknown."] = "Tuyến đầu ra đang hoạt động không rõ.",
        ["The external device's final conversion and output format are not visible here."] = "Chuyển đổi cuối cùng và định dạng đầu ra của thiết bị ngoài không hiển thị ở đây.",
        ["The full equalizer band state is unavailable."] = "Trạng thái đầy đủ các dải cân bằng âm không có sẵn.",
        ["The local output format is not reported by the player."] = "Định dạng đầu ra cục bộ không được trình phát báo cáo.",
        ["The player cannot compare the engine and output sample rates."] = "Trình phát không thể so sánh tần số lấy mẫu giữa bộ máy và đầu ra.",
        ["The player reports different engine and output sample rates."] = "Trình phát báo cáo tần số lấy mẫu khác nhau giữa bộ máy và đầu ra.",
        ["The remote device's final output format is not visible here."] = "Định dạng đầu ra cuối cùng của thiết bị từ xa không hiển thị ở đây.",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "Ảnh chụp cho thấy sự thay đổi hoặc thiếu thông tin để xác minh đường dẫn tín hiệu không đổi.",
        ["This firmware does not expose a live equalizer snapshot."] = "Phần sụn này không cung cấp ảnh chụp trực tiếp của bộ cân bằng.",
        ["This firmware does not expose a live output snapshot."] = "Phần sụn này không cung cấp ảnh chụp đầu ra trực tiếp.",
        ["Title: %s"] = "Tiêu đề: %s",
        ["Track Inspector"] = "Bộ kiểm tra bài hát",
        ["Track and file details"] = "Chi tiết bài hát và tệp",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "Tiêu đề FLAC STREAMINFO bị cắt ngắn (dưới 42 byte)",
        ["Truncated file header (less than 12 bytes)"] = "Tiêu đề tệp bị cắt ngắn (dưới 12 byte)",
        ["Type: Uncompressed PCM"] = "Loại: PCM không nén",
        ["USB audio"] = "Âm thanh USB",
        ["USB audio output is selected"] = "Đã chọn đầu ra âm thanh USB",
        ["USB output cannot be fully checked"] = "Không thể kiểm tra đầy đủ đầu ra USB",
        ["Uncompressed PCM"] = "PCM không nén",
        ["Unknown"] = "Không rõ",
        ["Unknown (mode not reported)"] = "Không rõ (chế độ không được báo cáo)",
        ["Unknown / Negotiating"] = "Không rõ / Đang thỏa thuận",
        ["Unknown / not reported"] = "Không rõ / không báo cáo",
        ["Unknown filter"] = "Bộ lọc không rõ",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "Định dạng tiêu đề không xác định (chỉ kiểm tra tiêu đề WAV, FLAC, AIFF; không đoán qua phần mở rộng)",
        ["Unknown route"] = "Tuyến không rõ",
        ["View all equalizer bands"] = "Xem tất cả các dải cân bằng âm",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (Mở rộng nén: 0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (Nén: định dạng 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (Float mở rộng)",
        ["WAV (Extensible PCM)"] = "WAV (PCM mở rộng)",
        ["WAV (IEEE Float)"] = "WAV (IEEE Float)",
        ["WAV (PCM Integer)"] = "WAV (PCM số nguyên)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "Chế độ nén không mất dữ liệu hoặc kết hợp của WavPack và tệp sửa lỗi không được báo cáo.",
        ["Wider or narrower stereo"] = "Âm thanh nổi rộng hơn hoặc hẹp hơn",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "Đầu ra có dây",
        ["Wired output is selected"] = "Đã chọn đầu ra có dây",
        ["Yes"] = "Có",
        ["active"] = "hoạt động",
        ["amount unknown"] = "mức không rõ",
        ["differs from the engine"] = "khác với bộ máy",
        ["forward-only"] = "chỉ chuyển tiếp",
        ["gain unknown"] = "độ lợi không rõ",
        ["matches the engine"] = "khớp với bộ máy",
        ["seek status unknown"] = "trạng thái tua không rõ",
        ["seekable"] = "tua được",
        ["standby"] = "chờ",
        ["status unknown"] = "trạng thái không rõ",
        ["unity (0 dB)"] = "độ lợi 1.0 (0 dB)",
    },
    zh_CN = {
        [" · bypassed"] = " · 已旁路",
        [" · normal"] = " · 正常",
        [" · stored; overridden by MSEB"] = " · 已保存；被 MSEB 覆盖",
        [" · time stretch active"] = " · 时间拉伸已激活",
        ["%d bytes"] = "%d 字节",
        ["%d channels"] = "%d 声道",
        ["%d kbps"] = "%d kbps",
        ["%d%% strength"] = "%d%% 强度",
        ["%d-bit"] = "%d 位",
        ["%d:%02d (%d s)"] = "%d:%02d (%d 秒)",
        ["%s elapsed"] = "已播放 %s",
        ["%s · format unavailable"] = "%s · 格式不可用",
        ["-inf dB"] = "-inf dB",
        ["1 (Mono)"] = "1 (单声道)",
        ["2 (Stereo)"] = "2 (立体声)",
        ["AAC"] = "AAC",
        ["AIFC (Compressed: %s)"] = "AIFC (压缩：%s)",
        ["AIFC (Float)"] = "AIFC (浮点)",
        ["AIFC (Little-Endian PCM)"] = "AIFC (小端 PCM)",
        ["AIFC (PCM)"] = "AIFC (PCM)",
        ["AIFF (PCM)"] = "AIFF (PCM)",
        ["ALAC (Apple Lossless)"] = "ALAC (Apple Lossless)",
        ["Active output format: %s · %s"] = "活动输出格式：%s · %s",
        ["Active output format: Not available while output is inactive"] = "活动输出格式：输出不活动时不可用",
        ["Album artist: %s"] = "专辑艺术家：%s",
        ["Album: %s"] = "专辑：%s",
        ["An EQ band's enabled state is unknown."] = "某个 EQ 频段的启用状态未知。",
        ["An enabled EQ band has an unrecognized filter type; its effect is unknown."] = "某个已启用的 EQ 频段具有无法识别的滤波器类型；其效果未知。",
        ["An enabled EQ filter has unknown gain."] = "某个已启用的 EQ 滤波器增益未知。",
        ["Applied ReplayGain: %s"] = "已应用 ReplayGain：%s",
        ["Artist: %s"] = "艺术家：%s",
        ["Audio engine format: %s · %s"] = "音频引擎格式：%s · %s",
        ["Audio engine format: Unknown"] = "音频引擎格式：未知",
        ["Audio engine is idle; no active playback stream to inspect."] = "音频引擎空闲；没有活动播放流可检查。",
        ["Audio engine output: %s · %s"] = "音频引擎输出：%s · %s",
        ["Audio engine resampling: %s source to %s"] = "音频引擎重采样：源 %s 至 %s",
        ["Audio format: Unknown (no active decoder snapshot)"] = "音频格式：未知（无活动解码器快照）",
        ["Band %d · %s · %s Hz · %s · Q %s · %s"] = "频段 %d · %s · %s Hz · %s · Q %s · %s",
        ["Bit Depth: %s"] = "位深：%s",
        ["Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."] = "位深扩展：源 %d 位 -> 输出 %d 位（可能存在填充或抖动；比特透明性未验证）。",
        ["Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."] = "位深截断：源 %d 位 -> 输出 %d 位（抖动或精度损失）。",
        ["Bitrate: %s"] = "比特率：%s",
        ["Bluetooth"] = "Bluetooth",
        ["Bluetooth can change audio"] = "Bluetooth 可能会改变音频",
        ["Bluetooth codec: %s"] = "Bluetooth 编解码器：%s",
        ["Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."] = "Bluetooth 编码可能会改变音频 (%s)；接收设备的最终输出在此不可见。",
        ["Bypassed"] = "已旁路",
        ["Change or unknown detail"] = "变更或未知细节",
        ["Changes detected or information unavailable"] = "检测到更改或信息不可用",
        ["Changes to this setting take effect with the next track."] = "此设置的更改将在下一首曲目生效。",
        ["Channels: %s"] = "声道：%s",
        ["Codec: %s"] = "编解码器：%s",
        ["Could not open file picker. Please try again."] = "无法打开文件选择器。请重试。",
        ["Could not open file picker: %s"] = "无法打开文件选择器：%s",
        ["Could not open file: %s"] = "无法打开文件：%s",
        ["Crossfade is enabled; the player does not report whether tracks are currently being mixed."] = "交叉渐入渐出已启用；播放器未报告当前是否正在混音曲目。",
        ["Crossfade setting: %s · current mixing state is not exposed"] = "交叉渐变设置：%s · 当前混音状态未公开",
        ["Crossfeed angle: %.1f°"] = "Crossfeed 角度：%.1f°",
        ["Crossfeed delay: none"] = "Crossfeed 延迟：无",
        ["DSD audio"] = "DSD 音频",
        ["DSD carrier rate: %s · expected %s"] = "DSD 载波速率：%s · 预期 %s",
        ["DSD converted to PCM at %s"] = "DSD 已转换为 PCM，速率为 %s",
        ["DSD is converted to PCM; the sound settings below can affect playback."] = "DSD 已转换为 PCM；下方的声音设置可能会影响播放。",
        ["DSD playback: converted to PCM"] = "DSD 播放：转换为 PCM",
        ["DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."] = "DSD 流已转换为 PCM（抽取已激活；非原生 DSD 直接透传）。",
        ["DSD-over-PCM carrier is active; PCM processing is bypassed"] = "DSD-over-PCM 载波已激活；已绕过 PCM 处理",
        ["DSD-over-PCM carrier: %s"] = "DSD-over-PCM 载波：%s",
        ["DSD-over-PCM playback bypasses the equalizer and other PCM processing."] = "DSD-over-PCM 播放绕过均衡器和其他 PCM 处理。",
        ["DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."] = "DSD 至 PCM 抽取已激活：DSD 比特流转换为 PCM 并受 PCM DSP 滤波处理。",
        ["Detail: %s"] = "详情：%s",
        ["Disabled"] = "已禁用",
        ["DoP active but codec is not DSD."] = "DoP 已启用但编解码器不是 DSD。",
        ["DoP carrier depth insufficient: got %s (requires 24-bit carrier)."] = "DoP 载波位深不足：实际为 %s（需要 24 位载波）。",
        ["DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."] = "DoP 载波封装：%s 1 位 DSD 流打包入 %s %s PCM 载波帧；已绕过 PCM DSP 链。",
        ["DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."] = "DoP 载波速率不匹配：DSD 预期为 %.1f kHz，实际为 %s。",
        ["Duration: %s"] = "时长：%s",
        ["EQ bands configuration missing."] = "缺少 EQ 频段配置。",
        ["EQ digital preamp gain active: %+.2f dB."] = "EQ 数字前级增益已激活：%+.2f dB。",
        ["EQ preamp gain is unknown or invalid."] = "EQ 前级增益未知或无效。",
        ["Enabled equalizer bands: %d / 10"] = "已启用的均衡器频段：%d / 10",
        ["Enabled equalizer bands: Not fully reported"] = "已启用的均衡器频段：未完全报告",
        ["Encoding: Compressed audio · losslessness not confirmed by this header"] = "编码：压缩音频 · 此文件头未确认无损性",
        ["Encoding: Lossless compressed audio"] = "编码：无损压缩音频",
        ["Equalizer bands"] = "均衡器频段",
        ["Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."] = "均衡器旁路还会跳过前级增益、立体声宽度、Crossfeed 和滤波器。",
        ["Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."] = "均衡器旁路已激活；已跳过前级增益、立体声宽度和各频段滤波器。Crossfeed 保持独立。",
        ["Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."] = "均衡器旁路已激活；已跳过前级增益、立体声宽度、Crossfeed 和各频段滤波器。",
        ["Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."] = "均衡器旁路跳过前级增益、立体声宽度和滤波器；Crossfeed 保持独立。",
        ["Equalizer details unavailable"] = "均衡器详情不可用",
        ["Equalizer state unavailable or unqueried; cannot verify flat DSP path."] = "均衡器状态不可用或未查询；无法验证平坦的 DSP 路径。",
        ["Equalizer: %s"] = "均衡器：%s",
        ["Estimated Container Bitrate: %s (includes container/metadata overhead)"] = "预估容器比特率：%s（包含容器/元数据开销）",
        ["FLAC (Free Lossless Audio Codec)"] = "FLAC (Free Lossless Audio Codec)",
        ["File header: %s · %s · %s"] = "文件头：%s · %s · %s",
        ["File picker unavailable. Update firmware to inspect a local file."] = "文件选择器不可用。请更新固件以检查本地文件。",
        ["File size: %s"] = "文件大小：%s",
        ["File: %s"] = "文件：%s",
        ["Final device format: Not available from the player"] = "最终设备格式：播放器不可用",
        ["Final device format: Not reported by the player"] = "最终设备格式：播放器未报告",
        ["Format: %s"] = "格式：%s",
        ["Gapless playback: %s"] = "无缝播放：%s",
        ["Genre: %s"] = "流派：%s",
        ["Header Parsing Status: Unsupported / Malformed"] = "文件头解析状态：不支持 / 损坏",
        ["Headphone crossfeed is active at %.2f strength."] = "耳机 Crossfeed 已激活，强度为 %.2f。",
        ["Headphone crossfeed state is unknown."] = "耳机 Crossfeed 状态未知。",
        ["Headphone crossfeed: %s%s"] = "耳机 Crossfeed：%s%s",
        ["High shelf"] = "高通架 (High shelf)",
        ["In order"] = "顺序播放",
        ["Inspect a file"] = "检查文件",
        ["Inspector settings"] = "检查器设置",
        ["Invalid file path"] = "无效的文件路径",
        ["Length: %s · %s"] = "时长：%s · %s",
        ["Live or unknown length"] = "直播或未知时长",
        ["Local file"] = "本地文件",
        ["Local file details"] = "本地文件详情",
        ["Local output format: %s · %s"] = "本地输出格式：%s · %s",
        ["Lossless compression"] = "无损压缩",
        ["Lossy"] = "有损",
        ["Low shelf"] = "低通架 (Low shelf)",
        ["MP3"] = "MP3",
        ["Malformed AIFF: invalid audio parameters"] = "AIFF 格式损坏：音频参数无效",
        ["Malformed AIFF: missing or truncated COMM chunk"] = "AIFF 格式损坏：缺少 COMM 块或被截断",
        ["Malformed FLAC: STREAMINFO block length too small"] = "FLAC 格式损坏：STREAMINFO 块长度过小",
        ["Malformed FLAC: first metadata block must be STREAMINFO"] = "FLAC 格式损坏：第一个元数据块必须是 STREAMINFO",
        ["Malformed FLAC: invalid audio parameters in STREAMINFO"] = "FLAC 格式损坏：STREAMINFO 中音频参数无效",
        ["Malformed WAV: invalid audio parameters"] = "WAV 格式损坏：音频参数无效",
        ["Malformed WAV: missing or truncated fmt chunk"] = "WAV 格式损坏：缺少 fmt 块或被截断",
        ["Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."] = "启用标准 MSEB 时，手动均衡器频段、前级增益和立体声宽度会被其覆盖。",
        ["Monkey's Audio"] = "Monkey's Audio",
        ["Mono"] = "单声道",
        ["Native DoP bypasses stock MSEB during playback."] = "原生 DoP 在播放过程中绕过标准 MSEB。",
        ["Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."] = "原生 DoP 硬件流绕过 PCM 均衡器、标准 MSEB、立体声宽度和软件音量。",
        ["Neutral"] = "中性",
        ["No"] = "否",
        ["No Active Playback"] = "无活动播放",
        ["No changes detected (wired DoP candidate)"] = "未检测到更改（有线 DoP 候选）",
        ["No changes detected (wired PCM candidate)"] = "未检测到更改（有线 PCM 候选）",
        ["No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."] = "在可观察的播放阶段未检测到更改。此快照无法提供硬件认证。",
        ["No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."] = "在可观察的播放阶段未检测到更改。这是候选状态，并非物理硬件输出的证明。",
        ["Not classified by this inspector"] = "未被此检查器分类",
        ["Not reported"] = "未报告",
        ["Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."] = "注意：检查仅限于本地 WAV、FLAC、AIFF 头部。其他格式不会根据文件扩展名推断，直接报告为未知。",
        ["One-bit DSD audio"] = "1 位 DSD 音频",
        ["Opus"] = "Opus",
        ["Other observation"] = "其他观察项",
        ["Output active: %s"] = "输出处于活动状态：%s",
        ["Output bit depth is unknown or invalid."] = "输出位深未知或无效。",
        ["Output depth differs: audio engine %d-bit -> player-reported %d-bit."] = "输出位深不同：音频引擎 %d 位 -> 播放器报告 %d 位。",
        ["Output details"] = "输出详情",
        ["Output details unavailable"] = "输出详情不可用",
        ["Output device"] = "输出设备",
        ["Output is inactive"] = "输出处于不活动状态",
        ["Output is inactive or its state is unknown."] = "输出处于不活动状态或状态未知。",
        ["Output rate matches engine: %s"] = "输出速率与引擎匹配：%s",
        ["Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."] = "输出为 USB DAC：外部 USB 端点转换与硬件混音器格式未经核实；仅凭匹配的 PCM 参数无法证明比特完美输出。",
        ["Output route: %s · %s"] = "输出路由：%s · %s",
        ["Output sample rate is unknown or invalid."] = "输出采样率未知或无效。",
        ["Output sink DoP flag is not active."] = "输出接收端的 DoP 标志未激活。",
        ["PCM audio"] = "PCM 音频",
        ["Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."] = "参数均衡器有 %d 个已启用的频段；即使响应平坦，滤波处理和峰值保护也可能会影响采样。",
        ["Path is outside SD root"] = "路径在 SD 卡根目录之外",
        ["Paused"] = "暂停",
        ["Peaking"] = "峰值滤波 (Peaking)",
        ["Per album"] = "按专辑",
        ["Per track"] = "按音轨",
        ["Play mode: %s"] = "播放模式：%s",
        ["Playback details"] = "播放详情",
        ["Playback speed modified: %.4fx (time-stretching DSP active)."] = "播放速度已调整：%.4fx（时间拉伸 DSP 已激活）。",
        ["Playback speed state unavailable or invalid."] = "播放速度状态不可用或无效。",
        ["Playback speed: %s"] = "播放速度：%s",
        ["Playback: %s · %s"] = "播放：%s · %s",
        ["Player output rate: %s · %s"] = "播放器输出速率：%s · %s",
        ["Player volume: %s · separate from software audio gain"] = "播放器音量：%s · 独立于软件音频增益",
        ["Player-reported output rate differs from source: %d Hz -> %d Hz."] = "播放器报告的输出速率与源不同：%d Hz -> %d Hz。",
        ["Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."] = "播放器报告的输出速率与 DoP 载波不匹配：%d Hz 对比 %.0f Hz。",
        ["Please close the other file picker and try again."] = "请关闭其他文件选择器后重试。",
        ["Preamp gain: %s%s"] = "前级增益：%s%s",
        ["Refresh output details"] = "刷新输出详情",
        ["Refresh playback details"] = "刷新播放详情",
        ["Refresh signal path check"] = "刷新信号路径检查",
        ["Refresh sound details"] = "刷新声音详情",
        ["Remote streams do not support direct file header inspection; format provided by decoder snapshot"] = "远程流不支持直接检查文件头；格式由解码器快照提供",
        ["ReplayGain (loudness matching): %s · current track applied: %s"] = "ReplayGain（响度匹配）：%s · 当前音轨已应用：%s",
        ["ReplayGain scaling applied: %+.2f dB."] = "已应用 ReplayGain 缩放：%+.2f dB。",
        ["ReplayGain state unavailable."] = "ReplayGain 状态不可用。",
        ["ReplayGain was reported as applied, but its gain amount is unknown."] = "ReplayGain 报告已应用，但其增益数值未知。",
        ["Resampling active: source %d Hz -> output %d Hz."] = "重采样已激活：源 %d Hz -> 输出 %d Hz。",
        ["Result: %s"] = "结果：%s",
        ["Route: %s"] = "路由：%s",
        ["Sample Rate: %s"] = "采样率：%s",
        ["Show full file paths"] = "显示完整文件路径",
        ["Show music library tags"] = "显示音乐库标签",
        ["Signal check"] = "信号检查",
        ["Software audio gain: %s"] = "软件音频增益：%s",
        ["Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."] = "软件音量处于单位增益（1.00 / 0.0 dB - 无数字 PCM 缩放）。",
        ["Software volume scaling active: %.6fx (%s digital modification)."] = "软件音量缩放已激活：%.6fx（%s 数字调整）。",
        ["Software volume state unavailable or invalid; cannot verify unity gain."] = "软件音量状态不可用或无效；无法验证单位增益。",
        ["Sound processing"] = "声音处理",
        ["Source and audio engine rates match: %s"] = "源与音频引擎速率匹配：%s",
        ["Source audio: %s · %s · %s"] = "源音频：%s · %s · %s",
        ["Source bit depth is unknown or lossy (no original PCM depth)."] = "源位深未知或为有损编码（无原始 PCM 位深）。",
        ["Source channels count is unknown or invalid."] = "源声道数未知或无效。",
        ["Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."] = "源编解码器为有损 (%s)：有损解码无法保证原始 PCM 母带的比特完美还原。",
        ["Source codec is unknown."] = "源编解码器未知。",
        ["Source quality: %s"] = "源音质：%s",
        ["Source sample rate is unknown or invalid."] = "源采样率未知或无效。",
        ["Source: %s · %s"] = "来源：%s · %s",
        ["Start or resume playback to inspect the decoder's live format."] = "开始或继续播放以检查解码器的实时格式。",
        ["State unknown"] = "状态未知",
        ["Stereo width is unknown or invalid."] = "立体声宽度未知或无效。",
        ["Stereo width processing is active: %.4f."] = "立体声宽度处理已激活：%.4f。",
        ["Stereo width: %s%s"] = "立体声宽度：%s%s",
        ["Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."] = "标准 MSEB 会覆盖保存的手动 EQ 频段、前级增益和立体声宽度；Crossfeed 保持独立。",
        ["Stock MSEB processing is enabled with non-neutral settings."] = "标准 MSEB 处理已启用且设置非中性。",
        ["Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."] = "标准 MSEB 设置不完整或无效；无法验证中性 PCM 路径。",
        ["Stock MSEB state is unavailable; cannot verify the PCM processing path."] = "标准 MSEB 状态不可用；无法验证 PCM 处理路径。",
        ["Stock MSEB: %s"] = "标准 MSEB：%s",
        ["Stream name or endpoint: %s"] = "流名称或端点：%s",
        ["The active output route is unknown."] = "活动输出路由未知。",
        ["The external device's final conversion and output format are not visible here."] = "外部设备的最终转换与输出格式在此不可见。",
        ["The full equalizer band state is unavailable."] = "完整的均衡器频段状态不可用。",
        ["The local output format is not reported by the player."] = "播放器未报告本地输出格式。",
        ["The player cannot compare the engine and output sample rates."] = "播放器无法比较引擎与输出采样率。",
        ["The player reports different engine and output sample rates."] = "播放器报告引擎与输出的采样率不同。",
        ["The remote device's final output format is not visible here."] = "远程设备的最终输出格式在此不可见。",
        ["The snapshot shows a change or lacks enough information to verify an unchanged signal path."] = "快照显示存在更改，或者缺乏足够的信息来验证信号路径未受改动。",
        ["This firmware does not expose a live equalizer snapshot."] = "此固件未公开实时均衡器快照。",
        ["This firmware does not expose a live output snapshot."] = "此固件未公开实时输出快照。",
        ["Title: %s"] = "标题：%s",
        ["Track Inspector"] = "音轨检查器",
        ["Track and file details"] = "音轨与文件详情",
        ["Truncated FLAC STREAMINFO header (less than 42 bytes)"] = "FLAC STREAMINFO 头部截断（不足 42 字节）",
        ["Truncated file header (less than 12 bytes)"] = "文件头截断（不足 12 字节）",
        ["Type: Uncompressed PCM"] = "类型：非压缩 PCM",
        ["USB audio"] = "USB 音频",
        ["USB audio output is selected"] = "已选择 USB 音频输出",
        ["USB output cannot be fully checked"] = "USB 输出无法完全检查",
        ["Uncompressed PCM"] = "非压缩 PCM",
        ["Unknown"] = "未知",
        ["Unknown (mode not reported)"] = "未知（未报告模式）",
        ["Unknown / Negotiating"] = "未知 / 协商中",
        ["Unknown / not reported"] = "未知 / 未报告",
        ["Unknown filter"] = "未知滤波器",
        ["Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"] = "未知文件头格式（检查仅限 WAV、FLAC、AIFF 头部；不会从后缀推断格式）",
        ["Unknown route"] = "未知路由",
        ["View all equalizer bands"] = "查看所有均衡器频段",
        ["Vorbis"] = "Vorbis",
        ["WAV (Compressed Extensible: 0x%04X)"] = "WAV (压缩可扩展：0x%04X)",
        ["WAV (Compressed: format 0x%04X)"] = "WAV (压缩：格式 0x%04X)",
        ["WAV (Extensible Float)"] = "WAV (可扩展浮点)",
        ["WAV (Extensible PCM)"] = "WAV (可扩展 PCM)",
        ["WAV (IEEE Float)"] = "WAV (IEEE 浮点)",
        ["WAV (PCM Integer)"] = "WAV (PCM 整数)",
        ["WavPack"] = "WavPack",
        ["WavPack lossless or hybrid mode and correction-file status are unreported."] = "WavPack 无损或混合模式及修正文件状态未报告。",
        ["Wider or narrower stereo"] = "更宽或更窄的立体声",
        ["Windows Media Audio"] = "Windows Media Audio",
        ["Wired output"] = "有线输出",
        ["Wired output is selected"] = "已选择有线输出",
        ["Yes"] = "是",
        ["active"] = "活动",
        ["amount unknown"] = "数值未知",
        ["differs from the engine"] = "与引擎不同",
        ["forward-only"] = "仅快进",
        ["gain unknown"] = "增益未知",
        ["matches the engine"] = "与引擎匹配",
        ["seek status unknown"] = "跳转状态未知",
        ["seekable"] = "可跳转",
        ["standby"] = "待机",
        ["status unknown"] = "状态未知",
        ["unity (0 dB)"] = "单位增益 (0 dB)",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end
-- Track Inspector
-- Inspects audio playback format snapshots, output route and hardware sink info,
-- parametric EQ and DSP signal chain status, bit-perfect PCM candidate criteria,
-- and local file headers for WAV, FLAC, and AIFF.

local HEADER_READ_LIMIT = 4096
local FLOAT_TOLERANCE = 1e-6

local settings = {
    show_full_path = false,
    show_db_tags = true,
}

local function load_settings()
    if plugin.has_capability("storage.namespaced") and plugin.storage then
        local ok, val = pcall(plugin.storage.get, "show_full_path", "0")
        if ok and val == "1" then settings.show_full_path = true end
        local ok_tags, val_tags = pcall(plugin.storage.get, "show_db_tags", "1")
        if ok_tags and val_tags == "0" then settings.show_db_tags = false end
    end
end

local function save_setting(key, val)
    if plugin.has_capability("storage.namespaced") and plugin.storage then
        pcall(plugin.storage.set, key, val)
    end
end

load_settings()

--------------------------------------------------------------------------------
-- String, Path and Numerical Formatting Helpers
--------------------------------------------------------------------------------

local function is_valid_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function has_capability(name)
    if type(plugin.has_capability) ~= "function" then return false end
    local ok, supported = pcall(plugin.has_capability, name)
    return ok and supported == true
end

local function format_hz(hz)
    if not is_valid_number(hz) or hz <= 0 then return tr("Unknown") end
    if hz % 1000 == 0 then
        return string.format("%.1f kHz (%d Hz)", hz / 1000, math.floor(hz))
    elseif hz % 100 == 0 then
        return string.format("%.1f kHz (%d Hz)", hz / 1000, math.floor(hz))
    else
        return string.format("%.2f kHz (%d Hz)", hz / 1000, math.floor(hz))
    end
end

local function format_depth(bits)
    if not is_valid_number(bits) or bits <= 0 then return tr("Unknown / not reported") end
    return string.format(tr("%d-bit"), math.floor(bits))
end

local function format_channels(ch)
    if not is_valid_number(ch) or ch <= 0 then return tr("Unknown") end
    ch = math.floor(ch)
    if ch == 1 then return tr("1 (Mono)") end
    if ch == 2 then return tr("2 (Stereo)") end
    if ch > 2 then return string.format(tr("%d channels"), ch) end
    return tr("Unknown")
end

local function format_bitrate(kbps)
    if not is_valid_number(kbps) or kbps <= 0 then return tr("Unknown") end
    return string.format(tr("%d kbps"), math.floor(kbps))
end

local function format_duration(sec)
    if not is_valid_number(sec) or sec < 0 then return tr("Unknown") end
    if sec == 0 then return tr("Live or unknown length") end
    if sec >= 3600 then
        return string.format("%d:%02d:%02d", math.floor(sec / 3600), math.floor(sec / 60) % 60, math.floor(sec) % 60)
    end
    local m = math.floor(sec / 60)
    local s = math.floor(sec % 60)
    return string.format(tr("%d:%02d (%d s)"), m, s, math.floor(sec))
end

local function format_gain_db(gain_linear)
    if not is_valid_number(gain_linear) or gain_linear <= 0 then return tr("-inf dB") end
    local db = 20 * (math.log(gain_linear) / math.log(10))
    return string.format("%+.2f dB", db)
end

local function basename(path)
    if not path or path == "" then return "" end
    return path:match("([^/\\]+)$") or path
end

local function is_remote_url(path)
    if type(path) ~= "string" then return false end
    return path:match("^%a[%w+%.%-]*://") ~= nil
end

local function sanitize_path(path)
    if type(path) ~= "string" or path == "" then return "" end
    if is_remote_url(path) then
        local clean = path:gsub("[?#].*$", "")
        local scheme, authority, suffix = clean:match("^(%a[%w+.-]*://)([^/]*)(.*)$")
        if scheme and authority then
            local last_at = authority:match(".*()@")
            if last_at then authority = authority:sub(last_at + 1) end
            clean = scheme .. authority .. suffix
        end
        return clean
    end
    return path
end

local function safe_display_path(path, show_full)
    if type(path) ~= "string" or path == "" then return "" end
    local clean = sanitize_path(path)
    if not show_full then
        if is_remote_url(clean) then
            local name = clean:match("([^/]+)$")
            return name or clean
        else
            return basename(clean)
        end
    end
    return clean
end

local function is_within_sd(path, sd_root)
    if type(path) ~= "string" or type(sd_root) ~= "string" or path == "" or sd_root == "" then
        return false
    end
    if is_remote_url(path) then return false end
    local clean_root = sd_root:gsub("/+$", "")
    if path ~= clean_root and not path:find("^" .. clean_root:gsub("([^%w])", "%%%1") .. "/") then
        return false
    end
    if path:find("/%.%./") or path:find("/%.%.$") or path:find("^%.%./") then
        return false
    end
    return true
end

--------------------------------------------------------------------------------
-- Binary Header Parsers (Bounded reads: WAV, FLAC, AIFF)
--------------------------------------------------------------------------------

local function read_u16_le(bytes, offset)
    local b1, b2 = bytes:byte(offset, offset + 1)
    if not b1 or not b2 then return nil end
    return b1 | (b2 << 8)
end

local function read_u32_le(bytes, offset)
    local b1, b2, b3, b4 = bytes:byte(offset, offset + 3)
    if not b1 or not b4 then return nil end
    return b1 | (b2 << 8) | (b3 << 16) | (b4 << 24)
end

local function read_u16_be(bytes, offset)
    local b1, b2 = bytes:byte(offset, offset + 1)
    if not b1 or not b2 then return nil end
    return (b1 << 8) | b2
end

local function read_u32_be(bytes, offset)
    local b1, b2, b3, b4 = bytes:byte(offset, offset + 3)
    if not b1 or not b4 then return nil end
    return (b1 << 24) | (b2 << 16) | (b3 << 8) | b4
end

local function decode_ieee_extended(bytes, offset)
    if not bytes or #bytes < offset + 9 then return nil end
    local b1, b2 = bytes:byte(offset, offset + 1)
    local sign = (b1 & 0x80) ~= 0
    local exp = ((b1 & 0x7F) << 8) | b2
    local b3, b4, b5, b6, b7, b8, b9, b10 = bytes:byte(offset + 2, offset + 9)
    if exp == 0 and b3 == 0 and b4 == 0 then return 0 end
    if exp == 0x7FFF then return nil end
    local f_mantissa = (b3 * (2.0 ^ -7))
                     + (b4 * (2.0 ^ -15))
                     + (b5 * (2.0 ^ -23))
                     + (b6 * (2.0 ^ -31))
                     + (b7 * (2.0 ^ -39))
                     + (b8 * (2.0 ^ -47))
                     + (b9 * (2.0 ^ -55))
                     + (b10 * (2.0 ^ -63))
    local rate = (2.0 ^ (exp - 16383)) * f_mantissa
    if sign then rate = -rate end
    return math.floor(rate + 0.5)
end

local function parse_local_file_header(path)
    if type(path) ~= "string" or path == "" then
        return nil, tr("Invalid file path")
    end
    if is_remote_url(path) then
        return nil, tr("Remote streams do not support direct file header inspection; format provided by decoder snapshot")
    end
    if plugin.sd_root and not is_within_sd(path, plugin.sd_root()) then
        return nil, tr("Path is outside SD root")
    end

    local f, err = io.open(path, "rb")
    if not f then
        return nil, string.format(tr("Could not open file: %s"), tostring(err))
    end

    local file_size = f:seek("end") or 0
    f:seek("set", 0)
    local buf = f:read(HEADER_READ_LIMIT)
    f:close()

    if not buf or #buf < 12 then
        return nil, tr("Truncated file header (less than 12 bytes)")
    end

    -- 1. WAV Detection (RIFF/RIFX .... WAVE)
    local riff_id = buf:sub(1, 4)
    if (riff_id == "RIFF" or riff_id == "RIFX") and buf:sub(9, 12) == "WAVE" then
        local is_be = (riff_id == "RIFX")
        local offset = 13
        local fmt_found = false
        local audio_format, channels, sample_rate, byte_rate, bit_depth, extensible_subfmt
        local data_size = nil

        while offset + 8 <= #buf do
            local chunk_id = buf:sub(offset, offset + 3)
            local chunk_len = is_be and read_u32_be(buf, offset + 4) or read_u32_le(buf, offset + 4)
            if not chunk_len or chunk_len < 0 then break end
            local data_offset = offset + 8

            if chunk_id == "fmt " and chunk_len >= 16 then
                if data_offset + 16 > #buf + 1 then break end
                audio_format = is_be and read_u16_be(buf, data_offset) or read_u16_le(buf, data_offset)
                channels = is_be and read_u16_be(buf, data_offset + 2) or read_u16_le(buf, data_offset + 2)
                sample_rate = is_be and read_u32_be(buf, data_offset + 4) or read_u32_le(buf, data_offset + 4)
                byte_rate = is_be and read_u32_be(buf, data_offset + 8) or read_u32_le(buf, data_offset + 8)
                bit_depth = is_be and read_u16_be(buf, data_offset + 14) or read_u16_le(buf, data_offset + 14)
                if audio_format == 0xFFFE and chunk_len >= 40 and data_offset + 26 <= #buf then
                    extensible_subfmt = is_be and read_u16_be(buf, data_offset + 24) or read_u16_le(buf, data_offset + 24)
                end
                fmt_found = true
            elseif chunk_id == "data" then
                data_size = chunk_len
            end

            offset = data_offset + chunk_len + (chunk_len % 2)
        end

        if not fmt_found or not sample_rate or not channels or not bit_depth then
            return nil, tr("Malformed WAV: missing or truncated fmt chunk")
        end
        if sample_rate <= 0 or channels <= 0 or bit_depth <= 0 then
            return nil, tr("Malformed WAV: invalid audio parameters")
        end

        local codec, format_name, is_compressed
        if audio_format == 1 then
            codec = "pcm"
            format_name = tr("WAV (PCM Integer)")
            is_compressed = false
        elseif audio_format == 3 then
            codec = "wav_float"
            format_name = tr("WAV (IEEE Float)")
            is_compressed = false
        elseif audio_format == 0xFFFE then
            if extensible_subfmt == 1 then
                codec = "pcm"
                format_name = tr("WAV (Extensible PCM)")
                is_compressed = false
            elseif extensible_subfmt == 3 then
                codec = "wav_float"
                format_name = tr("WAV (Extensible Float)")
                is_compressed = false
            else
                codec = "wav_compressed"
                format_name = string.format(tr("WAV (Compressed Extensible: 0x%04X)"), extensible_subfmt or 0)
                is_compressed = true
            end
        else
            codec = "wav_compressed"
            format_name = string.format(tr("WAV (Compressed: format 0x%04X)"), audio_format)
            is_compressed = true
        end

        local duration = 0
        local bitrate_kbps = 0
        if not is_compressed then
            if data_size and byte_rate and byte_rate > 0 then
                duration = data_size / byte_rate
            elseif file_size > 44 and byte_rate and byte_rate > 0 then
                duration = (file_size - 44) / byte_rate
            end
            bitrate_kbps = math.floor((sample_rate * channels * bit_depth) / 1000)
        else
            if file_size > 0 and duration > 0 then
                bitrate_kbps = math.floor((file_size * 8) / (duration * 1000))
            end
        end

        return {
            codec = codec,
            format_name = format_name,
            sample_rate = sample_rate,
            bit_depth = bit_depth,
            channels = channels,
            duration_seconds = duration,
            bitrate_kbps = bitrate_kbps,
            file_size = file_size,
            is_compressed = is_compressed,
        }
    end

    -- 2. FLAC Detection ("fLaC")
    if buf:sub(1, 4) == "fLaC" then
        if #buf < 42 then
            return nil, tr("Truncated FLAC STREAMINFO header (less than 42 bytes)")
        end
        local block_header = buf:byte(5)
        local block_type = block_header & 0x7F
        if block_type ~= 0 then
            return nil, tr("Malformed FLAC: first metadata block must be STREAMINFO")
        end
        local block_len = (buf:byte(6) << 16) | (buf:byte(7) << 8) | buf:byte(8)
        if block_len < 34 then
            return nil, tr("Malformed FLAC: STREAMINFO block length too small")
        end

        local b1, b2, b3, b4, b5, b6, b7, b8 = buf:byte(19, 26)
        local sample_rate = (b1 << 12) | (b2 << 4) | (b3 >> 4)
        local channels = ((b3 >> 1) & 0x07) + 1
        local bit_depth = (((b3 & 0x01) << 4) | (b4 >> 4)) + 1
        local total_samples = ((b4 & 0x0F) * 4294967296) + (b5 << 24) + (b6 << 16) + (b7 << 8) + b8

        if sample_rate <= 0 or channels <= 0 or bit_depth <= 0 then
            return nil, tr("Malformed FLAC: invalid audio parameters in STREAMINFO")
        end

        local duration = (sample_rate > 0 and total_samples > 0) and (total_samples / sample_rate) or 0
        local bitrate_kbps = 0
        if file_size > 0 and duration > 0 then
            bitrate_kbps = math.floor((file_size * 8) / (duration * 1000))
        end

        return {
            codec = "flac",
            format_name = tr("FLAC (Free Lossless Audio Codec)"),
            sample_rate = sample_rate,
            bit_depth = bit_depth,
            channels = channels,
            duration_seconds = duration,
            bitrate_kbps = bitrate_kbps,
            file_size = file_size,
            total_samples = total_samples,
            is_compressed = true,
        }
    end

    -- 3. AIFF / AIFC Detection ("FORM" .... "AIFF" or "AIFC")
    if buf:sub(1, 4) == "FORM" and (buf:sub(9, 12) == "AIFF" or buf:sub(9, 12) == "AIFC") then
        local is_aifc = (buf:sub(9, 12) == "AIFC")
        local offset = 13
        local comm_found = false
        local channels, sample_frames, bit_depth, sample_rate
        local compression_type = is_aifc and "NONE" or "NONE"

        while offset + 8 <= #buf do
            local chunk_id = buf:sub(offset, offset + 3)
            local chunk_len = read_u32_be(buf, offset + 4)
            if not chunk_len or chunk_len < 0 then break end
            local data_offset = offset + 8

            if chunk_id == "COMM" and chunk_len >= 18 then
                if data_offset + 18 > #buf + 1 then break end
                channels = read_u16_be(buf, data_offset)
                sample_frames = read_u32_be(buf, data_offset + 2)
                bit_depth = read_u16_be(buf, data_offset + 6)
                sample_rate = decode_ieee_extended(buf, data_offset + 8)
                if is_aifc and chunk_len >= 22 and data_offset + 22 <= #buf + 1 then
                    compression_type = buf:sub(data_offset + 18, data_offset + 21)
                end
                comm_found = true
                break
            end

            offset = data_offset + chunk_len + (chunk_len % 2)
        end

        if not comm_found or not sample_rate or not channels or not bit_depth then
            return nil, tr("Malformed AIFF: missing or truncated COMM chunk")
        end
        if sample_rate <= 0 or channels <= 0 or bit_depth <= 0 then
            return nil, tr("Malformed AIFF: invalid audio parameters")
        end

        local codec, format_name, is_compressed
        if not is_aifc then
            codec = "pcm"
            format_name = tr("AIFF (PCM)")
            is_compressed = false
        else
            if compression_type == "NONE" then
                codec = "pcm"
                format_name = tr("AIFC (PCM)")
                is_compressed = false
            elseif compression_type == "sowt" then
                codec = "pcm"
                format_name = tr("AIFC (Little-Endian PCM)")
                is_compressed = false
            elseif compression_type == "fl32" or compression_type == "fl64" then
                codec = "aifc_float"
                format_name = tr("AIFC (Float)")
                is_compressed = false
            else
                codec = "aifc_compressed"
                format_name = string.format(tr("AIFC (Compressed: %s)"), compression_type)
                is_compressed = true
            end
        end

        local duration = (sample_rate > 0 and sample_frames and sample_frames > 0) and (sample_frames / sample_rate) or 0
        local bitrate_kbps = 0
        if not is_compressed then
            bitrate_kbps = math.floor((sample_rate * channels * bit_depth) / 1000)
        else
            if file_size > 0 and duration > 0 then
                bitrate_kbps = math.floor((file_size * 8) / (duration * 1000))
            end
        end

        return {
            codec = codec,
            format_name = format_name,
            sample_rate = sample_rate,
            bit_depth = bit_depth,
            channels = channels,
            duration_seconds = duration,
            bitrate_kbps = bitrate_kbps,
            file_size = file_size,
            is_compressed = is_compressed,
        }
    end

    return nil, tr("Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)")
end

--------------------------------------------------------------------------------
-- Bit-Perfect Candidate Evaluation
--------------------------------------------------------------------------------

-- audio.crossfeed predates independent bypass behavior. The stock-MSEB
-- capability identifies the first firmware boundary that guarantees it;
-- older API 16 releases still bypass crossfeed with the manual EQ.
local function crossfeed_runs_when_bypassed()
    return has_capability("audio.mseb.stock")
end

local MSEB_FIELDS = {
    "temperature", "bass_ext", "bass_texture", "thickness", "vocal_pos",
    "female_vocal", "sibilance_lf", "sibilance_hf", "impulse_tone", "air",
}

local function get_mseb_snapshot()
    local cap_ok, supported = pcall(plugin.has_capability, "audio.mseb.stock")
    if not cap_ok or not supported or type(plugin.get_mseb_state) ~= "function" then
        return nil, false
    end
    local ok, state = pcall(plugin.get_mseb_state)
    if not ok or type(state) ~= "table" or type(state.enabled) ~= "boolean" then
        return nil, true
    end
    return state, true
end

local function mseb_has_effect(state)
    if type(state) ~= "table" then return nil end
    for _, field in ipairs(MSEB_FIELDS) do
        local value = state[field]
        if not is_valid_number(value) or value < -100 or value > 100 or value % 1 ~= 0 then
            return nil
        end
        if value ~= 0 then return true end
    end
    local width = state.width
    if not is_valid_number(width) or width < 0 or width > 2 then return nil end
    return width ~= 1
end

local function assess_bit_perfect(fmt, out, eq, mseb, mseb_supported)
    if not fmt then
        return {
            status = tr("No Active Playback"),
            is_candidate = false,
            reasons = { tr("Audio engine is idle; no active playback stream to inspect.") },
            notes = {},
        }
    end

    local reasons = {}
    local notes = {}

    -- Codec validation
    local codec = fmt.codec and tostring(fmt.codec):lower() or "unknown"
    if codec == "" or codec == "unknown" then
        table.insert(reasons, tr("Source codec is unknown."))
    end
    if codec == "wavpack" then
        table.insert(reasons, tr("WavPack lossless or hybrid mode and correction-file status are unreported."))
    end

    -- Required source & output format dimensions
    local src_rate = fmt.sample_rate
    local out_rate = fmt.output_sample_rate
    local src_depth = fmt.bit_depth
    local out_depth = fmt.output_bit_depth
    local channels = fmt.channels

    if not is_valid_number(src_rate) or src_rate <= 0 then
        table.insert(reasons, tr("Source sample rate is unknown or invalid."))
    end
    if not is_valid_number(out_rate) or out_rate <= 0 then
        table.insert(reasons, tr("Output sample rate is unknown or invalid."))
    end
    if not is_valid_number(channels) or channels <= 0 then
        table.insert(reasons, tr("Source channels count is unknown or invalid."))
    end

    -- Required sink presence
    if not out or out.active ~= true then
        table.insert(reasons, tr("Output is inactive or its state is unknown."))
    end

    -- Route check
    local route = out and out.route or "unknown"
    if route == "bluetooth" then
        local bt_codec = (out and out.bluetooth_codec) or tr("Unknown / Negotiating")
        table.insert(reasons, string.format(tr("Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here."), bt_codec))
    elseif route == "usb_dac" then
        table.insert(reasons, tr("Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output."))
    elseif route ~= "wired" then
        table.insert(reasons, tr("The active output route is unknown."))
    end

    local hardware_format_known = out and (is_valid_number(out.hardware_sample_rate) and out.hardware_sample_rate > 0
        and is_valid_number(out.hardware_bit_depth) and out.hardware_bit_depth > 0)
    if out then
        if out.resampling_known then
            if out.resampling then
                table.insert(reasons, tr("The player reports different engine and output sample rates."))
            end
        else
            table.insert(reasons, tr("The player cannot compare the engine and output sample rates."))
        end
        if not hardware_format_known then
            table.insert(reasons, tr("The local output format is not reported by the player."))
        elseif is_valid_number(out_depth) and out.hardware_bit_depth ~= out_depth then
            table.insert(reasons, string.format(tr("Output depth differs: audio engine %d-bit -> player-reported %d-bit."), out_depth, out.hardware_bit_depth))
        end
    end

    -- Native DoP vs DSD-to-PCM Decimation
    local is_true_dop = (fmt.dop == true)
    if is_true_dop then
        if codec ~= "dsd" then
            table.insert(reasons, tr("DoP active but codec is not DSD."))
        end
        local expected_carrier_rate = is_valid_number(src_rate) and (src_rate / 16) or 0
        if not is_valid_number(out_rate) or math.abs(out_rate - expected_carrier_rate) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format(tr("DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s."), expected_carrier_rate / 1000, format_hz(out_rate)))
        end
        if not is_valid_number(out_depth) or out_depth < 24 then
            table.insert(reasons, string.format(tr("DoP carrier depth insufficient: got %s (requires 24-bit carrier)."), format_depth(out_depth)))
        end
        if not out or out.dop ~= true then
            table.insert(reasons, tr("Output sink DoP flag is not active."))
        end
        if hardware_format_known and is_valid_number(out.hardware_sample_rate) and math.abs(out.hardware_sample_rate - expected_carrier_rate) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format(tr("Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz."), out.hardware_sample_rate, expected_carrier_rate))
        end

        table.insert(notes, string.format(tr("DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed."),
            format_hz(src_rate), format_hz(out_rate), format_depth(out_depth)))
    elseif fmt.is_dsd then
        table.insert(reasons, tr("DSD stream converted to PCM (decimation active; not native DSD direct passthrough)."))
        table.insert(notes, tr("DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering."))
    end

    -- PCM specific validation
    if not is_true_dop then
        if not is_valid_number(src_depth) or src_depth <= 0 then
            table.insert(reasons, tr("Source bit depth is unknown or lossy (no original PCM depth)."))
        end
        if not is_valid_number(out_depth) or out_depth <= 0 then
            table.insert(reasons, tr("Output bit depth is unknown or invalid."))
        end

        if codec == "mp3" or codec == "aac" or codec == "opus" or codec == "vorbis" or codec == "wma" then
            table.insert(reasons, string.format(tr("Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master."), codec:upper()))
        end

        if is_valid_number(src_rate) and is_valid_number(out_rate) and math.abs(src_rate - out_rate) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format(tr("Resampling active: source %d Hz -> output %d Hz."), math.floor(src_rate), math.floor(out_rate)))
        end

        if hardware_format_known and is_valid_number(out.hardware_sample_rate) and is_valid_number(src_rate) and math.abs(out.hardware_sample_rate - src_rate) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format(tr("Player-reported output rate differs from source: %d Hz -> %d Hz."), math.floor(src_rate), math.floor(out.hardware_sample_rate)))
        end

        if is_valid_number(src_depth) and is_valid_number(out_depth) and src_depth ~= out_depth then
            if src_depth > out_depth then
                table.insert(reasons, string.format(tr("Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss)."), math.floor(src_depth), math.floor(out_depth)))
            else
                table.insert(reasons, string.format(tr("Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified)."), math.floor(src_depth), math.floor(out_depth)))
            end
        end

        -- Stock MSEB replaces manual EQ, preamp and stereo width while active.
        local mseb_enabled = mseb_supported and mseb and mseb.enabled == true
        if mseb_supported and not mseb then
            table.insert(reasons, tr("Stock MSEB state is unavailable; cannot verify the PCM processing path."))
        elseif mseb_enabled then
            local mseb_effect = mseb_has_effect(mseb)
            if mseb_effect == true then
                table.insert(reasons, tr("Stock MSEB processing is enabled with non-neutral settings."))
            elseif mseb_effect == nil then
                table.insert(reasons, tr("Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path."))
            end
        end

        -- Parametric EQ & Stereo Width
        if not eq or type(eq.bypass) ~= "boolean" then
            table.insert(reasons, tr("Equalizer state unavailable or unqueried; cannot verify flat DSP path."))
        elseif eq.bypass == true then
            local crossfeed_independent = crossfeed_runs_when_bypassed()
            table.insert(notes, crossfeed_independent
                and tr("Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent.")
                or tr("Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped."))
            if crossfeed_independent then
                local crossfeed = eq.crossfeed
                if not is_valid_number(crossfeed) and (not is_valid_number(channels) or channels == 2) then
                    table.insert(reasons, tr("Headphone crossfeed state is unknown."))
                elseif is_valid_number(crossfeed) and (not is_valid_number(channels) or channels == 2) and crossfeed > 0 then
                    table.insert(reasons, string.format(tr("Headphone crossfeed is active at %.2f strength."), crossfeed))
                end
            end
        else
            if mseb_enabled then
                table.insert(notes, tr("Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled."))
            else
                local preamp = eq.preamp_db
                if not is_valid_number(preamp) then
                    table.insert(reasons, tr("EQ preamp gain is unknown or invalid."))
                elseif preamp ~= 0 then
                    table.insert(reasons, string.format(tr("EQ digital preamp gain active: %+.2f dB."), preamp))
                end
            end

            local width = eq.stereo_width
            if not mseb_enabled then
                if not is_valid_number(width) and (not is_valid_number(channels) or channels == 2) then
                    table.insert(reasons, tr("Stereo width is unknown or invalid."))
                elseif (not is_valid_number(channels) or channels == 2) and width ~= 1.0 then
                    table.insert(reasons, string.format(tr("Stereo width processing is active: %.4f."), width))
                end
            end

            local crossfeed = eq.crossfeed
            if not is_valid_number(crossfeed) and (not is_valid_number(channels) or channels == 2) then
                table.insert(reasons, tr("Headphone crossfeed state is unknown."))
            elseif is_valid_number(crossfeed) and (not is_valid_number(channels) or channels == 2) and crossfeed > 0 then
                table.insert(reasons, string.format(tr("Headphone crossfeed is active at %.2f strength."), crossfeed))
            end

            local active_bands = 0
            if mseb_enabled then
                -- The manual bands remain stored but do not affect output.
            elseif type(eq.bands) == "table" then
                if #eq.bands ~= 10 then table.insert(reasons, tr("The full equalizer band state is unavailable.")) end
                for _, band in ipairs(eq.bands) do
                    if band.enabled == nil then
                        table.insert(reasons, tr("An EQ band's enabled state is unknown."))
                    elseif band.enabled then
                        local band_type = type(band.type) == "string" and band.type:lower() or "unknown"
                        if band_type ~= "peaking" and band_type ~= "low_shelf" and band_type ~= "high_shelf" then
                            table.insert(reasons, tr("An enabled EQ band has an unrecognized filter type; its effect is unknown."))
                        elseif not is_valid_number(band.gain_db) then
                            table.insert(reasons, tr("An enabled EQ filter has unknown gain."))
                        else
                            active_bands = active_bands + 1
                        end
                    end
                end
            else
                table.insert(reasons, tr("EQ bands configuration missing."))
            end
            if active_bands > 0 then
                table.insert(reasons, string.format(tr("Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response."), active_bands))
            end
        end

        -- Software Volume Gain
        local soft_gain = fmt.software_volume_gain
        if not is_valid_number(soft_gain) then
            table.insert(reasons, tr("Software volume state unavailable or invalid; cannot verify unity gain."))
        elseif soft_gain ~= 1.0 then
            table.insert(reasons, string.format(tr("Software volume scaling active: %.6fx (%s digital modification)."), soft_gain, format_gain_db(soft_gain)))
        else
            table.insert(notes, tr("Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling)."))
        end

        -- Playback Speed
        local speed = fmt.playback_speed
        if not is_valid_number(speed) then
            table.insert(reasons, tr("Playback speed state unavailable or invalid."))
        elseif speed ~= 1.0 then
            table.insert(reasons, string.format(tr("Playback speed modified: %.4fx (time-stretching DSP active)."), speed))
        end

        -- ReplayGain
        if fmt.replaygain_applied == nil then
            table.insert(reasons, tr("ReplayGain state unavailable."))
        elseif fmt.replaygain_applied == true then
            local rg_db = fmt.replaygain_applied_db
            if not is_valid_number(rg_db) then
                table.insert(reasons, tr("ReplayGain was reported as applied, but its gain amount is unknown."))
            elseif rg_db ~= 0 then
                table.insert(reasons, string.format(tr("ReplayGain scaling applied: %+.2f dB."), rg_db))
            end
        end

        if fmt.crossfade_enabled then
            table.insert(reasons, tr("Crossfade is enabled; the player does not report whether tracks are currently being mixed."))
        end
    else
        table.insert(notes, tr("Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume."))
    end

    local status, is_candidate
    if #reasons == 0 and route == "wired" and hardware_format_known then
        if is_true_dop then
            status = tr("No changes detected (wired DoP candidate)")
        else
            status = tr("No changes detected (wired PCM candidate)")
        end
        is_candidate = true
        table.insert(notes, tr("No changes detected in the observable playback stages. Hardware certification is not available from this snapshot."))
    elseif route == "bluetooth" or route == "usb_dac" then
        status = route == "bluetooth" and tr("Bluetooth can change audio") or tr("USB output cannot be fully checked")
        is_candidate = false
    elseif out and out.active ~= true then
        status = tr("Output is inactive")
        is_candidate = false
    else
        status = tr("Changes detected or information unavailable")
        is_candidate = false
    end

    return {
        status = status,
        is_candidate = is_candidate,
        reasons = reasons,
        notes = notes,
        route = route,
    }
end

--------------------------------------------------------------------------------
-- Live State Snapshot Providers
--------------------------------------------------------------------------------

local function get_format_snapshot()
    if not plugin.has_capability("playback.format") or not plugin.get_playback_format then
        return nil, "playback.format capability not available"
    end
    local f = plugin.get_playback_format()
    if not f then return nil, "Audio engine is idle" end
    return f
end

local function get_output_snapshot()
    if not plugin.has_capability("playback.output_info") or not plugin.get_output_info then
        return nil, "playback.output_info capability not available"
    end
    return plugin.get_output_info()
end

local function get_live_eq()
    if not plugin.has_capability("audio.peq.state") or not plugin.get_eq_state then
        return nil, "audio.peq.state capability not available"
    end
    return plugin.get_eq_state()
end
local get_eq_snapshot = get_live_eq

local function get_track_metadata(path)
    if not path or is_remote_url(path) then return nil end
    if not plugin.has_capability("library.track_metadata") or not plugin.get_track_metadata then
        return nil
    end
    return plugin.get_track_metadata(path)
end

local CODEC_NAMES = {
    flac = "FLAC (Free Lossless Audio Codec)", mp3 = "MP3", pcm = "PCM audio",
    dsd = "DSD audio", aac = "AAC", alac = "ALAC (Apple Lossless)",
    ape = "Monkey's Audio", wma = "Windows Media Audio", opus = "Opus",
    vorbis = "Vorbis", wavpack = "WavPack", unknown = "Unknown codec",
}

local function codec_name(codec)
    local key = type(codec) == "string" and codec:lower() or "unknown"
    local raw = CODEC_NAMES[key] or key
    return tr(raw)
end

local function source_quality(codec)
    codec = type(codec) == "string" and codec:lower() or "unknown"
    if codec == "flac" or codec == "alac" or codec == "ape" then return tr("Lossless compression") end
    if codec == "pcm" then return tr("Uncompressed PCM") end
    if codec == "dsd" then return tr("One-bit DSD audio") end
    if codec == "mp3" or codec == "aac" or codec == "opus" or codec == "vorbis" or codec == "wma" then return tr("Lossy") end
    if codec == "wavpack" or codec == "unknown" or codec == "" then return tr("Unknown (mode not reported)") end
    return tr("Not classified by this inspector")
end

local function safe_call(name, ...)
    local fn = plugin[name]
    if type(fn) ~= "function" then return nil end
    local ok, value = pcall(fn, ...)
    if ok then return value end
    return nil
end

local function safe_call_all(name, ...)
    local fn = plugin[name]
    if type(fn) ~= "function" then return nil end
    local result = table.pack(pcall(fn, ...))
    if not result[1] then return nil end
    local values = { n = result.n - 1 }
    for i = 2, result.n do values[i - 1] = result[i] end
    return values
end

local function first_text(...)
    for i = 1, select("#", ...) do
        local value = select(i, ...)
        if type(value) == "string" and value ~= "" then return value end
    end
    return nil
end

local function yes_no_unknown(value)
    if value == true then return tr("Yes") end
    if value == false then return tr("No") end
    return tr("Unknown")
end

local function playback_position()
    local pos = safe_call("get_position")
    local duration = safe_call("get_duration")
    if not is_valid_number(pos) or pos < 0 then return tr("Unknown") end
    local function clock(sec)
        sec = math.floor(sec)
        if sec >= 3600 then return string.format("%d:%02d:%02d", math.floor(sec / 3600), math.floor(sec / 60) % 60, sec % 60) end
        return string.format("%d:%02d", math.floor(sec / 60), sec % 60)
    end
    if is_valid_number(duration) and duration > 0 then return clock(pos) .. " / " .. clock(duration) end
    return string.format(tr("%s elapsed"), clock(pos))
end

local function playback_state()
    local playing, paused = safe_call("is_playing"), safe_call("is_paused")
    if playing == true then return tr("Playing") end
    if paused == true then return tr("Paused") end
    if playing == false and paused == false then return tr("Stopped") end
    return tr("Unknown")
end

local function file_size(path)
    if type(path) ~= "string" or path == "" or is_remote_url(path) then return nil end
    local f = io.open(path, "rb")
    if not f then return nil end
    local size = f:seek("end")
    f:close()
    if is_valid_number(size) and size >= 0 then return size end
    return nil
end

local function format_file_size(size)
    if not is_valid_number(size) then return tr("Unknown") end
    if size < 1024 then return string.format(tr("%d bytes"), size) end
    if size < 1024 * 1024 then return string.format("%.1f KiB", size / 1024) end
    if size < 1024 * 1024 * 1024 then return string.format("%.2f MiB", size / (1024 * 1024)) end
    return string.format("%.2f GiB", size / (1024 * 1024 * 1024))
end

--------------------------------------------------------------------------------
-- UI Screens and Navigation (In-place replacement via ui.list_update)
--------------------------------------------------------------------------------

local show_format_screen
local show_output_screen
local show_dsp_screen
local show_bitperfect_screen
local show_file_inspector
local show_file_details
local show_settings_screen

-- 1. Format Snapshot Screen
show_format_screen = function(replace_handle)
    local fmt = get_format_snapshot()
    local out = get_output_snapshot()
    local rows = {}

    table.insert(rows, { label = tr("Refresh playback details") })
    table.insert(rows, { label = string.format(tr("Playback: %s · %s"), playback_state(), playback_position()), wrap = true })
    local now = safe_call_all("get_now_playing") or {}
    local now_title, now_artist, now_album, now_duration = now[1], now[2], now[3], now[4]
    local source_path = first_text(fmt and fmt.path, safe_call("get_current_track_path"))
    local source_is_stream = (fmt and fmt.is_stream == true) or is_remote_url(source_path)
    local meta = source_path and settings.show_db_tags and not source_is_stream and get_track_metadata(source_path) or nil
    local title = first_text(meta and meta.title, now_title)
    if title and is_remote_url(title) then title = sanitize_path(title) end
    local artist = first_text(meta and meta.artist, now_artist)
    local album = first_text(meta and meta.album, now_album)
    if title and title ~= "" then table.insert(rows, { label = string.format(tr("Title: %s"), title), wrap = true }) end
    if artist and artist ~= "" then table.insert(rows, { label = string.format(tr("Artist: %s"), artist), wrap = true }) end
    if meta and meta.album_artist and meta.album_artist ~= "" then table.insert(rows, { label = string.format(tr("Album artist: %s"), meta.album_artist), wrap = true }) end
    if album and album ~= "" then table.insert(rows, { label = string.format(tr("Album: %s"), album), wrap = true }) end
    if meta and meta.genre and meta.genre ~= "" then table.insert(rows, { label = string.format(tr("Genre: %s"), meta.genre), wrap = true }) end
    if source_path then
        local src_desc = source_is_stream and tr("Network stream") or tr("Local file")
        table.insert(rows, { label = string.format(tr("Source: %s · %s"), src_desc, safe_display_path(source_path, settings.show_full_path)), wrap = true })
        if not source_is_stream then
            table.insert(rows, { label = string.format(tr("File size: %s"), format_file_size(file_size(source_path))), wrap = true })
            local header = parse_local_file_header(source_path)
            if header then
                table.insert(rows, { label = string.format(tr("File header: %s · %s · %s"), header.format_name, format_hz(header.sample_rate), format_depth(header.bit_depth)), wrap = true })
            end
        end
    end

    if not fmt then
        table.insert(rows, { label = tr("Audio format: Unknown (no active decoder snapshot)"), wrap = true })
        table.insert(rows, { label = tr("Start or resume playback to inspect the decoder's live format."), wrap = true })
    else
        table.insert(rows, { label = string.format(tr("Codec: %s"), codec_name(fmt.codec)), wrap = true })
        table.insert(rows, { label = string.format(tr("Source quality: %s"), source_quality(fmt.codec)), wrap = true })
        table.insert(rows, { label = string.format(tr("Source audio: %s · %s · %s"), format_hz(fmt.sample_rate), format_depth(fmt.bit_depth), format_channels(fmt.channels)), wrap = true })
        table.insert(rows, { label = string.format(tr("Bitrate: %s"), format_bitrate(fmt.bitrate_kbps)), wrap = true })
        local duration = is_valid_number(fmt.duration_seconds) and fmt.duration_seconds > 0 and fmt.duration_seconds or now_duration
        local seek_desc = fmt.seekable == true and tr("seekable") or fmt.seekable == false and tr("forward-only") or tr("seek status unknown")
        table.insert(rows, { label = string.format(tr("Length: %s · %s"), format_duration(duration), seek_desc), wrap = true })
        if fmt.dop then
            table.insert(rows, { label = tr("DSD-over-PCM carrier is active; PCM processing is bypassed"), wrap = true })
        elseif fmt.is_dsd then
            table.insert(rows, { label = tr("DSD playback: converted to PCM"), wrap = true })
        end
        if fmt.is_stream then table.insert(rows, { label = string.format(tr("Stream name or endpoint: %s"), safe_display_path(fmt.path, settings.show_full_path)), wrap = true }) end
        table.insert(rows, { label = string.format(tr("Audio engine output: %s · %s"), format_hz(fmt.output_sample_rate), format_depth(fmt.output_bit_depth)), wrap = true })
    end
    if out then
        local route_names = { wired = "Wired output", bluetooth = "Bluetooth", usb_dac = "USB audio" }
        local route = route_names[out.route] and tr(route_names[out.route]) or tr("Unknown route")
        local act_desc = out.active == true and tr("active") or out.active == false and tr("standby") or tr("status unknown")
        table.insert(rows, { label = string.format(tr("Output route: %s · %s"), route, act_desc), wrap = true })
        if out.route == "bluetooth" then table.insert(rows, { label = string.format(tr("Bluetooth codec: %s"), (out.bluetooth_codec or tr("Not reported"))), wrap = true }) end
        if out.resampling_known then
            local resamp_desc = out.resampling and tr("differs from the engine") or tr("matches the engine")
            table.insert(rows, { label = string.format(tr("Player output rate: %s · %s"), format_hz(out.sample_rate), resamp_desc), wrap = true })
        else
            table.insert(rows, { label = tr("Final device format: Not available from the player"), wrap = true })
        end
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list(tr("Playback details"), rows, function(idx)
        if idx == 1 then show_format_screen(current_handle) end
    end, opts)
    return current_handle
end

-- 2. Output & Signal Path Screen
show_output_screen = function(replace_handle)
    local out = get_output_snapshot()
    local fmt = get_format_snapshot()
    local rows = {}

    table.insert(rows, { label = tr("Refresh output details") })

    if not out then
        table.insert(rows, { label = tr("Output details unavailable") })
        table.insert(rows, { label = tr("This firmware does not expose a live output snapshot."), wrap = true })
        local current_handle
        local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
        current_handle = plugin.show_list(tr("Output details"), rows, function(idx)
            if idx == 1 then show_output_screen(current_handle) end
        end, opts)
        return current_handle
    end

    local route_names = { wired = "Wired output", bluetooth = "Bluetooth", usb_dac = "USB audio" }
    table.insert(rows, { label = string.format(tr("Route: %s"), (route_names[out.route] and tr(route_names[out.route]) or tr("Unknown"))) })
    table.insert(rows, { label = string.format(tr("Output active: %s"), yes_no_unknown(out.active)) })

    if out.route == "bluetooth" then
        local bt_codec = out.bluetooth_codec or tr("Not reported")
        table.insert(rows, { label = string.format(tr("Bluetooth codec: %s"), bt_codec), wrap = true })
        table.insert(rows, { label = tr("The remote device's final output format is not visible here."), wrap = true })
    elseif out.route == "usb_dac" then
        table.insert(rows, { label = tr("USB audio output is selected") })
        table.insert(rows, { label = tr("The external device's final conversion and output format are not visible here."), wrap = true })
    elseif out.route == "wired" then
        table.insert(rows, { label = tr("Wired output is selected") })
    end

    if fmt then
        table.insert(rows, { label = string.format(tr("Audio engine format: %s · %s"), format_hz(fmt.output_sample_rate), format_depth(fmt.output_bit_depth)), wrap = true })
    else
        table.insert(rows, { label = tr("Audio engine format: Unknown") })
    end
    if out.active == true then
        table.insert(rows, { label = string.format(tr("Active output format: %s · %s"), format_hz(out.sample_rate), format_depth(out.bit_depth)), wrap = true })
    else
        table.insert(rows, { label = tr("Active output format: Not available while output is inactive"), wrap = true })
    end

    local hw_known = (is_valid_number(out.hardware_sample_rate) and out.hardware_sample_rate > 0
        and is_valid_number(out.hardware_bit_depth) and out.hardware_bit_depth > 0)
    if hw_known then
        table.insert(rows, { label = string.format(tr("Local output format: %s · %s"), format_hz(out.hardware_sample_rate), format_depth(out.hardware_bit_depth)), wrap = true })
        table.insert(rows, { label = string.format(tr("Output rate matches engine: %s"), (out.resampling_known and (out.resampling and tr("No") or tr("Yes")) or tr("Unknown"))), wrap = true })
    else
        table.insert(rows, { label = tr("Final device format: Not reported by the player"), wrap = true })
        table.insert(rows, { label = string.format(tr("Output rate matches engine: %s"), (out.resampling_known and (out.resampling and tr("No") or tr("Yes")) or tr("Unknown"))), wrap = true })
    end

    table.insert(rows, { label = string.format(tr("DSD-over-PCM carrier: %s"), yes_no_unknown(out.dop)) })

    if fmt and is_valid_number(fmt.sample_rate) and fmt.sample_rate > 0
        and is_valid_number(fmt.output_sample_rate) and fmt.output_sample_rate > 0 then
        if fmt.dop then
            local expected = fmt.sample_rate / 16
            table.insert(rows, { label = string.format(tr("DSD carrier rate: %s · expected %s"), format_hz(fmt.output_sample_rate), format_hz(expected)), wrap = true })
        elseif fmt.is_dsd then
            table.insert(rows, { label = string.format(tr("DSD converted to PCM at %s"), format_hz(fmt.output_sample_rate)), wrap = true })
        elseif fmt.sample_rate == fmt.output_sample_rate then
            table.insert(rows, { label = string.format(tr("Source and audio engine rates match: %s"), format_hz(fmt.sample_rate)), wrap = true })
        else
            table.insert(rows, { label = string.format(tr("Audio engine resampling: %s source to %s"), format_hz(fmt.sample_rate), format_hz(fmt.output_sample_rate)), wrap = true })
        end
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list(tr("Output details"), rows, function(idx)
        if idx == 1 then show_output_screen(current_handle) end
    end, opts)
    return current_handle
end

-- 3. DSP & Equalizer State Screen
show_dsp_screen = function(replace_handle)
    local eq = get_live_eq()
    local fmt = get_format_snapshot()
    local mseb, mseb_supported = get_mseb_snapshot()
    local rows = {}

    table.insert(rows, { label = tr("Refresh sound details") })

    if mseb_supported then
        local status = mseb and (mseb.enabled and tr("Enabled") or tr("Disabled")) or tr("State unknown")
        table.insert(rows, { label = string.format(tr("Stock MSEB: %s"), status) })
        if mseb and mseb.enabled then
            table.insert(rows, { label = fmt and fmt.dop == true
                and tr("Native DoP bypasses stock MSEB during playback.")
                or tr("Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent."), wrap = true })
        end
    end

    if not eq then
        table.insert(rows, { label = tr("Equalizer details unavailable") })
        table.insert(rows, { label = tr("This firmware does not expose a live equalizer snapshot."), wrap = true })
        local current_handle
        local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
        current_handle = plugin.show_list(tr("Sound processing"), rows, function(idx)
            if idx == 1 then show_dsp_screen(current_handle) end
        end, opts)
        return current_handle
    end

    local bypass = eq.bypass
    table.insert(rows, { label = string.format(tr("Equalizer: %s"), (bypass == true and tr("Bypassed") or bypass == false and tr("Enabled") or tr("State unknown"))) })
    if bypass == true then
        table.insert(rows, { label = crossfeed_runs_when_bypassed()
            and tr("Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent.")
            or tr("Equalizer bypass also skips preamp, stereo width, crossfeed, and filters."), wrap = true })
    end
    if fmt and fmt.dop then
        table.insert(rows, { label = tr("DSD-over-PCM playback bypasses the equalizer and other PCM processing."), wrap = true })
    elseif fmt and fmt.is_dsd then
        table.insert(rows, { label = tr("DSD is converted to PCM; the sound settings below can affect playback."), wrap = true })
    end

    local mseb_override = mseb and mseb.enabled == true and not (fmt and fmt.dop == true)
    local preamp_suffix = bypass == true and tr(" · bypassed") or mseb_override and tr(" · stored; overridden by MSEB") or ""
    local preamp_val = is_valid_number(eq.preamp_db) and string.format("%+.2f dB", eq.preamp_db) or tr("Unknown")
    table.insert(rows, { label = string.format(tr("Preamp gain: %s%s"), preamp_val, preamp_suffix), wrap = true })
    local width = eq.stereo_width
    local width_desc = not is_valid_number(width) and tr("Unknown") or (width == 1.0 and tr("Neutral") or width == 0 and tr("Mono") or tr("Wider or narrower stereo"))
    local width_suffix = mseb_override and tr(" · stored; overridden by MSEB") or ""
    local width_val = is_valid_number(width) and string.format("%.3f · %s", width, width_desc) or width_desc
    table.insert(rows, { label = string.format(tr("Stereo width: %s%s"), width_val, width_suffix), wrap = true })
    local crossfeed = eq.crossfeed
    local angle = safe_call("eq_get_crossfeed_angle")
    if not is_valid_number(angle) then angle = eq.crossfeed_angle end
    local crossfeed_suffix = bypass == true and not crossfeed_runs_when_bypassed() and tr(" · bypassed") or ""
    local crossfeed_val = is_valid_number(crossfeed) and string.format(tr("%d%% strength"), math.floor(crossfeed * 100 + 0.5)) or tr("Unknown")
    table.insert(rows, { label = string.format(tr("Headphone crossfeed: %s%s"), crossfeed_val, crossfeed_suffix), wrap = true })
    if is_valid_number(angle) then
        table.insert(rows, { label = angle == 0 and tr("Crossfeed delay: none") or string.format(tr("Crossfeed angle: %.1f°"), angle), wrap = true })
    end

    if fmt then
        local soft_gain = fmt.software_volume_gain
        local soft_desc = is_valid_number(soft_gain) and (soft_gain == 1.0 and tr("unity (0 dB)") or format_gain_db(soft_gain)) or tr("Unknown")
        local soft_val = is_valid_number(soft_gain) and string.format("%.4fx · %s", soft_gain, soft_desc) or soft_desc
        table.insert(rows, { label = string.format(tr("Software audio gain: %s"), soft_val), wrap = true })
        local volume = safe_call("get_volume")
        local vol_val = is_valid_number(volume) and string.format("%d%%", math.floor(volume + 0.5)) or tr("Unknown")
        table.insert(rows, { label = string.format(tr("Player volume: %s · separate from software audio gain"), vol_val), wrap = true })

        local speed = fmt.playback_speed
        local speed_suffix = speed ~= 1.0 and tr(" · time stretch active") or tr(" · normal")
        local speed_val = is_valid_number(speed) and string.format("%.3fx%s", speed, speed_suffix) or tr("Unknown")
        table.insert(rows, { label = string.format(tr("Playback speed: %s"), speed_val), wrap = true })

        local rg_mode = safe_call("get_replaygain_mode")
        local replaygain_names = { off = "Off", track = "Per track", album = "Per album" }
        local rg_mode_str = replaygain_names[rg_mode] and tr(replaygain_names[rg_mode]) or tr("Unknown")
        table.insert(rows, { label = string.format(tr("ReplayGain (loudness matching): %s · current track applied: %s"), rg_mode_str, yes_no_unknown(fmt.replaygain_applied)), wrap = true })
        if rg_mode then table.insert(rows, { label = tr("Changes to this setting take effect with the next track."), wrap = true }) end
        if fmt.replaygain_applied == true then
            local rg_val = is_valid_number(fmt.replaygain_applied_db) and string.format("%+.2f dB", fmt.replaygain_applied_db) or tr("amount unknown")
            table.insert(rows, { label = string.format(tr("Applied ReplayGain: %s"), rg_val), wrap = true })
        end

        table.insert(rows, { label = string.format(tr("Crossfade setting: %s · current mixing state is not exposed"), yes_no_unknown(fmt.crossfade_enabled)), wrap = true })
        local gapless = safe_call("get_gapless")
        table.insert(rows, { label = string.format(tr("Gapless playback: %s"), yes_no_unknown(gapless)), wrap = true })
        local play_mode = safe_call("get_play_mode")
        local mode_names = { sequential = "In order", repeat_all = "Repeat all", repeat_one = "Repeat one", shuffle = "Shuffle" }
        local play_mode_str = mode_names[play_mode] and tr(mode_names[play_mode]) or tr("Unknown")
        table.insert(rows, { label = string.format(tr("Play mode: %s"), play_mode_str) })
    end

    local active_count = 0
    local band_states_known = type(eq.bands) == "table" and #eq.bands == 10
    if type(eq.bands) == "table" then
        for _, b in ipairs(eq.bands) do
            if type(b.enabled) ~= "boolean" then band_states_known = false end
            if b.enabled == true then
                active_count = active_count + 1
            end
        end
    end
    local band_label = band_states_known and string.format(tr("Enabled equalizer bands: %d / 10"), active_count) or tr("Enabled equalizer bands: Not fully reported")
    local mseb_band_suffix = mseb_override and tr(" · stored; overridden by MSEB") or ""
    table.insert(rows, { label = band_label .. mseb_band_suffix })
    table.insert(rows, { label = tr("View all equalizer bands") })

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list(tr("Sound processing"), rows, function(idx)
        if idx == 1 then
            show_dsp_screen(current_handle)
        elseif idx == #rows then
            local band_rows = {}
            if eq.bands then
                for i, b in ipairs(eq.bands) do
                    local filter_names = { peaking = "Peaking", low_shelf = "Low shelf", high_shelf = "High shelf" }
                    local filter = filter_names[b.type] and tr(filter_names[b.type]) or (b.type or tr("Unknown filter"))
                    local gain = is_valid_number(b.gain_db) and string.format("%+.2f dB", b.gain_db) or tr("gain unknown")
                    local state = b.enabled == true and tr("Enabled") or b.enabled == false and tr("Disabled") or tr("State unknown")
                    table.insert(band_rows, { label = string.format(tr("Band %d · %s · %s Hz · %s · Q %s · %s"), b.index or i, filter, is_valid_number(b.freq_hz) and tostring(math.floor(b.freq_hz)) or "?", gain, is_valid_number(b.q) and string.format("%.2f", b.q) or "?", state), wrap = true })
                end
            end
            plugin.show_list(tr("Equalizer bands"), band_rows, function(b_idx) end)
        end
    end, opts)
    return current_handle
end

-- 4. Bit-Perfect Assessment Screen
show_bitperfect_screen = function(replace_handle)
    local fmt = get_format_snapshot()
    local out = get_output_snapshot()
    local eq = get_live_eq()
    local mseb, mseb_supported = get_mseb_snapshot()
    local assess = assess_bit_perfect(fmt, out, eq, mseb, mseb_supported)

    local rows = {}
    table.insert(rows, { label = tr("Refresh signal path check") })
    table.insert(rows, { label = string.format(tr("Result: %s"), assess.status), wrap = true })

    if assess.is_candidate then
        table.insert(rows, { label = tr("No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output."), wrap = true })
    else
        table.insert(rows, { label = tr("The snapshot shows a change or lacks enough information to verify an unchanged signal path."), wrap = true })
    end

    -- Lists have no section-header row, so each finding names its group in
    -- the row's native muted secondary line ("text\nsecondary" on wrapped rows).
    for _, r in ipairs(assess.reasons) do
        table.insert(rows, { label = r .. "\n" .. tr("Change or unknown detail"), wrap = true })
    end

    for _, n in ipairs(assess.notes) do
        table.insert(rows, { label = n .. "\n" .. tr("Other observation"), wrap = true })
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list(tr("Signal check"), rows, function(idx)
        if idx == 1 then show_bitperfect_screen(current_handle) end
    end, opts)
    return current_handle
end

-- 5. Local File Header Inspector Screen
show_file_details = function(file_path)
    local header, err = parse_local_file_header(file_path)
    local detail_rows = {}
    local clean_name = safe_display_path(file_path, false)
    table.insert(detail_rows, { label = string.format(tr("File: %s"), clean_name), wrap = true })

    if header then
        table.insert(detail_rows, { label = string.format(tr("Format: %s"), header.format_name), wrap = true })
        table.insert(detail_rows, { label = string.format(tr("Sample Rate: %s"), format_hz(header.sample_rate)), wrap = true })
        table.insert(detail_rows, { label = string.format(tr("Bit Depth: %s"), format_depth(header.bit_depth)), wrap = true })
        table.insert(detail_rows, { label = string.format(tr("Channels: %s"), format_channels(header.channels)), wrap = true })
        table.insert(detail_rows, { label = string.format(tr("Duration: %s"), format_duration(header.duration_seconds)), wrap = true })
        if header.is_compressed then
            table.insert(detail_rows, { label = string.format(tr("Estimated Container Bitrate: %s (includes container/metadata overhead)"), format_bitrate(header.bitrate_kbps)), wrap = true })
            table.insert(detail_rows, { label = header.codec == "flac" and tr("Encoding: Lossless compressed audio") or tr("Encoding: Compressed audio · losslessness not confirmed by this header"), wrap = true })
        else
            table.insert(detail_rows, { label = string.format(tr("Bitrate: %s"), format_bitrate(header.bitrate_kbps)), wrap = true })
            table.insert(detail_rows, { label = tr("Type: Uncompressed PCM"), wrap = true })
        end
    else
        table.insert(detail_rows, { label = tr("Header Parsing Status: Unsupported / Malformed"), wrap = true })
        table.insert(detail_rows, { label = string.format(tr("Detail: %s"), (err or tr("Unknown format"))), wrap = true })
        table.insert(detail_rows, { label = tr("Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension."), wrap = true })
    end

    plugin.show_list(tr("Local file details"), detail_rows, function(d_idx) end)
end

show_file_inspector = function()
    if not plugin.has_capability("ui.file_picker") or type(plugin.pick_file) ~= "function" then
        plugin.show_toast(tr("File picker unavailable. Update firmware to inspect a local file."))
        return
    end

    local ok, result, err = pcall(plugin.pick_file, nil, function(path)
        if path ~= nil then
            show_file_details(path)
        end
    end)
    if not ok then
        plugin.show_toast(tr("Could not open file picker. Please try again."))
    elseif result ~= true then
        if err == "busy" then
            plugin.show_toast(tr("Please close the other file picker and try again."))
        else
            local reason = tostring(err or "unknown error")
            if #reason > 120 then reason = reason:sub(1, 117) .. "..." end
            plugin.show_toast(string.format(tr("Could not open file picker: %s"), reason))
        end
    end
end

-- 6. Settings Screen
show_settings_screen = function()
    local items = {
        {
            type = "toggle",
            label = tr("Show full file paths"),
            value = settings.show_full_path,
            on_change = function(val)
                settings.show_full_path = val
                save_setting("show_full_path", val and "1" or "0")
            end,
        },
        {
            type = "toggle",
            label = tr("Show music library tags"),
            value = settings.show_db_tags,
            on_change = function(val)
                settings.show_db_tags = val
                save_setting("show_db_tags", val and "1" or "0")
            end,
        },
    }
    plugin.show_settings_list(tr("Inspector settings"), items)
end

-- Main Menu Navigation
local function show_main_menu()
    local fmt = get_format_snapshot()
    local short_codec = fmt and codec_name(fmt.codec):gsub("%s*%b()", "")
    local status_line = fmt and string.format("%s · %s · %s · %s", playback_state(), short_codec, format_depth(fmt.bit_depth), format_hz(fmt.sample_rate)) or string.format(tr("%s · format unavailable"), playback_state())

    local rows = {
        { label = status_line, wrap = true },
        { label = tr("Track and file details"), wrap = true },
        { label = tr("Output device"), wrap = true },
        { label = tr("Sound processing"), wrap = true },
        { label = tr("Signal check"), wrap = true },
        { label = tr("Inspect a file"), wrap = true },
        { label = tr("Settings"), wrap = true },
    }

    plugin.show_list(tr("Track Inspector"), rows, function(index)
        index = index - 1 -- the first row is the playback overview
        if index == 1 then
            show_format_screen()
        elseif index == 2 then
            show_output_screen()
        elseif index == 3 then
            show_dsp_screen()
        elseif index == 4 then
            show_bitperfect_screen()
        elseif index == 5 then
            show_file_inspector()
        elseif index == 6 then
            show_settings_screen()
        end
    end)
end

--------------------------------------------------------------------------------
-- Registration and Event Handlers
--------------------------------------------------------------------------------

-- Older firmware keeps the Playback entry until it supports player menu rows.
local entry_location = plugin.has_capability("ui.player_menu") and "player" or "playback"
plugin.register_list_item(entry_location, tr("Track Inspector"), function()
    show_main_menu()
end)

--------------------------------------------------------------------------------
-- Test Exposure for Unit & Regression Tests
--------------------------------------------------------------------------------

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        parse_local_file_header = parse_local_file_header,
        assess_bit_perfect = assess_bit_perfect,
        get_mseb_snapshot = get_mseb_snapshot,
        mseb_has_effect = mseb_has_effect,
        decode_ieee_extended = decode_ieee_extended,
        format_hz = format_hz,
        format_depth = format_depth,
        format_channels = format_channels,
        format_bitrate = format_bitrate,
        format_duration = format_duration,
        format_gain_db = format_gain_db,
        is_remote_url = is_remote_url,
        sanitize_path = sanitize_path,
        safe_display_path = safe_display_path,
        is_within_sd = is_within_sd,
        is_valid_number = is_valid_number,
        show_main_menu = show_main_menu,
        show_format_screen = show_format_screen,
        show_output_screen = show_output_screen,
        show_dsp_screen = show_dsp_screen,
        show_bitperfect_screen = show_bitperfect_screen,
        show_file_inspector = show_file_inspector,
        show_file_details = show_file_details,
        show_settings_screen = show_settings_screen,
        settings = settings,
    }
end
