package imac.diehardkart.decorable.weapon {
	import imac.diehardkart.decorable.Decorator;
	import flash.events.Event;
	import imac.diehardkart.decorable.bullet.IBullet;
	import flash.geom.Point;
	import imac.diehardkart.utils.Labels;
	import imac.diehardkart.decorable.weapon.WeaponDecorator;
	import imac.diehardkart.decorable.weapon.IWeapon;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	public class OrientedWeapon extends WeaponDecorator {

		public function OrientedWeapon(decoratedWeapon:IWeapon) {
			super(decoratedWeapon);		
		}
			
		public function aim(mouseX : Number, mouseY : Number) : void {

			setOrientation(mouseX - x, mouseY - y);
		}
	}
}

