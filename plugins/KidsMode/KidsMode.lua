plugin.define({ id = "example.kidsmode", name = "Kids Mode", version = "3.2.0", api_min = 19 })

local T = {
    de = {
        ["Kids Mode"] = "Kindermodus",
        ["Music"] = "Musik",
        ["Stream Media"] = "Streaming-Medien",
        ["Wireless"] = "Drahtlos",
        ["Books"] = "Bücher",
        ["Settings"] = "Einstellungen",
        ["More"] = "Mehr",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Dateien",
        ["Artists"] = "Künstler",
        ["Albums"] = "Alben",
        ["Album Artist"] = "Album-Künstler",
        ["Genres"] = "Genres",
        ["All Songs"] = "Alle Titel",
        ["Playlists"] = "Wiedergabelisten",
        ["Sound"] = "Klang",
        ["Playback"] = "Wiedergabe",
        ["Library"] = "Bibliothek",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Schlummerfunktion",
        ["Crossfade"] = "Überblenden",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Lückenlos",
        ["Remote control"] = "Fernsteuerung",
        ["Car mode"] = "Automodus",
        ["Plugin toggles"] = "Plugin-Schalter",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Kindermodus-Einstellungen konnten nicht gelesen werden; sichere Beschränkungen sind aktiv",
        ["Unable to encode Kids Mode settings"] = "Kindermodus-Einstellungen konnten nicht kodiert werden",
        ["Unable to save Kids Mode settings"] = "Kindermodus-Einstellungen konnten nicht gespeichert werden",
        ["This player cannot customize Home"] = "Dieser Player kann den Startbildschirm nicht anpassen",
        ["This player cannot customize Music menus"] = "Dieser Player kann Musikmenüs nicht anpassen",
        ["This player cannot customize the Quick Drawer"] = "Dieser Player kann das Schnellmenü nicht anpassen",
        ["Update Compás to edit item order"] = "Aktualisiere Compás, um die Reihenfolge zu bearbeiten",
        ["Invalid item order"] = "Ungültige Elementreihenfolge",
        ["Close and reopen this editor to discard the unsaved change"] = "Schließe und öffne diesen Editor erneut, um die ungespeicherte Änderung zu verwerfen",
        ["Close the current item editor before opening another"] = "Schließe den aktuellen Editor, bevor du einen weiteren öffnest",
        ["Unable to open this item editor"] = "Dieser Editor konnte nicht geöffnet werden",
        ["Enable Kids Mode"] = "Kindermodus aktivieren",
        ["Home items"] = "Startbildschirm-Elemente",
        ["Music menus"] = "Musikmenüs",
        ["Music shortcuts"] = "Musik-Kurzbefehle",
        ["Quick Drawer"] = "Schnellmenü",
        ["Drawer EQ access"] = "EQ-Zugriff im Schnellmenü",
        ["Drawer volume access"] = "Lautstärkezugriff im Schnellmenü",
        ["Drawer items"] = "Schnellmenü-Elemente",
        ["Change Parent PIN"] = "Eltern-PIN ändern",
        ["New Parent PIN (4+ digits)"] = "Neue Eltern-PIN (mind. 4 Ziffern)",
        ["PIN must be at least 4 digits"] = "PIN muss mindestens 4 Ziffern lang sein",
        ["PIN updated"] = "PIN aktualisiert",
        ["Unable to save PIN"] = "PIN konnte nicht gespeichert werden",
        ["Apply saved changes and reload UI"] = "Gespeicherte Änderungen anwenden und Oberfläche neu laden",
        ["About Kids Mode"] = "Über Kindermodus",
        ["Kids Mode limits"] = "Kindermodus-Grenzen",
        ["Kids Mode controls navigation only."] = "Der Kindermodus steuert nur die Navigation.",
        ["Playback buttons and Now Playing remain available."] = "Wiedergabetasten und Aktuelle Wiedergabe bleiben verfügbar.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Das Ausblenden von Schnellmenü-Elementen ändert weder Lautstärke, Wi-Fi, Bluetooth, Radio noch Timer.",
        ["Parent Mode"] = "Elternmodus",
        ["Disable Kids Mode"] = "Kindermodus deaktivieren",
        ["Configure restrictions"] = "Beschränkungen konfigurieren",
        ["Close the current text entry before entering a PIN"] = "Schließe die aktuelle Texteingabe, bevor du eine PIN eingibst",
        ["Unable to open PIN entry"] = "PIN-Eingabe konnte nicht geöffnet werden",
        ["Parent PIN"] = "Eltern-PIN",
        ["Incorrect PIN"] = "Falsche PIN",
    },
    es = {
        ["Kids Mode"] = "Modo infantil",
        ["Music"] = "Música",
        ["Stream Media"] = "Medios en línea",
        ["Wireless"] = "Inalámbrico",
        ["Books"] = "Libros",
        ["Settings"] = "Ajustes",
        ["More"] = "Más",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Archivos",
        ["Artists"] = "Artistas",
        ["Albums"] = "Álbumes",
        ["Album Artist"] = "Artista del álbum",
        ["Genres"] = "Géneros",
        ["All Songs"] = "Todas las canciones",
        ["Playlists"] = "Listas de reproducción",
        ["Sound"] = "Sonido",
        ["Playback"] = "Reproducción",
        ["Library"] = "Biblioteca",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Temporizador de apagado",
        ["Crossfade"] = "Fundido cruzado",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Sin pausas",
        ["Remote control"] = "Control remoto",
        ["Car mode"] = "Modo coche",
        ["Plugin toggles"] = "Controles de plugins",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "No se pudieron leer los ajustes del Modo infantil; las restricciones seguras están activas",
        ["Unable to encode Kids Mode settings"] = "No se pudieron codificar los ajustes del Modo infantil",
        ["Unable to save Kids Mode settings"] = "No se pudieron guardar los ajustes del Modo infantil",
        ["This player cannot customize Home"] = "Este reproductor no puede personalizar el Inicio",
        ["This player cannot customize Music menus"] = "Este reproductor no puede personalizar los menús de Música",
        ["This player cannot customize the Quick Drawer"] = "Este reproductor no puede personalizar el panel rápido",
        ["Update Compás to edit item order"] = "Actualiza Compás para editar el orden de los elementos",
        ["Invalid item order"] = "Orden de elementos no válido",
        ["Close and reopen this editor to discard the unsaved change"] = "Cierra y vuelve a abrir este editor para descartar el cambio no guardado",
        ["Close the current item editor before opening another"] = "Cierra el editor actual antes de abrir otro",
        ["Unable to open this item editor"] = "No se pudo abrir este editor de elementos",
        ["Enable Kids Mode"] = "Activar Modo infantil",
        ["Home items"] = "Elementos de Inicio",
        ["Music menus"] = "Menús de Música",
        ["Music shortcuts"] = "Accesos directos de Música",
        ["Quick Drawer"] = "Panel rápido",
        ["Drawer EQ access"] = "Acceso a EQ en el panel",
        ["Drawer volume access"] = "Acceso a volumen en el panel",
        ["Drawer items"] = "Elementos del panel",
        ["Change Parent PIN"] = "Cambiar PIN parental",
        ["New Parent PIN (4+ digits)"] = "Nuevo PIN parental (4+ dígitos)",
        ["PIN must be at least 4 digits"] = "El PIN debe tener al menos 4 dígitos",
        ["PIN updated"] = "PIN actualizado",
        ["Unable to save PIN"] = "No se pudo guardar el PIN",
        ["Apply saved changes and reload UI"] = "Aplicar cambios guardados y recargar la interfaz",
        ["About Kids Mode"] = "Acerca de Modo infantil",
        ["Kids Mode limits"] = "Límites del Modo infantil",
        ["Kids Mode controls navigation only."] = "El Modo infantil solo controla la navegación.",
        ["Playback buttons and Now Playing remain available."] = "Los botones de reproducción y En reproducción siguen disponibles.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Ocultar elementos del panel no cambia el volumen, Wi-Fi, Bluetooth, radio ni temporizadores.",
        ["Parent Mode"] = "Modo parental",
        ["Disable Kids Mode"] = "Desactivar Modo infantil",
        ["Configure restrictions"] = "Configurar restricciones",
        ["Close the current text entry before entering a PIN"] = "Cierra la entrada de texto actual antes de introducir un PIN",
        ["Unable to open PIN entry"] = "No se pudo abrir la entrada de PIN",
        ["Parent PIN"] = "PIN parental",
        ["Incorrect PIN"] = "PIN incorrecto",
    },
    fi = {
        ["Kids Mode"] = "Lasten tila",
        ["Music"] = "Musiikki",
        ["Stream Media"] = "Suoratoisto",
        ["Wireless"] = "Langaton",
        ["Books"] = "Kirjat",
        ["Settings"] = "Asetukset",
        ["More"] = "Lisää",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Tiedostot",
        ["Artists"] = "Artistit",
        ["Albums"] = "Albumit",
        ["Album Artist"] = "Albumin artisti",
        ["Genres"] = "Tyylilajit",
        ["All Songs"] = "Kaikki kappaleet",
        ["Playlists"] = "Soittolistat",
        ["Sound"] = "Ääni",
        ["Playback"] = "Toisto",
        ["Library"] = "Kirjasto",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Uniajastin",
        ["Crossfade"] = "Ristiinhäivytys",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Tauoton",
        ["Remote control"] = "Kaukosäädin",
        ["Car mode"] = "Autotila",
        ["Plugin toggles"] = "Lisäosien kytkimet",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Lasten tilan asetuksia ei voitu lukea; turvarajoitukset ovat käytössä",
        ["Unable to encode Kids Mode settings"] = "Lasten tilan asetusten koodaus epäonnistui",
        ["Unable to save Kids Mode settings"] = "Lasten tilan asetusten tallennus epäonnistui",
        ["This player cannot customize Home"] = "Tämä soitin ei voi mukauttaa Koti-näkymää",
        ["This player cannot customize Music menus"] = "Tämä soitin ei voi mukauttaa Musiikki-valikoita",
        ["This player cannot customize the Quick Drawer"] = "Tämä soitin ei voi mukauttaa pikavalikkoa",
        ["Update Compás to edit item order"] = "Päivitä Compás muokataksesi järjestystä",
        ["Invalid item order"] = "Virheellinen järjestys",
        ["Close and reopen this editor to discard the unsaved change"] = "Sulje ja avaa muokkain uudelleen hylätäksesi tallentamattoman muutoksen",
        ["Close the current item editor before opening another"] = "Sulje nykyinen muokkain ennen toisen avaamista",
        ["Unable to open this item editor"] = "Muokkaimen avaaminen epäonnistui",
        ["Enable Kids Mode"] = "Ota Lasten tila käyttöön",
        ["Home items"] = "Koti-valikon kohteet",
        ["Music menus"] = "Musiikki-valikot",
        ["Music shortcuts"] = "Musiikin pikavalinnat",
        ["Quick Drawer"] = "Pikavalikko",
        ["Drawer EQ access"] = "EQ-pääsy pikavalikossa",
        ["Drawer volume access"] = "Äänenvoimakkuus pikavalikossa",
        ["Drawer items"] = "Pikavalikon kohteet",
        ["Change Parent PIN"] = "Vaihda vanhempien PIN",
        ["New Parent PIN (4+ digits)"] = "Uusi vanhempien PIN (väh. 4 numeroa)",
        ["PIN must be at least 4 digits"] = "PIN-koodissa on oltava vähintään 4 numeroa",
        ["PIN updated"] = "PIN päivitetty",
        ["Unable to save PIN"] = "PIN-koodin tallennus epäonnistui",
        ["Apply saved changes and reload UI"] = "Ota muutokset käyttöön ja lataa käyttöliittymä uudelleen",
        ["About Kids Mode"] = "Tietoja Lasten tilasta",
        ["Kids Mode limits"] = "Lasten tilan rajoitukset",
        ["Kids Mode controls navigation only."] = "Lasten tila rajoittaa vain navigointia.",
        ["Playback buttons and Now Playing remain available."] = "Toistopainikkeet ja Nyt soi -näkymä pysyvät käytettävissä.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Pikavalikon kohteiden piilottaminen ei muuta äänenvoimakkuutta, Wi-Fiä, Bluetoothia, radiota tai ajastimia.",
        ["Parent Mode"] = "Vanhempien tila",
        ["Disable Kids Mode"] = "Poista Lasten tila käytöstä",
        ["Configure restrictions"] = "Määritä rajoitukset",
        ["Close the current text entry before entering a PIN"] = "Sulje nykyinen tekstinsyöttö ennen PIN-koodin syöttämistä",
        ["Unable to open PIN entry"] = "PIN-syötön avaaminen epäonnistui",
        ["Parent PIN"] = "Vanhempien PIN",
        ["Incorrect PIN"] = "Väärä PIN",
    },
    fr = {
        ["Kids Mode"] = "Mode Enfant",
        ["Music"] = "Musique",
        ["Stream Media"] = "Médias en ligne",
        ["Wireless"] = "Sans fil",
        ["Books"] = "Livres",
        ["Settings"] = "Paramètres",
        ["More"] = "Plus",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Fichiers",
        ["Artists"] = "Artistes",
        ["Albums"] = "Albums",
        ["Album Artist"] = "Artiste de l'album",
        ["Genres"] = "Genres",
        ["All Songs"] = "Tous les titres",
        ["Playlists"] = "Listes de lecture",
        ["Sound"] = "Son",
        ["Playback"] = "Lecture",
        ["Library"] = "Bibliothèque",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Minuterie de veille",
        ["Crossfade"] = "Fondu enchaîné",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Sans interruption",
        ["Remote control"] = "Contrôle à distance",
        ["Car mode"] = "Mode voiture",
        ["Plugin toggles"] = "Boutons des plugins",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Impossible de lire les paramètres du Mode Enfant ; les restrictions de sécurité sont actives",
        ["Unable to encode Kids Mode settings"] = "Impossible d'encoder les paramètres du Mode Enfant",
        ["Unable to save Kids Mode settings"] = "Impossible d'enregistrer les paramètres du Mode Enfant",
        ["This player cannot customize Home"] = "Ce lecteur ne peut pas personnaliser l'accueil",
        ["This player cannot customize Music menus"] = "Ce lecteur ne peut pas personnaliser les menus Musique",
        ["This player cannot customize the Quick Drawer"] = "Ce lecteur ne peut pas personnaliser le tiroir rapide",
        ["Update Compás to edit item order"] = "Mettez à jour Compás pour modifier l'ordre des éléments",
        ["Invalid item order"] = "Ordre des éléments invalide",
        ["Close and reopen this editor to discard the unsaved change"] = "Fermez et rouvrez cet éditeur pour annuler la modification non enregistrée",
        ["Close the current item editor before opening another"] = "Fermez l'éditeur actuel avant d'en ouvrir un autre",
        ["Unable to open this item editor"] = "Impossible d'ouvrir cet éditeur d'éléments",
        ["Enable Kids Mode"] = "Activer le Mode Enfant",
        ["Home items"] = "Éléments de l'accueil",
        ["Music menus"] = "Menus Musique",
        ["Music shortcuts"] = "Raccourcis Musique",
        ["Quick Drawer"] = "Tiroir rapide",
        ["Drawer EQ access"] = "Accès EQ du tiroir",
        ["Drawer volume access"] = "Accès volume du tiroir",
        ["Drawer items"] = "Éléments du tiroir",
        ["Change Parent PIN"] = "Modifier le code PIN parent",
        ["New Parent PIN (4+ digits)"] = "Nouveau PIN parent (4+ chiffres)",
        ["PIN must be at least 4 digits"] = "Le code PIN doit comporter au moins 4 chiffres",
        ["PIN updated"] = "Code PIN mis à jour",
        ["Unable to save PIN"] = "Impossible d'enregistrer le code PIN",
        ["Apply saved changes and reload UI"] = "Appliquer les modifications et recharger l'interface",
        ["About Kids Mode"] = "À propos du Mode Enfant",
        ["Kids Mode limits"] = "Limites du Mode Enfant",
        ["Kids Mode controls navigation only."] = "Le Mode Enfant contrôle uniquement la navigation.",
        ["Playback buttons and Now Playing remain available."] = "Les boutons de lecture et Lecture en cours restent disponibles.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Masquer des éléments du tiroir ne modifie ni le volume, ni le Wi-Fi, ni le Bluetooth, ni la radio, ni les minuteries.",
        ["Parent Mode"] = "Mode Parent",
        ["Disable Kids Mode"] = "Désactiver le Mode Enfant",
        ["Configure restrictions"] = "Configurer les restrictions",
        ["Close the current text entry before entering a PIN"] = "Fermez la saisie de texte en cours avant d'entrer un code PIN",
        ["Unable to open PIN entry"] = "Impossible d'ouvrir la saisie du code PIN",
        ["Parent PIN"] = "Code PIN parent",
        ["Incorrect PIN"] = "Code PIN incorrect",
    },
    it = {
        ["Kids Mode"] = "Modalità Bambini",
        ["Music"] = "Musica",
        ["Stream Media"] = "Streaming",
        ["Wireless"] = "Wireless",
        ["Books"] = "Libri",
        ["Settings"] = "Impostazioni",
        ["More"] = "Altro",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "File",
        ["Artists"] = "Artisti",
        ["Albums"] = "Album",
        ["Album Artist"] = "Artista album",
        ["Genres"] = "Generi",
        ["All Songs"] = "Tutti i brani",
        ["Playlists"] = "Playlist",
        ["Sound"] = "Suono",
        ["Playback"] = "Riproduzione",
        ["Library"] = "Libreria",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Timer spegnimento",
        ["Crossfade"] = "Dissolvenza incrociata",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Senza pause",
        ["Remote control"] = "Controllo remoto",
        ["Car mode"] = "Modalità auto",
        ["Plugin toggles"] = "Interruttori plugin",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Impossibile leggere le impostazioni della Modalità Bambini; sono attive le restrizioni di sicurezza",
        ["Unable to encode Kids Mode settings"] = "Impossibile codificare le impostazioni della Modalità Bambini",
        ["Unable to save Kids Mode settings"] = "Impossibile salvare le impostazioni della Modalità Bambini",
        ["This player cannot customize Home"] = "Questo lettore non può personalizzare la schermata Home",
        ["This player cannot customize Music menus"] = "Questo lettore non può personalizzare i menu Musica",
        ["This player cannot customize the Quick Drawer"] = "Questo lettore non può personalizzare il pannello rapido",
        ["Update Compás to edit item order"] = "Aggiorna Compás per modificare l'ordine degli elementi",
        ["Invalid item order"] = "Ordine degli elementi non valido",
        ["Close and reopen this editor to discard the unsaved change"] = "Chiudi e riapri questo editor per annullare la modifica non salvata",
        ["Close the current item editor before opening another"] = "Chiudi l'editor attuale prima di aprirne un altro",
        ["Unable to open this item editor"] = "Impossibile aprire questo editor di elementi",
        ["Enable Kids Mode"] = "Attiva Modalità Bambini",
        ["Home items"] = "Elementi Home",
        ["Music menus"] = "Menu Musica",
        ["Music shortcuts"] = "Scorciatoie Musica",
        ["Quick Drawer"] = "Pannello rapido",
        ["Drawer EQ access"] = "Accesso EQ nel pannello",
        ["Drawer volume access"] = "Accesso volume nel pannello",
        ["Drawer items"] = "Elementi del pannello",
        ["Change Parent PIN"] = "Cambia PIN genitori",
        ["New Parent PIN (4+ digits)"] = "Nuovo PIN genitori (4+ cifre)",
        ["PIN must be at least 4 digits"] = "Il PIN deve avere almeno 4 cifre",
        ["PIN updated"] = "PIN aggiornato",
        ["Unable to save PIN"] = "Impossibile salvare il PIN",
        ["Apply saved changes and reload UI"] = "Applica le modifiche salvate e ricarica l'interfaccia",
        ["About Kids Mode"] = "Info su Modalità Bambini",
        ["Kids Mode limits"] = "Limiti della Modalità Bambini",
        ["Kids Mode controls navigation only."] = "La Modalità Bambini controlla solo la navigazione.",
        ["Playback buttons and Now Playing remain available."] = "I pulsanti di riproduzione e In riproduzione restano disponibili.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Nascondere gli elementi del pannello non modifica volume, Wi-Fi, Bluetooth, radio o timer.",
        ["Parent Mode"] = "Modalità Genitori",
        ["Disable Kids Mode"] = "Disattiva Modalità Bambini",
        ["Configure restrictions"] = "Configura restrizioni",
        ["Close the current text entry before entering a PIN"] = "Chiudi l'inserimento di testo corrente prima di immettere un PIN",
        ["Unable to open PIN entry"] = "Impossibile aprire l'inserimento del PIN",
        ["Parent PIN"] = "PIN genitori",
        ["Incorrect PIN"] = "PIN errato",
    },
    ja = {
        ["Kids Mode"] = "キッズモード",
        ["Music"] = "音楽",
        ["Stream Media"] = "ストリーミング",
        ["Wireless"] = "ワイヤレス",
        ["Books"] = "ブック",
        ["Settings"] = "設定",
        ["More"] = "その他",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "ファイル",
        ["Artists"] = "アーティスト",
        ["Albums"] = "アルバム",
        ["Album Artist"] = "アルバムアーティスト",
        ["Genres"] = "ジャンル",
        ["All Songs"] = "すべての曲",
        ["Playlists"] = "プレイリスト",
        ["Sound"] = "サウンド",
        ["Playback"] = "再生",
        ["Library"] = "ライブラリ",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "スリープタイマー",
        ["Crossfade"] = "クロスフェード",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "ギャップレス",
        ["Remote control"] = "リモート操作",
        ["Car mode"] = "カーモード",
        ["Plugin toggles"] = "プラグイントグル",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "キッズモードの設定を読み込めませんでした。安全制限が有効です",
        ["Unable to encode Kids Mode settings"] = "キッズモードの設定をエンコードできません",
        ["Unable to save Kids Mode settings"] = "キッズモードの設定を保存できません",
        ["This player cannot customize Home"] = "このプレイヤーではホーム画面をカスタマイズできません",
        ["This player cannot customize Music menus"] = "このプレイヤーでは音楽メニューをカスタマイズできません",
        ["This player cannot customize the Quick Drawer"] = "このプレイヤーではクイックドロワーをカスタマイズできません",
        ["Update Compás to edit item order"] = "項目の並び順を編集するには Compás を更新してください",
        ["Invalid item order"] = "無効な項目の並び順です",
        ["Close and reopen this editor to discard the unsaved change"] = "未保存の変更を破棄するには、このエディタを閉じて再度開いてください",
        ["Close the current item editor before opening another"] = "別のエディタを開く前に現在の項目エディタを閉じてください",
        ["Unable to open this item editor"] = "この項目エディタを開けません",
        ["Enable Kids Mode"] = "キッズモードを有効化",
        ["Home items"] = "ホーム項目",
        ["Music menus"] = "音楽メニュー",
        ["Music shortcuts"] = "音楽ショートカット",
        ["Quick Drawer"] = "クイックドロワー",
        ["Drawer EQ access"] = "ドロワーの EQ アクセス",
        ["Drawer volume access"] = "ドロワーの音量アクセス",
        ["Drawer items"] = "ドロワー項目",
        ["Change Parent PIN"] = "保護者 PIN を変更",
        ["New Parent PIN (4+ digits)"] = "新しい保護者 PIN（4桁以上）",
        ["PIN must be at least 4 digits"] = "PIN は4桁以上で入力してください",
        ["PIN updated"] = "PIN を更新しました",
        ["Unable to save PIN"] = "PIN を保存できません",
        ["Apply saved changes and reload UI"] = "保存した変更を適用して UI を再読み込み",
        ["About Kids Mode"] = "キッズモードについて",
        ["Kids Mode limits"] = "キッズモードの制限",
        ["Kids Mode controls navigation only."] = "キッズモードはナビゲーションのみを制限します。",
        ["Playback buttons and Now Playing remain available."] = "再生ボタンと再生中画面は引き続き利用できます。",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "ドロワー項目を非表示にしても、音量、Wi-Fi、Bluetooth、ラジオ、タイマーは変更されません。",
        ["Parent Mode"] = "保護者モード",
        ["Disable Kids Mode"] = "キッズモードを無効化",
        ["Configure restrictions"] = "制限を設定",
        ["Close the current text entry before entering a PIN"] = "PIN を入力する前に現在のテキスト入力を閉じてください",
        ["Unable to open PIN entry"] = "PIN 入力を開けません",
        ["Parent PIN"] = "保護者 PIN",
        ["Incorrect PIN"] = "PIN が正しくありません",
    },
    nl = {
        ["Kids Mode"] = "Kindermodus",
        ["Music"] = "Muziek",
        ["Stream Media"] = "Media streamen",
        ["Wireless"] = "Draadloos",
        ["Books"] = "Boeken",
        ["Settings"] = "Instellingen",
        ["More"] = "Meer",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Bestanden",
        ["Artists"] = "Artiesten",
        ["Albums"] = "Albums",
        ["Album Artist"] = "Albumartiest",
        ["Genres"] = "Genres",
        ["All Songs"] = "Alle nummers",
        ["Playlists"] = "Afspeellijsten",
        ["Sound"] = "Geluid",
        ["Playback"] = "Afspelen",
        ["Library"] = "Bibliotheek",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Slaaptimer",
        ["Crossfade"] = "Crossfade",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Naadloos",
        ["Remote control"] = "Afstandsbediening",
        ["Car mode"] = "Automodus",
        ["Plugin toggles"] = "Plugin-schakelaars",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Kindermodus-instellingen konden niet worden gelezen; veilige beperkingen zijn actief",
        ["Unable to encode Kids Mode settings"] = "Kan Kindermodus-instellingen niet coderen",
        ["Unable to save Kids Mode settings"] = "Kan Kindermodus-instellingen niet opslaan",
        ["This player cannot customize Home"] = "Deze speler kan het startscherm niet aanpassen",
        ["This player cannot customize Music menus"] = "Deze speler kan muziekmenu's niet aanpassen",
        ["This player cannot customize the Quick Drawer"] = "Deze speler kan het snelmenu niet aanpassen",
        ["Update Compás to edit item order"] = "Werk Compás bij om de itemvolgorde te bewerken",
        ["Invalid item order"] = "Ongeldige itemvolgorde",
        ["Close and reopen this editor to discard the unsaved change"] = "Sluit en heropen deze editor om de niet-opgeslagen wijziging te verwerpen",
        ["Close the current item editor before opening another"] = "Sluit de huidige itemeditor voordat je een andere opent",
        ["Unable to open this item editor"] = "Kan deze itemeditor niet openen",
        ["Enable Kids Mode"] = "Kindermodus inschakelen",
        ["Home items"] = "Startscherm-items",
        ["Music menus"] = "Muziekmenu's",
        ["Music shortcuts"] = "Muzieksnelkoppelingen",
        ["Quick Drawer"] = "Snelmenu",
        ["Drawer EQ access"] = "EQ-toegang in snelmenu",
        ["Drawer volume access"] = "Volumetoegang in snelmenu",
        ["Drawer items"] = "Snelmenu-items",
        ["Change Parent PIN"] = "Ouder-PIN wijzigen",
        ["New Parent PIN (4+ digits)"] = "Nieuwe ouder-PIN (4+ cijfers)",
        ["PIN must be at least 4 digits"] = "PIN moet minimaal 4 cijfers bevatten",
        ["PIN updated"] = "PIN bijgewerkt",
        ["Unable to save PIN"] = "Kan PIN niet opslaan",
        ["Apply saved changes and reload UI"] = "Opgeslagen wijzigingen toepassen en interface herladen",
        ["About Kids Mode"] = "Over Kindermodus",
        ["Kids Mode limits"] = "Beperkingen van Kindermodus",
        ["Kids Mode controls navigation only."] = "Kindermodus beperkt alleen de navigatie.",
        ["Playback buttons and Now Playing remain available."] = "Afspeelknoppen en Nu afspelen blijven beschikbaar.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Het verbergen van snelmenu-items wijzigt het volume, Wi-Fi, Bluetooth, radio of timers niet.",
        ["Parent Mode"] = "Oudermodus",
        ["Disable Kids Mode"] = "Kindermodus uitschakelen",
        ["Configure restrictions"] = "Beperkingen configureren",
        ["Close the current text entry before entering a PIN"] = "Sluit de huidige tekstinvoer voordat je een PIN invoert",
        ["Unable to open PIN entry"] = "Kan PIN-invoer niet openen",
        ["Parent PIN"] = "Ouder-PIN",
        ["Incorrect PIN"] = "Onjuiste PIN",
    },
    pt = {
        ["Kids Mode"] = "Modo Infantil",
        ["Music"] = "Música",
        ["Stream Media"] = "Streaming",
        ["Wireless"] = "Sem fio",
        ["Books"] = "Livros",
        ["Settings"] = "Configurações",
        ["More"] = "Mais",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Arquivos",
        ["Artists"] = "Artistas",
        ["Albums"] = "Álbuns",
        ["Album Artist"] = "Artista do álbum",
        ["Genres"] = "Gêneros",
        ["All Songs"] = "Todas as músicas",
        ["Playlists"] = "Playlists",
        ["Sound"] = "Som",
        ["Playback"] = "Reprodução",
        ["Library"] = "Biblioteca",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Temporizador",
        ["Crossfade"] = "Crossfade",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Sem pausas",
        ["Remote control"] = "Controle remoto",
        ["Car mode"] = "Modo carro",
        ["Plugin toggles"] = "Botões de plugins",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Não foi possível ler as configurações do Modo Infantil; restrições seguras estão ativas",
        ["Unable to encode Kids Mode settings"] = "Não foi possível codificar as configurações do Modo Infantil",
        ["Unable to save Kids Mode settings"] = "Não foi possível salvar as configurações do Modo Infantil",
        ["This player cannot customize Home"] = "Este reprodutor não pode personalizar o Início",
        ["This player cannot customize Music menus"] = "Este reprodutor não pode personalizar os menus de Música",
        ["This player cannot customize the Quick Drawer"] = "Este reprodutor não pode personalizar o painel rápido",
        ["Update Compás to edit item order"] = "Atualize o Compás para editar a ordem dos itens",
        ["Invalid item order"] = "Ordem de itens inválida",
        ["Close and reopen this editor to discard the unsaved change"] = "Feche e reabra este editor para descartar a alteração não salva",
        ["Close the current item editor before opening another"] = "Feche o editor de itens atual antes de abrir outro",
        ["Unable to open this item editor"] = "Não foi possível abrir este editor de itens",
        ["Enable Kids Mode"] = "Ativar Modo Infantil",
        ["Home items"] = "Itens do Início",
        ["Music menus"] = "Menus de Música",
        ["Music shortcuts"] = "Atalhos de Música",
        ["Quick Drawer"] = "Painel rápido",
        ["Drawer EQ access"] = "Acesso ao EQ no painel",
        ["Drawer volume access"] = "Acesso ao volume no painel",
        ["Drawer items"] = "Itens do painel",
        ["Change Parent PIN"] = "Alterar PIN dos pais",
        ["New Parent PIN (4+ digits)"] = "Novo PIN dos pais (4+ dígitos)",
        ["PIN must be at least 4 digits"] = "O PIN deve ter pelo menos 4 dígitos",
        ["PIN updated"] = "PIN atualizado",
        ["Unable to save PIN"] = "Não foi possível salvar o PIN",
        ["Apply saved changes and reload UI"] = "Aplicar alterações salvas e recarregar a interface",
        ["About Kids Mode"] = "Sobre o Modo Infantil",
        ["Kids Mode limits"] = "Limites do Modo Infantil",
        ["Kids Mode controls navigation only."] = "O Modo Infantil controla apenas a navegação.",
        ["Playback buttons and Now Playing remain available."] = "Os botões de reprodução e Reproduzindo agora permanecem disponíveis.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Ocultar itens do painel não altera o volume, Wi-Fi, Bluetooth, rádio ou temporizadores.",
        ["Parent Mode"] = "Modo Pais",
        ["Disable Kids Mode"] = "Desativar Modo Infantil",
        ["Configure restrictions"] = "Configurar restrições",
        ["Close the current text entry before entering a PIN"] = "Feche a entrada de texto atual antes de digitar o PIN",
        ["Unable to open PIN entry"] = "Não foi possível abrir a entrada de PIN",
        ["Parent PIN"] = "PIN dos pais",
        ["Incorrect PIN"] = "PIN incorreto",
    },
    ru = {
        ["Kids Mode"] = "Детский режим",
        ["Music"] = "Музыка",
        ["Stream Media"] = "Потоковое медиа",
        ["Wireless"] = "Беспроводные сети",
        ["Books"] = "Книги",
        ["Settings"] = "Настройки",
        ["More"] = "Ещё",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Файлы",
        ["Artists"] = "Исполнители",
        ["Albums"] = "Альбомы",
        ["Album Artist"] = "Исполнитель альбома",
        ["Genres"] = "Жанры",
        ["All Songs"] = "Все песни",
        ["Playlists"] = "Плейлисты",
        ["Sound"] = "Звук",
        ["Playback"] = "Воспроизведение",
        ["Library"] = "Фонотека",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Таймер сна",
        ["Crossfade"] = "Кроссфейд",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Без пауз",
        ["Remote control"] = "Удалённое управление",
        ["Car mode"] = "Авторежим",
        ["Plugin toggles"] = "Переключатели плагинов",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Не удалось прочитать настройки Детского режима; действуют безопасные ограничения",
        ["Unable to encode Kids Mode settings"] = "Не удалось закодировать настройки Детского режима",
        ["Unable to save Kids Mode settings"] = "Не удалось сохранить настройки Детского режима",
        ["This player cannot customize Home"] = "Этот плеер не поддерживает настройку главного экрана",
        ["This player cannot customize Music menus"] = "Этот плеер не поддерживает настройку меню «Музыка»",
        ["This player cannot customize the Quick Drawer"] = "Этот плеер не поддерживает настройку шторки быстрого доступа",
        ["Update Compás to edit item order"] = "Обновите Compás, чтобы изменить порядок элементов",
        ["Invalid item order"] = "Некорректный порядок элементов",
        ["Close and reopen this editor to discard the unsaved change"] = "Закройте и снова откройте редактор, чтобы отменить несохранённое изменение",
        ["Close the current item editor before opening another"] = "Закройте текущий редактор элементов перед открытием другого",
        ["Unable to open this item editor"] = "Не удалось открыть редактор элементов",
        ["Enable Kids Mode"] = "Включить Детский режим",
        ["Home items"] = "Элементы главного экрана",
        ["Music menus"] = "Меню «Музыка»",
        ["Music shortcuts"] = "Быстрые кнопки в «Музыке»",
        ["Quick Drawer"] = "Быстрая шторка",
        ["Drawer EQ access"] = "Доступ к EQ в шторке",
        ["Drawer volume access"] = "Доступ к громкости в шторке",
        ["Drawer items"] = "Элементы шторки",
        ["Change Parent PIN"] = "Изменить родительский PIN",
        ["New Parent PIN (4+ digits)"] = "Новый родительский PIN (от 4 цифр)",
        ["PIN must be at least 4 digits"] = "PIN должен содержать не менее 4 цифр",
        ["PIN updated"] = "PIN обновлён",
        ["Unable to save PIN"] = "Не удалось сохранить PIN",
        ["Apply saved changes and reload UI"] = "Применить изменения и перезагрузить интерфейс",
        ["About Kids Mode"] = "О Детском режиме",
        ["Kids Mode limits"] = "Ограничения Детского режима",
        ["Kids Mode controls navigation only."] = "Детский режим ограничивает только навигацию.",
        ["Playback buttons and Now Playing remain available."] = "Кнопки воспроизведения и экран «Сейчас играет» остаются доступны.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Скрытие элементов шторки не меняет громкость, Wi-Fi, Bluetooth, радио или таймеры.",
        ["Parent Mode"] = "Родительский режим",
        ["Disable Kids Mode"] = "Выключить Детский режим",
        ["Configure restrictions"] = "Настроить ограничения",
        ["Close the current text entry before entering a PIN"] = "Закройте текущий ввод текста перед вводом PIN",
        ["Unable to open PIN entry"] = "Не удалось открыть ввод PIN",
        ["Parent PIN"] = "Родительский PIN",
        ["Incorrect PIN"] = "Неверный PIN",
    },
    uk = {
        ["Kids Mode"] = "Дитячий режим",
        ["Music"] = "Музика",
        ["Stream Media"] = "Потокове медіа",
        ["Wireless"] = "Бездротові мережі",
        ["Books"] = "Книги",
        ["Settings"] = "Налаштування",
        ["More"] = "Ще",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Файли",
        ["Artists"] = "Виконавці",
        ["Albums"] = "Альбоми",
        ["Album Artist"] = "Виконавець альбому",
        ["Genres"] = "Жанри",
        ["All Songs"] = "Усі пісні",
        ["Playlists"] = "Списки відтворення",
        ["Sound"] = "Звук",
        ["Playback"] = "Відтворення",
        ["Library"] = "Медіатека",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Таймер сну",
        ["Crossfade"] = "Кросфейд",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Без пауз",
        ["Remote control"] = "Дистанційне керування",
        ["Car mode"] = "Авторежим",
        ["Plugin toggles"] = "Перемикачі плагінів",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Не вдалося прочитати налаштування Дитячого режиму; діють безпечні обмеження",
        ["Unable to encode Kids Mode settings"] = "Не вдалося закодувати налаштування Дитячого режиму",
        ["Unable to save Kids Mode settings"] = "Не вдалося зберегти налаштування Дитячого режиму",
        ["This player cannot customize Home"] = "Цей плеєр не підтримує налаштування головного екрана",
        ["This player cannot customize Music menus"] = "Цей плеєр не підтримує налаштування меню «Музика»",
        ["This player cannot customize the Quick Drawer"] = "Цей плеєр не підтримує налаштування швидкої шторки",
        ["Update Compás to edit item order"] = "Оновіть Compás, щоб змінити порядок елементів",
        ["Invalid item order"] = "Некоректний порядок елементів",
        ["Close and reopen this editor to discard the unsaved change"] = "Закрийте і знову відкрийте редактор, щоб скасувати незбережену зміну",
        ["Close the current item editor before opening another"] = "Закрийте поточний редактор елементів перед відкриттям іншого",
        ["Unable to open this item editor"] = "Не вдалося відкрити редактор елементів",
        ["Enable Kids Mode"] = "Увімкнути Дитячий режим",
        ["Home items"] = "Елементи головного екрана",
        ["Music menus"] = "Меню «Музика»",
        ["Music shortcuts"] = "Швидкі кнопки в «Музиці»",
        ["Quick Drawer"] = "Швидка шторка",
        ["Drawer EQ access"] = "Доступ до EQ у шторці",
        ["Drawer volume access"] = "Доступ до гучності у шторці",
        ["Drawer items"] = "Елементи шторки",
        ["Change Parent PIN"] = "Змінити батьківський PIN",
        ["New Parent PIN (4+ digits)"] = "Новий батьківський PIN (від 4 цифр)",
        ["PIN must be at least 4 digits"] = "PIN має містити щонайменше 4 цифри",
        ["PIN updated"] = "PIN оновлено",
        ["Unable to save PIN"] = "Не вдалося зберегти PIN",
        ["Apply saved changes and reload UI"] = "Застосувати збережені зміни та перезавантажити інтерфейс",
        ["About Kids Mode"] = "Про Дитячий режим",
        ["Kids Mode limits"] = "Обмеження Дитячого режиму",
        ["Kids Mode controls navigation only."] = "Дитячий режим обмежує лише навігацію.",
        ["Playback buttons and Now Playing remain available."] = "Кнопки відтворення та екран «Зараз грає» залишаються доступними.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Приховування елементів шторки не змінює гучність, Wi-Fi, Bluetooth, радіо чи таймери.",
        ["Parent Mode"] = "Батьківський режим",
        ["Disable Kids Mode"] = "Вимкнути Дитячий режим",
        ["Configure restrictions"] = "Налаштувати обмеження",
        ["Close the current text entry before entering a PIN"] = "Закрийте поточне введення тексту перед введенням PIN",
        ["Unable to open PIN entry"] = "Не вдалося відкрити введення PIN",
        ["Parent PIN"] = "Батьківський PIN",
        ["Incorrect PIN"] = "Неправильний PIN",
    },
    vi = {
        ["Kids Mode"] = "Chế độ Trẻ em",
        ["Music"] = "Nhạc",
        ["Stream Media"] = "Phát trực tuyến",
        ["Wireless"] = "Không dây",
        ["Books"] = "Sách",
        ["Settings"] = "Cài đặt",
        ["More"] = "Thêm",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "Tệp",
        ["Artists"] = "Nghệ sĩ",
        ["Albums"] = "Album",
        ["Album Artist"] = "Nghệ sĩ album",
        ["Genres"] = "Thể loại",
        ["All Songs"] = "Tất cả bài hát",
        ["Playlists"] = "Danh sách phát",
        ["Sound"] = "Âm thanh",
        ["Playback"] = "Phát nhạc",
        ["Library"] = "Thư viện",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "Hẹn giờ tắt",
        ["Crossfade"] = "Chuyển mượt",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "Phát liền mạch",
        ["Remote control"] = "Điều khiển từ xa",
        ["Car mode"] = "Chế độ ô tô",
        ["Plugin toggles"] = "Nút bật/tắt plugin",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "Không đọc được cài đặt Chế độ Trẻ em; các giới hạn an toàn đang bật",
        ["Unable to encode Kids Mode settings"] = "Không thể mã hóa cài đặt Chế độ Trẻ em",
        ["Unable to save Kids Mode settings"] = "Không thể lưu cài đặt Chế độ Trẻ em",
        ["This player cannot customize Home"] = "Trình phát này không thể tùy chỉnh Màn hình chính",
        ["This player cannot customize Music menus"] = "Trình phát này không thể tùy chỉnh menu Nhạc",
        ["This player cannot customize the Quick Drawer"] = "Trình phát này không thể tùy chỉnh ngăn kéo nhanh",
        ["Update Compás to edit item order"] = "Hãy cập nhật Compás để sửa thứ tự mục",
        ["Invalid item order"] = "Thứ tự mục không hợp lệ",
        ["Close and reopen this editor to discard the unsaved change"] = "Đóng và mở lại trình sửa này để hủy thay đổi chưa lưu",
        ["Close the current item editor before opening another"] = "Hãy đóng trình sửa mục hiện tại trước khi mở trình sửa khác",
        ["Unable to open this item editor"] = "Không thể mở trình sửa mục này",
        ["Enable Kids Mode"] = "Bật Chế độ Trẻ em",
        ["Home items"] = "Mục trên Màn hình chính",
        ["Music menus"] = "Menu Nhạc",
        ["Music shortcuts"] = "Lối tắt Nhạc",
        ["Quick Drawer"] = "Ngăn kéo nhanh",
        ["Drawer EQ access"] = "Quyền mở EQ ở ngăn kéo",
        ["Drawer volume access"] = "Quyền chỉnh âm lượng ở ngăn kéo",
        ["Drawer items"] = "Mục trong ngăn kéo",
        ["Change Parent PIN"] = "Đổi mã PIN Phụ huynh",
        ["New Parent PIN (4+ digits)"] = "Mã PIN Phụ huynh mới (4+ chữ số)",
        ["PIN must be at least 4 digits"] = "Mã PIN phải có ít nhất 4 chữ số",
        ["PIN updated"] = "Đã cập nhật mã PIN",
        ["Unable to save PIN"] = "Không thể lưu mã PIN",
        ["Apply saved changes and reload UI"] = "Áp dụng thay đổi đã lưu và tải lại giao diện",
        ["About Kids Mode"] = "Giới thiệu về Chế độ Trẻ em",
        ["Kids Mode limits"] = "Giới hạn của Chế độ Trẻ em",
        ["Kids Mode controls navigation only."] = "Chế độ Trẻ em chỉ giới hạn điều hướng.",
        ["Playback buttons and Now Playing remain available."] = "Các nút phát nhạc và màn hình Đang phát vẫn khả dụng.",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "Ẩn các mục trong ngăn kéo không làm thay đổi âm lượng, Wi-Fi, Bluetooth, radio hay hẹn giờ.",
        ["Parent Mode"] = "Chế độ Phụ huynh",
        ["Disable Kids Mode"] = "Tắt Chế độ Trẻ em",
        ["Configure restrictions"] = "Cấu hình giới hạn",
        ["Close the current text entry before entering a PIN"] = "Hãy đóng ô nhập văn bản hiện tại trước khi nhập mã PIN",
        ["Unable to open PIN entry"] = "Không thể mở ô nhập mã PIN",
        ["Parent PIN"] = "Mã PIN Phụ huynh",
        ["Incorrect PIN"] = "Mã PIN không đúng",
    },
    zh_CN = {
        ["Kids Mode"] = "儿童模式",
        ["Music"] = "音乐",
        ["Stream Media"] = "流媒体",
        ["Wireless"] = "无线",
        ["Books"] = "图书",
        ["Settings"] = "设置",
        ["More"] = "更多",
        ["Subsonic"] = "Subsonic",
        ["Files"] = "文件",
        ["Artists"] = "艺术家",
        ["Albums"] = "专辑",
        ["Album Artist"] = "专辑艺术家",
        ["Genres"] = "流派",
        ["All Songs"] = "所有歌曲",
        ["Playlists"] = "播放列表",
        ["Sound"] = "声音",
        ["Playback"] = "播放",
        ["Library"] = "媒体库",
        ["Wi-Fi"] = "Wi-Fi",
        ["Bluetooth"] = "Bluetooth",
        ["Sleep timer"] = "睡眠定时器",
        ["Crossfade"] = "淡入淡出",
        ["AirPlay"] = "AirPlay",
        ["DLNA"] = "DLNA",
        ["Gapless"] = "无缝播放",
        ["Remote control"] = "远程控制",
        ["Car mode"] = "车载模式",
        ["Plugin toggles"] = "插件开关",
        ["Kids Mode settings could not be read; safe restrictions are active"] = "无法读取儿童模式设置；已启用安全限制",
        ["Unable to encode Kids Mode settings"] = "无法编码儿童模式设置",
        ["Unable to save Kids Mode settings"] = "无法保存儿童模式设置",
        ["This player cannot customize Home"] = "此播放器无法自定义主屏幕",
        ["This player cannot customize Music menus"] = "此播放器无法自定义音乐菜单",
        ["This player cannot customize the Quick Drawer"] = "此播放器无法自定义快捷抽屉",
        ["Update Compás to edit item order"] = "请更新 Compás 以编辑项目顺序",
        ["Invalid item order"] = "无效的项目顺序",
        ["Close and reopen this editor to discard the unsaved change"] = "请关闭并重新打开此编辑器以放弃未保存的更改",
        ["Close the current item editor before opening another"] = "打开另一个项目编辑器前请先关闭当前编辑器",
        ["Unable to open this item editor"] = "无法打开此项目编辑器",
        ["Enable Kids Mode"] = "启用儿童模式",
        ["Home items"] = "主屏幕项目",
        ["Music menus"] = "音乐菜单",
        ["Music shortcuts"] = "音乐快捷方式",
        ["Quick Drawer"] = "快捷抽屉",
        ["Drawer EQ access"] = "抽屉 EQ 访问",
        ["Drawer volume access"] = "抽屉音量访问",
        ["Drawer items"] = "抽屉项目",
        ["Change Parent PIN"] = "更改家长 PIN 码",
        ["New Parent PIN (4+ digits)"] = "新家长 PIN 码（至少 4 位数字）",
        ["PIN must be at least 4 digits"] = "PIN 码必须至少为 4 位数字",
        ["PIN updated"] = "PIN 码已更新",
        ["Unable to save PIN"] = "无法保存 PIN 码",
        ["Apply saved changes and reload UI"] = "应用已保存的更改并重新加载界面",
        ["About Kids Mode"] = "关于儿童模式",
        ["Kids Mode limits"] = "儿童模式限制",
        ["Kids Mode controls navigation only."] = "儿童模式仅控制导航菜单。",
        ["Playback buttons and Now Playing remain available."] = "播放按钮和正在播放界面仍然可用。",
        ["Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."] = "隐藏抽屉项目不会更改音量、Wi-Fi、Bluetooth、收音机或定时器。",
        ["Parent Mode"] = "家长模式",
        ["Disable Kids Mode"] = "禁用儿童模式",
        ["Configure restrictions"] = "配置限制",
        ["Close the current text entry before entering a PIN"] = "输入 PIN 码前请先关闭当前文本输入",
        ["Unable to open PIN entry"] = "无法打开 PIN 码输入",
        ["Parent PIN"] = "家长 PIN 码",
        ["Incorrect PIN"] = "PIN 码不正确",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- Kids Mode narrows navigation. It does not lock the device: playback
-- controls and Now Playing remain available, and hidden controls are not
-- switched off.

local CONFIG_KEY = "settings_v1"
local HOME_KEYS = {
    { key = "music", label = "Music" },
    { key = "stream_media", label = "Stream Media" },
    { key = "wireless", label = "Wireless" },
    { key = "books", label = "Books" },
    { key = "settings", label = "Settings" },
    { key = "dac", label = "More" },
    { key = "subsonic", label = "Subsonic" },
}
local MUSIC_KEYS = {
    { key = "files", label = "Files" },
    { key = "artists", label = "Artists" },
    { key = "albums", label = "Albums" },
    { key = "album_artist", label = "Album Artist" },
    { key = "genres", label = "Genres" },
    { key = "all_songs", label = "All Songs" },
    { key = "playlists", label = "Playlists" },
}
local SHORTCUT_KEYS = {
    { key = "sound", label = "Sound" },
    { key = "playback", label = "Playback" },
    { key = "library", label = "Library" },
}
local DRAWER_KEYS = {
    { key = "wifi", label = "Wi-Fi" },
    { key = "bluetooth", label = "Bluetooth" },
    { key = "sleep", label = "Sleep timer" },
    { key = "crossfade", label = "Crossfade" },
    { key = "airplay", label = "AirPlay" },
    { key = "dlna", label = "DLNA" },
    { key = "gapless", label = "Gapless" },
    { key = "remote_control", label = "Remote control" },
    { key = "car_mode", label = "Car mode" },
    { key = "plugins", label = "Plugin toggles" },
}

local function defaults()
    return {
        enabled = false,
        home = { "music", "books" },
        home_order = { "music", "stream_media", "wireless", "books", "settings", "dac", "subsonic" },
        music = { "files", "artists", "albums", "album_artist", "genres", "all_songs", "playlists" },
        music_order = { "files", "artists", "albums", "album_artist", "genres", "all_songs", "playlists" },
        shortcuts = {},
        shortcuts_order = { "sound", "playback", "library" },
        drawer_enabled = false,
        drawer_eq_visible = true,
        drawer_volume_visible = true,
        drawer = { "wifi", "bluetooth", "sleep", "crossfade", "airplay", "dlna", "gapless",
            "remote_control", "car_mode", "plugins" },
        drawer_order = { "wifi", "bluetooth", "sleep", "crossfade", "airplay", "dlna", "gapless",
            "remote_control", "car_mode", "plugins" },
    }
end

local function valid_order(value, choices)
    if type(value) ~= "table" then return nil end
    local allowed, seen, result = {}, {}, {}
    for _, item in ipairs(choices) do allowed[item.key] = true end
    for _, key in ipairs(value) do
        if type(key) ~= "string" or not allowed[key] or seen[key] then return nil end
        seen[key] = true
        result[#result + 1] = key
    end
    return result
end

local function complete_order(value, visible_order, choices)
    local full = valid_order(value, choices)
    if full and #full == #choices then return full end

    local result, seen = {}, {}
    local visible = valid_order(visible_order, choices) or {}
    for _, key in ipairs(visible) do
        result[#result + 1] = key
        seen[key] = true
    end
    for _, item in ipairs(choices) do
        if not seen[item.key] then result[#result + 1] = item.key end
    end
    return result
end

local function normalize(raw, legacy_enabled)
    local cfg = defaults()
    if type(raw) ~= "table" then
        cfg.enabled = legacy_enabled
        return cfg
    end
    cfg.enabled = raw.enabled == true
    cfg.home = valid_order(raw.home, HOME_KEYS) or cfg.home
    cfg.home_order = complete_order(raw.home_order, cfg.home, HOME_KEYS)
    cfg.music = valid_order(raw.music, MUSIC_KEYS) or cfg.music
    cfg.music_order = complete_order(raw.music_order, cfg.music, MUSIC_KEYS)
    cfg.shortcuts = valid_order(raw.shortcuts, SHORTCUT_KEYS) or cfg.shortcuts
    cfg.shortcuts_order = complete_order(raw.shortcuts_order, cfg.shortcuts, SHORTCUT_KEYS)
    cfg.drawer_enabled = raw.drawer_enabled == true
    if type(raw.drawer_eq_visible) == "boolean" then cfg.drawer_eq_visible = raw.drawer_eq_visible end
    if type(raw.drawer_volume_visible) == "boolean" then cfg.drawer_volume_visible = raw.drawer_volume_visible end
    cfg.drawer = valid_order(raw.drawer, DRAWER_KEYS) or cfg.drawer
    cfg.drawer_order = complete_order(raw.drawer_order, cfg.drawer, DRAWER_KEYS)
    return cfg
end

local function read_config()
    local raw = plugin.storage.get(CONFIG_KEY)
    local legacy_enabled = plugin.storage.get("enabled", "0") == "1"
    if not raw or raw == "" then return normalize(nil, legacy_enabled) end
    local decoded = select(1, plugin.json_decode(raw))
    if type(decoded) ~= "table" then
        local cfg = defaults()
        cfg.enabled = true
        plugin.show_toast(tr("Kids Mode settings could not be read; safe restrictions are active"))
        return cfg
    end
    return normalize(decoded, legacy_enabled)
end

local config = read_config()
local pin = plugin.secrets.get("pin") or "1234"

local function clone_config(source)
    local out = {
        enabled = source.enabled,
        home = {}, home_order = {}, music = {}, music_order = {},
        shortcuts = {}, shortcuts_order = {}, drawer = {}, drawer_order = {},
        drawer_enabled = source.drawer_enabled,
        drawer_eq_visible = source.drawer_eq_visible,
        drawer_volume_visible = source.drawer_volume_visible,
    }
    for _, key in ipairs(source.home) do out.home[#out.home + 1] = key end
    for _, key in ipairs(source.home_order) do out.home_order[#out.home_order + 1] = key end
    for _, key in ipairs(source.music) do out.music[#out.music + 1] = key end
    for _, key in ipairs(source.music_order) do out.music_order[#out.music_order + 1] = key end
    for _, key in ipairs(source.shortcuts) do out.shortcuts[#out.shortcuts + 1] = key end
    for _, key in ipairs(source.shortcuts_order) do out.shortcuts_order[#out.shortcuts_order + 1] = key end
    for _, key in ipairs(source.drawer) do out.drawer[#out.drawer + 1] = key end
    for _, key in ipairs(source.drawer_order) do out.drawer_order[#out.drawer_order + 1] = key end
    return out
end

local function save_config(candidate)
    local ok_encode, encoded = pcall(plugin.json_encode, candidate)
    if not ok_encode or type(encoded) ~= "string" then
        plugin.show_toast(tr("Unable to encode Kids Mode settings"))
        return false
    end
    local ok_save, saved = pcall(plugin.storage.set, CONFIG_KEY, encoded)
    if not ok_save or saved ~= true then
        plugin.show_toast(tr("Unable to save Kids Mode settings"))
        return false
    end
    config = candidate
    -- settings_v1 is now authoritative. Remove the compatibility flag so a
    -- later downgrade does not resurrect an old enabled state.
    pcall(plugin.storage.delete, "enabled")
    return true
end

local function set_config_field(field, value)
    local candidate = clone_config(config)
    candidate[field] = value
    return save_config(candidate)
end

local function set_order_config(field, order_field, visible_order, full_order)
    local candidate = clone_config(config)
    candidate[field] = visible_order
    candidate[order_field] = full_order
    return save_config(candidate)
end

local function apply_layout()
    if not config.enabled then return end

    local home_order = {}
    for _, key in ipairs(config.home) do home_order[#home_order + 1] = key end
    -- Recovery is deliberately outside the editable list and always last.
    home_order[#home_order + 1] = "kids_parent"
    if plugin.has_capability("ui.home_layout") then
        plugin.set_home_layout({
            { key = "kids_parent" }, -- the theme's own tile, like every other
        }, { mode = #home_order > 6 and "list" or "tile", tile_gap = 24, order = home_order })
    else
        plugin.show_toast(tr("This player cannot customize Home"))
    end

    if plugin.has_capability("ui.music_layout") then
        plugin.set_music_layout({ order = config.music, toolbar = config.shortcuts })
    else
        plugin.show_toast(tr("This player cannot customize Music menus"))
    end

    if plugin.has_capability("ui.quick_drawer_layout") then
        plugin.set_quick_drawer_layout({
            enabled = config.drawer_enabled,
            order = config.drawer,
            eq_visible = config.drawer_eq_visible,
            volume_visible = config.drawer_volume_visible,
        })
    else
        plugin.show_toast(tr("This player cannot customize the Quick Drawer"))
    end
end

local request_text_input

local function show_settings()
    local function editor_row(label, items, field, order_field)
        return { type = "row", label = label, on_select = function()
            if not plugin.has_capability("ui.order_editor")
                    or type(plugin.show_order_editor) ~= "function" then
                plugin.show_toast(tr("Update Compás to edit item order"))
                return
            end
            local ordered = {}
            local enabled_keys = {}
            for _, key in ipairs(config[field]) do enabled_keys[key] = true end
            local item_by_key = {}
            for _, item in ipairs(items) do item_by_key[item.key] = item end
            -- Keep the complete order, including hidden entries, so a drag
            -- remains in place when an item is hidden and later restored.
            for _, key in ipairs(config[order_field]) do
                local item = item_by_key[key]
                if item then
                    ordered[#ordered + 1] = { key = item.key, label = tr(item.label),
                        visible = enabled_keys[item.key] == true }
                end
            end
            local ok, err = pcall(plugin.show_order_editor, label, ordered, function(changed)
                if type(changed) ~= "table" then return end
                local next_order, next_visible, seen = {}, {}, {}
                for _, entry in ipairs(changed) do
                    if type(entry) ~= "table" or type(entry.key) ~= "string"
                            or type(entry.visible) ~= "boolean" or seen[entry.key] then
                        plugin.show_toast(tr("Invalid item order"))
                        return
                    end
                    seen[entry.key] = true
                    next_order[#next_order + 1] = entry.key
                    if entry.visible then next_visible[#next_visible + 1] = entry.key end
                end
                -- Reject partial or foreign editor responses before saving.
                if #changed ~= #items then
                    plugin.show_toast(tr("Invalid item order"))
                    return
                end
                for _, item in ipairs(items) do
                    if not seen[item.key] then
                        plugin.show_toast(tr("Invalid item order"))
                        return
                    end
                end
                if not set_order_config(field, order_field, next_visible, next_order) then
                    plugin.show_toast(tr("Close and reopen this editor to discard the unsaved change"))
                end
            end)
            if not ok then
                local message = tostring(err or "")
                if message:find("already open", 1, true) then
                    plugin.show_toast(tr("Close the current item editor before opening another"))
                else
                    plugin.show_toast(tr("Unable to open this item editor"))
                end
            end
        end }
    end

    plugin.show_settings_list(tr("Kids Mode"), {
        { type = "toggle", label = tr("Enable Kids Mode"), value = config.enabled, on_change = function(value)
            local candidate = clone_config(config)
            candidate.enabled = value
            if save_config(candidate) then plugin.reload_ui() end
        end },
        editor_row(tr("Home items"), HOME_KEYS, "home", "home_order"),
        editor_row(tr("Music menus"), MUSIC_KEYS, "music", "music_order"),
        editor_row(tr("Music shortcuts"), SHORTCUT_KEYS, "shortcuts", "shortcuts_order"),
        { type = "toggle", label = tr("Quick Drawer"), value = config.drawer_enabled, on_change = function(value)
            set_config_field("drawer_enabled", value)
        end },
        { type = "toggle", label = tr("Drawer EQ access"), value = config.drawer_eq_visible, on_change = function(value)
            set_config_field("drawer_eq_visible", value)
        end },
        { type = "toggle", label = tr("Drawer volume access"), value = config.drawer_volume_visible, on_change = function(value)
            set_config_field("drawer_volume_visible", value)
        end },
        editor_row(tr("Drawer items"), DRAWER_KEYS, "drawer", "drawer_order"),
        { type = "row", label = tr("Change Parent PIN"), on_select = function()
            request_text_input(tr("New Parent PIN (4+ digits)"), function(text)
                if text == nil then return end
                if not text:match("^%d%d%d%d+$") then
                    plugin.show_toast(tr("PIN must be at least 4 digits"))
                    return
                end
                local ok, saved = pcall(plugin.secrets.set, "pin", text)
                if ok and saved == true then
                    pin = text
                    plugin.show_toast(tr("PIN updated"))
                else
                    plugin.show_toast(tr("Unable to save PIN"))
                end
            end)
        end },
        { type = "row", label = tr("Apply saved changes and reload UI"), on_select = function()
            plugin.reload_ui()
        end },
        { type = "row", label = tr("About Kids Mode"), on_select = function()
            plugin.show_list(tr("Kids Mode limits"), {
                tr("Kids Mode controls navigation only."),
                tr("Playback buttons and Now Playing remain available."),
                tr("Hiding drawer items does not change volume, Wi-Fi, Bluetooth, radio, or timers."),
            }, function() end)
        end },
    })
end

local function show_parent_menu()
    plugin.show_list(tr("Parent Mode"), { tr("Disable Kids Mode"), tr("Configure restrictions") }, function(index)
        if index == 1 then
            local candidate = clone_config(config)
            candidate.enabled = false
            if save_config(candidate) then plugin.reload_ui() end
        elseif index == 2 then
            show_settings()
        end
    end)
end

request_text_input = function(title, on_submit)
    local ok, opened, reason = pcall(plugin.show_text_input, title, "", true, on_submit)
    if not ok or opened ~= true then
        if reason == "text input busy" then
            plugin.show_toast(tr("Close the current text entry before entering a PIN"))
        else
            plugin.show_toast(tr("Unable to open PIN entry"))
        end
    end
end

local function prompt_parent_pin()
    request_text_input(tr("Parent PIN"), function(text)
        if text == nil then return end
        if text == pin then
            show_parent_menu()
        else
            plugin.show_toast(tr("Incorrect PIN"))
        end
    end)
end

plugin.register_home_tile("kids_parent", tr("Parent Mode"), prompt_parent_pin, "launcher/sys_set.png")

plugin.register_list_item("settings", tr("Kids Mode"), function()
    if config.enabled then prompt_parent_pin() else show_settings() end
end)

apply_layout()
