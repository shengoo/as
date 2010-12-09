package xmltest
{
	public class XmlValidator
	{
		
		private var doc:XML;
		
		
		public function XmlValidator()
		{
			var file:File = new File(path);
			var fs:FileStream=new FileStream();
			fs.open(file, FileMode.READ);
			var xmlDoc:XMLDocument=new XMLDocument(fs.readUTFBytes(fs.bytesAvailable));
			doc = new XML(xmlDoc.toString());
			fs.close();
		}
		
		public static function IsValid(value:String):Boolean
		{
			var _isValid:Boolean = true;
			try{
				var xml:XML = new XML(value);
			}
			catch(e:Error){
				_isValid = false;
			}
			return _isValid;

		}
	}
}