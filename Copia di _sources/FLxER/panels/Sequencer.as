﻿package FLxER.panels {
	import flash.display.Sprite;
	import flash.utils.*;

	import FLxER.main.Rett;
	import FLxER.comp.CheckBoxBase;
	import FLxER.comp.CheckBoxSeq;
	import FLxER.comp.ButtonTxt;
	import FLxER.comp.ListMenu;
	class Sequencer extends Sprite {
		public var seqStatus:Boolean;
		var c:uint;
		var myStatusList:Array;
		var lastStop:Boolean;
		var lastHide:Boolean;
		var seqPattern:Array;
		
		var seq:CheckBoxBase;
		var myPatternSel:ListMenu;
		var myReset:ButtonTxt;
		var s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15:CheckBoxSeq;
		var fondo:Rett;
		var controller:Controller;
		var pulsa:Sprite;
		public var chSeq:uint;
		public function Sequencer(xx:uint,yy:uint,c:Controller,ch:uint):void {
			chSeq = ch;
			Preferences.pref.pos["ch_"+chSeq] = 0;
			lastStop = false;
			lastHide = false;
			controller = c;
			this.x = xx;
			this.y = yy;
			this.myStatusList = new Array("NULL", "PLAY", "STOP", "REWIND", "HIDE", "SHOW");
			seqStatus = false;
			this.myPatternSel = new ListMenu(67, 0, 75, 11, "select pattern", loadPattern, undefined, Preferences.pref.sequencerPattern.childNodes[0], 2);
			this.addChild(myPatternSel);
			this.myReset = new ButtonTxt(157, 0, 35, 11, "RESET", resetta, "NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL", null);
			this.addChild(myReset);
			this.pulsa = new Sprite();
			this.addChild(pulsa);
			for (var a=15; a>=0; a--) {
				this["s"+a] = new CheckBoxSeq((a*12)+1, 12, 11, 11, swapSeq, myStatusList, a);
				this.pulsa.addChild(this["s"+a]);
			}
			this.fondo = new Rett(0, -1, 193, 25, 0x999999, -1, .5);
			this.addChild(fondo);
			this.seq = new CheckBoxBase(1, 0, 55, 11, "SEQUENCER", avvia, null, false);
			this.addChild(seq);
		}
		function avvia(p:Boolean):void {
			this.parent.change_ch();
			trace("avvia"+p)
			seqStatus = p;
			if (seqStatus) {
				//pos = -1;
				if (!seqPattern) {
					seqPattern = new Array("NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL");
				}
				if (!Preferences.pref.masterTap) myTimer();
				fondo.visible = false;				
			} else {
				seqPattern = undefined;
				removeSeq();
				this["s"+Preferences.pref.pos["ch_"+chSeq]].lab.borderColor = 0x999999;
				this["s"+Preferences.pref.pos["ch_"+chSeq]].lab.border = false;
			}
			parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",seqManager,"+this.parent.ch+","+p);
		}
		public function myTimerOff():void {
			clearInterval(c);
			this["s"+Preferences.pref.pos["ch_"+chSeq]].lab.borderColor = 0x999999;
			this["s"+Preferences.pref.pos["ch_"+chSeq]].lab.border = false;
			parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",removeSeq,"+this.parent.ch);
		}
		public function myTimer():void {
			clearInterval(c);
			if (seqStatus) {
				seqAct();
				c = setInterval(seqAct, Preferences.pref.msVal["ch_"+parent.ch]);
				parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",seqUpdater,"+this.parent.ch+","+Preferences.pref.msVal["ch_"+parent.ch]);
			}
		}
		function removeSeq():void {
			clearInterval(c);
			controller.playpause(controller.playVal);
			controller.hider(controller.hideVal);
			this.setChildIndex(fondo,this.numChildren - 1)
			this.setChildIndex(seq,this.numChildren - 1)
			fondo.visible = true
			parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",removeSeq,"+this.parent.ch);
		}
		function swapSeq(p:uint,v:uint):void {
			this.parent.change_ch();
			trace(seqPattern)
			seqPattern[p] = myStatusList[v];
			trace(seqPattern)
			parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",setSeqPattern,"+this.parent.ch+","+seqPattern.toString());
		}
		public function resetta(p:String):void {
			loadPattern(0,"NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL");
			controller.playpause(controller.playVal);
			controller.hider(controller.hideVal);
			myPatternSel.resetta()
		}
		function loadPattern(p1:String,p:String):void {
			this.parent.change_ch();
			var tmp = p.split(",");
			for (var a = 15; a>=0; a--) {
				for (var b = 0; b<this.myStatusList.length; b++) {
					if (tmp[a] == this.myStatusList[b]) {
						trace("a: "+a+" b: "+b)
						this["s"+a].myStatusSeq = b;
						seqPattern[a] = this["s"+a].txt = this["s"+a].myList[b]
						//this["s"+a].mouseOutHandlerSeq();
						this["s"+a].mouseOutHandler(null);
					}
				}
			}
			parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",setSeqPattern,"+this.parent.ch+","+seqPattern.toString());
		}
		public function setCh(ch:uint):void {
			chSeq = ch;
		}
		public function spegni(pos:uint):void {
			if (pos>=0) {
				this["s"+pos].lab.borderColor = 0x999999;
				this["s"+pos].lab.border = false;
			}
		}
		private function avanti():void {
			if (Preferences.pref.pos["ch_"+chSeq]>14) {
				Preferences.pref.pos["ch_"+chSeq] = 0;
			} else {
				Preferences.pref.pos["ch_"+chSeq]++;
			}
		}
		public function accendi(pos):void {
			this["s"+pos].lab.borderColor = 0xFF0000;
			this["s"+pos].lab.border = true;
		}
		function seqAct():void {
			if (parent.myTapper.masterTap.myStatus) {
				for (var a:uint=0;a<Preferences.pref.nCh;a++) {
					if (Preferences.pref.interfaceTrgt.chCnt["ch_"+a].mySequencer.seqStatus) Preferences.pref.interfaceTrgt.chCnt["ch_"+a].mySequencer.spegni(Preferences.pref.pos["ch_"+chSeq]);
				}
				avanti();
				for (a=0;a<Preferences.pref.nCh;a++) {
					if (Preferences.pref.interfaceTrgt.chCnt["ch_"+a].mySequencer.seqStatus) Preferences.pref.interfaceTrgt.chCnt["ch_"+a].mySequencer.accendi(Preferences.pref.pos["ch_"+chSeq]);
				}
			} else {
				spegni(Preferences.pref.pos["ch_"+chSeq]);
				avanti();
				accendi(Preferences.pref.pos["ch_"+chSeq]);
			}
		}
		public function keyControl(n:uint):void {
			switch (n) {
			case 1 :
				if (lastStop) {
					this["s"+Preferences.pref.pos["ch_"+chSeq]].setStatus(1);
				} else {
					this["s"+Preferences.pref.pos["ch_"+chSeq]].setStatus(2);
				}
				lastStop = !lastStop;
				break;
			case 3 :
				this["s"+Preferences.pref.pos["ch_"+chSeq]].setStatus(3);
				break;
			case 4 :
				if (lastHide) {
					this["s"+Preferences.pref.pos["ch_"+chSeq]].setStatus(5);
				} else {
					this["s"+Preferences.pref.pos["ch_"+chSeq]].setStatus(4);
				}
				lastHide = !lastHide;
				break;
			}
			seqPattern[Preferences.pref.pos["ch_"+chSeq]] = this["s"+Preferences.pref.pos["ch_"+chSeq]].txt = this["s"+Preferences.pref.pos["ch_"+chSeq]].myList[this["s"+Preferences.pref.pos["ch_"+chSeq]].myStatusSeq]
			parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",setSeqPattern,"+this.parent.ch+","+seqPattern.toString());
		}
	}
}