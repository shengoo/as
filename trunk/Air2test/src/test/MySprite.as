package test
{
	import flash.display.Sprite;
	
	public class MySprite extends Sprite
	{
	 	public var dataObj:Object;
		public function MySprite(data:Object)
		{
			dataObj = data;
			super();
		}
	}
}