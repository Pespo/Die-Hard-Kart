package imac.diehardkart {
	import imac.diehardkart.decorable.weapon.StandardWeapon;
	import imac.diehardkart.decorable.weapon.OrientedWeapon;
	import imac.diehardkart.decorable.vehicle.StandardVehicle;
	import imac.diehardkart.decorable.vehicle.ArmedVehicle;
	import imac.diehardkart.decorable.vehicle.Kart;
	
	public class Player {
		private var m_stdWeapon : StandardWeapon;
		private var m_decoWeapon : OrientedWeapon;
		private var m_stdVehicle : StandardVehicle;
		private var m_decoVehicle : ArmedVehicle;
		private var m_kart : Kart;
		private var m_score : int;
		
		public function Player(stdV : StandardVehicle, decoV : ArmedVehicle, stdW : StandardWeapon, decoW : OrientedWeapon) {
			m_decoWeapon = decoW;
			m_stdWeapon = stdW;
			m_stdVehicle = stdV;
			m_decoVehicle = decoV;
			m_kart = new Kart(m_decoVehicle);
			m_score = 0;
		}
		
		public function set score(value : int) : void {
			m_score = value;
		}
		
		public function get score() : int {
			return m_score;
		}
		
		public function set kart(value : Kart) : void {
			m_kart = value;
		}
		
		public function get kart() : Kart {
			return m_kart;
		}
		
		public function get decoWeapon() : OrientedWeapon {
			return m_decoWeapon;
		}
		
		public function set decoWeapon(value : OrientedWeapon) : void {
			m_decoWeapon = value;
		}
		
		public function get decoVehicle() : ArmedVehicle {
			return m_decoVehicle;
		}
		
		public function set decoVehicle(value : ArmedVehicle) : void {
			m_decoVehicle = value;
		}
		
		public function get stdVehicle() : StandardVehicle {
			return m_stdVehicle;
		}
		
		public function set stdVehicle(value : StandardVehicle) : void {
			m_stdVehicle = value;
		}
		
		public function get stdWeapon() : StandardWeapon {
			return m_stdWeapon;
		}
		
		public function set stdWeapon(value : StandardWeapon) : void {
			m_stdWeapon = value;
		}
	}
}