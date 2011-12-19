package imac.diehardkart.bullet {
	import imac.diehardkart.game.Game;
	import imac.diehardkart.utils.CustomEvent;
	import flash.display.MovieClip;
	import imac.diehardkart.bullet.Bullet;

	/**
	 * The common bullet in the bullet's Decorator Pattern
	 * @author muxisar
	 */
	public class StandardBullet extends MovieClip implements Bullet {
		
		private var m_dx : Number;				// Direction on axis x
		private var m_dy : Number;				// Direction on axis y
		private var m_speed : Number;			// Speed percentage
		private static var GAME_REF : Game;		// Ref to the main class Game
		
		/** 
		 * Construct a StandardBullet
		 * @param bulletType a <code>Number</code> corresponding to the bullet's style
		 */
		public function StandardBullet(bulletType : Number = BulletType.STANDARD_BULLET) {
			// Read XML and get infos about bulletType
		}
		
		/**
		 * Move the bullet at each frame
		 * @return void
		 */
		public function move() : void {
			
		}
		
		/**
		 * Explode the bullet at each frame
		 * @return void
		 */
		public function explode() : void {
			
		}
	}
}