package imac.diehardkart.bullet {
	import flash.display.Stage;
	import imac.diehardkart.game.Game;
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.utils.Labels;
	import imac.diehardkart.utils.CustomEvent;
	import flash.events.EventDispatcher;
	import imac.diehardkart.utils.Physics;

	public class StandardBullet extends EventDispatcher implements IBullet {
		
		private var m_physics : Physics;
		private var m_damage : Number;
		public static var GAME : Game;
		public static var STAGE : Stage;
		public static const STANDARD_DAMAGE : Number = 10;
		
		public function StandardBullet(damage:Number = STANDARD_DAMAGE) {
			
			
			m_damage = damage;
			m_physics = new Physics("", Physics.STANDARD_ANGLE, 2);
		}
		
		public function display() : void {
			m_physics.gotoAndPlay(Labels.INIT);
			STAGE.addChild(m_physics);
		}
		
		public function loop() : void {
			trace(Math.random());
			m_physics.move();
			outTest();
			deadTest();
		}
		
		private function deadTest() : void {
			if (m_physics.currentFrameLabel == Labels.EXPLOSION_DONE) {
				undisplay();
			}
		}
			
		public function explode() : void {
			die();
			m_physics.gotoAndPlay(Labels.EXPLOSION);
		}
				
		public function outTest() : void {
			if (m_physics.x < -m_physics.width / 2 || m_physics.y < -m_physics.height / 2 || m_physics.x > STAGE.stageWidth + m_physics.width / 2 || m_physics.y > STAGE.stageHeight + m_physics.height / 2) {
				die();
				undisplay();
			}
		}
		
		private function die() : void {
			dispatchEvent(new CustomEvent(CustomEvent.DEAD));
		}
		
		private function undisplay() : void {
			STAGE.removeChild(m_physics);
		}
		
		public function get physics() : Physics {
			return m_physics;
		}
		
		public function set physics(m:Physics) : void {
			m_physics = m;
		}
	}
}