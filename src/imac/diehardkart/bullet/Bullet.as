package imac.diehardkart.bullet {
	import flash.events.Event;
	import imac.diehardkart.utils.Movement;
	/** 
	 * Interface of the bullet's Decorator Pattern
	 * @author muxisar
	 */ 
	public interface Bullet {
		function e_addedToStage(evt:Event) : void;
		function e_removedFromStage(evt:Event) : void;
		function e_action(evt:Event) : void;
		function get movement() : Movement;
		function set movement(movement:Movement) : void;	
		function explode() : void;
		function die() : void;
	}
}
