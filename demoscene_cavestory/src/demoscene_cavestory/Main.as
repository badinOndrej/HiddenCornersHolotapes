package demoscene_cavestory
{
	import bhvr.interfaces.IExternalCommunication;
	import bhvr.constants.GameConfig;
	import Shared.BGSExternalInterface;
	import demoscene_cavestory.sprites.caveman;
	import demoscene_cavestory.sprites.clouds;
	import demoscene_cavestory.sprites.ground;
	import demoscene_cavestory.sprites.spawner;
	import demoscene_cavestory.sprites.volcano;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class Main extends Sprite implements IExternalCommunication
	{
		
		[Embed(source = "../img/sky.png")] private var sky:Class;
		[Embed(source = "../img/cave.png")] private var cave:Class;
		[Embed(source = "../img/cave2.png")] private var cave2:Class;
		
		[Embed(source="../fonts/04B_30__.TTF", fontName="gameFont", mimeType="application/x-font", advancedAntiAliasing="true", embedAsCFF="false")]
		private var gameFont:Class;
		
		public var BGSCodeObj:Object;
		public var IsMiniGame:Boolean = true;
		public var UseOwnCursor:Boolean = false;
		
		public function Main() 
		{
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
		
		private var frameCounter:Number;
		private var cav1:Bitmap;
		private var cav2:Bitmap;
		private var spawn_v:spawner;
		private var spawn_j:spawner;
		private var spawn_p:spawner;
		
		private var introText:TextField;
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var cman:caveman = new caveman();
			var grnd:ground = new ground();
			var cld1:clouds = new clouds(1);
			var cld2:clouds = new clouds(1.5);
			var cld3:clouds = new clouds(2);
			this.cav1 = new cave();
			this.cav2 = new cave2();
			
			this.addChild(new sky());
			
			this.addChild(cld1);
			
			this.addChild(cld2);
			cld2.y = -37.5;
			
			this.addChild(cld3);
			cld3.y = -75;
			
			this.spawn_v = new spawner();
			this.spawn_v.x = 826;
			this.spawn_v.setState(2);
			this.addChild(spawn_v);
			
			this.spawn_j = new spawner();
			this.spawn_j.x = 826;
			this.spawn_j.setState(1);
			this.addChild(spawn_j);
			
			this.spawn_p = new spawner();
			this.spawn_p.x = 826;
			this.spawn_p.setState(3);
			this.addChild(spawn_p);
			
			this.addChild(cman);
			cman.x = 413; cman.y = 450;
			
			this.addChild(grnd);
			grnd.x = 413; grnd.y = 448;
			
			cav1.scaleX = 2.5; cav1.scaleY = 2.5;
			this.addChild(cav1);
			cav2.scaleX = 2.5; cav2.scaleY = 2.5; cav2.x = 1125;
			this.addChild(cav2);
			
			var edgemask:Sprite = new Sprite();
			edgemask.graphics.beginFill(0xff000000);
			edgemask.graphics.drawRect( -1000, 0, 1000, 700);
			edgemask.graphics.drawRect(826, 0, 1000, 700);
			edgemask.graphics.endFill();
			this.addChild(edgemask);
			
			introText = new TextField();
			introText.embedFonts = true;
			introText.defaultTextFormat = new TextFormat("gameFont", 40, 0xffffffff);
			introText.filters.push(new DropShadowFilter());
			introText.text = "Jane Adams presents";
			introText.width = introText.textWidth + 10;
			introText.x = 413 - introText.width / 2;
			introText.y = 350;
			this.addChild(introText);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.frameCounter = 0;
			
			
		}
		
		private var showCav1:Boolean = true;
		
		private var tCaveExit:Timer;
		private var tCaveEnter:Timer;
		
		private function exitCave(e:TimerEvent):void {
			this.cav1.x -= 8;
			if (this.cav1.x < this.cav1.width * -2.5) {
				this.removeChild(this.cav1);
				this.tCaveExit.stop();
			}
		}
		
		private function enterCave(e:TimerEvent):void {
			this.cav2.x -= 8;
			if (this.cav2.x < -270) {
				this.tCaveEnter.stop();
			}
		}
		
		private function onEnterFrame(e:Event):void {
			switch(frameCounter) {
				case 0:
					BGSExternalInterface.call(this.BGSCodeObj,"playRegisteredSound",GameConfig.GAME_THEME_ID);
					break;
				case 120:
					// exit cave to empty plains
					tCaveExit = new Timer(33.33333, 0);
					tCaveExit.addEventListener(TimerEvent.TIMER, exitCave);
					tCaveExit.start();
					introText.text = "CAVEMAN STORY";
					introText.width = introText.textWidth + 10;
					introText.x = 413 - introText.width / 2;
					break;
				case 400:
					this.removeChild(introText);
					break;
				case 500:
					// jungle
					this.spawn_j.setSpawning(true);
					break;
				case 740:
					// volcanoes
					this.spawn_v.setSpawning(true);
					break;
				case 800:
					// stop jungle
					this.spawn_j.setSpawning(false);
					break;
				case 1320:
					// jungle, stop volcanoes
					this.spawn_v.setSpawning(false);
					this.spawn_j.setSpawning(true);
					break;
				case 1560:
					// plains
					this.spawn_j.setSpawning(false);
					this.spawn_p.setSpawning(true);
					break;
				case 1860:
					// jungle
					this.spawn_p.setSpawning(false);
					this.spawn_j.setSpawning(true);
					break;
				case 1900:
					this.spawn_v.setSpawning(true);
					break;
				case 2000:
					// volcanoes
					this.spawn_j.setSpawning(false);
					break;
				case 2340:
					// empty plains
					this.spawn_v.setSpawning(false);
					break;
				case 2670:
					// enter cave
					tCaveEnter = new Timer(33.33333, 0);
					tCaveEnter.addEventListener(TimerEvent.TIMER, enterCave);
					tCaveEnter.start();
					break;
				case 2800:
					// end
					this.addChild(introText);
					introText.text = "The End";
					introText.width = introText.textWidth + 10;
					introText.x = 413 - introText.width / 2;
					break;
				default:
					break;
			}
			
			this.frameCounter++;
		}
		
	}
	
}