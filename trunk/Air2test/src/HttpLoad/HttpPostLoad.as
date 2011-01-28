package HttpLoad
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.controls.Alert;

	public class HttpPostLoad
	{
		public function HttpPostLoad()
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, responseHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(evt:IOErrorEvent):void
			{
				Alert.show("Io error");
			});
			var request:URLRequest=new URLRequest("http://localhost:29338/");
			var postData:URLVariables=new URLVariables();
			postData.UserName="master";
			postData.Password="master99";
			request.data=postData;
			request.method=URLRequestMethod.POST;
			loader.load(request);
		}
		
		private function loadCompleteHandler(e:Event):void
		{
			
		}
		
		private function httpStatusHandler(e:HTTPStatusEvent):void
		{
			
		}
		
		private function responseHandler(e:HTTPStatusEvent):void
		{
			
		}
	}
}