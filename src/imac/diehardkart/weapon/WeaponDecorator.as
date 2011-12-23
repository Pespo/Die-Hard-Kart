package imac.diehardkart.weapon {
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.utils.Physics;
	import flash.display.MovieClip;
	import imac.diehardkart.weapon.IWeapon;
	
	/**
	 * Decorator parent for all the weapon's Decorator Pattern
	 * @author muxisar
	 */
	public class WeaponDecorator extends MovieClip implements IWeapon {
		private var m_decoratedWeapon : IWeapon;
		
		/**
		 * Construct a WeaponDecorator
		 * @param decoratedBullet an instance of <code>imac.diehardkart.weapon.WeaponDecorator</code>
		 */
		public function WeaponDecorator(decoratedVehicle : IWeapon) {
			m_decoratedWeapon = decoratedVehicle;
		}
		
		/*public function display() : void {
			m_decoratedWeapon.display();
		}*/
		
		public function get physics() : Physics {
			return m_decoratedWeapon.physics;
		}
		public function set physics(s:Physics) : void {
			m_decoratedWeapon.physics = s;
		}
		
		public function get physicsHolder() : Physics {
			return m_decoratedWeapon.physics;
		}
		public function set physicsHolder(s:Physics) : void {
			m_decoratedWeapon.physics = s;
		}
		
		public function setBullet() : IBullet {
			return m_decoratedWeapon.setBullet();
		}

		public function shoot() : void {
			m_decoratedWeapon.shoot();
		}

		public function loop() : void {
			m_decoratedWeapon.loop();
		}
	}
}
