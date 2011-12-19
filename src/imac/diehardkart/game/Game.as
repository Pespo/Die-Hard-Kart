package imac.diehardkart.game {
	import imac.diehardkart.bullet.StandardBullet;
	import imac.diehardkart.vehicle.StandardVehicle;
	import flash.display.Stage;
	
	public class Game {
		private static var m_stage : Stage;
		
		public function Game(stage : Stage) {
			m_stage = stage;
			StandardVehicle.GAME_REF = this;
		}
		
		public function get stage() : Stage {
			return m_stage; 
		}
		
		public function get playerBullets() : Vector.<StandardBullet> {
			return null;
		}
	}
}
