package imac.diehardkart.vehicle {
	import flash.events.EventDispatcher;
	import imac.diehardkart.utils.Physics;

	public class VehicleDecorator extends EventDispatcher implements IVehicle {
		
		protected var m_decoratedVehicle : IVehicle;
		
		public function VehicleDecorator(decoratedVehicle:IVehicle) {
			m_decoratedVehicle = decoratedVehicle;
		}
		
		public function loop() : void {
			m_decoratedVehicle.loop();
		}
		
		public function get physics() : Physics {
			return m_decoratedVehicle.physics;
		}
		
		public function set physics(s:Physics) : void {
			m_decoratedVehicle.physics = s;
		}
		
		public function display() : void {
			m_decoratedVehicle.display();
		}
		
	}
}