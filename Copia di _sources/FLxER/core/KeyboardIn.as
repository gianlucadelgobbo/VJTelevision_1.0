﻿package FLxER.core {	import flash.events.*;  	import flash.ui.Keyboard;  	import flash.ui.Mouse;	public class KeyboardIn {		var a:uint;		var mouseShow:Boolean;		var MF:String;		var pressedA:Object;		public function KeyboardIn():void {			Preferences.pref.myKeyboardIn = this;			pressedA = new Object();			myEnable();		}		public function myEnable():void {			// KEYBOARD LISTNER ////////			trace("// myEnable KEYBOARD LISTNER ////////"+Preferences.pref.interfaceTrgt.parent)			Preferences.pref.interfaceTrgt.parent.stage.addEventListener(KeyboardEvent.KEY_DOWN, myOnKeyDown);  			Preferences.pref.interfaceTrgt.parent.stage.addEventListener(KeyboardEvent.KEY_UP, myOnKeyUp);  		}		public function myDisable():void {			// KEYBOARD LISTNER ////////			trace("// myDisable KEYBOARD LISTNER ////////")			Preferences.pref.interfaceTrgt.parent.stage.removeEventListener(KeyboardEvent.KEY_DOWN, myOnKeyDown);  			Preferences.pref.interfaceTrgt.parent.stage.removeEventListener(KeyboardEvent.KEY_UP, myOnKeyUp);  		}		private function myOnKeyDown(event:Event):void {			myCode = event.keyCode;			pressedA["key"+myCode] = true;			trace("myOnKeyDown"+myCode)			switch (myCode) {				// E			case 69 :				break;				// D			case 68 :								Preferences.pref.monitorTrgt.fondo.enabled = !Preferences.pref.monitorTrgt.fondo.enabled;				break;				// M			case 77 :				if (mouseShow) {					Mouse.show();				} else {					Mouse.hide();				}				mouseShow = !mouseShow;				break;				// pgup			case 33 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myLibSel.scrolla(-1);				break;				// pgdown			case 34 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myLibSel.scrolla(1);				break;				// U			case 85 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myBlend.scrolla(-1);				break;				// J			case 74 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myBlend.scrolla(1);				break;				// I			case 73 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myWipe.scrolla(-1);				break;				// K			case 75 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myWipe.scrolla(1);				break;				// +			case 107 :			case 187 :			case 221 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myTrasform.w_m.scrolla(1);				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myTrasform.h_m.scrolla(1);				break;				// -			case 109 :			case 191 :			case 189 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myTrasform.w_m.scrolla(-1);				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myTrasform.h_m.scrolla(-1);				break;				// Q			case 81 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySlider.muovi(-1);				break;				// A			case 65 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySlider.muovi(1);				break;				//////////////////////////////////////				// Z			case 90 :				Mouse.hide();				if (pressedA["key"+Keyboard.CONTROL]) {					MF = "mouseRotateZ";				} else {					MF = "mouseZoom";				}				Preferences.pref.interfaceTrgt.parent.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseListener);				//_root.onEnterFrame = mouseZoom;				break;				// S			case 83 :				Mouse.hide();				MF = "mouseScratch";	            Preferences.pref.interfaceTrgt.parent.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseListener);				break;				// RGB			case 82 :			case 71 :			case 66 :				Mouse.hide();				MF = "mouseColors";	            Preferences.pref.interfaceTrgt.parent.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseListener);				break;				// IMAGE				// Y			case 89 :				if (pressedA["key"+Keyboard.CONTROL]) {					MF = "mouseRotateY";				} else {					Mouse.hide();					MF = "mouseImage";				}				Preferences.pref.interfaceTrgt.parent.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseListener);				break;			case 79 :			case 80 :			case 86 :			case 78 :				Mouse.hide();				MF = "mouseImage";				Preferences.pref.interfaceTrgt.parent.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseListener);				break;				// W			case 87 :				Mouse.hide();				MF = "mouseSlide";				Preferences.pref.interfaceTrgt.parent.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseListener);				break;				/*//SHIFT				case Keyboard.SHIFT :				myShift();				break;*/			case Keyboard.DOWN :				if (pressedA["key"+Keyboard.CONTROL]) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySwapDepth(-1);				} else if (pressedA["key"+Keyboard.SHIFT]) {					if (Preferences.pref.monitorTrgt.parent.myTreDengine.active) {						Preferences.pref.monitorTrgt.parent.myTreDengine.avvia()					}				} else {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myFileSel.scrolla(1);				}				break;			case Keyboard.UP :				if (pressedA["key"+Keyboard.CONTROL]) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySwapDepth(1);				} else if (pressedA["key"+Keyboard.SHIFT]) {					if (Preferences.pref.monitorTrgt.parent.myTreDengine.active) {						Preferences.pref.monitorTrgt.parent.myTreDengine.avvia()					}				} else {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myFileSel.scrolla(-1);				}				break;				// SPACE			case Keyboard.SPACE :				if (pressedA["key"+Keyboard.CONTROL] && pressedA["key"+Keyboard.SHIFT]) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myController.mySolo.mouseDownHandler(null);				} else if (pressedA["key"+Keyboard.CONTROL]) {					if (Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySequencer.seqStatus) {						Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySequencer.keyControl(4);					}					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myController.myHide.mouseDownHandler(null);				} else if (pressedA["key"+Keyboard.SHIFT]) {					for (var a = 0; a<Preferences.pref.nCh; a++) {						if (Preferences.pref.interfaceTrgt.chCnt["ch_"+a].mySequencer.seqStatus) {							Preferences.pref.interfaceTrgt.chCnt["ch_"+a].mySequencer.keyControl(1);						}						Preferences.pref.interfaceTrgt.chCnt["ch_"+a].myController.myPlay.mouseDownHandler(null);					}				} else {					if (Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySequencer.seqStatus) {						Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySequencer.keyControl(1);					}					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myController.myPlay.mouseDownHandler(null);				}				break;				// LEFT			case Keyboard.LEFT :				if (pressedA["key"+Keyboard.SHIFT]) {					if (Preferences.pref.monitorTrgt.parent.myTreDengine.active) {						Preferences.pref.monitorTrgt.parent.myTreDengine.avvia()					}				} else {					if (Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySequencer.seqStatus) {						Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySequencer.keyControl(3);					}					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myController.myRew.mouseDownHandler(null);				}				break;				// RIGHT			case Keyboard.RIGHT :				if (pressedA["key"+Keyboard.SHIFT]) {					if (Preferences.pref.monitorTrgt.parent.myTreDengine.active) {						Preferences.pref.monitorTrgt.parent.myTreDengine.avvia()					}				}				break;				// T			case 84 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myTapper.takeTap(true);				break;				// X			case 88 :				if (pressedA["key"+Keyboard.SHIFT]) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].eject(null);				} else if (pressedA["key"+Keyboard.CONTROL]) {					MF = "mouseRotateX";					Preferences.pref.interfaceTrgt.parent.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseListener);				} else {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myTrasform.resetta(null);				}				break;				// L			case 76 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myLockWipe.mouseDownHandler(null);				break;				// H			case 72 :				Preferences.pref.myGlobalCtrl.puls1.mouseDownHandler(null);				break;				// C			case 67 :				if (Preferences.pref.fs) {					if (pressedA["key"+Keyboard.SHIFT]) {						Preferences.pref.myGlobalCtrl.visible = !Preferences.pref.myGlobalCtrl.visible;					} else {						Preferences.pref.interfaceTrgt.visible = !Preferences.pref.interfaceTrgt.visible;					}				}				break;				// F			case 70 :				Preferences.pref.myGlobalCtrl.puls4.mouseDownHandler(null);				break;				// 1			case 49 :				Preferences.pref.interfaceTrgt.chCnt.ch_0.change_ch();				break;				// 2			case 50 :				Preferences.pref.interfaceTrgt.chCnt.ch_1.change_ch();				break;				// 3			case 51 :				Preferences.pref.interfaceTrgt.chCnt.ch_2.change_ch();				break;				// 4			case 52 :				Preferences.pref.interfaceTrgt.chCnt.ch_3.change_ch();				break;				// 5			case 53 :				Preferences.pref.interfaceTrgt.chCnt.ch_4.change_ch();				break;				// 6			case 54 :				Preferences.pref.interfaceTrgt.chCnt.ch_5.change_ch();				break;				// 7			case 55 :				Preferences.pref.interfaceTrgt.chCnt.ch_6.change_ch();				break;			}		}		public function myOnKeyUp(event:Event):void {			myCode = event.keyCode;			pressedA["key"+myCode] = false;			trace("onKeyUp"+myCode)			if 	(Preferences.pref.interfaceTrgt.parent.stage.hasEventListener(MouseEvent.MOUSE_MOVE)) {				Preferences.pref.interfaceTrgt.parent.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseListener)			}			switch (myCode) {				// E			case 69 :					break;			case 90 :			case 83 :			case 82 :			case 71 :			case 66 :			case 89 :			case 79 :			case 80 :			case 86 :			case 78 :			case 87 :				Mouse.show();				break;				// pgup			case 33 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myLibSel.seleziona(0);				break;				// pgdown			case 34 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myLibSel.seleziona(0);				break;				// U			case 85 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myBlend.seleziona(0);				break;				// J			case 74 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myBlend.seleziona(0);				break;				// I			case 73 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myWipe.seleziona(0);				break;				// K			case 75 :				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myWipe.seleziona(0);				break;			case Keyboard.DOWN :				if (pressedA["key"+Keyboard.CONTROL]) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch]["down"].mouseDownHandler(null);				} else if (pressedA["key"+Keyboard.SHIFT]) {					/*if (!_root["myTreDengine"].onEnterFrame && _root["myTreDengine"].active) {						_root["myTreDengine"].onEnterFrame = _root["myTreDengine"].moveInScene;					}*/				} else {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myFileSel.seleziona(0);				}				break;			case Keyboard.UP :				if (pressedA["key"+Keyboard.CONTROL]) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch]["up"].mouseDownHandler(null);				} else if (pressedA["key"+Keyboard.SHIFT]) {					/*if (!_root["myTreDengine"].onEnterFrame && _root["myTreDengine"].active) {						_root["myTreDengine"].onEnterFrame = _root["myTreDengine"].moveInScene;					}*/				} else {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myFileSel.seleziona(0);				}				break;			/*case Keyboard.SPACE :				if (pressedA["key"+Keyboard.CONTROL] && pressedA["key"+Keyboard.SHIFT]) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].mySequencer.mySolo.onRelease();				}*/			}		}		private function mouseListener(event:Event):void {			trace(MF)			this[MF]()		}		// MIDI MOUSE ////		private function mouseZoom():void {			if (pressedA["key"+Keyboard.SHIFT]) {				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myTrasform.mouseScale(Preferences.pref.interfaceTrgt.mouseX/800, Preferences.pref.interfaceTrgt.mouseX/800);			} else {				Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myTrasform.mouseScale(Preferences.pref.interfaceTrgt.mouseX/800, Preferences.pref.interfaceTrgt.mouseY/600);			}/**/		}		private function mouseRotateX():void {			mouseRotateMidiX(Preferences.pref.interfaceTrgt.mouseX/2.2222222, Preferences.pref.ch);		}		private function mouseRotateY():void {			mouseRotateMidiY(Preferences.pref.interfaceTrgt.mouseX/2.2222222, Preferences.pref.ch);		}		private function mouseRotateZ():void {			mouseRotateMidiZ(Preferences.pref.interfaceTrgt.mouseX/2.2222222, Preferences.pref.ch);		}		private function mouseRotateMidiX(p:Number, ch:uint):void {			Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.mouseRotationChX(p);		}		private function mouseRotateMidiY(p:Number, ch:uint):void {			Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.mouseRotationChY(p);		}		private function mouseRotateMidiZ(p:Number, ch:uint):void {			Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.mouseRotationChZ(p);		}		private function mouseImage():void {			if (pressedA["key"+89]) {				// val 0 360				changeMatrix(int((Preferences.pref.interfaceTrgt.mouseX/800)*360), "hueSlider", Preferences.pref.ch);			}			if (pressedA["key"+79]) {				// val -300 300				changeMatrix(int(((Preferences.pref.interfaceTrgt.mouseX/800)*(300+300))-300), "satSlider", Preferences.pref.ch);			}			if (pressedA["key"+80]) {				// val -200,500				changeMatrix(int(((Preferences.pref.interfaceTrgt.mouseX/800)*(500+200))-200), "conSlider", Preferences.pref.ch);			}			if (pressedA["key"+86]) {				// val -255 255				changeMatrix(int((Preferences.pref.interfaceTrgt.mouseX-400)/1.5686), "briSlider", Preferences.pref.ch);			}			if (pressedA["key"+78]) {				// val 0 255				changeMatrix(int(Preferences.pref.interfaceTrgt.mouseX/3.1372), "thrSlider", Preferences.pref.ch);			}		}		private function mouseScratch():void {			mouseScratchMidi(Preferences.pref.interfaceTrgt.mouseX/800, Preferences.pref.ch);		}		private function mouseScratchMidi(p:Number, ch:uint):void {			Preferences.pref.monitorTrgt.mbuto((getTimer()-Preferences.pref.lastTime)+",SCRATCH"+Preferences.pref.monitorTrgt.levels["ch_"+ch].oldTipo+","+Preferences.pref.ch+","+p);		}		private function mouseColors():void {			if (pressedA["key"+Keyboard.SHIFT]) {				if (pressedA["key"+82]) {					//changeCol(int(Preferences.pref.interfaceTrgt.mouseX/3.1372), "rbSlider", Preferences.pref.ch);					changeCol((((Preferences.pref.interfaceTrgt.mouseX/800)*510)-255), "rbSlider", Preferences.pref.ch);				}				if (pressedA["key"+71]) {					changeCol(int(Preferences.pref.interfaceTrgt.mouseX/3.1372), "gbSlider", Preferences.pref.ch);				}				if (pressedA["key"+66]) {					changeCol(int(Preferences.pref.interfaceTrgt.mouseX/3.1372), "bbSlider", Preferences.pref.ch);				}			} else {				trace(Preferences.pref.interfaceTrgt.mouseX)				if (pressedA["key"+82]) {					changeCol(int((Preferences.pref.interfaceTrgt.mouseX-400)/1.5686), "rSlider",Preferences.pref.ch);				}				if (pressedA["key"+71]) {					changeCol(int((Preferences.pref.interfaceTrgt.mouseX-400)/1.5686), "gSlider", Preferences.pref.ch);				}				if (pressedA["key"+66]) {					changeCol(int((Preferences.pref.interfaceTrgt.mouseX-400)/1.5686), "bSlider", Preferences.pref.ch);				}			}		}		private function changeCol(p:Number, trgt:String, ch:uint):void {			trace("changeCol  "+p)			Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myColors[trgt].setVal(p);		}		private function changeMatrix(p:Number, trgt:String, ch:uint):void {			Preferences.pref.interfaceTrgt.chCnt["ch_"+Preferences.pref.ch].myImage[trgt].setVal(p);		}		private function mouseSlide():void {			mouseSlideAct(Preferences.pref.interfaceTrgt.mouseY/6,Preferences.pref.ch);		}		private function mouseSlideAct(p:Number, ch:uint):void {			Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].mySlider.setVal(p);		}		private function myMidi(myCode:String, val:Number, ch:uint):void {			trace("myMidi myCode: "+myCode+" val: "+val+" ch: "+ch);			switch (myCode) {			case "mouseShowHide" :				if (mouseShow) {					Mouse.show();				} else {					Mouse.hide();				}				mouseShow = !mouseShow;				break;			case "libraryScroller" :				// val 1 -1				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myLibSel.scrolla(val);				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myLibSel.seleziona(0);				break;			case "blendScroller" :				// val 1 -1				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myBlend.scrolla(val);				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myBlend.seleziona(0);				break;			case "wipeScroller" :				// val 1 -1				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myWipe.scrolla(val);				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myWipe.seleziona(0);				break;			case "zoomOneByOne" :				// val 1 -1				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.w_m.scrolla(val);				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.h_m.scrolla(val);				break;			case "zoomOneByOneX" :				// val 1 1600				trace("zoomX "+val)				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.w_m.scrolla(val);				break;			case "quickContent" :				// val n				//Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myFileSel.conta = 0;				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myFileSel.seleziona(val);				break;			case "sliderOneByOne" :				// val 1 -1				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].keySlider(val);				break;			case "topBarShowHide" :				if (Preferences.pref.fs) {					Preferences.pref.myGlobalCtrl.visible = !Preferences.pref.myGlobalCtrl.visible;				}				break;			case "bottomBarShowHide" :				if (Preferences.pref.fs) {					Preferences.pref.interfaceTrgt.visible = !Preferences.pref.interfaceTrgt.visible;				}				break;			case "rotateX" :				// val 1 1600				mouseRotateMidiX(val, ch);				break;			case "rotateY" :				// val 1 1600				mouseRotateMidiY(val, ch);				break;			case "rotateZ" :				// val 1 1600				mouseRotateMidiZ(val, ch);				break;			case "zoom" :				// val 1 1600				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.w_m.scrolla(val);				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.h_m.scrolla(val);				break;			case "scratch" :				// val 0 800				mouseScratchMidi(val/800);				break;			case "bkgOnOff" :				// val 				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myColors.myBkgOnOff.mouseDownHandler(null);				break;			case "colOnOff" :				// val 				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myColors.col_onoff.mouseDownHandler(null);				break;			case "redMovie" :				// val -255 255				changeCol(val, "rSlider", ch);				break;			case "greenMovie" :				// val -255 255				changeCol(val, "gSlider", ch);				break;			case "bluMovie" :				// val -255 255				changeCol(val, "bSlider", ch);				break;			case "redMovieB" :				// val -255 255				changeCol(val, "rbSlider", ch);				break;			case "greenMovieB" :				// val -255 255				changeCol(val, "gbSlider", ch);				break;			case "bluMovieB" :				// val -255 255				changeCol(val, "bbSlider", ch);				break;				// W			case "slider" :				// val 0 100				trace("val "+val)				trace("ch "+ch)				mouseSlideAct((val-100)*-1, ch);				break;			case "moveDown" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch]["down"].mouseDownHandler(null);				break;			case "moveUp" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch]["up"].mouseDownHandler(null);				break;			case "movieScroller" :				// val 1 -1				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myFileSel.scrolla(val);				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myFileSel.seleziona(0);				break;			case "hideShow" :				if (Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].mySequencer.seqStatus) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].mySequencer.keyControl(4);				}				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myController.myHide.mouseDownHandler(null);				break;			case "soloPress" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myController.mySolo.mouseDownHandler(null);				break;			case "stopPlay" :				if (Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].mySequencer.seqStatus) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].mySequencer.keyControl(1);				}				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].mySequencer.myPlay.mouseDownHandler(null);				break;			case "rewind" :				if (Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].mySequencer.seqStatus) {					Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].mySequencer.keyControl(3);				}				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myController.myRew.mouseDownHandler(null);				break;			case "tap" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTapper.takeTap(true);				break;			case "live" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].out_onoff.mouseDownHandler(null);				break;			case "eject" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].eject(null);				break;			case "reset" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myTrasform.resetta(null);				break;			case "lockWipes" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myLockWipe.mouseDownHandler(null);				break;			case "hiQuality" :				Preferences.pref.myGlobalCtrl.puls1.mouseDownHandler(null);				break;			case "fullScreen" :				Preferences.pref.myGlobalCtrl.puls4.mouseDownHandler(null);				break;			case "changeChannel" :				// val 2 a numero ch in flxerPref.xml				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].change_ch();				break;			case "hueMovie" :				// val 0 360				changeMatrix(val, "hueSlider", ch);				break;			case "satMovie" :				// val -300 300				changeMatrix(val, "satSlider", ch);				break;			case "conMovie" :				// val -200,500				changeMatrix(val, "conSlider", ch);				break;			case "briMovie" :				// val -255 255				changeMatrix(val, "briSlider", ch);				break;			case "thrMovie" :				// val 0 255				changeMatrix(val, "thrSlider", ch);				break;			case "thrOnOff" :				Preferences.pref.interfaceTrgt.chCnt["ch_"+ch].myImage.thrOnOff.mouseDownHandler(null);				break;			}		}	}}