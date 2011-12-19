package imac.diehardkart.bullet {
	import imac.diehardkart.bullet.IBullet;
	
	/**
	 * Decorator parent for all the bullet's Decorator Pattern
	 * @author muxisar
	 */
	public class BulletDecorator implements IBullet {
		private var m_decoratedBullet : IBullet;
		
		/**
		 * Construct a BulletDecorator
		 * @param decoratedBullet an instance of <code>imac.diehardkart.bullet.StandardBullet</code>
		 */
		public function BulletDecorator(decoratedBullet:IBullet) {
			m_decoratedBullet = decoratedBullet;
		}
		
		public function explode() : void {
			m_decoratedBullet.explode();
		}
	}
}
