package
{
	import bhvr.interfaces.IExternalCommunication;
	import bhvr.constants.GameConfig;
	import flash.display.Sprite;
	import flash.events.Event;
	import objects.Dropsy;
	import screens.CountingScreen;
	import screens.IntroScreen;
	import Shared.BGSExternalInterface;
	import screens.TextScreen;
	import util.SoundManager;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class Main extends Sprite implements IExternalCommunication
	{
		
		public var BGSCodeObj:Object;
		public var IsMiniGame:Boolean = true;
		public var UseOwnCursor:Boolean = false;
		
		public function Main() 
		{
			stage.stageFocusRect = false;
			
			this.BGSCodeObj = new Object();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.REMOVED_FROM_STAGE, dispose);
		}
		
		public function dispose( event:Event ):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, dispose);
		}
		
		/**
		 * used for program initialization by FO4 engine itself
		 * place things like long sound registrations in here
		 */
		public function InitProgram():void {
			BGSExternalInterface.call(this.BGSCodeObj, "registerSound", GameConfig.GAME_THEME);
			BGSExternalInterface.call(this.BGSCodeObj, "registerSound", GameConfig.SFX_QUESTION);
			BGSExternalInterface.call(this.BGSCodeObj, "registerSound", GameConfig.SFX_ROUNDYES);
			BGSExternalInterface.call(this.BGSCodeObj, "registerSound", GameConfig.SFX_ROUNDNO);
			BGSExternalInterface.call(this.BGSCodeObj, "registerSound", GameConfig.SFX_WIN);
			BGSExternalInterface.call(this.BGSCodeObj, "registerSound", GameConfig.SFX_LOSE);
			BGSExternalInterface.call(this.BGSCodeObj, "registerSound", GameConfig.SFX_WALK);
		}
		
		public function SetHighscore(highscore:int):void {
			// do nothing
		}
		
		public function ProcessUserEvent(strEventName:String, abPressed:Boolean):Boolean {
			return false;
		}
		
		public function ConfirmQuit():void {
			BGSExternalInterface.call(this.BGSCodeObj, "closeHolotape");
		}
		
		private var gameStage:int;
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			gameStage = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private var introscreen:IntroScreen;
		private var countingscreen:CountingScreen;
		private var textscreen:TextScreen;
		private var numrounds:int;
		private var numlives:int;
		
		// game stages
		// 0 - intro
		// 1 - show game screen
		// 2 - wait for game screen to initialize, then give control
		// 3 - wait for game screen to yield control then analyze the result and show text screen
		// 4 - wait for text screen to finish then anaylze the game and move to apropriate stage
		// 5 - game win
		// 6 - game lose
		// 7 - wait for the game over screen to finish and loop back to the intro
		
		private function onEnterFrame(e:Event):void {
			switch(gameStage) {
				case 0:
					this.numrounds = 10;
					this.numlives = 3;
					this.introscreen = new IntroScreen();
					addChild(this.introscreen);
					gameStage++;
					break;
				case 1:
					if (this.introscreen.introDone) {
						try {
							removeChild(this.introscreen);
						} catch (e:Error) {
							trace(e.name, e.message);
						}
						this.countingscreen = new CountingScreen();
						addChild(this.countingscreen);
						SoundManager.playQuestion(this.BGSCodeObj);
						gameStage++;
					}
					break;
				case 2:
					if (this.countingscreen.canInput) {
						stage.focus = this.countingscreen;
						gameStage++;
					}
					break;
				case 3:
					if (this.countingscreen.isAnswered) {
						removeChild(this.countingscreen);
						numrounds--;
						if (this.countingscreen.isCorrectAnswer) {
							this.textscreen = new TextScreen(0);
						} else {
							numlives--;
							this.textscreen = new TextScreen(1);
						}
						this.addChild(this.textscreen);
						this.textscreen.startActionFromParent();
						gameStage++;
					}
					break;
				case 4:
					if (this.textscreen.isFinished) {
						removeChild(this.textscreen);
						if(this.numlives > 0) {
							if (numrounds > 0) gameStage = 1;
							else gameStage = 5;
						} else gameStage = 6;
					}
					break;
				case 5:
					this.textscreen = new TextScreen(2);
					addChild(this.textscreen);
					this.textscreen.startActionFromParent();
					gameStage = 7;
					break;
				case 6:
					this.textscreen = new TextScreen(3);
					addChild(this.textscreen);
					this.textscreen.startActionFromParent();
					gameStage = 7;
					break;
				case 7:
					if (this.textscreen.isFinished) {
						removeChild(this.textscreen);
						gameStage = 0;
					}
			}
		}
		
	}
	
}