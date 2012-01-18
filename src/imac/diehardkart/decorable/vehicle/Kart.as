package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.PhysicalElement;

	public class Kart extends VehicleDecorator {
		
		private var m_controls : Array;
		public static const MAX_SPEED_ON_ROAD : Number = PhysicalElement.MAX_SPEED / 2;
		public static const MAX_SPEED_ON_SAND : Number = PhysicalElement.MAX_SPEED / 5;
		
		// Should be static !
		public static var MAX_SPEED : Number = PhysicalElement.MAX_SPEED / 2;
		public static const MIN_SPEED : Number = PhysicalElement.MIN_SPEED;
		private static const ROTATION : int = 3;
		
		public static const FORWARD : Number = 0;
		public static const BACKWARD : Number = 1;
		public static const LEFT : Number = 2;
		public static const RIGHT : Number = 3;
		
		public function Kart(decoratedVehicle : IVehicle) {
			super(decoratedVehicle);
			speed = 0;
			m_controls = new Array();
			for (var i : int = 0; i < 4; ++i) {
				m_controls.push(false);
			}
		}
		
		override public function loop() : void {
			super.loop();
			updatePostion();
			friction();
		}
		
		private function friction() : void {
			trace("speed " + speed);
			if(speed >= 0) {speed = speed  - 0.1 >= 0 ? speed - 0.1 : 0;}
			else if(speed<0){speed = speed  + 0.1 < 0 ? speed + 0.1 : 0;}
		}

		public function setDirection(dir : Number, state : Boolean) : void {
			m_controls[dir] = state;
		}

		private function updatePostion() : void {
			if (m_controls[LEFT] && (speed >= 0.5 || speed <= -0.5)) {
				rotate(-ROTATION);
			}
			
			if (m_controls[FORWARD]) {
				speed += speed + 0.5 <= MAX_SPEED ? 0.5 : MAX_SPEED - speed;
			}
			
			if (m_controls[RIGHT] && (speed >= 0.5 || speed <= -0.5)) {
				rotate(ROTATION);
			}
			
			if (m_controls[BACKWARD]) {
				speed -= speed - 0.5 >= MIN_SPEED ? 0.5 : 0;
			}
		}
	}
}