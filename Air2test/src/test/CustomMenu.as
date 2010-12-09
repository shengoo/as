package test
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	
	import mx.containers.Panel;
	import mx.controls.Menu;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;

	public class CustomMenu extends Sprite
	{
		private var p:Panel = new Panel();
		private var t:TextField = new TextField();
		private var m:NativeMenu = new NativeMenu();
		private var menu:Menu;
		public function CustomMenu()
		{
			t.selectable = false;
			t.text = "click";
			t.x = 10;
			t.y = 10;
			t.width = 50;
			t.height = 20;
			var m1:NativeMenuItem = new NativeMenuItem("aaaaaa");
			var m2:NativeMenuItem = new NativeMenuItem("bbbbbbbb");
			m.addItem(m1);
			m.addItem(m2);
//			t.contextMenu = m;
			t.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			t.addEventListener(MouseEvent.MOUSE_OUT,mouseLeaveHandler);
			t.addEventListener(MouseEvent.CLICK,clickHandler);
			this.addChild(t);
//			var menuData:Array = [ "Item 1", "Item 2", "Item 3" ];
			
			// create the menu
//		 	menu = Menu.createMenu( parent, menuData, false );
			
			
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			
			// show the menu
			m.display(this.stage,t.x,t.y+t.height);
//			menu.x = t.x;
//			menu.y = t.y + t.height;
//			menu.show();
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			t.border=true;
			t.borderColor = 0x000005;
		}
		
		private function mouseLeaveHandler(e:MouseEvent):void
		{
			t.border = false;
		}
		
	}
}