package imac.diehardkart.bullet {
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.utils.Movement;
	import flash.events.Event;
	
	/**
	 * Decorator parent for all the bullet's Decorator Pattern
	 * @author muxisar
	 */
	public class BulletDecorator extends IBullet {
		protected var m_decoratedBullet : IBullet;
		
		public function BulletDecorator(decoratedBullet:IBullet) {
			m_decoratedBullet = decoratedBullet;
			
			addEventListener(Event.ADDED_TO_STAGE, e_addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, e_removedFromStage);
		}
		
		public override function get movement() : Movement {
			return m_decoratedBullet.movement;
		}
		
		public override function set movement(movement:Movement) : void {
			m_decoratedBullet.movement = movement;
		}
		
		public override function e_action(evt:Event) : void {
			addChild(m_decoratedBullet);
			//m_decoratedBullet.e_action(evt);
		}
		
		public override function explode() : void {
			m_decoratedBullet.explode();
		}
		
		public override function e_addedToStage(evt:Event) : void {
			addEventListener(Event.ENTER_FRAME, e_action);
		}
		
		public override function e_removedFromStage(evt:Event) : void {			
			removeEventListener(Event.ENTER_FRAME, e_action);
		}
		
		public override function destruct() : void {
			m_decoratedBullet.destruct();
		}
	}
}
