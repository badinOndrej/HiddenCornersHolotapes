package demoscene_cavestory.sprites 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Animated caveman
	 * Walk cycle
	 * @author Ondrej Badin
	 */
	public class caveman extends Sprite 
	{
		// load frame images
		[Embed(source = "../../img/caveman0001.png")] private var Frame1:Class;
		[Embed(source = "../../img/caveman0002.png")] private var Frame2:Class;
		[Embed(source = "../../img/caveman0003.png")] private var Frame3:Class;
		[Embed(source = "../../img/caveman0004.png")] private var Frame4:Class;
		[Embed(source = "../../img/caveman0005.png")] private var Frame5:Class;
		[Embed(source = "../../img/caveman0006.png")] private var Frame6:Class;
		[Embed(source = "../../img/caveman0007.png")] private var Frame7:Class;
		[Embed(source = "../../img/caveman0008.png")] private var Frame8:Class;
		[Embed(source = "../../img/caveman0009.png")] private var Frame9:Class;
		[Embed(source = "../../img/caveman0010.png")] private var Frame10:Class;
		[Embed(source = "../../img/caveman0011.png")] private var Frame11:Class;
		[Embed(source = "../../img/caveman0012.png")] private var Frame12:Class;
		[Embed(source = "../../img/caveman0013.png")] private var Frame13:Class;
		[Embed(source = "../../img/caveman0014.png")] private var Frame14:Class;
		[Embed(source = "../../img/caveman0015.png")] private var Frame15:Class;
		[Embed(source = "../../img/caveman0016.png")] private var Frame16:Class;
		[Embed(source = "../../img/caveman0017.png")] private var Frame17:Class;
		[Embed(source = "../../img/caveman0018.png")] private var Frame18:Class;
		[Embed(source = "../../img/caveman0019.png")] private var Frame19:Class;
		[Embed(source = "../../img/caveman0020.png")] private var Frame20:Class;
		[Embed(source = "../../img/caveman0021.png")] private var Frame21:Class;
		[Embed(source = "../../img/caveman0022.png")] private var Frame22:Class;
		[Embed(source = "../../img/caveman0023.png")] private var Frame23:Class;
		
		// returns apropriate bitmap for each frame index
		private function getFrame(f:int):Bitmap {
			switch(f) {
				default:
					return null;
				case 0:
					return new Frame1;
				case 1:
					return new Frame2;
				case 2:
					return new Frame3;
				case 3:
					return new Frame4;
				case 4:
					return new Frame5;
				case 5:
					return new Frame6;
				case 6:
					return new Frame7;
				case 7:
					return new Frame8;
				case 8:
					return new Frame9;
				case 9:
					return new Frame10;
				case 10:
					return new Frame11;
				case 11:
					return new Frame12;
				case 12:
					return new Frame13;
				case 13:
					return new Frame14;
				case 14:
					return new Frame15;
				case 15:
					return new Frame16;
				case 16:
					return new Frame17;
				case 17:
					return new Frame18;
				case 18:
					return new Frame19;
				case 19:
					return new Frame20;
				case 20:
					return new Frame21;
				case 21:
					return new Frame22;
				case 22:
					return new Frame23;
			}
		}
		
		// frame counter
		private var f:int = 0; 
		
		private function advance():void {
			// remove all children
			this.removeAllChildren();
			
			// add and center child
			this.addChild(getFrame(f));
			
			this.getChildAt(0).x = -128;
			this.getChildAt(0).y = -256;
			this.getChildAt(0).scaleX = 2;
			this.getChildAt(0).scaleY = 2;
			
			// advance frame counter
			f = (f + 1) % 23;
		}
		
		public function caveman() 
		{
			super();
			
			// initialize animation timer
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		private function onEnterFrame(ev:Event):void {
			this.advance();
		}
		
		private function removeAllChildren():void {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
		}
		
	}

}