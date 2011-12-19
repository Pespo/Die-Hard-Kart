package imac.diehardkart.bullet {
	import flash.display.MovieClip;
	import imac.diehardkart.bullet.Bullet;
	
	/**
	 * Decorator parent for all the bullet's Decorator Pattern
	 * @author muxisar
	 */
	public class BulletDecorator extends MovieClip {
		private var m_decoratedBullet : Bullet;
		
		/**
		 * Construct a BulletDecorator
		 * @param decoratedBullet an instance of <code>imac.diehardkart.bullet.StandardBullet</code>
		 */
		public function BulletDecorator(decoratedBullet : Bullet) {
			m_decoratedBullet = decoratedBullet;
		}
		
		public function move() : void {
			m_decoratedBullet.move();
		}
		
		public function explode() : void {
			m_decoratedBullet.explode();
		}
	}
}
