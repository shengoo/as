package draws
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.Button;
	import mx.controls.ProgressBar;
	import mx.controls.ProgressBarDirection;
	import mx.controls.ProgressBarLabelPlacement;
	import mx.controls.ProgressBarMode;
	
	public class ProgressBarExample extends Sprite
	{
		private var j:uint;
		private var pb:ProgressBar;
		private var fakeProgressCount:uint;
		
		public function ProgressBarExample() {
			setupProgressBar();    
			setupButton();
		}
		
		private function advancePreloader(e:MouseEvent):void {
			fakeProgressCount = (fakeProgressCount == 100) ? 0 : fakeProgressCount + 10;
			pb.setProgress(fakeProgressCount, 100);
		}
		
		private function setupButton():void {
			var b:Button = new Button();
			b.move(10, 30);
			b.width = 120;
			b.height = 30;
			b.label = "Increment Progress";
			b.addEventListener(MouseEvent.CLICK, advancePreloader);
			addChild(b);
		}
		
		private function setupProgressBar():void {
			fakeProgressCount = 0;
			pb = new ProgressBar();
			pb.direction = ProgressBarDirection.RIGHT;
			pb.label = "bar";
			pb.labelPlacement = ProgressBarLabelPlacement.BOTTOM; 
			pb.setStyle("themeColor","#F20D7A");
			pb.minimum = 0;
			pb.visible = true;
			pb.maximum = 100;
			
			pb.width = 100;
			pb.height = 20;
			pb.x = 10;
			pb.y = 10;
//			pb.move(10, 10);
			pb.mode = ProgressBarMode.MANUAL;
			var tf:TextField = new TextField();
			tf.text = "aaa";
			addChild(tf);
			addChild(pb);
		}
	}

}