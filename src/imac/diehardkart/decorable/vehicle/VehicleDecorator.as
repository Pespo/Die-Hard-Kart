package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.Decorator;

	public class VehicleDecorator extends Decorator implements IVehicle {
		
		public function VehicleDecorator(decoratedVehicle : IVehicle) {
			super(decoratedVehicle);
		}
	}
}