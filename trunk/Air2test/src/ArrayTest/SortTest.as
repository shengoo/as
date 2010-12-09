package ArrayTest
{
	import Entities.QQ;

	public class SortTest
	{
		private var arr:Array = new Array();
		
		public function SortTest()
		{
			for(var i:int = 0;i<20;i++)
			{
				arr.push(new QQ(i,i.toString()));
			}
			
			arr = arr.sortOn("name");
			trace('sortOn("name");(String)');
			for(var i:int = 0;i<arr.length;i++)
			{
				trace("QQ.id=" + arr[i].id + "......QQ.name=" + arr[i].name);
			}
			
			arr = arr.sortOn("id",Array.NUMERIC);
			trace('sortOn("id",Array.NUMERIC);');
			for(var i:int = 0;i<arr.length;i++)
			{
				trace("QQ.id=" + arr[i].id + "......QQ.name=" + arr[i].name);
			}
		}
		
		
		
	}
	
	
}