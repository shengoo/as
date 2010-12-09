package MD5Test
{
	import flash.events.KeyboardEvent;
	
	import mx.containers.Form;
	import mx.containers.FormHeading;
	import mx.containers.FormItem;
	
	import spark.components.Group;
	import spark.components.TextInput;

	public class MD5tf extends Group
	{
		private var form:Form;
		private var output:TextInput;
		private var input:TextInput;
		public function MD5tf()
		{
			form = new Form();
			var head:FormHeading = new FormHeading();
			head.label = "MD5 test";
			form.addElement(head);
			var item1:FormItem = new FormItem();
			item1.label = "string";
			input = new TextInput();
			input.width = 250;
			input.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			item1.addElement(input);
			form.addElement(item1);
			var item2:FormItem = new FormItem();
			item2.label = "MD5:";
			output = new TextInput();
			output.width = 250;
			output.editable = false;
			item2.addElement(output);
			form.addElement(item2);
			addElement(form);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			output.text = MyMD5.hash(input.text);
		}
	}
}