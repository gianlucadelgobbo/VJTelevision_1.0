﻿package {	import flash.text.TextFormat;	import flash.text.Font;	import flash.xml.XMLDocument;	import flash.xml.XMLNode;	import flash.text.StyleSheet;	import VJTV.VJTVStarter;	public class Preferences {		public static var pref:Object;		public function Preferences():void {		}		public static function customizePref(p:Object):void {			pref = p			trace("customizePref")		}		public static function createPref(ww:uint,hh:uint):void {			trace("createPref")			pref = new Object();			pref.msVal = new Object();			pref.pos = new Object();			pref.w = ww;			pref.h = hh;			pref.colWhite = new Object();			pref.colWhite.col = "0x000000";			pref.colWhite.bkgCol = "0xFFFFFF";			pref.colWhite.bkgColOver = "0xFF0000";			pref.colWhite.brdCol = "0x999999";			pref.colWhite.pltCol = "0x909090";			pref.colWhite.monCol = "0xFFFFFF";			//			pref.colBlack = new Object();			pref.colBlack.col = "0x999999";			pref.colBlack.bkgCol = "0x000000";			pref.colBlack.bkgColOver = "0x990000";			pref.colBlack.brdCol = "0x333333";			pref.colBlack.pltCol = "0x909090";			pref.colBlack.monCol = "0x000000";			//			pref.myCol = new Object();			pref.myCol.altCol 		= "0x000000";			pref.myCol.altBkg 		= "0xFFFF00";			pref.myCol.altBrd 		= "0x000000";			pref.myCol.col			= "0x999999";			pref.myCol.bkgCol		= "0x000000";			pref.myCol.bkgColOver	= "0x990000";			pref.myCol.brdCol		= "0x333333";			pref.myCol.pltCol		= "0x909090";			pref.myCol.monCol		= "0x000000";						pref.centra_onoff = true;			pref.resizza_onoff = true;			pref.myLoop = true;			var embeddedFontsArray:Array = Font.enumerateFonts(false);			embeddedFontsArray.sortOn("fontName");			/*			for (var a in embeddedFontsArray) {				trace(a + " " + embeddedFontsArray[a].fontName);			}			*/			pref.ts = new TextFormat();			with (pref.ts) {				font = embeddedFontsArray[1].fontName;				size = 8;				color = 0x999999;				leading = -2;				leftMargin = 1;				rightMargin = 0;			}			pref.th = new TextFormat();			with (pref.th) {				font = embeddedFontsArray[0].fontName;				size = 8;				color = 0x999999;				leading = -2;				leftMargin = 1;				rightMargin = 0;			}			pref.tsHtml = new StyleSheet();			//pref.tsHtml.setStyle("p",{fontFamily:pref.myFont, fontSize:'8px', color:VJTV.VJTVStarter.myReplace(pref.myCol.bkgCol, "0x", "#"), marginLeft:'3px'});			pref.tsHtml.setStyle("p",{fontFamily:pref.myFont, fontSize:'8px', color:"#666666"});			pref.tsHtml.setStyle("a:link",{color:VJTV.VJTVStarter.myReplace(pref.myCol.bkgColOver, "0x", "#")});			pref.tsHtml.setStyle("a:visited",{color:VJTV.VJTVStarter.myReplace(pref.myCol.bkgColOver, "0x", "#")});			pref.tsHtml.setStyle("a:active",{color:VJTV.VJTVStarter.myReplace(pref.myCol.bkgColOver, "0x", "#")});			pref.tsHtml.setStyle("a:hover",{color:VJTV.VJTVStarter.myReplace(pref.myCol.bkgCol, "0x", "#")});			pref.tsHtml.setStyle("div",{display:"block",color:"#666666"});		}		public static function updateColObj(obj:Object):void {			pref.myCol.col 			= pref.flxerPref.childNodes[0].attributes.col 			= obj.col;			pref.ts.color 			= obj.col;			pref.th.color 			= obj.col;			pref.myCol.bkgCol 		= pref.flxerPref.childNodes[0].attributes.bkgCol 		= obj.bkgCol;			pref.myCol.bkgColOver 	= pref.flxerPref.childNodes[0].attributes.bkgColOver 	= obj.bkgColOver;			pref.myCol.brdCol 		= pref.flxerPref.childNodes[0].attributes.brdCol 		= obj.brdCol;			pref.myCol.pltCol 		= pref.flxerPref.childNodes[0].attributes.pltCol 		= obj.pltCol;			pref.myCol.monCol 		= pref.flxerPref.childNodes[0].attributes.monCol 		= obj.monCol;		}		public static function updateCol():void {			trace(pref.flxerPref)			pref.myCol.col 			= pref.flxerPref.childNodes[0].attributes.col;			pref.ts.color 			= pref.myCol.col;			pref.th.color 			= pref.myCol.col;			pref.myCol.bkgCol 		= pref.flxerPref.childNodes[0].attributes.bkgCol;			pref.myCol.bkgColOver 	= pref.flxerPref.childNodes[0].attributes.bkgColOver;			pref.myCol.brdCol 		= pref.flxerPref.childNodes[0].attributes.brdCol;			pref.myCol.pltCol 		= pref.flxerPref.childNodes[0].attributes.pltCol;			pref.myCol.monCol 		= pref.flxerPref.childNodes[0].attributes.monCol;		}		public static function myReplace(str:String, search:String, replace:String):String {			var temparray:Array = str.split(search);			str = temparray.join(replace);			return str;		}	}}