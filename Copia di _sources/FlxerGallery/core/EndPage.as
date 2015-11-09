package FlxerGallery.core {
	import flash.display.Sprite;
	import fl.transitions.easing.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	import FlxerGallery.main.Rett;
	import FlxerGallery.main.DrawerFunc;
	import FlxerGallery.componenti.FotoSlider;
	import FlxerGallery.componenti.ButtonImg;
	import FlxerGallery.comp.ButtonSelector;

	public class EndPage extends Sprite {
		//PARAMETRI
		public var cnt
		public var fondo
		public var myW
		public var myH
		public var myHfooter = Preferences.pref.thh;
		
		public var myPadding = 4
		public var myThumbSpacer = 4
		

		public var myFunz
		
		public var localXml
		public var numVoci

		//ELEMENTI
		public var footerSprite;
		public var parteAltaSprite;
		public var btnRePlay
		public var btnBuyNow
		public var btnSendTo;
		
		
		public function EndPage(xml, imgReplay, fnz) {
			/*
			this.myW = Preferences.pref.w;
			this.myh = (Preferences.pref.toolbarBottom ? Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.piedeH+Preferences.pref.testaY) : Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.testaY));
			*/
			var myContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			var item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].playAgain)
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,fnz);
			myContextMenu.customItems.push(item);
			item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].buyNowAlt)
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,btnBuyNowAct);
			myContextMenu.customItems.push(item);
			item = new ContextMenuItem(Preferences.pref.lab[Preferences.pref.lng].sendToFriends)
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,btnSendToAct);
			myContextMenu.customItems.push(item);
			this.contextMenu = myContextMenu;
			
			this.myW = 400
			this.myH = 300
			
			this.localXml = xml
			this.myFunz = fnz

			
			this.fondo = new Sprite();
			DrawerFunc.drawer(fondo,0,0,myW,myH,0xFFFFFF,null,.4);
			DrawerFunc.drawer(fondo,0,0,myW,myH,0x000000,null,.4);
			this.addChild(this.fondo);
			
			this.cnt = new Sprite();
			this.addChild(this.cnt)
			
			//this.btnRePlay = new ButtonSelector(this.myPadding, this.myPadding, fnz, 1, "jpg", this.localXml.childNodes[0].childNodes[0].childNodes[2].childNodes[0].toString(),Preferences.pref.lab[Preferences.pref.lng].playAgain);
			this.btnRePlay = new ButtonSelector(this.myPadding, this.myPadding, fnz, 1, "jpg", imgReplay,Preferences.pref.lab[Preferences.pref.lng].playAgain);
			//this.btnRePlay = new ButtonImg     (this.myPadding,this.myPadding,112,84,this.localXml.childNodes[0].childNodes[0].childNodes[2].childNodes[0],vaiUrl, null, Preferences.pref.lab[Preferences.pref.lng].playAgain, 1)
			this.cnt.addChild(this.btnRePlay)
			var ppBig = new PlayBig();
			ppBig.scaleX = ppBig.scaleY = .5;
			ppBig.x = (btnRePlay.width-ppBig.width)/2;
			ppBig.y = (btnRePlay.height-ppBig.height)/2;
			ppBig.simb.gotoAndStop(1);
			this.btnRePlay.addChild(ppBig);

			this.btnBuyNow  = new buttonBuy();
			this.cnt.addChild(this.btnBuyNow);
			btnBuyNow.avvia({noResize:true,fnz:btnBuyNowAct,param:"",txt:Preferences.pref.lab[Preferences.pref.lng].buyNow,alt:Preferences.pref.lab[Preferences.pref.lng].buyNowAlt});
			btnBuyNow.x = btnRePlay.x + 128 + this.myThumbSpacer
			btnBuyNow.y = this.myPadding
			
			this.btnSendTo  = new buttonSend()
			this.cnt.addChild(this.btnSendTo)
			btnSendTo.x = btnBuyNow.x + btnBuyNow.width + this.myThumbSpacer
			btnSendTo.y = this.myPadding
			btnSendTo.avvia({noResize:true,fnz:btnSendToAct,param:this.localXml.childNodes[0].childNodes[1].childNodes[0].toString(),txt:Preferences.pref.lab[Preferences.pref.lng].sendToFriends,alt:Preferences.pref.lab[Preferences.pref.lng].sendToFriendsAlt});
			
			this.footerSprite = new FotoSlider(0,this.myH-this.myHfooter,this.myW,this.myHfooter+10,this.localXml.childNodes[0].childNodes[2],this.vaiUrl)
			this.cnt.addChild(this.footerSprite);
			//this.cnt.removeChild(this.btnBuyNow);
			
			this.resizza();/**/
		}
		public function resizza() {
			//var h = (Preferences.pref.toolbarBottom ? Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.piedeH+Preferences.pref.testaY) : Preferences.pref.h-(Preferences.pref.testaH+Preferences.pref.testaY));
			var h = Preferences.pref.h;
			var w = Preferences.pref.w;
			myX = this.cnt.x = ((w/2)-(this.myW/2));
			myY = this.cnt.y = ((h/2)-(this.myH/2));
			this.fondo.width = w;
			this.fondo.height = h;
		}
		public function buttonControl(p) {
			var localLink = p
			this.vaiUrl(localLink)
		}
		public function btnBuyNowAct(p) {
			this.vaiUrl(this.localXml.childNodes[0].childNodes[0].childNodes[0].toString())
		}
		public function btnSendToAct(p) {
			parent.myToolbar.apriEmbed(p);
		}
		public function vaiUrl(p) {
			if(p==null){
				this.myFunz()
			}else{
				navigateToURL(new URLRequest(Starter.myReplace(p, "&amp;", "&")), "_self");
			}
		}
	}
}