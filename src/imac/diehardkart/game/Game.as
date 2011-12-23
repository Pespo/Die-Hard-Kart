package imac.diehardkart.game {
	import imac.diehardkart.bullet.StandardBullet;
	import imac.diehardkart.weapon.StandardWeapon;
	import imac.diehardkart.bullet.IBullet;
	import flash.events.EventDispatcher;
	import imac.diehardkart.utils.CustomEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.TimerEvent;
	import imac.diehardkart.vehicle.IVehicle;
	import flash.utils.Timer;
	import flash.display.Stage;
	import imac.diehardkart.vehicle.StandardVehicle;
	
	public class Game extends EventDispatcher {
		
// -------------------------- ICI ON FAIT LES TESTS -------------------------- //
		private function test() : void {
			var st : StandardVehicle = new StandardVehicle();
			st.physics.x = 100;
			st.physics.y = 100;
			st.addEventListener(CustomEvent.DEAD, e_deadvehicle);
			m_vehicles.push(st);
			st.display();
		}
// -------------------------------------------------------------------------- //
		
		private var m_vehicles : Vector.<IVehicle>;
		private var m_ennemiesBullets : Vector.<IBullet>;
		private var m_playerBullets : Vector.<IBullet>;
		
		private var m_XML : XMLList;
		
		private var m_genTimer : Timer;
		
		public static const ELEMENT_TO_LOAD : Number = 3;
		
		public function Game(stage:Stage) {
			loadXMLData("../res/ship.xml", m_XML);

			m_genTimer = new Timer(1, 0);
			m_genTimer.addEventListener(TimerEvent.TIMER, e_loop);

			m_vehicles = new Vector.<IVehicle>();
			m_ennemiesBullets = new Vector.<IBullet>();
			m_playerBullets = new Vector.<IBullet>();

			StandardVehicle.STAGE = stage;
			StandardVehicle.GAME = this;
			StandardBullet.STAGE = stage;
			StandardBullet.GAME = this;
			StandardWeapon.STAGE = stage;
			StandardWeapon.STAGE = this;			
		}
		
		public function run() : void {
			m_genTimer.start();
			/* ------- */
			test();
			/* ------- */
		}
		
		private function e_loop(evt:TimerEvent) : void {
			for each(var vehicle : IVehicle in m_vehicles) {
				vehicle.loop();
			}
			for each(var bullet : IBullet in m_playerBullets) {
				bullet.loop();
			}
			for each(var bullet : IBullet in m_ennemiesBullets) {
				bullet.loop();
			}
		}
		
		private function e_deadvehicle(evt:Event) : void {
			m_vehicles.splice(m_vehicles.indexOf(evt.target), 1);
		}
		
		private function e_deadennemiesbullet(evt:Event) : void {
			m_ennemiesBullets.splice(m_ennemiesBullets.indexOf(evt.target), 1);
		}
		
		private function e_deadplayerbullet(evt:Event) : void {
			m_playerBullets.splice(m_playerBullets.indexOf(evt.target), 1);
		}
		
		public function get vehicles() : Vector.<IVehicle> {
			return m_vehicles;
		}
		
		public function get ennemiesBullets() : Vector.<IBullet> {
			return m_ennemiesBullets;
		}
		
		public function get playerBullets() : Vector.<IBullet> {
			return m_playerBullets;
		}
		
		private function loadXMLData(path:String, xml:XMLList) : void {
			var XMLLoader : URLLoader = new URLLoader();
			XMLLoader.load(new URLRequest(path));
			XMLLoader.addEventListener(Event.COMPLETE, e_loaded);
			
			function e_loaded(evt:Event) : void {
				xml = new XML(evt.target.data).elements();
				dispatchEvent(new CustomEvent(CustomEvent.LOADED));
			}
		}
	}
}
