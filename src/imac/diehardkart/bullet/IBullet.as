package imac.diehardkart.bullet {
	import flash.events.Event;
	import flash.display.Sprite;
	import imac.diehardkart.game.Game;
	import imac.diehardkart.utils.Movement;	

	/** 
	 * Interface of the bullet's Decorator Pattern
	 * @author muxisar
	 */ 
	public class IBullet extends Sprite {
		
		/**
		 * Reference to the main game
		 */
		public static var GAME_REF : Game;
		
		/**
		 * Bullet movement
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
		 * Damage caused by the bullet
		 */
		protected var m_damage : Number;	
		
		/**
		 * Standard values
		 */
		public static const STANDARD_DAMAGE : Number = 1;
		protected var m_dead : Boolean;
		protected var m_skin : SkinBullet;
		
		
		
		protected function e_action(evt:Event) : void {
			throw new Event("This method must be overriden");
		}
		
		protected function explode() : void {
			throw new Event("This method must be overriden");
		}
	}
}
