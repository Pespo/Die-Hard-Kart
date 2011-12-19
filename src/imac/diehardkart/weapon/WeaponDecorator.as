package imac.diehardkart.weapon {
	import flash.display.MovieClip;
	import imac.diehardkart.weapon.Weapon;
	
	/**
	 * Decorator parent for all the weapon's Decorator Pattern
	 * @author muxisar
	 */
	public class WeaponDecorator extends MovieClip implements Weapon {
		private var m_decoratedWeapon : Weapon;
		
		/**
		 * Construct a WeaponDecorator
		 * @param decoratedBullet an instance of <code>imac.diehardkart.weapon.WeaponDecorator</code>
		 */
		public function WeaponDecorator(decoratedVehicle : Weapon) {
			m_decoratedWeapon = decoratedVehicle;
		}

		public function shoot() : void {
			m_decoratedWeapon.shoot();
		}
	}
}
