package imac.diehardkart.decorable.bullet {
	import imac.diehardkart.decorable.IDecorator;
	
	public interface IBullet extends IDecorator {
		function clone() : IBullet;
		function get damage() : Number;
		function explode() : void;
	}
}