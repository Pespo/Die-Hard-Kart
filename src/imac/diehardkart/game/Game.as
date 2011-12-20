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
			var st1 : StandardVehicle = new StandardVehicle(new Movement(1, 0.1, 0.3), 1, 10);
			var st2 : StandardVehicle = new StandardVehicle(new Movement(1, -0.5, 0.2), 1, 10);
			var st3 : StandardVehicle = new StandardVehicle(new Movement(1, 0.1, -0.4), 1, 10);
			var st4 : StandardVehicle = new StandardVehicle(new Movement(1, -0.5, -0.7), 1, 10);
			st1.addEventListener(CustomEvent.DEAD, e_deadElement);
			st2.addEventListener(CustomEvent.DEAD, e_deadElement);
			st3.addEventListener(CustomEvent.DEAD, e_deadElement);
			st4.addEventListener(CustomEvent.DEAD, e_deadElement);
			st1.x = 200;
			st1.y = 200;
			st2.x = 200;
			st2.y = 200;
			st3.x = 200;
			st3.y = 200;
			st4.x = 200;
			st4.y = 200;
			addChild(st1);
			addChild(st2);
			addChild(st3);
			addChild(st4);

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
			if (contains(evt.target as DisplayObject)) {
				var index : int = getChildIndex(evt.target as DisplayObject);
				var child : DisplayObject = getChildAt(index);
				removeChildAt(index);
				child = null;
			}	
		}
		
		public function get playerBullets() : Vector.<StandardBullet> {
			return null;
		}
	}
}
