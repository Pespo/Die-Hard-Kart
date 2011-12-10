package imac.diehardkart.bullet {
	import flash.display.MovieClip;
	import imac.diehardkart.bullet.Bullet;

	public class BulletDecorator extends MovieClip implements Bullet {
		private var m_decoratedBullet : Bullet;
		public function BulletDecorator(decoratedVehicle : Bullet) {
			m_decoratedBullet = decoratedVehicle;
		}

		public function action() : void {
			m_decoratedBullet.action();
		}
	}
}
