package FLxER.panels{
	import flash.display.Sprite;
	import flash.utils.*;
	import flash.display.DisplayObjectContainer.*
	import flash.geom.ColorTransform;
	import flash.xml.XMLDocument;
	import flash.net.*;
	import flash.events.*;
	import flash.display.Loader;
    import flash.net.FileReference;


	import FLxER.main.Rett;
	import FLxER.main.Txt;
	import FLxER.comp.CheckBoxBase;
	import FLxER.comp.ButtonTxt;
	import FLxER.comp.ButtonArrow;
	import FLxER.comp.ListMenu;
	import FLxER.comp.ListBox;
	import FLxER.comp.SliderCh;
	import FLxER.panels.Preview;
	import FLxER.panels.Sequencer;
	import FLxER.panels.ColorsCtrl;
	import FLxER.panels.Trasform;
	import FLxER.panels.Image;
	import FLxER.panels.Controller;
	public class ChCtrl extends Sprite {

		public var myDepth:Number;
		public var ch:Number;
		var myPath:String;
		var sliderVal:Number;
		public var outStatus:Boolean;
		public var lockWipeStatus:Boolean;
		var liveA:Object;
		//
		var fondino:Rett;
		public var mySlider:SliderCh;
		var out_onoff:CheckBoxBase;
		public var myLibSel:ListMenu;
		var myEject:ButtonTxt;
		public var myFileSel:ListBox;
		var myDvIn:CheckBoxBase;
		var myMovie:Txt;
		public var treD:CheckBoxBase;
		var myMovieL:ButtonTxt;
		var dl:Txt;
		var myDepthF:Txt;
		public var down:ButtonArrow;
		public var up:ButtonArrow;
		public var myBlend:ListMenu;
		public var myLockWipe:CheckBoxBase;
		public var myWipe:ListMenu;
		var myTxtEditorP:CheckBoxBase;
		var myTxtEditor:TxtEditor;
		public var monitor:Preview;
		var fondinoLabW:Rett;
		var fondinoLab:Rett;
		var lab:Txt;
		var led:Rett;
		var myColorsVisualizer:ButtonTxt;
		public var myColors:ColorsCtrl;
		var myTrasformVisualizer:ButtonTxt;
		public var myTrasform:Trasform;
		var myImageVisualizer:ButtonTxt;
		public var myImage:Image;
		public var mySequencer:Sequencer;
		public var myController:Controller;
		public var myTapper:Tapper;
		//
		var myPalette:Array;
		var myFileList:XMLDocument;
		/**/
		var a:uint;
		var c:uint;
		var l:uint;
		var current_mov:String;
		var lastLiveAct:String;
		var tipo:String;
		var oldTipo:String;
		////
		var currLib:String;
		var myLoader:URLLoader
		var MyFile:FileReference
		public function ChCtrl(a:uint):void {
			myDepth = ch = a;
			y = (563-(40*(7-Preferences.pref.nCh)))-(40*ch);
			myPath = "";
			sliderVal = 100;
			outStatus = true;
			//this.monitor.mon.ch_0.myStopStatus = myPreviewStopStatus=true;
			lockWipeStatus = false;
			liveA = new Object();

			// CHANNEL DESIGN //
			fondino = new Rett(0, 0, 800, 37, 0x909090, -1, .5);
			this.addChild(fondino);
			//
			mySlider = new SliderCh(60, 1, 18, 35, sliderFnz, "Q / A or W + Y MOUSE");
			this.addChild(mySlider);
			out_onoff = new CheckBoxBase(80, 1, 22, 11, "LIVE", live, null, true);
			this.addChild(out_onoff);
			myLibSel = new ListMenu(104, 1, 100, 11, "select playlist", loadLib, "PAGE UP / PAGE DOWN", Preferences.pref.libraryList.childNodes[0], 3);
			this.addChild(myLibSel);
			this.myEject = new ButtonTxt(91, 13, 11, 11, "I>", eject, null, "SHIFT + X");
			this.myEject.rotation = 90;
			this.addChild(myEject);
			myFileSel = new ListBox(92, 13, 140, 11, myLoadMovie, null, 1, "ARROW UP", "ARROW DOWN");
			this.addChild(myFileSel);
			myDvIn = new CheckBoxBase(206, 1, 26, 11, "DV-IN", loadDvIn, null, false);
			this.addChild(myDvIn);
			myMovie = new Txt(102, 25, 105, 11, "", Preferences.pref.th, "input");
			this.addChild(myMovie);
			this.treD = new CheckBoxBase(80, 25, 20, 11, "3 D", treDengineONOFF, "USE SHIFT + ARROW KEY", false);
			this.addChild(treD);
			myMovieL = new ButtonTxt(208, 25, 24, 11, "LOAD", load_url, null, null);
			this.addChild(myMovieL);
			
			dl = new Txt(237, 1, 33, 11, "DEPTH", Preferences.pref.th, null);
			this.addChild(dl);
			myDepthF = new Txt(274, 1, 15, 11, this.ch+1, Preferences.pref.th, null);
			this.addChild(myDepthF);
			this.down = new ButtonArrow(269, 1, 90, mySwapDepth, -1, "CTRL + ARROW UP");
			this.addChild(down);
			this.up = new ButtonArrow(283, 1, -90, mySwapDepth, 1, "CTRL + ARROW DOWN");
			this.addChild(up);
			
			myBlend = new ListMenu(344, 1, 62, 11, "BLEND NORMAL", changeBlend, "PAGE UP / PAGE DOWN", Preferences.pref.blendList.childNodes[0], 3);
			this.addChild(myBlend);
			myLockWipe = new CheckBoxBase(408, 1, 11, 11, "WIPE LOCK: ", lockWipe, "L", false);
			this.addChild(myLockWipe);
			myWipe = new ListMenu(418, 1, 70, 11, "WIPE NONE (MIX)", changeWipe, null, Preferences.pref.plugin.childNodes[0].childNodes[0], 3);
			this.addChild(myWipe);
			/////// TXT EDITOR ///
			myTxtEditorP = new CheckBoxBase(295, 1, 47, 11, "TXT EDITOR", showTxtEditor, null, false);
			this.addChild(myTxtEditorP);
			myTxtEditor = new TxtEditor(80,1);
			this.addChild(myTxtEditor);
			/////////////////////
			// Preview
			monitor = new Preview(1, 1, 44, 33, ch);
			this.addChild(monitor);
			// Led e Label
			fondinoLabW = new Rett(2, 2, 44, 9, 0xFFFFFF, -1, .45);
			this.addChild(fondinoLabW);
			fondinoLab = new Rett(2, 2, 44, 9, 0x000000, -1, .15);
			this.addChild(fondinoLab);
			lab = new Txt(10, 1, 27, 11, "CH: "+(this.ch+1), Preferences.pref.th, null);
			this.addChild(lab);
			led = new Rett(3, 3, 7, 7, 0x000000, -1, 1);
			this.addChild(led);
			/////// COLORS ///
			myColorsVisualizer = new ButtonTxt(495, 1, 44, 11, "COLORS", paletteHideShow, 0, null); // manca param:"myColors"
			this.addChild(myColorsVisualizer);
			this.myColors = new ColorsCtrl(541, 1);
			this.addChild(myColors);
			////////////////////////
			///// TRASFORM ///
			myTrasformVisualizer = new ButtonTxt(495, 11, 44, 11, "TRASFORM", paletteHideShow, 1, null); // manca param:"myTrasform"
			this.addChild(myTrasformVisualizer);
			this.myTrasform = new Trasform(541, 1, ch);
			this.addChild(myTrasform);
			//////////////////////////////////
			/////// IMAGE ///
			myImageVisualizer = new ButtonTxt(495, 21, 44, 11, "IMAGE", paletteHideShow, 2, null); // manca param:"myEffects"
			this.addChild(myImageVisualizer);
			this.myImage = new Image(541, 1);
			this.addChild(myImage);
			//
			this.myPalette = new Array("myColors", "myTrasform", "myImage");
			/////// SEQUENCER ///
			this.myController = new Controller(240,13);
			this.addChild(myController);
			this.mySequencer = new Sequencer(295,13,myController, ch);
			this.addChild(mySequencer);
			this.setChildIndex(myController, this.numChildren-1)
			this.myTapper = new Tapper(240,25,ch);
			this.addChild(myTapper);
		///////
			
			this.myColorsVisualizer.myDisable();
			//this.myTrasformVisualizer.myDisable();
			//this.myImageVisualizer.myDisable();
			//this.myColors.visible = false;
			this.myTrasform.visible = false;
			this.myImage.visible = false;
			//this.myTxtEditor.center.onPress();
			MyFile = new FileReference();
			MyFile.addEventListener(Event.SELECT, selectHandler);
            MyFile.addEventListener(Event.COMPLETE, useMap);
		}
		private function selectHandler(event:Event):void {
            var file:FileReference = FileReference(event.target);
            trace("selectHandler: name=" + file.name);
            MyFile.load();
        }
		public function useMap(event:Event) {
			lastLiveAct = ",useMap,"+this.ch+","+Preferences.myReplace(MyFile.data,",",";");
			trace(MyFile.data)
			//this.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",changeBlend,"+ch+","+p);
			if (outStatus) {
				parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+lastLiveAct);
			} else {
				liveA.useMap = lastLiveAct;
			}
			sliderFnz2();
		}
		public function initHandlerSWF(l:Loader):void {
		}
		public function initHandlerJPG(l:Loader):void {
		}
		public function initHandlerFLV(event:Event):void {
		}
		public function initHandlerMP3():void {
		}
		public function change_ch():void {
			if (Preferences.pref.ch != this.ch){
				Preferences.pref.ch = this.ch;
				for (var a=0; a<Preferences.pref.nCh; a++) {
					this.change_col(this.parent.chCnt["ch_"+a].led, 0x00000);
					if (Preferences.pref.fs) {
						this.parent.chCnt["ch_"+a].visible = false;
					}
				}
				this.change_col(this.led, 0xFF0000);
			}
			if (Preferences.pref.fs) {
				this.visible = true;
			}
		}
		function treDengineONOFF(p:String):void {
			parent.parent.myTreDengine.treDengineONOFF(p, ch)
		}
		public function change_col(trgt:Sprite, col:uint):void {
			var myCol:ColorTransform = trgt.transform.colorTransform;
			myCol.color = col;
			trgt.transform.colorTransform = myCol;
		}
		function loadLib(a:String,b:String):void {
			change_ch();
			l = 0;
			currLib = b;
			loaderLib("playlists/"+b+".xml")
		}
		function loaderLib(b:String):void {
			myLoader = new URLLoader(new URLRequest(b));
			myLoader.addEventListener("complete", loadLibEsito);
			myLoader.addEventListener("ioError", loadLibEsito);
		}
		public function loadLibEsito(event:Event):void {
			if (event.type == "complete") {
				myFileList = new XMLDocument();
				myFileList.ignoreWhite = true;
				myFileList.parseXML(myLoader.data);
				myFileSel.avvia(myFileList.childNodes[0].childNodes[0]);
				myPath = myFileList.childNodes[0].childNodes[0].attributes.path;
				myMovie.text = myFileList.childNodes[0].childNodes[0].attributes.path;
				myMovie.textColor = Preferences.pref.th.color;
			} else {
				if (l == 0) {
					loaderLib(Preferences.pref.libraryList.childNodes[0].attributes.path+currLib);
				} else if (l == 1) {
					loaderLib(Preferences.pref.libraryList.childNodes[0].attributes.path+currLib+".flx");
				} else if (l == 2) {
					loaderLib("library/"+currLib+".flx");
				/*} else if ((l == 3) && (Preferences.pref.myPrefSO.data.flxerPref.childNodes[0].childNodes[1].attributes.use == "true")) {
					loaderLib(Preferences.pref.libraryList.childNodes[0].childNodes[1].attributes.value+"librarys/"+currLib+".xml");
				} else if ((l == 4) && (Preferences.pref.myPrefSO.data.flxerPref.childNodes[0].childNodes[1].attributes.use == "true")) {
					loaderLib(Preferences.pref.libraryList.childNodes[0].childNodes[1].attributes.value+"librarys/"+currLib);
				*/
				} else {
					loadErr();
				}
				l++;
			}
		}
		public function loadErr():void {
			myMovie.text = "FILE NOT FOUND";
			myMovie.textColor = 0xFF0000;
			myMovie.setSelection(0, 0);

		}
		function lockWipe(p:Boolean):void {
			change_ch();
			lockWipeStatus = p;
		}
		function changeBlend(a:String,p:String):void {
			change_ch();
			lastLiveAct = ",changeBlend,"+this.ch+","+p;
			//this.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",changeBlend,"+ch+","+p);
			if (outStatus) {
				parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+lastLiveAct);
			} else {
				liveA.changeBlend = lastLiveAct;
			}
		}
		function paletteHideShow(p:String):void {
			change_ch();
			for (a=0; a<this.myPalette.length; a++) {
				if (a == p) {
					this[this.myPalette[a]].visible = true;
					this[this.myPalette[a]+"Visualizer"].myDisable();
					//this[this.myPalette[a]+"Visualizer"].lab.backgroundColor = 0xFFFFFF;
				} else {
					this[this.myPalette[a]].visible = false;
					this[this.myPalette[a]+"Visualizer"].myEnable();
					//this[this.myPalette[a]+"Visualizer"].lab.backgroundColor = 0xCCCCCC;
				}
			}
		}
		public function mySwapDepth(p:int):void {
			myDepth = parent.parent.monitor.mon.getChildIndex(parent.parent.monitor.levels["ch_"+ch]);
			change_ch();
			if (p != 0) {
				if ((this.myDepth+p<Preferences.pref.nCh) && (this.myDepth+p>=0)) {
					myDepth += p;
					//if (outStatus) {
					parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",mySwapDepth,"+this.ch+","+this.myDepth);
					for (var a = 0; a<Preferences.pref.nCh; a++) {
						this.parent.chCnt["ch_"+a].myDepthF.text = (parent.parent.monitor.mon.getChildIndex(parent.parent.monitor.levels["ch_"+a])+1);
					}
					//}
				}
			}
		}
		function live(p:Boolean):void {
			change_ch();
			this.outStatus = p;
			if (p) {
				/*
				if (tipo == "txt") {
					this.myTxtEditor.myTxtOut = this.myTxtEditor.myTxt;
				} else {
					this.myTxtEditor.myTxtOut = undefined;
					if (tipo != "txt") {
						clearInterval(this.myTxtEditor.txtInt);
					}
					if (this.myColors.col_onoff.myStatus) {
						//var tmp = (getTimer()-Preferences.pref.lastTime)+",applicaLive,"+this.ch+this.lastLiveAct+","+this.monitor.mon.ch_0.x+","+this.monitor.mon.ch_0.y+","+this.monitor.mon.ch_0.cnt.vid.x+","+this.monitor.mon.ch_0.cnt.vid.y+","+this.monitor.mon.ch_0.cnt.vid.xscale+","+this.monitor.mon.ch_0.cnt.vid.yscale+","+this.monitor.mon.ch_0.cnt.vid.rotation+","+this.sliderVal+","+this.myWipe.lab.lab.lab.text+",CF,CFT,rb,"+this.monitor.mon.ch_0.CFT.rb+",CF,CFT,gb,"+this.monitor.mon.ch_0.CFT.gb+",CF,CFT,bb,"+this.monitor.mon.ch_0.CFT.bb+","+this.monitor.mon.ch_0.cnt.fondo.visible+","+this.myDepth+","+this["myBlend"].lab.lab.lab.text+",CM,CMT,rb,"+this.monitor.mon.ch_0.CMT.rb+",CM,CMT,gb,"+this.monitor.mon.ch_0.CMT.gb+",CM,CMT,bb,"+this.monitor.mon.ch_0.CMT.bb;
					} else {
						//var tmp = (getTimer()-Preferences.pref.lastTime)+",applicaLive,"+this.ch+this.lastLiveAct+","+this.monitor.mon.ch_0.x+","+this.monitor.mon.ch_0.y+","+this.monitor.mon.ch_0.cnt.vid.x+","+this.monitor.mon.ch_0.cnt.vid.y+","+this.monitor.mon.ch_0.cnt.vid.xscale+","+this.monitor.mon.ch_0.cnt.vid.yscale+","+this.monitor.mon.ch_0.cnt.vid.rotation+","+this.sliderVal+","+this.myWipe.lab.lab.lab.text+",CF,CFT,rb,"+this.monitor.mon.ch_0.CFT.rb+",CF,CFT,gb,"+this.monitor.mon.ch_0.CFT.gb+",CF,CFT,bb,"+this.monitor.mon.ch_0.CFT.bb+","+this.monitor.mon.ch_0.cnt.fondo.visible+","+this.myDepth+","+this["myBlend"].lab.lab.lab.text;
					}
					parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+",preTxt,"+this.ch+",txt");
					parent.parent.monitor.mbuto(tmp);
					this.myTxtEditor.myTxtOut = this.myTxtEditor.myTxt;
				}
				for (a=0; a<Preferences.pref.nCh; a++) {
					//this.parent.chCnt["ch_"+a].myDepthF.text = _root.monitor.mon["ch_"+a].getDepth()+1;
				}
				*/
				for (var i in liveA) {
					parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+liveA[i]);
				}
				liveA = new Object();
			}
		}
		function loadDvIn(p:Boolean):void {
			change_ch();
			trace(Preferences.pref.plugin.childNodes[0].childNodes[1])
			if (p) {
				myLibSel.myDisable();
				myLibSel.setVal("select playlist",0);
				
				myPath = Preferences.pref.plugin.childNodes[0].childNodes[1].attributes.path;
				myFileList = new XMLDocument();
				myFileList.parseXML("<lib>"+Preferences.pref.plugin.childNodes[0].childNodes[1]+"</lib>")
				myFileSel.avvia(Preferences.pref.plugin.childNodes[0].childNodes[1]);
			} else {
				myLibSel.myEnable();
			}
		}
		function showTxtEditor(p:Boolean):void {
			change_ch();
			myLibSel.visible = !p;
			myFileSel.visible = !p;
			myDvIn.visible = !p;
			myMovie.visible = !p;
			myMovieL.visible = !p;
			myTxtEditor.visible = p;
			if (p) {
				myTxtEditor.myTxtField.setSelection(0,10);
				//c = setInterval(mySetFocus, 300);
			} else {
				//Selection.setFocus(null);
			}
		}
		function mySetFocus():void {
			clearInterval(c);
			trace("mySetFocusmySetFocusmySetFocus")
			/*	onEnterFrame = function() {
			delete onEnterFrame;
			return false;
			};*/
		}
		function load_url(a:String):void {
			var tmp:String = Preferences.myReplace(myMovie.text,myPath,"");
			myLoadMovie(tmp,tmp);
		}
		function myLoadMovie(a:String,p:String):void {
			Preferences.pref.nLoadErr["ch_"+ch] = 0;
			Preferences.pref.currentMedia["ch_"+ch] = p;
			myLoadMovieMore(a,p);
		}
		public function myLoadMovieMore(a:String,p:String):void {
			change_ch();
			if (p.indexOf("/") == -1) {
				p = myPath+p;
			}
			current_mov = myMovie.text = p;
			myMovie.textColor = Preferences.pref.th.color;
			tipo = p.substring(p.length-3, p.length).toLowerCase();
			trace(tipo);
			if (tipo == "txt") {
				this.tipo = "swf";
				this.myTxtEditor.myTxtLoader.load(new URLRequest(this.current_mov));
			} else {
				if (tipo == "flv" || tipo == "avi" || tipo == "mov" || tipo == "mpg" || tipo == "mp4" || tipo == "m4v") {
					tipo = "flv";
					lastLiveAct = ",loadFlv,"+ch+","+current_mov+","+tipo+","+sliderVal;
				} else if (tipo == "mp3") {
					lastLiveAct = ",loadMp3,"+ch+","+current_mov+","+tipo+","+sliderVal;
				} else {
					tipo = "swf";
					lastLiveAct = ",loadMedia,"+ch+","+current_mov+","+tipo+","+sliderVal;
				}
				if (outStatus) {
					parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+lastLiveAct);
				} else {
					liveA.loadMedia = lastLiveAct;
				}
				if (monitor.previewStatus) {
					monitor.mbuto((getTimer()-Preferences.pref.lastTime)+lastLiveAct);
				}
			}
			oldTipo = tipo;
		}
		function sliderFnz(p:Number):void {
			sliderVal = p;
			sliderFnz2();
		}
		function mouseSlider(p:Number):void {
			mySlider.curs.y = (((p))/100)*(mySlider.path.height-mySlider.curs.height);
			sliderVal = 100-(p);
			mySlider.curs.lab.text = int(sliderVal);
			sliderFnz2();
		}
		function keySlider(p:Number):void {
			if (sliderVal+p>=0 && sliderVal+p<=100) {
				sliderVal += p;
				mySlider.curs.y = ((-sliderVal/100)+1)*(mySlider.path.height-mySlider.curs.height);
				mySlider.curs.lab.text = int(sliderVal);
				sliderFnz2();
			}
		}
		function sliderFnz2():void {
			lastLiveAct = ",slideWipe,"+this.ch+","+this.sliderVal+","+this.myWipe.getVal();
			if (outStatus) {
				parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+lastLiveAct);
			} else {
				liveA.slideWipe = lastLiveAct;
			}
		}
		function changeWipe(a:String,p:String):void {
			lastLiveAct = "";
			change_ch();
			if (p != "WIPE NONE (MIX)" && p != "VERTICAL" && p != "HORIZONTAL" && p.indexOf("LOAD SVG MAP")==-1) {
				lastLiveAct = ",changeWipe,"+this.ch+","+Preferences.pref.plugin.childNodes[0].childNodes[0].attributes.path+p+","+this.sliderVal;
			} else if (p.indexOf("LOAD SVG MAP")!=-1) {
	            MyFile.browse([new FileFilter("Vector file", "*.svg")]);
				
			} else {
				lastLiveAct = ",redrawWipe,"+this.ch;
			}
			if (lastLiveAct) {
				if (outStatus) {
					parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+lastLiveAct);
				} else {
					liveA.changeWipe = lastLiveAct;
				}
				sliderFnz2();
			}
		}
		public function eject(p:String):void {
			mySlider.resetta();
			treD.resetta();
			myFileSel.resetta();
			myMovie.resetta();
			myController.resetta();
			//myDepth.resetta();
			myBlend.resetta();
			if (mySequencer.seqStatus) {
				mySequencer.seq.mouseDownHandler(null);
			}
			myColors.resetta();
			myTrasform.resetta("");
			myImage.resetta();
			lastLiveAct = ",eject,"+this.ch;
			if (outStatus) {
				parent.parent.monitor.mbuto((getTimer()-Preferences.pref.lastTime)+lastLiveAct);
			} else {
				liveA.eject = lastLiveAct;
			}
		}
	}
}