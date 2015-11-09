package FLxER.core {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;  
	import flash.display.StageAlign;
	
	public class KeyboardIn extends Sprite {
		var F:Boolean = false;
		var K:Boolean = true;
		var MSL:Object;
		var MML:Object;
		var myKL:Object;
		var myEnterListener:Object;
		var owner:Object;
		var c;
		var a;
		var mouseShow:Boolean;
		var myScaleInterface = true;
		var MF;
		var MCLMap,MMLMap
		//
		var flxerStage
		public function KeyboardIn(t) {
			flxerStage = t
			K = true;
			// STAGE ////
			trace("KeyboardIn")
			/*if (Stage.width != 800 or Stage.height != 600) {
				Stage.displayState = "normal";
				//fscommand("fullscreen", false);
				myScaleInterface = true;
			}
			// STAGE LISTNER ////////
			MSL = new Object();
			MSL.owner = this;
			MSL.onResize = function() {
				Stage.scaleMode = "exactFit";
				//owner.myScaleInterface = false;
				//fscommand("fullscreen", true);
				trace("onResize")
				Stage.displayState = "fullScreen"
			};
			c = setInterval(this, "myAdd", 1000);
			// MOUSE LISTNER ////////
			MML = new Object();
			MML.owner = this;
			MML.onMouseMove = function() {
				owner[owner.MF]();
				updateAfterEvent();
			};
			// ENTER LISTNER ////////
			myEnterListener = new Object();
			myEnterListener.owner = this;
			myEnterListener.onKeyDown = function() {
				if (Key.getAscii() == Key.ENTER) {
					Selection.setFocus(null);
				}
			};
			Key.addListener(myEnterListener);
			*/
			// KEYBOARD LISTNER ////////
			flxerStage.addEventListener(KeyboardEvent.KEY_DOWN, myOnKeyDown);  
			flxerStage.addEventListener(KeyboardEvent.KEY_UP, myOnKeyUp);  
			trace("cazzo"+flxerStage)
			/*myKL = new Object();
			myKL.owner = this;
			myKL.onKeyDown = function pressKey() {
				//trace("onKeyDown"+Key.getCode())
				//_level0.myGlobalCtrl.myTrace.text = Key.getCode();
				delete _root.onEnterFrame;
				owner.K = false;
				owner.myOnKeyDown(Key.getCode(), Preferences.pref.ch);
			};
			myKL.onKeyUp = function() {
				trace("onKeyUp"+Key.getCode())
				//_level0.myGlobalCtrl.myTrace.text = Key.getCode();
				flxerStage.removeEventListener(MouseEvent.MOUSE_OVER, MF);
				delete _root.onEnterFrame;
				owner.K = true;
				if (_root["flxerPref"].childNodes[0].childNodes[4].attributes.smoothStop == "false") {
					delete _root["myTreDengine"].onEnterFrame;
				}
				owner.myOnKeyUp(Key.getCode(), Preferences.pref.ch);
			};
			Key.addListener(myKL);
			*/
			/*
			this.MCLMap = new Object();
			this.MCLMap["ow"] = this;
			this.MCLMap.onMouseDown = function() {
				this["ow"].myMouseDownMap();
				updateAfterEvent();
				Mouse.addListener(this["ow"].MMLMap);
			};
			this.MCLMap.onMouseUp = function() {
				Mouse.removeListener(this["ow"].MMLMap);
			};
			this.MMLMap = new Object();
			this.MMLMap["ow"] = this;
			this.MMLMap.onMouseMove = function() {
				this["ow"].myMouseMoveMap();
			};
			*/
		}
		function myOnKeyUp(event) {
			myCode = event.keyCode;
			trace("onKeyUp"+myCode)
			//_level0.myGlobalCtrl.myTrace.text = Key.getCode();
			flxerStage.removeEventListener(MouseEvent.MOUSE_OVER, MF);
			//delete _root.onEnterFrame;
			//owner.K = true;
			//if (Preferences.pref.flxerPref.childNodes[0].childNodes[4].attributes.smoothStop == "false") {
				//delete _root["myTreDengine"].onEnterFrame;
			//}
			/*if (Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].activeKey && Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"]["mask"]["trgt3"]["shapes"]) {
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"].alpha = 100;
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cnt"].setMask(Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"]);
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].activeKey = false;
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["handles"].y = -10000;
				trace("stacaaaaa "+Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].MCL)
				Mouse.removeListener(MCLMap);
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].currentShape = undefined;
				if (Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].shapesA.length>0) {
					_root["flxerDrawedMasks"].data.lista[Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].currentMask] = Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].shapesA;
				}
				Preferences.pref.eventTrgt.fondo.enabled = true;
			}*/
			switch (myCode) {
				// E
			case 69 :
					break;
			case 90 :
			case 83 :
			case 82 :
			case 71 :
			case 66 :
			case 89 :
			case 79 :
			case 80 :
			case 86 :
			case 78 :
			case 87 :
				Mouse.show();
				break;
				// pgup
			case 33 :
				trgtInterface["ch_"+Preferences.pref.ch].myLibSel.seleziona(0);
				break;
				// pgdown
			case 34 :
				trgtInterface["ch_"+Preferences.pref.ch].myLibSel.seleziona(0);
				break;
			/*case Key.DOWN :
				if (!Key.isDown(Key.CONTROL) && !Key.isDown(Key.SHIFT)) {
					trgtInterface["ch_"+Preferences.pref.ch].myListBox.seleziona(0);
				}
				break;
			case Key.UP :
				if (!Key.isDown(Key.CONTROL) && !Key.isDown(Key.SHIFT)) {
					trgtInterface["ch_"+Preferences.pref.ch].myListBox.seleziona(0);
				}
				break;*/
				// U
			case 85 :
				trgtInterface["ch_"+Preferences.pref.ch].myBlend.seleziona(0);
				break;
				// J
			case 74 :
				trgtInterface["ch_"+Preferences.pref.ch].myBlend.seleziona(0);
				break;
				// I
			case 73 :
				trgtInterface["ch_"+Preferences.pref.ch].myWipe.seleziona(0);
				break;
				// K
			case 75 :
				trgtInterface["ch_"+Preferences.pref.ch].myWipe.seleziona(0);
				break;
			/*case Key.SPACE :
				if (Key.isDown(Key.CONTROL) && Key.isDown(Key.SHIFT)) {
					trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySolo.onRelease();
				}*/
			}
		}
		function myOnKeyDown(event) {
			myCode = event.keyCode;
			//delete _root.onEnterFrame;
			//owner.K = false;
			/*if (myCode != 69 && Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].activeKey && Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"]["mask"]["trgt3"]["shapes"]) {
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"].alpha = 100;
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cnt"].setMask(Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"]);
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].activeKey = false;
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"]["mask"]["trgt3"]["handles"].y = -10000;
				trace("stacaaaaa "+Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].MCL)
				Mouse.removeListener(MCLMap);
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].currentShape = undefined;
				if (Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].shapesA.length>0) {
					_root["flxerDrawedMasks"].data.lista[Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].currentMask] = Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].shapesA;
				}
				Preferences.pref.eventTrgt.fondo.enabled = true;
			}*/
			switch (myCode) {
				// E
			case 69 :
				/*if (!Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].activeKey && Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"]["mask"]["trgt3"]["shapes"]) {
					Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cnt"].setMask(null);
					Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"].alpha = 50;
					Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].activeKey = true;
					Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch]["cntMask"]["mask"]["trgt3"]["handles"].y = 0;
					Mouse.addListener(MCLMap);
					trace("attacca "+Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].MCL)
					Preferences.pref.eventTrgt.fondo.enabled = false;
				}
				break;*/
				// D
			case 68 :
				
				Preferences.pref.eventTrgt.fondo.enabled = !Preferences.pref.eventTrgt.fondo.enabled;
				break;
				// M
			case 77 :
				if (mouseShow) {
					Mouse.show();
				} else {
					Mouse.hide();
				}
				mouseShow = !mouseShow;
				break;
				// pgup
			case 33 :
			trace("cazzo1");
				trgtInterface["ch_"+Preferences.pref.ch].myLibSel.scrolla(-1);
				break;
				// pgdown
			case 34 :
			trace("cazzo2"+trgtInterface["ch_"+Preferences.pref.ch].myLibSel.scrolla);
				trgtInterface["ch_"+Preferences.pref.ch].myLibSel.scrolla(1);
				break;
				// U
			case 85 :
				trgtInterface["ch_"+Preferences.pref.ch].myBlend.scrolla(-1);
				break;
				// J
			case 74 :
				trgtInterface["ch_"+Preferences.pref.ch].myBlend.scrolla(1);
				break;
				// I
			case 73 :
				trgtInterface["ch_"+Preferences.pref.ch].myWipe.scrolla(-1);
				break;
				// K
			case 75 :
				trgtInterface["ch_"+Preferences.pref.ch].myWipe.scrolla(1);
				break;
				// +
			case 107 :
			case 187 :
			case 221 :
				trgtInterface["ch_"+Preferences.pref.ch].myTrasform.myScaleXY(1);
				break;
				// -
			case 109 :
			case 191 :
			case 189 :
				trgtInterface["ch_"+Preferences.pref.ch].myTrasform.myScaleXY(-1);
				break;
				// Q
			case 81 :
				trgtInterface["ch_"+Preferences.pref.ch].keySlider(1);
				break;
				// A
			case 65 :
				trgtInterface["ch_"+Preferences.pref.ch].keySlider(-1);
				break;
				//////////////////////////////////////
				// C
			case 67 :
				if (F) {
					/*if (Key.isDown(Key.SHIFT)) {
						_root.myGlobalCtrl.visible = !_root.myGlobalCtrl.visible;
					} else {
						trgtInterface["ch_"+Preferences.pref.ch].visible = !trgtInterface["ch_"+Preferences.pref.ch].visible;
					}*/
				}
				break;
				// Z
			case 90 :
				/*Mouse.hide();
				if (Key.isDown(Key.CONTROL)) {
					MF = "mouseRotate";
				} else {
					MF = "mouseZoom";
				}
				flxerStage.addEventListener(MouseEvent.MOUSE_OVER, MF);
				//_root.onEnterFrame = mouseZoom;*/
				break;
				// S
			case 83 :
				/*Mouse.hide();
				_root.onEnterFrame = function() {
					_root.mykeyboard.mouseScratch();
				};*/
				break;
				// RGB
			case 82 :
			case 71 :
			case 66 :
				Mouse.hide();
				MF = "mouseColors";
	            flxerStage.addEventListener(MouseEvent.MOUSE_OVER, MF);
				flxerStage.addEventListener(MouseEvent.MOUSE_OVER, MF);
				break;
				// IMAGE
			case 89 :
			case 79 :
			case 80 :
			case 86 :
			case 78 :
				Mouse.hide();
				MF = "mouseImage";
				flxerStage.addEventListener(MouseEvent.MOUSE_OVER, MF);
				break;
				// W
				// W
			case 87 :
				Mouse.hide();
				MF = "mouseSlide";
				flxerStage.addEventListener(MouseEvent.MOUSE_OVER, MF);
				break;
				/*//SHIFT
				case Key.SHIFT :
				myShift();
				break;*/
			case Key.DOWN :
				if (Key.isDown(Key.CONTROL)) {
					trgtInterface["ch_"+Preferences.pref.ch]["down"].onPress();
				} else if (Key.isDown(Key.SHIFT)) {
					if (!_root["myTreDengine"].onEnterFrame && _root["myTreDengine"].active) {
						_root["myTreDengine"].onEnterFrame = _root["myTreDengine"].moveInScene;
					}
				} else {
					trgtInterface["ch_"+Preferences.pref.ch].myListBox.scrolla(1);
				}
				break;
			case Key.UP :
				if (Key.isDown(Key.CONTROL)) {
					trgtInterface["ch_"+Preferences.pref.ch]["up"].onPress();
				} else if (Key.isDown(Key.SHIFT)) {
					if (!_root["myTreDengine"].onEnterFrame && _root["myTreDengine"].active) {
						_root["myTreDengine"].onEnterFrame = _root["myTreDengine"].moveInScene;
					}
				} else {
					trgtInterface["ch_"+Preferences.pref.ch].myListBox.scrolla(-1);
				}
				break;
				// SPACE
			case Key.SPACE :
				if (Key.isDown(Key.CONTROL) && Key.isDown(Key.SHIFT)) {
					trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySolo.onPress();
				} else if (Key.isDown(Key.CONTROL)) {
					if (trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySequencerStatus) {
						trgtInterface["ch_"+Preferences.pref.ch].mySequencer.keyControl(4);
					}
					trgtInterface["ch_"+Preferences.pref.ch].mySequencer.myHide.onPress();
				} else if (Key.isDown(Key.SHIFT)) {
					for (var a = 0; a<_root.nCh; a++) {
						if (trgtInterface["ch_"+a].mySequencer.mySequencerStatus) {
							trgtInterface["ch_"+a].mySequencer.keyControl(1);
						}
						trgtInterface["ch_"+a].mySequencer.myPlay.onPress();
					}
				} else {
					if (trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySequencerStatus) {
						trgtInterface["ch_"+Preferences.pref.ch].mySequencer.keyControl(1);
					}
					trgtInterface["ch_"+Preferences.pref.ch].mySequencer.myPlay.onPress();
				}
				break;
				// LEFT
			case Key.LEFT :
				if (Key.isDown(Key.SHIFT)) {
					if (!_root["myTreDengine"].onEnterFrame && _root["myTreDengine"].active) {
						_root["myTreDengine"].onEnterFrame = _root["myTreDengine"].moveInScene;
					}
				} else {
					if (trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySequencerStatus) {
						trgtInterface["ch_"+Preferences.pref.ch].mySequencer.keyControl(3);
					}
					trgtInterface["ch_"+Preferences.pref.ch].mySequencer.rewindplaypause();
				}
				break;
				// RIGHT
			case Key.RIGHT :
				if (Key.isDown(Key.SHIFT)) {
					if (!_root["myTreDengine"].onEnterFrame && _root["myTreDengine"].active) {
						_root["myTreDengine"].onEnterFrame = _root["myTreDengine"].moveInScene;
					}
				}
				break;
				// T
			case 84 :
				trgtInterface["ch_"+Preferences.pref.ch].mySequencer.takeTap();
				break;
				// X
			case 88 :
				if (Key.isDown(Key.SHIFT)) {
					trgtInterface["ch_"+Preferences.pref.ch].eject();
				} else {
					trgtInterface["ch_"+Preferences.pref.ch].myTrasform.reset_trans();
				}
				break;
				// L
			case 76 :
				trgtInterface["ch_"+Preferences.pref.ch].myLockWipe.onPress();
				break;
				// H
			case 72 :
				_root.myGlobalCtrl.puls1.onPress();
				break;
				// F
			case 70 :
				_root.myGlobalCtrl.puls3.onPress();
				break;
				// 1
			case 49 :
				changeChannel(0);
				break;
				// 2
			case 50 :
				changeChannel(1);
				break;
				// 3
			case 51 :
				changeChannel(2);
				break;
				// 4
			case 52 :
				changeChannel(3);
				break;
				// 5
			case 53 :
				changeChannel(4);
				break;
				// 6
			case 54 :
				changeChannel(5);
				break;
				// 7
			case 55 :
				changeChannel(6);
				break;
			}
		}
		function myMouseDownMap() {
			trace("myMouseDownMapmyMouseDownMapmyMouseDownMapmyMouseDownMapmyMouseDownMapmyMouseDownMap")
			if(Key.isDown(69)) {
				Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].myMouseDown();
			} else {
				trace("ERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRROOOOOOOOOOOOOOOOOOORRRRRRRRRRRREEEEEEEEEEEEEE")
				Mouse.removeListener(MCLMap);
			}
		}
		function myMouseMoveMap() {
			Preferences.pref.eventTrgt.levels["ch_"+Preferences.pref.ch].myMouseMove()
		}
		function myAdd() {
			clearInterval(c);
			Stage.addListener(MSL);
		}
		function myFullscreen() {
			/*clearInterval(c);
			if (F) {
				Stage.scaleMode = "noScale";
				if (myScaleInterface) {
					//fscommand("fullscreen", false);
					Stage.displayState = "normal";
				}
				Preferences.pref.eventTrgt.x = 200;
				Preferences.pref.eventTrgt.y = 23;
				Preferences.pref.eventTrgt.xscale = Preferences.pref.eventTrgt.yscale=100;
				for (a=0; a<_root.nCh; a++) {
					//trgtInterface["ch_"+a].y = (563-(40*(7-_root.nCh)))-(40*this.a);
					trgtInterface["ch_"+a].y = (563-(40*(7-_root.nCh)))-(40*trgtInterface["ch_"+a].myDepth);
					trgtInterface["ch_"+a].visible = true;
				}
				_root.myGlobalCtrl.visible = true;
				F = false;
				c = setInterval(this, "myAdd", 1000);
			} else {
				Stage.removeListener(MSL);
				for (a=0; a<_root.nCh; a++) {
					trgtInterface["ch_"+a].y = 563;
					trgtInterface["ch_"+a].visible = false;
				}
				_root.myGlobalCtrl.visible = false;
				//fscommand("fullscreen", true);
				Stage.displayState = "fullscreen";
				Stage.scaleMode = "exactFit";
				Preferences.pref.eventTrgt.x = Preferences.pref.eventTrgt.y=0;
				Preferences.pref.eventTrgt.xscale = Preferences.pref.eventTrgt.yscale=200;
				F = true;
			}*/
		}
		// MIDI MOUSE ////
		function mouseZoom() {
			/*if (Key.isDown(Key.SHIFT)) {
				trgtInterface["ch_"+Preferences.pref.ch].myTrasform.mouseScaleFix(_root.xmouse*2);
			} else {
				trgtInterface["ch_"+Preferences.pref.ch].myTrasform.mouseScale(_root.xmouse*2, _root.ymouse*2);
			}*/
		}
		function mouseRotate() {
			//mouseRotateMidi(_root.xmouse/2.2222222);
		}
		function mouseRotateMidi(p) {
			//trgtInterface["ch_"+Preferences.pref.ch].myTrasform.r_ch.val.text = p;
			//trgtInterface["ch_"+Preferences.pref.ch].myTrasform.myEnterR(p);
		}
		function mouseScratch() {
			//mouseScratchMidi(_root.xmouse);
		}
		function mouseImage() {
			if (Key.isDown(89)) {
				// val 0 360
				changeMatrix(int((_root.xmouse/800)*360), "hueSlider", Preferences.pref.ch);
			}
			if (Key.isDown(79)) {
				// val -300 300
				changeMatrix(int(((_root.xmouse/800)*(300+300))-300), "satSlider", Preferences.pref.ch);
			}
			if (Key.isDown(80)) {
				// val -200,500
				changeMatrix(int(((_root.xmouse/800)*(500+200))-200), "conSlider", Preferences.pref.ch);
			}
			if (Key.isDown(86)) {
				// val -255 255
				changeMatrix(int((_root.xmouse-400)/1.5686), "briSlider", Preferences.pref.ch);
			}
			if (Key.isDown(78)) {
				// val 0 255
				changeMatrix(int(_root.xmouse/3.1372), "thrSlider", Preferences.pref.ch);
			}
		}
		function mouseScratchMidi(p) {
			Preferences.pref.eventTrgt.mbuto((getTimer()-_root.myGlobalCtrl.myRecorder.last_time)+",scratch"+Preferences.pref.eventTrgt.mon["ch_"+Preferences.pref.ch].oldTipo+","+Preferences.pref.ch+","+p);
		}
		function mouseColors() {
			if (Key.isDown(Key.SHIFT)) {
				if (Key.isDown(82)) {
					changeCol(int(_root.xmouse/3.1372), "rbSlider", Preferences.pref.ch);
				}
				if (Key.isDown(71)) {
					changeCol(int(_root.xmouse/3.1372), "gbSlider", Preferences.pref.ch);
				}
				if (Key.isDown(66)) {
					changeCol(int(_root.xmouse/3.1372), "bbSlider", Preferences.pref.ch);
				}
			} else {
				if (Key.isDown(82)) {
					changeCol(int((_root.xmouse-400)/1.5686), "rSlider",Preferences.pref.ch);
				}
				if (Key.isDown(71)) {
					changeCol(int((_root.xmouse-400)/1.5686), "gSlider", Preferences.pref.ch);
				}
				if (Key.isDown(66)) {
					changeCol(int((_root.xmouse-400)/1.5686), "bSlider", Preferences.pref.ch);
				}
			}
		}
		function changeCol(p, trgt, ch) {
			trace("changeCol  "+p)
			trgtInterface["ch_"+Preferences.pref.ch].myColors[trgt].lab.val.text = p;
			trgtInterface["ch_"+Preferences.pref.ch].myColors[trgt].muovi();
		}
		function mouseSlide() {
			mouseSlideAct(_root.ymouse/6, Preferences.pref.ch);
		}
		function mouseSlideAct(p, ch) {
			trgtInterface["ch_"+Preferences.pref.ch].mouseSlider(p);
		}
		function changeMatrix(p, trgt, ch) {
			trgtInterface["ch_"+Preferences.pref.ch].myImage[trgt].lab.val.text = p;
			trgtInterface["ch_"+Preferences.pref.ch].myImage[trgt].muovi();
		}
		function myMidi(myCode, val, ch) {
			//trace("myMidi myCode: "+myCode+" val: "+val+" ch: "+ch);
			switch (myCode) {
			case "mouseShowHide" :
				if (mouseShow) {
					Mouse.show();
				} else {
					Mouse.hide();
				}
				mouseShow = !mouseShow;
				break;
			case "libraryScroller" :
				// val 1 -1
				trgtInterface["ch_"+Preferences.pref.ch].myLibSel.seleziona(val);
				break;
			case "blendScroller" :
				// val 1 -1
				trgtInterface["ch_"+Preferences.pref.ch].myBlend.scrolla(val);
				trgtInterface["ch_"+Preferences.pref.ch].myBlend.seleziona(0);
				break;
			case "wipeScroller" :
				// val 1 -1
				trgtInterface["ch_"+Preferences.pref.ch].myWipe.scrolla(val);
				trgtInterface["ch_"+Preferences.pref.ch].myWipe.seleziona(0);
				break;
			case "zoomOneByOne" :
				// val 1 -1
				trgtInterface["ch_"+Preferences.pref.ch].myTrasform.myScaleXY(val);
				break;
			case "zoomOneByOneX" :
				// val 1 1600
				trace("zoomX "+val)
				trgtInterface["ch_"+Preferences.pref.ch].myTrasform.myScaleX(val);
				break;
			case "quickContent" :
				// val n
				trgtInterface["ch_"+Preferences.pref.ch].myListBox.conta = 0;
				trgtInterface["ch_"+Preferences.pref.ch].myListBox.seleziona(val);
				break;
			case "sliderOneByOne" :
				// val 1 -1
				trgtInterface["ch_"+Preferences.pref.ch].keySlider(val);
				break;
			case "topBarShowHide" :
				if (F) {
					_root.myGlobalCtrl.visible = !_root.myGlobalCtrl.visible;
				}
				break;
			case "bottomBarShowHide" :
				if (F) {
					trgtInterface["ch_"+Preferences.pref.ch].visible = !trgtInterface["ch_"+Preferences.pref.ch].visible;
				}
				break;
			case "rotate" :
				// val 1 1600
				mouseRotateMidi(val, ch);
				break;
			case "zoom" :
				// val 1 1600
				trgtInterface["ch_"+Preferences.pref.ch].myTrasform.mouseScaleFix(val);
				break;
			case "scratch" :
				// val 0 800
				mouseScratchMidi(val);
				break;
			case "bkgOnOff" :
				// val 
				trgtInterface["ch_"+Preferences.pref.ch].myColors.myBkgOnOff.onPress();
				break;
			case "colOnOff" :
				// val 
				trgtInterface["ch_"+Preferences.pref.ch].myColors.col_onoff.onPress();
				break;
			case "redMovie" :
				// val -255 255
				changeCol(val, "rSlider", ch);
				break;
			case "greenMovie" :
				// val -255 255
				changeCol(val, "gSlider", ch);
				break;
			case "bluMovie" :
				// val -255 255
				changeCol(val, "bSlider", ch);
				break;
			case "redMovieB" :
				// val -255 255
				changeCol(val, "rbSlider", ch);
				break;
			case "greenMovieB" :
				// val -255 255
				changeCol(val, "gbSlider", ch);
				break;
			case "bluMovieB" :
				// val -255 255
				changeCol(val, "bbSlider", ch);
				break;
				// W
			case "slider" :
				// val 0 100
				trace("val "+val)
				trace("ch "+ch)
				mouseSlideAct((val-100)*-1, ch);
				break;
			case "moveDown" :
				trgtInterface["ch_"+Preferences.pref.ch]["down"].onPress();
				break;
			case "moveUp" :
				trgtInterface["ch_"+Preferences.pref.ch]["up"].onPress();
				break;
			case "movieScroller" :
				// val 1 -1
				trgtInterface["ch_"+Preferences.pref.ch].myListBox.scrolla(val);
				trgtInterface["ch_"+Preferences.pref.ch].myListBox.seleziona(0);
				break;
			case "hideShow" :
				if (trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySequencerStatus) {
					trgtInterface["ch_"+Preferences.pref.ch].mySequencer.keyControl(4);
				}
				trgtInterface["ch_"+Preferences.pref.ch].mySequencer.myHide.onPress();
				break;
			case "soloPress" :
				trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySolo.onPress();
				break;
			case "soloRelease" :
				trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySolo.onRelease();
				break;
			case "stopPlay" :
				if (trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySequencerStatus) {
					trgtInterface["ch_"+Preferences.pref.ch].mySequencer.keyControl(1);
				}
				trgtInterface["ch_"+Preferences.pref.ch].mySequencer.myPlay.onPress();
				break;
			case "rewind" :
				if (trgtInterface["ch_"+Preferences.pref.ch].mySequencer.mySequencerStatus) {
					trgtInterface["ch_"+Preferences.pref.ch].mySequencer.keyControl(3);
				}
				trgtInterface["ch_"+Preferences.pref.ch].mySequencer.myRew.onPress();
				break;
			case "tap" :
				trgtInterface["ch_"+Preferences.pref.ch].mySequencer.takeTap();
				break;
			case "live" :
				trgtInterface["ch_"+Preferences.pref.ch].out_onoff.onPress();
				break;
			case "eject" :
				trgtInterface["ch_"+Preferences.pref.ch].eject();
				break;
			case "reset" :
				trgtInterface["ch_"+Preferences.pref.ch].myTrasform.reset_trans();
				break;
			case "lockWipes" :
				trgtInterface["ch_"+Preferences.pref.ch].myLockWipe.onPress();
				break;
			case "hiQuality" :
				_root.myGlobalCtrl.puls1.onPress();
				break;
			case "fullScreen" :
				_root.myGlobalCtrl.puls3.onPress();
				break;
			case "changeChannel" :
				// val 2 a numero ch in flxerPref.xml
				changeChannel(val);
				break;
			case "hueMovie" :
				// val 0 360
				changeMatrix(val, "hueSlider", ch);
				break;
			case "satMovie" :
				// val -300 300
				changeMatrix(val, "satSlider", ch);
				break;
			case "conMovie" :
				// val -200,500
				changeMatrix(val, "conSlider", ch);
				break;
			case "briMovie" :
				// val -255 255
				changeMatrix(val, "briSlider", ch);
				break;
			case "thrMovie" :
				// val 0 255
				changeMatrix(val, "thrSlider", ch);
				break;
			case "thrOnOff" :
				trgtInterface["ch_"+Preferences.pref.ch].myImage.thrOnOff.onPress();
				break;
			}
		}
		function changeChannel(p) {
			if (p<_root.nCh) {
				if (F) {
					if (trgtInterface["ch_"+Preferences.pref.ch].visible) {
						this.bottomONOFF(false);
						Preferences.pref.ch = p;
						this.bottomONOFF(true);
					} else {
						Preferences.pref.ch = p;
					}
				}
				trgtInterface["ch_"+p].change_ch();
			}
		}
		function bottomONOFF(p) {
			trgtInterface["ch_"+Preferences.pref.ch].visible = p;
		}
		function topONOFF(p) {
			_root.myGlobalCtrl.visible = p;
		}
	}
}