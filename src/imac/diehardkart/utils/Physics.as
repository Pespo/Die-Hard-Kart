package imac.diehardkart.utils {
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	import flash.display.MovieClip;

	/**
	 * @author tom
	 */
	public class Physics extends Sprite {
		
		private var m_dx : Number;
		private var m_dy : Number;
		private var m_speed : Number;
		private var m_anim : MovieClip;
		public static const STANDARD_SPEED : Number = 5;
		public static const MAX_SPEED : Number = 10;
		public static const MIN_SPEED : Number = 1;
		public static const STANDARD_ANGLE : Number = 0.5;
		public static const STANDARD_DX : Number = 0.5;
		public static const STANDARD_DY : Number = 0;
		
		public function Physics(skinName:String,
							angle:Number = STANDARD_ANGLE,
							speed:Number = STANDARD_SPEED) {
			
			//var SkinClass : Class = getDefinitionByName(skinName) as Class;
			m_anim = new SkinWeapon();
			this.addChild(m_anim);
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
		public function rotate(angle:Number) : void {
			rotation += angle; 
			setVecDir(Math.cos(Math.PI * rotation / 180), Math.sin(Math.PI * rotation / 180));
		}
		
		/**
		 * Absolute rotation from the zero angle
		 */
		private function setRotation(angle:Number) : void {
			rotation = angle;
			m_dx = Math.cos(Math.PI * angle / 180);
			m_dy = Math.sin(Math.PI * angle / 180);
		}
		
		/**
		 * uncomment  and TEST IT if you need !!!
		private function orientate(dx:Number, dy:Number) : void {
			m_dx += dx;
			m_dy += dy;
			setOrientation(m_dx, m_dy);
			rotation += Math.atan(dx / dy);
		}
		*/
		
		/**
		 * Absolute orientation from the zero direction
		 */
		private function setVecDir(dx:Number, dy:Number) : void {
			var norm : Number = Math.sqrt(dx * dx + dy * dy);
			m_dx = (norm == 0) ? 0 : dx / norm;
			m_dy = (norm == 0) ? 0 : dy / norm;
			//rotation = Math.acos(m_dx);
		}
		
		public function set speed(s:Number) : void {
			m_speed = (s >= MIN_SPEED && s <= MAX_SPEED) ? s : STANDARD_SPEED; 
		}
		
		public function gotoAndPlay(label:String, scene:String = null) : void {
			m_anim.gotoAndPlay(label,scene);
		}
		
		public function get currentFrameLabel() : String {
			return m_anim.currentFrameLabel;
		}
		
		public function get anim():MovieClip {
			return m_anim;
		}
		
		public function set anim(value:MovieClip):void {
			m_anim = value;
		}
	}
}