package test
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.effects.Resize;
	 
	    public class MinMaxPanel extends Panel
	    {
	        private var minMaxBtn:Button = new Button();
			private var closeBtn:Button = new Button();
	        private var effResize:Resize = new Resize();
	        private var previousHeight:int = 40;
	 
	        public function MinMaxPanel()
	        {
	            super();
	            minMaxBtn.addEventListener(MouseEvent.CLICK, minimisePanel);
				closeBtn.addEventListener(MouseEvent.CLICK, closePanel);
	        }
	 
	        override protected function createChildren():void{
	            super.createChildren();
	            super.titleBar.addChild(minMaxBtn);
				super.titleBar.addChild(closeBtn);
	        }
			
			private function closePanel(e:MouseEvent):void
			{
				stage.nativeWindow.close();
			}
	 
	        private function minimisePanel(e:MouseEvent):void{
	            effResize.stop();
	            minMaxBtn.removeEventListener(MouseEvent.CLICK, minimisePanel);
	            minMaxBtn.addEventListener(MouseEvent.CLICK, maxmisePanel);
	            effResize.heightFrom = height;
	            effResize.heightTo = previousHeight;
	            previousHeight = height;
	            effResize.play([this]);
	        }

	        private function maxmisePanel(e:MouseEvent):void{
	            effResize.stop();
	            minMaxBtn.removeEventListener(MouseEvent.CLICK, maxmisePanel);
	            minMaxBtn.addEventListener(MouseEvent.CLICK, minimisePanel);
	            effResize.heightFrom = height;
	            effResize.heightTo = previousHeight;
	            previousHeight = height;
	            effResize.play([this]);
	        }

	        override protected function updateDisplayList(w:Number, h:Number):void{
	            super.updateDisplayList(w,h);
	            minMaxBtn.x = super.titleBar.width - 60;
	            minMaxBtn.y = 5;
	            minMaxBtn.width = 20;
	            minMaxBtn.height = 20;
				closeBtn.x = super.titleBar.width - 30;
				closeBtn.y = 5;
				closeBtn.width = 20;
				closeBtn.height = 20;
	        }

	    }
}