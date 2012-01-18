package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.weapon.IWeapon;

	public class ArmedVehicle extends VehicleDecorator {
		
		private var m_weapons : Vector.<IWeapon>;
		private var m_dirigibleWeapon : Boolean;
		
		public function ArmedVehicle(decoratedVehicle : IVehicle, weapons : Vector.<IWeapon>, dirigible : Boolean = false) {
			super(decoratedVehicle);
			m_weapons = weapons;
			m_dirigibleWeapon = dirigible;
			for each (var weapon : IWeapon in m_weapons) {
				position(weapon);
			}
		}

		private function position(weapon : IWeapon) : void {
			weapon.x = x;
			weapon.y = y;
			if (!m_dirigibleWeapon)
				weapon.rotation = rotation;
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
				weapon.setOrientation(dx, dy);
			}
		}
		
		override public function destructor() : void {
			//trace("Destruct ArmedVehicle");
			super.destructor();
			for each (var weapon : IWeapon in m_weapons) {
				weapon.destructor();
			}
		}
	}
}

