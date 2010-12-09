package test
{
	import flash.display.*;
	public class AddAt extends Sprite
	{
		public function AddAt()
		{
			var red:Shape = createCircle( 0xFF0000, 100 );
			red.x = 100;
			red.y = 200;
			var green:Shape = createCircle( 0x00FF00, 100 );
			green.x = 150;
			green.y = 250;
			var blue:Shape = createCircle( 0x0000FF, 100 );
			blue.x = 200;
			blue.y = 200;
			addChild( red );
			addChild( blue );
			addChildAt( green, 1 );
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