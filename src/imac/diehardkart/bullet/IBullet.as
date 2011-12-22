package imac.diehardkart.bullet {
	import flash.display.Stage;
	import imac.diehardkart.utils.Movement;

	public interface IBullet {
		function loop() : void;
		function get stage() : Stage;
		function get x() : Number;
		function set x(x:Number) : void;
		function get y() : Number;
		function set y(y:Number) : void;
		function get damage() : Number;
		function get movement() : Movement;
		function set movement(movement:Movement) : void;
		function get rotation() : Number;
		function set rotation(r:Number) : void;
		function display() : void;
	}
}
