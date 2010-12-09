package test
{
	import flash.events.MouseEvent;
	
	import mx.containers.Panel;
	import mx.controls.Button;
	
	[Event(name="titleBtnClick", type="it.creativesource.CustomMouseEvent")]
	[Style(name="titleBtnStyleName", type="String", inherit="no")]
	
	
	public class CustomPanel extends Panel{
		
		private var _titleBtn:Button;
		
		
		public function CustomPanel(){
			super();
		}
		
		// this method is called during the initialize phase
		// and is used to create the interface
		override protected function createChildren() : void{
			
			super.createChildren();		
			_titleBtn=new Button();
			
			_titleBtn.height= borderMetrics.top-6;
			_titleBtn.width= borderMetrics.top-6;					
			_titleBtn.addEventListener(MouseEvent.CLICK,handleTitleBtnClick);			
			
			rawChildren.addChild(_titleBtn);
			
		}
		
		// this method is used every time there is a change in the DisplayList
		// to move and reorganize the interface
		override protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number):void{
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);			
			var y:int = borderMetrics.top/2 - _titleBtn.width/2;
			var x:int = this.width - _titleBtn.width - borderMetrics.right;
			_titleBtn.move(x, y);
			
			
		}
		// this method is used every time there is a change using setStyle
		
		override public function styleChanged(styleProp:String):void{
			
			super.styleChanged(styleProp);
			if(_titleBtn){
				_titleBtn.styleName=getStyle("titleBtnStyleName");	
			}
		}
		
		
		private function handleTitleBtnClick(e:MouseEvent):void{
			
			dispatchEvent(new CustomMouseEvent(CustomMouseEvent.TITLE_BTN_CLICK , e.bubbles, e.cancelable,e.localX,e.localY,e.relatedObject,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown,e.delta));
			
		}
	}

}