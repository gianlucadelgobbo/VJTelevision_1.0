﻿package {	import FLxER.core.Monitor;	import FLxER.core.Player;	import flash.display.Sprite;	public class Plugin {		public function Plugin():void {		}		public static function getChannelsNum():uint {			return Preferences.pref.nCh;		}		public static function getMonWidth():uint {			return Preferences.pref.w;		}		public static function getMonHeight():uint {			return Preferences.pref.h;		}		public static function getChannel(ch):Player {			return Preferences.pref.monitorTrgt.levels["ch_"+ch];		}		public static function getMonitor():Monitor {			return Preferences.pref.monitorTrgt;		}		public static function getMovie(ch):Sprite {			return Preferences.pref.monitorTrgt.levels["ch_"+ch].vid;		}		public static function getMovieCnt(ch):Sprite {			return Preferences.pref.monitorTrgt.levels["ch_"+ch].cnt;		}		public static function getMask(ch):Sprite {			return Preferences.pref.monitorTrgt.levels["ch_"+ch].cntMask;		}		public static function clearMask(ch):void {			trace("clearMaskclearMask"+ch)			Preferences.pref.monitorTrgt.levels["ch_"+ch].clearMask()		}		public static function restoreMask(ch):void {			Preferences.pref.monitorTrgt.levels["ch_"+ch].restoreMask()		}	}}