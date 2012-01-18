package imac.diehardkart.decorable.weapon {
	import imac.diehardkart.decorable.Decorator;
	
	public class WeaponDecorator extends Decorator implements IWeapon {
		
		public function WeaponDecorator(decoratedWeapon: IWeapon) {
			super(decoratedWeapon);
		}
	}
}
