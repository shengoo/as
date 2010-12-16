package WebService
{
	
	import mx.controls.DataGrid;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.mxml.WebService;
	
	import spark.components.Group;
	
	public class GetData extends Group
	{
		[Bindable] 
		private var employees:ArrayCollection = new ArrayCollection();
		
		public function GetData()
		{
			var dg:DataGrid = new DataGrid();
			dg.dataProvider = employees;
			this.addElement(dg);
			var employeeService:WebService = new WebService("http://www.adobetes.com/f4iaw100/remoteData/EmployeeData.cfc?wsdl");
			employeeService.addEventListener(ResultEvent.RESULT,getResult);
		}
	}
}