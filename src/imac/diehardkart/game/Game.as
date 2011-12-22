package imac.diehardkart.game {
	import flash.display.IBitmapDrawable;
	import imac.diehardkart.bullet.BouncingBullet;
	import imac.diehardkart.bullet.IBullet;
	import imac.diehardkart.bullet.StandardBullet;
	import imac.diehardkart.map.Map;
	import imac.diehardkart.utils.Movement;
	import imac.diehardkart.vehicle.BlindVehicle;
	import flash.events.TimerEvent;
	import imac.diehardkart.vehicle.IVehicle;
	import flash.utils.Timer;
	import flash.display.Stage;
	import flash.display.Sprite;
	import imac.diehardkart.vehicle.StandardVehicle;
	
	public class Game extends Sprite {
		
		private var m_map : Map;
		private var m_vehicles : Vector.<IVehicle>;
		private var m_playerBullets : Vector.<IBullet>;
		private var m_enemyBullets : Vector.<IBullet>;
		
		public function Game(stage:Stage) {
			m_map = new Map(stage);
			
			m_vehicles = new Vector.<IVehicle>();
			StandardVehicle.STAGE = stage;
			StandardVehicle.GAME = this;
			
			m_playerBullets = new Vector.<IBullet>();
			m_enemyBullets = new Vector.<IBullet>();
			StandardBullet.STAGE = stage;
			StandardBullet.GAME = this;
			
			var genTimer : Timer = new Timer(1, 0);
			genTimer.addEventListener(TimerEvent.TIMER, e_loop);
			genTimer.start();
			
			var st : BlindVehicle = new BlindVehicle(new StandardVehicle(new XMLList));
			st.x = 100;
			st.y = 100;
			m_vehicles.push(st);
			st.display();
			
			var stdPlayerBullet : StandardBullet = new StandardBullet(new Movement());
			stdPlayerBullet.x = 200;
			stdPlayerBullet.y = 200;
			m_playerBullets.push(stdPlayerBullet);
			stdPlayerBullet.display();
			
			var bouncingBullet : BouncingBullet = new BouncingBullet(new StandardBullet(new Movement()));
			bouncingBullet.x = 200;
			bouncingBullet.y = 300;
			bouncingBullet.movement.setDirection(0.2, 1);
			m_enemyBullets.push(bouncingBullet);
			bouncingBullet.display();
		}
		
		private function e_loop(evt:TimerEvent) : void {
			for each(var vehicle : IVehicle in m_vehicles) {
				vehicle.loop();
			}
			for each(var playerBullet : IBullet in m_playerBullets) {
				playerBullet.loop();
			}
			for each(var enemyBullet : IBullet in m_enemyBullets) {
				enemyBullet.loop();
			}
		}
		
		public function get vehicles() : Vector.<IVehicle> {
			return m_vehicles;
		}
		
		public function get playerBullets() : Vector.<IBullet> {
			return m_playerBullets;
		}
		
		public function get enemyBullet() : Vector.<IBullet> {
			return m_enemyBullets;
		}
	}
}
