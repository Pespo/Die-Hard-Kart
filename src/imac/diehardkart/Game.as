package imac.diehardkart {

	import imac.diehardkart.decorable.vehicle.Kart;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;	
	import imac.diehardkart.decorable.Decorator;
	import imac.diehardkart.decorable.IDecorator;
	import imac.diehardkart.utils.CustomEvent;
	import com.gskinner.utils.Rndm;
	import imac.diehardkart.decorable.vehicle.BlindVehicle;
	import flash.events.Event;
	import imac.diehardkart.decorable.vehicle.StandardVehicle;
	import imac.diehardkart.decorable.vehicle.ArmedVehicle;
	import imac.diehardkart.decorable.weapon.StandardWeapon;
	import imac.diehardkart.decorable.weapon.OrientedWeapon;
	import imac.diehardkart.decorable.weapon.IWeapon;
	import imac.diehardkart.decorable.bullet.StandardBullet;

	import flash.display.Sprite;
		
	public class Game extends Sprite {
		private var m_displayControllers : Vector.<IDecorator>;
		private var m_player : Player;

		
		private function test() : void {
			var stve : StandardVehicle = new StandardVehicle();
			var stve1 : StandardVehicle = new StandardVehicle();
			var stve2 : StandardVehicle = new StandardVehicle();
			var stve3 : StandardVehicle = new StandardVehicle();
			var stve4 : StandardVehicle = new StandardVehicle();
			var bve : BlindVehicle = new BlindVehicle(stve);

			var b : StandardBullet = new StandardBullet();
			var w : StandardWeapon = new StandardWeapon(b);
			var ow : OrientedWeapon = new OrientedWeapon(w);
			var ws : Vector.<IWeapon> = new Vector.<IWeapon>();
			ws.push(ow);
			var ave : ArmedVehicle = new ArmedVehicle(bve, ws);
			
	

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
			
			//survey(w);
			//survey(ave);
			survey(stve1);
			survey(stve2);
			survey(stve3);
			survey(stve4);
			//survey(bve);	
		}
		
		public function Game() {
			Rndm.seed = Math.floor(Math.random() * 1000 - 10 + 1) + 1;
			m_displayControllers = new Vector.<IDecorator>();
			
			var qgqge : StandardWeapon = new StandardWeapon(new StandardBullet());
			
			var weapon : OrientedWeapon = new OrientedWeapon(qgqge);
			var weapons : Vector.<IWeapon> = new Vector.<IWeapon>();
			weapons.push(weapon);
			var qsg : StandardVehicle = new StandardVehicle();
			survey(qsg);
			addChild(qsg);
			
			survey(qgqge);
			addChild(qgqge);
			var ac : ArmedVehicle = new ArmedVehicle(qsg, weapons);
			m_player = new Player(weapon, new StandardVehicle(), ac);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function catchUserEvent(evt : KeyboardEvent) : void {
			switch(evt.keyCode) {
				//case 87 :
				case 90 :
					m_player.kart.setDirection(Kart.FORWARD);
					break;
				//case 83 :
				case 80 :					
					m_player.kart.setDirection(Kart.BACKWARD);
					break;
				//case 65 :
				case 81 :
					m_player.kart.setDirection(Kart.LEFT);
					break;
				case 68 :
					m_player.kart.setDirection(Kart.RIGHT);
					break;
			}
		}
		
		//Make one survey by listener
		private function survey(obj : EventDispatcher) : void {
			obj.addEventListener(CustomEvent.DEAD, deadObject);
			obj.addEventListener(CustomEvent.SHOOT, addBullet);
			m_displayControllers.push(obj);
		}

		private function  addBullet(evt : CustomEvent):void {
			trace("Add Bullet");
			addChild(evt.target.bullet);
			survey(evt.target.bullet);
		}

		private function deadObject(evt : Event) : void {
			var obj : Decorator = evt.target as Decorator;
			obj.removeEventListener(CustomEvent.DEAD, deadObject);
			removeChild(DisplayObject(obj));
			destruct(obj);
		}
		
		private function destruct(obj : IDecorator) : void {
			trace("destruct");
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
			//addChild(m_player.viewKart);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, catchUserEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, catchUserEvent);
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, catchMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, catchMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP, catchMouseEvent);
			
			//test();	
		}
		
		private function catchMouseEvent(evt : MouseEvent) : void {
			switch(evt.type) {
				case MouseEvent.MOUSE_MOVE :
					m_player.weapon.aim(stage.mouseX, stage.mouseY);
					break;
				case MouseEvent.MOUSE_DOWN :
					m_player.weapon.addEventListener(CustomEvent.SHOOT, addBullet);
					m_displayControllers.push(m_player.weapon);				
					break;
				case MouseEvent.MOUSE_UP :
					m_displayControllers.splice(m_displayControllers.indexOf(m_player.weapon), 1);
					m_player.weapon.removeEventListener(CustomEvent.SHOOT, addBullet);
					break;
			}
		}
		
		private function loop(evt : Event) : void {
			for each (var obj : IDecorator in m_displayControllers) {
				obj.loop();
				if (obj.x < -obj.width || obj.y < -obj.height
					|| obj.x > stage.stageWidth + obj.width
					|| obj.y > stage.stageHeight + obj.height) {
					destruct(obj);
				}
				m_player.kart.loop();
			}
		}
	}
}