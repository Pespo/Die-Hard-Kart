package imac.diehardkart.vehicle {
	import flash.events.Event;
	
	/** 
	 * Interface of the vehicle's Decorator Pattern
	 * @author muxisar
	 */ 
	public interface IVehicle {
		function e_action(evt:Event) : void;
		function e_addedToStage(evt:Event) : void;
		function e_removedFromStage(evt:Event) : void;
		function explode() : void;
		function die() : void;
		function looseLife() : void;
	}

}