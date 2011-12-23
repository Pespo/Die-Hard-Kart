package imac.diehardkart.bullet {
	import imac.diehardkart.utils.Physics;

	public interface IBullet {
		function explode() : void;
		function loop() : void;
		function display() : void;
		function get physics() : Physics;
		function set physics(s:Physics) : void;
	}
}
