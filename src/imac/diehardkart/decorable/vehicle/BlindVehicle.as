package imac.diehardkart.decorable.vehicle {
	import com.gskinner.utils.Rndm;

	public class BlindVehicle extends VehicleDecorator {

		private var m_frameCounter : uint;
		private var m_wait : uint;
		private var m_rotation : int;
		private var m_rotations : Array;
		private static const MAX_WAIT : uint = 50;
		private static const MIN_WAIT : uint = 10;
		
		public function BlindVehicle(decoratedVehicle : IVehicle) {
			super(decoratedVehicle);
			m_frameCounter = 0;
			m_rotations = new Array(-1, 0, 1);
			m_wait = MIN_WAIT;
			m_rotation = 0;
		}
		
		override public function loop() : void {
			super.loop();
			randomizeDirection();
		}
		
		private function randomizeDirection() : void {
			++m_frameCounter;
			if (m_frameCounter == m_wait) {
				computeRotation();
				computeWait();
				m_frameCounter = 0;				
			}
			rotate(m_rotation);
		}
		
		private function computeWait() : void {
			m_wait = Rndm.integer(MIN_WAIT, MAX_WAIT);//Math.round(Math.random() * (MAX_WAIT - MIN_WAIT)) + MIN_WAIT;
		}
		
		private function computeRotation() : void {
			m_rotation = m_rotations[Rndm.integer(0, m_rotations.length)];//Math.floor(Math.random() * m_rotations.length)];
		}
	}
}
