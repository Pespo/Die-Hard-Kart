package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.Decorator;

	public class VehicleDecorator extends Decorator implements IVehicle {
		
		public function VehicleDecorator(decoratedVehicle : IVehicle) {
			super(decoratedVehicle);
		}
		
		public function looseLife(damage : Number) : Number {
			var deco : IVehicle = super.m_decorated as IVehicle;
			return deco.looseLife(damage);
		}
		
	}
}