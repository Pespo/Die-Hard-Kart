package imac.diehardkart.vehicle {
	import imac.diehardkart.utils.Physics;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import imac.diehardkart.vehicle.VehicleDecorator;
	import imac.diehardkart.vehicle.IVehicle;

	public class ControlledVehicle extends VehicleDecorator {
		
		private var m_controls : Array;
		private static const ROTATION : int = 3;
		
		public function ControlledVehicle(decoratedVehicle : IVehicle) {
			super(decoratedVehicle);
			physics.speed = 0;
			m_controls = new Array();
			for (var i : int = 0; i < 222; ++i) {
				m_controls.push([i, false]);
			}
			StandardVehicle.STAGE.addEventListener(MouseEvent.MOUSE_MOVE, aim);
			StandardVehicle.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, downKeys);
			StandardVehicle.STAGE.addEventListener(KeyboardEvent.KEY_UP, upKeys);
		}
		
		private function aim(evt:MouseEvent) : void {
			physics.setOrientation(evt.stageX - physics.x, evt.stageY - physics.y);
		}
		
		public override function loop() : void {
			super.loop();
			updatePostion();
			friction();
		}
		
		private function friction() : void {
			physics.speed -= physics.speed  - 0.1 >= Physics.MIN_SPEED ? 0.1 : Physics.MIN_SPEED + physics.speed;
		}
		
		private function downKeys(evt:KeyboardEvent) : void {
			m_controls[evt.keyCode][1] = true;
		}
		
		private function upKeys(evt:KeyboardEvent) : void {			
			m_controls[evt.keyCode][1] = false;
		}

		private function updatePostion() : void {
			if (m_controls[65][1] && physics.speed >= 1) {
				physics.rotate(-ROTATION);
			}
			
			if (m_controls[87][1]) {
				physics.speed += physics.speed + 0.5 <= Physics.MAX_SPEED ? 0.5 : Physics.MAX_SPEED - physics.speed;
			}
			
			if (m_controls[68][1] && physics.speed >= 1) {
				physics.rotate(ROTATION);
			}
			
			if (m_controls[83][1]) {
				physics.speed -= physics.speed - 0.5 >= Physics.MIN_SPEED ? 0.5 : Physics.MIN_SPEED + physics.speed;
			}
		}
	}
}