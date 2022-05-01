package demoscene_cavestory.sprites 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class mammooth extends Sprite 
	{
		
		[Embed(source = "../../img/mammooth.png")] private var mammoothsprite:Class;
		
		public function mammooth() 
		{
			super();
			this.addChild(new mammoothsprite());
			this.getChildAt(0).rotationY = (Math.random() < 0.3 ? 180 : 0);
			if (this.getChildAt(0).rotationY == 180) this.getChildAt(0).x += this.getChildAt(0).width;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			this.x -= 5.5;
			if (this.x < -2048) {
				this.parent.removeChild(this);
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
	}

}