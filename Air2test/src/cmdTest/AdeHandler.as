package cmdTest
{
	
	import flash.desktop.*;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.net.*;
	
	import mx.controls.*;
	import mx.events.CloseEvent;
	
	
	public class AdeHandler
	{
		public var adeInstalled:Boolean=false;
		public var pdfPath:String;
		public var adePath:String;
		public function AdeHandler()
		{
				try
				{
					adePath=NativeApplication.nativeApplication.getDefaultApplication("acsm");
					pdfPath = NativeApplication.nativeApplication.getDefaultApplication("pdf");
					if(adePath == null)
						adeInstalled = false;
					else if(adePath.search("digitaleditions") > -1)
						adeInstalled = true;
				}
				catch (e:Error)
				{
					Alert.show(e.message, "Error", Alert.OK);
				}
		}
	}
}