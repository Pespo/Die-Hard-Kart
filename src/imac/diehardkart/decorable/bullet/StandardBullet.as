package imac.diehardkart.decorable.bullet {
	import flash.utils.getDefinitionByName;
	import flash.display.MovieClip;
	import imac.diehardkart.decorable.PhysicalElement;
	import imac.diehardkart.utils.Labels;
	import imac.diehardkart.utils.CustomEvent;
	
	public class StandardBullet extends PhysicalElement implements IBullet {
		
		private var m_damage : Number;
		private var m_view : MovieClip;
		private var m_explode : Boolean = false;
		public static const STANDARD_DAMAGE : Number = 10;
		public static const STANDARD_SKIN : String = "StandardBulletSkin";
		
		public function StandardBullet(skin : String = STANDARD_SKIN, damage:Number = STANDARD_DAMAGE) {
			super();
			
			var SkinClass : Class = getDefinitionByName(skin) as Class;
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
			// create duplicate
			var targetClass:Class = Object(this).constructor as Class;
			var duplicate:IBullet = new targetClass(m_damage);
			//duplicate properties
			//duplicate.transform = this.transform;
			// duplicate.filters = this.filters;
			//duplicate.cacheAsBitmap = this.cacheAsBitmap;
			//duplicate.opaqueBackground = this.opaqueBackground;
			//if (this.scale9Grid) {
			//var rect:Rectangle = this.scale9Grid;
			//WAS Flash 9 bug where returned scale9Grid is 20x larger than assigned
			//rect.x /= 20, rect.y /= 20, rect.width /= 20, rect.height /= 20;
			//duplicate.scale9Grid = rect;
			//}
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
	}
}