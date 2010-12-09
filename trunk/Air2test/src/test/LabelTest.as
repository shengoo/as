package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import mx.controls.Label;
	
	import spark.components.SkinnableContainer;

	public class LabelTest extends SkinnableContainer
	{ 
		private var s:Sprite = new Sprite();
		private var l:Label = new Label();
		private var ll:Label = new Label();
		public function LabelTest()
		{
		
			this.width  = 300;
			this.height = 300;
			
			
//			l.x = 20;
//			l.y = 20;
			l.maxWidth = 100;
			l.text = "1234567890abcdefghijklmnopqrstuvwxyz";
			addElement(l);
			
			ll.maxWidth = 150;
			ll.text = "1234567890abcdefghijklmnopqrstuvwxyz";
//			addElement(ll);
			
			
		}
	}
}