package FileUpload
{
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;

	public class FileUploadTest2
	{
		private	var file:File = new File("C:\\1.html");
		public function FileUploadTest2()
		{
			file.addEventListener(ProgressEvent.PROGRESS,onFileProgress);
			file.addEventListener(Event.COMPLETE,onFileComplete);
			file.upload(new URLRequest("http://localhost/upload.php"));
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