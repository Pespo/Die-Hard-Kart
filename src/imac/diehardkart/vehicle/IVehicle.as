package imac.diehardkart.vehicle {
	import flash.display.Sprite;
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.game.Game;
	import flash.events.Event;
	
	/** 
	 * Interface of the vehicle's Decorator Pattern
	 * @author muxisar
	 */ 
	public class IVehicle extends Sprite {
		
		/**
		 * Reference to the main game
		 */
		public static var GAME_REF : Game;
		
		/**
		 * Vehicle movement
		 */
		protected var m_movement : Movement;
		
		/**
		 * For counting frames
		 */
		protected var m_ctrFramesSinceLastMove : uint;
		/**
		 * Number of frames to wait before act
		 */
		protected var m_waitingFrames : uint;
		
		/**
		 * Current life of vehicle
		 */
		protected var m_life : Number;
		/**
		 * Coeff of life losed when it happens
		 */
		protected var m_coeffLifeLost : Number;
		
		/**
		 * Damage caused when it explodes
		 */
		protected var m_maxDamages : Number;
		/**
		 * Ray of explosion
		 */
		protected var m_explosionRange : Number;
		
		/**
		 * Standard values
		 */
		public static const STANDARD_LIFE : Number = 100;
		public static const STANDARD_COEFF_LIFE_LOST : Number = 1;
		public static const STANDARD_MAX_DAMAGES : Number = 10;
		public static const STANDARD_EXPLOSION_RANGE : Number = 20;
		
		protected var m_dead : Boolean;
		
		protected var m_skin : SkinVehicle;
		
		protected function e_action(evt:Event) : void {
			throw new Event("This method must be overriden");
		}
		
		protected function explode() : void {
			throw new Event("This method must be overriden");
		}
		
		public function looseLife() : void {
			throw new Event("This method must be overriden");
		}
	}
}