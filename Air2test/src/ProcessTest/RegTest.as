package ProcessTest
{
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.*;
	import flash.filesystem.File;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.System;
	
	public class RegTest
	{
		
		private var adeFile:File;
		private var np:NativeProcess;
		
		
		public function RegTest()
		{
			np=new NativeProcess();
			
			np.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			np.addEventListener(ProgressEvent.STANDARD_INPUT_PROGRESS, inputProgressListener);
			np.addEventListener(ProgressEvent.STANDARD_ERROR_DATA,onStandardErrorData);
			np.addEventListener(NativeProcessExitEvent.EXIT, onExit);

			var info:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			var ar:Array = File.getRootDirectories();
//			info.executable=new File("%systemroot%\\System32\\reg.exe");
			info.executable=new File("%systemroot%\\System32\\reg.exe");
			var processArgs:Vector.<String>=new Vector.<String>();
			processArgs.push("QUERY");
			var k:String = "HKLM\\Software\\Adobe\\Digital Editions";
			processArgs.push(k);
			processArgs.push("/v");
			processArgs.push("InstallPath");
		
			
			trace(info.executable.nativePath + " " + processArgs[0] + " " + processArgs[1] + " " + processArgs[2]);
//			trace(info.executable.nativePath + " " + processArgs[0] + " " + processArgs[1]);
			info.arguments=processArgs;
			np.start(info);
		}
		
		private function onExit(e:NativeProcessExitEvent):void
		{
			
		}
		
		private function onStandardErrorData(event:ProgressEvent):void
		{
			trace("Ade not installed");
			np.exit(true);
		}
		
		public function inputProgressListener(event:ProgressEvent):void
		{
			np.closeInput();
		}
		public function onOutputData(event:ProgressEvent):void
		{
			var str:String = np.standardOutput.readUTFBytes(np.standardOutput.bytesAvailable);
			var array:Array = str.split("  ");
			for(var i:int = 0; i<array.length; i++)
			{
				if(array[i].search(".exe") > -1)
				{
					trace(array[i]);
					np.exit();	
				}
			}
		}
	}
}