package FLxER.core {
	import flash.display.Sprite;
	import flash.utils.getTimer;

	import FLxER.comp.CheckBoxBase;
	import FLxER.main.Rett;
	import FLxER.comp.ButtonRett;
	import FLxER.core.Player;

	public class Preview extends Sprite {
		var ch:Number;
		var fondo
		var fondino
		public var levels;
		//
		var n_play:Number;
		var c:Number;
		var myAction:Array;
		var alt
		var mon_onoff,mon_playstop,mon_bkg,dragButt,myMask;
		public var previewStatus:Boolean;
		public function Preview(xx, yy, ww, hh, n) {
			x = xx;
			y = yy;
			w = ww;
			h = hh;
			ch = n;
			alt = n+1;
			previewStatus = false
			fondino = new Rett(0,0,w+2,h+2,0x333333,null,1);;
			this.addChild(fondino);
			fondo = new Rett(1,1,w,h,0x000000,null,1);;
			this.addChild(fondo);
			myMask = new Rett(1,1,w,h,0x000000,null,1);;
			this.addChild(myMask);
			mon_onoff = new CheckBoxBase(46, 0, 11, 11, "PREVIEW: ", preview, null, false);
			this.addChild(mon_onoff);
			mon_playstop = new CheckBoxBase(46, 12, 11, 11, "PLAY: ", mon_play, null, false);
			this.addChild(mon_playstop);
			mon_bkg = new CheckBoxBase(46, 24, 11, 11, "BLACK BKG: ", bkg, null, false);
			this.addChild(mon_bkg);
			//filoMonitor = new Rett(1, 1, w, h, null, 0x9FF999, 1);
			//this.addChild(filoMonitor);
		}
		public function preview(val) {
			//this.parent.change_ch();
			if (!levels) {
				levels = new Object();
				levels["ch_"+ch] = new Player(ch, w, h);
				//levels["ch_"+ch].width = w;
				//levels["ch_"+ch].height = h;
				levels["ch_"+ch].x = 1;
				levels["ch_"+ch].y = 1;
				levels["ch_"+ch].myStopStatus = true;
				dragButt = new ButtonRett(1, 1, w, h, myDrag, null, alt, 0);
				dragButt.mouseUpAcivation(this.myDragStop);
			}
			if (val) {
				this.addChild(levels["ch_"+ch]);
				this.addChild(dragButt);
				levels["ch_"+ch].mask = myMask;
				previewStatus = true;
			} else {
				this.removeChild(levels["ch_"+ch]);
				this.removeChild(dragButt);
				previewStatus = false;
			}
		}
		public function mon_play(val) {
			//this.parent.change_ch();
			if (val) {
				mbuto("0,PLAY,"+ch)
			} else {
				mbuto("0,STOP,"+ch)
			}
		}
		public function bkg(p) {
			//this.parent.change_ch();
			if (p) {
				parent.change_col(this.fondo, 0xFFFFFF);
			} else {
				parent.change_col(this.fondo, 0x000000);
			}
		}
		public function mbuto(azione) {
			trace("MMmbuto"+azione);
			myAction = azione.split(",");
			trace("MMmbuto"+levels["ch_"+ch]);
			levels["ch_"+myAction[2]][myAction[1]](myAction);
		}
		function myDrag(s=0) {
			var tmp
			if (this.parent.lockWipeStatus) {
				levels["ch_"+ch].startDrag();
			} else {
				levels["ch_"+ch].cnt.startDrag();
			}
			this.addEventListener('enterFrame', chMoveMonitor);
		}
		function myDragStop() {
			this.removeEventListener('enterFrame', chMoveMonitor);
			if (this.parent.lockWipeStatus) {
				levels["ch_"+ch].stopDrag();
			} else {
				levels["ch_"+ch].cnt.stopDrag();
			}
		}
		function chMoveMonitor(e) {
			/*
			_root.myCtrl["ch_"+FlxerStarter.ch].monitor["mon"].ch_0.x = this["ch_"+FlxerStarter.ch].x;
			_root.myCtrl["ch_"+FlxerStarter.ch].monitor["mon"].ch_0.y = this["ch_"+FlxerStarter.ch].y;
			_root.myCtrl["ch_"+FlxerStarter.ch].monitor["mon"].ch_0.cnt.x = this["ch_"+FlxerStarter.ch].cnt.x;
			_root.myCtrl["ch_"+FlxerStarter.ch].monitor["mon"].ch_0.cnt.y = this["ch_"+FlxerStarter.ch].cnt.y;
			_root.myCtrl["ch_"+FlxerStarter.ch].myTrasform.x_m.val.text = this["ch_"+FlxerStarter.ch].cnt.x-200;
			_root.myCtrl["ch_"+FlxerStarter.ch].myTrasform.y_m.val.text = this["ch_"+FlxerStarter.ch].cnt.y-150;
			_root.myCtrl["ch_"+FlxerStarter.ch].myTrasform.x_ch.val.text = this["ch_"+FlxerStarter.ch].x;
			_root.myCtrl["ch_"+FlxerStarter.ch].myTrasform.y_ch.val.text = this["ch_"+FlxerStarter.ch].y;
			*/
			if (this.parent.outStatus) {
				parent.parent.parent.monitor.mbuto((getTimer()-Preferences.pref.last_time)+",chMove,"+this.ch+","+(levels["ch_"+ch].x*(400/w))+","+(levels["ch_"+ch].y*(300/h))+","+levels["ch_"+ch].cnt.x+","+levels["ch_"+ch].cnt.y);
			}
		}
	}
}