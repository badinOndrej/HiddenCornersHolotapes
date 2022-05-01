package sprites 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class PolyseqLogo extends Sprite 
	{
		
		public function PolyseqLogo() 
		{
			super();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private var fnum:int = 0;
		
		private function onEnterFrame(e:Event):void {
			if (numChildren < 10) {
				if (fnum == 0) {
					var tmpelement:LogoElement = new LogoElement();
					tmpelement.x = 413; tmpelement.y = 350;
					this.addChild(tmpelement);
				}
				
				fnum = (fnum + 1) % 4;
			}
		}
	}

}