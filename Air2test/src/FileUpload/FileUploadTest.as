package FileUpload
{
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import spark.components.Button;
	import spark.components.Group;

	public class FileUploadTest
	{
		private	var file:File = new File();
		
		public function FileUploadTest()
		{
			file.addEventListener(Event.SELECT,onSelectFile);
			file.addEventListener(ProgressEvent.PROGRESS,onFileProgress);
			file.addEventListener(Event.COMPLETE,onFileComplete);
			file.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,onResponse);
			file.addEventListener(HTTPStatusEvent.HTTP_STATUS,onResponse);
		}
		
		private function onResponse(e:HTTPStatusEvent):void
		{
			trace(e.status);
		}
		
		public function browseFile():void
		{
			file.browse();
		}
		
		private function onSelectFile(e:Event):void
		{
			trace(file.size);
			var req:URLRequest = new URLRequest("http://localhost/upload.php");
			
			file.upload(req);
		}
		
		private function onFileProgress(e:ProgressEvent):void
		{
			trace(e.bytesLoaded + " of " + e.bytesTotal + " bytes");
		}
		
		private function onFileComplete(e:Event):void
		{
			trace("complete");	
		}
	}
}