package 
{
	import net.hires.debug.Stats;
	import imac.diehardkart.game.Game;
	import flash.display.Sprite;

	public class Application extends Sprite
	{		
		public function Application() {
			
			addChild(new Stats());
			var g : Game = new Game(this.stage);
			addChild(g);
		}
	}
}
