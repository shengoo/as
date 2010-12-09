package test
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class TimerTest extends Sprite
	{
		private var _square:Sprite;
		private var _circle:Sprite;
		
		public function TimerTest()
		{
			_square = new Sprite( );
			_square.graphics.beginFill(0xff0000);
			_square.graphics.drawRect(0, 0, 100, 100);
			_square.graphics.endFill( );
			addChild(_square);
			_square.x = 100;
			_square.y = 50;
			_circle = new Sprite( );
			_circle.graphics.beginFill(0x0000ff);
			_circle.graphics.drawCircle(50, 50, 50);
			_circle.graphics.endFill( );
			addChild(_circle);
			_circle.x = 100;
			_circle.y = 200;
			// 创建两个定时器，启动
			var squareTimer:Timer = new Timer(50, 0);
			squareTimer.addEventListener(TimerEvent.TIMER, onSquareTimer);
			squareTimer.start( );
			var circleTimer:Timer = new Timer(100, 0);
			circleTimer.addEventListener(TimerEvent.TIMER, onCircleTimer);
			circleTimer.start( );
		}
		
		// 定义两个事件句柄
		private function onSquareTimer(event:TimerEvent):void {
			_square.y++;
		}
		private function onCircleTimer(event:TimerEvent):void {
			_circle.x++;
		}
		
		
	}
}