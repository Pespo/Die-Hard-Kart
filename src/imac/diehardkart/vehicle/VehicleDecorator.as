package imac.diehardkart.vehicle {

	public class VehicleDecorator implements IVehicle {
		
		protected var m_decoratedVehicle : IVehicle;
		
		public function VehicleDecorator(decoratedVehicle:IVehicle) {
			m_decoratedVehicle = decoratedVehicle;
		}
		
		public function loop() : void {
			m_decoratedVehicle.loop();
		}
		
		public function set x(x:Number) : void {
			m_decoratedVehicle.x = x;
		}
		
		public function set y(y:Number) : void {
			m_decoratedVehicle.y = y;
		}
		
		public function display() : void {
			m_decoratedVehicle.display();
		}
		
		public function set rotation(r:Number) : void {
			m_decoratedVehicle.rotation = r;
		}
		
		public function get rotation() : Number {
			return m_decoratedVehicle.rotation;
		}
	}
}
