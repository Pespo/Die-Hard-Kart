package {
	import imac.diehardkart.map.Map;
	import imac.diehardkart.Game;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Main extends Sprite {
		private static var m_game : Game;
		private var m_map : Map;
		private var m_objectsTotal : Number = 5;
		private var m_objectsLoaded : Number = 0;
		private var m_bulletXml : XMLList;
		private var m_mapXml : XMLList;
		private var m_shipXml : XMLList;
		private var m_weaponXml : XMLList;

		public function Main() {
			loadXMLData("../res/bullet.xml", m_bulletXml);
			loadXMLData("../res/map.xml", m_mapXml);
			loadXMLData("../res/ship.xml", m_shipXml);
			loadXMLData("../res/weapon.xml", m_weaponXml);
			m_map = new Map("../res/maps/mapTest.png", "../res/maps/refmapTest.png");
			m_game = new Game(m_map, m_bulletXml, m_mapXml, m_shipXml, m_weaponXml);
			
			
			m_map.addEventListener(Event.COMPLETE, mapLoaded);
			
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		
		private function loadXMLData(path:String, xml:XMLList) : void {
		   var XMLLoader : URLLoader = new URLLoader();
		   XMLLoader.load(new URLRequest(path));
		   XMLLoader.addEventListener(Event.COMPLETE, e_loaded);
		   
		   function e_loaded(evt:Event) : void {
				   xml = new XMLList(evt.target.data).elements();
				   ++m_objectsLoaded;
				   XMLLoader.removeEventListener(Event.COMPLETE, e_loaded);
		   }
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