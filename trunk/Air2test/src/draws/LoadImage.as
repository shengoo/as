package draws
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	/**
	 * The following example uses the BitmapExample class to load the "Image.gif" image into a DisplayObject in the default location (x = 0, y = 0). A copy of Image.gif is then placed to the right of the original, which has new colors applied to pixels that pass a test using the threshold() method. This task is accomplished using the following steps:

   1. A property url is created, which is the location and name of the image file
   2. The class constructor calls the configureAssets() method, which, in turn, calls the completeHandler() method.
   3. configureAssets() creates a Loader object, which then instantiates an event listener, which is dispatched when completeHandler() completes the image manipulation.
   4. Next, the buildChild() method creates a new instance of a URLRequest object, request, with url passed so the file name and location are known.
   5. The request object is passed to the loader.load() method, which loads the image into memory via a display object.
   6. The image is then placed on the display list, which promptly displays the image on screen at coordinates x = 0, y = 0.
   7. The completeHandler() method then performs the following tasks: 

Notes:

    * You will need to compile the SWF file with "Local playback security" set to "Access local files only".
    * This example requires that a file named Image.gif be placed in the same directory as your SWF file.
    * It is recommended that you use an image up to 80 pixels wide. 
	 */
	
	
	public class LoadImage extends Sprite
	{
		private var url:String = "sony-reader.png";
		private var size:uint = 80;
		
		public function LoadImage() {
			configureAssets();
		}
		
		private function configureAssets():void {
			var loader:Loader = new Loader();
//			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			var request:URLRequest = new URLRequest(url);
//			loader.x = size * numChildren+50;
			loader.load(request);
			addChild(loader);
		}
		
		private function duplicateImage(original:Bitmap):Bitmap {
			var image:Bitmap = new Bitmap(original.bitmapData.clone());
			image.x = size * numChildren;
			addChild(image);
			return image;
		}
		
		private function completeHandler(event:Event):void {
			var loader:Loader = Loader(event.target.loader);
			var image:Bitmap = Bitmap(loader.content);
			
//			var duplicate:Bitmap = 
//				duplicateImage(image);
//			var bitmapData:BitmapData = duplicate.bitmapData;
//			var sourceRect:Rectangle = new Rectangle(0, 0, bitmapData.width, bitmapData.height);
//			var destPoint:Point = new Point();
//			var operation:String = ">=";
//			var threshold:uint = 0xCCCCCCCC;
//			var color:uint = 0xFFFFFF00;
//			var mask:uint = 0x000000FF;
//			var copySource:Boolean = true;
			
//			bitmapData.threshold(bitmapData,
//				sourceRect,
//				destPoint,
//				operation,
//				threshold,
//				color,
//				mask,
//				copySource);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Unable to load image: " + url);
		}
	}

}