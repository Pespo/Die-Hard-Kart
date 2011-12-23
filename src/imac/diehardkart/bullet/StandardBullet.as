package imac.diehardkart.bullet {
	import flash.display.Stage;
	import imac.diehardkart.game.Game;
	import flash.display.MovieClip;
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.utils.CustomEvent;
	import flash.events.Event;
<<<<<<< Updated upstream
	import imac.diehardkart.utils.FrameLabel;
	import flash.utils.getDefinitionByName;
	import assets.SkinBullet;
	
	public class StandardBullet implements IBullet {
		
		private var m_display : MovieClip;
		private var m_movement : Movement;
		private var m_damage : Number;
		public static var GAME : Game;
		public static var STAGE : Stage;
		public static const STANDARD_SKIN : String = "SkinBullet";
		
		public function StandardBullet(movement:Movement, damage:Number = 1, skin:String = STANDARD_SKIN) {			
			//var skinName : Class = getDefinitionByName(skin) as Class;
			m_display = new SkinBullet();
			m_movement = new Movement();
			orientate();
		}
		
		public function display() : void {
			STAGE.addChild(m_display);
		}
		
		public function get stage() : Stage {
			return STAGE;
		}
		
		public function get x() : Number {
			return m_display.x;
		}
		
		public function set x(x:Number) : void {
			m_display.x = x;
		}
		
		public function set y(y:Number) : void {
			m_display.y = y;
		}
		
		public function get y() : Number {
			return m_display.y;
		}
		
		public function get damage() : Number {
			return m_damage;
		}
		
		public function get movement() : Movement {
			return m_movement;
		}
		
		public function set movement(movement:Movement) : void {
=======
	import imac.diehardkart.utils.Labels;

	/**
	 * The common bullet in the bullet's Decorator Pattern
	 * @author muxisar
	 */
	public class StandardBullet extends IBullet {
		
		/** 
		 * Construct a StandardBullet
		 * @param movement <code>Movement</code> describing the bullet's movement
		 * @param damage <code>Number</code> default value is 1
		 */
		public function StandardBullet(movement:Movement,
										damage:Number = STANDARD_DAMAGE,
										waitingFrames:uint = 10) {
						
>>>>>>> Stashed changes
			m_movement = movement;
		}
		
		public function set rotation(r:Number) : void {
			m_display.rotation = r;
		}
		
		public function get rotation() : Number {
			return m_display.rotation;
		}
		
		public function set width(w:Number) : void {
			m_display.width = w;
		}
		
		public function get width() : Number {
			return m_display.width;
		}
		
		public function set height(h:Number) : void {
			m_display.height = h;
		}
		
		public function get height() : Number {
			return m_display.height;
		}
		
		private function move() : void {
			x = m_movement.make(x, Movement.AXIS_X);
			y = m_movement.make(y, Movement.AXIS_Y);
		}
	
		private function orientate() : void {
			if (m_movement.dx >= 0) {
				rotation = (180 * Math.asin(m_movement.dy) / Math.PI);
			} else if (m_movement.dx <= 0 && m_movement.dy >= 0) {
				rotation = - (180 * Math.asin(m_movement.dx) / Math.PI) + 90;
			} else if (m_movement.dx <= 0 && m_movement.dy <= 0) {
				rotation = - (180 * Math.asin(m_movement.dy) / Math.PI) + 180;
			}
		}
		
		private function hitTest() : void {
			
<<<<<<< Updated upstream
		}
		
		public function loop() : void {
			move();
			hitTest();
			outTest();
		}
		
		private function outTest() : void {
			if (x < -width || y < -height || x > STAGE.stageWidth || y > STAGE.stageHeight) {
=======
			addEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
		}
		
		/**
		 * Add the bullet to the stage
		 * @return void
		 * @param evt <code>Event</code> act on added to the stage
		 */
		public override function e_addedToStage(evt:Event) : void {
			addEventListener(Event.ENTER_FRAME, e_action);
		}
		
		/**
		 * Remove the bullet from the stage
		 * @return void
		 * @param evt <code>Event</code> act on removed from the stage
		 */
		public override function e_removedFromStage(evt:Event) : void {			
			removeEventListener(Event.ENTER_FRAME, e_action);
		}
		
		/**
		 * Move the bullet at each frame
		 * @return void
		 * @param evt <code>Event</code> act on each frame
		 */
		public override function e_action(evt:Event) : void {
			if (!m_dead) {
				++m_ctrFramesSinceLastMove;
				if (m_ctrFramesSinceLastMove == m_waitingFrames) {
					x = m_movement.make(x, Movement.AXIS_X);
					y = m_movement.make(y, Movement.AXIS_Y);
					m_ctrFramesSinceLastMove = 0;
				}
				if (x < 0 || y < 0 || x > GAME_REF.stage.stageWidth || y > GAME_REF.stage.stageHeight)
					destruct();
			}
			
			if (m_skin.currentFrameLabel == Labels.EXPLOSION_DONE) {
>>>>>>> Stashed changes
				destruct();
			}
		}
		
		/*private function gotoAndPlay(s:String) : void {
			
		}
		
		private function explode() : void {
			gotoAndPlay(FrameLabel.EXPLOSION);
		}
		
<<<<<<< Updated upstream
		private function looseLife() : void {
			
		}*/
		
		private function destruct() : void {
		
=======
		/**
		 * Explode the bullet when it hits a vehicle
		 * @return void
		 */
		public override function explode() : void {
			m_dead = true;
			GAME_REF.playerBullets.splice(GAME_REF.playerBullets.indexOf(this), 1);
			m_skin.gotoAndPlay(Labels.EXPLOSION);
		}

		/**
		 * Make the bullet die when after exploding or when out of the screen
		 * @return void
		 */
		public override function destruct() : void {
			trace("destruct2");
			dispatchEvent(new CustomEvent(CustomEvent.DEAD));
			removeEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
>>>>>>> Stashed changes
		}
	}
}