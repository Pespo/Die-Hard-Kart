package imac.diehardkart.vehicle {
	
	public interface IVehicle {
		function loop() : void;
		function set x(x:Number) : void;
		function set y(y:Number) : void;
		function set rotation(r:Number) : void;
		function get rotation() : Number;
		function display() : void;
	}
}