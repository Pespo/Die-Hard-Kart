package imac.diehardkart {
	import imac.diehardkart.map.Map;
	import imac.diehardkart.decorable.vehicle.Kart;
	import flash.events.KeyboardEvent;
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	import imac.diehardkart.decorable.Decorator;
	import imac.diehardkart.decorable.IDecorator;
	import imac.diehardkart.utils.CustomEvent;
	import com.gskinner.utils.Rndm;
	import imac.diehardkart.decorable.vehicle.BlindVehicle;
	import flash.events.Event;
	import imac.diehardkart.decorable.vehicle.StandardVehicle;
	import flash.display.Sprite;
		
	public class Game extends Sprite {
		private var m_displayControllers : Vector.<IDecorator>;
		private var m_kart : Kart;
		private var m_viewKart : StandardVehicle;
		private var m_map : Map;
		
		private function test() : void {
			var stve : StandardVehicle = new StandardVehicle();
			var stve1 : StandardVehicle = new StandardVehicle();
			var stve2 : StandardVehicle = new StandardVehicle();
			var stve3 : StandardVehicle = new StandardVehicle();
			var stve4 : StandardVehicle = new StandardVehicle();
			var bve : BlindVehicle = new BlindVehicle(stve);
			position(stve);
			addChild(stve);
			position(stve1);
			addChild(stve1);
			position(stve2);
			addChild(stve2);	
			position(stve3);
			addChild(stve3);	
			position(stve4);
			addChild(stve4);
			survey(bve);
			survey(stve1);
			survey(stve2);
			survey(stve3);
			survey(stve4);
			//survey(bve);	
		}
		
		public function Game() {
			Rndm.seed = Math.floor(Math.random() * 1000 - 10 + 1) + 1;
			m_displayControllers = new Vector.<IDecorator>();
			m_viewKart = new StandardVehicle("Kart");
			m_map = new Map("../res/maps/mapTest.png");
			m_kart = new Kart(m_viewKart);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function catchUserEvent(evt : KeyboardEvent) : void {
			switch(evt.keyCode) {
				case 87 :
					m_kart.setDirection(Kart.FORWARD);
					break;
				case 83 :
					m_kart.setDirection(Kart.BACKWARD);
					break;
				case 65 :
					m_kart.setDirection(Kart.LEFT);
					break;
				case 68 :
					m_kart.setDirection(Kart.RIGHT);
					break;
			}
		}
		
		private function survey(obj : EventDispatcher) : void {
			obj.addEventListener(CustomEvent.DEAD, deadObject);
			m_displayControllers.push(obj);
		}
		
		private function deadObject(evt : Event) : void {
			var obj : Decorator = evt.target as Decorator;
			obj.removeEventListener(CustomEvent.DEAD, deadObject);
			removeChild(DisplayObject(obj));
			destruct(obj);
		}
		
		private function destruct(obj : IDecorator) : void {
			m_displayControllers.splice(m_displayControllers.indexOf(obj), 1);
			obj.destructor();
			obj = null;
		}
		
		private function position(obj : IDecorator) : void {
			// Random horizontal position 
			if (Rndm.boolean()) {
				// Restrict verticality in top of the scene
				if (Rndm.boolean()) {
					obj.x = 0;
				}
				// Restrict verticality in bottom of the scene
				else {
					obj.x = stage.stageWidth;
				}
				obj.y = Rndm.integer(0, stage.stageHeight);
			}
			// Random vertical position
			else {
				// Restrict horizontality in left of the scene
				if (Rndm.boolean()) {
					obj.y = 0;
				}
				// Restrict horizontality in right of the scene
				else {
					obj.y = stage.stageHeight;
				}
				obj.x = Rndm.integer(0, stage.stageWidth);
			}
			var xCenter : Number = stage.stageWidth / 2;
			var yCenter : Number = stage.stageHeight / 2;
			var xDir : Number = Rndm.float(xCenter - (1/3 * stage.stageWidth), xCenter + (1/3 * stage.stageWidth));
			var yDir : Number = Rndm.float(yCenter - (1/3 * stage.stageHeight), yCenter + (1/3 * stage.stageHeight));
			// Set direction in approximate center
			obj.setOrientation(xDir - obj.x, yDir - obj.y);
		}
		
		private function onAddedToStage(evt : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addChild(m_viewKart);
			addChildAt(m_map.mapBitmap, 0);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, catchUserEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, catchUserEvent);
			addEventListener(Event.ENTER_FRAME, loop);
			
			test();	
		}
		
		private function loop(evt : Event) : void {
			for each (var obj : IDecorator in m_displayControllers) {
				obj.loop();
				if (obj.x < -obj.width || obj.y < -obj.height
					|| obj.x > stage.stageWidth + obj.width
					|| obj.y > stage.stageHeight + obj.height) {
					destruct(obj);
				}
				m_kart.loop();
			}
		}
	}
}