package imac.diehardkart.vehicle {
	import flash.events.Event;
	
	/** 
	 * Interface of the vehicle's Decorator Pattern
	 * @author muxisar
	 */ 
	public interface IVehicle {
		function e_action(evt:Event) : void;
		function explode() : void;
		function e_die(evt:Event) : void;
		function looseLife() : void;
	}

}