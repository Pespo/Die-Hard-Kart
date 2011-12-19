package 
{
	import net.hires.debug.Stats;
	import imac.diehardkart.game.Game;
	import flash.display.Sprite;
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.vehicle.StandardVehicle;

	public class Application extends Sprite
	{		
		public function Application() {
			
			addChild(new Stats());
			var g : Game = new Game();
			addChild(g);
		}
	}
}
