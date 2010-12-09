package test
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.*;
	
	import mx.managers.*;
	
	public class MyCircleButton extends Sprite
	{
		public function MyCircleButton()
		{
			super();
			graphics.beginFill(0x888888);
			graphics.drawCircle(5,5,5);
			graphics.beginFill(0xffffff);
			graphics.drawCircle(5,5,3);
			graphics.endFill( );
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
		}
		
		/**
		 * Make the circle look like selected
		 */
		public function setFocus():void
		{
			graphics.beginFill(0x888888);
			graphics.drawCircle(5,5,5);
		}
		
		
		/**
		 * Make the circle look like not selected
		 */
		public function loseFocus():void
		{
			graphics.beginFill(0xffffff);
			graphics.drawCircle(5,5,3);
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			this.removeEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.AUTO;
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
		}
	}
}