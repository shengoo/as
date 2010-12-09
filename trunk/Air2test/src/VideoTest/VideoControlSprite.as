package VideoTest
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	public class VideoControlSprite extends Sprite
	{
		private var tf:TextField = new TextField();
		
		public function VideoControlSprite()
		{
			super();
			graphics.beginFill(0xaa00aa);
			graphics.drawRect(0,15,500,10);
			graphics.endFill();
//			tf.text = "Mouse on";
			addEventListener(MouseEvent.CLICK,onMouseClick);
			addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			
		}
		
		private function onMouseOver(e:MouseEvent):void
		{trace("over\n");
			addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			Mouse.cursor = MouseCursor.BUTTON;
			tf.x = mouseX;
			tf.y = 0;
			tf.text = mouseX.toString();
			this.addChild(tf);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{trace("Move\n");
			tf.x = mouseX;
			tf.text = mouseX.toString();
		}
		
		private function onMouseOut(e:MouseEvent):void
		{trace("Out\n");
			Mouse.cursor = MouseCursor.AUTO;
			this.removeChild(tf);
			removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		
	}
}