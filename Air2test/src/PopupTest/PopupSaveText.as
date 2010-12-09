package PopupTest
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import flashx.textLayout.container.ScrollPolicy;
	
	import mx.containers.TitleWindow;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	import spark.components.HGroup;
	import spark.components.TextArea;
	
	
	public class PopupSaveText extends Sprite
	{
		private var tf:TextField = new TextField();
		private var win:TitleWindow ;
		private var ta:TextArea = new TextArea();
		
		public function PopupSaveText()
		{
			super();
			tf.selectable = false;
			tf.text = "This is a test.";
			addChild(tf);
			tf.addEventListener(MouseEvent.RIGHT_CLICK,showMenu);
		}
		
		private function showMenu(e:MouseEvent):void
		{
			var menu:NativeMenu = new NativeMenu();
			var item:NativeMenuItem = new NativeMenuItem("Edit");
			item.addEventListener(Event.SELECT,beginEdit);
			menu.addItem(item);
			menu.display(this.stage,e.stageX,e.stageY);
		}
		
		private function beginEdit(e:Event):void
		{
			win = new TitleWindow();
			win.showCloseButton = true;
			win.width = 400;
			win.height = 300;
			win.horizontalScrollPolicy = ScrollPolicy.OFF;
			win.title = "Editing Description.";
			win.addEventListener(Event.CLOSE,onCloseWin);
			ta.text = tf.text;
			ta.width = 390;
			ta.height = 220;
			win.addChild(ta);
			var saveBtn:Button = new Button();
			saveBtn.label = "Save";
			saveBtn.addEventListener(MouseEvent.CLICK,onSaveEdtiting);
			var cancelBtn:Button = new Button();
			cancelBtn.label = "Cancel";
			cancelBtn.addEventListener(MouseEvent.CLICK,onCancelEditing);
			var hb:HGroup = new HGroup();
			hb.addElement(saveBtn);
			hb.addElement(cancelBtn);
			hb.paddingLeft = 120;
			win.addChild(hb);
			PopUpManager.addPopUp(win,this);
			PopUpManager.centerPopUp(win);
			ta.setFocus();
		}
		
		private function onCloseWin(e:Event):void
		{
			PopUpManager.removePopUp(win);
		}
		
		private function onCancelEditing(e:MouseEvent):void
		{
			PopUpManager.removePopUp(win);
		}
		
		private function onSaveEdtiting(e:MouseEvent):void
		{
			PopUpManager.removePopUp(win);
			tf.text = ta.text;
		}
		
		
	}
}