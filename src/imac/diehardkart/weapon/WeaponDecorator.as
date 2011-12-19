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

		public function shoot() : void {
			m_decoratedWeapon.shoot();
		}
		
		public function e_addedToStage(evt:Event) : void {
			m_decoratedWeapon.e_addedToStage(evt);
		}
		
		public function e_removedFromStage(evt:Event) : void {
			m_decoratedWeapon.e_removedFromStage(evt);
		}
		
		public function get movement():Movement {
			return m_decoratedWeapon.movement;
		}
		
		public function set movement(movement:Movement) : void {
			m_decoratedWeapon.movement = movement;
		}
	}
}
