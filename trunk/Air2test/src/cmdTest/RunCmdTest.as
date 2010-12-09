package cmdTest
{
	import flash.desktop.*;
	import flash.desktop.NativeProcess;
	import flash.events.*;
	import flash.filesystem.File;

	public class RunCmdTest
	{
		private var np:NativeProcess ;
		public function RunCmdTest()
		{
			np = new NativeProcess();
			var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();            
			np.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
			np.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
			np.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			np.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
			np.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);

			var ade:AdeHandler = new AdeHandler();
			if(ade.adeInstalled)
			{
				var adeFile:File = new File(ade.adePath);
				info.executable = adeFile;
				var processArgs:Vector.<String> = new Vector.<String>();
				processArgs[0] = "c:\\test.pdf";
				info.arguments = processArgs;
				np.start(info);
			}
		}
		
		public function onOutputData(event:ProgressEvent):void
		{
			trace("Got: ", np.standardOutput.readUTFBytes(np.standardOutput.bytesAvailable)); 
		}
		
		public function onErrorData(event:ProgressEvent):void
		{
			trace("ERROR -", np.standardError.readUTFBytes(np.standardError.bytesAvailable)); 
		}
		
		public function onExit(event:NativeProcessExitEvent):void
		{
			trace("Process exited with ", event.exitCode);
		}
		
		public function onIOError(event:IOErrorEvent):void
		{
			trace(event.toString());
		}


		
		
	}
}