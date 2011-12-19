package imac.diehardkart.weapon {
	import imac.diehardkart.game.Game;
	import imac.diehardkart.bullet.BulletType;
	import flash.display.MovieClip;
	import imac.diehardkart.weapon.Weapon;

	public class StandardWeapon extends MovieClip implements Weapon {
		
		private var m_bulletType : Number;		// Type of the bullet to launch
		private var m_shootRate : Number; 		// 
		private var GAME_REF : Game;
		
		public function StandardWeapon(weaponType : Number = WeaponType.STANDARD_WEAPON) {
			
		}
		
		public function shoot() : void {
			
		}
	}
}
