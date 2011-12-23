package imac.diehardkart.bullet {
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.bullet.BulletDecorator;
	
	/**
	 * @author kimo
	 */
	public class BouncingBullet extends BulletDecorator {
		
		private const MAX_BOUNCING : uint = 3;
		private var m_bouncingCounter : uint;
		
		public function BouncingBullet(decoratedBullet : IBullet) {
			super(decoratedBullet);
			m_bouncingCounter = 0;
		}
		
		public override function loop() : void {
			super.loop();
			bounce();
		}
		
		private function bounce() : void {
			
		}
	}
}