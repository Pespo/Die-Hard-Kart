package imac.diehardkart.decorable.bullet {
	import imac.diehardkart.decorable.Decorator;

	public class BulletDecorator extends Decorator implements IBullet {
		
		public function BulletDecorator(decoratedBullet : IBullet) {
			super(decoratedBullet);
		}
		
		public function clone() : IBullet {
			return null;
		}
	}
}