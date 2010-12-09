package ProcessTest
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.system.Capabilities;
	
	import mx.controls.Alert;

	public class FFProcess extends EventDispatcher
	{
		
		private var process:NativeProcess;
		private var nativeProcessStartupInfo:NativeProcessStartupInfo;
		private var currentError : String;
		
		public function FFProcess()
		{
			if(NativeProcess.isSupported)
			{
				nativeProcessStartupInfo = new NativeProcessStartupInfo();
				if(Capabilities.os.substr(0,3).toLowerCase() == "win")
				{
					nativeProcessStartupInfo.executable = File.applicationDirectory.resolvePath("libs/ffmpeg/win/ffmpeg.exe");
				}
				else
					nativeProcessStartupInfo.executable = File.applicationDirectory.resolvePath("libs/ffmpeg/mac/ffmpeg");
			}
			else
				Alert.show("Native Process not supported.");
		}
		
		public function slice(infilepath:String,outfilepath:String,start:int,duration:int):void
		{
			var processArgs:Vector.<String> = new Vector.<String>();
			processArgs.push("-i",infilepath,"-ss",start,"-t",duration,"-y",outfilepath);
			nativeProcessStartupInfo.arguments = processArgs;
			process = new NativeProcess();
			trace(nativeProcessStartupInfo.arguments);
			process.start(nativeProcessStartupInfo);
			process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA,onErrorData);
			process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
		}
		
		public function onErrorData(event:ProgressEvent):void
		{
			if(process.running){
				currentError = process.standardError.readUTFBytes(process.standardError.bytesAvailable)
				trace(currentError); 
			}
		}
		
		public function onExit(event:NativeProcessExitEvent):void
		{
			if(event.exitCode == 1){
				Alert.show(currentError,"Error");
			}
			if(event.exitCode == 0)
			{
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
	}
}