package VJTV {
	import flash.display.MovieClip;
	import flash.display.StageAlign;
    import flash.display.StageScaleMode;
	import flash.xml.XMLDocument;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.SharedObject;
	import flash.net.LocalConnection;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.external.ExternalInterface;
	import flash.system.fscommand;
	//
	import FLxER.core.Monitor;
	import FLxER.panels.Mess;
	import FLxER.panels.PrefOption;
	import FLxER.main.Rett;
	import FLxER.comp.Alt;
	import VJTV.VJTVOptions;
	import VJTV.VJTVLoading;
	import VJTV.VJTVMonitor;
	import VJTV.VJTVInterface;
	public class VJTVStarter extends MovieClip {
		public var monitor					:VJTVMonitor;
		public var flxerInterface			:VJTVInterface;
		public var myAlt					:Alt;
		public var myPrefSO					:SharedObject;
		//
		var myOptions						:VJTVOptions;
		var myAlert							:Mess;
		var myPrefOption					:PrefOption;
		var myLoader						:URLLoader
		var myLoading						:VJTVLoading
		public function VJTVStarter() {
			trace("VJTVStarter")
			stage.showDefaultContextMenu = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			fscommand("trapallkeys", true);
			Preferences.createPref(stage.stageWidth,stage.stageHeight);
			Preferences.pref.lastTime = 0;
			Preferences.pref.fs = false;
			openOptions();
		}
		function openOptions() {
			myOptions = new VJTVOptions(200, 150, "VJ TELEVISION 1.0",setMode);
			this.addChild(myOptions);
		}
		public function setMode(n:uint) {
			this.removeChildAt(0);
			Preferences.pref.myMode = n;
			Preferences.pref.vKS = true;
			Preferences.pref.nCh = 3;
			//this.myLoading = new VJTVLoading();
			//this.addChild(myLoading);
			stage.displayState = "fullScreen";
			Preferences.pref.w = stage.stageWidth;
			Preferences.pref.h = stage.stageHeight;
			loadLib()
		}
		public function loadLib() {
			myLoader = new URLLoader(new URLRequest("http://www.vjtelevision.com/playlists/index.xml"));
			//myLoader = new URLLoader(new URLRequest("/playlists/index.xml"));
			myLoader.addEventListener("complete", startup);
			myLoader.addEventListener("ioError", xmlNotLoaded);
		}
		function xmlNotLoaded(event:Event):void {
			trace("Data not loaded."+event);
		}
		public function startup(event:Event) {
			Preferences.pref.libraryList = new XMLDocument();
			Preferences.pref.libraryList.ignoreWhite = true;
			Preferences.pref.libraryList.parseXML(myLoader.data);
			interfaceDrawer()
			stage.addEventListener(Event.RESIZE, resizer);
		}
		public function resizer(event:Event) {
			Preferences.pref.w = stage.stageWidth;
			Preferences.pref.h = stage.stageHeight;
			Preferences.pref.monitorTrgt.resizer(stage.stageWidth,stage.stageHeight);
			Preferences.pref.interfaceTrgt.setPos()
		}
		function interfaceDrawer() {
			//this.removeChildAt(0);
			this.myAlt  = new Alt();
			Preferences.pref.myAlt = this.myAlt;
			Preferences.pref.ch = 0;
			monitor = new VJTVMonitor(0,0,Preferences.pref.w, Preferences.pref.h);
			flxerInterface = new VJTVInterface();
			this.addChild(monitor);
			this.addChild(flxerInterface);
			this.addChild(myAlt);
			if (Preferences.pref.vKS) {
			}
		}
		public static function myReplace(str, search, replace) {
			var temparray = str.split(search);
			str = temparray.join(replace);
			return str;
		}
/*
		public function myFullscreen(p:Boolean) {
			Preferences.pref.fs = p;
			var a:uint;
			//clearInterval(c);
			if (p) {
				stage.addEventListener(Event.RESIZE, resizer);
				stage.displayState = "fullScreen";
				Preferences.pref.interfaceTrgt.chCnt["ch_"+0].y = Preferences.pref.h-57;
				resizer(null)
			} else {
				stage.removeEventListener(Event.RESIZE, resizer);
				stage.displayState = "normal";
			}
		}
		public function resetta() {
			this.removeChild(flxerInterface);
			this.removeChild(monitor);
			if (myAlt) {
				this.removeChild(myAlt);
			}
			loadPref();
		}
		public function reDraw() {
			//this.removeChildAt(0);
			this.removeChild(flxerInterface);
			this.removeChild(monitor);
			if (myAlt) {
				this.removeChild(myAlt);
			}
			interfaceDrawer()
		}
		function setPref() {
			myPrefSO = SharedObject.getLocal("vjtvPref","/",false);
			if (myPrefSO.data.flxerPref == undefined) {
				loadPref();
			} else {
				Preferences.pref.flxerPref = new XMLDocument();
				Preferences.pref.flxerPref.ignoreWhite = true;
				Preferences.pref.flxerPref.parseXML(myPrefSO.data.flxerPref);
				if (Preferences.pref.flxerPref.childNodes[0].childNodes[4] == undefined) {
					loadPref();
				} else {
					Preferences.updateCol();
					openOptions();
				}
			}
		}
		function loadPref() {
			myLoader = new URLLoader(new URLRequest("preferences/vjtvPref.xml"));
			myLoader.addEventListener("complete", firstStartup);
			myLoader.addEventListener("ioError", xmlNotLoaded);
		}
		function firstStartup(event:Event) {
			Preferences.pref.flxerPref = new XMLDocument();
			Preferences.pref.flxerPref.ignoreWhite = true;
			Preferences.pref.flxerPref.parseXML(myLoader.data);
			Preferences.updateColObj(Preferences.pref.colBlack);
			myPrefSO.data.flxerPref = Preferences.pref.flxerPref;
			myPrefSO.flush();
			openOptions();
		}
		function checkMonOut() {
			this.myOptions.visible = true;
			clearInterval(c);
			myAlert = new Mess(200, 100, "ALERT", "Before to start you have to run the application named:\n\n- FLxER4monitorOut\n\n");
			this.addChild(myAlert);
		}
*/
	}
}