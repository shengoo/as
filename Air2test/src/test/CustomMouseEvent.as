package test
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	
	public class CustomMouseEvent extends MouseEvent{
		
		public static const TITLE_BTN_CLICK:String="titleBtnClick";
		
		
		public function CustomMouseEvent(type:String,bubbles:Boolean=true,cancelable:Boolean=false,localX:Number=NaN,localY:Number=NaN,relatedObject:InteractiveObject=null,ctrlKey:Boolean=false,altKey:Boolean=false,shiftKey:Boolean=false,buttonDown:Boolean=false,delta:int=0){
			super(type, bubbles, cancelable,localX,localY,relatedObject,ctrlKey,altKey,shiftKey,buttonDown,delta);
		}
		
		override public function clone():Event{
			return super.clone();
		}
		
	}

}