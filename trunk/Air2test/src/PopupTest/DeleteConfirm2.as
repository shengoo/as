package PopupTest
{
	import flash.events.MouseEvent;
	
	import mx.containers.TitleWindow;
	import mx.controls.Alert;
	import mx.controls.Spacer;
	import mx.controls.Text;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.HGroup;
	
	public class DeleteConfirm2 extends Group
	{
		private var win:TitleWindow;
		private var btnDelete:Button;
		private var btnDeleteAll:Button;
		private var btnCancel:Button;
		
		public function DeleteConfirm2()
		{
			super();
			var btn:Button = new Button();
			btn.label = "show dialog";
			btn.addEventListener(MouseEvent.CLICK,show);
			addElement(btn);
		}
		
		private function show(e:MouseEvent):void
		{
			win = new TitleWindow();
			win.width = 600;
			win.height = 200;
			win.showCloseButton = true;
			
			
			var g:Group = new Group();
			
			
			var txt:Text = new Text();
			txt.top = 30;
			txt.left = 30;
			txt.right = 30;
			txt.text = "Vil du slette           <name of book> fra disken, eller kun fra applikasjonen (filen vil da bli liggende i bibliotekmappen)?";
			txt.percentWidth = 100;
			g.addElement(txt);
			
			var h:HGroup = new HGroup();
			btnCancel = new Button();
			btnCancel.label = "Avbryt";
			btnCancel.addEventListener(MouseEvent.CLICK,cancel);
			h.addElement(btnCancel);
			
			var s:Spacer = new Spacer();
			s.percentWidth = 100;
			h.addElement(s);
			
			btnDelete = new Button();
			btnDelete.label = "Behold fil";
			btnDelete.addEventListener(MouseEvent.CLICK,deleteMedia);
			h.addElement(btnDelete);
			
			btnDeleteAll = new Button();
			btnDeleteAll.label = "Slett fil";
			btnDeleteAll.addEventListener(MouseEvent.CLICK,deleteFile);
			h.addElement(btnDeleteAll);
			
			
			h.left = 30;
			h.right = 30;
			h.bottom = 30;
			h.percentWidth = 100;
			g.addElement(h);
			g.percentHeight = 100;
			g.percentWidth = 100;
			win.addElement(g);
			win.addEventListener(CloseEvent.CLOSE,function(e:CloseEvent):void{PopUpManager.removePopUp(win);});
			PopUpManager.addPopUp(win,this,true);
			PopUpManager.centerPopUp(win);
		}
		
		
		private function cancel(e:MouseEvent):void
		{
			Alert.show("cacel");
		}
		
		private function deleteMedia(e:MouseEvent):void
		{
			Alert.show("not delete file");
		}
		
		private function deleteFile(e:MouseEvent):void
		{
			
		}
		
		
	}
}