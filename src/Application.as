package {
	import imac.diehardkart.utils.CustomEvent;
	import flash.events.Event;
	import net.hires.debug.Stats;
	import imac.diehardkart.game.Game;
	import flash.display.Sprite;

	public class Application extends Sprite {		
				
		private var m_game : Game;
		private var m_ready : int;
		
		public function Application() {		
			addChild(new Stats());
			m_game = new Game(stage);
			m_ready = 0;
			m_game.addEventListener(CustomEvent.LOADED, getReady);
		}
		
		private function getReady(evt:Event) : void {
			if (++m_ready == Game.ELEMENT_TO_LOAD)
				run();
		}
		
		private function run() : void {
			m_game.run();
		}
	}
}
/*
package
{
	import flash.utils.getDefinitionByName;
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	public class Application extends Sprite {
		public function Application() {		
			var Skin : Class = getDefinitionByName("SkinVehicle") as Class;
			var v:Object = new Skin();		

		}
	}
}*/