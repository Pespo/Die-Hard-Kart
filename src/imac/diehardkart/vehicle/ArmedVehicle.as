package imac.diehardkart.vehicle {
	import imac.diehardkart.weapon.IWeapon;
	import imac.diehardkart.vehicle.VehicleDecorator;
	import imac.diehardkart.vehicle.IVehicle;

	/**
	 * @author tom
	 */
	public class ArmedVehicle extends VehicleDecorator {
		
		private var m_weapons : Vector.<IWeapon>;
		
		public function ArmedVehicle(decoratedVehicle : IVehicle, weapons : Vector.<IWeapon> ) {
			super(decoratedVehicle);
			m_weapons = weapons;
			for each (var weapon : IWeapon in m_weapons) {
				physics.addChild(weapon.physics);
			}
		}
		
		private function transmitPhysic() : void {
			for each (var weapon : IWeapon in m_weapons) {
				weapon.physicsHolder = physics;
			}
		}
		
		public override function loop() : void {
			transmitPhysic();
			super.loop();
		}
		
	}
}
