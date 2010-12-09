package soundTest
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class SoundTest extends Sprite
	{
		var a:Sound = new Sound();
		public function SoundTest()
		{
			super();
			var file:File = new File("d:/sound.mp3");
			var fileUrl:URLRequest = new URLRequest(file.url);
			a.addEventListener(Event.COMPLETE,onLoadComplete);
			a.load(fileUrl);
//			a.play(0,1);
		}
		
		private function onLoadComplete(e:Event):void
		{
			var wave:BitmapData = new BitmapData(600,300);
			extractWaveform(a,wave);
			var image:Bitmap = new Bitmap(wave);
			this.addChild(image);
		}
		
		public function extractWaveform(sound:Sound, waveform:BitmapData):void
		{
			// Set sample rate
			// Flash resamples all sound to 44100hz.
			var sampleRate:int = 44100;
			
			// Set sample bit
			// We can work with less bits because we're drawing waveform,
			// the visual representation doesn't have to be bit-accurate.
			// (less bits = smaller loops)
			var sampleBit:int  = 8;
			
			// Estimate sample length
			// (To get exact sample length we might need to dig byte to byte.)
			var sampleLength:Number = Math.floor((sound.length / 1000) * sampleRate);
			
			// Extract sound samples
			var samples:ByteArray = new ByteArray();
			sound.extract(samples, sampleLength);
			samples.position = 0;
			
			// Calculate sample size based on the
			// desired waveform width
			var sampleSize:int = waveform.width * sampleBit;
			
			// The number of samples to skip
			var sampleEvery:int = samples.length / sampleSize;
			do { sampleEvery-- } while ( sampleEvery % sampleBit );
			
			// Build waveform
			var left:Number;
			var right:Number;
			var mono:Number;
			var rect:Rectangle = new Rectangle(0, 0, 1, 0);
			
			for (var i:int=0; i<sampleSize; i++)
			{
				// Get amplitude of the left & right channel
				left  = samples.readFloat();
				right = samples.readFloat();
				
				// Combine the amplitude of left & right channel
				mono = Math.abs(Math.max(left, right)) + Math.abs(Math.min(left, right));
				
				// Draw the amplitude on the waveform
				rect.height = mono * waveform.height;
				rect.x      = i / sampleBit;
				rect.y      = (waveform.height - rect.height) / 2;
				waveform.fillRect(rect, 0xFF336699);
				
				// Set the starting position to get
				// the amplitude in the next loop
				samples.position = i * sampleEvery;
			}
		}
		<!-- Page not cached by WP Super Cache. No closing HTML tag. Check your theme. -->

	}
}