package BandwidthTest
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	
	public class BandwidthTest extends EventDispatcher
	{
		
		private var _downloadCount:uint;
		private var _bandwidthTests:Array;
		private var _detectedBandwidth:Number;
		private var _startTime:uint;
		
		
		public function BandwidthTest(target:IEventDispatcher=null)
		{
			_downloadCount = 0;
			_bandwidthTests = new Array( );
		}
		
		public function get detectedBandwidth( ):Number {
			return _detectedBandwidth;
		}
		
		// Run the bandwidth test.
		public function test( ):void {
			// Use a URLLoader to load the data.
			var loader:URLLoader = new URLLoader( );
			// Use a URL with a unique query string to ensure the data is
			// loaded from the server and not from browser cache.
			var request:URLRequest = new URLRequest("http://localhost/upload/Faust.epub");
			loader.load(request);
			loader.addEventListener(Event.OPEN, onStart);
			loader.addEventListener(Event.COMPLETE, onLoad);
		}
		// When the file starts to download get the current timer value.
		private function onStart(event:Event):void {
			_startTime = getTimer( );
		}
		
		private function onLoad(event:Event):void {
			// The download time is the timer value when the file has downloaded
			// minus the timer value when the value started downloading. Then
			// divide by 1000 to convert from milliseconds to seconds.
			var downloadTime:Number = (getTimer( ) - _startTime) / 1000;
			_downloadCount++;
			// Convert from bytes to kilobits.
			var kilobits:Number = event.target.bytesTotal / 1000 * 8;
			// Divide the kilobits by the download time.
			var kbps:Number = kilobits / downloadTime;
			// Add the test value to the array.
			_bandwidthTests.push(kbps);
			if(_downloadCount == 1) {
				// If it's only run one test then run the second.
				test( );
			}
			else if(_downloadCount == 2) {
				// If it's run two tests then determine the margin between the
				// first two tests.
				// If the margin is small (in this example, less than 50 kbps)
				// then dispatch a complete event. If not run a test.
				if(Math.abs(_bandwidthTests[0] - _bandwidthTests[1]) < 50) {
					dispatchCompleteEvent( );
				}
				else {
					test( );
				}
			}
			else {
				// Following the third test dispatch a complete event.
				dispatchCompleteEvent( );
			}
		}
			
	
	private function dispatchCompleteEvent( ):void {
		// Determine the avarage bandwidth detection value.
		_detectedBandwidth = 0;
		var i:uint;
		for(i = 0; i < _bandwidthTests.length; i++) {
			_detectedBandwidth += _bandwidthTests[i];
		}
		_detectedBandwidth /= _downloadCount;
		// Dispatch a complete event.
		dispatchEvent(new Event(Event.COMPLETE));
	}}
}