package FLxER.core {
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.Keyboard;  
	public class TreDengine {
		var stiffK:Number;
		var dampK:Number;
		var referenceXoffset:Number;
		var referenceYoffset:Number;
		var focalLength:Number;
		var cameraView:Object;
		var myOnEnterFrame:Boolean;
		public var active:Boolean;
		var dZ:Number;
		var objectsInScene:Array;
		var oldcameraViewX:Number;
		var oldcameraViewY:Number;
		var oldcameraViewZ:Number;
		var cameraViewX:Number;
		var cameraViewY:Number;
		var cameraViewZ:Number;
		/////////
		public function TreDengine():void {
			stiffK = .9;
			dampK = .3;
			referenceXoffset = 200;
			referenceYoffset = 150;
			focalLength = Preferences.pref.monitorTrgt.h;
			cameraView = {xx:(Preferences.pref.monitorTrgt.w/2), yy:(Preferences.pref.monitorTrgt.h/2), zz:0, Zvelocity:0, Xvelocity:0, attrito:.90, maxVelocity:100};
			myOnEnterFrame = true;
			active = false;
			dZ = parseInt(Preferences.pref.flxerPref.childNodes[0].childNodes[4].attributes.zvalue);
		}
		public function avvia():void {
			Preferences.pref.monitorTrgt.addEventListener(Event.ENTER_FRAME, moveInScene);
		}
		public function stoppa():void {
			Preferences.pref.monitorTrgt.removeEventListener(Event.ENTER_FRAME, moveInScene);
		}
		public function treDengineONOFF(c:Boolean,ch:uint):void {
			objectsInScene = [];
			for (var i:uint = 0; i<Preferences.pref.nCh; i++) {
				if (Preferences.pref.interfaceTrgt.chCnt["ch_"+i].treD.myStatus) {
					var trgt:Player = Preferences.pref.monitorTrgt.levels["ch_"+i];
					trgt.xx = (Preferences.pref.monitorTrgt.w/2);
					trgt.yy = (Preferences.pref.monitorTrgt.h/2);
					trace("ch_"+i+" "+Preferences.pref.interfaceTrgt.chCnt["ch_"+i].myDepth+" "+Preferences.pref.monitorTrgt.mon.getChildIndex(Preferences.pref.monitorTrgt.levels["ch_"+i]));
					trgt.zz = ((Preferences.pref.nCh-1)*dZ)-((Preferences.pref.interfaceTrgt.chCnt["ch_"+i].myDepth)*dZ);
					placeObjectIn3D(trgt, trgt.xx-cameraView.xx, trgt.yy-cameraView.yy, trgt.zz-cameraView.zz, 4);
					objectsInScene.push(trgt);
				}
			}
			if (objectsInScene.length>0) {
				active = true;
			} else {
				active = false;
				cameraView = {xx:(Preferences.pref.monitorTrgt.w/2), yy:(Preferences.pref.monitorTrgt.h/2), zz:0, Zvelocity:0, Xvelocity:0, attrito:.90, maxVelocity:100};
				//focalLength = Preferences.pref.monitorTrgt.h;
				Preferences.pref.monitorTrgt.removeEventListener(Event.ENTER_FRAME, moveInScene);
				//delete onEnterFrame;
			}
			if (!c) {
				placeObjectIn3D(Preferences.pref.monitorTrgt.levels["ch_"+ch], 0, 0, 0, 1);
			}
		}
		function placeObjectIn3D(obj:Object, x:Number, y:Number, z:Number, scala:Number):void {
			var obj2:Object = {};
			if (z>-focalLength) {
				var scaleRatio:Number = focalLength/(focalLength+z);
				obj2.xx = (Preferences.pref.monitorTrgt.w/2)+(x*scaleRatio);
				obj2.yy = (Preferences.pref.monitorTrgt.h/2)+(y*scaleRatio);
				obj2.xscale = obj2.yscale=scaleRatio;
				//obj2.maskxscale = obj2.maskyscale=100*(1/scaleRatio);
				//obj2.maskx = obj2.maskyscale=100*(1/scaleRatio);
				if (Preferences.pref.flxerPref.childNodes[0].childNodes[4].attributes.zalpha == "true") {
					obj2.alpha = obj2.yscale;
				} else {
					obj2.alpha = 1;
				}
			} else {
				obj2.alpha = 0;
			}
			Preferences.pref.monitorTrgt.mbuto((getTimer()-Preferences.pref.lastTime)+",placeObjectIn3D,"+obj.ch+","+obj2.alpha+","+obj2.xx+","+obj2.yy+","+obj2.xscale+","+scala);
		}
		function moveInScene(event:Event):void {
			if (int(cameraView.xx*1) == int(oldcameraViewX*1) && int(cameraView.zz*1) == int(oldcameraViewZ*1)) {
				Preferences.pref.monitorTrgt.removeEventListener(Event.ENTER_FRAME, moveInScene);
				myOnEnterFrame = true;
			}
			oldcameraViewZ = cameraView.zz;
			oldcameraViewX = cameraView.xx;
			// tengo conto della posizione del mouse per muovere la camera   
			//cameraView.yy = _ymouse-theScene.yy;
			//cameraView.xx = _xmouse-theScene.xx;
			if (Preferences.pref.monitorTrgt.parent.myKeyboard.pressedA["key"+Keyboard.UP]) {
				cameraView.Zvelocity += 2;
			} else {
				cameraView.Zvelocity *= cameraView.attrito;
			}
			if (Preferences.pref.monitorTrgt.parent.myKeyboard.pressedA["key"+Keyboard.DOWN]) {
				cameraView.Zvelocity -= 2;
			}
			if (cameraView.Zvelocity>cameraView.maxZvelocity) {
				cameraView.Zvelocity = cameraView.maxVelocity;
			}
			cameraView.zz += cameraView.Zvelocity;
			if (cameraView.zz>Preferences.pref.nCh*dZ) {
				cameraView.zz = Preferences.pref.nCh*dZ;
			}
			trace((Preferences.pref.nCh*dZ)+" BBB "+cameraView.zz);
			// posso usare i tasti DX SX per orientare la cam, invece del mouse (disattivato qui) 
			if (Preferences.pref.monitorTrgt.parent.myKeyboard.pressedA["key"+Keyboard.LEFT]) {
				cameraView.Xvelocity += 2;
			} else {
				cameraView.Xvelocity *= cameraView.attrito;
			}
			if (Preferences.pref.monitorTrgt.parent.myKeyboard.pressedA["key"+Keyboard.RIGHT]) {
				//cameraView.xx += cameraView.Xvelocity/5;
				cameraView.Xvelocity -= 2;
			}
			if (cameraView.Xvelocity>cameraView.maxXvelocity) {
				cameraView.Xvelocity = cameraView.maxVelocity;
			}
			cameraView.xx += cameraView.Xvelocity;
			if (cameraView.xx<-(referenceXoffset*2)) {
				cameraView.xx = -(referenceXoffset*2);
			} else if (cameraView.xx>(referenceXoffset*2)+Preferences.pref.monitorTrgt.w) {
				cameraView.xx = (referenceXoffset*2)+Preferences.pref.monitorTrgt.w;
			}
			// Render degli oggetti                     
			for (var i:uint = 0; i<Preferences.pref.nCh; i++) {
				if (Preferences.pref.interfaceTrgt.chCnt["ch_"+i].treD.myStatus) {
					placeObjectIn3D(objectsInScene[i], objectsInScene[i].xx-cameraView.xx, objectsInScene[i].yy-cameraView.yy, objectsInScene[i].zz-cameraView.zz,4);
				}
			}
		}
	}
}