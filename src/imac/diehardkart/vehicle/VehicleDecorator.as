package imac.diehardkart.vehicle {
	import flash.events.Event;

	/**
	 * Decorator parent for all the vehicle's Decorator Pattern
	 * @author muxisar
	 */
	public class VehicleDecorator extends IVehicle {
		private var m_decoratedVehicle : IVehicle;
		
		public function VehicleDecorator(decoratedVehicle:IVehicle) {
			m_decoratedVehicle = decoratedVehicle;
		}
		
		private function e_action(evt:Event) : void {
			m_decoratedVehicle.e_action(evt);
		}
		
		private function explode() : void {
			m_decoratedVehicle.explode();
		}
		
		private function e_die(evt:Event) : void {
			m_decoratedVehicle.e_die(evt);			
		}
		
		public override function looseLife() : void {
			m_decoratedVehicle.looseLife();
		}
	}
}
