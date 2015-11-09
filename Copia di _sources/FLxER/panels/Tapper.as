package FLxER.panels {
	import flash.display.Sprite;
	import flash.utils.*;

	import FLxER.main.Rett;
	import FLxER.main.Txt;
	import FLxER.comp.CheckBoxBase;
	import FLxER.comp.CheckBoxSeq;
	import FLxER.comp.ButtonTxt;
	import FLxER.comp.ListMenu;
	public class Tapper extends Sprite {
		public var msVal:Number;
		var bpmVal:Number;
		var lastTap:Number;
		var oldMsVal:Number;
		var ch:uint;
		
		public var masterTap:CheckBoxBase;
		var myBpm:ButtonTxt;
		var tapValField:Txt;
		
		public function Tapper(xx:int,yy:int,c:uint):void {
			this.x = xx;
			this.y = yy;
			ch = c;
			bpmVal = 160;
			msVal = 60000/bpmVal;
			Preferences.pref.msVal["ch_"+ch] = msVal;
			this.myBpm = new ButtonTxt(11, 0, 18, 11, "TAP", takeTap, null, " T");
			this.addChild(myBpm);
			this.tapValField = new Txt(30, 0, 19, 11, "160", Preferences.pref.th, "input", updateTap);
			this.addChild(tapValField);
			this.masterTap = new CheckBoxBase(0, 0, 10, 11, "MASTER TAP: ", setMasterTap, null, false);
			this.addChild(masterTap);
		}
		function setMasterTap(p:Boolean):void {
			this.parent.change_ch();
			trace("setMasterTap "+p+" "+ch)
			parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",setMasterTap,"+ch+","+p);
			Preferences.pref.masterTap = p;
			var a;
			for (a=0;a<Preferences.pref.nCh;a++) {
				if (p) {
					parent.parent.chCnt["ch_"+a].mySequencer.setCh(ch);
					if (a != parent.ch) parent.parent.chCnt["ch_"+a].mySequencer.myTimerOff();
				} else {
					parent.parent.chCnt["ch_"+a].mySequencer.setCh(a);
					parent.parent.chCnt["ch_"+a].mySequencer.myTimer();
				}
			}
		}
		public function takeTap(p:String):void {
			this.parent.change_ch();
			if (lastTap) {
				Preferences.pref.msVal["ch_"+ch] = msVal = getTimer()-lastTap;
				if (int(60000/msVal)>0) {
					bpmVal = int(60000/msVal);
					this.tapValField.text = int(60000/msVal);
				}
			}
			if (int(60000/msVal)>0) {
				updateTap("");
			}
			lastTap = getTimer();
		}
		function updateTap(p:String):void {
			bpmVal = parseInt(tapValField.text);
			Preferences.pref.msVal["ch_"+ch] = msVal = 60000/bpmVal;
			if (parent.mySequencer.seqStatus) {
				if (Preferences.pref.masterTap) {
					if (masterTap.myStatus) parent.mySequencer.myTimer();
				} else {
					parent.mySequencer.myTimer();
				}
			}
		}
		/*
		public function setMasterTapAct(p:Number):void {
			oldMsVal = msVal;
			msVal = p;
			tapValField.text = bpmVal = 60000/msVal;
			if (masterTap.myStatus) {
				masterTap.myStatus_swap();
			}
			Preferences.pref.msVal["ch_"+ch] = msVal = 60000/bpmVal;
		}
		public function setSingleTapAct():void {
			msVal = oldMsVal;
			tapValField.text = bpmVal = 60000/msVal;
			updateTap("")
		}
		*/
	}
}