package imac.diehardkart.game {
	import flash.sampler.NewObjectSample;
	import imac.diehardkart.bullet.BouncingBullet;
	import imac.diehardkart.vehicle.BlindVehicle;
	import imac.diehardkart.vehicle.ControlledVehicle;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	import imac.diehardkart.vehicle.ArmedVehicle;
	import imac.diehardkart.weapon.IWeapon;
	import imac.diehardkart.weapon.MultipleWeapon;
	import imac.diehardkart.weapon.OrientedWeapon;
	import imac.diehardkart.weapon.StandardWeapon;
	import flash.events.EventDispatcher;
	import imac.diehardkart.utils.CustomEvent;
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.bullet.StandardBullet;
	import imac.diehardkart.map.Map;
	import flash.events.TimerEvent;
	import imac.diehardkart.vehicle.IVehicle;
	import flash.utils.Timer;
	import flash.display.Stage;
	import imac.diehardkart.vehicle.StandardVehicle;
	
	public class Game extends EventDispatcher {
		
// -------------------------- ICI ON FAIT LES TESTS -------------------------- //
		private function test() : void {
<<<<<<< Updated upstream
			/*var weapon1 : StandardWeapon = new StandardWeapon(new StandardBullet());
			weapon1.physics.rotate(-160);
			weapon1.physics.x = -10;
			weapon1.physics.y = -20;	
=======

			var weapon1 : OrientedWeapon = new OrientedWeapon(new MultipleWeapon(new StandardWeapon(new StandardBullet())));
			weapon1.addEventListener(CustomEvent.DEAD, e_deadWeapon);
			weapon1.physics.rotate(0);
			weapon1.physics.x = 20;
			weapon1.physics.y = 0;
			trace("pouet");
			
			var bullet : StandardBullet =( new StandardBullet());

>>>>>>> Stashed changes
			
			var weapon2 : StandardWeapon = (new StandardWeapon(bullet));
			weapon2.addEventListener(CustomEvent.DEAD, e_deadWeapon);
			weapon2.physics.rotate(0);
			weapon2.physics.x = 20;
			weapon2.physics.y = -5;	
			
			m_weapons.push(weapon1);
			//m_weapons.push(weapon2);
			var weapons : Vector.<IWeapon> = new Vector.<IWeapon>;
			weapons.push(weapon1);
			//weapons.push(weapon2);

			var st : ArmedVehicle = (new ArmedVehicle(new StandardVehicle(), weapons));
			st.physics.x = 100;
			st.physics.y = 100;
			st.physics.speed = 0;
			st.addEventListener(CustomEvent.DEAD, e_deadVehicle);
			m_vehicles.push(st);
			st.display();
			//
			//var vehicle1 : ControlledVehicle = new ControlledVehicle(new StandardVehicle());
			//vehicle1.physics.x = 100;
			//vehicle1.physics.y = 100;
			//vehicle1.addEventListener(CustomEvent.DEAD, e_deadVehicle);
			//m_vehicles.push(vehicle1);
			//vehicle1.display();
			//trace("5");
			
			var vehicle2 : BlindVehicle = new BlindVehicle(new StandardVehicle());
			vehicle2.physics.x = 100;
			vehicle2.physics.y = 100;
			vehicle2.addEventListener(CustomEvent.DEAD, e_deadVehicle);
			m_vehicles.push(vehicle2);
			vehicle2.display();*/
		}
// -------------------------------------------------------------------------- //
		
		private var m_map : Map;
		private var m_actualZone : String;
		private var m_mapCheckpoints : Number;
		private var m_mapLaps : Number;

		private var m_vehicles : Vector.<IVehicle>;
		private var m_weapons : Vector.<IWeapon>;
		private var m_ennemiesBullets : Vector.<IBullet>;
		private var m_playerBullets : Vector.<IBullet>;
		private var m_kart : ControlledVehicle;
		
		private var m_XML : XMLList;
		
		private var m_genTimer : Timer;
		
		public static const ELEMENT_TO_LOAD : Number = 3;
		
		public function Game(stage:Stage) {
			loadXMLData("../res/ship.xml", m_XML);

			m_map = new Map(stage);
			m_actualZone = "road";
			m_mapCheckpoints = 0;
			m_mapLaps = 0;
			
			m_genTimer = new Timer(1, 0);
			m_genTimer.addEventListener(TimerEvent.TIMER, e_loop);

			m_vehicles = new Vector.<IVehicle>();
			m_weapons = new Vector.<IWeapon>();
			m_ennemiesBullets = new Vector.<IBullet>();
			m_playerBullets = new Vector.<IBullet>();

			StandardVehicle.STAGE = stage;
			StandardVehicle.GAME = this;
			StandardBullet.STAGE = stage;
			StandardBullet.GAME = this;
			StandardWeapon.STAGE = stage;
<<<<<<< Updated upstream
			StandardWeapon.GAME = this;	
			
			m_kart = new ControlledVehicle(new StandardVehicle());
			m_kart.physics.x = 100;
			m_kart.physics.y = 100;
			m_vehicles.push(m_kart);
			m_kart.addEventListener(CustomEvent.DEAD, e_deadVehicle);
			m_kart.display();
=======
			StandardWeapon.GAME = this;			
			OrientedWeapon.STAGE = stage;
			BouncingBullet.STAGE = stage;
>>>>>>> Stashed changes
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
			
			for each(var weapon : IWeapon in m_weapons) {
				weapon.loop();
			}

			for each(var pbullet : IBullet in m_playerBullets) {
				pbullet.loop();
			}

			for each(var ebullet : IBullet in m_ennemiesBullets) {
				ebullet.loop();
			}
			
			kartZone();
		}
		
		public function addPlayerBullets(bullet:IBullet) : void {
			trace(bullet);
			EventDispatcher(bullet.decorated).addEventListener(CustomEvent.DEAD, e_deadplayerbullet);
			m_playerBullets.push(bullet);
		}
		
		private function e_deadVehicle(evt:Event) : void {
			m_vehicles.splice(m_vehicles.indexOf(evt.target), 1);
		}
		
		private function e_deadWeapon(evt:Event) : void {
			m_weapons.splice(m_weapons.indexOf(evt.target), 1);
		}
		
		private function e_deadEnnemiesBullet(evt:Event) : void {
			m_ennemiesBullets.splice(m_ennemiesBullets.indexOf(evt.target), 1);
		}
		
		private function e_deadplayerbullet(evt:Event) : void {
			trace("deadPlayerBullet");
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
		
		public function kartZone() : void {
			if (m_actualZone == "road" 
					&& (m_map.refMapBitmap.bitmapData.getPixel(m_kart.physics.x , m_kart.physics.y)).toString(16) == String("808080")) {
				roadToSand();
			}
			else if (m_actualZone == "sand" 
						&& (m_map.refMapBitmap.bitmapData.getPixel(m_kart.physics.x, m_kart.physics.y)).toString(16) == String("0")) {
				sandToRoad();
			}
			else if ((m_actualZone == "road" || m_actualZone == "sand") 
						&& (m_map.refMapBitmap.bitmapData.getPixel(m_kart.physics.x, m_kart.physics.y)).toString(16) == String("ffff00")) {
				checkpointPassed();
			}
			else if ((m_actualZone == "road" || m_actualZone == "sand")
						&& (m_map.refMapBitmap.bitmapData.getPixel(m_kart.physics.x, m_kart.physics.y)).toString(16) == String("ff0000")) {
				startPassed();
			}
			else if ((m_actualZone == "road" || m_actualZone == "sand")
						&& (m_map.refMapBitmap.bitmapData.getPixel(m_kart.physics.x, m_kart.physics.y)).toString(16) == String("ffffff")) {
				kartOut();
			}
		}
		
		private function roadToSand() : void {
			m_actualZone = "sand";
			ControlledVehicle.MAX_SPEED = ControlledVehicle.MAX_SPEED_ON_SAND;
		}
		
		private function sandToRoad() : void {
			m_actualZone = "road";
			ControlledVehicle.MAX_SPEED = ControlledVehicle.MAX_SPEED_ON_ROAD;
		}
		
		private function checkpointPassed() : void {
			m_mapCheckpoints = 1;
		}
		
		private function startPassed() : void {
			if (m_mapLaps == 0 || m_mapCheckpoints == 1) {
				m_mapCheckpoints = 0;
				++m_mapLaps;
				trace(m_mapLaps);
			}
		}
		
		private function kartOut() : void {
			trace("loose");
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
