package FLxER.comp {
	import flash.display.Sprite;
	import flash.utils.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	//import fl.motion.Color;
	import flash.events.KeyboardEvent;  
	import flash.ui.Keyboard; 

	import FLxER.main.Rett;
	import FLxER.main.Txt;
	import FLxER.comp.ButtonRett;
	public class SliderTxt extends Sprite {
		var w:Number;
		var h:Number;
		var myStart:Number;
		var val:Number;
		var fnz:Function;
		var alt:String;
		var suffix:String;
		///////
		var txt:Txt;
		var lab:Txt;
		var labb:Rett;
		//
		var myDelta:Number;
		//
		var min:Number
		var max:Number
		var limit:Boolean
		public function SliderTxt(xx:Number,yy:Number,ww:uint,hh:uint, l:String, s:String, v:Number, f:Function, a:String, d:Number=0, minn:Number=0, maxx:Number=0, ll:Boolean=false):void {
			x = xx;
			y = yy;
			w = ww;
			h = hh;
			val = myStart = v
			fnz = f
			alt = a;
			suffix = s;
			myDelta = d;
			min = minn;
			max = maxx;
			limit = ll;
			this.lab = new Txt(0, 0, 0, h,  l, Preferences.pref.th, null);
			this.addChild(lab);
			var xtxt = (lab.textWidth>5 ? lab.textWidth+5 : 10)
			this.txt = new Txt(xtxt, 0, w-xtxt, h,  (suffix=="%" ? (val-myDelta)*100 : val-myDelta).toString()+suffix, Preferences.pref.th, null);
			this.addChild(txt);
			labb = new Rett(0,0,w,h,Preferences.pref.myCol.bkgCol,-1,1);
			labb.alpha = 0.1;
			this.addChild(labb);
			myEnable()
		}
		public function myDisable():void {
			this.labb.removeEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.labb.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			this.labb.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			this.labb.removeEventListener(MouseEvent.DOUBLE_CLICK,mouseDoubleDownHandler);
			this.labb.buttonMode = false;
		}
		public function myEnable():void {
			this.labb.doubleClickEnabled = true;
			this.labb.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.labb.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			this.labb.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			this.labb.addEventListener(MouseEvent.DOUBLE_CLICK,mouseDoubleDownHandler);
			this.labb.buttonMode = true;
		}
		function mouseOverHandler(event:Event):void {
			this.txt.textColor = Preferences.pref.myCol.bkgColOver;
			if (Preferences.pref.vKS && alt) {
				Preferences.pref.myAlt.avvia(alt);
			}
		}
		function mouseOutHandler(event:Event):void {
			this.txt.textColor = Preferences.pref.th.color;
			if (Preferences.pref.vKS && alt) {
				Preferences.pref.myAlt.stoppa();
			}
		}
		function mouseDownHandler(event:Event):void {
			trace("mouseDownHandler")
			stage.addEventListener(Event.ENTER_FRAME, mySetValue)
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler)
			if (Preferences.pref.vKS && alt) {
				Preferences.pref.myAlt.stoppa();
			}
		}
		function mouseUpHandler(event:Event):void {
			stage.removeEventListener(Event.ENTER_FRAME, mySetValue)
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler)
			mouseOutHandler(event)
		} 
		function mouseDoubleDownHandler(event:Event):void {
			this.removeChild(labb);
			txt.type="input";
			txt.background = true;
			txt.selectable = true;
			txt.text = int(suffix=="%" ? (val-myDelta)*100 : val-myDelta);
			txt.stage.focus=txt
			txt.setSelection(0, txt.text.length);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKey);  
		}
		function pressKey(event:KeyboardEvent):void  {  
			if(event.keyCode == Keyboard.ENTER) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, pressKey);  
				this.addChild(labb);
				myEnable();
				txt.stage.focus=Preferences.pref.interfaceTrgt.parent;
				txt.type="dynamic";
				txt.background = false;
				txt.selectable = false;
				if (limit) {
					if (int(txt.text)>=min && int(txt.text)<=max ) {
					} else {
						if (int(txt.text)<min) {
							txt.text = min;
						} else {
							txt.text = max;
						}
					}
				}
				val = (suffix=="%" ? (int(txt.text)+myDelta)/100 : int(txt.text)+myDelta);
				txt.text = int(suffix=="%" ? (val-myDelta)*100 : val-myDelta).toString()+suffix;
				fnz(val)
			}
		}  
		function mySetValue(p:String):void {
			var tmp = int((this.mouseX-(w/2))/10);
			tmp = (Math.abs(tmp)>15 ? 15*(tmp/Math.abs(tmp)) : tmp);
			tmp = (suffix=="%" ? tmp/100 : tmp);
			trace("min "+min)
			trace("max "+max)
			if (limit) {
				if (val + tmp>=min && val + tmp<=max ) {
					val += tmp;
				} else {
					if (val + tmp<min) {
						val = min;
					} else {
						val = max;
					}
				}
			} else {
				val += tmp;
			}
			txt.text = int(suffix=="%" ? (val-myDelta)*100 : val-myDelta).toString()+suffix;
			fnz(val)
		}  
		public function scrolla(p:Number):void {
			val = (suffix=="%" ? val+(p/100) : val+p)
			txt.text = int(suffix=="%" ? (val-myDelta)*100 : val-myDelta).toString()+suffix;
			fnz(val)
		}  
		public function setVal(p:Number):void {
			val = (suffix=="%" ? p/100 : p);
			trace("setVal"+val)
			txt.text = int(suffix=="%" ? (val-myDelta)*100 : val-myDelta).toString()+suffix;
			//txt.text = (val-myDelta).toString()+suffix;			
		}
		public function getVal():Number {
			return val;
		}
		public function resetta():void {
			if (val != myStart) {
				val = myStart;
				txt.text = (suffix=="%" ? (val-myDelta)*100 : val-myDelta)+suffix;
				fnz(val)
			}
		}
	}
}