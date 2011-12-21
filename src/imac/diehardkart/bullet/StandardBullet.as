package imac.diehardkart.bullet {
	import flash.display.Stage;
	import imac.diehardkart.game.Game;
	import flash.display.MovieClip;
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.utils.CustomEvent;
	import flash.events.Event;
	import imac.diehardkart.utils.FrameLabel;
	
	public class StandardBullet implements IBullet {
		
		private var m_display : MovieClip;
		private var m_movement : Movement;
		public var m_data : XMLList;
		public static var GAME : Game;
		public static var STAGE : Stage;
		
		public function StandardBullet(xml:XMLList) {
			m_data = xml;
			m_display = new SkinBullet();
			m_movement = new Movement();
			orientate();
		}
		
		public function display() : void {
			STAGE.addChild(m_display);
		}
		
		public function get stage() : Stage {
			return STAGE;
		}
		
		public function get x() : Number {
			return m_display.x;
		}
		
		public function set x(x:Number) : void {
			m_display.x = x;
		}
		
		public function set y(y:Number) : void {
			m_display.y = y;
		}
		
		public function get y() : Number {
			return m_display.y;
		}
		
		public function get movement() : Movement {
			return m_movement;
		}
		
		public function set movement(movement:Movement) : void {
			m_movement = movement;
		}
		
		public function set rotation(r:Number) : void {
			m_display.rotation = r;
		}
		
		public function get rotation() : Number {
			return m_display.rotation;
		}
		
		public function set width(w:Number) : void {
			m_display.width = w;
		}
		
		public function get width() : Number {
			return m_display.width;
		}
		
		public function set height(h:Number) : void {
			m_display.height = h;
		}
		
		public function get height() : Number {
			return m_display.height;
		}
		
		private function move() : void {
			x = m_movement.make(x, Movement.AXIS_X);
			y = m_movement.make(y, Movement.AXIS_Y);
		}
	
		private function orientate() : void {
			if (m_movement.dx >= 0) {
				rotation = (180 * Math.asin(m_movement.dy) / Math.PI);
			} else if (m_movement.dx <= 0 && m_movement.dy >= 0) {
				rotation = - (180 * Math.asin(m_movement.dx) / Math.PI) + 90;
			} else if (m_movement.dx <= 0 && m_movement.dy <= 0) {
				rotation = - (180 * Math.asin(m_movement.dy) / Math.PI) + 180;
			}
		}
		
		private function hitTest() : void {
			
		}
		
		public function loop() : void {
			move();
			hitTest();
			outTest();
		}
		
		private function outTest() : void {
			if (x < -width || y < -height || x > STAGE.stageWidth || y > STAGE.stageHeight) {
				destruct();
			}
		}
		
		/*private function gotoAndPlay(s:String) : void {
			
		}
		
		private function explode() : void {
			gotoAndPlay(FrameLabel.EXPLOSION);
		}
		
		private function looseLife() : void {
			
		}*/
		
		private function destruct() : void {
		
		}
	}
}