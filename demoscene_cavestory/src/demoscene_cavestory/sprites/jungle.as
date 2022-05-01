package demoscene_cavestory.sprites 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class jungle extends Sprite 
	{
		[Embed(source = "../../img/jungle.png")] private var junglesprite:Class;
		
		public function jungle() 
		{
			super();
			this.addChild(new junglesprite());
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			this.x -= 5;
			if (this.x < -1536) {
				this.parent.removeChild(this);
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
	}

}