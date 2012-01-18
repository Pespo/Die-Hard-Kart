package imac.diehardkart.decorable {
	import flash.display.Sprite;

	public class PhysicalElement extends Sprite {
		private var m_dx : Number;
		private var m_dy : Number;
		private var m_speed : Number;
		
		public static const STANDARD_SPEED : Number = 2;
		public static const MAX_SPEED : Number = 10;
		public static const MIN_SPEED : Number = 0;
		public static const STANDARD_ANGLE : Number = 0;
		public static const STANDARD_DX : Number = 0.5;
		public static const STANDARD_DY : Number = 0;

		public function PhysicalElement(angle : Number = STANDARD_ANGLE,
								speed : Number = STANDARD_SPEED) {
			
			this.setRotation(angle);
			this.speed = speed;
		}

		public function move() : void {
			x += (m_dx * m_speed);
			y += (m_dy * m_speed);
		}

		/**
		 * Relative rotation from the current angle
		 */
		public function rotate(angle : Number) : void {
			trace(this);
			rotation += angle;
			setRotation(rotation);
			trace("rotate : " + rotation);
		}

		public function orientate(dx : Number, dy : Number) : void {
			m_dx += dx;
			m_dy += dy;
			setOrientation(m_dx, m_dy);
		}

		/**
		 * Absolute rotation from the zero angle
		 */
		public function setRotation(angle : Number) : void {
			trace(this);
			rotation = angle;
			m_dx = Math.cos(Math.PI * angle / 180);
			m_dy = Math.sin(Math.PI * angle / 180);
			trace("setRotation : " + rotation);

		}

		public function setOrientation(dx : Number, dy : Number) : void {
			trace(this);
			setNormalized(dx, dy);
			rotation = 180 * Math.acos(m_dx) / Math.PI * (m_dy >= 0 ? 1 : -1);
			trace("setOrientation : " + rotation);
		}

		/**
		 * Absolute orientation from the zero direction
		 */
		private function setNormalized(dx : Number, dy : Number) : void {
			var norm : Number = Math.sqrt(dx * dx + dy * dy);
			m_dx = (norm == 0) ? 0 : dx / norm;
			m_dy = (norm == 0) ? 0 : dy / norm;
		}
		
		public function set speed(s : Number) : void {
			m_speed = (s >= MIN_SPEED && s <= MAX_SPEED) ? s : STANDARD_SPEED;
		}
		
		public function get speed() : Number {
			return m_speed;
		}
		
		public function get dx() : Number {
			return dx;
		}
		
		public function get dy() : Number {
			return dy;
		}
		
		public function destructor() : void {
			//trace("Destruct PhysicalElement");
		}
	}
}
