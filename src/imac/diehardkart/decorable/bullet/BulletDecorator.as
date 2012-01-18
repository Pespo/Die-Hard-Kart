package imac.diehardkart.decorable.bullet {
	import imac.diehardkart.decorable.Decorator;

	public class BulletDecorator extends Decorator implements IBullet {
		
		public function BulletDecorator(decoratedBullet : IBullet) {
			super(decoratedBullet);
		}
		
		public function clone() : IBullet {
			return null;
		}
		
		public function get damage() : Number {
			var deco : IBullet = m_decorated as IBullet;
			return deco.damage;
		}
		
		public function explode() : void {
			var deco : IBullet = m_decorated as IBullet;
			deco.explode();
		}
	}
}