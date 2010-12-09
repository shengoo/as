package xmltest
{
	import flash.events.*;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.*;
	import flash.xml.XMLDocument;
	public class ReadFromWeb
	{
		
		private var doc:XML;
		private var ids:Array = new Array();
		private var items:Array = new Array();
		private var mediaItems:Array = new Array();
		
		
		public function ReadFromWeb()
		{
			read("http://www.paragallo.com/apluss/update.xml");
		}
		
		
		public function read(path:String):void
		{
			var loader:URLLoader = new URLLoader( );
			// Define the event handlers to listen for success and failure
			loader.addEventListener( IOErrorEvent.IO_ERROR, handleIOError );
			loader.addEventListener( HTTPStatusEvent.HTTP_STATUS, handleHttpStatus );
			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR,handleSecurityError );
			loader.addEventListener( Event.COMPLETE, handleComplete );
			// Configure the loader to load URL-encoded variables
//			loader.dataFormat = DataFormat
			// Attempt to load some data
			loader.load( new URLRequest(path) );
		}
		
		function handleIOError( event:IOErrorEvent ):void {
			trace( "Load failed: IO error: " + event.text );
		}
		
		function handleHttpStatus( event:HTTPStatusEvent ):void {
			trace( "Load failed: HTTP Status = " + event.status );
		}
		function handleSecurityError( event:SecurityErrorEvent ):void {
			trace( "Load failed: Security Error: " + event.text );
		}
		function handleComplete( event:Event ):void {
			trace( "The data has successfully loaded" );
			var doc:XML = new XML(event.target.data.toString());
			trace(doc.url);
		}
		
	}
}