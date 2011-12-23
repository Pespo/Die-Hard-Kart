package imac.diehardkart.vehicle {
	import imac.diehardkart.vehicle.VehicleDecorator;
	import imac.diehardkart.vehicle.IVehicle;

	/**
	 * @author tom
	 */
	public class BlindVehicle extends VehicleDecorator {
		
		private var m_randomCpt : uint;
		private var m_waitBeforeTurn : uint;
		private var m_wayRotation : int;
		private var m_possiblesRotation : Array;
		
		public function BlindVehicle(decoratedVehicle : IVehicle) {
			super(decoratedVehicle);
			m_randomCpt = 0;
			waitBeforeTurn();
			m_possiblesRotation = new Array(-1, 0, 1);
			wayRotation();
		}
		
		public override function loop() : void {
			super.loop();
			randomDirection();
		}
		
		private function randomDirection() : void {
			++m_randomCpt;
			if (m_randomCpt == m_waitBeforeTurn) {
				wayRotation();
				waitBeforeTurn();
				m_randomCpt = 0;				
			}
			physics.rotate(m_wayRotation);
		}
		
		private function waitBeforeTurn() : void {
			m_waitBeforeTurn = Math.round(Math.random() * (200 - 50)) + 50;
		}
		
		private function wayRotation() : void {
			m_wayRotation = m_possiblesRotation[Math.floor(Math.random() * m_possiblesRotation.length)];
		}
	}
}
