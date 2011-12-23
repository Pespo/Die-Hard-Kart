package imac.diehardkart.weapon {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.bullet.StandardBullet;
	import flash.geom.*;
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.game.Game;
	import flash.display.Stage;
	import flash.utils.getDefinitionByName;
	import imac.diehardkart.utils.Physics;
	import imac.diehardkart.utils.Labels;

	
	public class StandardWeapon implements IWeapon {
		
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
		public static const STANDARD_SHOOT_RATE : Number = 5;
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
			//	var skinName : Class = getDefinitionByName(skin) as Class;
			//	m_display =new skinName();		
			m_shootRate = (m_shootRate < MIN_SHOOT_RATE || m_shootRate > MAX_SHOOT_RATE) ? STANDARD_SHOOT_RATE : shootRate;
			m_shootCounter = 0;
			m_bullet = bullet;
			m_physics = new Physics("", angle, 0);
		}
		
		public function display() : void {
			m_physics.gotoAndPlay(Labels.INIT);
			STAGE.addChild(m_physics);
		}
		
		public function get physics() : Physics {
			return m_physics;
		}
		
		public function set physics(m:Physics) : void {
			m_physics = m;
		}

		public function setBullet() : IBullet {
			/*var bulletStartPosition : MovieClip = new MovieClip();
			bulletStartPosition.localToGlobal(new Point(physics.x, physics.y));*/
			var launchBullet : IBullet = m_bullet.clone();
			launchBullet.physics.x = /*bulletStartPosition.*/physics.x;
			launchBullet.physics.y = /*bulletStartPosition.*/physics.y;
			launchBullet.physics.rotate(physics.rotation);
			launchBullet.physics.speed = 5;
			return launchBullet;
		}
		
		public function shoot() : void {
			++m_shootCounter;
			if (m_shootRate < m_shootCounter) {
				var launchBullet : IBullet = setBullet();
				GAME.addPlayerBullets(launchBullet);
				launchBullet.display();
				m_shootCounter = 0;
			}
		}
		
		public function loop() : void {
			shoot();
		}
		

	}
}
	
