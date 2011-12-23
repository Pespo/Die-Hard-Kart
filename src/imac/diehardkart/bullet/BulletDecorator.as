package imac.diehardkart.bullet {
	import flash.display.Stage;
	import imac.diehardkart.utils.Movement;

	public class BulletDecorator implements IBullet {
		
		protected var m_decoratedBullet : IBullet;
		
		public function BulletDecorator(decoratedBullet:IBullet) {
			m_decoratedBullet = decoratedBullet;
		}
		
		public function loop() : void {
			m_decoratedBullet.loop();
		}
		
		public function get stage() : Stage {
			return m_decoratedBullet.stage;
		}
		
		public function get x() : Number {
			return m_decoratedBullet.x;
		}
		
		public function set x(x:Number) : void {
			m_decoratedBullet.x = x;
		}
		
		public function get y() : Number {
			return m_decoratedBullet.y;
		}
		
		public function set y(y:Number) : void {
			m_decoratedBullet.y = y;
		}
		
		public function get damage() : Number {
			return m_decoratedBullet.damage;
		}
		
		public function get movement() : Movement {
			return m_decoratedBullet.movement;
		}
		
		public function set movement(movement:Movement) : void {
			m_decoratedBullet.movement = movement;
		}
		
		public function display() : void {
			m_decoratedBullet.display();
		}
		
		public function get rotation() : Number {
			return m_decoratedBullet.rotation;
		}
		
		public function set rotation(r:Number) : void {
			m_decoratedBullet.rotation = r;
		}
	}
}