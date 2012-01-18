package imac.diehardkart.decorable.bullet {
	import flash.display.Shape;

	public class BouncingBullet extends BulletDecorator {
		
		private static const MAX_BOUNCING : uint = 3;
		private var m_bouncingCounter : uint;
		private var m_bouncingBox : Shape;
		
		public function BouncingBullet(decoratedBullet : IBullet, box : Shape) {
			super(decoratedBullet);
			m_bouncingBox = box;
			m_bouncingCounter = 0;
		}
		
		override public function loop() : void {
			super.loop();
			bounce();
		}
		
		private function bounce() : void {
			if (m_bouncingCounter != MAX_BOUNCING) {
				if (x > m_bouncingBox.width || x < 0) {
					++m_bouncingCounter;
					setOrientation( -dx, dy);
				}
				if (y > m_bouncingBox.height || y < 0) {
					++m_bouncingCounter;
					setOrientation(dx, -dy);
				}
			}
		}
	}
}