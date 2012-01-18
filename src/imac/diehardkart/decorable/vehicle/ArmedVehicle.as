package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.weapon.IWeapon;

	public class ArmedVehicle extends VehicleDecorator {
		
		private var m_weapons : Vector.<IWeapon>;
		
		public function ArmedVehicle(decoratedVehicle : IVehicle, weapons : Vector.<IWeapon> ) {
			super(decoratedVehicle);
			m_weapons = weapons;
			for each (var weapon : IWeapon in m_weapons) {
				position(weapon);
			}
		}

		private function position(weapon : IWeapon) : void {
			weapon.x = x;
			weapon.y = y;
		}
		
		public override function loop() : void {
			super.loop();
			for each (var weapon : IWeapon in m_weapons) {
				position(weapon);
			}
		}
		
		override public function setOrientation(dx : Number, dy : Number) : void {
			super.setOrientation(dx, dy);
			for each (var weapon : IWeapon in m_weapons) {
				trace("");
				weapon.setOrientation(dx, dy);
			}
		}
	}
}

