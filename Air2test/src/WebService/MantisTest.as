package WebService
{
	import com.adobe.fiber.core.model_internal;
	import com.adobe.fiber.services.wrapper.WebServiceWrapper;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.mxml.WebService;
	
	public class MantisTest extends WebServiceWrapper
	{
		private var data:Object = new Object();
		private var username:String = 'apluss-betatester'
		private var password:String = 'betatester';
		private var operation:AbstractOperation;
		
		
		public function MantisTest(target:IEventDispatcher=null)
		{
			super(target);
			_serviceControl = new WebService();
			//load wsdl
			_serviceControl.loadWSDL("http://mantis.paragallo.no/mantis/api/soap/mantisconnect1?wsdl");
			model_internal::initialize();
			initData();
		}
		
		private function initData():void
		{
			data.project = new Object();
			data.project.id = 22;
			data.project.name = 'a"pluss';
			data.category = 'General';
			data.summary = "test summary";
			data.version = 'Version 1.0';
			data.description = "test description";
		}
		
		public function testReportAsync():void
		{
			operation = _serviceControl.getOperation("mc_issue_add");
			operation.addEventListener(ResultEvent.RESULT,testResult);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			operation.send(username,password,data);
		}
		
		private function testResult(e:ResultEvent):void
		{
			
		}
		
		public function testReport():AsyncToken
		{
			operation = _serviceControl.getOperation("mc_issue_add");
			operation.addEventListener(ResultEvent.RESULT,testResult);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			return operation.send(username,password,data);
		}
		
		
		
		private function onFault(e:FaultEvent):void
		{
			//remove handlers after event dispatched.
			operation.removeEventListener(FaultEvent.FAULT,onFault);
			Alert.show("Cannot connect to server");
		}
		
		
	}
}