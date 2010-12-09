package draws
{
	import spark.components.VGroup;
	import spark.components.Label;
	
	public class Texts extends VGroup
	{
		public function Texts()
		{
			super();
			var t1:Label = new Label();
			t1.text = "text1";
			var t2:Label = new Label();
			t2.text = "text2";
			t1.percentWidth = 100;
			t2.percentWidth = 100;
			addElement(t1);
			addElement(t2);
		}
	}
}