package imac.diehardkart.game {
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.bullet.StandardBullet;
	import imac.diehardkart.vehicle.StandardVehicle;
	import flash.display.Stage;
	
	public class Game {
		private static var m_stage : Stage;
		
		public function Game(stage : Stage) {
			m_stage = stage;
			StandardVehicle.GAME_REF = this;
			var st : StandardVehicle = new StandardVehicle(new Movement(0.8, 1, 1), 1, 0);
			st.x = 300;
			st.y = 300;
			m_stage.addChild(st);
			
		}
		
		public function get stage() : Stage {
			return m_stage; 
		}
		
		public function get playerBullets() : Vector.<StandardBullet> {
			return null;
		}
	}
}
