package Views.Bubbles
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	
	public class BubbleContainer extends UIComponent
	{
		private var _sprite:Sprite;
		private var bubble:Bubble;
		public function BubbleContainer()
		{
			_sprite = new Sprite();
			addChild(_sprite);
			_sprite.graphics.beginFill(0xffffff);
			_sprite.graphics.drawRect(0, 0, stage.width, stage.height);
			_sprite.graphics.endFill();
			_sprite.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(event:MouseEvent):void {
			bubble = new Bubble(mouseX,mouseY);
			_sprite.addChild(bubble);
		}
		
		
	}
}