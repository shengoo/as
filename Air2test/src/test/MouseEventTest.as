package test
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class MouseEventTest extends Sprite
	{
		private var _sprite:Sprite;
		public function MouseEventTest()
		{
			
			_sprite = new Sprite();
			addChild(_sprite);
			_sprite.graphics.beginFill(0xffffff);
			_sprite.graphics.drawRect(0, 0, 400, 400);
			_sprite.graphics.endFill();
			_sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_sprite.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseDown(event:MouseEvent):void {
			_sprite.graphics.lineStyle(1, 0, 1);
			_sprite.graphics.moveTo(mouseX, mouseY);
			_sprite.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseUp(event:MouseEvent):void {
			_sprite.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseMove(event:MouseEvent):void {
			_sprite.graphics.lineStyle(1, Math.random( ) * 0xffffff, 1);
			_sprite.graphics.lineTo(mouseX, mouseY);
		}
	}
}