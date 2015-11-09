package FLxER.main{
	import flash.events.*;
	import flash.net.*;
	import flash.xml.XMLDocument
	public class XmlLoader {
		var trgt
		var fnz
		var myLoader:URLLoader
		public function XmlLoader(myUrl, t, f) {
			trgt = t;
			fnz = f;
			trgt = new XMLDocument();
			trgt.ignoreWhite = true;
			if (myUrl) loadXml(myUrl);
		}
		function loadXml(myUrl) {
			myLoader = new URLLoader(new URLRequest(myUrl));
			myLoader.addEventListener("complete", xmlLoaded);
			myLoader.addEventListener("ioError", xmlNotLoaded);
		}
		function xmlLoaded(event:Event):void {
			trace("Data loaded.");
			trgt.parseXML(myLoader.data);
			fnz(true);
		}
		function xmlNotLoaded(event:Event):void {
			trace("Data not loaded.");
			fnz(false);
		}
	}
}
