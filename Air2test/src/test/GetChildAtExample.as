package test
{
	import flash.display.*;
	import flash.events.*;
	
	public class GetChildAtExample extends Sprite
	{
		public function GetChildAtExample()
		{
			var color:Array = [ 0xFF0000, 0x990000, 0x660000, 0x00FF00,
				0x009900, 0x006600, 0x0000FF, 0x000099,
				0x000066, 0xCCCCCC ];
			for ( var i:int = 0; i < 10; i++ ) {
				var circle:Shape = createCircle( color[i], 100 );
				circle.x = i*80+80;
				circle.y = i*50 + 50; // the + 10 adds padding from the top
				addChild( circle );
			}
			addEventListener( MouseEvent.CLICK, updateDisplay );
		}
		public function updateDisplay( event:MouseEvent ):void {
			setChildIndex( getChildAt(0), numChildren - 1 );
		}
		public function createCircle( color:uint, radius:Number ):Shape {
			var shape:Shape = new Shape( );
			shape.graphics.beginFill( color );
			shape.graphics.drawCircle( 0, 0, radius );
			shape.graphics.endFill( );
			return shape;
		}
	}
}