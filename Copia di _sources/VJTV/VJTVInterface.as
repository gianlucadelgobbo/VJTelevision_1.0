﻿package VJTV {
	import flash.display.Sprite;
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

	import VJTV.VJTVChCtrl;
	import VJTV.VJTVDett;
	import FLxER.comp.ButtonTxt;

	public class VJTVInterface extends Sprite {
		var myTween;
		var myTween2;
		var myTween3;
		var myTween4;
		var mL;
		public var chCnt:Object;
		var c
		/*
		public var myEmbed
		var tipo
		var single
		var myKeyL;
		var noImg;
		var t
		*/
		public var menuIsClose
		var autoHide
		var myLoading:VJTVLoading
		public var myToolbar:Toolbar2;
		public var myloaded;
		var dett:VJTVDett;
		var sottopanciaOk;
		var alert:ButtonTxt;
		public var firstPlay
		public function VJTVInterface():void {
			this.myLoading = new VJTVLoading();
			Preferences.pref.interfaceTrgt = this;
			Preferences.pref.nLoadErr = new Object();
			myToolbar = new Toolbar2();
			chCnt = new VJTVChCtrl(Preferences.pref.h-myToolbar.piede.piedeEst.height);
			menuIsClose = true
			autoHide = false
			this.addChild(chCnt);
			this.addChild(myToolbar);
			Preferences.pref.monitorTrgt.mbuto((getTimer()-Preferences.pref.lastTime)+",HIDE,1");
			Preferences.pref.monitorTrgt.mbuto((getTimer()-Preferences.pref.lastTime)+",loadMedia,1,"+"http://www.vjtelevision.com/_swf/sottopancia.swf"+",swf,100");
			dett = new VJTVDett(chCnt.myLoad,showInfo);
			dett.alpha = 0;
			//
			alert = new ButtonTxt(0, myToolbar.piede.y-36, Preferences.pref.w/2, 18, "You are waiting to load the daily content at the right time of today. Do not want to wait? click here.", startNow, 1, null);
			alert.mouseOverHandler(null)
			alert.scaleX = alert.scaleY = 2;
			setPos();
		}
		public function startAlert():void {
			this.addChild(alert);
		}
		public function startNow(a):void {
			chCnt.goToSec = 0;
			Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bufferTime = 2;
			this.removeChild(alert);
		}
		public function showInfo(xml,a):void {
			if (this.contains(dett)) {
				myTween4 = new Tween(dett,"alpha",Strong.easeOut,dett.alpha,0,2,true);
				myTween4.addEventListener(TweenEvent.MOTION_FINISH, removeInfo);
			} else {
				dett.riempi(xml,a)
				this.addChild(dett);
				myTween4 = new Tween(dett,"alpha",Strong.easeOut,dett.alpha,1,2,true);
			}
		}
		public function removeInfo(e) {
			dett.svuota()
			this.removeChild(dett);
		}
		public function startHideToolbarNow() {
			autoHide = true;
			trace("hideToolbar"+Preferences.pref.toolbarBottom);
			if (Preferences.pref.toolbarBottom == false && menuIsClose) {
				hideToolbar();
				if (!this.hasEventListener(MouseEvent.MOUSE_MOVE)) this.addEventListener(MouseEvent.MOUSE_MOVE, showToolbarAndHide);
			}
		}
		function startHideToolbar() {
			clearInterval(mL);
			mL = setInterval(hideToolbar,3000);
			if (!this.hasEventListener(MouseEvent.MOUSE_MOVE)) this.addEventListener(MouseEvent.MOUSE_MOVE, showToolbarAndHide);
		}
		function hideToolbar() {
			clearInterval(mL);
			myTween = new Tween(myToolbar.piede,"alpha",Strong.easeOut,myToolbar.piede.alpha,0,2,true);
			myTween2 = new Tween(chCnt,"alpha",Strong.easeOut,chCnt.alpha,0,2,true);
		}
		function showToolbar() {
			clearInterval(mL);
			myTween = new Tween(myToolbar.piede,"alpha",Strong.easeOut,myToolbar.piede.alpha,1,1,true);
			myTween2 = new Tween(chCnt,"alpha",Strong.easeOut,chCnt.alpha,1,1,true);
			if (myToolbar.piede.alpha  == 0) {
			}
		}
		public function startLoading() {
			if (!this.contains(myLoading)) this.addChild(myLoading);
			myToolbar.disable();
		}
		public function stopLoading() {
			trace("stopLoading"+this.contains(myLoading));
			trace("stopLoading"+Preferences.pref.interfaceTrgt.myloaded);
			trace("stopLoading"+Preferences.pref.monitorTrgt.myStarted);
			if (this.contains(myLoading) && Preferences.pref.interfaceTrgt.myloaded && Preferences.pref.monitorTrgt.myStarted) {
				this.removeChild(myLoading);
				myToolbar.enable();
			}
		}
		function showToolbarAndHide(e) {
			showToolbar()
			startHideToolbar()
		}
		function apriMenu(event) {
			if (menuIsClose) {
				menuIsClose = false
				if (this.hasEventListener(MouseEvent.MOUSE_MOVE)) this.removeEventListener(MouseEvent.MOUSE_MOVE, showToolbarAndHide);
				clearInterval(mL);
				showToolbar()
				myTween3 = new Tween(chCnt,"y",Strong.easeOut,chCnt.y,chCnt.myY,2,true);
			} else {
				menuIsClose = true;
				if (autoHide) startHideToolbarNow();
				myTween3 = new Tween(chCnt,"y",Strong.easeOut,chCnt.y,Preferences.pref.h,2,true);
			}
		}

		public function setPos() {
			chCnt.setPos(Preferences.pref.h-myToolbar.piede.piedeEst.height);
			myLoading.setPos();
			myToolbar.setPos();
			if (this.contains(alert)) {
				alert.y = myToolbar.piede.y-36;
				alert.lab.width = Preferences.pref.w/2;
			}
		}
		//
		public function onMetaDataFLV(info:Object,ch:uint):void {
			trace("onMetaDataFLV")
		}
		public function hideSottopancia() {
			Preferences.pref.monitorTrgt.mbuto((getTimer()-Preferences.pref.lastTime)+",HIDE,1");
			clearInterval(c);
			c = setInterval(showSottopancia, 60000);
		}
		public function showSottopancia() {
			Preferences.pref.monitorTrgt.levels["ch_"+1].swfLoader.content.parti();
			Preferences.pref.monitorTrgt.mbuto((getTimer()-Preferences.pref.lastTime)+",SHOW,1");
			clearInterval(c);
			c = setInterval(hideSottopancia, 5000);
		}
		public function initHandlerSWF(e:Loader,ch:uint):void {
			if (!sottopanciaOk) {
				Preferences.pref.monitorTrgt.mbuto((getTimer()-Preferences.pref.lastTime)+",loadMedia,2,"+"http://www.vjtelevision.com/_swf/logo.swf"+",swf,100");
				Preferences.pref.monitorTrgt.levels["ch_"+1].swfLoader.content.avvia(showInfo);
				sottopanciaOk = true;
				chCnt.paletteHideShow("today");
			}
			trace("initHandlerSWFinitHandlerSWFinitHandlerSWFinitHandlerSWFinitHandlerSWF")
		}
		public function initHandlerFLV(event:Event,ch:uint):void {
			trace(event.info.code)
			if (event.info.code == "NetStream.Play.Stop") {
				Preferences.pref.monitorTrgt.levels["ch_"+0].myDuration = undefined;
				Preferences.pref.currentMedia++;
				if (Preferences.pref.currentMedia>chCnt.myFileList.childNodes[0].childNodes) Preferences.pref.currentMedia = 0;
				firstPlay = true;
				chCnt.myLoad(Preferences.pref.currentMedia);
				chCnt.updatePage();
			}
			if (event.info.code == "NetStream.Buffer.Full") {
				if (firstPlay) {
					firstPlay = false;
					trace("NetStream.Buffer.Full2 "+chCnt.goToSec);
					if (chCnt.goToSec) {
						if (this.contains(alert)) this.removeChild(alert);
						trace("AZZOMPA"+chCnt.goToSec)
						Preferences.pref.monitorTrgt.levels["ch_"+0].NS.seek(chCnt.goToSec);
						Preferences.pref.monitorTrgt.levels["ch_"+0].NS.bufferTime = 2;
						chCnt.goToSec = 0;
					}
					Preferences.pref.monitorTrgt.myStarted = true;
					stopLoading();
					startHideToolbarNow()
				}
			}
			if (event.info.code == "NetStream.Play.Start") {
				showSottopancia();
				if (!hasEventListener(Event.ENTER_FRAME)) {
					Preferences.pref.tipo = "flv";
					myToolbar.avvia_indice()
				}
				Preferences.pref.monitorTrgt.levels["ch_"+0].myStopStatus = false;
				myToolbar.piede.contr.playpause.simb.gotoAndStop(2);
			}
			if (event.info.code == "NetStream.Play.StreamNotFound" || event.info.code == "NetStream.Play.FileStructureInvalid"|| event.info.code == "NetStream.Play.NoSupportedTrackFound") {
			}
		}
		public function initHandlerMP3(ch:uint):void {
		}
		public function initHandlerJPG(e:Loader,ch:uint):void {
		}
		public function errorHandlerCNT(event:Event,ch:uint):void {
			trace("errorHandlerCNT "+ch)
		}
		public function errorHandlerSWF(event:Event,ch:uint):void {
			errorHandlerCNT(event,ch);
		}
		public function errorHandlerMP3(event:Event,ch:uint):void {
			errorHandlerCNT(event,ch);
		}
		public function errorHandlerJPG(event:Event,ch:uint):void {
			errorHandlerCNT(event,ch);
			trace("errorHandlerJPG "+Preferences.pref.currentMedia["ch_"+ch])
		}
		public function errorHandlerWipes(event:Event, ch:uint):void {
		}
	}
}