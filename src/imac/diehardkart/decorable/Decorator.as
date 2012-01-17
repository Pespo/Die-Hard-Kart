package imac.diehardkart.decorable {
	import flash.events.EventDispatcher;
	import flash.display.MovieClip;

	public class Decorator extends EventDispatcher implements IDecorator {
		
		protected var m_decorated : IDecorator;
		
		public function Decorator(decorated : IDecorator) {
			m_decorated = decorated;
		}
		
		public function get view() : MovieClip {
			return m_decorated.view;
		}
		
		public function set view(v : MovieClip) : void {
			m_decorated.view = v;
		}
		
		public function loop() : void {
			m_decorated.loop();
		}
		
		public function rotate(a : Number) : void {
			m_decorated.rotate(a);
		}
		
		public function set speed(s : Number) : void {
			m_decorated.speed = s;
		}
		
		public function get speed() : Number {
			return m_decorated.speed;
		}
		
		public function get x() : Number {
			return m_decorated.x;
		}
		
		public function get y() : Number {
			return m_decorated.y;
		}
		
		public function set x(x : Number) : void {
			m_decorated.x = x;
		}
		
		public function set y(y : Number) : void {
			m_decorated.y = y;
		}
		
		public function get dx() : Number {
			return m_decorated.dx;
		}
		
		public function get dy() : Number {
			return m_decorated.dy;
		}
		
		public function get height() : Number {
			trace("get height");
			return m_decorated.height;
		}
		
		public function get width() : Number {
			trace("get width");
			return m_decorated.width;
		}
		
		public function setOrientation(dx : Number, dy : Number) : void {
			m_decorated.setOrientation(dx, dy);
		}
		
		public function destructor() : void {
			trace("Destruct Decorator");
			m_decorated.destructor();
			m_decorated = null;
		}
	}
}