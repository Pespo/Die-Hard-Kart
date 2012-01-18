package imac.diehardkart {
	import imac.diehardkart.decorable.bullet.StandardBullet;
	import imac.diehardkart.decorable.weapon.OrientedWeapon;
	import imac.diehardkart.decorable.vehicle.StandardVehicle;
	import imac.diehardkart.decorable.vehicle.ArmedVehicle;
	import imac.diehardkart.decorable.vehicle.Kart;
	
	public class Player {
		private var m_bullet : StandardBullet;
		private var m_weapon : OrientedWeapon;
		private var m_viewKart : StandardVehicle;
		private var m_kart : Kart;
		
		public function Player(weapon : OrientedWeapon, view : StandardVehicle, vehicle : ArmedVehicle) {
			
			//m_bullet = new StandardBullet();
			m_weapon = weapon;
			//var weapons : view = new Vector.<IWeapon>(m_weapon);
			//weapons.push(m_weapon);
			m_viewKart = view;//new StandardVehicle();
			//var ac : ArmedVehicle = new ArmedVehicle(m_viewKart, weapons);
			m_kart = new Kart(vehicle);
		}
		
		public function set kart(value : Kart) : void {
			m_kart = value;
		}
		
		public function get kart() : Kart {
			return m_kart;
		}
		
		public function get weapon() : OrientedWeapon {
			//trace("Access player weapion");
			return m_weapon;
		}
		
		public function set weapon(value : OrientedWeapon) : void {
			m_weapon = value;
		}
		
		public function get viewKart() : StandardVehicle {
			return m_viewKart;
		}
		
		public function set viewKart(value : StandardVehicle) : void {
			m_viewKart = value;
		}
	}
}