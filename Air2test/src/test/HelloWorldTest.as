package test
{
	import flash.display.Sprite;
	import flash.text.*;
	import mx.controls.Label;
//	[SWF(width="800", height="600", backgroundColor="#00ffff", frameRate="31")]
	public class HelloWorldTest extends Sprite
	{
		
		private var greeting:TextField;
		private var greeting2:TextField;
		
		private var t:TextField = new TextField();
		private var l:Label = new Label();
		
		public function HelloWorldTest()
		{
			greeting = new TextField();
//			greeting.autoSize = "left";
//			greeting.background = true;
//			greeting.border = true;
			greeting.text = "Hello World!";
			greeting.x = 100;
			greeting.y = 100;
			addChild(greeting);
			greeting2 = new TextField();
			greeting2.text = "Hello there.";
			addChild(greeting2);
			t.text = "aaaaaaa";
			t.x= 30;
			t.y = 30;
			addChild(t);
			
			
			l.x = 20;
			l.y = 20;
			l.maxWidth = 100;
			l.text = "1234567890abcdefghijklmnopqrstuvwxyz";
			addChild(l);
		}
	}
}