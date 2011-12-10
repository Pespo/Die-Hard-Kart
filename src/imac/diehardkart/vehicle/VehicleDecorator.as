package imac.diehardkart.vehicle {
	import flash.display.MovieClip;

	import imac.diehardkart.vehicle.Vehicle;

	public class VehicleDecorator extends MovieClip implements Vehicle {
		private var m_decoratedVehicle : Vehicle;
		public function VehicleDecorator(decoratedVehicle : Vehicle) {
			m_decoratedVehicle = decoratedVehicle;
		}

		public function action() : void {
			m_decoratedVehicle.action();
		}
	}
}
