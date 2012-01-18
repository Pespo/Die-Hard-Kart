package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.PhysicalElement;
	import assets.skins.Kart;

	public class Kart extends VehicleDecorator {
		
		private var m_controls : Array;
		public static const MAX_SPEED_ON_ROAD : Number = PhysicalElement.MAX_SPEED / 5;
		public static const MAX_SPEED_ON_SAND : Number = MAX_SPEED_ON_ROAD/ 3;
		public static var MAX_SPEED : Number = MAX_SPEED_ON_ROAD;
		public static const MIN_SPEED : Number = PhysicalElement.MIN_SPEED;
		private static const ROTATION : int = 3;
		private static const ACCELERATION : Number = MAX_SPEED_ON_ROAD/20;
		private static const FRICTION : Number = ACCELERATION/10;
		
		public static const FORWARD : Number = 0;
		public static const BACKWARD : Number = 1;
		public static const LEFT : Number = 2;
		public static const RIGHT : Number = 3;
		
		private var implementSkinKart : assets.skins.Kart = new assets.skins.Kart();		
		
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
			if (!m_controls[FORWARD]  &&  !m_controls[BACKWARD]) 
				friction();
		}
		
		private function friction() : void {
			if (speed >= 0) {
				speed = speed  - FRICTION >= 0 ? speed - FRICTION : 0;
			} else if (speed < 0) {
				speed = speed  + FRICTION < 0 ? speed + FRICTION : 0;
			}
		}
		
	   public function setDirection(dir : Number, state : Boolean) : void {
			   m_controls[dir] = state;
		}
		
		private function updatePostion() : void {
			if (m_controls[LEFT] && (speed >= ACCELERATION || speed <= -ACCELERATION)) {
				rotate(-ROTATION);
			}
			
			if (m_controls[FORWARD]) {
				speed += speed + ACCELERATION <= MAX_SPEED ? ACCELERATION : MAX_SPEED - speed;
			}
			
			if (m_controls[RIGHT] && (speed >= ACCELERATION|| speed <= -ACCELERATION)) {
				rotate(ROTATION);
			}
			
			if (m_controls[BACKWARD]) {
				speed -= speed - ACCELERATION >= MIN_SPEED ? ACCELERATION : 0;
			}
		}
	}
}