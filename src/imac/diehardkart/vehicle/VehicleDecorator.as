package imac.diehardkart.vehicle {
	import flash.display.MovieClip;

	/**
	 * Decorator parent for all the vehicle's Decorator Pattern
	 * @author muxisar
	 */
	public class VehicleDecorator extends MovieClip implements IVehicle {
		private var m_decoratedVehicle : IVehicle;
		
		public function VehicleDecorator(decoratedVehicle : IVehicle) {
			m_decoratedVehicle = decoratedVehicle;
		}
		
		public function explode() : void {
			m_decoratedVehicle.explode();
		}
		
		public function looseLife() : void {
			m_decoratedVehicle.looseLife();
		}
	}
}
