package test
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	public class TextFieldTest extends Sprite
	{
		private var textField:TextField = new TextField();
		private var maxHeight:int = 50;
		private var str:String = "The FIFA World Cup, also called the Football World Cup or the Soccer World Cup, but usually referred to simply as the World Cup, is an international association football competition contested by the men's national teams of the members of Fédération Internationale de Football Association (FIFA), the sport's global governing body. The championship has been awarded every four years since the first tournament in 1930, except in 1942 and 1946 when it was not contested because of World War II.The FIFA World Cup, also called the Football World Cup or the Soccer World Cup, but usually referred to simply as the World Cup, is an international association football competition contested by the men's national teams of the members of Fédération Internationale de Football Association (FIFA), the sport's global governing body. The championship has been awarded every four years since the first tournament in 1930, except in 1942 and 1946 when it was not contested because of World War II.";
		private var tfList:Array = new Array();
		private var buttonList:Array = new Array();
		public function TextFieldTest()
		{
			textField.multiline = true;
			textField.width = 200;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.wordWrap = true;
			textField.text = str;
			textField.type = TextFieldType.INPUT;
			textField.addEventListener(Event.CHANGE,onChange);
			sizeTF(textField);
			this.addChild(textField);
			addListeners();
		}
		
		private function onChange(e:Event):void
		{
			textField.text = (e.target as TextField).text;
			sizeTF(textField);
		}
		
		public function sizeTF(tf:TextField):void
		{
			if(tf.height > maxHeight)
			{
				tf.text = "";
				for(var i:int = 0; i<str.length; i++)
				{
					if(tf.height < maxHeight)
						tf.appendText(str.charAt(i));
				}
				tf.text = tf.text.substr(0,tf.text.length-2);
				tf.text = tf.text.substr(0,tf.text.lastIndexOf(" "));
				str = str.substr(tf.text.length);
				tfList.push(tf);
				var b:MyCircleButton = new MyCircleButton();
				b.x = 100 + buttonList.length * 20;
				b.y = 100;
				this.addChild(b);
				buttonList.push(b);
				var textF:TextField = new TextField();
				textF.multiline = true;
				textF.width = 200;
				textF.autoSize = TextFieldAutoSize.LEFT;
				textF.wordWrap = true;
				textF.text = str;
				textF.type = TextFieldType.INPUT;
				sizeTF(textF);
			}
			else
			{
				tfList.push(tf);
				var b:MyCircleButton = new MyCircleButton();
				b.x = 100 + buttonList.length * 20;
				b.y = 100;
				this.addChild(b);
				buttonList.push(b);
			}
		}
		
		private function addListeners():void
		{
			if(buttonList.length != 0 )
			{
				(buttonList[0] as MyCircleButton).setFocus();
				for(var i:int = 0; i<buttonList.length; i++)
				{
					(buttonList[i] as MyCircleButton).addEventListener(MouseEvent.CLICK,buttonClickHandler);
				}
			}
		}
		
		private function buttonClickHandler(e:MouseEvent):void
		{
			refreshButtons();
			clearScr();
			var btn:MyCircleButton = e.target as MyCircleButton;
			btn.setFocus();
			var index:int = buttonList.indexOf(btn);
			this.addChild(tfList[index]);
		}
		
		private function clearScr():void
		{
			for(var i:int = 0; i<tfList.length; i++)
			{
				if(this.contains(tfList[i]))
					this.removeChild(tfList[i]);
			}
		}
		
		private function refreshButtons():void
		{
			if(buttonList.length != 0 )
			{
				for(var i:int = 0; i<buttonList.length; i++)
				{
					(buttonList[i] as MyCircleButton).loseFocus();
				}
			}
		}
		
	}

}