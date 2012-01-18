package imac.diehardkart.decorable.bullet {
	import flash.utils.getDefinitionByName;
	import flash.display.MovieClip;
	import imac.diehardkart.decorable.PhysicalElement;
	import imac.diehardkart.utils.Labels;
	import imac.diehardkart.utils.CustomEvent;

	import assets.skins.StandardBulletSkin;
	
	public class StandardBullet extends PhysicalElement implements IBullet {
		
		private var implementSkinBullet : StandardBulletSkin = new StandardBulletSkin();		
		private var m_damage : Number;
		private var m_view : MovieClip;
		private var m_skin : String;
		private var m_explode : Boolean = false;
		
		public static const STANDARD_DAMAGE : Number = 10;
		public static const STANDARD_SKIN : String = "StandardBulletSkin";
		public static const COEFF_BULLET_SPEED : int = MAX_SPEED / 2;
		public static const STANDARD_SPEED_BULLET : int =1;
		public static const MAX_SPEED_BULLET : int = 10;
		
		public function StandardBullet(skin : String = STANDARD_SKIN, damage : Number = STANDARD_DAMAGE, speedMovement : Number = STANDARD_SPEED) {
			var test : Number = (speedMovement < STANDARD_SPEED_BULLET || speedMovement > MAX_SPEED_BULLET) ? STANDARD_SPEED_BULLET * COEFF_BULLET_SPEED : 5 / (MAX_SPEED_BULLET - STANDARD_SPEED_BULLET) * (speedMovement - STANDARD_SPEED_BULLET) + COEFF_BULLET_SPEED;
			super(PhysicalElement.STANDARD_ANGLE, test);
			m_skin = skin;
			var SkinClass : Class = getDefinitionByName("assets.skins." + skin) as Class;
			m_view = new SkinClass();
			m_view.gotoAndPlay(Labels.INIT);
			this.addChild(m_view);
			m_damage = damage;
		}
		
		public function loop() : void {
			if (!m_explode)
				move();
			else
				deadTest();
		}
		
		public function clone() : IBullet {
			var targetClass:Class = Object(this).constructor as Class;
			var duplicate:IBullet = new targetClass(m_skin, m_damage);
			duplicate.speed = speed;
			return duplicate;
		}
		
		private function deadTest() : void {
			if (m_view.currentFrameLabel == Labels.EXPLOSION_DONE) {
				die();
			}
		}
			
		public function explode() : void {
			m_explode = true;
			m_view.gotoAndPlay(Labels.EXPLOSION);
		}
		
		private function die() : void {
			dispatchEvent(new CustomEvent(CustomEvent.DEAD));
		}
		
		public function get view() : MovieClip {
			return m_view;
		}
		
		public function set view(v : MovieClip) : void {
			m_view = v;
		}
		
		public function get damage() : Number {
			return m_damage;
		}
		
		override public function destructor() : void {
			trace("Destruct StandardBullet");
			super.destructor();
			removeChild(m_view);
			m_view.stop();
			m_view = null;
		}
	}
}