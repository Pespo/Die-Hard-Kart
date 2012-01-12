package imac.diehardkart.weapon {
	import imac.diehardkart.utils.Physics;
	import imac.diehardkart.bullet.IBullet;
	
	/** 
	 * Interface of the weapon's Decorator Pattern
	 */ 
	public interface IWeapon {
		//function display() : void;
		function get physics() : Physics;
		function set physics(m:Physics) : void;
		function get physicsHolder() : Physics;
		function set physicsHolder(m:Physics) : void;
		function get bullet() : IBullet;
		function set bullet(value:IBullet) : void;
		function makeBullet() : IBullet;
		function shoot() : void
		function loop() : void ;
	}
}
