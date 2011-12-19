package imac.diehardkart.weapon {
	import flash.events.Event;
	/** 
	 * Interface of the weapon's Decorator Pattern
	 * @author muxisar
	 */ 
	public interface Weapon {
		function shoot() : void;
		function e_addedToStage(evt:Event) : void;
		function e_removedFromStage(evt:Event) : void;
		function get movement() : void;
		function set movement(movement:Movement) : void;
	}
}
