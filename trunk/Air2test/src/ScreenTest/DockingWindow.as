package ScreenTest
{ import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	public class DockingWindow extends Sprite
	{
		private const dockedWidth:uint = 80;
		private const dockedHeight:uint = 80;
		
		public function DockingWindow():void{
		}
		
		public function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKey);
			
			dockLeft();
		}
		
		private function onKey(event:KeyboardEvent):void{
			switch(event.keyCode){
				case Keyboard.LEFT :
					dockLeft();
					break;
				case Keyboard.RIGHT :
					dockRight();
					break;
				case Keyboard.UP :
					dockTop();
					break;
				case Keyboard.DOWN :
					dockBottom();
					break;
				case Keyboard.SPACE :
					stage.nativeWindow.close();
			}    
		}
		
		public function dockLeft():void{
			var screen:Screen = getCurrentScreen();
			stage.nativeWindow.x = screen.visibleBounds.left;
			stage.nativeWindow.y = screen.visibleBounds.top;
			stage.nativeWindow.height = screen.visibleBounds.height;
			stage.stageWidth = dockedWidth;
			drawContent();
		}
		
		public function dockRight():void{
			var screen:Screen = getCurrentScreen();
			stage.nativeWindow.x = screen.visibleBounds.width - dockedWidth;            
			stage.nativeWindow.y = screen.visibleBounds.top;
			stage.stageWidth = dockedWidth;
			stage.nativeWindow.height = screen.visibleBounds.height;
			drawContent();
		}
		
		public function dockTop():void{
			var screen:Screen = getCurrentScreen();
			stage.nativeWindow.x = screen.visibleBounds.left;
			stage.nativeWindow.y = screen.visibleBounds.top;
			stage.nativeWindow.width = screen.visibleBounds.width;
			stage.stageHeight = dockedHeight;
			drawContent();
		}
		
		public function dockBottom():void{
			var screen:Screen = getCurrentScreen();
			stage.nativeWindow.x = screen.visibleBounds.left;
			stage.nativeWindow.y = screen.visibleBounds.height - dockedHeight;
			stage.nativeWindow.width = screen.visibleBounds.width;
			stage.stageHeight = dockedHeight;    
			drawContent();        
		}
		
		private function getCurrentScreen():Screen{
			return Screen.getScreensForRectangle(stage.nativeWindow.bounds)[0];
		}
		
		private function drawContent():void{
			const size:int = 60;
			const pad:int = 10;
			var numHSquares:int = Math.floor(stage.stageWidth/(size + pad));
			var numVSquares:int = Math.floor(stage.stageHeight/(size + pad));
			with (graphics){
				clear();
				lineStyle(1);
				beginFill(0x3462d5,.7);
				for(var i:int = 0; i < numHSquares; i++){
					for(var j:int = 0; j < numVSquares; j++){                
						drawRect((i * (size + pad)) + pad, (j * (size + pad)) + pad, size, size);
					}
				}
				endFill();
			}
		}
	}

}