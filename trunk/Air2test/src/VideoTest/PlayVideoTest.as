package VideoTest
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import spark.components.Group;
	import spark.components.VideoDisplay;
	
	public class PlayVideoTest extends Sprite
	{
		private var videoURL:String = "D:\\1.flv";
		private var connection:NetConnection;
		private var stream:NetStream;

		public function PlayVideoTest()
		{
			super();
			var v:VideoDisplay = new VideoDisplay();
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
			var stream:NetStream = new NetStream(connection);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			var video:Video = new Video(600,448);
			video.attachNetStream(stream);
			stream.play(videoURL);
			addChild(video);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore AsyncErrorEvent events.
		}

		
		
	}
}