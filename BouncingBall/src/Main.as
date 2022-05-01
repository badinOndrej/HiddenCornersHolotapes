package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class Main extends Sprite 
	{
		
		private var xx:int, dir:int;
		
		public function Main() 
		{
			xx = 50;
			dir = 1;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function rerange(oldVal:int, oldMin:int, oldMax:int, newMin:int, newMax:int):int {
			return (((oldVal - oldMin) * (newMax - newMin)) / (oldMax - oldMin)) + newMin;
		}
		
		private function onEnterFrame(e:Event):void {
			if (xx <= 0) dir *= -1;
			if (xx >= 360) dir *= -1;
			xx = xx + (5 * dir);
			var xx2:int = rerange(xx, 0, 359, 0, 826);
			var yy:int = (Math.abs(Math.sin(xx / 180 * Math.PI)) * -550) + 600;
			graphics.clear();
			graphics.beginFill(0xffFAFAFA);
			graphics.drawCircle(xx2, yy, 30);
			graphics.endFill();
		}
		
	}
	
}