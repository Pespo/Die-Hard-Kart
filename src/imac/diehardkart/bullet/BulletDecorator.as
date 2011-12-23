package imac.diehardkart.bullet {
	import imac.diehardkart.utils.Physics;

	public class BulletDecorator implements IBullet {
		
		protected var m_decoratedBullet : IBullet;
		
		public function BulletDecorator(decoratedBullet:IBullet) {
			m_decoratedBullet = decoratedBullet;
		}
		
		public function explode() : void {
			 m_decoratedBullet.explode();
		}
		
		public function loop() : void {
			m_decoratedBullet.loop();
		}
		
		public function display() : void {
			m_decoratedBullet.display();
		}
		
		public function get physics() : Physics {
			return m_decoratedBullet.physics;
		}
		
		public function set physics(s:Physics) : void {
			m_decoratedBullet.physics = s;
		}
		
		public function clone() : IBullet {
			return m_decoratedBullet.clone();
		}
	}
}