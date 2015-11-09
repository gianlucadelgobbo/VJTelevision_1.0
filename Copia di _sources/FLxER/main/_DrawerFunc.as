package FLxER.main{
	import flash.text.TextField.defaultTextFormat 
	import flash.text.TextField;
	import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
	import flash.text.Font;
	
	public class DrawerFunc {
		public static var txt;
		public static var txt2;

		public function DrawerFunc() {
		}
		public static function arrowDrawer(trgt, col) {
			with (trgt) {
				graphics.beginFill(col,1);
				graphics.moveTo(0,0);
				graphics.lineTo(10,0);
				graphics.lineTo(10,2);
				graphics.lineTo(8,2);
				graphics.lineTo(8,4);
				graphics.lineTo(6,4);
				graphics.lineTo(6,6);
				graphics.lineTo(4,6);
				graphics.lineTo(4,4);
				graphics.lineTo(2,4);
				graphics.lineTo(2,2);
				graphics.lineTo(0,2);
				graphics.lineTo(0,0);
			}
		}
		public static function drawer(trgt,xx,yy,w,h,col,o_col,aa) {
			
			if (aa == undefined) {
				aa=100;
			}
			with (trgt) {
				if (o_col != null) {
					graphics.lineStyle(0,o_col,aa);
				}
				if (col != null) {
					graphics.beginFill(col,aa);
				}
				graphics.moveTo(0,0);
				graphics.lineTo(w,0);
				graphics.lineTo(w,h);
				graphics.lineTo(0,h);
				graphics.lineTo(0,0);
				x=xx;
				y=yy;
			}
		}
		public static function tBase(myName,xx,yy,t,tf) {
			trace("myName1 "+myName)
			myName = new TextField();
			trace("myName2 "+myName+" / "+myName.name)
			with (myName) {
				//border = true
				text=t;
				selectable=false;
				embedFonts=true;
				setTextFormat(tf);
				width=textWidth + 9;
				height=textHeight + 4;
				x = xx
				y = yy
			}
			return myName
		}
		public static function td(trgt,myName,xx,yy,t) {
			myName = tBase(myName,xx,yy,t,txt)
			trgt.addChild(myName)
		}
		public static function tds(trgt,myName,xx,yy,t) {
			myName = tBase(myName,xx,yy,t,txt2);
			trgt.addChild(myName)
		}
		public static function tbd(trgt,myName,x,y,w,h,t) {
			myName = tBase(myName,x,y,t,txt);
			with (myName) {
				width=w;
				height=h;
				background=true;
				border=true;
				borderColor=0x999999;
			}
			trgt.addChild(myName)
		}
		function tdw(trgt,myName,x,y,w,h,t) {
			myName = tBase(myName,x,y,t);
			with (myName) {
				width=w;
				height=h;
			}
			trgt.addChild(myName)
		}
		function tbed(trgt,myName,x,y,w,h,t) {
			myName = tBase(myName,x,y,t);
			with (myName) {
				width=w;
				height=h;
				background=true;
				border=true;
				borderColor=0x999999;
				type="input";
				selectable=true;
			}
			trgt.addChild(myName)
		}
	}
}