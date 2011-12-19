package imac.diehardkart.utils {
	
	public class Movement {
		
		private var m_dx : Number;
		private var m_dy : Number;
		private var m_speed : Number;
		public static const AXIS_X : String = "axe x";
		public static const AXIS_Y : String = "axe y";
		public static const STANDARD_SPEED : Number = 0.5;
				
		public function Movement(speed:Number = STANDARD_SPEED, dx:Number = 1, dy:Number = 0) {
			var norm : Number = Math.sqrt(dx * dx + dy * dy);
			m_dx = (norm == 0) ? 0 : dx / norm;
			m_dy = (norm == 0) ? 0 : dy / norm;
			m_speed = (speed >= 0 && speed <= 1) ? speed : STANDARD_SPEED; 
		}
		
		public function get dx() : Number {
			return m_dx;
		}
		
		public function get dy() : Number {
			return m_dy;
		}
		
		public function get speed() : Number {
			return m_speed;
		}
		
		public function setDirection(dx:Number, dy:Number) : void {
			var norm : Number = Math.sqrt(dx * dx + dy * dy);
			m_dx = (norm == 0) ? 0 : dx / norm;
			m_dy = (norm == 0) ? 0 : dy / norm;
		}
		
		public function set speed(s:Number) : void {
			m_speed = (s >= 0 && s <= 1) ? s : STANDARD_SPEED; 
		}
		
		public function make(current:Number, axis:String) : Number {
			switch(axis) {
				case AXIS_X :
					return current + (m_dx * m_speed);
					break;
				case AXIS_Y : 
					return current + (m_dy * m_speed);
					break;
			}   
			return current;
		}
	}
}