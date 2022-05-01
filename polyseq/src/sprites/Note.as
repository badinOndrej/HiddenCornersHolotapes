package sprites 
{
	import Shared.BGSExternalInterface;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class Note extends Sprite
	{
		
		[Embed(source = "../img/note.png")] private const NoteBitmap:Class;
		
		private var note:Bitmap;
		private var dx:int, dy:int;
		
		public function Note()
		{
			note = new NoteBitmap();
			note.x = int(Math.random() * 562) + 100; note.y = int(Math.random() * 372) + 100;
			dx = dy = 5 + (int(Math.random() * 4) - 2);
			
			addChild(note);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			if (note.x < 0 || note.x > 762) {
				dx *= -1;
				BGSExternalInterface.call((this.parent as Main).BGSCodeObj,"playSound","_DemoscenePolyseqPing");
			}
			if (note.y < 0 || note.y > 572) {
				dy *= -1;
				BGSExternalInterface.call((this.parent as Main).BGSCodeObj,"playSound","_DemoscenePolyseqPing");
			}
			
			note.x += dx; note.y += dy;
		}
		
	}

}