package VideoTest
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import mx.core.UIComponent;
	
	import spark.components.Button;
	import spark.components.Group;

	public class VideoControl extends Group
	{
		private var progress:Sprite = new Sprite();
		private var tf:TextField = new TextField();
		
		public function VideoControl()
		{
			drawProgress();
			progress.width = 600;
			progress.height = 20;
			progress.graphics.beginFill(0x0000ff);
			progress.graphics.drawRect(0,0,100,100);
			progress.graphics.endFill();
			tf.text = "aaaaaaaaa";
			progress.addChild(tf);
			var uic:UIComponent = new UIComponent();
			uic.width = 600;
			uic.height = 20;
			uic.percentHeight = 100;
			uic.percentWidth = 100;
			uic.addChild(progress);
			addElement(uic);
			var b:Button = new Button();
			b.label = "dddddddddddddd";
			addElement(b);
		}
		
		private function drawProgress():void
		{
		}
		
	}
}