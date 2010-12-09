package test
{
	import mx.controls.HTML;

	public class AddThisHtml extends HTML
	{
		public function AddThisHtml()
		{
			this.htmlLoader.placeLoadStringContentInApplicationSandbox = true;
			this.location = "add.html";
			
		}
	}
}