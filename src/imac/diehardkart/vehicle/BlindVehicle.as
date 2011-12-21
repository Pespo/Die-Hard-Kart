package imac.diehardkart.vehicle {
	import imac.diehardkart.vehicle.VehicleDecorator;
	import imac.diehardkart.vehicle.IVehicle;

	/**
	 * @author tom
	 */
	public class BlindVehicle extends VehicleDecorator {
		
		private var m_cptRotation;
		
		public function BlindVehicle(decoratedVehicle : IVehicle) {
			super(decoratedVehicle);
			m_cptRotation = 0;
		}
		
		public override function loop() : void {
			super.loop();
			randomDirection();
		}
		
		private function randomDirection() : void {
			m_cptRotation++;
			if (m_cptRotation == 10) {
				rotation += 2;
				m_cptRotation = 0;
			}
		}
	}
}
