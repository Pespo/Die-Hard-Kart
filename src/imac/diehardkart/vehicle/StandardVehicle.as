package imac.diehardkart.vehicle {
	import imac.diehardkart.utils.CustomEvent;
	import imac.diehardkart.utils.FrameLabel;
	import imac.diehardkart.utils.Movement;
	import flash.events.Event;

	/**
	 * The common vehicle in the vehicle's Decorator Pattern
	 * @author muxisar
	 */
	public class StandardVehicle extends IVehicle{
		
		/** 
		 * Construct a StandardVehicle
		 * @param movement <code>Movement</code> describing the vehicle's movement
		 * @param waitingFrames <code>uint</code> default value is 10
		 * @param life <code>Number</code> default value is 100
		 * @param coeffLifeLost <code>Number</code> default value is  1
		 * @param maxDamages <code>Number</code> default value is 10
		 * @param explosionRange <code>Number</code> default value is 20
		 */
		public function StandardVehicle(movement:Movement,
										waitingFrames:uint = 10,
										life:Number = STANDARD_LIFE,
										coeffLifeLost:Number = STANDARD_COEFF_LIFE_LOST,
										maxDamages:Number = STANDARD_MAX_DAMAGES,
										explosionRange:Number = STANDARD_EXPLOSION_RANGE) {			

			m_movement = movement;
			m_life = life;
			m_coeffLifeLost = Math.abs(coeffLifeLost);
			m_maxDamages = maxDamages;
			m_explosionRange = explosionRange;
			m_ctrFramesSinceLastMove = 0;
			m_waitingFrames = waitingFrames;
			m_skin = new SkinVehicle();
			addChild(m_skin);
			trace(m_movement.dx + " - " + m_movement.dy);
			
			if (m_movement.dx >= 0) {
				rotation = (180 * Math.asin(m_movement.dy) / Math.PI);
			} else if (m_movement.dx <= 0 && m_movement.dy >= 0) {
				rotation = - (180 * Math.asin(m_movement.dx) / Math.PI) + 90;
			} else if (m_movement.dx <= 0 && m_movement.dy <= 0) {
				rotation = - (180 * Math.asin(m_movement.dy) / Math.PI) + 180;
			}
			
			m_dead = false;
			
			addEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
		}
		
		private function e_addedToStage(evt:Event) : void {
			addEventListener(Event.ENTER_FRAME, e_action);
		}
		
		private function e_removedFromStage(evt:Event) : void {			
			removeEventListener(Event.ENTER_FRAME, e_action);
		}
		
		protected override function e_action(evt:Event) : void {
			if (!m_dead) {
				++m_ctrFramesSinceLastMove;
				
				if (m_ctrFramesSinceLastMove == m_waitingFrames) {
					x = m_movement.make(x, Movement.AXIS_X);
					y = m_movement.make(y, Movement.AXIS_Y);
					m_ctrFramesSinceLastMove = 0;
				}
					
				if (m_life <= 0)
					explode();
			}
			
			if (m_skin.currentFrameLabel == FrameLabel.EXPLOSION_DONE) {
				destruct();
			}
			
			if (x < -width || y < -height || x > GAME_REF.stage.stageWidth || y > GAME_REF.stage.stageHeight) {
				destruct();
			}
		}
		
		protected override function explode() : void {
			m_dead = true;
			m_skin.gotoAndPlay(FrameLabel.EXPLOSION);
		}
		
		public override function looseLife() : void {
			m_life = m_life - (1 * m_coeffLifeLost);
		}
		
		private function destruct() : void {
			dispatchEvent(new CustomEvent(CustomEvent.DEAD));
			removeEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
		}
	}
}