package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.utils.CustomEvent;
	import imac.diehardkart.utils.Labels;
	import flash.utils.getDefinitionByName;
	import flash.display.MovieClip;
	import imac.diehardkart.decorable.PhysicalElement;
	import assets.skins.StandardVehicleSkin;

	
	public class StandardVehicle extends PhysicalElement implements IVehicle {
		private var m_life : Number;
		private var m_damageExplosion : Number;
		private var m_rayExplosion : Number;
		private var m_coeffLoseLife : Number;
		private var m_view : MovieClip;
		private var m_explode : Boolean = false;
	
		private var implementSkinVehicle : StandardVehicleSkin = new StandardVehicleSkin();		

		protected static const STANDARD_SKIN : String = "StandardVehicleSkin";
		public static const STANDARD_LIFE : Number = 100;
		public static const STANDARD_COEFF_LIFE : Number = 1;
		public static const STANDARD_DAMAGE_EXPLOSION : Number = 10;
		public static const STANDARD_RAY_EXPLOSION : Number = 20;
		
		public function StandardVehicle(skin : String = STANDARD_SKIN,
										speed : Number = STANDARD_SPEED,
										life : Number = STANDARD_LIFE,
										coeff : uint = STANDARD_COEFF_LIFE,
										damage : Number = STANDARD_DAMAGE_EXPLOSION,
										ray : Number = STANDARD_RAY_EXPLOSION) {
			super(PhysicalElement.STANDARD_ANGLE, speed);
			
			var SkinClass : Class = getDefinitionByName("assets.skins." + skin) as Class;
			m_view = new SkinClass();
			m_view.gotoAndPlay(Labels.INIT);
			this.addChild(m_view);
			
			m_life = life;
			m_damageExplosion = damage;
			m_coeffLoseLife = coeff;
			m_rayExplosion = ray;
		}
		
		public function loop() : void {
			//trace("ahhhhhhhhhhhhh " + rotation); 
			if (!m_explode)
				move();
			else
				deadTest();
		}
			
		private function explode() : void {
			m_explode = true;
			m_view.gotoAndPlay(Labels.EXPLOSION);
		}
		
		private function deadTest() : void {
			if (m_view.currentFrameLabel == Labels.EXPLOSION_DONE) {
				die();
			}
		}
		
		public function looseLife(l : uint) : void {
			m_life -= l * m_coeffLoseLife;
			if (m_life <= 0)
				explode();
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
		
		override public function destructor() : void {
			trace("Destruct StandardVehicle");
			super.destructor();
			removeChild(m_view);
			m_view.stop();
			m_view = null;
		}
	}
}