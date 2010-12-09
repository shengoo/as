package Events
{
	import flash.events.Event;
	
	public class DownloadStateChangeEvt extends Event
	{
		public static const DownloadStateChangeEvt:String="DownloadStateChangeEvt";
		
		private var _downState:String;
		
		public function DownloadStateChangeEvt(downState:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			_downState=downState;
			super(DownloadStateChangeEvt, bubbles, cancelable);
		}
		
		public function get downState():String
		{
			return _downState;
		}
		
	}
}