package objects 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import util.MathLib;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class Dropsy extends Sprite 
	{
		
		[Embed(source = "../img/dropsy.png")] private const DropsyBmp:Class;
		
		private var dropsy:Bitmap;
		
		public function Dropsy(intro:Boolean) 
		{
			super();
			
			this.dropsy = new DropsyBmp();
			this.dropsy.x = -64; this.dropsy.y = -128;
			addChild(this.dropsy);
			
			if (intro) {
				addEventListener(Event.ENTER_FRAME, onIntroEnterFrame);
			} else {
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		private var animFrame:Number = 0;
		private function bounceAnim():void {
			this.scaleY = MathLib.remap(Math.abs(Math.sin((this.animFrame * 36) * Math.PI / 180)), 0.0, 1.0, 0.8, 1.0);
			animFrame = (animFrame + 0.5) % 10;
		}
		
		private function onEnterFrame(e:Event):void {
			bounceAnim();
		}
		
		private var introStage:int = 0;
		
		public var introDone:Boolean = false;
		
		private function onIntroEnterFrame(e:Event):void {
			switch(introStage) {
				case 0:
					// init - enter stage
					this.x = 1000;
					this.introStage++;
					break;
				case 1:
					// begin - enter stage
					if (this.x > 413) {
						this.x -= 5;
						bounceAnim();
					} else this.introStage++;
					break;
				case 2:
					if (this.y < 650) {
						this.y += 5;
						bounceAnim();
					} else this.introStage++;
					break;
				case 3:
					this.animFrame = 7.5;
					bounceAnim();
					this.introStage++;
					break;
				case 4:
					this.introDone = true;
					this.introStage++;
					removeEventListener(Event.ENTER_FRAME, onIntroEnterFrame);
					break;
			}
		}
		
	}

}