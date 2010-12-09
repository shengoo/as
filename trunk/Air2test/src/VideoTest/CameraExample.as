package VideoTest
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class CameraExample extends Sprite {
		private var video:Video;
		private var videoURL:String = "D:\\1.flv";
		private var connection:NetConnection;
		private var stream:NetStream;
		
		public function CameraExample() {
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.align = StageAlign.TOP_LEFT;
			
			var camera:Camera = Camera.getCamera("1");trace(camera.name);
			if (camera != null) {
				camera.addEventListener(StatusEvent.STATUS,onStatus);
				camera.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
				video = new Video(480, 360);trace(camera.width);trace(camera.height);
				video.attachCamera(camera);
				addChild(video);
			} else {
				trace("You need a camera.");
			}
//			connection = new NetConnection();
//			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
//			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
//			connection.connect(null);
		}
		
		private function onStatus(e:StatusEvent):void
		{
			
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
		
		private function activityHandler(event:ActivityEvent):void {
			trace("activityHandler: " + event);
		}
	}

}