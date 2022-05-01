package demoscene_cavestory.sprites 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class volcano extends Sprite 
	{
		[Embed(source = "../../img/volcano11.png")] private var volcano11:Class;
		[Embed(source = "../../img/volcano12.png")] private var volcano12:Class;
		[Embed(source = "../../img/volcano21.png")] private var volcano21:Class;
		[Embed(source = "../../img/volcano22.png")] private var volcano22:Class;
		
		private var typetwo:Boolean;
		private var frames:int;
		private var frameIndex:int;
		private var currFrame:Bitmap;
		
		public function volcano() 
		{
			super();
			
			typetwo = (Math.random() < 0.5);
			
			frames = 0;
			frameIndex = 0;
			
			currFrame = typetwo ? new volcano21() : new volcano11();
			
			this.addChild(currFrame);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			frames++;
			if (frames == 10) {
				currFrame = frameIndex == 0 ? (typetwo ? new volcano21() : new volcano11()) : (typetwo ? new volcano22() : new volcano12());
				while (this.numChildren > 0) this.removeChildAt(0);
				this.addChild(currFrame);
				frameIndex = (frameIndex + 1) % 2;
				frames = 0;
			}
			this.x -= 2;
			if (this.x < -1536) {
				this.parent.removeChild(this);
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
	}

}