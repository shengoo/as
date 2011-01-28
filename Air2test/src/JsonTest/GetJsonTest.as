package JsonTest
{
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.*;
	import flash.utils.ByteArray;
	
	import json.JSON;
	
	import mx.utils.ArrayUtil;

	public class GetJsonTest
	{
		private var req:URLRequest;
		private var loader:URLLoader
		public function GetJsonTest()
		{
			req = new URLRequest("http://localhost:51029/");
			req.method = URLRequestMethod.POST;
			loader = new URLLoader(req);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);

		}
		
		private function loaderCompleteHandler(event:Event):void {
			trace(event.target.data);
//			var val:Object = event.target.data;
			var jsonObj:Object = JSON.decode(loader.data);
			var bytes:ByteArray = new ByteArray();
			var arr:Array = new Array();
			arr = jsonObj.Data;
			for(var i:int = 0;i<arr.length;i++)
				bytes.writeByte(arr[i]);
			
//			trace(s.name)
			
			var f:File = File.documentsDirectory.resolvePath("test.jpg");
			var fs:FileStream = new FileStream();
			try
			{
				 //open file in write mode
				 fs.open(f,FileMode.WRITE);
				 //write bytes from the byte array
				 fs.writeBytes(bytes);
				trace("create file: "+f.nativePath);
			}
			catch(e:Error)
			{
				trace(e.message);
			}
			finally
			{
				 //close the file
				 fs.close();
			}
		}

		private function errorHandler(e:IOErrorEvent):void {
			trace("io error");
		}

		
	}
}