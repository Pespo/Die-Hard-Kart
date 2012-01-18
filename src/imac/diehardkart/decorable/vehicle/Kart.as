package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.PhysicalElement;

	public class Kart extends VehicleDecorator {
		
		private var m_controls : Array;
		public static const MAX_SPEED_ON_ROAD : Number = 5;
		public static const MAX_SPEED_ON_SAND : Number = 2;
		public static var MAX_SPEED : Number = PhysicalElement.MAX_SPEED / 4;
		public static const MIN_SPEED : Number = 0;
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
			speed -= speed  - 0.1 >= MIN_SPEED ? 0.1 : MIN_SPEED + speed;
		}

		public function setDirection(dir : Number) : void {
			m_controls[dir] = !m_controls[dir];
		}

		private function updatePostion() : void {
			if (m_controls[LEFT] && speed >= 1) {
				rotate(-ROTATION);
			}
			
			if (m_controls[FORWARD]) {
				speed += speed + 0.5 <= MAX_SPEED ? 0.5 : MAX_SPEED - speed;
			}
			
			if (m_controls[RIGHT] && speed >= 1) {
				rotate(ROTATION);
			}
			
			if (m_controls[BACKWARD]) {
				speed -= speed - 0.5 >= MIN_SPEED ? 0.5 : MIN_SPEED + speed;
			}
		}
	}
}