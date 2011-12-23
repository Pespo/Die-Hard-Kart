package imac.diehardkart.vehicle {
	import flash.display.Stage;
	import imac.diehardkart.game.Game;
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.utils.Labels;
	import imac.diehardkart.utils.CustomEvent;
	import flash.events.EventDispatcher;
	import imac.diehardkart.utils.Physics;

	public class StandardVehicle extends EventDispatcher implements IVehicle {
		
		private var m_physics : Physics;
		private var m_life : Number;
		private var m_damageExplosion : Number;
		private var m_rayExplosion : Number;
		private var m_coeffLoseLife : Number;
		public static var GAME : Game;
		public static var STAGE : Stage;
		public static const STANDARD_LIFE : Number = 100;
		public static const STANDARD_COEFF_LIFE : Number = 1;
		public static const STANDARD_DAMAGE_EXPLOSION : Number = 10;
		public static const STANDARD_RAY_EXPLOSION : Number = 20;
		
		public function StandardVehicle(life:Number = STANDARD_LIFE,
										coeffLoseLife:uint = STANDARD_COEFF_LIFE,
										damage:Number = STANDARD_DAMAGE_EXPLOSION,
										ray:Number = STANDARD_RAY_EXPLOSION) {
			
			m_life = life;
			m_damageExplosion = damage;
			m_coeffLoseLife = coeffLoseLife;
			m_rayExplosion = ray; 
			m_physics = new Physics("", Physics.STANDARD_ANGLE, 2);
		}
		
		public function display() : void {
			m_physics.gotoAndPlay(Labels.INIT);
			STAGE.addChild(m_physics);
		}
		
		public function loop() : void {
			trace(Math.random());
			m_physics.move();
			hitTest();
			outTest();
			deadTest();
		}
		
		private function deadTest() : void {
			if (m_physics.currentFrameLabel == Labels.EXPLOSION_DONE) {
				undisplay();
			}
		}
			
		private function explode() : void {
			die();
			m_physics.gotoAndPlay(Labels.EXPLOSION);
		}
		
		private function looseLife(d:uint) : void {
			m_life -= d * m_coeffLoseLife;
			if (m_life <= 0)
				explode();
		}
		
		private function hitTest() : void {
			for each(var bullet : IBullet in GAME.ennemiesBullets) {
				if (m_physics.hitTestObject(bullet)) {
					bullet.explode();
					/* this is is good -> *///looseLife(bullet.damage);
					/*       for testing -> */looseLife(1);
				}
			}
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