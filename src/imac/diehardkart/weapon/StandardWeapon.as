package imac.diehardkart.weapon {
	import flash.display.DisplayObject;
	import com.senocular.display.Duplicator;
	import imac.diehardkart.utils.FrameLabel;
	import flash.geom.Point;
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.game.Game;
	import flash.display.MovieClip;
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.weapon.IWeapon;
	import flash.events.Event;

	public class StandardWeapon extends MovieClip implements IWeapon {
		
		/**
		 * Reference to the main game
		 */
		public static var GAME_REF : Game;
		
		/**
		 * Vehicle movement
		 */
		private var m_movement : Movement;
		
		/**
		 * Bullet to launch
		 */
		private var m_bullet : IBullet;	
		
		/**
		 * Rate of fire
		 */
		private var m_shootRate : Number; 	

		/**
		 * Standard values
		 */
		private static const STANDARD_SHOOT_RATE = 1;
		
		/** 
		 * Construct a StandardWeapon
		 * @param movement <code>Movement</code> describing the weapon's movement
		 * @param bullet <code>Bullet</code> give a model of bullet
		 * @param shootRate <code>Number</code> default value is 1
		 */
		public function StandardWeapon(movement:Movement,
										bullet:IBullet,
										shootRate:Number = STANDARD_SHOOT_RATE) {
			m_movement = movement;					
			m_bullet = bullet;
			m_shootRate = shootRate;
			
			addEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
		}
		
		public function e_addedToStage(evt:Event) : void {
			gotoAndPlay(FrameLabel.INIT_FRAME);
			addEventListener(Event.ENTER_FRAME, e_shoot);
		}
		
		public function e_removedFromStage(evt:Event) : void {			
			removeEventListener(Event.ENTER_FRAME, e_shoot);
		}
		
		public function e_shoot() : void {
			var bullet : IBullet = Duplicator.duplicateDisplayObject(m_bullet);
			var bulletStartPosition : Point = new Point;	
			bulletStartPosition = localToGlobal(new Point(this.x, this.y));
			bullet.x = bulletStartPosition.x;
			bullet.y = bulletStartPosition.y;
			bullet.m_movement.setDirection(m_movement.dx, m_movement.dy);
			GAME_REF.stage.addChild(bullet);
		}
		
		public function get movement() : Movement {
			return m_movement;
		}
		
		public function set movement(movement:Movement) : void {
			m_movement = movement;
		}
	}
}
