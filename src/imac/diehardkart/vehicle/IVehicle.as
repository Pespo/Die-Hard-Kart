package imac.diehardkart.vehicle {
	import imac.diehardkart.utils.Physics;
	
	public interface IVehicle {
		function loop() : void;
		function display() : void;
		function get physics() : Physics;
		function set physics(s:Physics) : void;
	}
}