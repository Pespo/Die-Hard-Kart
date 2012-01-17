package imac.diehardkart.decorable.weapon {
	import imac.diehardkart.utils.CustomEvent;
	import flash.display.MovieClip;
	import imac.diehardkart.utils.Labels;
	import flash.utils.getDefinitionByName;
	import imac.diehardkart.decorable.bullet.IBullet;
	import imac.diehardkart.decorable.PhysicalElement;
	
	public class StandardWeapon extends PhysicalElement implements IWeapon {
		
		
		private var m_shootRate : Number;
		private var m_shootCounter : Number;
		private var m_bullet : IBullet;
		private var m_view : MovieClip;
		private var m_launchBullet : IBullet;
		
		public static const STANDARD_SHOOT_RATE : Number = 10;
		public static const MAX_SHOOT_RATE : Number = 10;
		public static const MIN_SHOOT_RATE : Number = 1;
		public static const STANDARD_DIRECTION : Number = 0;
		public static const STANDARD_SKIN : String = "StandardWeaponSkin";
		
		public function StandardWeapon(bullet : IBullet,
										skin : String = STANDARD_SKIN,	
										shootRate : Number = STANDARD_SHOOT_RATE) {	
			super();
			
			var SkinClass : Class = getDefinitionByName(skin) as Class;
			m_view = new SkinClass();
			m_view.gotoAndPlay(Labels.INIT);
			this.addChild(m_view);								
			
			m_shootRate = (m_shootRate < MIN_SHOOT_RATE || m_shootRate > MAX_SHOOT_RATE) ? STANDARD_SHOOT_RATE : shootRate;
			m_shootCounter = 0;
			m_bullet = bullet;
		}

		private function makeBullet() : void {
			m_launchBullet = m_bullet.clone();
			m_launchBullet.x = x;
			m_launchBullet.y = y;
			m_launchBullet.rotate(rotation);
			m_launchBullet.speed = 10;
		}
		
		public function shoot() : void {
			++m_shootCounter;
			if (m_shootRate < m_shootCounter) {
				makeBullet();
				dispatchEvent(new CustomEvent(CustomEvent.SHOOT));
				m_shootCounter = 0;
			}
		}
		
		public function loop() : void {
			shoot();
		}
		
		public function get bullet() : IBullet {
			return m_launchBullet;
		}
		
		public function get view() : MovieClip {
			return m_view;
		}
		
		public function set view(v : MovieClip) : void {
			m_view = v;
		}
	}
}
