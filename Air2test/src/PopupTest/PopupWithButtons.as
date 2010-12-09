package PopupTest
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Form;
	import mx.containers.FormHeading;
	import mx.containers.FormItem;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.TextArea;
	import spark.components.TextInput;
	import spark.components.TitleWindow;
	
	public class PopupWithButtons extends Group
	{
		private var btn:Button = new Button();
		private var win:TitleWindow ;
		
		public function PopupWithButtons()
		{
			super();
			btn.label = "click";
			btn.addEventListener(MouseEvent.CLICK,onclick);
			addElement(btn);
		}
		
		private function onclick(e:MouseEvent):void
		{
			win = new TitleWindow();
			var form:Form = new Form();
			form.width = 600;
			form.height = 350;
			var heading:FormHeading = new FormHeading();
			heading.label = "Beskrivelse av problemet";
			var item1:FormItem = new FormItem();
			item1.label = "Oppsummering";
			item1.width = 500;
			item1.height = 23;
			var summary:TextInput = new TextInput();
			summary.width = 327;
			item1.addElement(summary);
			var item2:FormItem = new FormItem();
			item2.label = "Beskrivelse";
			item2.width = 500;
			item2.height = 173;
			var description:TextArea = new TextArea();
			description.width = 326;
			description.height = 170;
			item2.addElement(description);
			form.addElement(heading);
			form.addElement(item1);
			form.addElement(item2);
			var btn:Button = new Button();
			btn.label = "Send";
			btn.x = 100;
			btn.y = 272;
			btn.addEventListener(MouseEvent.CLICK,btnClicked);
			form.defaultButton = btn;
			win.addElement(form);
			win.addElement(btn);
			win.addEventListener(Event.CLOSE,onCloseWin);
			PopUpManager.addPopUp(win,this);
			PopUpManager.centerPopUp(win);
		}
		
		private function btnClicked(e:MouseEvent):void
		{
			
		}
		
		private function onCloseWin(e:Event):void
		{
			PopUpManager.removePopUp(win);
		}
	}
}