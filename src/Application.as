package {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import net.hires.debug.Stats;
	import imac.diehardkart.game.Game;
	import flash.display.Sprite;

	public class Application extends Sprite {		
		public function Application() {
			addChild(new Stats());
			var g : Game = new Game(stage);
			addChild(g);
		}
	}
}
