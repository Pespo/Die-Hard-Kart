package imac.diehardkart.weapon {
	import flash.display.MovieClip;
	import imac.diehardkart.weapon.Weapon;

	public class WeaponDecorator extends MovieClip implements Weapon {
		private var m_decoratedWeapon : Weapon;
		public function WeaponDecorator(decoratedVehicle : Weapon) {
			m_decoratedWeapon = decoratedVehicle;
		}

		public function action() : void {
			m_decoratedWeapon.action();
		}
	}
}
