package imac.diehardkart.utils {
	
	public class Movement {
		
		private var m_dx : Number;
		private var m_dy : Number;
		private var m_speed : Number;
		public static const AXIS_X : String = "axe x";
		public static const AXIS_Y : String = "axe y";
		
		public function Movement(speed:Number = 0.5, dx:Number = 1, dy:Number = 0) {
			var norm : Number = Math.sqrt(dx * dx + dy * dy);
			m_dx = (norm == 0) ? 0 : dx / norm;
			m_dy = (norm == 0) ? 0 : dy / norm;
			m_speed = (speed >= 0 && speed <= 1) ? speed : Math.abs(Math.cos(speed)); 
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
		
		public function set dx(dx:Number) : void {
			var norm : Number = Math.sqrt(dx * dx + m_dy * m_dy);
			m_dx = (norm == 0) ? 0 : dx / norm;
			m_dy = (norm == 0) ? 0 : m_dy / norm;
		}
		
		public function set dy(dy:Number) : void {
			var norm : Number = Math.sqrt(m_dx * m_dx + dy * dy);
			m_dx = (norm == 0) ? 0 : m_dx / norm;
			m_dy = (norm == 0) ? 0 : dy / norm;
		}
		
		public function set speed(s:Number) : void {
			m_speed = (s >= 0 && s <= 1) ? s : Math.abs(Math.cos(s)); 
		}
		
		public function make(current:Number, axis:String) : Number {
			switch(axis) {
				case AXIS_X :
					return current + (m_dx * m_speed);
					break;
				case AXIS_X : 
					return current + (m_dy * m_speed);
					break;
			}   
			return current;
		}
	}
}