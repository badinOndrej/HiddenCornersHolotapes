package screens 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import objects.Dropsy;
	import util.SoundManager;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class IntroScreen extends Sprite 
	{
		[Embed(source = "../img/title.png")] public const TitleBmp:Class;
		
		private var dropsy:Dropsy;
		private var title:Bitmap;
		
		public function IntroScreen() 
		{
			super();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private var introStage:int = 0;
		private var frameCount:int = 0;
		private var showTimerFinished:Boolean = false;
		
		public var introDone:Boolean = false;
		
		private function onEnterFrame(e:Event):void {
			switch(introStage) {
				case 0:
					this.dropsy = new Dropsy(true);
					dropsy.x = 1000; dropsy.y = 350;
					addChild(dropsy);
					
					SoundManager.playWalk((this.parent as Main).BGSCodeObj);
					
					introStage++;
					break;
				case 1:
					if (this.dropsy.introDone) {
						SoundManager.stopWalk((this.parent as Main).BGSCodeObj);
						
						this.title = new TitleBmp();
						this.title.scaleX = 2;
						this.title.scaleY = 2;
						this.title.y = -300;
						this.title.x = 413 - (this.title.width / 2)
						addChild(this.title);
						introStage++;
					}
					break;
				case 2:
					if (this.title.y < 100) {
						this.title.y += 10;
					} else {
						this.introStage++;
						
						var t:Timer = new Timer(6000, 1);
						t.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
							showTimerFinished = true;
						});
						t.start();
						
						SoundManager.playMainTheme((this.parent as Main).BGSCodeObj);
					}
					break;
				case 3:
					if (showTimerFinished) this.introStage++
					break;
				case 4:
					this.introDone = true;
					break;
			}
		}
		
	}

}