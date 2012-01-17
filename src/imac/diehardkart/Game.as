package imac.diehardkart {
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
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
			addEventListener(KeyboardEvent.KEY_DOWN, downKeys);
			addEventListener(KeyboardEvent.KEY_UP, upKeys);
		}
		
		private function downKeys(evt:KeyboardEvent) : void {
			//Send to kart
		}
		
		private function upKeys(evt:KeyboardEvent) : void {			
			//Send to kart
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
			trace("destruct");
			trace(m_displayControllers.length);
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
			m_displayControllers = new Vector.<IDecorator>();
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
			}
		}
	}
}