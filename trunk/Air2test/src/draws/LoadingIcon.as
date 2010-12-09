package draws
{
	import com.paragallo.api.gif.player.GIFPlayer;
	
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.VGroup;
	
	public class LoadingIcon
	{
		private static var loadingIcon:GIFPlayer;
		private static var loadingPlace:UIComponent;
		
		public function LoadingIcon()
		{
		}
		
		public static function GetLoadingIcon(showText:Boolean):Group
		{
			var hg:Group = new Group();
			var file:File = new File(File.applicationDirectory.resolvePath('com/paragallo/asset/image/ajax-loader.gif').nativePath);
			loadingIcon = new GIFPlayer();
			loadingIcon.load(new URLRequest(file.url));
			loadingPlace = new UIComponent();
			loadingPlace.addChild(loadingIcon);
			loadingPlace.percentWidth = 100;
			loadingPlace.percentHeight = 100;
			hg.addElement(loadingPlace);
			if(showText)
			{
				var txt:Label = new Label();
				txt.text = "Downloading...";
				//				txt.percentWidth = 100;
				//				txt.percentHeight = 100;
				hg.addElement(txt);
			}
			return hg;
		}
	}
}