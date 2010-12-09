package soundTest
{
	import ProcessTest.FFProcess;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	
	import org.bytearray.video.FLVSlice;
	import org.bytearray.video.FLVSlicer;
	import org.bytearray.video.events.SlicedEvent;
	import org.osmf.events.TimeEvent;
	
	
	public class SoundSlicer extends Sprite
	{
		private var sound:Sound;
		private var samples:ByteArray = new ByteArray();
		private var buffer:BitmapData = new BitmapData(1024,512,false,0);
		private var cursorBuffer:BitmapData = new BitmapData(1024,512,true,0);
		private var selectBuffer:BitmapData = new BitmapData(1024,512,true,0);
		private var selectScreen:Bitmap = new Bitmap(selectBuffer);
		private var cursorScreen:Bitmap = new Bitmap(cursorBuffer);
		private var screen:Bitmap = new Bitmap(buffer);
		private var label:TextField = new TextField ();
		private var rect:Rectangle = new Rectangle(0,0,1,0);
		private var playingTime:int;
		private var ratio:Number;
		private var step:int;
		private var zone:Rectangle = new Rectangle(0,0,1,512);
		private var selectionRect:Rectangle = new Rectangle(0,0,0,1024);
		private var clickedPosition:int;
		private var looper:Timer = new Timer(0,0);
		private var channel:SoundChannel;
		private var browseBtn:TextField = new TextField();
		private var saveBtn:TextField = new TextField();
		private var selectedBytes:ByteArray = new ByteArray();
		private var mediaFile:File = new File();
		private var outputFile:File = new File();
		private var console:TextField = new TextField();
		
	
		
		public function SoundSlicer()
		{
			super();
			addChild( screen );
			addChild( cursorScreen );
			addChild( selectScreen );
			label.defaultTextFormat = new TextFormat ( "Verdana", 10, 0xFFFFFF );
			label.autoSize = TextFieldAutoSize.LEFT;
			label.text = "simple as3 waveform with Sound.extract() - select any area to loop";
			addChild ( label );
			looper.addEventListener( TimerEvent.TIMER, onTime );
			browseBtn.text = "Select file";
			browseBtn.border = true;
			browseBtn.height = 20;
			browseBtn.width = 200;
			browseBtn.selectable = false;
			browseBtn.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			browseBtn.addEventListener(MouseEvent.CLICK,browseFile);
			browseBtn.y = 512;
			addChild(browseBtn);
			saveBtn.text = "Save selected area as mp3 file";
			saveBtn.border = true;
			saveBtn.height = 20;
			saveBtn.width = 200;
			saveBtn.selectable = false;
			saveBtn.y = 532;
			saveBtn.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			saveBtn.addEventListener(MouseEvent.CLICK,saveFile);
			addChild(saveBtn);
			console.wordWrap = true;
			console.border = true;
			console.width = 200;
			console.height = 80;
			console.selectable = false;
			console.y = 512;
			console.x = 220;
			addChild(console as DisplayObject);
		}
		
		private function saveFile(e:MouseEvent):void
		{
			if(selectionRect.width == 0)
			{
				Alert.show("Nothing selected.");
				return;
			}	
			outputFile.addEventListener(Event.SELECT,writeFile);
			outputFile.browseForSave("Save file");
		}
		
		private function writeFile(e:Event):void
		{
			outputFile.removeEventListener(Event.SELECT,writeFile);
			outputFile = e.target as File;
			var p:FFProcess = new FFProcess();
			p.addEventListener(Event.COMPLETE,onGenerateComplete);
			p.slice(mediaFile.nativePath,outputFile.nativePath,Math.floor(selectionRect.x*ratio/1000),Math.floor(selectionRect.width*ratio/1000));
			console.text = "Generating file, please wait.\n";
			
			/*var fs:FileStream = new FileStream();
			try{
				 //open file in write mode
				 fs.open(outputFile,FileMode.WRITE);
				 //write bytes from the byte array
				 fs.writeBytes(selectedBytes);
			}catch(e:Error){
				 trace(e.message);
			}
			finally
			{
				 //close the file
				 fs.close();
			}*/
		}
		
		private function onGenerateComplete(e:Event):void
		{
			console.text = "File generate complete\n";
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
			browseBtn.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			browseBtn.removeEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			saveBtn.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			saveBtn.removeEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.AUTO;
			browseBtn.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			browseBtn.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			saveBtn.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			saveBtn.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
		}
		
		private function browseFile(e:MouseEvent):void
		{
			mediaFile.addEventListener(Event.SELECT,selectFile);
			var mp3Filter:FileFilter = new FileFilter("MP3","*.mp3");
			mediaFile.browseForOpen("Select an mp3 file to open.",[mp3Filter]);
		}
		
		private function selectFile(e:Event):void
		{
			selectionRect.width = 0;
			selectBuffer.fillRect( selectBuffer.rect, 0 );
			mediaFile.removeEventListener(Event.SELECT,selectFile);
			console.text = "Loading file, please wait.\n";
			mediaFile = e.target as File;
			if(channel != null)
				channel.stop();
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, loadComplete);
			sound.load(new URLRequest(mediaFile.url));
		}
		
		private function scrollIt( e:Event ):void
		{
			cursorBuffer.fillRect( cursorBuffer.rect,0 );
			zone.x = (buffer.width / playingTime) * channel.position;
			cursorBuffer.fillRect( zone , 0xFF990000 );  
		}
		
		
		private function loadComplete(event:Event):void
		{
			console.text = "Loading complete, drawing wave.\n";
			buffer.fillRect( buffer.rect, 0 );
			/*var fs:FileStream = new FileStream();
			fs.open(mediaFile,FileMode.READ);
			var input:ByteArray = new ByteArray();
			fs.readBytes(input);
			//create the FLVSlice object
			var slicer:FLVSlicer = new FLVSlicer(input);
			
			// listen for the SlicedEvent.COMPLETE event
			slicer.addEventListener( SlicedEvent.COMPLETE, onSliced );
			
			// extract the slice with the specific timing (in ms) and save it
			var firstSlice:FLVSlice = slicer.slice(1000, 3000);
			
			// extract another slice with the specific timing (in ms) and save it
			var secondSlice:FLVSlice = slicer.slice(7200, 8900);
			
			// create a FLVSlice vector
			var slices:Vector.<FLVSlice> = new Vector.<FLVSlice>();
			
			// store the slices
			slices.push ( firstSlice );
			slices.push ( secondSlice );
			
			// merge them as a single FLV stream
			var merged:FLVSlice = slicer.merge( slices );
			outputFile = new File("D:/newflv.flv");
			var fs:FileStream = new FileStream();
			try{
				 //open file in write mode
				 fs.open(outputFile,FileMode.WRITE);
				 //write bytes from the byte array
				 fs.writeBytes(secondSlice.stream);
			}catch(e:Error){
				 trace(e.message);
			}
			finally
			{
				 //close the file
				 fs.close();
			}
			
			*/
		
			var extract:Number = Math.floor ((sound.length/1000)*44100);
			
			playingTime = sound.length;
			
			ratio = playingTime / buffer.width;
			samples = new ByteArray();
			var lng:Number = sound.extract(samples,extract);
			stage.addEventListener( Event.ENTER_FRAME, scrollIt );
			
			samples.position = 0;
			
			step = samples.length/4096;
			
			do step-- while ( step % 4 );
			
			var left:Number;
			var right:Number;
			
			for (var c:int = 0; c < 4096; c++)
			{
				rect.x = c/4;
				left = samples.readFloat()*128;
				right = samples.readFloat()*128;
				samples.position = c*step;
				
				if (left>0)
				{
					rect.y = 128-left;
					rect.height = left;
				} else
				{
					rect.y = 128;
					rect.height = -left;
				}
				
				buffer.fillRect( rect, 0xFFFFFF );
				
				if (right>0)
				{
					rect.y = 350-right;
					rect.height = right;
				} else
				{
					rect.y = 350;
					rect.height = -right;
				}
				
				buffer.fillRect( rect, 0x00FFFF );
			}
			channel = sound.play();
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseIsDown );
			console.text = "Wave done\n";
		}
		
	
		
		private function onTime( e:TimerEvent ):void
		{
			channel.stop();
			channel = sound.play( selectionRect.x*ratio );
		}
		
		private function onMouseIsDown( e:MouseEvent ):void
		{
			if(e.stageY > 512)
				return;
			if(e.stageX >1024)
				return;
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMove );
			selectBuffer.fillRect( selectBuffer.rect, 0 );
			clickedPosition = e.stageX;
			selectionRect.x = clickedPosition;
			selectionRect.width = 0;
		}
		
		private function onMove( e:MouseEvent ):void
		{
			if ( e.stageX > clickedPosition )
			{
				selectionRect.width = e.stageX-clickedPosition;
			} else
			{
				selectionRect.x = e.stageX;
				selectionRect.width = Math.abs (e.stageX-clickedPosition);
			}
			selectBuffer.fillRect( selectionRect, 0x33CCCCCC );
		}
		
		private function onClick( e:MouseEvent ):void
		{
			if(e.stageY > 512)
				return;
			if(e.stageX >1024)
				return;
			channel.stop();
			channel = sound.play( selectionRect.x*ratio );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
			
			if (selectionRect.width)
			{
				looper.delay = ratio*selectionRect.width;
				looper.start();
			} else looper.stop();
		}
		
	}
}