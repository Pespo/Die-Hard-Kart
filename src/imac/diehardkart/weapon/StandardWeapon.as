package imac.diehardkart.weapon {
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.printing.PrintJobOptions;
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.game.Game;
	import flash.display.Stage;
	import imac.diehardkart.utils.Physics;
	
	public class StandardWeapon extends EventDispatcher implements IWeapon {
		
		/**
		 * Reference to the main game
		 */
		public static var GAME : Game;
		
		/**
		 * Reference to the stage
		 */
		public static var STAGE : Stage;
		
		/**
		 * Manage physic of weapon
		 */
		private var m_physics : Physics;
		
		/**
		 * Save physic of holder
		 */
		private var m_physicsHolder : Physics;
		
		/**
		 * Rate of shoot
		 */
		private var m_shootRate : Number;
		
		/**
		 * Shoot counter
		 */
		private var m_shootCounter : Number;
		/**
		 * Model of bullet
		 */
		private var m_bullet : IBullet;
		
		/**
		 * Standard values
		 */
		public static const STANDARD_SHOOT_RATE : Number = 10;
		public static const MAX_SHOOT_RATE : Number = 10;
		public static const MIN_SHOOT_RATE : Number = 1;
		public static const STANDARD_DIRECTION : Number = 0;
		//public static const STANDARD_SKIN : String = "SkinWeapon";
		
		/** 
		 * Construct a StandardWeapon
		 * @param movement <code>Movement</code> describing the weapon's movement
		 * @param bullet <code>Bullet</code> give a model of bullet
		 * @param shootRate <code>Number</code> default value is 5
		 * @param angle <code>Number</code> default value is 0
		 */
		
		public function StandardWeapon(bullet:IBullet, shootRate:Number = STANDARD_SHOOT_RATE, angle:Number = STANDARD_DIRECTION/*, skin:String = STANDARD_SKIN*/) {
			
			m_shootRate = (m_shootRate < MIN_SHOOT_RATE || m_shootRate > MAX_SHOOT_RATE) ? STANDARD_SHOOT_RATE : shootRate;
			m_shootCounter = 0;
			m_bullet = bullet;
			m_physics = new Physics("SkinWeapon", angle, 0);
			m_physicsHolder = new Physics();
		}
		
		public function get physics() : Physics {
			return m_physics;
		}
		
		public function set physics(m:Physics) : void {
			m_physics = m;
		}
		
		public function get physicsHolder() : Physics {
			return m_physicsHolder;
		}
		
		public function set physicsHolder(m:Physics) : void {
			m_physicsHolder = m;
		}
		
		public function get bullet() : IBullet {
			return m_bullet;
		}
		
		public function set bullet(value:IBullet) : void {
			m_bullet = value;
		}

		public function makeBullet() : IBullet {
			var launchBullet : IBullet = m_bullet.clone();
			trace(launchBullet);
			var bulletStartPosition : Point =  physics.localToGlobal(new Point(0, 0));
			launchBullet.physics.x = bulletStartPosition.x;
			launchBullet.physics.y =  bulletStartPosition.y ;
			launchBullet.physics.rotate(physics.parent.rotation + physics.rotation);
			launchBullet.physics.speed = 5;
			return launchBullet;
		}
		
		public function shoot() : void {
			++m_shootCounter;
			if (m_shootRate < m_shootCounter) {
				var launchBullet : IBullet = makeBullet();
				GAME.addPlayerBullets(launchBullet);
				launchBullet.display();
				m_shootCounter = 0;
			}
		}
		
		public function loop() : void {
			shoot();
			//physics.rotate(2);
		}
		

	}
}
