package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.Decorator;
	import imac.diehardkart.decorable.weapon.IWeapon;

	public class ArmedVehicle extends VehicleDecorator {
		
		private var m_weapons : Vector.<IWeapon>;
		
		public function ArmedVehicle(decoratedVehicle : IVehicle, weapons : Vector.<IWeapon> ) {
			super(decoratedVehicle);
			m_weapons = weapons;
			for each (var weapon : IWeapon in m_weapons) {
				addChild(weapon.view);
			}
		}

		public override function loop() : void {
			super.loop();
		}
		
	}
}

