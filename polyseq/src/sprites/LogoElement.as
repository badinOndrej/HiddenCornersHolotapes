package sprites 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class LogoElement extends Sprite 
	{
		
		[Embed(source = "../img/logo.png")] private const Logo:Class;
		
		private var logoSprite:Bitmap;
		
		public function LogoElement() 
		{
			super();
			
			logoSprite = new Logo();
			logoSprite.x = -298.5; logoSprite.y = -225;
			this.z = -1500;
			addChild(logoSprite);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			if(this.z < 500) {
				this.z += 50;
			}
		}
		
	}

}