package demoscene_cavestory.sprites 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class clouds extends Sprite 
	{
		
		[Embed(source = "../../img/clouds.png")] private var cloudSprite:Class;
		
		private var c1:Bitmap = new cloudSprite();
		private var c2:Bitmap = new cloudSprite();
		
		private var speed:Number = 0;
		
		public function clouds(speed:Number) 
		{
			super();
			
			this.speed = speed;
			
			c1.scaleX = 2; c1.scaleY = 2;
			c2.scaleX = 2; c2.scaleY = 2;
			c1.x -= 826;
			
			this.addChild(c1); this.addChild(c2);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		private function onEnterFrame(e:Event):void {
			c1.x -= this.speed;
			c2.x -= this.speed;
			
			if (c1.x < -826) {
				c1.x += (826 * 2);
			}
			if (c2.x < -826) {
				c2.x += (826 * 2);
			}
		}
		
	}

}