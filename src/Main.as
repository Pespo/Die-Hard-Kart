package {
	import imac.diehardkart.map.Map;
	import imac.diehardkart.Game;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite {
		private static var m_game : Game;
		private var m_map : Map;
		private var m_objectsTotal : Number = 1;
		private var m_objectsLoaded : Number = 0;

		public function Main() {
			m_map = new Map("../res/maps/mapTest.png", "../res/maps/refmapTest.png");
			m_game = new Game(m_map);
			
			m_map.addEventListener(Event.COMPLETE, mapLoaded);
			
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		
		private function mapLoaded(evt : Event) : void {
			++m_objectsLoaded;
			m_map.removeEventListener(Event.COMPLETE, mapLoaded);
		}
		
		public function get objectsTotal() : Number {
			return m_objectsTotal;
		}
		
		public function get objectsLoaded() : Number {
			return m_objectsLoaded;
		}
		
		private function addedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addChild(m_game);
		}
	}
}