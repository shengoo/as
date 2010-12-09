package test
{
	import flash.desktop.*;
	import flash.display.Sprite;
	import flash.filesystem.*;
	import flash.system.*;
	
	import mx.messaging.channels.StreamingAMFChannel;
	
	public class DRMDownloader extends Sprite
	{
		private var acsmDefAppPath:String = new String();
		private var osType:String = new String();
		private var identifier:String = new String();
		private var filePath:String = new String();
		private var acsmFile:File;
		public var adeInstalled:Boolean = false;
		private var mediaNode:XML;
		private var adeRoot:File;
		
	  	private	var dc:Namespace = new Namespace ("http://purl.org/dc/elements/1.1/");
		private	var de:Namespace = new Namespace ("http://ns.adobe.com/digitaleditions");
		/**
		 *  Get the file path by passing a acsm file
		 */
		public function DRMDownloader(acsmSourceFile:File)
		{
			acsmFile = acsmSourceFile;
			adeInstalled = CheckAcsm();
		}
		
		/**
		 *  Check if the acsm is default opened by Adobe Digital Editions 
		 * If not ,the user should be reminded to install a Adobe Digital Editions
		 */
		private function CheckAcsm():Boolean
		{
			try
			{
				acsmDefAppPath = NativeApplication.nativeApplication.getDefaultApplication("acsm");
				if(acsmDefAppPath.search("digitaleditions")>-1)
					return true;
				else 
					return false;
			}
			catch(e:Error)
			{
				trace(e.message);;
			}
			return false
		}
		
		/**
		 *  Check type of the os
		 */
		private function CheckOSType():void
		{
			osType = flash.system.Capabilities.os;
			if(osType.search("Win")>-1)
				adeRoot = File.documentsDirectory.resolvePath("My Digital Editions");
			else
				adeRoot = File.documentsDirectory.resolvePath("Digital Editions");
		}
		
		
		
		
		/**
		 *  Get the uuid of the content in acsm
		 */
		private function GetIdentifier():void
		{
			var fileStream:FileStream = new FileStream();
			fileStream.open(acsmFile, FileMode.READ);
			var acsmXml:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			
			fileStream.close();
			var meta:XMLList = acsmXml.resourceItemInfo.metadata;
			var dc:Namespace = new Namespace ("http://purl.org/dc/elements/1.1/");
			
			
			identifier = acsmXml.children()[4].children()[2].children()[3];
		}
		
		
		/**
		 *  Open the acsm file with ADE
		 *  if ADE is not installed, do nothing just return
		 */ 
		private function OpenWithAde():void
		{
			if(!adeInstalled)
				return;
			acsmFile.openWithDefaultApplication();
		}
		
		/**
		 *  Find the file's local path by uuid
		 *  If the Adobe Digital Editions not installed ,return "No Adobe Digital Editions"
		 *  If file download not complete, return "File not download complete"
		 * 	If no such file in manifest.xml, return "File not found"
		 */
		public function findNode():Boolean
		{
			if(!CheckAcsm())
			{
				return false;
			}
//			OpenWithAde();
			CheckOSType();
			GetIdentifier();
			var file:File;
			file = adeRoot.resolvePath("manifest.xml");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			var DEManifest:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			fileStream.close();

			var bookChildren:XMLList = DEManifest.de::contentSet.children();
			for(var i:int = 0; i<bookChildren.length(); i++)
			{
				if(bookChildren[i].dc::identifier.text() == identifier)
				{
					if(bookChildren[i].de::downloadState.text() == "1")
//						if(bookChildren[i].de::localPath.attribute("relative"))
							mediaNode = bookChildren[i];
							return true;
				}
				//if 
			}
			OpenWithAde();
			return false;
		}
		
		public function get DownloadMedia():Object
		{
			var media:Object = new Object();
			media.Author = mediaNode.dc::creator;
			media.CoverUrl = adeRoot.resolvePath(mediaNode.de::thumbnailID).nativePath;
			media.FileType = mediaNode.dc::format;
			media.LocalPath = mediaNode.de::localPath.attribute("relative") ?
				adeRoot.resolvePath(mediaNode.de::localPath).nativePath:mediaNode.de::localPath;
			media.Publisher = mediaNode.dc::publisher;
			media.Title = mediaNode.dc::title;
			return media;
		}
		
	}
}