package FLxER.core {
	import flash.display.Sprite;
	import flash.display.StageQuality
	import FLxER.comp.*;
	import FLxER.main.DrawerFunc;
	import FLxER.main.Rett;
	import FLxER.main.Txt;
	import FLxER.FlxerStarter;
	import flash.system.fscommand;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;

	public class GlobalCtrl extends Sprite {
		var logo;
		var firstTime = true;
		function GlobalCtrl() {
			//DrawerFunc.drawer(this, "f", 0, 0, 400, 300, 0xFFFFFF, 0x000000, 1);
			fondo = new Rett(0, 0, 800, 23, 0x808080, null, .5);
			this.addChild(fondo);
			logo = new Txt(-1, -7, null, null, "FLxER.net", Preferences.pref.ts, null);
			logo.scaleX = logo.scaleY=2
			this.addChild(logo);
			puls3D = new CheckBoxBase(140, 10, 44, 10, "3D ENGINE", treDengineONOFF, "USE SHIFT + ARROW KEY", false);
			this.addChild(puls3D);
			puls0 = new ButtonTxt(605, 10, 59, 10, "PREFERENCES", loadPref, null, null);
			this.addChild(puls0);
			
			puls1 = new CheckBoxBase(puls0.x+puls0.width+5, 10, 20, 10, "HI-Q", myHQ, "H", true);
			this.addChild(puls1);
			
			puls2 = new CheckBoxBase(puls1.x+puls1.width+5, 10, 19, 10, "MIDI", midiOnOff, null, false);
			this.addChild(puls2);
			
			puls3 = new CheckBoxBase(puls2.x+puls2.width+5, 10, 52, 10, "FULLSCREEN", myFullscreen, "F", false);
			this.addChild(puls3);
			
			puls4 = new ButtonTxt(puls3.x+puls3.width+5, 10, 10, 10, "?", vaiHelp, null, "HELP");
			this.addChild(puls4);
			
			puls5 = new ButtonTxt(800-13, 2, 10, 10, "X", chiudi, null, "ALT + F4 // CTRL + Q");
			this.addChild(puls5);
			/*
			_root.myClassedMC(FLxER.recorder, this, "myRecorder", {x:200});
			*/	
		}
		function myHQ(t) {
			if (stage.quality == "LOW") {
				stage.quality = "HIGH";
			} else {
				stage.quality = "LOW";
			}
		}
		function myFullscreen() {
			/*if (!_root.mykeyboard.F && firstTime) {
				_root.myClassedMC(FLxER.panels.alert, _root, "myAlert", {w:200, h:100, myXml:"Don't forget te following keyboar shortcut:\n\n- C to make visible channels control\n\n- SHIFT+C to make visible globals control\n\n- F to disable fullscreen"});
				firstTime = false;
			}
			_root.mykeyboard.myFullscreen();
			*/
		}
		function chiudi() {
			//fscommand("quit", "");
		}
		function vaiHelp() {
			navigateToURL(new URLRequest("http://wiki.flxer.net"),"_blank");
		}
		function midiOnOff(p) {
			/*
			if (p) {
				_root.myMidi = new FLxER.midi();
			} else {
				delete _root.myMidi;
			}
			*/
		}
		public function loadPref(p) {
			parent.parent.loadPrefPanel(p)
			//_root.myClassedMC(FLxER.panels.preferences, _root, "prefPanel", {x:200, y:150, w:400, h:300});
		}
		public function treDengineONOFF(aa) {
			trace("treDengineONOFF "+aa+this);
		}
	}
}