package imac.diehardkart.weapon {
	import imac.diehardkart.utils.Movement;
	import flash.events.Event;
	
	/** 
	 * Interface of the weapon's Decorator Pattern
	 * @author muxisar
	 */ 
	public interface IWeapon {
		function shoot() : void;
		function e_addedToStage(evt:Event) : void;
		function e_removedFromStage(evt:Event) : void;
		function get movement() : Movement;
		function set movement(movement:Movement) : void;
	}
}
