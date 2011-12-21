package imac.diehardkart.vehicle {
	import imac.diehardkart.weapon.IWeapon;
	import imac.diehardkart.vehicle.VehicleDecorator;
	import imac.diehardkart.vehicle.IVehicle;

	/**
	 * @author tom
	 */
	public class ArmedVehicle extends VehicleDecorator {
		
		public function ArmedVehicle(decoratedVehicle : IVehicle) {
			super(decoratedVehicle);
		}
	}
}
