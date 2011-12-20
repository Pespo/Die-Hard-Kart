package imac.diehardkart.game {
	import flash.display.Stage;
	import flash.events.FocusEvent;
	import imac.diehardkart.vehicle.IVehicle;
	import imac.diehardkart.bullet.IBullet;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import imac.diehardkart.utils.CustomEvent;
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.bullet.StandardBullet;
	import imac.diehardkart.vehicle.StandardVehicle;
	
	public class Game extends Sprite {
		
		public static var m_stage:Stage;
		
		public function Game(stage:Stage) {
			m_stage = stage;
			IVehicle.GAME_REF = this;
			IBullet.GAME_REF = this;
			var st : StandardVehicle = new StandardVehicle(new Movement(1, 0.5, -0.5), 1, 10);
			var stdBullet : StandardBullet = new StandardBullet(new Movement(1, 0.5, 0.5), 1, 1);
			st.addEventListener(CustomEvent.DEAD, e_deadElement);
			st.x = 350;
			st.y = 50;
			addChild(st);
			stdBullet.addEventListener(CustomEvent.DEAD, e_deadElement);
			stdBullet.x = 250;
			st.y = 100;
			addChild(stdBullet);
		}
		
		private function e_deadElement(evt:CustomEvent) : void {
			if (contains(evt.target as DisplayObject))
				removeChild(evt.target as DisplayObject);
		}
		
		public function get playerBullets() : Vector.<StandardBullet> {
			return null;
		}
	}
}
