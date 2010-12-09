package VideoTest
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.filesystem.File;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import mx.core.UIComponent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.HGroup;
	
	public class LoadVideoTest extends Group
	{
		private var videoURL:String = "D:\\mp3.swf";
		private var connection:NetConnection;
		private var stream:NetStream;
		private var videoContainer:Sprite = new Sprite();
		private var btn:Button = new Button();
		private var file:File;
		
		public function LoadVideoTest()
		{
			var h1:HGroup = new HGroup();
			btn.label = "browse file";
			btn.addEventListener(MouseEvent.CLICK,clickBtnHandler);
			h1.addElement(btn);
			addElement(h1);
			var uic:UIComponent = new UIComponent();
			uic.addChild(videoContainer);
			uic.top = btn.height;
			var h2:HGroup = new HGroup();
			h2.addElement(uic);
			h2.setStyle("color",0x333333);
			h2.width = 800;
			h2.height = 600;
//			h2.percentHeight = 100;
//			h2.percentWidth = 100;
			h2.horizontalCenter = 0;
			h2.verticalCenter = 0;
			addElement(h2);
		}
		
		private function clickBtnHandler(e:MouseEvent):void
		{
			file = new File();
			file.addEventListener(Event.SELECT,selectFile);
			file.browse();
		}
		
		private function selectFile(e:Event):void
		{
			if(file)
			{
				file.removeEventListener(Event.SELECT,selectFile);
				videoURL = file.nativePath;
			}
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connection.connect(null);
		}
		
		
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					trace("Unable to locate video: " + videoURL);
					break;
			}
		}
		
		private function connectStream():void {
			stream = new NetStream(connection);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			var client:Object = new Object( );
			client.onMetaData = function(metadata:Object):void {
				trace(metadata.duration);
			};
			stream.client = client;
			var video:Video = new Video(600,448);
			video.attachNetStream(stream);
			stream.play(videoURL);
			videoContainer.addChild(video);stream.seek(50);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore AsyncErrorEvent events.
		}

		
		
	}
}