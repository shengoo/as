package test
{
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.text.TextField;
	import flash.desktop.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.controls.Menu;
	import mx.core.UIComponent;
	
	import spark.components.mediaClasses.VolumeBar;

	public class USBPanel extends Sprite
	{
		private var storageCollection:ArrayCollection = new ArrayCollection();
	 	private	var tf:TextField = new TextField();
		private	var sprite:Sprite = new Sprite();
		private	var step:int = 30;
		private var dg:DataGrid = new DataGrid();
		public function USBPanel()
		{
			var storageVolumes:Vector.<StorageVolume> = StorageVolumeInfo.storageVolumeInfo.getStorageVolumes();
			var length:int = storageVolumes.length;
			
			addEventListeners();
//			trace(NativeApplication.nativeApplication.getDefaultApplication(".pdf"));
			for (var i:int = 0; i < length; i++)
			{
				addItem( storageVolumes[i] );
			}
			showVolmues();
		}
		
		private function showVolmues():void
		{
			if(contains(sprite))
				removeChild(sprite);
			while(sprite.numChildren>0)
				sprite.removeChildAt(0);
//			trace(storageCollection.length);
			for (var i:int = 0;i<storageCollection.length; i++)
			{
				var bm:Bitmap = new Bitmap();
				bm.bitmapData = storageCollection[i].icon;
				var anIcon:MySprite = new MySprite(storageCollection[i]);
				anIcon.addChild(bm);
				anIcon.x = i*step + 5;
				anIcon.name = storageCollection[i].name != null ? storageCollection[i].name + "(" + storageCollection[i].nativePath + ")"
					: anIcon.name;
				
				anIcon.addEventListener(MouseEvent.CLICK,MouseClickHandler);
				anIcon.addEventListener(MouseEvent.RIGHT_CLICK,MouseClickHandler);
				anIcon.addEventListener(MouseEvent.MOUSE_OVER,MouseOverHandler);
				anIcon.addEventListener(MouseEvent.MOUSE_OUT,MouseOutHandler);
				sprite.addChild(anIcon);
			}
			addChild(sprite);
		}
		
		private function MouseClickHandler(event:MouseEvent):void
		{
			var popup:NativeMenu = createRootMenu(event.target.dataObj);
			popup.display(this.stage,mouseX,mouseY);
		}
		
	    private	function createRootMenu(data:Object):NativeMenu{
			var menu:NativeMenu = new NativeMenu();
			menu.addItem(new NativeMenuItem("Copy to "));
			menu.addItem(new NativeMenuItem("Open "));
			menu.items[0].data = data.nativePath;
			menu.items[0].addEventListener(Event.SELECT,CopyClickHandler);
			menu.items[1].data = data.nativePath;
			menu.items[1].addEventListener(Event.SELECT,OpenClickHandler);
			return menu;
		}
		
		private function OpenClickHandler(event:Event):void
		{
			var file:File = new File(event.target.data);
			file.browseForOpenMultiple("tt");
			file.addEventListener(FileListEvent.SELECT_MULTIPLE, file_selectMultiple);
		}
		
		private function file_selectMultiple(evt:FileListEvent):void {
			dg.dataProvider = evt.files;
			dg.visible = true;
			sprite.addChild(dg);
		}

		
		private function CopyClickHandler(event:Event):void
		{
			trace("clicked " + event.target.data);
		}
		
		private function MouseOutHandler(event:MouseEvent):void
		{
			removeChild(tf);
		}
		
		private function MouseOverHandler(event:MouseEvent):void
		{
			tf.text = event.target.name;
			tf.x = mouseX;
			tf.y = mouseY;
			addChild(tf);
		}
		
		private function addEventListeners():void
		{
			
			StorageVolumeInfo.storageVolumeInfo.addEventListener(StorageVolumeChangeEvent.STORAGE_VOLUME_MOUNT,
				function (event:StorageVolumeChangeEvent):void
				{
					addItem(event.storageVolume);   
					showVolmues();
				});
			
			
			StorageVolumeInfo.storageVolumeInfo.addEventListener(StorageVolumeChangeEvent.STORAGE_VOLUME_UNMOUNT,
				function (event:StorageVolumeChangeEvent):void
				{
					var nativePath:String =
					event.rootDirectory.nativePath;
					removeItemByNativePath( nativePath );
					showVolmues();
				});
		}
		
		
		private function addItem(storageVolume:StorageVolume ):void
		{
//			if(storageVolume.isRemovable)
//			{
				var object:Object = new Object();
			
				object = new Object();
				object.name = storageVolume.name;
				object.icon = storageVolume.rootDirectory.icon.bitmaps[1];
				object.nativePath = storageVolume.rootDirectory.nativePath;
				object.isWritable = storageVolume.isWritable;
				object.isRemovable = storageVolume.isRemovable;
				storageCollection.addItem( object );     
//			}
			
		}
		
		
		private function removeItemByNativePath(nativePath:String ):void
		{
			var len:Number = this.storageCollection.length;
			var object:Object;
			
			for ( var i:int=0; i<len; i++ )
			{
				object = this.storageCollection.getItemAt(
					i );
				
				if ( object.nativePath == nativePath )
				{
					this.storageCollection.removeItemAt(
						i );
					break;
				}
			}
		}
	}
}