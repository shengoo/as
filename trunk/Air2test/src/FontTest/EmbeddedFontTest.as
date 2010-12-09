package FontTest
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class EmbeddedFontTest extends Sprite
	{
		[Embed(source="MyriadPro-Bold.otf", fontName="MyriadPro", mimeType="application/x-font")]
		public static var MyriadPro:Class;
		
		private var tf:TextField = new TextField();
		private var format:TextFormat = new TextFormat();
		
		public function EmbeddedFontTest()
		{
			tf=new TextField();
			tf.selectable=false;
			tf.mouseEnabled=false;
			format.font = "MyriadPro";
			format.size = 24;
			tf.defaultTextFormat=format;
			tf.embedFonts = true;
			
			tf.width=200;
			tf.height=30;
			tf.x=35;
			tf.y=4;
			tf.text = "tessssssssssst";
			tf.textColor=0x575757;
			this.addChild(tf);
		}
	}
}