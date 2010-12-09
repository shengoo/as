package draws
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;

	public class RemoveIcon extends Sprite
	{
		private var tf:TextField = new TextField();
		
		public function RemoveIcon()
		{
			super();
			var pen:Pen = new Pen(this.graphics);
			
			pen.lineStyle(0,0xffffff);
			pen.beginFill(0x000000);
			pen.drawTriangle(1,8,8,11,-45);
			pen.drawRect(1,9,11,5);
			pen.endFill();
			tf.text = "remove this";
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
			tf.x = mouseX;
			tf.y = mouseY;
			this.addChild(tf);
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.AUTO;
			this.removeChild(tf);
		}
		
	}
}