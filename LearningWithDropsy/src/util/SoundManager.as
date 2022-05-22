package util 
{
	import Shared.BGSExternalInterface;
	import bhvr.constants.GameConfig;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class SoundManager 
	{
		
		public static function playSound(BGSCodeObj:Object, Sound:uint):void {
			BGSExternalInterface.call(BGSCodeObj,"playRegisteredSound",Sound);
		}
		
		public static function stopSound(BGSCodeObj:Object, Sound:uint):void {
			BGSExternalInterface.call(BGSCodeObj,"stopRegisteredSound",Sound);
		}
		
		public static function playSfx(BGSCodeObj:Object, Sound:String):void {
			BGSExternalInterface.call(BGSCodeObj, "playSound", Sound);
		}
		
		public static function playMainTheme(BGSCodeObj:Object):void {
			playSound(BGSCodeObj, GameConfig.GAME_THEME_ID);
		}
		
		public static function playQuestion(BGSCodeObj:Object):void {
			playSound(BGSCodeObj, GameConfig.SFX_QUESTION_ID);
		}
		
		public static function playRoundYes(BGSCodeObj:Object):void {
			playSound(BGSCodeObj, GameConfig.SFX_ROUNDYES_ID);
		}
		
		public static function playRoundNo(BGSCodeObj:Object):void {
			playSound(BGSCodeObj, GameConfig.SFX_ROUNDNO_ID);
		}
		
		public static function playWin(BGSCodeObj:Object):void {
			playSound(BGSCodeObj, GameConfig.SFX_WIN_ID);
		}
		
		public static function playLose(BGSCodeObj:Object):void {
			playSound(BGSCodeObj, GameConfig.SFX_LOSE_ID);
		}
		
		public static function playWalk(BGSCodeObj:Object):void {
			playSound(BGSCodeObj, GameConfig.SFX_WALK_ID);
		}
		
		public static function stopWalk(BGSCodeObj:Object):void {
			stopSound(BGSCodeObj, GameConfig.SFX_WALK_ID);
		}
		
		public static function playPop(BGSCodeObj:Object):void {
			playSfx(BGSCodeObj, GameConfig.SFX_POP);
		}
		
	}

}