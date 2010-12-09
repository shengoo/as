package test
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	
	public class KeyDownTest extends Sprite
	{
		public function KeyDownTest()
		{
			stage.focus = this;
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		private function onKeyDown(event:KeyboardEvent):void {
			trace("key down: " + event.charCode);
		}
	}
}