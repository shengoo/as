package test
{
	import flash.display.*;
	
	public class SimpleButtonDemo extends Sprite
	{
		public function SimpleButtonDemo()
		{
			// 创建三个不同文字不同大小和位置的矩形按钮
			var button1:RectangleButton = new RectangleButton( "Button 1", 60, 100 );
			button1.x = 20;
			button1.y = 20;
			var button2:RectangleButton = new RectangleButton( "Button 2", 80, 30 );
			button2.x = 90;
			button2.y = 20;
			var button3:RectangleButton = new RectangleButton( "Button 3", 100, 40 );
			button3.x = 100;
			button3.y = 60;
			addChild( button1 );
			addChild( button2 );
			addChild( button3 );
		}
	}
}