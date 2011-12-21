package imac.diehardkart.game {
	import imac.diehardkart.vehicle.BlindVehicle;
	import flash.events.TimerEvent;
	import imac.diehardkart.vehicle.IVehicle;
	import flash.utils.Timer;
	import flash.display.Stage;
	import flash.display.Sprite;
	import imac.diehardkart.vehicle.StandardVehicle;
	
	public class Game extends Sprite {
		
		private var m_vehicles : Vector.<IVehicle>;
		
		public function Game(stage:Stage) {
			m_vehicles = new Vector.<IVehicle>();
			StandardVehicle.STAGE = stage;
			StandardVehicle.GAME = this;
			
			var genTimer : Timer = new Timer(1, 0);
			genTimer.addEventListener(TimerEvent.TIMER, e_loop);
			genTimer.start();
			
			var st : BlindVehicle = new BlindVehicle(new StandardVehicle(new XMLList));
			st.x = 100;
			st.y = 100;
			m_vehicles.push(st);
			st.display();			
		}
		
		private function e_loop(evt:TimerEvent) : void {
			for each(var vehicle : IVehicle in m_vehicles) {
				vehicle.loop();
			}
		}
		
		public function get vehicles() : Vector.<IVehicle> {
			return m_vehicles;
		}
	}
}
