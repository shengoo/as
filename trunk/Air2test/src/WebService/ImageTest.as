package WebService
{
	import com.adobe.fiber.core.model_internal;
	import com.adobe.fiber.services.wrapper.WebServiceWrapper;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.mxml.WebService;
	import mx.utils.ObjectProxy;
	
	
	public class ImageTest extends WebServiceWrapper
	{
		private var t1:Date;
		private var t2:Date;
		public function ImageTest()
		{
			_serviceControl = new WebService();
			//load wsdl
			t1 = new Date();
			_serviceControl.loadWSDL("http://converterservice.dev1.paragallo.no/EpubService/Service1.svc?wsdl");
			model_internal::initialize();
//			getImage();
			getEpubs();
			InitEpub("cf5d67c7d2c44d04b3e67024a3d438f1");
			GetChapter(300);
		}
		
		public function GetChapter(itemID:int):void
		{
			var operation:AbstractOperation = _serviceControl.getOperation("GetChapter");
			operation.addEventListener(ResultEvent.RESULT,GetChapterResult);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			var GetChapterRequest:Object={ItemId: itemID};
			operation.send(GetChapterRequest);
		}
		
		public function GetChapterResult(e:ResultEvent):void
		{
			Alert.show(" GetChapter Received data");
			var attachments:ArrayCollection = e.result.Attachments;
			var html:Object = e.result.Html;//Content, Id
		}
		
		public function InitEpub(epubID:String):void
		{
			var operation:AbstractOperation = _serviceControl.getOperation("InitEpub");
			operation.addEventListener(ResultEvent.RESULT,InitEpubResult);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			var InitEpubRequest:Object={EpubId: epubID};
			operation.send(InitEpubRequest);
		}
		
		public function InitEpubResult(e:ResultEvent):void
		{
			Alert.show(" InitEpub Received data");
			var font:Object = e.result.Font;//Content, Id,
			var chapters:ArrayCollection = e.result.Index;//chapter[Id, ItemId, Label, SpineOrder]
			var style:Object = e.result.Style;//Content, Id
		}
		
		public function getEpubs():void
		{
			var operation:AbstractOperation = _serviceControl.getOperation("GetEpubs");
			operation.addEventListener(ResultEvent.RESULT,getEpubResult);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			var GetEpubsRequest:Object={batchSize: 2};
			operation.send(GetEpubsRequest);
		}
				
		private function getEpubResult(e:ResultEvent):void
		{
			var results:ArrayCollection = e.result as ArrayCollection;
			trace(results[0].Id);
			Alert.show(" getEpub Received data");
		}
		
		public function getImage():void
		{
			var operation:AbstractOperation = _serviceControl.getOperation("TestImage");
			operation.addEventListener(ResultEvent.RESULT,onresult);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			operation.send();
		}
		
		private function onFault(e:FaultEvent):void
		{
			t2 = new Date();
			trace(t2.time-t1.time);
			Alert.show(e.fault.message);
		}
		
		private function onresult(e:ResultEvent):void
		{
			var imgByte:ByteArray = e.result as ByteArray;
			var f:File = File.documentsDirectory.resolvePath("test.jpg");
			var fs:FileStream = new FileStream();
			try
			{
				 //open file in write mode
				 fs.open(f,FileMode.WRITE);
				 //write bytes from the byte array
				 fs.writeBytes(imgByte);
				trace("create file: "+f.nativePath);
			}
			catch(e:Error)
			{
				trace(e.message);
			}
			finally
			{
				 //close the file
				 fs.close();
			}
		}
	}
}