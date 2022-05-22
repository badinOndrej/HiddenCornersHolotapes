package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import util.SoundManager;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class TextScreen extends Sprite 
	{
		[Embed(source = "../fonts/Organic Relief.ttf", fontName = "gameFont", mimeType = "application/x-font", advancedAntiAliasing = "true", embedAsCFF = "false")] private const GameFont:Class;
		
		private var text:TextField;
		private var mode:int;
		
		public var isFinished:Boolean;
		
		/**
		 * Constructor - select mode
		 * @param	mode	0 - ROUND YES, 1 - ROUND NO, 2 - GAME WIN, 3 - GAME OVER
		 */
		public function TextScreen(mode:int) 
		{
			super();
			
			this.mode = mode;
			
			this.isFinished = false;
			
			this.text = new TextField();
			this.text.embedFonts = true;
			this.text.defaultTextFormat = new TextFormat("gameFont", 80, 0xfffF8800);
			
			addChild(this.text);
		}
		
		public function startActionFromParent():void {
			switch(this.mode) {
				case 0:
					this.text.text = "CORRECT"
					SoundManager.playRoundYes((this.parent as Main).BGSCodeObj);
					break;
				case 1:
					this.text.text = "WRONG"
					SoundManager.playRoundNo((this.parent as Main).BGSCodeObj);
					break;
				case 2:
					this.text.text = "WELL DONE!"
					SoundManager.playWin((this.parent as Main).BGSCodeObj);
					break;
				case 3:
					this.text.text = "GAME OVER";
					SoundManager.playLose((this.parent as Main).BGSCodeObj);
					break;
				default:
					break;
			}
			
			this.text.width = this.text.textWidth + 10;
			this.text.height = this.text.textHeight;
			this.text.x = 413 - this.text.textWidth / 2;
			this.text.y = 350 - this.text.textHeight / 2;
			
			
			
			var t:Timer = new Timer(3000, 1);
			t.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
				isFinished = true;
			});
			t.start();
		}
		
	}

}