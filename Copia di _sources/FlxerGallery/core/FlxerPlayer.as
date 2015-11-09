package FlxerGallery.core {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.utils.*;
   	import flash.events.*;
	import flash.net.*;
	import flash.display.Shape;
	import flash.external.ExternalInterface;

	import FlxerGallery.main.DrawerFunc;
	import FLxER.core.Player;

	public class FlxerPlayer extends Sprite {
		var ssInt;
		public var myloaded:Boolean;
		public var h;
		var n;
		//
		var fondo;
		var myPlayer;
		var myMask;
		var index
		var swf_status
		var myTxtLoader:URLLoader
		public var currMov;
		public var tmpTrgt
		public var myMaskera;
		public function FlxerPlayer() {
			listaSS = [];
			if (Preferences.pref.toolbarBottom) {
				this.y = Preferences.pref.testaH+Preferences.pref.testaY;
			} else {
				this.y = 0; 
			}
			h = (Preferences.pref.toolbarBottom ? Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.piedeH+Preferences.pref.testaY) : Preferences.pref.h);
			w = Preferences.pref.w
			trace("Larghezza Schermo: "+w);
			trace("Altezza Schermo: "+h);
			if (Preferences.pref.playerBackground != "square") {
				fondo = new Sprite();
				DrawerFunc.drawer(fondo,0,0,w,h,Preferences.pref.playerBackground,null,1);
			} else {
				fondo = new Shape();
				DrawerFunc.textureDrawer(fondo, w, h);
			}
			this.addChild(fondo);
			this.myPlayer = new Player(1,w,h);
			this.myMask = new Sprite();
			DrawerFunc.drawer(myMask,0,0,w,h,0x000000,null,1);
			//this.myPlayer.x = this.myMask.x = int(w/2);
			//this.myPlayer.y = this.myMask.y = int(h/2);
			this.addChild(myPlayer);
			this.addChild(myMask);
			this.myPlayer.mask = myMask;
			if(Preferences.pref.maskera) {
				this.myMaskera = new maskera();
				this.addChild(myMaskera);
			}
			//}
		}
		public function avvia(i) {
			trace("avviaavviaavviaavviaavviaavviaavviaavviaavviaavviaavviaavviaavviaavviaavvia")
			if (myMaskera is maskera) {
				if (this.contains(myMaskera)) {
					this.myMaskera.avvia();
				}
			}
			if (this.parent.myToolbar.hasEventListener(Event.ENTER_FRAME)) {
				this.parent.myToolbar.removeEventListener(Event.ENTER_FRAME, this.parent.myToolbar["indice_"+Preferences.pref.tipo]);
			}
			if (parent.parent.home.childNodes[0].childNodes[i].attributes.type) {
				Preferences.pref.tipo = parent.parent.home.childNodes[0].childNodes[i].attributes.type;
			} else {
				var tmp = parent.parent.home.childNodes[0].childNodes[i].childNodes[0].childNodes[0].toString();
				Preferences.pref.tipo = tmp.substring(tmp.lastIndexOf(".")+1, tmp.length).toLowerCase();
			}
			trace(Preferences.pref.tipo)
			if (Preferences.pref.tipo == "png" || Preferences.pref.tipo == "gif" || Preferences.pref.tipo == "jpg") {
				listaSS = [];
				generaListaSS();
				Preferences.pref.tipo = "jpg";
				this.parent.myToolbar.piede.counter.lab.htmlText = listaSS.length+" / "+listaSS.length;
			} else {
				if (Preferences.pref.tipo == "mp4" || Preferences.pref.tipo == "mov" || Preferences.pref.tipo == "avi" || Preferences.pref.tipo == "mpg" || Preferences.pref.tipo == "m4v" || Preferences.pref.tipo == "flv") {
					Preferences.pref.tipo = "flv";
				}
				this.parent.myToolbar.piede.counter.lab.htmlText = "00:00 / 00:00";
			}
			if (this.parent.myThumbLoader) {
				if(this.parent.contains(this.parent.myThumbLoader)){
					this.parent.removeChild(this.parent.myThumbLoader);
				}
			}
			this.parent.myToolbar.setPos();
			avviaCommon(i);
			this["avvia_"+Preferences.pref.tipo](index);
		}
		public function avviaCommon(i) {
			this.parent.myToolbar.avvia("player");
			resetta();
			this.visible = true;
			index = i;
			firstTime = true;
			firstTime2 = true;
			this.parent.myToolbar.disable();
		}
		public function avviaSS(i) {
			if (this.parent.myToolbar.hasEventListener(Event.ENTER_FRAME)) {
				this.parent.myToolbar.removeEventListener(Event.ENTER_FRAME, this.parent.myToolbar["indice_"+Preferences.pref.tipo]);
			}
			Preferences.pref.tipo = "jpg";
			avviaCommon(i);
			avvia_jpg(i);
		}
		public function resetta() {
			//this.parent.myToolbar.resetta();
			mbuto(getTimer()+",eject,0");
			//myloaded = mcLoaded=swf_started=false;
			l = 0;
			n = 0;
			clearInterval(this.ssInt);
			this.visible = false;
		}
		public function mbuto(azione) {
			trace("MMmbuto"+azione);
			var myAction = azione.split(",");
			this.myPlayer[myAction[1]](myAction);
		}
		/* SWF /////////////////*/
		function avvia_swf(index) {
			swf_status = false;
			setLink(parent.parent.home.childNodes[0].childNodes[index].attributes.page_url);
			var tmp = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();
			if (tmp.lastIndexOf("cnt=") != -1) {
				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
			}
			load_swf(tmp);
			//this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();
			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();
			this.parent.myToolbar.testa.lab_i.htmlText = this.parent.myToolbar.tit;
		}
		/* TXT /////////////////*/
		function avvia_txt(index) {
			setLink(parent.parent.home.childNodes[0].childNodes[index].attributes.page_url);
			Preferences.pref.txtFile = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();
			
			myTxtLoader = new URLLoader();
			//myTxtLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            myTxtLoader.addEventListener(Event.COMPLETE, load_txt);
			myTxtLoader.load(new URLRequest(Preferences.pref.txtFile));
			
			
			currMov = Preferences.pref.txtFile;
			//this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();
			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();
			this.parent.myToolbar.testa.lab_i.htmlText = this.parent.myToolbar.tit;
		}
		function load_txt(event) {
			mbuto(getTimer()+",loadMedia,0,"+Preferences.pref.txtSwfReader+",swf,100,"+myTxtLoader.data+","+(Preferences.pref.ss_time/10));
		}
		/* MP3 /////////////////*/
		function avvia_mp3(index) {
			setLink(parent.parent.home.childNodes[0].childNodes[index].attributes.page_url);
			currMov = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();
			var currThumb = parent.parent.home.childNodes[0].childNodes[index].childNodes[2].childNodes[0].toString();
			mbuto(getTimer()+",loadMp3,0,"+currMov+","+Preferences.pref.tipo+","+parent.myToolbar.piede.volume_ctrl.getVal()+","+currThumb);
			//this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();
			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();
			this.parent.myToolbar.testa.lab_i.htmlText = this.parent.myToolbar.tit;
		}
		public function initHandlerMP3() {
			myPlayer.myStopStatus = false;
			this.parent.myToolbar.piede.contr.playpause.simb.gotoAndStop(2);
			this.parent.myToolbar.enable()
			this.parent.myToolbar.avvia_indice();
		}
		/* FLV /////////////////*/
		public function avvia_flv(index) {
			setLink(parent.parent.home.childNodes[0].childNodes[index].attributes.page_url);
			//this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();
			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();
			this.parent.myToolbar.testa.lab_i.htmlText = this.parent.myToolbar.tit+": Buffering...";
			var tmp = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();
			if (tmp.lastIndexOf("cnt=") != -1) {
				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
			}
			currMov = tmp;
			mbuto(getTimer()+",loadFlv,0,"+currMov+","+parent.myToolbar.piede.volume_ctrl.getVal());
		}
		public function initHandlerFLV(event) {
			trace(event.info.code)
			switch (event.info.code) {
				case "NetStream.Buffer.Full" :
					if (firstTime2) {
						firstTime2 = false;
					}
					break;
				case "NetStream.Play.Start" :
					if (firstTime) {
						this.parent.myToolbar.testa.lab_i.htmlText = this.parent.myToolbar.tit;
						this.parent.myToolbar.enable()
						this.parent.myToolbar.avvia_indice();
						//resizza();
						firstTime = false;
						myPlayer.myStopStatus = false;
						this.parent.myToolbar.piede.contr.playpause.simb.gotoAndStop(2);
						//nsclosed = false;
					}
					//resizza();
					break;
				case "NetStream.Play.Stop" :
					if (Preferences.pref.endpPath) {
						myPlayer.NS.seek(0);
						this.parent.myToolbar.myPlaypause(null);
						this.parent.loadFooter();
					} else {
						if (Preferences.pref.myLoop) {
							myPlayer.NS.seek(0);
						} else {
							if (parent.parent.home.childNodes[0].childNodes.length>1) {
								this.parent.myToolbar.avvia("selector");
							} else {
								myPlayer.NS.seek(0);
								this.parent.myToolbar.myPlaypause(null);
							}
						}
					}
					break;
			}
		}
		function errorHandlerMess(event_type) {
			trace(event_type)
			this.parent.myToolbar.testa.lab_i.htmlText = this.parent.myToolbar.tit+": "+event_type;
			try {
				if (ExternalInterface.available) {
					ExternalInterface.call("alert", event_type);
				}
			}
			catch (error) {
				navigateToURL(new URLRequest("javascript:alert('"+event_type+"')"));
			}
		}
		function errorHandlerJPG(event) {
			errorHandlerMess(event.type)
		}
		function errorHandlerMP3(event) {
			errorHandlerMess(event.type)
		}
		function errorHandlerSWF(event) {
			errorHandlerMess(event.type)
		}
		function errorHandlerFLV(event) {
			trace(event.info.code)
			switch (event.info.code) {
				case "NetStream.Play.FileStructureInvalid" :
				case "NetStream.Play.StreamNotFound" :
					errorHandlerMess(Starter.myReplace(event.info.code,"NetStream.Play.",""));
					break;
				case "NetStream.Play.NoSupportedTrackFound" :
					if (Preferences.pref.fpUpJsError) {
						this.parent.myToolbar.testa.lab_i.htmlText = this.parent.myToolbar.tit+": "+Starter.myReplace(event.info.code,"NetStream.Play.","");
						try {
							if (ExternalInterface.available) {
								ExternalInterface.call(Preferences.pref.fpUpJsError, "Error loading content.");
							}
						}
						catch (error) {
							navigateToURL(new URLRequest("javascript:"+Preferences.pref.fpUpJsError+"('Error loading content.')"));
						}
					} else {
						errorHandlerMess(Starter.myReplace(event.info.code,"NetStream.Play.",""));
					}
					break;
			}
		}
		/* IMMAGINI /////////////////*/
		function avvia_jpg(index) {
			for (var a = 0; a<listaSS.length; a++) {
				if (parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString() == parent.parent.home.childNodes[0].childNodes[listaSS[a]].childNodes[0].childNodes[0].toString()) {
					index = a;
				}
			}
			if (index != undefined || index == 0) {
				this.parent.myToolbar.piede.contr.playpause.simb.gotoAndStop(2);
				n = index;
			} else {
				this.parent.myToolbar.mRoot.customItems[0].enabled = true;
			}
			//this.parent.myToolbar.piede.indice.curs.puls.enabled = false;
			load_foto();
		}
		function generaListaSS() {
			for (var a = 0; a<parent.parent.home.childNodes[0].childNodes.length; a++) {
				var tmp = parent.parent.home.childNodes[0].childNodes[a].childNodes[0].childNodes[0].toString();
				tmp = tmp.substring(tmp.length-3, tmp.length).toLowerCase();
				if (tmp == "jpg" || tmp == "png" || tmp == "gif") {
					listaSS.push(a);
				}
			}
		}
		public function load_prev_foto() {
			if (n>1) {
				n-=2;
			} else if (n == 0) {
				n = listaSS.length-2;
			} else {
				n = listaSS.length-1;
			}
			load_foto()
		}
		function mouseOverHandler(e) {
			Preferences.pref.myAlt.avvia(Preferences.pref.lab[Preferences.pref.lng].pageDett);
		}
		function mouseOutHandler(e) {
			//Preferences.pref.myAlt.stoppa();
		}
		function setLink(xxx) {
			if (xxx) {
				if (xxx.length>0) {
					Preferences.pref.page_url = xxx;
					this.addEventListener(MouseEvent.MOUSE_DOWN, vaiUserURL);
					this.addEventListener(MouseEvent.MOUSE_MOVE,mouseOverHandler);
					//this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
					this.buttonMode=true;
				}
			} else {
				if (this.hasEventListener(MouseEvent.MOUSE_DOWN)) {
					this.removeEventListener(MouseEvent.MOUSE_DOWN, vaiUserURL);
					this.removeEventListener(MouseEvent.MOUSE_MOVE,mouseOverHandler);
					//this.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
					this.buttonMode=false;
				}
				Preferences.pref.page_url = undefined;
				/**/
			}
		}
		function loadNext() {
			if (Preferences.pref.tipo == "jpg" && listaSS.length>0 && !this.parent.mySuperPlayer.myPlayer.myStopStatus) {
				load_foto();
			}
		}
		public function load_foto() {
			this.parent.myToolbar.disable()
			clearInterval(this.ssInt);
			setLink(parent.parent.home.childNodes[0].childNodes[listaSS[n]].attributes.page_url);
			var tmp = parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[0].childNodes[0].toString();
			if (tmp.lastIndexOf("cnt=") != -1) {
				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
			}
			currMov = tmp;
			mbuto(getTimer()+",loadImg,0,"+currMov+","+Preferences.pref.tipo+","+parent.myToolbar.piede.volume_ctrl.getVal());
			if (parent.parent.home.childNodes[0].childNodes.length>1) {
				//this.parent.myToolbar.tit = (n+1)+" / "+listaSS.length+" - "+parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[1].childNodes[0].childNodes[0].toString();
				this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[1].childNodes[0].childNodes[0].toString();
				this.parent.myToolbar.piede.counter.lab.htmlText = (n+1)+" / "+listaSS.length;
				this.parent.myToolbar.piede.indice.curs.x = (((this.parent.myToolbar.barr_width)/(listaSS.length-1))*n);
				l++;
			} else {
				this.parent.myToolbar.piede.counter.lab.htmlText = (n+1)+" / "+listaSS.length;
				this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[1].childNodes[0].childNodes[0].toString();
			}
			this.parent.myToolbar.testa.lab_i.htmlText = this.parent.myToolbar.tit;
		}
		public function initHandlerJPG(trgt) {
			clearInterval(this.ssInt);
			if (listaSS.length>1) {
				if (n>listaSS.length-2) {
					if (Preferences.pref.myLoop) {
						n = 0;
						this.ssInt = setInterval(loadNext, Preferences.pref.ss_time);
					} else {
						if (Preferences.pref.endpPath) {
							//this.parent.loadFooter();
							this.myPlayer.myStopStatus = true;
							n = 0;
							this.ssInt = setInterval(this.parent.loadFooter, Preferences.pref.ss_time);
						} else {
							this.ssInt = setInterval(avviaSelector, Preferences.pref.ss_time);
						}
					}
				} else {
					n++;
					this.ssInt = setInterval(loadNext, Preferences.pref.ss_time);
				}
				this.parent.myToolbar.enable()
				this.parent.myToolbar.piede.indice.curs.disable()
			}
		}
		function load_swf(mov) {
			currMov = mov;
			mbuto(getTimer()+",loadMedia,0,"+currMov+","+Preferences.pref.tipo+","+parent.myToolbar.piede.volume_ctrl.getVal());
		}
		function avviaSelector() {
			clearInterval(this.ssInt);
			this.parent.myToolbar.avviaSelector(null);
		}
		public function initHandlerSWF(trgt) {
			/*if (Preferences.pref.tipo == "txt") {
				trgt.avvia(Preferences.pref.txtFile)
			}*/
			swf_status = true;
			myPlayer.myStopStatus = false;
			if(trgt is flash.display.MovieClip) {
				this.parent.myToolbar.piede.contr.playpause.simb.gotoAndStop(2);
				this.parent.myToolbar.enable()
				this.parent.myToolbar.piede.volume_ctrl.disable();
				this.parent.myToolbar.avvia_indice();
			}
			//resizza();
		}
		function setPos() {
			h = (Preferences.pref.toolbarBottom ? Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.piedeH+Preferences.pref.testaY) : Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.testaY));
			w = Preferences.pref.w;
			if (Preferences.pref.playerBackground != "square") {
				fondo.width = myMask.width = w;
				fondo.height = myMask.height = h;
			} else {
				DrawerFunc.textureDrawer(fondo, w, h);
				myMask.width = w;
				myMask.height = h;
			}
			//myPlayer.x = myMask.x = int(w/2);
			//myPlayer.y = myMask.y = int(h/2);
			//fondo.x = int(w/2);
			//fondo.y = int(h/2);
			myPlayer.resizer(w,h);
		}
		/*public function resizza_old(www=null,hhh=null) {
			if (myMaskera is maskera) {
				if (this.contains(myMaskera)) {
					this.myMaskera.resizza();
				}
			}
				//navigateToURL(new URLRequest("javascript:alert('width "+www+"')"));
			if (myPlayer.oldTipo) {
				h = (Preferences.pref.toolbarBottom ? Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.piedeH+Preferences.pref.testaY) : Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.testaY));
				w = Preferences.pref.w
				var item;
				if (myPlayer.oldTipo == "flv") {
					tmpTrgt = this.myPlayer.myVideo;
					if (tmpTrgt.videoWidth) {
						www = tmpTrgt.videoWidth
						hhh = tmpTrgt.videoHeight
					}
				} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "mp3") {
					tmpTrgt = this.myPlayer.imgToShow;
				} else if (myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt") {
					tmpTrgt = this.myPlayer.swfTrgt;
				}
				//
				if (Preferences.pref.resizza_onoff) {
					if (myPlayer.oldTipo == "flv") {
						if (www) {
							if ((www/hhh)>(w/h)) {
								tmpTrgt.width = w
								tmpTrgt.scaleY = tmpTrgt.scaleX;
							} else {
								tmpTrgt.height = h
								tmpTrgt.scaleX = tmpTrgt.scaleY;
							}
							tmpTrgt.width = Math.round(tmpTrgt.width)
							tmpTrgt.height = Math.round(tmpTrgt.height)
						}
					} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "mp3") {
						if ((tmpTrgt.width/tmpTrgt.height)>(w/h)) {
							tmpTrgt.width = w
							tmpTrgt.scaleY = tmpTrgt.scaleX;
						} else {
							tmpTrgt.height = h
							tmpTrgt.scaleX = tmpTrgt.scaleY;
						}
						tmpTrgt.width = Math.round(tmpTrgt.width)
						tmpTrgt.height = Math.round(tmpTrgt.height)
					} else if (myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt") {
						if (swf_status) {
							trace(tmpTrgt.scaleX)
							tmpTrgt.scaleX = w/Preferences.pref.swfW;
							tmpTrgt.scaleY = h/Preferences.pref.swfH;
							if ((Preferences.pref.swfW/Preferences.pref.swfH)>(w/h)) {
								tmpTrgt.scaleX = tmpTrgt.scaleY=(w/Preferences.pref.swfW);
							} else {
								tmpTrgt.scaleY = tmpTrgt.scaleX=(h/Preferences.pref.swfH);
							}
						}
					}
				} else {
					if (myPlayer.oldTipo == "flv" && www) {
						tmpTrgt = this.myPlayer.myVideo;
						tmpTrgt.width = www;
						tmpTrgt.height = hhh;
					} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "mp3") {
						tmpTrgt = this.myPlayer.imgToShow;
					} else if (myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt") {
						this.myPlayer.swfTrgt.scaleY = this.myPlayer.swfTrgt.scaleX = 1;
					}
					if (Preferences.pref.resizzaJs) {
						try {
							if (ExternalInterface.available) {
								ExternalInterface.call(Preferences.pref.resizzaJs,tmpTrgt.width,tmpTrgt.height);
							}
						}
						catch (error) {
							navigateToURL(new URLRequest("javascript:"+Preferences.pref.resizzaJs+"('"+tmpTrgt.width+"','"+tmpTrgt.height+"')"));
						}
					}
				}
				if (Preferences.pref.centra_onoff) {
					if (myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt") {
						if (swf_status) {
							tmpTrgt.x = -(Preferences.pref.swfW*tmpTrgt.scaleX)/2;
							tmpTrgt.y = -(Preferences.pref.swfH*tmpTrgt.scaleY)/2;
							tmpTrgt.visible = true;
						}
					} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "flv" || myPlayer.oldTipo == "mp3") {
						tmpTrgt.x = -int(tmpTrgt.width/2);
						tmpTrgt.y = -int(tmpTrgt.height/2);
						tmpTrgt.visible = true;
					}
				} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "flv" || myPlayer.oldTipo == "swf" || myPlayer.oldTipo == "txt" || myPlayer.oldTipo == "mp3") {
					tmpTrgt.x = -int(w/2);
					tmpTrgt.y = -int(h/2);
					tmpTrgt.visible = true;
				}
			}
				//navigateToURL(new URLRequest("javascript:alert('width "+tmpTrgt.width+"\\nheight "+tmpTrgt.height+"\\nparent.x "+tmpTrgt.parent.x+"\\nparent.y+ "+tmpTrgt.parent.y+"\\nx "+tmpTrgt.x+"\\ny "+tmpTrgt.y+"')"));
		}*/
		public function vaiUserURL(t) {
			navigateToURL(new URLRequest(Preferences.pref.page_url),"_self")
		}
	}
}