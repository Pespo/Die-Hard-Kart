package imac.diehardkart.game {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import imac.diehardkart.utils.CustomEvent;
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.bullet.StandardBullet;
	import imac.diehardkart.vehicle.StandardVehicle;
	import flash.display.Stage;
	
	public class Game extends Sprite {
		
		public function Game() {
			StandardVehicle.GAME_REF = this;
			var st : StandardVehicle = new StandardVehicle(new Movement(0.8, 1, 1), 1, 10);
			st.addEventListener(CustomEvent.DEAD, e_deadElement);
			st.x = 300;
			st.y = 300;
			addChild(st);
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
