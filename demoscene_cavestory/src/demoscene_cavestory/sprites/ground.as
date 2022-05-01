package demoscene_cavestory.sprites 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ondrej Badin
	 */
	public class ground extends Sprite 
	{
		[Embed(source = "../../img/cartoon_grass.png")] private var groundSprite:Class;
		
		private function spawnNewGround():Bitmap {
			var x:Bitmap = new groundSprite();
			x.scaleX = 2; x.scaleY = 2;
			x.x = -256;
			//x.y = 256;
			return x;
		}
		
		private var g1:Bitmap = spawnNewGround();
		private var g2:Bitmap = spawnNewGround();
		private var g3:Bitmap = spawnNewGround();
		private var g4:Bitmap = spawnNewGround();
		private var g5:Bitmap = spawnNewGround();
		private var g6:Bitmap = spawnNewGround();
		
		public function ground() 
		{
			super();
			this.addChild(g1); this.addChild(g2); this.addChild(g3); this.addChild(g4); this.addChild(g5); this.addChild(g6);
			
			g1.x -= 512; g3.x += 512; g4.x += 1024; g5.x += 1536; g6.x += 2048;
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			g1.x -= 8;
			g2.x -= 8;
			g3.x -= 8;
			g4.x -= 8;
			g5.x -= 8;
			g6.x -= 8;
			
			if (g1.x <= -1536) {
				g1.x = 1536;
			}
			if (g2.x <= -1536) {
				g2.x = 1536;
			}
			if (g3.x <= -1536) {
				g3.x = 1536;
			}
			if (g4.x <= -1536) {
				g4.x = 1536;
			}
			if (g5.x <= -1536) {
				g5.x = 1536;
			}
			if (g6.x <= -1536) {
				g6.x = 1536;
			}
		}
		
	}

}