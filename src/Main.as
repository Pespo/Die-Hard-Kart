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
		private var m_levelXml : XMLList;
		private var m_shipXml : XMLList;
		private var m_weaponXml : XMLList;
		
		private static const BULLET_XML : Number = 0;
		private static const SHIP_XML : Number = 1;
		private static const WEAPON_XML : Number = 2;
		private static const LEVEL_XML : Number = 3;

		public function Main() {
			loadXMLData("../res/bullet.xml", BULLET_XML);
			loadXMLData("../res/ship.xml", SHIP_XML);
			loadXMLData("../res/weapon.xml", WEAPON_XML);
			loadXMLData("../res/level.xml", LEVEL_XML);
			m_map = new Map("../res/maps/mapTest.png", "../res/maps/refmapTest.png");			
			m_map.addEventListener(Event.COMPLETE, mapLoaded);
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		
		private function loadXMLData(path : String, type : Number) : void {
			var XMLLoader : URLLoader = new URLLoader();
			XMLLoader.load(new URLRequest(path));
			XMLLoader.addEventListener(Event.COMPLETE, e_loaded);
		   
		function e_loaded(evt:Event) : void {
			var xml : XMLList = new XMLList(evt.target.data).elements();
			switch(type) {
				case BULLET_XML : 
					m_bulletXml = xml;
					break;
				case WEAPON_XML : 
					m_weaponXml = xml;
					break;
				case SHIP_XML : 
					m_shipXml = xml;
					break;
				case LEVEL_XML : 
					m_levelXml = xml;
					break;
			}
			if (++m_objectsLoaded == 5) {
				m_game = new Game(m_map, m_bulletXml, m_levelXml, m_shipXml, m_weaponXml);			
			}
			XMLLoader.removeEventListener(Event.COMPLETE, e_loaded);
			}
		}
		
		private function mapLoaded(evt : Event) : void {
			if (++m_objectsLoaded == 5) {
				m_game = new Game(m_map, m_bulletXml, m_levelXml, m_shipXml, m_weaponXml);			
			}
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