package
{
	import bhvr.interfaces.IExternalCommunication;
	import bhvr.constants.GameConfig;
	import Shared.BGSExternalInterface;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import sprites.BorderSprite;
	import sprites.Note;
	import sprites.PolyseqLogo;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class Main extends Sprite implements IExternalCommunication
	{
		[Embed(source = "fonts/ShareTechMono-Regular.ttf", fontName = "gameFont", mimeType = "application/x-font", advancedAntiAliasing = "true", embedAsCFF = "false")]
		private const gameFont:Class;
		
		public var BGSCodeObj:Object;
		public var IsMiniGame:Boolean = true;
		public var UseOwnCursor:Boolean = false;
		
		public function Main() 
		{
			this.BGSCodeObj = new Object();
			stage.stageFocusRect = false;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, dispose);
		}
		
		public function dispose( event:Event ):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, dispose);
		}
		
		public function ProcessUserEvent(strEventName:String, abPressed:Boolean):Boolean {
			return false;
		}
		
		public function InitProgram():void {
			BGSExternalInterface.call(this.BGSCodeObj,"registerSound",GameConfig.GAME_THEME);
		}
		
		public function SetHighscore(highscore:int):void {
			
		}
		
		private var fnum:int = 0;
		private var text:TextField;
		
		private function onEnterFrame(e:Event):void {
			switch(fnum) {
				case 30:
					BGSExternalInterface.call(this.BGSCodeObj,"playRegisteredSound",GameConfig.GAME_THEME_ID);
					addChild(new PolyseqLogo());
					addChild(new BorderSprite());
					break;
				case 200:
					removeChildAt(0);
					
					addChild(new Note());
					addChild(new Note());
					addChild(new Note());
					
					text = new TextField();
					text.embedFonts = true;
					text.defaultTextFormat = new TextFormat("gameFont", 40, 0xffffffff);
					text.text = "NO SynTeq™ HARDWARE DETECTED";
					text.width = text.textWidth + 10;
					text.height = text.textHeight;
					text.x = 413 - text.width / 2;
					text.y = 350 - text.height / 2;
					addChild(text);
			}
			fnum++;
		}
		
		public function ConfirmQuit() : void
		{
			BGSExternalInterface.call(this.BGSCodeObj,"closeHolotape");
		}
		
	}
	
}