package imac.diehardkart.bullet {
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.bullet.BulletDecorator;
	import imac.diehardkart.utils.Movement;
	
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
			if (m_bouncingCounter != MAX_BOUNCING) {
				if (x > stage.stageWidth || x < 0) {
					++m_bouncingCounter;
					movement.setDirection( -movement.dx, movement.dy);
				}
				if (y > stage.stageHeight || y < 0) {
					++m_bouncingCounter;
					movement.setDirection(movement.dx, -movement.dy);
				}
			}
		}
	}
}
