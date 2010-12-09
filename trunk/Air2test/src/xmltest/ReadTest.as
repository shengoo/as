package xmltest
{
	import Entities.*;
	
	import flash.filesystem.*;
	import flash.xml.*;
	
	import mx.utils.ArrayUtil;
	
	public class ReadTest
	{
		private var doc:XML;
		private var ids:Array = new Array();
		private var items:Array = new Array();
		private var mediaItems:Array = new Array();
		public function ReadTest()
		{
//			readNew();
//			find();
//			add("1001","4");
//			deleteItem("1001","1");
//			trace(check("1001","4"));
//			change("2","DRM","00000");
//			deleteFromMediaStorage("2");
//			editItem(new MediaItem());
//			renameTab("1003","name");
//			deleteTab("1003");
//			createTab("new de");
//			readSupportEreaders();
//			addSupportEreaders("aaaaaaaaa");
//			deleteSupportEreaders("READER");
			rememberLastViewType("test","tt");
		}
		
		public function rememberLastViewType(key:String,val:String):void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\src\\config.xml");
			var node:XMLList = doc.ViewTypes.ViewType.(@key == key);
			if(node.length() == 0)
			{
//				var newNode = "<ViewType key=\"" + key + "\" value=\"" + val + "\"/>";
				var newNode:XML = new XML("<ViewType key=\"" + key + "\" value=\"" + val + "\"/>");
				doc.ViewTypes.appendChild(newNode);
			}
			else
				node[0].@value = val;
			saveFile("C:\\projects2\\BeijingProjects\\EBook\\trunk\\src\\config.xml");
		}
		
		public function deleteSupportEreaders(name:String):void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\src\\config.xml");
//			delete (doc.SupportedEreaderNames.Name.(text == name)).length();
			var length:int = (doc.SupportedEreaderNames.Name.(text == name)).length();
			for(var i:int = 0;i<length;i++)
				delete doc.SupportedEreaderNames.Name.(text == name)[0];
		}
		
		public function addSupportEreaders(name:String):void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\src\\config.xml");
			var newStr:String = "<Name>" + name + "</Name>";
			var newElement:XML = new XML(newStr);
			doc.SupportedEreaderNames.appendChild(newElement);
		}
		
		public function readSupportEreaders():void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\src\\config.xml");
			trace(doc.SupportedEreaderNames.Name.text());
			for(var i:int = 0;i<doc.SupportedEreaderNames.Name.length();i++)
			trace(doc.SupportedEreaderNames.Name[i].toString());
		}
		
		public function createTab(name:String):void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\bin-debug\\CustomListStorage.xml");
			
		}
		
		public function deleteTab(id:String):void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\bin-debug\\CustomListStorage.xml");
			delete doc.TabItem.(ID == id)[0];
		}
		
		public function renameTab(id:String,name:String):void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\bin-debug\\CustomListStorage.xml");
			doc.TabItem.(ID == id).Title = name;
		}
		
		public function editItem(i:MediaItem):void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\bin-debug\\MediaStorage.xml");
			var str:String = "<aaaa>aaaaaaaa</aaaa>";
			var newEle:XML = new XML(str);
			doc.MediaItem.(ID == "2")[0] = newEle;
		}
		
		public function change(itemID:String,fieldName:String,val:String)
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\bin-debug\\MediaStorage.xml");
			var str:String = "<" + fieldName + ">" + val + "</" + fieldName + ">";
			var newEle:XML = new XML(str);
			for each ( var element:XML in doc.elements())
			{
				if(element.ID.toString() == itemID)
				{
//					var target:XML = element.elements(fieldName)[0];
//					element.r = newEle;
					element.elements(fieldName)[0] = newEle;
					break;
				}
			}
		}
		
		public function check(tabID:String,itemID:String):Boolean
		{
			readIDs(tabID);
			if(ArrayUtil.getItemIndex(itemID,ids)>-1)
				return true;
			return false;
		}
		
		public function deleteFromMediaStorage(itemID:String):void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\bin-debug\\MediaStorage.xml");
			delete doc.MediaItem.(ID == itemID)[0];
		}
		
		public function deleteItem(tabID:String,itemID:String):void
		{
			read("C:/new.xml");
			for each ( var element:XML in doc.elements())
			{
				if (element.ID.toString() == tabID)
				{
					delete element.Item.(ID.toString() == itemID)[0];
//					for each ( var node:XML in element.elements("Item"))
//						{
//							if(node.ID == itemID)
//							{
//								delete node.parent().Item.(ID.toString() == itemID)[0];
//								trace(node.parent());
//								break;
//							}
//						}
//					break;
				}
			}
			saveFile("C:/new.xml");
		}
		
		public function add(tabID:String,itemID:String):void
		{
			read("C:/new.xml");
			var newStr:String = "<Item><ID>" + itemID + "</ID></Item>";
			var newElement:XML = new XML(newStr);
			for each ( var element:XML in doc.elements())
			{
				if (element.ID.toString() == tabID)
				{
					element.appendChild(newElement);
					break;
				}
			}
			saveFile("C:/new.xml");
		}
		
		public function saveFile(path:String):void
		{
			try
			{
				var file:File=new File(path);
				var fs:FileStream=new FileStream();
				fs.open(file, FileMode.WRITE);
				fs.writeUTFBytes(doc.toString());
			}
			catch(e:Error)
			{
				if(fs != null)
					fs.close();
				trace(e.message);
			}
			finally
			{
				fs.close();
			}
		}
		
		public function read(path:String):void
		{
			var file:File = new File(path);
			var fs:FileStream=new FileStream();
			fs.open(file, FileMode.READ);
			var xmlDoc:XMLDocument=new XMLDocument(fs.readUTFBytes(fs.bytesAvailable));
			doc = new XML(xmlDoc.toString());
			fs.close();
		}
		
		public function find():void
		{
			read("C:\\projects2\\BeijingProjects\\EBook\\trunk\\bin-debug\\MediaStorage.xml");
			for each ( var element:XML in doc.elements() ) 
			{
				if(ArrayUtil.getItemIndex(element.ID.toString(),ids)>-1)
					mediaItems.push(convertObjToMediaItem(element));
			}
			trace(mediaItems.length);
		}
		
		public function readIDs(tabID:String):void
		{
			read("C:/new.xml");
			for each ( var element:XML in doc.elements() ) 
			{
				if(element.ID.toString() == tabID)
				{
					for each ( var node:XML in element.elements("Item"))
					ids.push(node.ID.toString());
				}
			}
			trace(ids.length);
		}
		
		public static function serilizeObj(obj:Object):XML
		{
			var result:XML;
			
			return result;
		}
		
		public static function convertObjToMediaItem(dataSource:Object):MediaItem
		{
			var mediaItem:MediaItem=new MediaItem();
			mediaItem.Author=dataSource["Author"];
			mediaItem.CoverUrl=dataSource["CoverUrl"];
			mediaItem.Description=dataSource["Description"];
			mediaItem.FileType=dataSource["FileType"];
			mediaItem.ID=dataSource["ID"];
			mediaItem.IsAcsm=dataSource["IsAcsm"];
			mediaItem.MediaType=dataSource["MediaType"];
			mediaItem.Price=dataSource["Price"];
			mediaItem.Publisher=dataSource["Publisher"];
			mediaItem.PublishTime=dataSource["PublishTime"];
			mediaItem.Title=dataSource["Title"];
			mediaItem.Url=dataSource["Url"];
			mediaItem.LocalPath=dataSource["LocalPath"];
			mediaItem.ContentType = dataSource["ContentType"];
			mediaItem.CopyrightNotice = dataSource["CopyrightNotice"];
			mediaItem.DownloadUrl = dataSource["DownloadUrl"];
			mediaItem.DRM = dataSource["DRM"];
			mediaItem.Edition = dataSource["Edition"];
			mediaItem.FileExtension = dataSource["FileExtension"];
			mediaItem.Identifier = dataSource["Identifier"];
			mediaItem.ShopUrl = dataSource["ShopUrl"];
			mediaItem.LocalCover = dataSource["LocalCover"];
			return mediaItem;
		}
		
		
		
	}
}