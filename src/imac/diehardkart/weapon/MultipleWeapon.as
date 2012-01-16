package imac.diehardkart.weapon {
	
	import flash.events.Event;
	import imac.diehardkart.bullet.IBullet;
	import flash.geom.Point;
	import imac.diehardkart.utils.Labels;
	import imac.diehardkart.weapon.WeaponDecorator;
	import imac.diehardkart.weapon.IWeapon;
	import imac.diehardkart.vehicle.IVehicle;
	
	public class MultipleWeapon extends WeaponDecorator {
		
		protected static const STANDARD_NUMBER_BULLET : Number = 10;
		protected static const MAX_NUMBER_BULLET : Number = 10;
		protected var m_nbrBullet : Number;
			
		public function MultipleWeapon(decoratedWeapon: IWeapon, nbrBullet : Number = STANDARD_NUMBER_BULLET) {
			super(decoratedWeapon);
			m_nbrBullet = nbrBullet;			
		}
		
		public override function loop() : void {
			trace("rotation avant" + bullet.physics.rotation);
				physics.rotate( -30);
			trace("rotation apres" + bullet.physics.rotation);
				super.loop();
				physics.rotate(30);
				super.loop();
				physics.rotate(30);
				super.loop();
				physics.rotate(-30);
		}
		
		//public function setBullet(position:Number) : void {
			//
		//}
		
	}
}