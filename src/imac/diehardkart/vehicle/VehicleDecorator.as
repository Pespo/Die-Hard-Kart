package imac.diehardkart.vehicle {
	import flash.events.Event;
	import flash.display.MovieClip;

	/**
	 * Decorator parent for all the vehicle's Decorator Pattern
	 * @author muxisar
	 */
	public class VehicleDecorator extends MovieClip implements IVehicle {
		private var m_decoratedVehicle : IVehicle;
		
		public function VehicleDecorator(decoratedVehicle:IVehicle) {
			m_decoratedVehicle = decoratedVehicle;
		}
		
		public function e_action(evt:Event) : void {
			m_decoratedVehicle.e_action(evt);
		}
		
		public function e_addedToStage(evt:Event) : void {
			m_decoratedVehicle.e_addedToStage(evt);
		}
		
		public function e_removedFromStage(evt:Event) : void {
			m_decoratedVehicle.e_removedFromStage(evt);
		}
				
		public function explode() : void {
			m_decoratedVehicle.explode();
		}
		
		public function die() : void {
			m_decoratedVehicle.die();			
		}
		
		public function looseLife() : void {
			m_decoratedVehicle.looseLife();
		}
	}
}
