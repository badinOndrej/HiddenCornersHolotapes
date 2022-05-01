package sprites 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class BorderSprite extends Sprite 
	{
		
		[Embed(source = "../img/notes.png")] private const Notes:Class;
		private var notesBitmap:Bitmap;
		
		public function BorderSprite() 
		{
			super();
			
			notesBitmap = new Notes();
			
			graphics.beginBitmapFill(notesBitmap.bitmapData);
			
			graphics.drawRect( -1000, -1000, 2826, 1000);
			graphics.drawRect( -1000, 700, 2826, 1000);
			graphics.drawRect( -1000, 0, 1000, 700);
			graphics.drawRect(826, 0, 1000, 700);
			
			graphics.endFill();
		}
		
	}

}