﻿import flash.text.Font;

var embeddedFontsArray:Array = Font.enumerateFonts(false);

//pref = new Object();
with(Preferences) {
	pref.myFont = embeddedFontsArray[0].fontName;
	
	pref.lng = "en";
	pref.autostop = true;
	pref.myLoop = false;
	pref.fpMenu = true;
	pref.forward = true;
	pref.fullscreenBtn = true;
	pref.ss_time = 3000;
	pref.resizza_onoff = true;
	pref.centra_onoff = true;
	pref.toolbarBottom = false;
	pref.btnSelLabel = true;
	pref.trackID = "UA-8844617-7";
	pref.trackPageviewPrefix = "/playerEmbedTrack.htm?param=";
	pref.logoAlt = "FLxER.net\nwww.flxer.net";
	pref.logoURL = "http://www.flxer.net"
	pref.thw = 128;
	pref.thh = 96;
	pref.testaH = 19;
	pref.testaY = 0;
	pref.thumbnail = "http://www.vjtelevision.com/_images/defaultBig.jpg";
	pref.txtSwfReader = "http://www.flxer.net/_fp/reader.swf";
	pref.policyFile = "";
	pref.downPath = "";
	pref.embedPath = "http://www.vjtelevision.com/_swf/vjtv.swf";
	pref.endpPath = "";
	pref.myViPath = "";
	//
	pref.thumbSaver = false;
	pref.fpUpPath = "/_fp/fpUp.php";
	pref.fpUpJsOk = "writeSnapshotOk";
	pref.fpUpJsError="writeEncodingMessage";
	
	// TEXTS COLORS //
	pref.txtCol = "0xFFFFFF";
	pref.txtColOver = "0x0000FF";
	
	// TOOLBAR COLORS //
	pref.toolbarHead = "0x333333";
	pref.toolbarHeadTxt = "0xFFFFFF";
	pref.toolbarBorder = "0x333333";
	pref.toolbarBackground = "0x333333";
	
	// BUTTONS COLORS //
	pref.btnBorder = "0x000000";
	pref.btnBorderOver = "0x990000";
	pref.btnBkg = "0x000000";
	pref.btnBkgOver = "0x990000";
	pref.btnSimb = "0xFFFFFF";
	pref.btnSimbOver = "0xFFFFFF";
	
	// PLAYER COLOR //
	pref.playerBackground = "square";   /* "square" QUADRATINI */
	
	// PLAYLISTS COLORS //
	pref.playlistThumbnailsOverColor = "0xFF0000";
	
	// ALT COLORS //
	pref.altBorder = "0xFFFFFF";
	pref.altBkg = "0x000000";
	
	// EMBED //
	pref.embedTitle = "FLxER.net";
	pref.embedPartner = "938991";
	pref.embedWidth = 300;
	pref.embedHeight = 250;
	pref.CID = "FLxER";
	
	//
	
	/* TOOLBAR */
	pref.toolBarPaddingLR = 5;
	pref.deltaT = 5; /* DELTA ALLUNGAMENTO CELLA TESTO */
	pref.deltaCounter = 10;
	
	// LABELS //
	pref.lab = new Array();
	
	pref.lab["de"] = {
		ssLabel      : "Diashow",
		ssLabelNoImg : "Diashow (keine Bilder)",
		pLabel       : "Playlist",
		fitLabel     : "Maßstab: Player Größe",
		noscLabel    : "Maßstab: 100%",
		fsLabel      : "FULLSCREEN",
		dwLabel      : "Download",
		emLabel      : "Embed",
		mLabel       : "Menü",
		sLabel       : "+SHARE",
		sAlt         : "Share this content",
		menuAlt      : "Im Menü Optionen",
		fsAlt        : "Fullscreen-Modus",
		fwAlt        : "Gehen Sie nach vorn (Pfeil rechts)",
		rwAlt        : "Rewind (Pfeil links)",
		playpauseAlt : "Stop/Play (Leertaste)",
		cursAlt      : "scratch",
		volumeAlt    : "Stellen Sie Lautstärke",
		embClose     : "Fenster schließen",
		ppBigAlt     : "Starten Sie jetzt",
		pageDn       : "Gehe zur vorherigen Seite",
		pageUp       : "Gehen Sie weiter zur nächsten Seite",
		pageDett     : "Detail page",
		otherContents : "Weitere Produkte des Anbieters",
		playAgain    : "Wiederholen",
		sendToFriends: "Send to a friend",
		buyNow       : "Jetzt kaufen",
		sendToFriendsAlt: "Weiterleiten",
		buyNowAlt    : "Jetzt kaufen",
		saveShot     : "Save image",
		delShot      : "Delete image"
	}
	pref.lab["en"] = {
		ssLabel      : "Slideshow",
		ssLabelNoImg : "Slideshow (no images)",
		pLabel       : "Playlist",
		fitLabel     : "Scale: Fit player size",
		noscLabel    : "Scale: 100%",
		fsLabel      : "FULLSCREEN",
		dwLabel      : "Download",
		emLabel      : "Embed",
		mLabel       : "MENU",
		sLabel       : "+SHARE",
		sAlt         : "Share this content",
		menuAlt      : "Show menu options",
		fsAlt        : "Fullscreen mode",
		fwAlt        : "Go forward (arrow right)",
		rwAlt        : "Rewind (arrow left)",
		playpauseAlt : "Stop/Play (space bar)",
		cursAlt      : "scratch",
		volumeAlt    : "Set audio volume",
		embClose     : "close window",
		ppBigAlt     : "Start now",
		pageDn       : "Go to previous page",
		pageUp       : "Go to next page",
		pageDett     : "Go to page",
		otherContents : "Related contents",
		playAgain    : "Play again this video",
		sendToFriends: "Share with friends",
		buyNow       : "DOWNLOAD",
		sendToFriendsAlt: "Share this item with friends",
		buyNowAlt    : "Download this item now",
		saveShot     : "Save image",
		delShot      : "Delete image"
	}
	pref.lab["it"] = {
		ssLabel      : "Slideshow",
		ssLabelNoImg : "Slideshow (non ci sono immagini)",
		pLabel       : "Torna all'elenco",
		fitLabel     : "Scala: Adatta al formato",
		noscLabel    : "Scala: 100%",
		fsLabel      : "FULLSCREEN",
		dwLabel      : "Download",
		emLabel      : "Embed",
		mLabel       : "MENU",
		sLabel       : "+SHARE",
		sAlt         : "Share this content",
		menuAlt      : "Mostra le opzioni",
		fsAlt        : "Modalità Fullscreen",
		fwAlt        : "Vai avanti (freccia destra)",
		rwAlt        : "Torna indietro (freccia sinistra)",
		playpauseAlt : "Stop/Play (barra spazio)",
		cursAlt      : "Trascina",
		volumeAlt    : "Regola il volume",
		embClose     : "Chiudi la finestra",
		ppBigAlt     : "Inizia ora",
		pageDn       : "Vai alla pagina precedente",
		pageUp       : "Vai alla pagina successiva",
		pageDett     : "Vai alla pagina",
		otherContents : "Altri contenuti",
		playAgain    : "Guarda ancora il contenuto",
		sendToFriends: "Condividi con gli amici",
		buyNow       : "SCARICA",
		sendToFriendsAlt: "Condividi questo contenuto con gli amici",
		buyNowAlt    : "Scarica il contenuto",
		saveShot     : "Salva immagine",
		delShot      : "Cancella immagine"
	}
	pref.lab["fr"] = {
		ssLabel      : "Diaporama",
		ssLabelNoImg : "Diaporama (aucune image)",	
		pLabel       : "Playlist",	
		fitLabel     : "Mettre à l’échelle du lecteur",
		noscLabel    : "Echelle: 100%",
		fsLabel      : "Plein écran",
		dwLabel      : "Télécharger",
		emLabel      : "Exporter",
		mLabel       : "MENU",
		sLabel       : "+SHARE",
		sAlt         : "Share this content",
		menuAlt      : "Voir les options",
		fsAlt        : "Mode plein écran",
		fwAlt        : "Avance (flèche droite)",
		rwAlt        : "Retour (flèche gauche)",
		playpauseAlt : "Stop/Play (barre espace)",
		cursAlt      : "",
		volumeAlt    : "Régler le volume",
		embClose     : "Fermer la fenêtre",
		ppBigAlt     : "Commencer",
		pageDn       : "Page précédente",
		pageUp       : "Page suivante",
		pageDett     : "Aller à la page",
		otherContents : "Contenus similaires",
		playAgain    : "Regarder encore ce contenu",
		sendToFriends: "Envoyer à un ami",
		buyNow       : "Buy now",
		sendToFriendsAlt: "Envoyer ce contenu à un ami",
		buyNowAlt    : "Buy this item now",
		saveShot     : "Save image",
		delShot      : "Delete image"
	}
	pref.lab["es"] = {
		ssLabel      : "Slideshow",
		ssLabelNoImg : "Slideshow (no images)",
		pLabel       : "Playlist",
		fitLabel     : "Scale: Fit player size",
		noscLabel    : "Scale: 100%",
		fsLabel      : "FULLSCREEN",
		dwLabel      : "Download",
		emLabel      : "Embed",
		mLabel       : "MENU",
		sLabel       : "+SHARE",
		sAlt         : "Share this content",
		menuAlt      : "Show menu options",
		fsAlt        : "Fullscreen mode",
		fwAlt        : "Go forward (arrow right)",
		rwAlt        : "Rewind (arrow left)",
		playpauseAlt : "Stop/Play (space bar)",
		cursAlt      : "scratch",
		volumeAlt    : "Set audio volume",
		embClose     : "close window",
		ppBigAlt     : "Start now",
		pageDn       : "Go to previous page",
		pageUp       : "Go to next page",
		pageDett     : "Go to page",
		otherContents : "Related contents",
		playAgain    : "Play again this video",
		sendToFriends: "Send to a friend",
		buyNow       : "Buy now",
		sendToFriendsAlt: "Send this item to a friend",
		buyNowAlt    : "Buy this item now",
		saveShot     : "Save image",
		delShot      : "Delete image"
	}
	pref.lab["pl"] = {
		ssLabel      : "Slideshow",
		ssLabelNoImg : "Slideshow (no images)",
		pLabel       : "Playlist",
		fitLabel     : "Scale: Fit player size",
		noscLabel    : "Scale: 100%",
		fsLabel      : "FULLSCREEN",
		dwLabel      : "Download",
		emLabel      : "Embed",
		mLabel       : "MENU",
		sLabel       : "+SHARE",
		sAlt         : "Share this content",
		menuAlt      : "Show menu options",
		fsAlt        : "Fullscreen mode",
		fwAlt        : "Go forward (arrow right)",
		rwAlt        : "Rewind (arrow left)",
		playpauseAlt : "Stop/Play (space bar)",
		cursAlt      : "scratch",
		volumeAlt    : "Set audio volume",
		embClose     : "close window",
		ppBigAlt     : "Start now",
		pageDn       : "Go to previous page",
		pageUp       : "Go to next page",
		pageDett     : "Go to page",
		otherContents : "Related contents",
		playAgain    : "Play again this video",
		sendToFriends: "Send to a friend",
		buyNow       : "Buy now",
		sendToFriendsAlt: "Send this item to a friend",
		buyNowAlt    : "Buy this item now",
		saveShot     : "Save image",
		delShot      : "Delete image"
	}
	
	
	
	// RESERVED //
	pref.maskera = false;
	pref.id = 0;
	pref.id_file = 0;
	pref.standAlone = true;
	pref.embedPWidth = 320;
	pref.embedPHeight = 240;
	pref.embedConfig = '<config baseTheme="v2"><display showEmail="true" showBookmark="true" showCloseButton="true"></display><body><controls><snbuttons iconsOnly="true"></snbuttons></controls></body></config>';;
	pref.ModuleID='PostModule1';
	
	// AUTO //
	pref.trackPageview = "";
	pref.trackEndPageview = "";
	pref.isEmbed = true;
	pref.piedeH = 0;
	pref.single = true;
	pref.noImg = true;
	pref.firstIsImg = false;
	pref.txtFile = "FLxER";
	pref.myAntiAliasType = "NORMAL";
}
//Preferences.customizePref(pref);
