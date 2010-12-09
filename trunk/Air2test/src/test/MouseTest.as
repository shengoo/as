package test
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class MouseTest extends Sprite
	{
		private var _sprite:Sprite;
		private var bubble:BubbleTest;
		public function MouseTest()
		{
			
			_sprite = new Sprite();
			addChild(_sprite);
			_sprite.graphics.beginFill(0xffffff);
			_sprite.graphics.drawRect(0, 0, 800, 600);
			_sprite.graphics.endFill();
			_sprite.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(event:MouseEvent):void {
			bubble = new BubbleTest(mouseX,mouseY);
			_sprite.addChild(bubble);
		}
		
	}
}