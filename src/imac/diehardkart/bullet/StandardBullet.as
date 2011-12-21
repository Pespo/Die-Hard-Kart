package imac.diehardkart.bullet {
	import imac.diehardkart.utils.CustomEvent;
	import imac.diehardkart.utils.Movement;
	import flash.events.Event;
	import imac.diehardkart.utils.FrameLabel;

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
						
			m_movement = movement;
			m_waitingFrames = waitingFrames;
			m_ctrFramesSinceLastMove = 0;
			m_damage = damage;
			m_skin = new SkinBullet();
			m_dead = false;
			addChild(m_skin);
			
			if (m_movement.dx >= 0) {
				rotation = (180 * Math.asin(m_movement.dy) / Math.PI);
			} else if (m_movement.dx <= 0 && m_movement.dy >= 0) {
				rotation = - (180 * Math.asin(m_movement.dx) / Math.PI) + 90;
			} else if (m_movement.dx <= 0 && m_movement.dy <= 0) {
				rotation = - (180 * Math.asin(m_movement.dy) / Math.PI) + 180;
			}
			
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
			
			if (m_skin.currentFrameLabel == FrameLabel.EXPLOSION_DONE) {
				destruct();
			}
		}
		
		public override function get movement() : Movement {
			return m_movement;
		}
		
		public override function set movement(movement:Movement) : void {
			m_movement = movement;
		}
		
		/**
		 * Explode the bullet when it hits a vehicle
		 * @return void
		 */
		public override function explode() : void {
			m_dead = true;
			GAME_REF.playerBullets.splice(GAME_REF.playerBullets.indexOf(this), 1);
			m_skin.gotoAndPlay(FrameLabel.EXPLOSION);
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
		}
	}
}