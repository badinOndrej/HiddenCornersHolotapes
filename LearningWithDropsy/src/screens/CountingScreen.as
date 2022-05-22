package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import objects.Dropsy;
	import util.SoundManager;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class CountingScreen extends Sprite 
	{
		[Embed(source = "../fonts/Organic Relief.ttf", fontName = "gameFont", mimeType = "application/x-font", advancedAntiAliasing = "true", embedAsCFF = "false")] private const GameFont:Class;
		
		private const grid:Array = [
			[165, 150], [165 * 2, 150], [165 * 3, 150], [165 * 4, 150],
			[165, 300], [165 * 2, 300], [165 * 3, 300], [165 * 4, 300]
		]
		
		private var dropsyCount:int;
		private var dropsyMaxCount:int;
		
		public function CountingScreen() 
		{
			super();
			
			this.dropsyCount = 0;
			this.dropsyMaxCount = int(Math.random() * 8) + 1;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public var canInput:Boolean = false;
		public var numberDisplay:TextField;
		
		private var frame:int = 1;
		private function onEnterFrame(e:Event):void {
			if (dropsyCount < dropsyMaxCount) {
				if (frame == 0) {
					SoundManager.playPop((this.parent as Main).BGSCodeObj);
					
					var tmp:Dropsy = new Dropsy(false);
					tmp.x = grid[dropsyCount][0]; tmp.y = grid[dropsyCount][1];
					addChild(tmp); dropsyCount++;
				}
				this.frame = (this.frame + 1) % 8;
			} else {
				this.numberDisplay = new TextField();
				this.numberDisplay.embedFonts = true;
				this.numberDisplay.defaultTextFormat = new TextFormat("gameFont", 100, 0xffff8800, false, false, false, "", "", TextFormatAlign.CENTER);
				this.numberDisplay.x = 413;
				this.numberDisplay.y = 420;
				addChild(this.numberDisplay);
				this.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				this.canInput = true;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		public var isCorrectAnswer:Boolean = false;
		public var isAnswered:Boolean = false;
		
		private function onKeyUp(e:KeyboardEvent):void {
			var correctKey:Boolean = false;
			var numInput:int = 0;
			switch(e.keyCode) {
				case Keyboard.NUMBER_1:
				case Keyboard.NUMPAD_1:
					this.numberDisplay.text = "1";
					numInput = 1;
					correctKey = true;
					break;
				case Keyboard.NUMBER_2:
				case Keyboard.NUMPAD_2:
					this.numberDisplay.text = "2";
					numInput = 2;
					correctKey = true;
					break;
				case Keyboard.NUMBER_3:
				case Keyboard.NUMPAD_3:
					this.numberDisplay.text = "3";
					numInput = 3;
					correctKey = true;
					break;
				case Keyboard.NUMBER_4:
				case Keyboard.NUMPAD_4:
					this.numberDisplay.text = "4";
					numInput = 4;
					correctKey = true;
					break;
				case Keyboard.NUMBER_5:
				case Keyboard.NUMPAD_5:
					this.numberDisplay.text = "5";
					numInput = 5;
					correctKey = true;
					break;
				case Keyboard.NUMBER_6:
				case Keyboard.NUMPAD_6:
					this.numberDisplay.text = "6";
					numInput = 6;
					correctKey = true;
					break;
				case Keyboard.NUMBER_7:
				case Keyboard.NUMPAD_7:
					this.numberDisplay.text = "7";
					numInput = 7;
					correctKey = true;
					break;
				case Keyboard.NUMBER_8:
				case Keyboard.NUMPAD_8:
					this.numberDisplay.text = "8";
					numInput = 8;
					correctKey = true;
					break;
				default:
					break;
			}
			if(correctKey) {
				this.numberDisplay.height = this.numberDisplay.textHeight;
				this.numberDisplay.width = this.numberDisplay.textWidth + 10;
				this.numberDisplay.x = 413 - this.numberDisplay.textWidth / 2;
				this.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				
				isCorrectAnswer = numInput === dropsyMaxCount;
				
				var t:Timer = new Timer(1500, 1);
				t.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
					isAnswered = true;
				});
				t.start();
			}
		}
		
	}

}