package FLxER {
	import flash.display.Sprite;
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
	import FLxER.core.FlxerInterface;
	import FLxER.core.Monitor;
	import FLxER.core.KeyboardIn;
	import FLxER.core.FlxerSSConnector;
	import FLxER.core.TreDengine;
	import FLxER.panels.Preloader;
	import FLxER.panels.Options;
	import FLxER.panels.Mess;
	import FLxER.panels.PrefOption;
	import FLxER.panels.GlobalCtrl;
	import FLxER.panels.OptionsRemote;
	import FLxER.main.Rett;
	import FLxER.comp.Alt;
	public class FlxerStarter extends Sprite {
		public var monitor					:Monitor;
		public var flxerInterface			:FlxerInterface;
		public var myGlobalCtrl				:GlobalCtrl;
		public var myAlt					:Alt;
		public var myTreDengine				:TreDengine;
		public var myKeyboard				:KeyboardIn;
		public var myPrefSO					:SharedObject;
		public var myFlxerSSConnectorSender	:FlxerSSConnector;
		//
		var startDelay						:uint;
		var c								:uint;
		var splash							:Preloader;
		var receiving_lc					:LocalConnection;
		var sending_lc						:LocalConnection
		var plugInLoader					:Loader;
		var receiving_lc_mon				:LocalConnection;
		var myOptions						:Options;
		var myOptionsRemote					:OptionsRemote;
		var myAlert							:Mess;
		var myPrefOption					:PrefOption;
		var fondo							:Rett;
		var fondino							:Rett;
		var myLoader						:URLLoader
		public function FlxerStarter() {
			stage.showDefaultContextMenu = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			fscommand("trapallkeys", true);
			startDelay = 500;
			Preferences.createPref(stage.stageWidth,stage.stageHeight);
			Preferences.pref.lastTime = 0;
			Preferences.pref.fs = false;
			splash = new Preloader(40338);
			this.addChild(splash);
			myPrefSO = SharedObject.getLocal("flxerPref","/",false);
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
					c = setInterval(openOptions, 500);
				}
			}
			//_root.myTabIndex = 1;
		}
		function loadPref() {
			myLoader = new URLLoader(new URLRequest("preferences/flxerPref.xml"));
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
			c = setInterval(openOptions, 500);
		}
		function openOptions() {
			if (getTimer() > startDelay) {
				clearInterval(c);
				this.removeChildAt(0);
				myOptions = new Options(400, 300, "FLXER STARTUP MODES",setMode);
				this.addChild(myOptions);
			}
		}
		public function savePref(p:Boolean) {
			trace("save")
		}
		public function setMode(n:uint) {
			Preferences.pref.myMode = n;
			switch (n) {
				case 0 :
					loadPluginXml();
					receiving_lc = new LocalConnection();
					receiving_lc.client = this;
					try {
						receiving_lc.connect("lc_flxer");
					} catch (error:ArgumentError) {
						trace("Can't connect...the connection name is already being used by another SWF");
					}
					break;
				case 1 :
					if (!receiving_lc_mon) {
						receiving_lc_mon = new LocalConnection();
						receiving_lc_mon.client = this;
						try {
							receiving_lc_mon.connect("lc_mon");
						} catch (error:ArgumentError) {
							trace("Can't connect...the connection name is already being used by another SWF");
						}
					}
					this.myOptions.visible = false;
	
					sending_lc = new LocalConnection();
					if (ExternalInterface.available) {
						ExternalInterface.call("openMonitorOut");
						c = setInterval(getMonitorAndCheck, 3000);
					} else {
						getMonitorAndCheck();
					}

		
					break;
				case 2 :
					if (ExternalInterface.available) {
						ExternalInterface.call("alert", "This function is not available in the web version.");
					} else {
						myFlxerSSConnectorSender = new FLxER.core.FlxerSSConnector(loadPluginXml, null);
						myOptionsRemote = new OptionsRemote(400, 300, "REMOTE RECEIVER MODE OPTIONS", myFlxerSSConnectorSender);
						this.addChild(myOptionsRemote);
					}
					break;
			}/**/
		}
		public function setMonitor(obj:Object) {
			clearInterval(c);
			Preferences.pref.monObj = obj;
			loadPluginXml();
		};
		function getMonitorAndCheck() {
			clearInterval(c);
			sending_lc.send("lc_flxer", "getMonitor");
			c = setInterval(checkMonOut, 2000);
		}
		function checkMonOut() {
			this.myOptions.visible = true;
			clearInterval(c);
			myAlert = new Mess(200, 100, "ALERT", "Before to start you have to run the application named:\n\n- FLxER4monitorOut\n\n");
			this.addChild(myAlert);
		}
		function xmlNotLoaded(event:Event):void {
			trace("Data not loaded."+event);
		}
		public function loadPluginXml() {
			myLoader = new URLLoader(new URLRequest("preferences/plugIn.xml"));
			myLoader.addEventListener("complete", loadSeqPattern);
			myLoader.addEventListener("ioError", xmlNotLoaded);
		}
		public function loadSeqPattern(event:Event) {
			Preferences.pref.plugin = new XMLDocument();
			Preferences.pref.plugin.ignoreWhite = true;
			Preferences.pref.plugin.parseXML(myLoader.data);
			myLoader = new URLLoader(new URLRequest("preferences/sequencerPattern.xml"));
			myLoader.addEventListener("complete", loadLib);
			myLoader.addEventListener("ioError", xmlNotLoaded);
		}
		public function loadLib(event:Event) {
			Preferences.pref.sequencerPattern = new XMLDocument();
			Preferences.pref.sequencerPattern.ignoreWhite = true;
			Preferences.pref.sequencerPattern.parseXML(myLoader.data);
			myLoader = new URLLoader(new URLRequest("preferences/playlists.xml"));
			myLoader.addEventListener("complete", startup);
			myLoader.addEventListener("ioError", xmlNotLoaded);
		}
		public function startup(event:Event) {
			Preferences.pref.libraryList = new XMLDocument();
			Preferences.pref.libraryList.ignoreWhite = true;
			Preferences.pref.libraryList.parseXML(myLoader.data);
			//
			Preferences.pref.blendList = new XMLDocument();
			Preferences.pref.blendList.ignoreWhite = true;
			var list:XML = <lib><a m="normal" /><a m="layer" /><a m="multiply" /><a m="screen" /><a m="lighten" /><a m="darken" /><a m="difference" /><a m="add" /><a m="subtract" /><a m="invert" /><a m="alpha" /><a m="erase" /><a m="overlay" /><a m="hardlight" /></lib>;
			Preferences.pref.blendList.parseXML(list);
			Preferences.pref.plugin.childNodes[0].childNodes[0].insertBefore(Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0].cloneNode(true),Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0]);
			Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0].attributes.m = "HORIZONTAL";
			Preferences.pref.plugin.childNodes[0].childNodes[0].insertBefore(Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0].cloneNode(true),Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0]);
			Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0].attributes.m = "VERTICAL";
			Preferences.pref.plugin.childNodes[0].childNodes[0].insertBefore(Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0].cloneNode(true),Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0]);
			Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0].attributes.m = "LOAD SVG MAP";
			Preferences.pref.plugin.childNodes[0].childNodes[0].insertBefore(Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0].cloneNode(true),Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0]);
			Preferences.pref.plugin.childNodes[0].childNodes[0].childNodes[0].attributes.m = "WIPE NONE (MIX)";

				//if (System.capabilities.os.substring(0, 3) == "Win" || System.capabilities.os.substring(0, 3) == "Mac") {
			if (Preferences.pref.flxerPref.childNodes[0].childNodes[2].attributes.value == "true") {
				Preferences.pref.vKS = true;
			} else {
				Preferences.pref.vKS = false;
			}
			Preferences.pref.nCh = parseInt(Preferences.pref.flxerPref.childNodes[0].childNodes[0].attributes.value.toString());
			if (Preferences.pref.nCh < 1) {
				Preferences.pref.nCh = 1;
			} else if (Preferences.pref.nCh > 7) {
				Preferences.pref.nCh = 7;
			} else if (isNaN(Preferences.pref.nCh)) {
				Preferences.pref.nCh = 7;
			}
			interfaceDrawer();
		}
		public function resizer(event:Event) {
			Preferences.pref.monitorTrgt.resizer(stage.stageWidth,stage.stageHeight);
			for (var a:uint = 0; a<Preferences.pref.nCh; a++) {
				Preferences.pref.interfaceTrgt.chCnt["ch_"+a].y = stage.stageHeight-37;
			}
		}
		public function myFullscreen(p:Boolean) {
			Preferences.pref.fs = p;
			var a:uint;
			//clearInterval(c);
			if (p) {
				stage.addEventListener(Event.RESIZE, resizer);
				stage.displayState = "fullScreen";
				Preferences.pref.monitorTrgt.x = Preferences.pref.monitorTrgt.y=0;
				resizer(null)
				for (a=0; a<Preferences.pref.nCh; a++) {
					if (a!=Preferences.pref.ch) Preferences.pref.interfaceTrgt.chCnt["ch_"+a].visible = false;
				}
				Preferences.pref.myGlobalCtrl.visible = Preferences.pref.interfaceTrgt.visible = false;
			} else {
				stage.removeEventListener(Event.RESIZE, resizer);
				stage.displayState = "normal";
				Preferences.pref.monitorTrgt.x = 200;
				Preferences.pref.monitorTrgt.y = 23;
				Preferences.pref.monitorTrgt.resizer(400,300);
				for (a=0; a<Preferences.pref.nCh; a++) {
					//Preferences.pref.interfaceTrgt.chCnt["ch_"+a].y = (563-(40*(7-_root.nCh)))-(40*this.a);
					Preferences.pref.interfaceTrgt.chCnt["ch_"+a].y = (563-(40*(7-Preferences.pref.nCh)))-(40*a);
					Preferences.pref.interfaceTrgt.chCnt["ch_"+a].visible = true;
				}
				Preferences.pref.interfaceTrgt.visible = Preferences.pref.myGlobalCtrl.visible = true;
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
		function interfaceDrawer() {
			clearInterval(c);
			this.removeChildAt(0);
			var www:uint;
			var hhh:uint;
			var ddd:Number;
			if (Preferences.pref.monObj) {
				if (Preferences.pref.monObj.monWidth/Preferences.pref.monObj.monHeight > 800/300) {
					ddd = Preferences.pref.monObj.monWidth/800;
					www = 800;
					hhh = Preferences.pref.monObj.monHeight/ddd;
				} else {
					ddd = Preferences.pref.monObj.monHeight/300;
					www = Preferences.pref.monObj.monWidth/ddd;
					hhh = 300
				}
				monitor = new Monitor((800-www)/2, 23+((300-hhh)/2), Preferences.pref.monObj.monWidth, Preferences.pref.monObj.monHeight, Preferences.pref.nCh, true);
				monitor.scaleX = monitor.scaleY = 1/ddd;
			} else {
				www = 400;
				hhh = 300;
				monitor = new Monitor((800-www)/2, 23+((300-hhh)/2), www, hhh, Preferences.pref.nCh, true);
			}
			fondo = new Rett(0,0,800,600,Preferences.pref.myCol.bkgCol,-1,1);
			fondino = new Rett(0,23,800,300,0x333333,-1,1);
			this.addChild(fondo);
			this.addChild(fondino);
			flxerInterface = new FlxerInterface();
			myGlobalCtrl = new GlobalCtrl();
			this.addChild(monitor);
			this.addChild(flxerInterface);
			stage.focus=stage;
			this.addChild(myGlobalCtrl);
			myKeyboard = new KeyboardIn();
			myTreDengine = new TreDengine();
			if (Preferences.pref.vKS) {
				this.myAlt  = new Alt();
				this.addChild(myAlt);
				Preferences.pref.myAlt = this.myAlt;
			}
		}
		public function loadPlugIn(p:String):void {
			this.plugInLoader = new Loader();
			plugInLoader.contentLoaderInfo.addEventListener(Event.INIT, initHandlerPlugIn);
			plugInLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerPlugIn);
			plugInLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerPlugIn);
			plugInLoader.load(new URLRequest("plug-in/"+p));
			trace("loadPlugIn "+p);
		}
		function initHandlerPlugIn(event:Event) {
			this.addChild(plugInLoader)
			trace("initHandlerPlugIn"+event)
		}
		function errorHandlerPlugIn(event:Event) {
			trace("errorHandlerPlugIn"+event)
		}/**/
	}
}