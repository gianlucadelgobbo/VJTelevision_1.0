/* STRUTTURA CLIP 
	effects
	cnt
		bkg
			SHAPE
		cnt w/2 h/2
			myVideo -w/2 -h/2
			swfLoader -w/2 -h/2
			imgLoader0 -w/2 -h/2
			imgLoader1 -w/2 -h/2
	cntMask w/2 h/2
		trgtMask -w/2 -h/2
		baseMask
			SHAPE -w/2 -h/2
*/
package FLxER.core {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.media.Video;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.display.AVM1Movie;
	import flash.net.LocalConnection;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.geom.ColorTransform;
	
	import FLxER.core.ColorMatrix;
    import flash.filters.ColorMatrixFilter;
	import flash.display.StageQuality;
	import flash.text.TextFormat;

	//import flash.utils.*;
	public class Player extends Sprite {
		var ch:Number;
		var w:Number;
		var h:Number;
		public var xx:Number;
		public var yy:Number;
		public var zz:Number;
		public var myStopStatus:Boolean;
		var nLoadErr:Number;
		public var currentMedia:String;
		public var oldTipo:String;
		var newFlv:Boolean;
		public var myDuration:Number;
		var myWidth:Number;
		var myHeight:Number;
		public var imgToShow, imgToRemove, myTweenA, myTweenS;
		public var song:SoundChannel;
		public var sliderVal;
		var myTxt;
		var intTime;
		var myFont;
		var txtKS;
		
		// CLIPS CONTAINERS
		public var bkg;
		public var effects;
		public var cnt;
		public var vid;
		public var myVideo;
		//public var swfLoader;
		public var imgLoader0;
		public var imgLoader1;
		public var cntMask;
		public var baseMask;
		public var trgtMask;
		public var drawMask;
		// END CLIPS CONTAINERS

		// OBJECTS
		var NC:NetConnection;
		public var NS:NetStream;
		var customClient:Object;
		var swfLoader:Loader;
		var wipesLoader:Loader;
		var swfSound:SoundMixer;
		var transformSound:SoundTransform;
		var flvSound:SoundMixer;
		public var mp3Sound:Sound;
		var CFT:Object;
		var CMT:Object;
		
		// END OBJECTS
		var mapTrgt,handles,shapesA,shapesAcnt,currentShape,KL,braccioOff;	
		public function Player(a, ww, hh) {
			ch = a;
			w = ww;
			h = hh;
			myStopStatus = false;
			
			// PLAYER CLIPS
			this.effects = new Sprite();
			this.addChild(effects);
			/*
			this.effects.visible = false;
			this.effects.channel = this;
			this.effects.ch = ch;
			this.effects.video = vid;
			this.effects["mask"] = this.cntMask;
			this.effects.channelPreview = _root.myCtrl[this.name].monitor.mon.ch_0;
			this.effects.effectUpdate = function(trgt, param) {
				//_root.monitor.mbuto((getTimer()-_root.myGlobalCtrl.myRecorder.last_time)+",effectUpdate,"+this.ch+","+trgt+","+param);
			};
			this.effects.videoPreview = _root.myCtrl[this.name].monitor.mon.ch_0["cnt"].vid;
			this.effects.maskPreview = _root.myCtrl[this.name].monitor.mon.ch_0["mask"];
			this.effects.myPanel = _root.myCtrl[this.name].myEffects["effects"];
			*/
			//
			this.cnt = new Sprite();
			this.addChild(cnt);		
			//
			this.bkg = new Sprite();
			trace("cazzo")
            bkg.graphics.beginFill(0xFFFFFF);
            bkg.graphics.drawRect(0, 0, w, h);
            bkg.graphics.endFill();
            this.cnt.addChild(bkg);
			bkg.visible = false;
			//
			this.vid = new Sprite();
            this.cnt.addChild(vid);
			//
			this.cntMask = new Sprite();
			this.addChild(cntMask);
			
			baseMask = new Sprite();
            baseMask.graphics.beginFill(0xFFFFFF);
            baseMask.graphics.drawRect(-w/2, -h/2, w, h);
            baseMask.graphics.endFill();
            this.cntMask.addChild(baseMask);

			drawMask = new Sprite();

			trgtMask = new Sprite();

			vid.x = cntMask.x = w/2;
			vid.y = cntMask.y = h/2;
			this.cnt.mask = this.cntMask;

			// END PLAYER CLIPS
			
			this.NC = new NetConnection();
			NC.addEventListener(NetStatusEvent.NET_STATUS, NCHandler);
			NC.connect(null);

			this.swfLoader = new Loader();
			swfLoader.contentLoaderInfo.addEventListener(Event.INIT, initHandlerSwf);
			swfLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerSwf);
			swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerSwf);

			this.wipesLoader = new Loader();
			wipesLoader.contentLoaderInfo.addEventListener(Event.INIT, initHandlerWipes);
            wipesLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerWipes);
            wipesLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerWipes);

			this.swfSound = new SoundMixer();
			/*swfChannel = swfSound.play();
			transformSound = swfChannel.soundTransform;
            transformSound.volume = 0;
            swfChannel.soundTransform = transformSound;*/
			this.transformSound = new SoundTransform();
			
			this.flvSound = new SoundMixer();
			

			//this.CMT = {rb:0,gb:0,bb:0};
			//this.CFT = {rb:-255,gb:-255,bb:-255};
			this.bkg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -255, -255, -255, 1);
			this.myFont = "standard 07_53"
			this.txtKS = new TextFormat();
			this.txtKS.font = "myFont2";
			this.txtKS.size = 48;
			this.txtKS.color = 0x00000;
			this.txtKS.align = "center";
		}
		public function resizer(ww,hh) {
			trace("palyer "+oldTipo)
			w = ww;
			h = hh;
			vid.x = cntMask.x = w/2;
			vid.y = cntMask.y = h/2;
			if (this.trgtMask.contains(wipesLoader)) {
				resizer_swf(wipesLoader)
			} else if (drawMask.numChildren == 0){
				trace(":::::::::::::::::::::::::::::::::::::::::::::::")
				baseMask.graphics.clear();
				baseMask.graphics.beginFill(0xFFFFFF);
				baseMask.graphics.drawRect(-w/2, -h/2, w, h);
				baseMask.graphics.endFill();
			}
				bkg.graphics.clear();
				bkg.graphics.beginFill(0xFFFFFF);
				bkg.graphics.drawRect(0, 0, w, h);
				bkg.graphics.endFill();
			if (oldTipo == "swf") {
				resizer_swf(swfLoader)
			} else if (oldTipo == "flv") {
				//resizer_swf(swfLoader)
			}
		}
		// SWF LOADER
		public function loadMedia(myAction) {
			if ((myAction[3].slice(-3,myAction[3].length)).toLowerCase()=="swf" ) {
				if (oldTipo != null) {
					this[oldTipo+"Reset"]();
				}
				oldTipo = myAction[4];
				myTxt = myAction[6];
				intTime = parseInt(myAction[7])
				//this.my_mclL.myVolume = parseFloat(myAction[5]);
				this.nLoadErr = 0;
				this.currentMedia = myAction[3];
				swfLoader.load(new URLRequest(myAction[3]));
			} else {
				loadImg(myAction)
			}
		}
		private function resizerSwf(t) {
			if (w/h < t.contentLoaderInfo.width/t.contentLoaderInfo.height) {
				t.scaleX = w/t.contentLoaderInfo.width;
				t.scaleY = t.scaleX;
			} else {
				t.scaleY = h/t.contentLoaderInfo.height;
				t.scaleX = t.scaleY;
			}
			t.x = -(t.contentLoaderInfo.width*t.scaleX)/2;
			t.y = -(t.contentLoaderInfo.height*t.scaleX)/2;
		}
		function initHandlerSwf(event) {
			//this.swfLoader = new MovieClip();
			//swfLoader = this.swfLoader;
			myWidth = this.swfLoader.contentLoaderInfo.width;
			myHeight = this.swfLoader.contentLoaderInfo.height;
			trace(this.swfLoader.contentLoaderInfo.width)
			trace(this.swfLoader.contentLoaderInfo.height)
			if(this.swfLoader.content is AVM1Movie) {
				if (myStopStatus) {
					functionSTOP(null);
				}
			}
			if (!this.vid.contains(swfLoader)) {
				//swfLoader.x = -w/2;
				//swfLoader.y = -h/2;
				this.vid.addChild(swfLoader);
			}
			if (myTxt) {
				swfLoader.content.startReader(myTxt, intTime);
				setFont()
				swfLoader.content.lab.x = -400;
				swfLoader.content.lab.y = 109;
				swfLoader.content.lab.width = 1200;
				swfLoader.content.lab.height = 100;
				ALIGNtxt([null,null,null,txtKS.align]);
			}
			resizer_swf(swfLoader)
			// SOLO SUPERPLAYER //
			parent.parent.initHandlerSWF(swfLoader);
			
			/*swfChannel = swfSound.play();
			transformSound = swfChannel.soundTransform;
			transformSound.volume = this.myVolume;
			swfChannel.soundTransform = transformSound;
			*/
			/*if (t) {
			}
			if (parent != _level0.monitor.mon) {
				parent.parent.parent.myMovie.val.text = this.clipPath;
				parent.parent.parent.myMovie.val.textColor = 0x000000;
			}*/
		}
		function errorHandlerSwf(event) {
			trace("errorHandlerSwf "+this.currentMedia)
			if (nLoadErr<1 && Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.useServer == "true") {
				this.nLoadErr++;
				swfLoader.load(new URLRequest(Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.value+this.currentMedia));
			} else {
				Preferences.pref.monitorTrgt.myError(ch,"FILE NOT FOUND", "media", currentMedia);
			}
		}

		function swfReset() {
			//this.swfLoader.close();
			if (this.vid.contains(swfLoader)) {
				this.swfLoader.unload();
				this.vid.removeChild(swfLoader);
			}
		}
		function SCRATCHswf(myAction) {
			//trgt.gotoAndPlay(int(((trgt.totalFrames-1)*(parseFloat(myAction[3])/800))+1));
			var tmp
			if (myStopStatus) {
				tmp = "gotoAndStop";
			} else {
				tmp = "gotoAndPlay";
			}
			swfLoader.content[tmp](int(((swfLoader.totalFrames-1)*parseFloat(myAction[3]))+1));
		}
		function REWINDswf() {
			if(swfLoader.content is MovieClip) {
				var act;
				if (myStopStatus) {
					act = "gotoAndStop";
				} else {
					act = "gotoAndPlay";
				}
				recursiveSwfActParam(swfLoader.content, act, 1);
			}
		}
		function FORWARDswf() {
			if(swfLoader.content is MovieClip) {
				var act;
				if (myStopStatus) {
					act = "gotoAndStop";
				} else {
					act = "gotoAndPlay";
				}
				recursiveSwfActParam(swfLoader, act, int(swfLoader.currentFrame+((swfLoader.totalFrames-swfLoader.currentFrame)/2)));
			}
		}
		function STOPswf() {
			if(swfLoader.content is MovieClip) {
				recursiveSwfAct(swfLoader.content, "stop");
			}
		}
		function PLAYswf() {
			if(swfLoader.content is MovieClip) {
				recursiveSwfAct(swfLoader.content, "play");
			}
		}
		function recursiveSwfAct(trgt, act) {
			trgt[act]();
			for (var a=0;a<trgt.numChildren;a++) {
				if (trgt.getChildAt(a) is MovieClip) {
					trgt.getChildAt(a)[act]();
					recursiveSwfAct(trgt.getChildAt(a), act);
				}
			}
		}
		function recursiveSwfActParam(trgt, act, p) {
			trgt[act](p);
			var item;
			for (item in trgt) {
				if (trgt[item].totalFrames) {
					trgt[item][act](p);
					recursiveSwfActParam(trgt[item], act, p);
				}
			}
		}
		// END SWF LOADER

		// VIDEO LOADER
		public function loadFlv(myAction) {
			trace("loadFlv "+myAction[3])
			if (oldTipo != null) {
				this[oldTipo+"Reset"]();
			}
			oldTipo = "flv";
			newFlv = true
			this.nLoadErr = 0;
			this.currentMedia = myAction[3];
			this.NS.play(myAction[3]);
			this.NS.pause();
			transformSound.volume = parseFloat(myAction[4]);
			NS.soundTransform = transformSound;
		}
		public function NCHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success" :
					connectStream();
					break;
			}
		}
		public function connectStream() {
			NS = new NetStream(NC);
			NS.bufferTime = 2;
			customClient = new Object();
			customClient.onMetaData = onMetaData;
			//customClient.onCuePoint = onCuePoint;
			//customClient.onPlayStatus = onPlayStatus;
			NS.client = customClient;
			NS.addEventListener(NetStatusEvent.NET_STATUS, NSHandler);
		}
		public function NSHandler(event:NetStatusEvent):void {
			trace(event.info.code)
			if (event.info.code == "NetStream.Play.Stop") {
				NS.seek(0);
			}
			if (event.info.code == "NetStream.Play.Start") {
				if (this.myStopStatus) {
					NS.pause();
					//NS.seek(0);
				}
				// SOLO SUPERPLAYER //
				parent.parent.initHandlerFLV(event)
			}
			if (event.info.code == "NetStream.Play.StreamNotFound" || event.info.code == "NetStream.Play.FileStructureInvalid") {
				trace("NetStream.Play.StreamNotFound "+this.currentMedia)
				if (nLoadErr<1 && Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.useServer == "true") {
					this.nLoadErr++;
					this.NS.play(Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.value+this.currentMedia)
				} else {
					Preferences.pref.monitorTrgt.myError(ch,"FILE NOT FOUND", "media", currentMedia);
				}
			}
		}
		private function resizerFlv() {
			if (w/h < myWidth/myHeight) {
				myVideo.width = w;
				myVideo.scaleY = myVideo.scaleX;
			} else {
				myVideo.height = h;
				myVideo.scaleX = myVideo.scaleY;
			}
			myVideo.x = -myVideo.width/2;
			myVideo.y = -myVideo.height/2;
		}
		public function onMetaData(info:Object):void {
			if (newFlv) {
				trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate)
				if (!this.myStopStatus) {
					this.NS.resume();
				}
				myDuration = info.duration;
				myWidth = info.width;
				myHeight = info.height;
				//
				this.myVideo = new Video(info.width , info.height);
				this.myVideo.smoothing = true;
				this.myVideo.attachNetStream(NS);
				if (!this.vid.contains(this.myVideo)) {
					this.vid.addChild(myVideo);
				}
				resizer_flv()
				newFlv = false
			}
		}
		function REWINDflv() {
			NS.seek(0);
		}
		function FORWARDflv() {
			var tmp2 = int((NS.time)+(myDuration/10));
			if (tmp2>myDuration) {
				tmp2 = myDuration;
			}
			NS.seek(tmp2);
		}
		public function SCRATCHflv(myAction) {
			NS.seek((myDuration*parseFloat(myAction[3])));
		}
		function STOPflv() {
			NS.pause();
		}
		function PLAYflv() {
			NS.resume();
		}
		function flvReset() {
			this.NS.close();
			if (this.myVideo is Video) {
				if (this.vid.contains(this.myVideo)) {
					this.myVideo.clear();
					this.vid.removeChild(myVideo);
				}
			}
		}
		// END VIDEO LOADER
		
		// IMAGES LOADER
		public function loadImg(myAction) {
			if (oldTipo != null && oldTipo != "jpg") {
				this[oldTipo+"Reset"]();
			}
			oldTipo = "jpg";
			/* SOLO SUPERPLAYER 
			loadPicAction = myAction;
			var contextTmp = false;
			if (Preferences.pref.policyFile) {
				Security.loadPolicyFile(Preferences.pref.policyFile);
				contextTmp = true;
			}
			var context = new LoaderContext(contextTmp);*/
			if (this.imgLoader0 == null) {
				this.imgLoader0 = new Loader();
			}
			if (this.imgLoader1 == null) {
				this.imgLoader1 = new Loader();				
			}
			//imgLoader0.alpha = imgLoader1.alpha = 0;
			this.vid.addChild(imgLoader0)
			this.vid.addChild(imgLoader1)
			this.nLoadErr = 0;
			this.currentMedia = myAction[3];
			if (this.imgLoader0.content == null) {
				imgLoader0.contentLoaderInfo.addEventListener(Event.INIT, initHandlerImg);
				imgLoader0.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerImg);
				imgLoader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerImg);
				imgToShow = this.imgLoader0;
				imgLoader0.load(new URLRequest(myAction[3])/*, context*/);
			} else {
				imgLoader1.contentLoaderInfo.addEventListener(Event.INIT, initHandlerImg);
				imgLoader1.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerImg);
				imgLoader1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerImg);
				imgToShow = this.imgLoader1;
				imgLoader1.load(new URLRequest(myAction[3])/*, context*/);
			}
		}
		function initHandlerImg(event) {
			myWidth = this.imgToShow.contentLoaderInfo.width;
			myHeight = this.imgToShow.contentLoaderInfo.height;
			resizer_swf(imgToShow);
			if (imgToRemove != null) {
				resizer_swf(imgToRemove);
				myFadeOff();
			} else {
				myFadeOn();
			}
        }
		function errorHandlerImg(event) {
			trace("errorHandlerSwf "+this.currentMedia)
			if (nLoadErr<1 && Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.useServer == "true") {
				this.nLoadErr++;
				if (this.imgLoader0.content == null) {
					imgLoader0.contentLoaderInfo.addEventListener(Event.INIT, initHandlerImg);
					imgLoader0.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerImg);
					imgLoader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerImg);
					imgToShow = this.imgLoader0;
					imgLoader0.load(Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.value+this.currentMedia);
				} else {
					imgLoader1.contentLoaderInfo.addEventListener(Event.INIT, initHandlerImg);
					imgLoader1.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerImg);
					imgLoader1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerImg);
					imgToShow = this.imgLoader1;
					imgLoader1.load(Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.value+this.currentMedia);
				}
			} else {
				Preferences.pref.monitorTrgt.myError(ch,"FILE NOT FOUND", "media", currentMedia);
			}
		}
		function myFadeOff() {
			myFadeOn()
			myTweenS=new Tween(imgToRemove,"alpha",Strong.easeIn,1,0,.5,true);
			myTweenS.useSeconds = true;
			myTweenS.addEventListener(TweenEvent.MOTION_FINISH, myFadeOffFinish);
        }
		function myFadeOffFinish(event) {
			imgToRemove.unload()
			myTweenS.removeEventListener(TweenEvent.MOTION_FINISH, myFadeOffFinish);
        }
		function myFadeOn() {
			// SOLO SUPERPLAYER //
			// parent.resizer();
			myTweenA = new Tween(imgToShow,"alpha",Strong.easeIn,0,1,1,true);
			myTweenA.useSeconds = true;
			myTweenA.addEventListener(TweenEvent.MOTION_FINISH, myFadeOnFinish);
        }
		function myFadeOnFinish(event) {
			// SOLO SUPERPLAYER //
			parent.parent.initHandlerJPG(imgToShow);
			imgToRemove = imgToShow;
			myTweenA.removeEventListener(TweenEvent.MOTION_FINISH, myFadeOnFinish);
        }
		function jpgReset() {
			trace("jpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgResetjpgReset")
			imgToRemove = null;
			imgToShow = null;
			if (imgLoader0) {
				imgLoader0.unload();
			}
			if (imgLoader1) {
				imgLoader1.unload();
			}
			if (myTweenA) {
				myTweenA.stop()
				myTweenA.removeEventListener(TweenEvent.MOTION_FINISH, myFadeOnFinish);
			}
			if (myTweenS) {
				myTweenS.stop()
				myTweenS.removeEventListener(TweenEvent.MOTION_FINISH, myFadeOffFinish);
			}
			if (imgLoader0 is Loader) {
				if (this.vid.contains(imgLoader0)) {
					this.vid.removeChild(imgLoader0);
	//				imgLoader0 = null;
				}
			}
			if (imgLoader1 is Loader) {
				if (this.vid.contains(imgLoader1)) {
					this.vid.removeChild(imgLoader1);
	//				imgLoader1 = null;
				}
			}
		}
		// SOLO SUPERPLAYER //
		/*function STOPjpg() {
		}
		function PLAYjpg() {
			parent.load_foto()
		}
		function REWINDjpg() {
			//this.myStopStatus = true;
			parent.load_prev_foto()
		}
		function FORWARDjpg() {
			//this.myStopStatus = true;
			parent.load_foto()
		}*/
		// END IMAGES LOADER

		// MP3 LOADER
		public function loadMp3(myAction) {
			if (oldTipo != myAction[4] && oldTipo != null) {
				this[oldTipo+"Reset"]();
			}
			oldTipo = "mp3";
			sliderVal = parseFloat(myAction[5]);
			/*if (this.parent == _level0.monitor.mon) {
				this.mp3Sound.loadSound(myAction[3], false);
				//this.mp3Sound.setVolume(parseFloat(myAction[5]));
			}*/
			var slc = new SoundLoaderContext(1, false); 
			this.nLoadErr = 0;
			this.currentMedia = myAction[3];
			this.mp3Sound = new Sound();
			mp3Sound.addEventListener(Event.COMPLETE, soundCompleteHandler);
			mp3Sound.addEventListener(flash.events.ProgressEvent.PROGRESS, soundProgressHandler);
			mp3Sound.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerMp3);
			mp3Sound.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerMp3);
			this.mp3Sound.load(new URLRequest(myAction[3]),slc);
            transformSound.volume = sliderVal;
			song = mp3Sound.play(0,1, transformSound);
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler2);
			// SOLO SUPERPLAYER //
			parent.parent.initHandlerMP3(null)
			if (myAction[6]) {
				this.imgLoader0 = new Loader();
				imgLoader0.x = -w/2;
				imgLoader0.y = -h/2;
				//imgLoader0.alpha = 0;
				this.addChild(imgLoader0)
				imgLoader0.contentLoaderInfo.addEventListener(Event.INIT, initHandlerImg);
				imgLoader0.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerImg);
				imgLoader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerImg);
				imgToShow = this.imgLoader0;
				imgLoader0.load(new URLRequest(myAction[6]));
			}
		}
		function errorHandlerMp3(event) {
			trace("errorHandlerSwf "+this.currentMedia)
			if (nLoadErr<1 && Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.useServer == "true") {
				this.nLoadErr++;
				var slc = new SoundLoaderContext(1, false); 
				this.mp3Sound.load(Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.value+this.currentMedia,slc);
			} else {
				Preferences.pref.monitorTrgt.myError(ch,"FILE NOT FOUND", "media", currentMedia);
			}
		}
		function soundProgressHandler(event) {
			trace("bella"+mp3Sound.bytesLoaded)
		}
		function soundCompleteHandler(event) {
		}
		function soundCompleteHandler2(event) {
			song = mp3Sound.play(0);
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler2);
		}
		public function setVol(myAction) {
			setVolAct(parseFloat(myAction[3]))
		}
		function setVolAct(v) {
            transformSound.volume = v;
			if (oldTipo == "flv") {
				NS.soundTransform = transformSound;
			} else if (oldTipo == "swf") {
				swfLoader.soundTransform = transformSound;
			} else if (oldTipo == "mp3") {
				song.soundTransform = transformSound;
			}
		};
		function mp3Reset() {
			trace("mp3Reset")
			this.song.stop();
			jpgReset();
		}
		function REWINDmp3() {
			song.stop();
			soundCompleteHandler2(null);
		}
		function FORWARDmp3() {
			song.stop();
			song = mp3Sound.play(song.position+((mp3Sound.length-song.position)/10));
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler2);
		}
		public function SCRATCHmp3(myAction) {
			var tmp = (((mp3Sound.length)*(parseFloat(myAction[3])/800)))/1000;
			song.stop();
			song = mp3Sound.play(parseFloat(myAction[3])*mp3Sound.length);
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler2);
		}
		function STOPmp3() {
			song.stop();
		}
		function PLAYmp3() {
			song = mp3Sound.play(song.position);
			song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler2);
		}
		// END MP3 LOADER

		// WIPES LOADER
		function changeWipe(myAction) {
            baseMask.graphics.clear();
			if (shapesAcnt) {
				for (var a=0;a<shapesAcnt.length;a++) {
					shapesAcnt[a].graphics.clear();
					this.drawMask.removeChild(shapesAcnt[a]);
				}
			}
			shapesAcnt = undefined;
			this.nLoadErr = 0;
			this.currentMedia = myAction[3];
			this.wipesLoader.load(new URLRequest(myAction[3]))
		}
		function initHandlerWipes(event) {
			//this.trgtMask = null;
			if (!this.cntMask.contains(trgtMask)) {
				this.cntMask.addChild(trgtMask);
			}
			this.trgtMask.addChild(wipesLoader);
			resizer_swf(wipesLoader)
		}
		function errorHandlerWipes(event) {
			trace("errorHandlerWipes "+this.currentMedia)
			if (nLoadErr<1 && Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.useServer == "true") {
				this.nLoadErr++;
				this.wipesLoader.load(new URLRequest(Preferences.pref.flxerPref.childNodes[0].childNodes[1].attributes.value+this.currentMedia));
			} else {
				Preferences.pref.monitorTrgt.myError(ch,"FILE NOT FOUND", "wipes", currentMedia);
				redrawWipe(null);
			}
		}
	public function mapDrawer(myAction) {
		if (!this.cntMask.contains(drawMask)) {
			this.cntMask.addChild(drawMask);
		}
		if (trgtMask) {
			if (this.cntMask.contains(trgtMask)) {
				this.wipesLoader.unload();
				this.cntMask.removeChild(trgtMask);
			}
		}
		if (shapesAcnt) {
			for (var a=0;a<shapesAcnt.length;a++) {
				shapesAcnt[a].graphics.clear();
				this.drawMask.removeChild(shapesAcnt[a]);
			}
		}
		trace("ddddddddddddddddddddd")
		baseMask.graphics.clear();
		trace("ddddddddddddddddddddd")
		/*if (baseMask["shapes"]) {
			baseMask["shapes"].removeMovieClip();
			baseMask["handles"].removeMovieClip();
		}
		//this["cntMask"]["mask"].trgt.avvia(this.currentMask);
		baseMask.createEmptyMovieClip("shapes",baseMask.getNextHighestDepth());
		baseMask.createEmptyMovieClip("handles",baseMask.getNextHighestDepth());
		mapTrgt = baseMask["shapes"];
		handles = baseMask["handles"];
		*/
		trace("mapDrawermapDrawermapDrawer "+myAction[3])
		var tmp = myAction[3].split(";");
		currentShape = undefined;
		if(Preferences.pref.flxerDrawedMasks.data.lista[tmp[1]]){
			shapesA = Preferences.pref.flxerDrawedMasks.data.lista[tmp[1]];
			currentMask = tmp[1];
			mapShape();
		} else {
			currentMask = undefined;
			shapesA = new Array();
		}
	}
	function mapShape() {
		shapesAcnt = new Array()
		trace("mapShapemapShape: "+shapesA.length);
		for (var a=0;a<shapesA.length;a++) {
			currentShape = a;
			/*mapTrgt.createEmptyMovieClip("cnt"+a,mapTrgt.getNextHighestDepth());
			handles.createEmptyMovieClip("cnt"+a,handles.getNextHighestDepth());
			for (var b=0;b<shapesA[a].length;b++) {
				handles["cnt"+a].createEmptyMovieClip("handle"+b,handles["cnt"+a].getNextHighestDepth());
				var obj = new Object();
				obj.trgt = this;
				obj.listner = _root.mykeyboard.MCLMap;
				obj.fnz = updatePath;
				obj.dragParent = true;
				obj.currentShape = a;
				obj.myId = b;
				handles["cnt"+a]["handle"+b].attachMovie("squareHandle","squareHandle", 1,obj);
				var obj = new Object();
				obj.trgt = this;
				obj.listner = _root.mykeyboard.MCLMap;
				obj.fnz = updatePathAngle;
				obj.currentShape = a;
				obj.myId = b;
				handles["cnt"+a]["handle"+b].attachMovie("roundHandle","roundHandle", 2,obj);
				handles["cnt"+a]["handle"+b]._x = shapesA[a][b][2];
				handles["cnt"+a]["handle"+b]._y = shapesA[a][b][3];
				handles["cnt"+a]["handle"+b]["roundHandle"]._x = shapesA[a][b][0]-shapesA[a][b][2];
				handles["cnt"+a]["handle"+b]["roundHandle"]._y = shapesA[a][b][1]-shapesA[a][b][3];
			}*/
			updateCurrent();
		}
		cntMask.addChild(drawMask)
		//this["handles"]._y = -10000;
	}
	function updateCurrent() {
		trace("updateCurrent"+currentShape)		
		shapesAcnt[currentShape] = new Shape();
		shapesAcnt[currentShape].graphics.beginFill(0x0000FF);
		shapesAcnt[currentShape].graphics.moveTo(shapesA[currentShape][0][2], shapesA[currentShape][0][3]);
		for (var a=1;a<shapesA[currentShape].length;a++) {
			shapesAcnt[currentShape].graphics.curveTo(shapesA[currentShape][a][0], shapesA[currentShape][a][1], shapesA[currentShape][a][2], shapesA[currentShape][a][3]);
			trace("updateCurrent "+shapesA[currentShape][a][3])
			/*if (Math.abs(shapesA[currentShape][a][2]-shapesA[currentShape][a][0]) > 4 || Math.abs(shapesA[currentShape][a][3]-shapesA[currentShape][a][1]) > 4) {
				handles["cnt"+currentShape]["handle"+a].clear();
				handles["cnt"+currentShape]["handle"+a].lineStyle(1,0x0000FF);
				handles["cnt"+currentShape]["handle"+a].moveTo(0, 0)
				handles["cnt"+currentShape]["handle"+a].lineTo(shapesA[currentShape][a][0]-shapesA[currentShape][a][2], shapesA[currentShape][a][1]-shapesA[currentShape][a][3])
			}*/
		}
		shapesAcnt[currentShape].graphics.endFill();
		drawMask.addChild(shapesAcnt[currentShape])
	}
	/*
	function myMouseMove() {
		if (!handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]["roundHandle"]) {
			if (Math.abs(shapesA[currentShape][shapesA[currentShape].length-1][2]-mapTrgt._xmouse) > 4 || Math.abs(shapesA[currentShape][shapesA[currentShape].length-1][3]-mapTrgt._ymouse) > 4) {
				braccioOff = false;
				var obj = new Object();
				obj.trgt = this;
				obj.listner = _root.mykeyboard.MCLMap;
				obj._x = handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]._xmouse;
				obj._y = handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]._ymouse;
				obj.fnz = updatePathAngle;
				obj.currentShape = currentShape;
				obj.myId = shapesA[currentShape].length-1;
				handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)].attachMovie("roundHandle","roundHandle", 2,obj);
			}
		}
		handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]["roundHandle"]._x = handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]._xmouse
		shapesA[currentShape][shapesA[currentShape].length-1][0] = mapTrgt._xmouse;
		handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]["roundHandle"]._y = handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]._ymouse
		shapesA[currentShape][shapesA[currentShape].length-1][1] = mapTrgt._ymouse;
		updateCurrent();
	}
	function myMouseDown() {
		trace("cazzocazzocazzo2 "+shapesA.length)
		if (currentShape == undefined) {
			shapesA.push(new Array());
			currentShape = shapesA.length-1;
			mapTrgt.createEmptyMovieClip("cnt"+currentShape,mapTrgt.getNextHighestDepth());
			handles.createEmptyMovieClip("cnt"+currentShape,handles.getNextHighestDepth());
			if (!Preferences.pref.flxerDrawedMasks.data.lista) {
				Preferences.pref.flxerDrawedMasks.data.lista = new Array();
			}
		}
		trace("cazzocazzocazzo2 "+currentShape)
		shapesA[currentShape].push(new Array(mapTrgt._xmouse,mapTrgt._ymouse,mapTrgt._xmouse,mapTrgt._ymouse));
		handles["cnt"+currentShape].createEmptyMovieClip("handle"+(shapesA[currentShape].length-1), handles["cnt"+currentShape].getNextHighestDepth());
		handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]._x = shapesA[currentShape][shapesA[currentShape].length-1][0];
		handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)]._y = shapesA[currentShape][shapesA[currentShape].length-1][1];
		var obj = new Object();
		obj.trgt = this;
		obj.listner = _root.mykeyboard.MCLMap;
		obj.fnz = updatePath;
		obj.dragParent = true;
		obj.currentShape = currentShape;
		obj.myId = shapesA[currentShape].length-1;
		handles["cnt"+currentShape]["handle"+(shapesA[currentShape].length-1)].attachMovie("squareHandle","squareHandle", 1,obj);
		updateCurrent();
		if (currentMask == undefined) {
			Preferences.pref.flxerDrawedMasks.data.lista.push(shapesA);
			currentMask = Preferences.pref.flxerDrawedMasks.data.lista.length-1
			Preferences.pref.flxerDrawedMasks.flush();
			var tmp = _level0.myCtrl["ch_0"].myWipe.xml_node.childNodes[0].cloneNode(true);
			tmp.attributes.m = "MAP-DRAWER;"+currentMask;
			_level0.myCtrl["ch_0"].myWipe.xml_node.appendChild(tmp);
			for (var item in _level0.myCtrl) {
				item.myWipe.avvia(_level0.myCtrl["ch_0"].myWipe.xml_node);
			}
		} else {
			Preferences.pref.flxerDrawedMasks.data.lista[currentMask] = shapesA
		}
	}
	function updatePathAngle(trgt,shape,id,x,y) {
		trgt.currentShape = shape;
		trgt.shapesA[shape][id][0] = x;
		trgt.shapesA[shape][id][1] = y;
		trgt.updateCurrent();
	}
	function updatePath(trgt,shape,id,x,y) {
		trgt.currentShape = shape;
		var dx = trgt.shapesA[shape][id][0]-trgt.shapesA[shape][id][2];
		var dy = trgt.shapesA[shape][id][1]-trgt.shapesA[shape][id][3];
		trgt.shapesA[shape][id][2] = x;
		trgt.shapesA[shape][id][3] = y;
		trgt.shapesA[shape][id][0] = x+dx;
		trgt.shapesA[shape][id][1] = y+dy;
		trgt.updateCurrent();
	}
	*/

		function redrawWipe(myAction) {
			if (trgtMask) {
				if (this.cntMask.contains(trgtMask)) {
					this.wipesLoader.unload();
					this.cntMask.removeChild(trgtMask);
				}
			}
			for (var a=0;a<drawMask.numChildren;a++){
				this.drawMask.getChildAt(a).graphics.clear();
				this.drawMask.removeChild(this.drawMask.getChildAt(a));
			}
			if (this.cntMask.contains(drawMask)) {
				this.cntMask.removeChild(drawMask);
			}
            baseMask.graphics.beginFill(0xFFFFFF);
            baseMask.graphics.drawRect(-w/2, -h/2, w, h);
            baseMask.graphics.endFill();
		}
		function slideWipe(myAction) {
			if (oldTipo == "mp3") {
				setVol(myAction[3]);
			}
			if (myAction[4] == "WIPE NONE (MIX)") {
				this.cntMask.scaleX = 1;
				this.cntMask.scaleY = 1;
				this.alpha = myAction[3]/100;
				trace("oooooooooo "+this.alpha)
			} else if (myAction[4] == "HORIZONTAL") {
				this.cntMask.scaleX = myAction[3]/100;
				this.cntMask.scaleY = 1;
				this.alpha = 1;
			} else if (myAction[4] == "VERTICAL") {
				this.cntMask.scaleX = 1;
				this.cntMask.scaleY = myAction[3]/100;
				this.alpha = 1;
			} else {
				this.cntMask.scaleX = myAction[3]/100;
				this.cntMask.scaleY = myAction[3]/100;
				this.alpha = 1;
			}
		}
		// END WIPES LOADER
		
		// COLORS
		public function colorizing(myAction) {
			trace(myAction)
			this[myAction[3]].transform.colorTransform = new ColorTransform(1, 1, 1, 1, myAction[4], myAction[5], myAction[6], 1);
			//this[myAction[4]][myAction[5]] = myAction[6];
			//this.mySetTrasform(myAction);
		}
		/*public function mySetTrasform(myAction) {
			if (myAction[4] == "CMT") {
				trace("CMT.rb"+CMT.rb)
				this.vid.transform.colorTransform = new ColorTransform(1, 1, 1, 1, CMT.rb, CMT.gb, CMT.bb, 1);
			} else {
				trace("CFT.rb"+CFT.rb)
				this.bkg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, CFT.rb, CFT.gb, CFT.bb, 1);
			}
		}*/
		function bkgOnOff(myAction) {
			if (myAction[3] == "true") {
				bkg.visible = true;
			} else {
				bkg.visible = false;
			}
		}
		// END COLORS

		// SEQUENCER
		public function PLAY(myAction) {
			this.cacheAsBitmap = this.myStopStatus=false;
			this["PLAY"+oldTipo]();
		}
		public function STOP(myAction) {
			this.cacheAsBitmap = this.myStopStatus=true;
			this["STOP"+oldTipo]();
		}
		public function REWIND(myAction) {
			this["REWIND"+oldTipo]();
		}
		public function FORWARD(myAction) {
			this["FORWARD"+oldTipo]();
		}
		function HIDE(myAction) {
			this.visible = false;
		}
		function SHOW(myAction) {
			this.visible = true;
		}
		// END SEQUENCER

		// END TRASFORM
		function chMove(myAction) {
			this.x = myAction[3];
			this.y = myAction[4];
			vid.x = myAction[5];
			vid.y = myAction[6];
		}
		function scala(myAction) {
			vid.scaleX = myAction[3];
			vid.scaleY = myAction[4];
		}
		function chRotate(myAction) {
			//this.cnt.mask = null;
			cntMask.rotationX = cnt.rotationX = myAction[3];
			cntMask.rotationY = cnt.rotationY = myAction[4];
			cntMask.rotationZ = cnt.rotationZ = myAction[5];
			//this.cnt.mask = this.cntMask;
		}
		function mRotate(myAction) {
			vid.rotationX = myAction[3];
			vid.rotationY = myAction[4];
			vid.rotationZ = myAction[5];
		}
		function resetta(myAction) {
			trace("resetta");
				this.x = 0;
				this.y = 0;
			/*if (!Preferences.pref.myTreDengine.isOn) {
				this.cntMask.scaleX = 1;
				this.cntMask.scaleY = 1;
			}*/
			trace("resetta");
			vid.x = w/2;
			vid.y = h/2;
			vid.rotation = 0;
			vid.scaleX = Preferences.pref.monObj.dScaleX;
			vid.scaleY = Preferences.pref.monObj.dScaleY;
			trace("resetta");
//			bkg.scaleX = 100/(Preferences.pref.monObj.dScaleX*100);
//			bkg.scaleY = 100/(Preferences.pref.monObj.dScaleY*100);
		}
		function chFlipH(myAction) {
			if (myAction[3] == "true") {
				this.x = w;
				this.scaleX = -1;
			} else {
				this.x = 0;
				this.scaleX = 1;
			}
		}
		function chFlipV(myAction) {
			if (myAction[3] == "true") {
				this.y = h;
				this.scaleY = -1;
			} else {
				this.y = 0;
				this.scaleY = 1;
			}
		}
		// END TRASFORM

		function changeBlend(myAction) {
			this.blendMode = myAction[3];
		}
		function setMatrix(myAction) {
			var mat:ColorMatrix=new ColorMatrix();
			mat.adjustHue(Number(myAction[7]));
			mat.adjustSaturation(Number(myAction[8]));
			mat.adjustContrast(Number(myAction[9]));
			mat.adjustBrightness(Number(myAction[10]));
	//		mat.setAlpha(alpha.value / 100);
			if (myAction[11]!= "undefined") {
				mat.threshold(Number(myAction[11]));
			}
			mat.setChannels(Number(myAction[3]),Number(myAction[4]),Number(myAction[5]),Number(myAction[6]));
			var cm:ColorMatrixFilter=new ColorMatrixFilter(mat.matrix);
			this.filters = new Array(cm);
		}
		public function eject(myAction) {
			if (oldTipo) {
				this[oldTipo+"Reset"]();
			}
			oldTipo = undefined;
		}
		function placeObjectIn3D(myAction) {
			trace("this.vid.alpha "+this.vid.alpha)
			trace("this.vid.x "+this.vid.x)
			trace("this.vid.y "+this.vid.y)
			trace("this.vid.scale "+this.vid.scaleY)
			trace("this.scalemask "+this.cntMask.scaleY)
			trace("\\this.alpha "+myAction[3])
			trace("\\this.x "+myAction[4])
			trace("\\this.y "+myAction[5])
			trace("\\this.scale "+myAction[6])
			trace("\\this.scalemask "+myAction[7])
			this.vid.alpha = myAction[3];
			this.vid.x = myAction[4];
			this.vid.y = myAction[5];
			this.vid.scaleX = this.vid.scaleY=myAction[6];
			//this.cntMask.scaleX = this.cntMask.scaleY = this.bkg.scaleX = this.bkg.scaleY=myAction[7];
			trace("this.vid.alpha "+this.vid.alpha)
			trace("this.vid.x "+this.vid.x)
			trace("this.vid.y "+this.vid.y)
			trace("this.vid.scale "+this.vid.scaleY)
			trace("this.scalemask "+this.cntMask.scaleY)
		}
		function mySwapDepth(myAction) {
			parent.setChildIndex(this,parseFloat(myAction[3]));
		}
		function applicaLive(myAction) {
			trace("applicaLive "+myAction[31])
			trace("applicaLive "+myAction[32])
			trace("applicaLive "+myAction[33])
			trace("applicaLive "+myAction[52])
			this[myAction[3]](["a", "b", myAction[4], myAction[5], myAction[6], myAction[7]]);
			if (!Preferences.pref.myTreDengine) {
			trace("applicaLive daje")
				this.x = myAction[8];
				this.y = myAction[9];
				if (myAction[16] != "WIPE NONE (MIX)" && myAction[16] != "HORIZONTAL" && myAction[16] != "VERTICAL") {
					changeWipe(["a", "b", "c", myAction[16]]);
				}
				slideWipe(["a", "b", "c", myAction[15], myAction[16]]);
			}
			this.vid.x = myAction[10];
			this.vid.y = myAction[11];
			this.vid.scaleX = (myAction[12]/100)*Preferences.pref.monObj.dScaleX;
			this.vid.scaleY = (myAction[13]/100)*Preferences.pref.monObj.dScaleY;
			this.vid.rotation = myAction[14];
			colorizing(["a", "b", "c", myAction[17], myAction[18], myAction[19], myAction[20]]);
			colorizing(["a", "b", "c", myAction[21], myAction[22], myAction[23], myAction[24]]);
			colorizing(["a", "b", "c", myAction[25], myAction[26], myAction[27], myAction[28]]);
			bkgOnOff(["a", "b", "c", myAction[29]]);
			mySwapDepth(["a", "b", "c", myAction[30]]);
			changeBlend(["a", "b", "c", myAction[31]]);
			setMatrix(["a", "b", "c", myAction[32], myAction[33], myAction[34], myAction[35], myAction[36], myAction[37], myAction[38], myAction[39], myAction[40], myAction[41], myAction[42], myAction[43]]);
			if (myAction[41]) {
				colorizing(["a", "b", "c", myAction[41], myAction[42], myAction[43], myAction[44]]);
				colorizing(["a", "b", "c", myAction[45], myAction[46], myAction[47], myAction[48]]);
				colorizing(["a", "b", "c", myAction[49], myAction[50], myAction[51], myAction[52]]);
			}
		}
		function myHQ(myAction) {
			stage.quality = StageQuality[myAction[3]];
		}




		function ALIGNtxt(myAction) {
			if (myTxt) {
			this.txtKS.align = myAction[3];
/*
			if (this.txtKS.align == "right") {
				swfLoader.content.lab.x = -1000;
			} else if (this.txtKS.align == "left") {
				swfLoader.content.lab.x = -w/2;
			} else {
				swfLoader.content.lab.x = -600;
			}
*/
			swfLoader.content.lab.defaultTextFormat = this.txtKS
			}
		}
		function FONTtxt(myAction) {
			this.myFont = myAction[3]
			setFont()			
		}
		function setFont() {
			if (this.myFont == "hooge 05_55") {
				this.txtKS.font = Preferences.pref.ts.font;
				swfLoader.content.lab.embedFonts = true;
			} else if (this.myFont == "standard 07_53") {
				this.txtKS.font = Preferences.pref.th.font;
				swfLoader.content.lab.embedFonts = true;
			} else {
				this.txtKS.font = this.myFont;
				swfLoader.content.lab.embedFonts = false;
			}
			swfLoader.content.lab.defaultTextFormat = this.txtKS
			//swfLoader.content.lab.setTextFormat(Preferences.pref.th);
			//swfLoader.content.lab.setNewTextFormat(this.txtKS);
		}
		function FORWARDtxt() {
			swfLoader.forwardTxt();
		}
		function REWINDtxt() {
			swfLoader.rewindTxt();
			//_root.myCtrl[this.name].myTxtEditor.currentReaderMode.myRewind(_root.myCtrl[this.name].myTxtEditor);
		}
		function STOPtxt() {
			swfLoader.stopTxt();
			//_root.myCtrl[this.name].myTxtEditor.currentReaderMode.myStop(_root.myCtrl[this.name].myTxtEditor);
		}
		function PLAYtxt() {
			swfLoader.playTxt();
			//_root.myCtrl[this.name].myTxtEditor.currentReaderMode.myPlay(_root.myCtrl[this.name].myTxtEditor);
		}
		/**/
		/*
		function effectUpdate(myAction) {
			var tmp = "";
			for (var a = 4; a<myAction.length; a++) {
				tmp += myAction[a];
				if (a<myAction.length-1) {
					tmp += ",";
				}
			}
			eval(myAction[3]).avvia(tmp);
		}
		function insertEffectMovie(myAction) {
			this.effects.createEmptyMovieClip("e"+myAction[3], parseFloat(myAction[3]));
			this.effects["livee"+myAction[3]] = myAction[5];
			this.my_wipeslL.errore = 0;
			this.my_wipeslL.clip = this.effects["e"+myAction[3]];
			this.wipesLoader.loadClip(myAction[4], this.effects["e"+myAction[3]]);
		}
		function removeEffectMovie(myAction) {
			this.effects["e"+myAction[3]].resetta();
			this.effects["e"+myAction[3]].removeMovieClip();
		}
		function set_txt(myAction) {
			cnt.txt.text = myAction[3];
			//cnt.txt.setTextFormat(this.txtKS);
		}
		function set_txtArea(myAction) {
			cnt.txt.width = myAction[3];
		}
*/
	}
}