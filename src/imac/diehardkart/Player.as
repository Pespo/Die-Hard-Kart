package imac.diehardkart {
	import imac.diehardkart.decorable.weapon.StandardWeapon;
	import imac.diehardkart.decorable.weapon.OrientedWeapon;
	import imac.diehardkart.decorable.vehicle.StandardVehicle;
	import imac.diehardkart.decorable.vehicle.ArmedVehicle;
	import imac.diehardkart.decorable.vehicle.Kart;
	
	public class Player {
		private var m_viewWeapon : StandardWeapon;
		private var m_controlWeapon : OrientedWeapon;
		private var m_viewVehicle : StandardVehicle;
		private var m_controlVehicle : ArmedVehicle;
		private var m_kart : Kart;
		
		public function Player(controlW : OrientedWeapon, viewW : StandardWeapon, viewV : StandardVehicle, controlV : ArmedVehicle) {
			m_controlWeapon = controlW;
			m_viewWeapon = viewW;
			m_viewVehicle = viewV;
			m_controlVehicle = controlV;
			m_kart = new Kart(m_controlVehicle);
		}
		
		public function set kart(value : Kart) : void {
			m_kart = value;
		}
		
		public function get kart() : Kart {
			return m_kart;
		}
		
		public function get weapon() : OrientedWeapon {
			return m_controlWeapon;
		}
		
		public function set weapon(value : OrientedWeapon) : void {
			m_controlWeapon = value;
		}
		
		public function get vehicle() : ArmedVehicle {
			return m_controlVehicle;
		}
		
		public function set vehicle(value : ArmedVehicle) : void {
			m_controlVehicle = value;
		}
		
		public function get viewVehicle() : StandardVehicle {
			return m_viewVehicle;
		}
		
		public function set viewVehicle(value : StandardVehicle) : void {
			m_viewVehicle = value;
		}
		
		public function get viewWeapon() : StandardWeapon {
			return m_viewWeapon;
		}
		
		public function set viewWeapon(value : StandardWeapon) : void {
			m_viewWeapon = value;
		}
	}
}