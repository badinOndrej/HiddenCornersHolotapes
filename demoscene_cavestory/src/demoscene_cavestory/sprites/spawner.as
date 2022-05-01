package demoscene_cavestory.sprites 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class spawner extends Sprite 
	{		
		// 0 - nothing, 1 - jungle, 2 - volcanoes, 3 - plains
		private var state:int;
		private var frame:int;
		private var spawning:Boolean;
		
		public function spawner() 
		{
			super();
			state = 0;
			frame = 0;
			spawning = false;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * Sets new spawner state
		 * @param	newState 0 - nothing, 1 - jungle, 2 - volcanoes, 3 - plains
		 */
		public function setState(newState:int):void {
			state = newState % 4;
		}
		
		public function setSpawning(spawning:Boolean):void {
			this.spawning = spawning;
		}
		
		private function onEnterFrame(e:Event):void {
			if(spawning)
				switch(state) {
					case 1:
						if (frame == 0) {
							var j:jungle = new jungle();
							j.scaleX = 2; j.scaleY = 2;
							this.addChild(j);
						}
						frame = (frame + 1) % (25 + (int(Math.random() * 2)));
						break;
					case 2:
						if (frame == 0) {
							var v:volcano = new volcano();
							v.scaleX = 2; v.scaleY = 2;
							this.addChild(v);
						}
						frame = (frame + 1) % (int(Math.random() * 15) + 25);
						break;
					case 3:
						if (frame == 0) {
							var m:mammooth = new mammooth();
							m.scaleX = 3; m.scaleY = 3;
							m.y += 90;
							this.addChild(m);
						}
						frame = (frame + 1) % (60 + int(Math.random() * 5));
						break;
					default:
						break;
				}
		}
		
	}

}