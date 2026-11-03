plugin.define({
    id = "org.compas.autoeq_context",
    name = "AutoEQ Context",
    version = "1.2.0",
    api_min = 19,
})

local T = {
    de = {
        ["AutoEQ Context"] = "AutoEQ-Kontext",
        ["Failed to encode configuration"] = "Konfiguration konnte nicht kodiert werden",
        ["Failed to save settings to storage; changes are live for this session only"] = "Speichern fehlgeschlagen; Änderungen gelten nur für diese Sitzung",
        ["Storage unavailable; changes are live for this session only"] = "Speicher nicht verfügbar; Änderungen gelten nur für diese Sitzung",
        ["Manual or external EQ change detected"] = "Manuelle oder externe EQ-Änderung erkannt",
        ["External change"] = "Externe Änderung",
        ["(None / Clear)"] = "(Keine / Zurücksetzen)",
        ["Add folder rule"] = "Ordnerregel hinzufügen",
        ["Folder Path"] = "Ordnerpfad",
        ["Select Profile for Folder"] = "Profil für Ordner wählen",
        ["Rule: %s"] = "Regel: %s",
        ["Change Profile"] = "Profil ändern",
        ["Delete Rule"] = "Regel löschen",
        ["New Profile"] = "Neues Profil",
        ["Folder Rules"] = "Ordnerregeln",
        ["Add artist rule"] = "Künstlerregel hinzufügen",
        ["Artist Name"] = "Künstlername",
        ["Select Profile for Artist"] = "Profil für Künstler wählen",
        ["Artist: %s"] = "Künstler: %s",
        ["Artist Rules"] = "Künstlerregeln",
        ["Add genre rule"] = "Genreregel hinzufügen",
        ["Genre Name"] = "Genrename",
        ["Select Profile for Genre"] = "Profil für Genre wählen",
        ["Genre: %s"] = "Genre: %s",
        ["Genre Rules"] = "Genreregeln",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Vorrang der AutoEQ-Kontextregeln:\n\n1. Ordner (längstes passendes Pfadpräfix)\n2. Künstler (exakte Übereinstimmung aus Metadaten)\n3. Genre (exakte Übereinstimmung aus get_track_metadata)\n4. Standardprofil (Fallback)\n\nProfile werden temporär angewendet (persist = false).\nBei Titeln ohne Regel wird die Ausgangs-EQ wiederhergestellt.\nBei externer EQ-Änderung pausiert die Automatik bis zur erneuten Aktivierung.",
        ["Priority & Precedence"] = "Priorität & Vorrang",
        ["Precedence: Folder > Artist > Genre > Default"] = "Vorrang: Ordner > Künstler > Genre > Standard",
        ["Disabled"] = "Deaktiviert",
        ["Suspended (%s)"] = "Pausiert (%s)",
        ["Active: %s"] = "Aktiv: %s",
        ["Active"] = "Aktiv",
        ["Enabled"] = "Aktiviert",
        ["Status: %s"] = "Status: %s",
        ["AutoEQ Context reclaimed"] = "AutoEQ-Kontext wiederhergestellt",
        ["Folder Rules (%d)"] = "Ordnerregeln (%d)",
        ["Artist Rules (%d)"] = "Künstlerregeln (%d)",
        ["Genre Rules (%d)"] = "Genreregeln (%d)",
        ["None"] = "Keines",
        ["Default Profile: %s"] = "Standardprofil: %s",
        ["Select Default Profile"] = "Standardprofil wählen",
        ["Priority & Precedence Info"] = "Info zu Priorität & Vorrang",
    },
    es = {
        ["AutoEQ Context"] = "AutoEQ por contexto",
        ["Failed to encode configuration"] = "No se pudo codificar la configuración",
        ["Failed to save settings to storage; changes are live for this session only"] = "No se pudieron guardar los ajustes; los cambios solo valen en esta sesión",
        ["Storage unavailable; changes are live for this session only"] = "Almacenamiento no disponible; los cambios solo valen en esta sesión",
        ["Manual or external EQ change detected"] = "Cambio de EQ manual o externo detectado",
        ["External change"] = "Cambio externo",
        ["(None / Clear)"] = "(Ninguno / Limpiar)",
        ["Add folder rule"] = "Añadir regla de carpeta",
        ["Folder Path"] = "Ruta de carpeta",
        ["Select Profile for Folder"] = "Elegir perfil para carpeta",
        ["Rule: %s"] = "Regla: %s",
        ["Change Profile"] = "Cambiar perfil",
        ["Delete Rule"] = "Eliminar regla",
        ["New Profile"] = "Nuevo perfil",
        ["Folder Rules"] = "Reglas de carpeta",
        ["Add artist rule"] = "Añadir regla de artista",
        ["Artist Name"] = "Nombre del artista",
        ["Select Profile for Artist"] = "Elegir perfil para artista",
        ["Artist: %s"] = "Artista: %s",
        ["Artist Rules"] = "Reglas de artista",
        ["Add genre rule"] = "Añadir regla de género",
        ["Genre Name"] = "Nombre del género",
        ["Select Profile for Genre"] = "Elegir perfil para género",
        ["Genre: %s"] = "Género: %s",
        ["Genre Rules"] = "Reglas de género",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Prioridad de reglas de AutoEQ por contexto:\n\n1. Carpeta (prefijo de ruta más largo)\n2. Artista (coincidencia exacta de metadatos)\n3. Género (coincidencia exacta de get_track_metadata)\n4. Perfil predeterminado (reserva)\n\nLos perfiles se aplican de forma temporal (persist = false).\nSi suena una pista sin regla o sin etiquetas, se restaura el EQ base.\nSi el EQ se modifica externamente, la automatización se suspende hasta reactivarla.",
        ["Priority & Precedence"] = "Prioridad y precedencia",
        ["Precedence: Folder > Artist > Genre > Default"] = "Prioridad: Carpeta > Artista > Género > Predeterminado",
        ["Disabled"] = "Desactivado",
        ["Suspended (%s)"] = "Suspendido (%s)",
        ["Active: %s"] = "Activo: %s",
        ["Active"] = "Activo",
        ["Enabled"] = "Activado",
        ["Status: %s"] = "Estado: %s",
        ["AutoEQ Context reclaimed"] = "Control de AutoEQ por contexto recuperado",
        ["Folder Rules (%d)"] = "Reglas de carpeta (%d)",
        ["Artist Rules (%d)"] = "Reglas de artista (%d)",
        ["Genre Rules (%d)"] = "Reglas de género (%d)",
        ["None"] = "Ninguno",
        ["Default Profile: %s"] = "Perfil predeterminado: %s",
        ["Select Default Profile"] = "Elegir perfil predeterminado",
        ["Priority & Precedence Info"] = "Info de prioridad y precedencia",
    },
    fi = {
        ["AutoEQ Context"] = "AutoEQ-konteksti",
        ["Failed to encode configuration"] = "Asetusten koodaus epäonnistui",
        ["Failed to save settings to storage; changes are live for this session only"] = "Tallennus epäonnistui; muutokset ovat voimassa vain tämän istunnon ajan",
        ["Storage unavailable; changes are live for this session only"] = "Tallennustila ei käytettävissä; muutokset ovat voimassa vain tämän istunnon ajan",
        ["Manual or external EQ change detected"] = "Manuaalinen tai ulkoinen EQ-muutos havaittu",
        ["External change"] = "Ulkoinen muutos",
        ["(None / Clear)"] = "(Ei mitään / Tyhjennä)",
        ["Add folder rule"] = "Lisää kansiosääntö",
        ["Folder Path"] = "Kansion polku",
        ["Select Profile for Folder"] = "Valitse profiili kansiolle",
        ["Rule: %s"] = "Sääntö: %s",
        ["Change Profile"] = "Vaihda profiilia",
        ["Delete Rule"] = "Poista sääntö",
        ["New Profile"] = "Uusi profiili",
        ["Folder Rules"] = "Kansiosäännöt",
        ["Add artist rule"] = "Lisää artistisääntö",
        ["Artist Name"] = "Artistin nimi",
        ["Select Profile for Artist"] = "Valitse profiili artistille",
        ["Artist: %s"] = "Artisti: %s",
        ["Artist Rules"] = "Artistisäännöt",
        ["Add genre rule"] = "Lisää tyylilajisääntö",
        ["Genre Name"] = "Tyylilajin nimi",
        ["Select Profile for Genre"] = "Valitse profiili tyylilajille",
        ["Genre: %s"] = "Tyylilaji: %s",
        ["Genre Rules"] = "Tyylilajisäännöt",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "AutoEQ-kontekstisääntöjen etusija:\n\n1. Kansio (pisin täsmäävä polun alkuosa)\n2. Artisti (tarkka osuma metatiedoista)\n3. Tyylilaji (tarkka osuma get_track_metadata-tiedoista)\n4. Oletusprofiili (varavaihtoehto)\n\nProfiilit otetaan käyttöön väliaikaisesti (persist = false).\nJos kappaleelle ei ole sääntöä, perustilan EQ palautetaan.\nJos EQ:ta muutetaan ulkoisesti, automatiikka keskeytyy kunnes se otetaan taas käyttöön.",
        ["Priority & Precedence"] = "Tärkeysjärjestys",
        ["Precedence: Folder > Artist > Genre > Default"] = "Järjestys: Kansio > Artisti > Tyylilaji > Oletus",
        ["Disabled"] = "Pois käytöstä",
        ["Suspended (%s)"] = "Keskeytetty (%s)",
        ["Active: %s"] = "Aktiivinen: %s",
        ["Active"] = "Aktiivinen",
        ["Enabled"] = "Käytössä",
        ["Status: %s"] = "Tila: %s",
        ["AutoEQ Context reclaimed"] = "AutoEQ-konteksti palautettu hallintaan",
        ["Folder Rules (%d)"] = "Kansiosäännöt (%d)",
        ["Artist Rules (%d)"] = "Artistisäännöt (%d)",
        ["Genre Rules (%d)"] = "Tyylilajisäännöt (%d)",
        ["None"] = "Ei mitään",
        ["Default Profile: %s"] = "Oletusprofiili: %s",
        ["Select Default Profile"] = "Valitse oletusprofiili",
        ["Priority & Precedence Info"] = "Tietoa tärkeysjärjestyksestä",
    },
    fr = {
        ["AutoEQ Context"] = "AutoEQ contextuel",
        ["Failed to encode configuration"] = "Échec d'encodage de la configuration",
        ["Failed to save settings to storage; changes are live for this session only"] = "Échec d'enregistrement ; modifications actives pour cette session uniquement",
        ["Storage unavailable; changes are live for this session only"] = "Stockage indisponible ; modifications actives pour cette session uniquement",
        ["Manual or external EQ change detected"] = "Modification manuelle ou externe de l'EQ détectée",
        ["External change"] = "Modification externe",
        ["(None / Clear)"] = "(Aucun / Effacer)",
        ["Add folder rule"] = "Ajouter une règle de dossier",
        ["Folder Path"] = "Chemin du dossier",
        ["Select Profile for Folder"] = "Choisir le profil du dossier",
        ["Rule: %s"] = "Règle : %s",
        ["Change Profile"] = "Changer de profil",
        ["Delete Rule"] = "Supprimer la règle",
        ["New Profile"] = "Nouveau profil",
        ["Folder Rules"] = "Règles de dossier",
        ["Add artist rule"] = "Ajouter une règle d'artiste",
        ["Artist Name"] = "Nom de l'artiste",
        ["Select Profile for Artist"] = "Choisir le profil de l'artiste",
        ["Artist: %s"] = "Artiste : %s",
        ["Artist Rules"] = "Règles d'artiste",
        ["Add genre rule"] = "Ajouter une règle de genre",
        ["Genre Name"] = "Nom du genre",
        ["Select Profile for Genre"] = "Choisir le profil du genre",
        ["Genre: %s"] = "Genre : %s",
        ["Genre Rules"] = "Règles de genre",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Priorité des règles AutoEQ contextuel :\n\n1. Dossier (préfixe de chemin le plus long)\n2. Artiste (correspondance exacte des métadonnées)\n3. Genre (correspondance exacte via get_track_metadata)\n4. Profil par défaut (secours)\n\nLes profils sont appliqués temporairement (persist = false).\nSi un titre sans règle est lu, l'EQ de base est restauré.\nSi l'EQ est modifié en externe, l'automatisation est suspendue jusqu'à sa réactivation.",
        ["Priority & Precedence"] = "Priorité et préséance",
        ["Precedence: Folder > Artist > Genre > Default"] = "Priorité : Dossier > Artiste > Genre > Défaut",
        ["Disabled"] = "Désactivé",
        ["Suspended (%s)"] = "Suspendu (%s)",
        ["Active: %s"] = "Actif : %s",
        ["Active"] = "Actif",
        ["Enabled"] = "Activé",
        ["Status: %s"] = "État : %s",
        ["AutoEQ Context reclaimed"] = "Contrôle AutoEQ contextuel repris",
        ["Folder Rules (%d)"] = "Règles de dossier (%d)",
        ["Artist Rules (%d)"] = "Règles d'artiste (%d)",
        ["Genre Rules (%d)"] = "Règles de genre (%d)",
        ["None"] = "Aucun",
        ["Default Profile: %s"] = "Profil par défaut : %s",
        ["Select Default Profile"] = "Choisir le profil par défaut",
        ["Priority & Precedence Info"] = "Infos de priorité et préséance",
    },
    it = {
        ["AutoEQ Context"] = "AutoEQ contestuale",
        ["Failed to encode configuration"] = "Impossibile codificare la configurazione",
        ["Failed to save settings to storage; changes are live for this session only"] = "Salvataggio non riuscito; modifiche valide solo per questa sessione",
        ["Storage unavailable; changes are live for this session only"] = "Archiviazione non disponibile; modifiche valide solo per questa sessione",
        ["Manual or external EQ change detected"] = "Rilevata modifica EQ manuale o esterna",
        ["External change"] = "Modifica esterna",
        ["(None / Clear)"] = "(Nessuno / Cancella)",
        ["Add folder rule"] = "Aggiungi regola cartella",
        ["Folder Path"] = "Percorso cartella",
        ["Select Profile for Folder"] = "Seleziona profilo per cartella",
        ["Rule: %s"] = "Regola: %s",
        ["Change Profile"] = "Cambia profilo",
        ["Delete Rule"] = "Elimina regola",
        ["New Profile"] = "Nuovo profilo",
        ["Folder Rules"] = "Regole cartella",
        ["Add artist rule"] = "Aggiungi regola artista",
        ["Artist Name"] = "Nome artista",
        ["Select Profile for Artist"] = "Seleziona profilo per artista",
        ["Artist: %s"] = "Artista: %s",
        ["Artist Rules"] = "Regole artista",
        ["Add genre rule"] = "Aggiungi regola genere",
        ["Genre Name"] = "Nome genere",
        ["Select Profile for Genre"] = "Seleziona profilo per genere",
        ["Genre: %s"] = "Genere: %s",
        ["Genre Rules"] = "Regole genere",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Precedenza regole AutoEQ contestuale:\n\n1. Cartella (prefisso di percorso più lungo)\n2. Artista (corrispondenza esatta dai metadati)\n3. Genere (corrispondenza esatta da get_track_metadata)\n4. Profilo predefinito (riserva)\n\nI profili sono applicati in modo transitorio (persist = false).\nSe viene riprodotto un brano senza regole, viene ripristinato l'EQ di base.\nSe l'EQ viene modificato esternamente, l'automazione si sospende fino alla riattivazione.",
        ["Priority & Precedence"] = "Priorità e precedenza",
        ["Precedence: Folder > Artist > Genre > Default"] = "Precedenza: Cartella > Artista > Genere > Predefinito",
        ["Disabled"] = "Disattivato",
        ["Suspended (%s)"] = "Sospeso (%s)",
        ["Active: %s"] = "Attivo: %s",
        ["Active"] = "Attivo",
        ["Enabled"] = "Attivato",
        ["Status: %s"] = "Stato: %s",
        ["AutoEQ Context reclaimed"] = "Controllo AutoEQ contestuale ripristinato",
        ["Folder Rules (%d)"] = "Regole cartella (%d)",
        ["Artist Rules (%d)"] = "Regole artista (%d)",
        ["Genre Rules (%d)"] = "Regole genere (%d)",
        ["None"] = "Nessuno",
        ["Default Profile: %s"] = "Profilo predefinito: %s",
        ["Select Default Profile"] = "Seleziona profilo predefinito",
        ["Priority & Precedence Info"] = "Info priorità e precedenza",
    },
    ja = {
        ["AutoEQ Context"] = "AutoEQ コンテキスト",
        ["Failed to encode configuration"] = "設定のエンコードに失敗しました",
        ["Failed to save settings to storage; changes are live for this session only"] = "設定を保存できませんでした。変更はこのセッションのみ有効です",
        ["Storage unavailable; changes are live for this session only"] = "ストレージを利用できません。変更はこのセッションのみ有効です",
        ["Manual or external EQ change detected"] = "手動または外部による EQ 変更を検出しました",
        ["External change"] = "外部変更",
        ["(None / Clear)"] = "(なし / クリア)",
        ["Add folder rule"] = "フォルダー規則を追加",
        ["Folder Path"] = "フォルダーパス",
        ["Select Profile for Folder"] = "フォルダー用プロファイルを選択",
        ["Rule: %s"] = "規則: %s",
        ["Change Profile"] = "プロファイルを変更",
        ["Delete Rule"] = "規則を削除",
        ["New Profile"] = "新しいプロファイル",
        ["Folder Rules"] = "フォルダー規則",
        ["Add artist rule"] = "アーティスト規則を追加",
        ["Artist Name"] = "アーティスト名",
        ["Select Profile for Artist"] = "アーティスト用プロファイルを選択",
        ["Artist: %s"] = "アーティスト: %s",
        ["Artist Rules"] = "アーティスト規則",
        ["Add genre rule"] = "ジャンル規則を追加",
        ["Genre Name"] = "ジャンル名",
        ["Select Profile for Genre"] = "ジャンル用プロファイルを選択",
        ["Genre: %s"] = "ジャンル: %s",
        ["Genre Rules"] = "ジャンル規則",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "AutoEQ コンテキスト規則の優先順位:\n\n1. フォルダー (最長パス一致)\n2. アーティスト (メタデータ完全一致)\n3. ジャンル (get_track_metadata 完全一致)\n4. デフォルトプロファイル (フォールバック)\n\nプロファイルは一時適用されます (persist = false)。\n規則に一致しない曲では元の EQ 状態に戻ります。\n手動や外部で EQ が変更された場合、競合防止のため自動適用は再有効化まで一時停止します。",
        ["Priority & Precedence"] = "優先順位について",
        ["Precedence: Folder > Artist > Genre > Default"] = "優先順位: フォルダー > アーティスト > ジャンル > デフォルト",
        ["Disabled"] = "無効",
        ["Suspended (%s)"] = "一時停止 (%s)",
        ["Active: %s"] = "有効: %s",
        ["Active"] = "有効",
        ["Enabled"] = "有効",
        ["Status: %s"] = "状態: %s",
        ["AutoEQ Context reclaimed"] = "AutoEQ コンテキストの制御を再開しました",
        ["Folder Rules (%d)"] = "フォルダー規則 (%d)",
        ["Artist Rules (%d)"] = "アーティスト規則 (%d)",
        ["Genre Rules (%d)"] = "ジャンル規則 (%d)",
        ["None"] = "なし",
        ["Default Profile: %s"] = "デフォルトプロファイル: %s",
        ["Select Default Profile"] = "デフォルトプロファイルを選択",
        ["Priority & Precedence Info"] = "優先順位の説明",
    },
    nl = {
        ["AutoEQ Context"] = "AutoEQ-context",
        ["Failed to encode configuration"] = "Configuratie coderen mislukt",
        ["Failed to save settings to storage; changes are live for this session only"] = "Opslaan mislukt; wijzigingen gelden alleen voor deze sessie",
        ["Storage unavailable; changes are live for this session only"] = "Opslag niet beschikbaar; wijzigingen gelden alleen voor deze sessie",
        ["Manual or external EQ change detected"] = "Handmatige of externe EQ-wijziging gedetecteerd",
        ["External change"] = "Externe wijziging",
        ["(None / Clear)"] = "(Geen / Wissen)",
        ["Add folder rule"] = "Mapregel toevoegen",
        ["Folder Path"] = "Mappad",
        ["Select Profile for Folder"] = "Profiel voor map kiezen",
        ["Rule: %s"] = "Regel: %s",
        ["Change Profile"] = "Profiel wijzigen",
        ["Delete Rule"] = "Regel verwijderen",
        ["New Profile"] = "Nieuw profiel",
        ["Folder Rules"] = "Mapregels",
        ["Add artist rule"] = "Artiestregel toevoegen",
        ["Artist Name"] = "Artiestnaam",
        ["Select Profile for Artist"] = "Profiel voor artiest kiezen",
        ["Artist: %s"] = "Artiest: %s",
        ["Artist Rules"] = "Artiestregels",
        ["Add genre rule"] = "Genreregel toevoegen",
        ["Genre Name"] = "Genrenaam",
        ["Select Profile for Genre"] = "Profiel voor genre kiezen",
        ["Genre: %s"] = "Genre: %s",
        ["Genre Rules"] = "Genreregels",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Voorrang van AutoEQ-contextregels:\n\n1. Map (langste overeenkomende padvoorvoegsel)\n2. Artiest (exacte overeenkomst uit metadata)\n3. Genre (exacte overeenkomst uit get_track_metadata)\n4. Standaardprofiel (terugval)\n\nProfielen worden tijdelijk toegepast (persist = false).\nBij een nummer zonder regel wordt de basis-EQ hersteld.\nAls de EQ extern wordt gewijzigd, pauzeert automatisering tot deze weer wordt ingeschakeld.",
        ["Priority & Precedence"] = "Prioriteit & voorrang",
        ["Precedence: Folder > Artist > Genre > Default"] = "Voorrang: Map > Artiest > Genre > Standaard",
        ["Disabled"] = "Uitgeschakeld",
        ["Suspended (%s)"] = "Gepauzeerd (%s)",
        ["Active: %s"] = "Actief: %s",
        ["Active"] = "Actief",
        ["Enabled"] = "Ingeschakeld",
        ["Status: %s"] = "Status: %s",
        ["AutoEQ Context reclaimed"] = "AutoEQ-context hervat",
        ["Folder Rules (%d)"] = "Mapregels (%d)",
        ["Artist Rules (%d)"] = "Artiestregels (%d)",
        ["Genre Rules (%d)"] = "Genreregels (%d)",
        ["None"] = "Geen",
        ["Default Profile: %s"] = "Standaardprofiel: %s",
        ["Select Default Profile"] = "Standaardprofiel kiezen",
        ["Priority & Precedence Info"] = "Info over prioriteit & voorrang",
    },
    pt = {
        ["AutoEQ Context"] = "AutoEQ por Contexto",
        ["Failed to encode configuration"] = "Falha ao codificar a configuração",
        ["Failed to save settings to storage; changes are live for this session only"] = "Falha ao salvar; as alterações valem apenas nesta sessão",
        ["Storage unavailable; changes are live for this session only"] = "Armazenamento indisponível; as alterações valem apenas nesta sessão",
        ["Manual or external EQ change detected"] = "Alteração manual ou externa de EQ detectada",
        ["External change"] = "Alteração externa",
        ["(None / Clear)"] = "(Nenhum / Limpar)",
        ["Add folder rule"] = "Adicionar regra de pasta",
        ["Folder Path"] = "Caminho da pasta",
        ["Select Profile for Folder"] = "Selecionar perfil para a pasta",
        ["Rule: %s"] = "Regra: %s",
        ["Change Profile"] = "Alterar perfil",
        ["Delete Rule"] = "Excluir regra",
        ["New Profile"] = "Novo perfil",
        ["Folder Rules"] = "Regras de pasta",
        ["Add artist rule"] = "Adicionar regra de artista",
        ["Artist Name"] = "Nome do artista",
        ["Select Profile for Artist"] = "Selecionar perfil para o artista",
        ["Artist: %s"] = "Artista: %s",
        ["Artist Rules"] = "Regras de artista",
        ["Add genre rule"] = "Adicionar regra de gênero",
        ["Genre Name"] = "Nome do gênero",
        ["Select Profile for Genre"] = "Selecionar perfil para o gênero",
        ["Genre: %s"] = "Gênero: %s",
        ["Genre Rules"] = "Regras de gênero",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Precedência das regras do AutoEQ por Contexto:\n\n1. Pasta (maior prefixo de caminho correspondente)\n2. Artista (correspondência exata dos metadados)\n3. Gênero (correspondência exata de get_track_metadata)\n4. Perfil padrão (alternativa)\n\nOs perfis são aplicados temporariamente (persist = false).\nSe tocar uma faixa sem regra, o EQ base é restaurado.\nSe o EQ for alterado externamente, a automação é suspensa até ser reativada.",
        ["Priority & Precedence"] = "Prioridade e precedência",
        ["Precedence: Folder > Artist > Genre > Default"] = "Precedência: Pasta > Artista > Gênero > Padrão",
        ["Disabled"] = "Desativado",
        ["Suspended (%s)"] = "Suspenso (%s)",
        ["Active: %s"] = "Ativo: %s",
        ["Active"] = "Ativo",
        ["Enabled"] = "Ativado",
        ["Status: %s"] = "Status: %s",
        ["AutoEQ Context reclaimed"] = "Controle do AutoEQ por Contexto retomado",
        ["Folder Rules (%d)"] = "Regras de pasta (%d)",
        ["Artist Rules (%d)"] = "Regras de artista (%d)",
        ["Genre Rules (%d)"] = "Regras de gênero (%d)",
        ["None"] = "Nenhum",
        ["Default Profile: %s"] = "Perfil padrão: %s",
        ["Select Default Profile"] = "Selecionar perfil padrão",
        ["Priority & Precedence Info"] = "Info de prioridade e precedência",
    },
    ru = {
        ["AutoEQ Context"] = "Контекстный AutoEQ",
        ["Failed to encode configuration"] = "Не удалось закодировать конфигурацию",
        ["Failed to save settings to storage; changes are live for this session only"] = "Не удалось сохранить настройки; изменения действуют только в этом сеансе",
        ["Storage unavailable; changes are live for this session only"] = "Хранилище недоступно; изменения действуют только в этом сеансе",
        ["Manual or external EQ change detected"] = "Обнаружено ручное или внешнее изменение EQ",
        ["External change"] = "Внешнее изменение",
        ["(None / Clear)"] = "(Нет / Очистить)",
        ["Add folder rule"] = "Добавить правило для папки",
        ["Folder Path"] = "Путь к папке",
        ["Select Profile for Folder"] = "Выберите профиль для папки",
        ["Rule: %s"] = "Правило: %s",
        ["Change Profile"] = "Сменить профиль",
        ["Delete Rule"] = "Удалить правило",
        ["New Profile"] = "Новый профиль",
        ["Folder Rules"] = "Правила для папок",
        ["Add artist rule"] = "Добавить правило для исполнителя",
        ["Artist Name"] = "Имя исполнителя",
        ["Select Profile for Artist"] = "Выберите профиль для исполнителя",
        ["Artist: %s"] = "Исполнитель: %s",
        ["Artist Rules"] = "Правила для исполнителей",
        ["Add genre rule"] = "Добавить правило для жанра",
        ["Genre Name"] = "Название жанра",
        ["Select Profile for Genre"] = "Выберите профиль для жанра",
        ["Genre: %s"] = "Жанр: %s",
        ["Genre Rules"] = "Правила для жанров",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Приоритет правил контекстного AutoEQ:\n\n1. Папка (наибольший совпадающий префикс пути)\n2. Исполнитель (точное совпадение из метаданных)\n3. Жанр (точное совпадение из get_track_metadata)\n4. Профиль по умолчанию (резервный)\n\nПрофили применяются временно (persist = false).\nЕсли играет трек без правил, восстанавливается базовый EQ.\nПри внешнем изменении EQ автоматика приостанавливается до повторного включения.",
        ["Priority & Precedence"] = "Приоритет правил",
        ["Precedence: Folder > Artist > Genre > Default"] = "Приоритет: Папка > Исполнитель > Жанр > По умолчанию",
        ["Disabled"] = "Отключено",
        ["Suspended (%s)"] = "Приостановлено (%s)",
        ["Active: %s"] = "Активно: %s",
        ["Active"] = "Активно",
        ["Enabled"] = "Включено",
        ["Status: %s"] = "Статус: %s",
        ["AutoEQ Context reclaimed"] = "Управление контекстным AutoEQ восстановлено",
        ["Folder Rules (%d)"] = "Правила для папок (%d)",
        ["Artist Rules (%d)"] = "Правила для исполнителей (%d)",
        ["Genre Rules (%d)"] = "Правила для жанров (%d)",
        ["None"] = "Нет",
        ["Default Profile: %s"] = "Профиль по умолчанию: %s",
        ["Select Default Profile"] = "Выберите профиль по умолчанию",
        ["Priority & Precedence Info"] = "О приоритете правил",
    },
    uk = {
        ["AutoEQ Context"] = "Контекстний AutoEQ",
        ["Failed to encode configuration"] = "Не вдалося закодувати конфігурацію",
        ["Failed to save settings to storage; changes are live for this session only"] = "Не вдалося зберегти налаштування; зміни діють лише в цьому сеансі",
        ["Storage unavailable; changes are live for this session only"] = "Сховище недоступне; зміни діють лише в цьому сеансі",
        ["Manual or external EQ change detected"] = "Виявлено ручну або зовнішню зміну EQ",
        ["External change"] = "Зовнішня зміна",
        ["(None / Clear)"] = "(Немає / Очистити)",
        ["Add folder rule"] = "Додати правило для теки",
        ["Folder Path"] = "Шлях до теки",
        ["Select Profile for Folder"] = "Виберіть профіль для теки",
        ["Rule: %s"] = "Правило: %s",
        ["Change Profile"] = "Змінити профіль",
        ["Delete Rule"] = "Видалити правило",
        ["New Profile"] = "Новий профіль",
        ["Folder Rules"] = "Правила для тек",
        ["Add artist rule"] = "Додати правило для виконавця",
        ["Artist Name"] = "Ім'я виконавця",
        ["Select Profile for Artist"] = "Виберіть профіль для виконавця",
        ["Artist: %s"] = "Виконавець: %s",
        ["Artist Rules"] = "Правила для виконавців",
        ["Add genre rule"] = "Додати правило для жанру",
        ["Genre Name"] = "Назва жанру",
        ["Select Profile for Genre"] = "Виберіть профіль для жанру",
        ["Genre: %s"] = "Жанр: %s",
        ["Genre Rules"] = "Правила для жанрів",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Пріоритет правил контекстного AutoEQ:\n\n1. Тека (найдовший спільний префікс шляху)\n2. Виконавець (точний збіг із метаданих)\n3. Жанр (точний збіг із get_track_metadata)\n4. Профіль за замовчуванням (резервний)\n\nПрофілі застосовуються тимчасово (persist = false).\nЯкщо грає трек без правил, відновлюється базовий EQ.\nУ разі зовнішньої зміни EQ автоматика призупиняється до повторного ввімкнення.",
        ["Priority & Precedence"] = "Пріоритет правил",
        ["Precedence: Folder > Artist > Genre > Default"] = "Пріоритет: Тека > Виконавець > Жанр > За замовчуванням",
        ["Disabled"] = "Вимкнено",
        ["Suspended (%s)"] = "Призупинено (%s)",
        ["Active: %s"] = "Активно: %s",
        ["Active"] = "Активно",
        ["Enabled"] = "Увімкнено",
        ["Status: %s"] = "Статус: %s",
        ["AutoEQ Context reclaimed"] = "Керування контекстним AutoEQ відновлено",
        ["Folder Rules (%d)"] = "Правила для тек (%d)",
        ["Artist Rules (%d)"] = "Правила для виконавців (%d)",
        ["Genre Rules (%d)"] = "Правила для жанрів (%d)",
        ["None"] = "Немає",
        ["Default Profile: %s"] = "Профіль за замовчуванням: %s",
        ["Select Default Profile"] = "Виберіть профіль за замовчуванням",
        ["Priority & Precedence Info"] = "Про пріоритет правил",
    },
    vi = {
        ["AutoEQ Context"] = "AutoEQ theo ngữ cảnh",
        ["Failed to encode configuration"] = "Không thể mã hóa cấu hình",
        ["Failed to save settings to storage; changes are live for this session only"] = "Không lưu được cài đặt; thay đổi chỉ có hiệu lực trong phiên này",
        ["Storage unavailable; changes are live for this session only"] = "Bộ nhớ không khả dụng; thay đổi chỉ có hiệu lực trong phiên này",
        ["Manual or external EQ change detected"] = "Phát hiện thay đổi EQ thủ công hoặc từ bên ngoài",
        ["External change"] = "Thay đổi bên ngoài",
        ["(None / Clear)"] = "(Không / Xóa)",
        ["Add folder rule"] = "Thêm quy tắc thư mục",
        ["Folder Path"] = "Đường dẫn thư mục",
        ["Select Profile for Folder"] = "Chọn hồ sơ cho thư mục",
        ["Rule: %s"] = "Quy tắc: %s",
        ["Change Profile"] = "Đổi hồ sơ",
        ["Delete Rule"] = "Xóa quy tắc",
        ["New Profile"] = "Hồ sơ mới",
        ["Folder Rules"] = "Quy tắc thư mục",
        ["Add artist rule"] = "Thêm quy tắc nghệ sĩ",
        ["Artist Name"] = "Tên nghệ sĩ",
        ["Select Profile for Artist"] = "Chọn hồ sơ cho nghệ sĩ",
        ["Artist: %s"] = "Nghệ sĩ: %s",
        ["Artist Rules"] = "Quy tắc nghệ sĩ",
        ["Add genre rule"] = "Thêm quy tắc thể loại",
        ["Genre Name"] = "Tên thể loại",
        ["Select Profile for Genre"] = "Chọn hồ sơ cho thể loại",
        ["Genre: %s"] = "Thể loại: %s",
        ["Genre Rules"] = "Quy tắc thể loại",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "Thứ tự ưu tiên của AutoEQ theo ngữ cảnh:\n\n1. Thư mục (khớp tiền tố đường dẫn dài nhất)\n2. Nghệ sĩ (khớp chính xác từ siêu dữ liệu)\n3. Thể loại (khớp chính xác từ get_track_metadata)\n4. Hồ sơ mặc định (dự phòng)\n\nHồ sơ được áp dụng tạm thời (persist = false).\nKhi phát bài không khớp quy tắc, EQ gốc sẽ được khôi phục.\nNếu EQ bị chỉnh từ bên ngoài, tự động hóa sẽ tạm dừng cho đến khi bật lại.",
        ["Priority & Precedence"] = "Thứ tự ưu tiên",
        ["Precedence: Folder > Artist > Genre > Default"] = "Ưu tiên: Thư mục > Nghệ sĩ > Thể loại > Mặc định",
        ["Disabled"] = "Đã tắt",
        ["Suspended (%s)"] = "Tạm dừng (%s)",
        ["Active: %s"] = "Đang bật: %s",
        ["Active"] = "Đang bật",
        ["Enabled"] = "Đã bật",
        ["Status: %s"] = "Trạng thái: %s",
        ["AutoEQ Context reclaimed"] = "Đã khôi phục điều khiển AutoEQ theo ngữ cảnh",
        ["Folder Rules (%d)"] = "Quy tắc thư mục (%d)",
        ["Artist Rules (%d)"] = "Quy tắc nghệ sĩ (%d)",
        ["Genre Rules (%d)"] = "Quy tắc thể loại (%d)",
        ["None"] = "Không",
        ["Default Profile: %s"] = "Hồ sơ mặc định: %s",
        ["Select Default Profile"] = "Chọn hồ sơ mặc định",
        ["Priority & Precedence Info"] = "Thông tin thứ tự ưu tiên",
    },
    zh_CN = {
        ["AutoEQ Context"] = "按情境 AutoEQ",
        ["Failed to encode configuration"] = "无法编码配置",
        ["Failed to save settings to storage; changes are live for this session only"] = "无法保存设置；更改仅在本次会话中生效",
        ["Storage unavailable; changes are live for this session only"] = "存储不可用；更改仅在本次会话中生效",
        ["Manual or external EQ change detected"] = "检测到手动或外部 EQ 更改",
        ["External change"] = "外部更改",
        ["(None / Clear)"] = "（无 / 清除）",
        ["Add folder rule"] = "添加文件夹规则",
        ["Folder Path"] = "文件夹路径",
        ["Select Profile for Folder"] = "为文件夹选择配置",
        ["Rule: %s"] = "规则：%s",
        ["Change Profile"] = "更换配置",
        ["Delete Rule"] = "删除规则",
        ["New Profile"] = "新配置",
        ["Folder Rules"] = "文件夹规则",
        ["Add artist rule"] = "添加艺人规则",
        ["Artist Name"] = "艺人名称",
        ["Select Profile for Artist"] = "为艺人选择配置",
        ["Artist: %s"] = "艺人：%s",
        ["Artist Rules"] = "艺人规则",
        ["Add genre rule"] = "添加流派规则",
        ["Genre Name"] = "流派名称",
        ["Select Profile for Genre"] = "为流派选择配置",
        ["Genre: %s"] = "流派：%s",
        ["Genre Rules"] = "流派规则",
        ["AutoEQ Context Rules Precedence:\n\n1. Folder (longest path prefix boundary match)\n2. Artist (exact match from metadata)\n3. Genre (exact match from get_track_metadata)\n4. Default Profile (fallback)\n\nProfiles are applied transiently (persist = false).\nIf an unmapped or tagless track plays, owned baseline is restored.\nIf EQ state is modified externally (manual EQ or Output-Aware Sound), automation suspends until re-enabled to prevent fighting."] = "按情境 AutoEQ 规则优先级：\n\n1. 文件夹（最长路径前缀匹配）\n2. 艺人（元数据精确匹配）\n3. 流派（get_track_metadata 精确匹配）\n4. 默认配置（后备）\n\n配置仅临时生效 (persist = false)。\n播放未匹配或无标签曲目时，将恢复基准 EQ。\n若外部修改了 EQ 状态，自动切换将暂停，直至重新启用。",
        ["Priority & Precedence"] = "优先级说明",
        ["Precedence: Folder > Artist > Genre > Default"] = "优先级：文件夹 > 艺人 > 流派 > 默认",
        ["Disabled"] = "已禁用",
        ["Suspended (%s)"] = "已暂停 (%s)",
        ["Active: %s"] = "已启用：%s",
        ["Active"] = "已启用",
        ["Enabled"] = "启用",
        ["Status: %s"] = "状态：%s",
        ["AutoEQ Context reclaimed"] = "已恢复按情境 AutoEQ 控制",
        ["Folder Rules (%d)"] = "文件夹规则 (%d)",
        ["Artist Rules (%d)"] = "艺人规则 (%d)",
        ["Genre Rules (%d)"] = "流派规则 (%d)",
        ["None"] = "无",
        ["Default Profile: %s"] = "默认配置：%s",
        ["Select Default Profile"] = "选择默认配置",
        ["Priority & Precedence Info"] = "优先级说明",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

-- AutoEQ by Context:
-- Automatically applies PEQ profiles based on folder, artist, or genre context.
-- Uses transient profile application (persist = false) to prevent flash writes on track changes.
-- Deterministic precedence: Folder (longest prefix) > Artist > Genre > Default profile.
--
-- EQ Ownership Policy:
-- - Detached snapshot of last applied EQ state is maintained with 1e-6 precision.
-- - Before automatic transition, current EQ is compared to last applied state.
-- - If state differs, automatic writes suspend immediately until re-enabled/reclaimed.
-- - Baseline EQ is restored on leaving matched context or on disable if still owned.
-- - Baseline EQ is preserved across rule/profile edits while owned.

local CONFIG_PATH = plugin.sd_root() .. "/.plugins/autoeq_context_config.json"
local PROFILES_DIR = plugin.sd_root() .. "/PEQ_Profiles"
local MAX_UI_ROWS = 500
local EPSILON = 1e-6

local config = {
    enabled = false,
    default_profile = "",
    rules = {
        folder = {}, -- array of { folder = "/path", profile = "name.peq" }
        artist = {}, -- map of [lower_artist] = "name.peq"
        genre = {},  -- map of [lower_genre] = "name.peq"
    }
}

local baseline_state = nil
local last_applied_state = nil
local is_suspended = false
local suspension_reason = nil
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

local function normalize_folder(f)
    if not f or f == "" then return "" end
    f = f:gsub("\\", "/")
    f = f:gsub("/+$", "")
    return f
end

local function folder_matches_track(folder_rule, track_path)
    if not folder_rule or folder_rule == "" or not track_path or track_path == "" then
        return false
    end
    folder_rule = normalize_folder(folder_rule)
    track_path = track_path:gsub("\\", "/")
    local f_len = #folder_rule
    local t_len = #track_path
    if t_len < f_len then return false end

    if string.lower(track_path:sub(1, f_len)) ~= string.lower(folder_rule) then
        return false
    end

    if t_len == f_len then return true end
    local next_char = track_path:sub(f_len + 1, f_len + 1)
    return next_char == "/"
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
    if type(data.default_profile) == "string" and (data.default_profile == "" or is_valid_profile_name(data.default_profile)) then
        config.default_profile = data.default_profile
    end
    if type(data.rules) == "table" then
        if type(data.rules.folder) == "table" then
            config.rules.folder = {}
            for _, r in ipairs(data.rules.folder) do
                if #config.rules.folder >= MAX_UI_ROWS then break end
                if type(r) == "table" and type(r.folder) == "string" and #r.folder > 0 and #r.folder <= 512
                   and is_valid_profile_name(r.profile) then
                    config.rules.folder[#config.rules.folder + 1] = {
                        folder = normalize_folder(r.folder),
                        profile = r.profile
                    }
                end
            end
        end
        if type(data.rules.artist) == "table" then
            config.rules.artist = {}
            local count = 0
            for k, v in pairs(data.rules.artist) do
                if count >= MAX_UI_ROWS then break end
                if type(k) == "string" and #k > 0 and #k <= 256 and is_valid_profile_name(v) then
                    config.rules.artist[string.lower(k)] = v
                    count = count + 1
                end
            end
        end
        if type(data.rules.genre) == "table" then
            config.rules.genre = {}
            local count = 0
            for k, v in pairs(data.rules.genre) do
                if count >= MAX_UI_ROWS then break end
                if type(k) == "string" and #k > 0 and #k <= 256 and is_valid_profile_name(v) then
                    config.rules.genre[string.lower(k)] = v
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

-- Resolve matching profile deterministically:
-- 1. Folder rule (longest prefix)
-- 2. Artist rule
-- 3. Genre rule
-- 4. Default fallback profile
local function resolve_profile_for_track(track_path)
    if not track_path or track_path == "" then
        return nil, "unresolved"
    end

    -- 1. Folder match: longest prefix
    local best_rule = nil
    local best_len = -1
    for _, r in ipairs(config.rules.folder) do
        if folder_matches_track(r.folder, track_path) then
            local norm = normalize_folder(r.folder)
            if #norm > best_len then
                best_len = #norm
                best_rule = r
            end
        end
    end
    if best_rule and is_valid_profile_name(best_rule.profile) then
        return best_rule.profile, "folder"
    end

    -- Metadata retrieval
    local meta = nil
    if plugin.has_capability and plugin.has_capability("library.track_metadata") and plugin.get_track_metadata then
        meta = plugin.get_track_metadata(track_path)
    end

    -- 2. Artist match
    local artist = nil
    if meta and meta.artist and meta.artist ~= "" then
        artist = meta.artist
    elseif plugin.get_now_playing then
        local _, np_artist = plugin.get_now_playing()
        if np_artist and np_artist ~= "" then artist = np_artist end
    end
    if artist then
        local prof = config.rules.artist[string.lower(artist)]
        if prof and is_valid_profile_name(prof) then
            return prof, "artist"
        end
    end

    -- 3. Genre match: nil or empty means unavailable
    local genre = meta and meta.genre
    if genre and genre ~= "" then
        local prof = config.rules.genre[string.lower(genre)]
        if prof and is_valid_profile_name(prof) then
            return prof, "genre"
        end
    end

    -- 4. Default profile
    if config.default_profile and is_valid_profile_name(config.default_profile) then
        return config.default_profile, "default"
    end

    return nil, "none"
end

local function apply_target_profile(profile_name)
    if not is_valid_profile_name(profile_name) then return false end
    local full_path = PROFILES_DIR .. "/" .. profile_name
    if not (plugin.has_capability and plugin.has_capability("audio.peq.transient") and plugin.eq_apply_profile) then
        return false
    end
    return plugin.eq_apply_profile(full_path, { persist = false })
end

local function evaluate_current_track()
    if not config.enabled then return end
    if is_suspended then return end

    local track_path = plugin.get_current_track_path and plugin.get_current_track_path()
    local target_profile, match_type = resolve_profile_for_track(track_path)

    if not target_profile or target_profile == "" then
        -- Unmatched, tagless, remote, or unresolved track:
        -- If we previously applied a transient profile, restore the runtime baseline!
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
            last_profile_succeeded = false
        end
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

    -- Cache successful context, retry failed profile
    if target_profile == last_applied_profile and last_profile_succeeded then
        return
    end

    local ok = apply_target_profile(target_profile)
    if ok then
        last_applied_profile = target_profile
        last_profile_succeeded = true
        if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
            last_applied_state = plugin.get_eq_state()
        end
    else
        last_applied_profile = target_profile
        last_profile_succeeded = false -- Ensures retry on next track
    end
end

local function grant_control(is_reclaiming)
    is_suspended = false
    suspension_reason = nil
    last_applied_profile = nil
    last_profile_succeeded = false

    if plugin.has_capability and plugin.has_capability("audio.peq.state") and plugin.get_eq_state then
        local current_eq = plugin.get_eq_state()
        -- Recapture baseline only if we have no baseline, or if explicitly reclaiming after manual/external modification
        if baseline_state == nil or is_reclaiming or (last_applied_state and not eq_states_equal(current_eq, last_applied_state)) then
            baseline_state = current_eq
        end
        last_applied_state = plugin.get_eq_state()
    end
    evaluate_current_track()
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

local function open_folder_rules()
    local rows = {
        {
            type = "row",
            label = tr("Add folder rule"),
            on_select = function()
                plugin.show_text_input(tr("Folder Path"), "/Music/", false, function(folder_path)
                    folder_path = normalize_folder(folder_path)
                    if folder_path ~= "" then
                        show_profile_picker(tr("Select Profile for Folder"), "", function(prof)
                            if prof ~= "" and is_valid_profile_name(prof) then
                                config.rules.folder[#config.rules.folder + 1] = { folder = folder_path, profile = prof }
                                save_config()
                                if config.enabled and not is_suspended then evaluate_current_track() end
                                open_folder_rules()
                            end
                        end)
                    end
                end)
            end
        }
    }
    local limit = math.min(#config.rules.folder, MAX_UI_ROWS - 1)
    for i = 1, limit do
        local r = config.rules.folder[i]
        local idx = i
        rows[#rows + 1] = {
            type = "row",
            label = r.folder .. " -> " .. r.profile,
            on_select = function()
                plugin.show_list(string.format(tr("Rule: %s"), r.folder), { tr("Change Profile"), tr("Delete Rule") }, function(action_idx)
                    if action_idx == 1 then
                        show_profile_picker(tr("New Profile"), r.profile, function(new_prof)
                            if new_prof ~= "" and is_valid_profile_name(new_prof) then
                                config.rules.folder[idx].profile = new_prof
                            else
                                table.remove(config.rules.folder, idx)
                            end
                            save_config()
                            if config.enabled and not is_suspended then evaluate_current_track() end
                            open_folder_rules()
                        end)
                    elseif action_idx == 2 then
                        table.remove(config.rules.folder, idx)
                        save_config()
                        if config.enabled and not is_suspended then evaluate_current_track() end
                        open_folder_rules()
                    end
                end)
            end
        }
    end
    plugin.show_settings_list(tr("Folder Rules"), rows, { update = true })
end

local function open_artist_rules()
    local rows = {
        {
            type = "row",
            label = tr("Add artist rule"),
            on_select = function()
                plugin.show_text_input(tr("Artist Name"), "", false, function(artist_name)
                    local key = artist_name:gsub("^%s+", ""):gsub("%s+$", "")
                    if key ~= "" then
                        show_profile_picker(tr("Select Profile for Artist"), "", function(prof)
                            if prof ~= "" and is_valid_profile_name(prof) then
                                config.rules.artist[string.lower(key)] = prof
                                save_config()
                                if config.enabled and not is_suspended then evaluate_current_track() end
                                open_artist_rules()
                            end
                        end)
                    end
                end)
            end
        }
    }
    local keys = {}
    for k in pairs(config.rules.artist) do keys[#keys + 1] = k end
    table.sort(keys)
    local limit = math.min(#keys, MAX_UI_ROWS - 1)
    for i = 1, limit do
        local k = keys[i]
        local prof = config.rules.artist[k]
        rows[#rows + 1] = {
            type = "row",
            label = k .. " -> " .. prof,
            on_select = function()
                plugin.show_list(string.format(tr("Artist: %s"), k), { tr("Change Profile"), tr("Delete Rule") }, function(action_idx)
                    if action_idx == 1 then
                        show_profile_picker(tr("New Profile"), prof, function(new_prof)
                            if new_prof ~= "" and is_valid_profile_name(new_prof) then
                                config.rules.artist[k] = new_prof
                            else
                                config.rules.artist[k] = nil
                            end
                            save_config()
                            if config.enabled and not is_suspended then evaluate_current_track() end
                            open_artist_rules()
                        end)
                    elseif action_idx == 2 then
                        config.rules.artist[k] = nil
                        save_config()
                        if config.enabled and not is_suspended then evaluate_current_track() end
                        open_artist_rules()
                    end
                end)
            end
        }
    end
    plugin.show_settings_list(tr("Artist Rules"), rows, { update = true })
end

local function open_genre_rules()
    local rows = {
        {
            type = "row",
            label = tr("Add genre rule"),
            on_select = function()
                plugin.show_text_input(tr("Genre Name"), "", false, function(genre_name)
                    local key = genre_name:gsub("^%s+", ""):gsub("%s+$", "")
                    if key ~= "" then
                        show_profile_picker(tr("Select Profile for Genre"), "", function(prof)
                            if prof ~= "" and is_valid_profile_name(prof) then
                                config.rules.genre[string.lower(key)] = prof
                                save_config()
                                if config.enabled and not is_suspended then evaluate_current_track() end
                                open_genre_rules()
                            end
                        end)
                    end
                end)
            end
        }
    }
    local keys = {}
    for k in pairs(config.rules.genre) do keys[#keys + 1] = k end
    table.sort(keys)
    local limit = math.min(#keys, MAX_UI_ROWS - 1)
    for i = 1, limit do
        local k = keys[i]
        local prof = config.rules.genre[k]
        rows[#rows + 1] = {
            type = "row",
            label = k .. " -> " .. prof,
            on_select = function()
                plugin.show_list(string.format(tr("Genre: %s"), k), { tr("Change Profile"), tr("Delete Rule") }, function(action_idx)
                    if action_idx == 1 then
                        show_profile_picker(tr("New Profile"), prof, function(new_prof)
                            if new_prof ~= "" and is_valid_profile_name(new_prof) then
                                config.rules.genre[k] = new_prof
                            else
                                config.rules.genre[k] = nil
                            end
                            save_config()
                            if config.enabled and not is_suspended then evaluate_current_track() end
                            open_genre_rules()
                        end)
                    elseif action_idx == 2 then
                        config.rules.genre[k] = nil
                        save_config()
                        if config.enabled and not is_suspended then evaluate_current_track() end
                        open_genre_rules()
                    end
                end)
            end
        }
    end
    plugin.show_settings_list(tr("Genre Rules"), rows, { update = true })
end

local function show_precedence_info()
    local text = tr("AutoEQ Context Rules Precedence:\n\n"
        .. "1. Folder (longest path prefix boundary match)\n"
        .. "2. Artist (exact match from metadata)\n"
        .. "3. Genre (exact match from get_track_metadata)\n"
        .. "4. Default Profile (fallback)\n\n"
        .. "Profiles are applied transiently (persist = false).\n"
        .. "If an unmapped or tagless track plays, owned baseline is restored.\n"
        .. "If EQ state is modified externally (manual EQ or Output-Aware Sound), "
        .. "automation suspends until re-enabled to prevent fighting.")
    if plugin.show_text_view then
        plugin.show_text_view(tr("Priority & Precedence"), text)
    elseif plugin.show_toast then
        plugin.show_toast(tr("Precedence: Folder > Artist > Genre > Default"))
    end
end

open_main_settings = function()
    local status_text
    if not config.enabled then
        status_text = tr("Disabled")
    elseif is_suspended then
        status_text = string.format(tr("Suspended (%s)"), tr(suspension_reason or "External change"))
    elseif last_applied_profile then
        status_text = string.format(tr("Active: %s"), last_applied_profile)
    else
        status_text = tr("Active")
    end

    local artist_count = 0
    for _ in pairs(config.rules.artist) do artist_count = artist_count + 1 end
    local genre_count = 0
    for _ in pairs(config.rules.genre) do genre_count = genre_count + 1 end

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
                    if plugin.show_toast then plugin.show_toast(tr("AutoEQ Context reclaimed")) end
                    open_main_settings()
                end
            end
        },
        {
            type = "row",
            label = string.format(tr("Folder Rules (%d)"), #config.rules.folder),
            on_select = open_folder_rules
        },
        {
            type = "row",
            label = string.format(tr("Artist Rules (%d)"), artist_count),
            on_select = open_artist_rules
        },
        {
            type = "row",
            label = string.format(tr("Genre Rules (%d)"), genre_count),
            on_select = open_genre_rules
        },
        {
            type = "row",
            label = string.format(tr("Default Profile: %s"), config.default_profile ~= "" and config.default_profile or tr("None")),
            on_select = function()
                show_profile_picker(tr("Select Default Profile"), config.default_profile, function(prof)
                    if prof == "" or is_valid_profile_name(prof) then
                        config.default_profile = prof
                        save_config()
                        if config.enabled and not is_suspended then evaluate_current_track() end
                        open_main_settings()
                    end
                end)
            end
        },
        {
            type = "row",
            label = tr("Priority & Precedence Info"),
            on_select = show_precedence_info
        }
    }
    plugin.show_settings_list(tr("AutoEQ Context"), rows, { update = true })
end

-- Initialize
load_config()
plugin.register_list_item("music_audio", tr("AutoEQ Context"), open_main_settings)

plugin.on("track_started", function()
    evaluate_current_track()
end)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        config = config,
        load_config = load_config,
        save_config = save_config,
        folder_matches_track = folder_matches_track,
        resolve_profile_for_track = resolve_profile_for_track,
        evaluate_current_track = evaluate_current_track,
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
                last_applied_profile = last_applied_profile,
                last_succeeded = last_profile_succeeded,
                last_applied_state = last_applied_state,
                baseline_state = baseline_state,
            }
        end,
        set_suspended = function(s, r) is_suspended = s; suspension_reason = r end,
    }
end
