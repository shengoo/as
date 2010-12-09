package soundTest
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SampleDataEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	
	import mx.collections.IList;
	import mx.controls.Button;
	import mx.controls.ComboBox;
	
	import spark.components.Button;
	import spark.components.Group;
	
	public class SoundRecorder extends Group
	{
		private var micCombo:ComboBox;
		private var recordButton:mx.controls.Button;
		private var playButton:spark.components.Button;
		private var saveButton:spark.components.Button;
		
		[Bindable] 
		private var micNames:Array = Microphone.names;
		private var recordedData:ByteArray;
		
		private var mic:Microphone;
		private var sound:Sound;
		private var file:File;
		
		private var tmp:File;
		private var tmpStream:FileStream;

		
		public function SoundRecorder()
		{
			super();
			this.width = 470;
			this.height = 240;
			
			micCombo = new ComboBox();
			micCombo.dataProvider = micNames;
			micCombo.x = 283;
			micCombo.y = 8;
			this.addElement(micCombo);
			
			recordButton = new mx.controls.Button();
			recordButton.label = "Record";
			recordButton.toggle = true;
			recordButton.x = 28;
			recordButton.y = 7;
			recordButton.addEventListener(MouseEvent.CLICK,OnOff);
			addElement(recordButton);
			
			playButton = new spark.components.Button();
			playButton.label = "Play recording";
			playButton.x = 102;
			playButton.y = 7;
			playButton.addEventListener(MouseEvent.CLICK,playRecordedData);
			addElement(playButton);
			
			saveButton = new spark.components.Button();
			saveButton.label = "Save";
			saveButton.x = 208;
			saveButton.y = 7;
			saveButton.addEventListener(MouseEvent.CLICK,save);
			addElement(saveButton);
			
		}
		
		private function OnOff(e:MouseEvent):void
		{
			if (recordButton.selected)
			{
				recordData();
				recordButton.label = "Stop";
			}
			else
			{
				stopRecording();
				recordButton.label = "Record";
			}
		}
		
		private function recordData():void
		{
			recordedData = new ByteArray();
			tmp = File.createTempFile();
			tmpStream = new FileStream();
			tmpStream.open(tmp,FileMode.APPEND);
			mic = Microphone.getMicrophone(micCombo.selectedIndex );trace(mic.name);
			mic.rate = 44;
			mic.setSilenceLevel(0, 4000);
			mic.gain = 100;
			
			mic.addEventListener(SampleDataEvent.SAMPLE_DATA,dataHandler);           
		}
		
		private function stopRecording():void
		{
			if (!mic)
				return;
			
			tmpStream.close();
			mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, dataHandler);
		}

		private function dataHandler(event:SampleDataEvent):void
		{
//			this.visualization.drawMicBar(mic.activityLevel,0xFF0000);
//			recordedData.writeBytes(event.data);               
			tmpStream.writeBytes(event.data);
		}
		
		private function playRecordedData(e:MouseEvent):void
		{
			tmpStream.open(tmp,FileMode.READ);
			tmpStream.readBytes(recordedData);
			tmpStream.close();
			recordedData.position = 0;
			sound = new Sound();
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA,
				playSoundHandler);
			
			var channel:SoundChannel;
			channel = sound.play();
			channel.addEventListener(Event.SOUND_COMPLETE,
				onPlaybackComplete);
			
//			visualization.start();
		}

		private function onPlaybackComplete(event:Event):void
		{
//			visualization.stop();
		}
		
		private function playSoundHandler(event:SampleDataEvent):void
		{
			if (!recordedData.bytesAvailable > 0)
				return;
			
			var length:int = 8192; // Change between 2048 and 8192
			for (var i:int = 0; i < length; i++)
			{
				var sample:Number = 0;
				
				if (recordedData.bytesAvailable > 0)
					sample = recordedData.readFloat();
				
				event.data.writeFloat(sample);
			}
		}
		
		private function save(e:MouseEvent):void
		{
			file = new File( );
			file.browseForSave( "Save your wav" );
			file.addEventListener( Event.SELECT, writeWav );
		}
		
		private function writeWav(evt:Event):void
		{
			var wavWriter:WAVWriter = new WAVWriter();
			var stream:FileStream = new FileStream();
			
			// Set settings
			recordedData.position = 0;
			wavWriter.numOfChannels = 1;
			wavWriter.sampleBitRate = 16;
			wavWriter.samplingRate = 44100;               
			
			stream.open( file, FileMode.WRITE );
			
			if(!recordedData.bytesAvailable > 0)
			{
				tmpStream.open(tmp,FileMode.READ);
				tmpStream.readBytes(recordedData);
				tmpStream.close();
			}
			
			// convert ByteArray to WAV
			wavWriter.processSamples( stream, recordedData,
				44100, 1 );
			stream.close();
			tmp.deleteFile();
		}        


		
		
		
	}
}