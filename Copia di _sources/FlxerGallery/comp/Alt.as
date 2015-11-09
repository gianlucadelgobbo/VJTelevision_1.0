package FlxerGallery.comp {
	import flash.display.Sprite;
	import flash.events.*;

	import FlxerGallery.main.DrawerFunc;
	import FlxerGallery.main.Txt;
	
	public class Alt extends Sprite {
		///////
		var freccetta:Sprite;
		var lab_i;
		//
		public function Alt() {
			this.x = -500;
			//this.alpha = .6;
			this.freccetta = new Sprite();
			DrawerFunc.drawer(freccetta, -5, -5, 10, 10, Preferences.pref.altBkg, Preferences.pref.altBorder, 1);
			freccetta.rotation = 45;
			this.addChild(freccetta);
			this.lab_i = new Txt(3,0,100,15,"bella","puls");
			this.addChild(lab_i)
			this.mouseChildren = false;
		}
		public function avvia(myXml) {
			//trace(myXml)
			stoppa()
			this.visible = true;
			lab_i.htmlText = "<p>"+myXml+"</p>";
			lab_i.width = 200;
			lab_i.height = 200;
			w = lab_i.textWidth+11;
			if (w>200) {
				w = 200;
			}
			lab_i.width = w;
			h = lab_i.textHeight;
			lab_i.height = h+5;
			//posiziona("bella")
			this.addEventListener(Event.ENTER_FRAME,posiziona);
		}
		public function posiziona(e) {
			this.x = parent.mouseX;
			this.y = parent.mouseY;
			if (x>stage.stageWidth-lab_i.width) {
				lab_i.x = -(lab_i.width);
				freccetta.x = -8;
			} else {
				lab_i.x = 0;
				freccetta.x = 8;
			}
			if (y<lab_i.height+11) {
				freccetta.y = 15;
				lab_i.y = 10;
			} else {
				freccetta.y = -10;
				lab_i.y = -lab_i.height-10;
			}
		}
		public function stoppa() {
			this.removeEventListener(Event.ENTER_FRAME,posiziona);
			this.x = -500;
		}
	}
}
