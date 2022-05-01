package
{
	import Shared.BGSExternalInterface;
	import bhvr.interfaces.IExternalCommunication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class Main extends Sprite implements IExternalCommunication
	{
		
		[Embed(source = "img/cursor.png")] private var cursor:Class;
		
		private var tip_x:int, tip_y:int;
		private var dir_x:int, dir_y:int;
		private const speed:int = 2;
		
		private var pointer:Bitmap;
		
		public var BGSCodeObj:Object;
		public var IsMiniGame:Boolean = true;
		public var UseOwnCursor:Boolean = false;
		
		public function Main() 
		{
			this.BGSCodeObj = new Object();
			
			tip_x = 413;
			tip_y = 350;
			stage.stageFocusRect = false;
			
			pointer = new cursor();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.focus = this;
			clearScreen();
			movePointer(tip_x, tip_y);
			this.addChild(pointer);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function ProcessUserEvent(strEventName:String, abPressed:Boolean):Boolean {
			return false;
		}
		
		public function InitProgram():void {
			
		}
		
		public function SetHighscore(highscore:int):void {
			
		}
		
		private function movePointer(x:int, y:int):void {
			pointer.x = x - (pointer.width / 2) + 1;
			pointer.y = y - (pointer.height / 2) + 1;
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case Keyboard.LEFT:
					BGSExternalInterface.call(this.BGSCodeObj,"playLeftAnim");
					dir_x = -1;
					break;
				case Keyboard.RIGHT:
					BGSExternalInterface.call(this.BGSCodeObj,"playRightAnim");
					dir_x = 1;
					break;
				case Keyboard.UP:
					BGSExternalInterface.call(this.BGSCodeObj,"playLeftAnim");
					dir_y = -1;
					break;
				case Keyboard.DOWN:
					BGSExternalInterface.call(this.BGSCodeObj,"playRightAnim");
					dir_y = 1;
					break;
				case Keyboard.SPACE:
					BGSExternalInterface.call(this.BGSCodeObj,"playActionAnim");
					clearScreen();
					break;
				default:
					break;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case Keyboard.LEFT:
				case Keyboard.RIGHT:
					dir_x = 0;
					break;
				case Keyboard.UP:
				case Keyboard.DOWN:
					dir_y = 0;
					break;
				case Keyboard.SPACE:
					clearScreen();
					break;
				default:
					break;
			}
		}
		
		private function clearScreen():void {
			graphics.clear()
			graphics.beginFill(0xff808080);
			graphics.drawRect(0, 0, 826, 700);
			graphics.endFill();
		}
		
		private function drawPoint(x:int, y:int):void {
			graphics.beginFill(0xff000000);
			graphics.drawRect(x, y, 2, 2);
			graphics.endFill();
		}
		
		private function onEnterFrame(e:Event):void {
			movePointer(tip_x, tip_y);
			drawPoint(tip_x, tip_y);
			
			tip_x += dir_x * speed;
			tip_y += dir_y * speed;
			
			if (tip_x >= 826) tip_x = 825;
			if (tip_x <= 0) tip_x = 0;
			if (tip_y >= 700) tip_y = 699;
			if (tip_y <= 0) tip_y = 0;
		}
		
		public function ConfirmQuit() : void
		{
			BGSExternalInterface.call(this.BGSCodeObj,"closeHolotape");
		}
		
	}
	
}