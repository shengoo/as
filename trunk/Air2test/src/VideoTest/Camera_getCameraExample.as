package VideoTest
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;

	
	public class Camera_getCameraExample extends Sprite
	{
		private var myTextField:TextField;
		private var cam:Camera;
		private var t:Timer = new Timer(1000);
		
		public function Camera_getCameraExample() {trace(Camera.names);
			myTextField = new TextField();
			myTextField.x = 10;
			myTextField.y = 10;
			myTextField.background = true;
			myTextField.selectable = false;
			myTextField.autoSize = TextFieldAutoSize.LEFT;    
			
			cam = Camera.getCamera("1");
			
			if (!cam) {
				myTextField.text = "No camera is installed.";
				
			} else if (cam.muted) {
				myTextField.text = "To enable the use of the camera,\n"
					+ "please click on this text field.\n" 
					+ "When the Flash Player Settings dialog appears,\n"
					+ "make sure to select the Allow radio button\n" 
					+ "to grant access to your camera.";
				
				myTextField.addEventListener(MouseEvent.CLICK, clickHandler);
				
			}else {
				myTextField.text = "Connecting";
				connectCamera(); 
			}
			
			addChild(myTextField);
			
			t.addEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		private function clickHandler(e:MouseEvent):void {
			Security.showSettings(SecurityPanel.PRIVACY);
			
			cam.addEventListener(StatusEvent.STATUS, statusHandler);
			
			myTextField.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function statusHandler(event:StatusEvent):void {
			
			if (event.code == "Camera.Unmuted") {
				connectCamera(); 
				cam.removeEventListener(StatusEvent.STATUS, statusHandler);
			}
		}
		
		private function connectCamera():void {
			var vid:Video = new Video(800, 600);trace(cam.width + "X" + cam.height);
			vid.x = 10;
			vid.y = 10;
			vid.attachCamera(cam);
			addChild(vid);    
			
			t.start();
		}
		
		private function timerHandler(event:TimerEvent):void {
			myTextField.y = cam.height + 20;
			myTextField.text = "";
			myTextField.appendText("bandwidth: " + cam.bandwidth + "\n");
			myTextField.appendText("currentFPS: " + Math.round(cam.currentFPS) + "\n");
			myTextField.appendText("fps: " + cam.fps + "\n");
			myTextField.appendText("keyFrameInterval: " + cam.keyFrameInterval + "\n");
			myTextField.appendText("times: " + t.currentCount.toString() + "\n");
		}

	}
}