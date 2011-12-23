package imac.diehardkart.weapon {
	import imac.diehardkart.utils.Movement;
	import flash.events.Event;
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
		
		public function display() : void {
			m_decoratedWeapon.display();
		}
		
		function get physics() : Physics {
			return m_decoratedWeapon.physics;
		}
		function set physics(s:Physics) : void {
			m_decoratedWeapon.physics = s;
		}
		function setBullet() : IBullet {
			m_decoratedWeapon.setBullet();
		}

		public function shoot() : void {
			m_decoratedWeapon.shoot();
		}

		function loop() : void {
			m_decoratedWeapon.loop();
		}
	}
}
