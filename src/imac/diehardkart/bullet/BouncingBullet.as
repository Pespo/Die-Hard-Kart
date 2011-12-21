package imac.diehardkart.bullet {
	import flash.events.Event;
	import imac.diehardkart.utils.Movement;
	
	/**
	 * Bullet Decorator: BoucingBullet Decorator's Pattern
	 * @author kimo
	 */
	public class BouncingBullet extends BulletDecorator {
		
		private const MAX_BOUNCING : uint = 5;
		private var m_bouncingCounter : uint;
		
		public function BouncingBullet(decoratedBullet:IBullet) {
			super(decoratedBullet);
		}
		
		public override function e_action(evt:Event) : void {
			trace(m_decoratedBullet.x);
		}
		
		public override function get decorated() : IBullet {
			return m_decoratedBullet;
		}
	}
}