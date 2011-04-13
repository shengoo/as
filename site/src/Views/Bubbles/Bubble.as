package Views.Bubbles
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;
	
	public class Bubble extends Sprite
	{
		private var _circle:Sprite;
		private var ra:int =3;
		public function Bubble(x:int,y:int)
		{
			_circle = new Sprite( );
			_circle.graphics.beginFill(0xff00ff);
			_circle.graphics.drawCircle(x, y, ra);
			_circle.graphics.endFill( );
			addChild(_circle);
			var circleTimer:Timer = new Timer(50, 30);
			circleTimer.addEventListener(TimerEvent.TIMER, onCircleTimer);
			circleTimer.start( );
			circleTimer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
		}
		
		private function onCircleTimer(event:TimerEvent):void {
			ra++;
			_circle.y -= 5;
			_circle.x += Math.random()*10-5;
			_circle.alpha -= 0.04;
			//			_circle.graphics.beginFill(0xff99ff);
			//			_circle.graphics.drawCircle(_circle.x, _circle.y, ra);
			//			_circle.graphics.endFill( );
		}
		private function timerComplete(event:TimerEvent):void
		{
			removeChild(_circle);
			System.gc();
		}
		
	}
}