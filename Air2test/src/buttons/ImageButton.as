package buttons
{
	import mx.controls.Button;
	
	public class ImageButton extends Button
	{
		[Embed(source="assets/image/delete-16.png")] 
		private var icon:Class;
		[Embed(source="assets/image/deleteover.png")] 
		private var overIcon:Class;
		[Embed(source="assets/image/deletedown.png")] 
		private var downIcon:Class;
		public function ImageButton()
		{
			super();
			this.label = "";
			this.width = 16;
			this.height = 16;
			this.setStyle("cornerRadius",8);
			this.setStyle("icon",icon);
			this.setStyle("downIcon",downIcon);
			this.setStyle("overIcon",overIcon);
			this.setStyle("upIcon",icon);
//			this.setStyle("horizontalAlign","center");
//			this.setStyle("verticalAlign","middle");
		}
	}
}