package imac.diehardkart.vehicle {
	import imac.diehardkart.utils.CustomEvent;
	import flash.display.Sprite;
	import imac.diehardkart.game.Game;
	import imac.diehardkart.utils.FrameLabel;
	import imac.diehardkart.utils.Movement;
	import flash.events.Event;

	/**
	 * The common vehicle in the vehicle's Decorator Pattern
	 * @author muxisar
	 */
	public class StandardVehicle extends Sprite/* implements IVehicle */{
		
		/**
		 * Reference to the main game
		 */
		public static var GAME_REF : Game;
		
		/**
		 * Vehicle movement
		 */
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
		 * Current life of vehicle
		 */
		private var m_life : Number;
		/**
		 * Coeff of life losed when it happens
		 */
		private var m_coeffLifeLost : Number;
		
		/**
		 * Damage caused when it explodes
		 */
		private var m_maxDamages : Number;
		/**
		 * Ray of explosion
		 */
		private var m_explosionRange : Number;
		
		/**
		 * Standard values
		 */
		public static const STANDARD_LIFE : Number = 100;
		public static const STANDARD_COEFF_LIFE_LOST : Number = 1;
		public static const STANDARD_MAX_DAMAGES : Number = 10;
		public static const STANDARD_EXPLOSION_RANGE : Number = 20;
		
		private var m_dead : Boolean;
		
		private var m_skin : SkinVehicle;
		
		/** 
		 * Construct a StandardVehicle
		 * @param movement <code>Movement</code> describing the vehicle's movement
		 * @param waitingFrames <code>uint</code> default value is 10
		 * @param life <code>Number</code> default value is 100
		 * @param coeffLifeLost <code>Number</code> default value is  1
		 * @param maxDamages <code>Number</code> default value is 10
		 * @param explosionRange <code>Number</code> default value is 20
		 */
		public function StandardVehicle(movement:Movement,
										waitingFrames:uint = 10,
										life:Number = STANDARD_LIFE,
										coeffLifeLost:Number = STANDARD_COEFF_LIFE_LOST,
										maxDamages:Number = STANDARD_MAX_DAMAGES,
										explosionRange:Number = STANDARD_EXPLOSION_RANGE) {			

			m_movement = movement;
			m_life = life;
			m_coeffLifeLost = Math.abs(coeffLifeLost);
			m_maxDamages = maxDamages;
			m_explosionRange = explosionRange;
			m_ctrFramesSinceLastMove = 0;
			m_waitingFrames = waitingFrames;
			m_skin = new SkinVehicle();
			addChild(m_skin);
			m_dead = false;
			
			addEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
		}
		
		public function e_addedToStage(evt:Event) : void {
			addEventListener(Event.ENTER_FRAME, e_action);
		}
		
		public function e_removedFromStage(evt:Event) : void {			
			removeEventListener(Event.ENTER_FRAME, e_action);
		}
		
		public function e_action(evt:Event) : void {
			looseLife();
			if (!m_dead) {
				++m_ctrFramesSinceLastMove;
				
				if (m_ctrFramesSinceLastMove == m_waitingFrames) {
					x = m_movement.make(x, Movement.AXIS_X);
					y = m_movement.make(y, Movement.AXIS_Y);
					m_ctrFramesSinceLastMove = 0;
				}
					
				if (m_life <= 0)
					explode();
			}
			
			if (m_skin.currentFrameLabel == FrameLabel.EXPLOSION_DONE)
				destruct();
		}
		
		public function explode() : void {
			m_dead = true;
			m_skin.gotoAndPlay(FrameLabel.EXPLOSION);
		}
		
		public function looseLife() : void {
			m_life = m_life - (1 * m_coeffLifeLost);
		}
		
		public function destruct() : void {
			removeEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
			dispatchEvent(new CustomEvent(CustomEvent.DEAD));
		}
	}
}