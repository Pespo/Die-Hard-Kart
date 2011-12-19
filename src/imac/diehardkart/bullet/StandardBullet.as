package imac.diehardkart.bullet {
	import flash.display.MorphShape;
	import imac.diehardkart.game.Game;
	import imac.diehardkart.utils.CustomEvent;
	import flash.display.MovieClip;
	import imac.diehardkart.bullet.Bullet;
	import imac.diehardkart.bullet.BulletType;
	import imac.diehardkart.utils.Movement;
	import flash.events.Event;
	import imac.diehardkart.utils.FrameLabel;

	/**
	 * The common bullet in the bullet's Decorator Pattern
	 * @author muxisar
	 */
	public class StandardBullet extends MovieClip implements Bullet {
		
		public static var GAME_REF : Game;		// Ref to the main class Game
		
		private var m_movement : Movement;
		
		/**
		 * For counting frames
		 */
		private var m_ctrFramesSinceLastMove : uint;
		/**
		 * Number of frames to wait before act
		 */
		private var m_waitingFrames : uint;
		
		/**
		 * damage caused by the bullet
		 */
		private var m_damage : Number;	
		
		/**
		 * Standard values
		 */
		private static const STANDARD_DAMAGE : Number = 1;
		
		/** 
		 * Construct a StandardBullet
		 * @param movement <code>Movement</code> describing the bullet's movement
		 * @param damage <code>Number</code> default value is 1
		 */
		public function StandardBullet(movement:Movement,
										damage:Number = STANDARD_DAMAGE,
										waitingFrames:uint = 10) {
			m_movement = movement;
			m_damage = damage;
			
			addEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
		}
				
		public function e_addedToStage(evt:Event) : void {
			gotoAndPlay(FrameLabel.INIT_FRAME);
			addEventListener(Event.ENTER_FRAME, e_action);
		}
		
		public function e_removedFromStage(evt:Event) : void {			
			removeEventListener(Event.ENTER_FRAME, e_action);
		}
		
		/**
		 * Move the bullet at each frame
		 * @return void
		 */
		public function e_action(evt:Event) : void {
			++m_ctrFramesSinceLastMove;
			if (m_ctrFramesSinceLastMove == m_waitingFrames) {
				x = m_movement.make(x, Movement.AXIS_X);
				y = m_movement.make(y, Movement.AXIS_Y);
				m_ctrFramesSinceLastMove = 0;
			}
			if (x < 0 || y < 0 || x > GAME_REF.stage.stageWidth || y > GAME_REF.stage.stageHeight) {
				explode();
			}
			if (currentFrameLabel == FrameLabel.EXPLOSION_DONE_FRAME)
				die();
		}
		
		public function get movement() : Movement {
			return m_movement;
		}
		
		public function set movement(movement:Movement) : void {
			m_movement = movement;
		}

		public function explode() : void {
			gotoAndPlay(FrameLabel.EXPLOSION_FRAME);
			dispatchEvent(new Event(CustomEvent.EXPLOSION));
		}
		
		public function die() : void {
			removeEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
		}
	}
}