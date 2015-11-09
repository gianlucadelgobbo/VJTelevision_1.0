﻿package VJTV {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.*;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
    import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.Keyboard;
    import flash.ui.Mouse;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	import flash.utils.*;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.printing.PrintJob;
	import flash.system.Security;
	import flash.external.*;
	import fl.transitions.*;
	import fl.transitions.easing.*;

	import FlxerGallery.main.BitmapDataToBinaryPNG
	import FlxerGallery.main.ByteArrayUploader;
	import FlxerGallery.main.DrawerFunc;

	public class VJTVToolbar extends MovieClip {
		var w;
		var h;
		//
		public var testa
		public var fondo
		public var piede
		public var tit
		public var mmSelTit
		var barr_width
		var bd
		var ppBig
		var scratchOFF;
        private var myContextMenu:ContextMenu;
		var myTween;
		var myTween2;
		var myTween3;
		var mL;
		public var mcWF:MovieClip;
		var cfg:Object;
		var fondoE;
		/*
		public var myEmbed
		var tipo
		var single
		var myKeyL;
		var noImg;
		var t
		*/
		public function VJTVToolbar():void {
			trace("VJTVToolbar")
			scratchOFF = true;
			avviaPuls();

			myCol = this.piede.piedeEst.transform.colorTransform;
			myCol.color = Preferences.pref.toolbarBorder;
			this.piede.piedeEst.transform.colorTransform = myCol;
			
			myCol = piede.piedeInt.transform.colorTransform;
			myCol.color = Preferences.pref.toolbarBackground;
			piede.piedeInt.transform.colorTransform = myCol;

			myCol = piede.indice.barrEst.transform.colorTransform;
			myCol.color = Preferences.pref.btnBorder;
			piede.indice.barrEst.transform.colorTransform = myCol;
/*
			myCol = piede.indice.barr.transform.colorTransform;
			myCol.color = Preferences.pref.btnBkg;
			piede.indice.barr.transform.colorTransform = myCol;
*/			
			//piede.counter.lab.textColor = Preferences.pref.btnBorder;
			
			creaContextMenu("player");
			setPos();
		}
		function avviaPuls() {
			trace("avviaPuls"+piede.s)
			try {
				if (ExternalInterface.available) {
					ExternalInterface.addCallback("apriEmbed",apriEmbed);
				}
			}
			catch (error) {
				trace(error);
			}
			//
			piede.logo.avvia({fnz:vaiLogoUrl,alt:Preferences.pref.logoAlt});
			if (Preferences.pref.logoAlt) {
			} else {
				piede.logo.visible = false;
			}
			piede.s.avvia({fnz:apriEmbed,txt:Preferences.pref.lab[Preferences.pref.lng].sLabel,alt:Preferences.pref.lab[Preferences.pref.lng].sAlt});
			piede.m.avvia({fnz:Preferences.pref.interfaceTrgt.apriMenu,txt:Preferences.pref.lab[Preferences.pref.lng].mLabel,alt:Preferences.pref.lab[Preferences.pref.lng].menuAlt});
			piede.fs.avvia({fnz:fs,txt:Preferences.pref.lab[Preferences.pref.lng].fsLabel,alt:Preferences.pref.lab[Preferences.pref.lng].fsAlt});
			piede.contr.fw.avvia({fnz:avanti,alt:Preferences.pref.lab[Preferences.pref.lng].fwAlt});
			piede.contr.fw.simb.rotation = 180;
			piede.contr.rw.avvia({fnz:indietro,alt:Preferences.pref.lab[Preferences.pref.lng].rwAlt});
			piede.contr.playpause.avvia({fnz:myPlaypause,alt:Preferences.pref.lab[Preferences.pref.lng].playpauseAlt});
			piede.indice.curs.avvia({fnz:scratch,alt:Preferences.pref.lab[Preferences.pref.lng].cursAlt,fnzOut:stopScratch});
			piede.indice.barr.mouseChildren = false;
			piede.indice.barr.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			piede.indice.barr.buttonMode=false;
			piede.volume_ctrl.avvia({fnz:regolaVolume,alt:Preferences.pref.lab[Preferences.pref.lng].volumeAlt});
			//disable();
		}
		function mouseDownHandler(event) {
			piede.indice.curs.x = piede.indice.mouseX;
			this["scratch_"+Preferences.pref.tipo](event)
		}
		public function disable() {
			trace("DISABLE")
			//stage.removeEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			piede.contr.fw.disable();
			piede.contr.rw.disable();
			piede.contr.playpause.disable();
			piede.indice.curs.disable();
			piede.volume_ctrl.disable();
		}
		public function enable() {
			trace("ENABLE")
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			piede.contr.fw.enable();
			piede.contr.rw.enable();
			piede.contr.playpause.enable();
			piede.indice.curs.enable();
			piede.volume_ctrl.enable();
		}
		public function vaiLogoUrl(t) {
			navigateToURL(new URLRequest(Preferences.pref.logoURL),"_blank")
		}
		function regolaVolume(a) {
			Preferences.pref.monitorTrgt.mbuto(getTimer()+",setVol,0,"+(a*100));
		}
		public function setPos() {
			trace("Preferences.pref.h "+Preferences.pref.h)
			w = Preferences.pref.w;
			h = Preferences.pref.h;
			piede.piedeEst.width = w;
			piede.y = h-piede.piedeEst.height;
			piede.piedeInt.width = w-2;
			var nextX = w;
			if (w>=400 && h>=300) {
				if (Preferences.pref.embedPath) {
					nextX = piede.s.x 	= nextX-(piede.s.puls.width+Preferences.pref.toolBarPaddingLR);
				} else {
					piede.s.x = w;
				}
				if (Preferences.pref.fpMenu) {
					nextX = piede.m.x 	= nextX-(piede.m.puls.width+Preferences.pref.toolBarPaddingLR);
				} else {
					piede.m.x = w;
				}
				if (Preferences.pref.fullscreenBtn) {
					nextX = piede.fs.x 	= nextX-(piede.fs.puls.width+Preferences.pref.toolBarPaddingLR);
				} else {
					piede.fs.x = w;
				}
				piede.volume_ctrl.visible = piede.contr.visible = piede.counter.visible = piede.indice.visible = true;
			} else {
				piede.s.x = w;
				piede.m.x = w;
				if (Preferences.pref.fullscreenBtn) {
					nextX = piede.fs.x 	= nextX-(piede.fs.puls.width+Preferences.pref.toolBarPaddingLR);
				} else {
					piede.fs.x = w;
				}
				piede.volume_ctrl.visible = piede.contr.visible = piede.counter.visible = piede.indice.visible = false;
			}
			if (ppBig!=undefined) {
				ppBig.x = (w-ppBig.width)/2;
				ppBig.y = (Preferences.pref.toolbarBottom ? (piede.y-ppBig.height)/2 : (h-ppBig.height)/2);
			}
			if (Preferences.pref.tipo == "jpg") {
				piede.volume_ctrl.x = w+1;
				piede.contr.fw.x = piede.contr.playpause.x + piede.contr.playpause.width+Preferences.pref.toolBarPaddingLR
			} else {
				nextX = piede.volume_ctrl.x = nextX-(piede.volume_ctrl.width+Preferences.pref.toolBarPaddingLR);
				if (Preferences.pref.forward) {
					piede.contr.fw.x = piede.contr.playpause.x + piede.contr.playpause.width+Preferences.pref.toolBarPaddingLR;
				} else {
					piede.contr.fw.x = piede.contr.rw.x
				}
			}
			piede.counter.fondo.width = piede.counter.lab.textWidth+(Preferences.pref.toolBarPaddingLR*2);
			piede.counter.x = nextX-(piede.counter.fondo.width+Preferences.pref.toolBarPaddingLR);
			//piede.indice.visible = false
			piede.indice.x = piede.contr.x+piede.contr.width+Preferences.pref.toolBarPaddingLR-piede.indice.fondo.x;
			piede.indice.fondo.width = piede.counter.x-(piede.indice.x + piede.indice.fondo.x)
			piede.indice.barr.width = piede.indice.fondo.width + (piede.indice.fondo.x*2);
			piede.indice.barrEst.width = piede.indice.barr.width-(piede.indice.barrEst.x*2);
			barr_width = piede.indice.barr.width;
			if (mcWF) {
				mcWF.x=int((Preferences.pref.w-cfg['width'])/2);
				mcWF.y=int((Preferences.pref.h-cfg['height'])/2);
				fondoE.x = -mcWF.x;
				fondoE.y = -mcWF.y;
				fondoE.width = Preferences.pref.w;
				fondoE.height = Preferences.pref.h;
			}
			for (a=0; a<Preferences.pref.nCh; a++) {
				//chCnt["ch_"+a].y = (563-(40*(7-_root.nCh)))-(40*this.a);
				//chCnt["ch_"+a].y = piede.y-(40*(a+1));
			}
		}
		//
		function scratch(t) {
			avvia_scratch();
			piede.indice.curs.startDrag(false,new Rectangle(piede.indice.barr.x,piede.indice.barr.y,piede.indice.barr.width,0));
		}
		function stopScratch(t) {
			scratchOFF = true;
			if (piede.contr.playpause.simb.currentFrame == 2 && Preferences.pref.tipo == "flv") {
				Preferences.pref.monitorTrgt.levels["ch_"+0].NS.resume();
			}
			this.removeEventListener(Event.ENTER_FRAME, this["scratch_"+Preferences.pref.tipo]);
			avvia_indice();
			piede.indice.curs.stopDrag();
		}
	
		function avvia_scratch() {
			scratchOFF = false;
			this.removeEventListener(Event.ENTER_FRAME, this["indice_"+Preferences.pref.tipo]);
			Preferences.pref.monitorTrgt.levels["ch_"+0].NS.pause();
			if (Preferences.pref.tipo == "mp3") {
				Preferences.pref.monitorTrgt.levels["ch_"+0].myStopStatus = false;
				piede.contr.playpause.simb.gotoAndStop(2);
			}
			this.addEventListener(Event.ENTER_FRAME, this["scratch_"+Preferences.pref.tipo]);
		}
		function scratch_swf(event) {
			Preferences.pref.monitorTrgt.mbuto(getTimer()+",SCRATCHswf,0,"+(piede.indice.curs.x/barr_width));
		}
		function scratch_flv(event) {
			Preferences.pref.monitorTrgt.mbuto(getTimer()+",SCRATCHflv,0,"+(piede.indice.curs.x/barr_width));
		}
		function scratch_mp3(event) {
			Preferences.pref.monitorTrgt.mbuto(getTimer()+",SCRATCHmp3,0,"+(piede.indice.curs.x/barr_width));
		}
		//
		function avanti(t) {
			Preferences.pref.monitorTrgt.mbuto(getTimer()+",FORWARD,0,");
		}
		function indietro(t) {
			Preferences.pref.monitorTrgt.mbuto(getTimer()+",REWIND,0,");
		}
		function myPlaypause(t) {
			if (scratchOFF){
				if (Preferences.pref.monitorTrgt.levels["ch_"+0].myStopStatus) {
					piede.contr.playpause.simb.gotoAndStop(2);
					Preferences.pref.monitorTrgt.mbuto(getTimer()+",PLAY,0")
				} else {
					piede.contr.playpause.simb.gotoAndStop(1);
					Preferences.pref.monitorTrgt.mbuto(getTimer()+",STOP,0")
				}
			}
		}
		public function visualizzappBig() {
			this.ppBig = new PlayBig();
			this.addChild(ppBig);
			ppBig.x = (w-ppBig.width)/2;
			ppBig.y = (Preferences.pref.toolbarBottom ? (piede.y-ppBig.height)/2 : (h-ppBig.height)/2);
			ppBig.avvia({fnz:myRemoveThumb,fnzOut:myRemoveThumb2,alt:Preferences.pref.lab[Preferences.pref.lng].ppBigAlt});
			ppBig.gotoAndStop(1);
			
		}
		function creaContextMenu(stat) {
			var item
			myContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			if (!Preferences.pref.single) {
				if (stat == "player") {
					item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].pLabel)
					item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,avviaSelector);
					myContextMenu.customItems.push(item);
				} else {
					item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].ssLabel)
					item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,avviaSS);
					myContextMenu.customItems.push(item);
					//mPlay.customItems.push(new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].pLabel,avviaSelector));
					if (Preferences.pref.noImg) {
						myContextMenu.customItems[0].enabled = false;
						myContextMenu.customItems[0].caption = Preferences.pref.lab[Preferences.pref.lng].ssLabelNoImg;
					}
					//myContextMenu.customItems[2].caption = Preferences.pref.lab[Preferences.pref.lng].ssLabelNoImg;
				}
			}
			item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].fitLabel)
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,scaleFit);
			myContextMenu.customItems.push(item);
			item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].noscLabel)
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,scale100);
			myContextMenu.customItems.push(item);
			if (Preferences.pref.fullscreenBtn) {
				item = new ContextMenuItem(""+Preferences.pref.lab[Preferences.pref.lng].fsLabel+"")
				myContextMenu.customItems.push(item);
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,fs);
			}
			//item = new ContextMenuItem("Print this content")
			//myContextMenu.customItems.push(item);
			if (Preferences.pref.downPath) {
				item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].dwLabel)
				myContextMenu.customItems.push(item);
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,dw);
			}
			if (Preferences.pref.embedPath) {
				item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].emLabel)
				myContextMenu.customItems.push(item);
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.apriEmbed);
			}
			myContextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, menuSelectHandler);
			if (stat != "player") {
				myContextMenu.customItems[1].enabled = false;
				myContextMenu.customItems[2].enabled = false;
			}
			this.contextMenu = myContextMenu;
		}
        function menuSelectHandler(event:ContextMenuEvent):void {
            trace("menuSelectHandler: " + event);
        }
		//
		public function fs(e):void {
			switch (stage.displayState) {
				case "normal" :
					stage.displayState="fullScreen";
					break;
				case "fullScreen" :
				default :
					stage.displayState="normal";
					break;
			}
		}
		public function scaleFit(e) {
			Preferences.pref.resizza_onoff = true;
			Preferences.pref.monitorTrgt.setPos();
		}
		public function scale100(e) {
			Preferences.pref.resizza_onoff=false;
			Preferences.pref.monitorTrgt.setPos();
		}
		public function apriEmbed(e) {
			if (!mcWF) {
				trace("apriEmbed")
				Security.allowDomain("cdn.gigya.com");
				Security.allowInsecureDomain("cdn.gigya.com");
				cfg = {};
				cfg['width'] = Preferences.pref.embedPWidth;
				cfg['height'] = Preferences.pref.embedPHeight;
				cfg['UIConfig'] = Preferences.pref.embedConfig;
				cfg['CID'] = Preferences.pref.CID;
				cfg['widgetTitle'] = Preferences.pref.embedTitle;
				cfg['useFacebookMystuff'] = "false";
				cfg['partner'] = Preferences.pref.embedPartner;
				var flashvar = "?";
				var conta = 0
				for (var keyStr:String in Preferences.pref.flashvar) {
					if (keyStr!="isEmbed") {
						if (conta) flashvar+= "&";
						flashvar+= keyStr+"="+Preferences.pref.flashvar[keyStr].toString();
						conta++;
					}
				}
				var tmp = Preferences.pref.embedPath+(flashvar != "?" ? flashvar : "");

				cfg['defaultContent'] = "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0\" width=\""+Preferences.pref.embedWidth+"\" height=\""+Preferences.pref.embedHeight+"\"><param name=\"movie\" value=\""+tmp+"\"></param><param name=\"wmode\" value=\"window\"></param><param name=\"allowfullscreen\" value=\"true\"></param><param name=\"allowscriptaccess\" value=\"always\"></param><embed src=\""+tmp+"\" type=\"application/x-shockwave-flash\" wmode=\"window\" allowfullscreen=\"true\" allowscriptaccess=\"always\" width=\""+Preferences.pref.embedWidth+"\" height=\""+Preferences.pref.embedHeight+"\"></embed></object>"; // <-- YOUR EMBED CODE GOES HERE
				cfg['useFacebookMystuff']='true';
				cfg['onClose']=function(eventObj:Object):void{
					removeEmbed();
				}
				function removeEmbed():void{
					parent.removeChild(mcWF);
				}
				
				Security.allowDomain("cdn.gigya.com");
				Security.allowInsecureDomain("cdn.gigya.com");
				// Step 8 - This code calls up Wildfire
				mcWF = new MovieClip();
				parent.addChild(mcWF).name='mcWF';
				mcWF.x=int((w-cfg['width'])/2);
				mcWF.y=int((h-cfg['height'])/2);
				fondoE = new MovieClip();
				fondoE.x = -mcWF.x;
				fondoE.y = -mcWF.y;
				DrawerFunc.drawer(fondoE,0,0,w,h,0xFFFFFF,null,.4);
				DrawerFunc.drawer(fondoE,0,0,w,h,0x000000,null,.4);
				mcWF.addChild(fondoE).name='fondo';
				
				var ldr:Loader = new Loader();
				var url:String = 'http://cdn.gigya.com/Wildfire/swf/WildfireInAS3.swf?ModuleID=' + Preferences.pref.ModuleID;
				var urlReq:URLRequest = new URLRequest(url);
				ldr.load(urlReq);
				mcWF.addChild(ldr);
			} else {
				mcWF.x=int((Preferences.pref.w-cfg['width'])/2);
				mcWF.y=int((Preferences.pref.h-cfg['height'])/2);
				fondoE.x = -mcWF.x;
				fondoE.y = -mcWF.y;
				fondoE.width = Preferences.pref.w;
				fondoE.height = Preferences.pref.h;
				parent.addChild(mcWF).name='mcWF';
			}
			mcWF[Preferences.pref.ModuleID] = cfg;
		}
		public function dw(e) {
			navigateToURL(new URLRequest(Preferences.pref.downPath+Preferences.pref.monitorTrgt.currMov),"_self");
		}
		public function avvia_indice() {
			var tmp = Preferences.pref.tipo;
			if (tmp == "txt") {
				tmp = "swf";
			}
			this.addEventListener(Event.ENTER_FRAME, this["indice_"+tmp]);
		}
		public function myTime(mm) {
			var min;
			var tmp;
			var tmp2;
			var sec;
			if (mm>60) {
				tmp = int(mm/60);
				if (tmp.toString().length<2) {
					min = "0"+tmp;
				} else {
					min = tmp;
				}
				tmp2 = int(mm-(60*tmp));
				if (tmp2.toString().length<2) {
					sec = "0"+tmp2;
				} else {
					sec = tmp2;
				}
			} else {
				min = "00";
				if (int(mm).toString().length<2) {
					sec = "0"+int(mm);
				} else {
					sec = int(mm);
				}
			}
			return min+":"+sec;
		}
		function indice_flv(event) {
			if (Preferences.pref.monitorTrgt.levels["ch_"+0].myDuration) {
				if (Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesLoaded<Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesTotal) {
					this.piede.counter.lab.htmlText = myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].NS.time)+" / "+myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].myDuration);
					piede.indice.barr.width = barr_width*(Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesLoaded/Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesTotal);
				} else if (Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesLoaded == Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesTotal && Preferences.pref.monitorTrgt.myloaded == false) {
					Preferences.pref.monitorTrgt.myloaded = true;
					piede.indice.barr.width = barr_width;
				} else {
					this.piede.counter.lab.htmlText = myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].NS.time)+" / "+myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].myDuration);
				}
				piede.indice.curs.x = (barr_width)*(Preferences.pref.monitorTrgt.levels["ch_"+0].NS.time/Preferences.pref.monitorTrgt.levels["ch_"+0].myDuration);
			} else {
				if (Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesLoaded<Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesTotal) {
					this.piede.counter.lab.htmlText = myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].NS.time);
					piede.indice.barr.width = barr_width*(Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesLoaded/Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesTotal);
				} else if (Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesLoaded == Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bytesTotal && Preferences.pref.monitorTrgt.myloaded == false) {
					Preferences.pref.monitorTrgt.myloaded = true;
					piede.indice.barr.width = barr_width;
				} else {
					this.piede.counter.lab.htmlText = myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].NS.time);
				}
				piede.indice.curs.x = 0;
			}
		}
		function indice_swf(event) {
			piede.indice.curs.x = (barr_width)*(Preferences.pref.monitorTrgt.levels["ch_"+0].swfTrgt.currentFrame/Preferences.pref.monitorTrgt.levels["ch_"+0].swfTrgt.totalFrames);
			this.piede.counter.lab.htmlText = myTime((Preferences.pref.monitorTrgt.levels["ch_"+0].swfTrgt.currentFrame/25)*60)+" / "+myTime((Preferences.pref.monitorTrgt.levels["ch_"+0].swfTrgt.totalFrames/25)*60);
		}
		function indice_mp3(event) {
			if (Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.bytesLoaded<Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.bytesTotal) {
				this.piede.counter.lab.htmlText = myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].song.position/1000)+" / "+myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.length/1000);
				piede.indice.barr.width = barr_width*(Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.bytesLoaded/Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.bytesTotal);
			} else if (Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.bytesLoaded == Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.bytesTotal && Preferences.pref.monitorTrgt.myloaded == false) {
				Preferences.pref.monitorTrgt.myloaded = true;
				piede.indice.barr.width = barr_width;
			} else {
				this.piede.counter.lab.htmlText = myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].song.position/1000)+" / "+myTime(Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.length/1000);
			}
			piede.indice.curs.x = (barr_width)*(Preferences.pref.monitorTrgt.levels["ch_"+0].song.position/Preferences.pref.monitorTrgt.levels["ch_"+0].mp3Sound.length);
		}
		function reportKeyDown(e) {
			if (e.keyCode == Keyboard.LEFT) {
				indietro(null);
			}
			if (e.keyCode == Keyboard.RIGHT) {
				avanti(null);
			}
			if (e.keyCode == Keyboard.SPACE) {
				myPlaypause(null)
			}
		}
		function resetta() {
			piede.contr.playpause.simb.gotoAndStop(1);
			piede.indice.curs.x = 0;
		}
	}
}