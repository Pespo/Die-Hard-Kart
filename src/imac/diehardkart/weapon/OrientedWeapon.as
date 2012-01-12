package imac.diehardkart.weapon {
	
	import flash.events.Event;
	import imac.diehardkart.bullet.IBullet;
	import flash.geom.Point;
	import imac.diehardkart.utils.Labels;
	import imac.diehardkart.weapon.WeaponDecorator;
	import imac.diehardkart.weapon.IWeapon;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	public class OrientedWeapon extends WeaponDecorator {

		public static var STAGE : Stage;
		public function OrientedWeapon(decoratedWeapon:IWeapon) {
			super(decoratedWeapon);		
			//StandardWeapon.STAGE.addEventListener(MouseEvent.MOUSE_MOVE, aim);
		}
			
		private function aim() : void {
			physics.setOrientation( STAGE.mouseX - physics.parent.x, STAGE.mouseY - physics.parent.y);
		}
		
		public override function loop() : void {
			aim();
			super.loop();
		}
		
		//public function setBullet(position:Number) : void {
			//
		//}
		
	}
}