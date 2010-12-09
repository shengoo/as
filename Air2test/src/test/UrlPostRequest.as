package test
{
	import flash.net.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class UrlPostRequest
	{
		public function UrlPostRequest()
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("http://www.akademika.no/desktop/logon");
			var postData:URLVariables = new URLVariables();
			postData.USERNAME = escape( "admin@paragallo.com");
			postData.PASSWORD = "parBT2010";
			request.data = postData;
			request.method = URLRequestMethod.POST;
			navigateToURL(request);

//			sendToURL(request);
//			trace(loader.load(request));
		}
	}
}