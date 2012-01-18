package imac.diehardkart {

	import flash.text.TextField;
	import imac.diehardkart.decorable.PhysicalElement;
	import imac.diehardkart.decorable.bullet.BulletDecorator;
	import imac.diehardkart.decorable.vehicle.VehicleDecorator;
	import imac.diehardkart.decorable.vehicle.IVehicle;
	import imac.diehardkart.decorable.bullet.IBullet;
	import imac.diehardkart.map.Map;
	import imac.diehardkart.decorable.vehicle.Kart;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;	
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
		private var m_displayBullets : Vector.<IBullet>;
		private var m_displayVehicles : Vector.<IVehicle>;
		private var m_displayWeapons : Vector.<IWeapon>;
		private var m_player : Player;
		private var m_map : Map;
		private var m_score : TextField;
		private var m_life : TextField;

		
		private function test() : void {
			
			var stve : StandardVehicle = new StandardVehicle();
			var bve : BlindVehicle = new BlindVehicle(stve);
			var b : StandardBullet = new StandardBullet();
			var w : StandardWeapon = new StandardWeapon(b);
			var ws : Vector.<IWeapon> = new Vector.<IWeapon>();
			ws.push(w);
			var ave : ArmedVehicle = new ArmedVehicle(bve, ws);
			
		
			
			position(stve);
			addChild(stve);
			surveyVehicle(ave);
			addChild(w);
			surveyWeapon(w);
		}
		
		public function Game(map:Map, bulletXml:XMLList, mapXml:XMLList, m_shipXml:XMLList, m_weaponXml:XMLList) {
			Rndm.seed = Math.floor(Math.random() * 1000 - 10 + 1) + 1;
			m_displayBullets = new Vector.<IBullet>();
			m_displayVehicles = new Vector.<IVehicle>();
			m_displayWeapons = new Vector.<IWeapon>();
			m_map = map;

			m_life = new TextField();
			m_life.text = "LIFE : 100";
			m_life.x = 10;
			m_life.y = 10;
			m_life.textColor = 0xFFFFFF;
			addChild(m_life);
			
			var stve : StandardVehicle = new StandardVehicle("Kart");
			var b : StandardBullet = new StandardBullet();
			var w : StandardWeapon = new StandardWeapon(b,StandardWeapon.STANDARD_SKIN, 10);
			var xs : OrientedWeapon = new OrientedWeapon(w);
			var ws : Vector.<IWeapon> = new Vector.<IWeapon>();
			ws.push(w);
			var ave : ArmedVehicle = new ArmedVehicle(stve, ws, true);
			
			m_player = new Player(stve, ave, w, xs);
			
			m_score = new TextField();
			m_score.text = "SCORE : " + m_player.score;
			m_score.x = 500;
			m_score.y = 10;
			m_score.textColor = 0xFFFF00;
			addChild(m_score);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function catchKeyEventDown(evt : KeyboardEvent) : void {
			switch(evt.keyCode) {
				case 87 :
					m_player.kart.setDirection(Kart.FORWARD, true);			
					break;
				case 83 :
					m_player.kart.setDirection(Kart.BACKWARD, true);	
					break;
				case 65 :
					m_player.kart.setDirection(Kart.LEFT, true);
					break;
				case 68 :
					m_player.kart.setDirection(Kart.RIGHT, true);
					break;
			}
		}
		
		private function catchKeyEventUp(evt : KeyboardEvent) : void {
			switch(evt.keyCode) {
				case 87 :
					m_player.kart.setDirection(Kart.FORWARD, false);				
					break;
				case 83 :
					m_player.kart.setDirection(Kart.BACKWARD, false);	
					break;
				case 65 :
					m_player.kart.setDirection(Kart.LEFT, false);
					break;
				case 68 :
					m_player.kart.setDirection(Kart.RIGHT, false);
					break;
			}
		}
		
		//Make one survey by listener
		private function surveyBullet(obj :IBullet) : void {
			obj.addEventListener(CustomEvent.DEAD, deadBullet);
			m_displayBullets.push(obj);
		}
		
		private function surveyWeapon(obj : IWeapon) : void {
			obj.addEventListener(CustomEvent.DEAD, deadWeapon);
			obj.addEventListener(CustomEvent.SHOOT, addBullet);
			m_displayWeapons.push(obj);
		}
		
		private function surveyVehicle(obj : IVehicle) : void {
			obj.addEventListener(CustomEvent.DEAD, deadVehicle);
			m_displayVehicles.push(obj);
		}

		private function addBullet(evt : CustomEvent):void {
			addChild(evt.target.bullet);
			surveyBullet(evt.target.bullet);
		}

		private function deadBullet(evt : Event) : void {
			var obj : IBullet = evt.target as IBullet;
			obj.removeEventListener(CustomEvent.DEAD, deadBullet);
			obj.removeEventListener(CustomEvent.SHOOT, addBullet);
			removeChild(DisplayObject(obj));
			destructBullet(obj);
		}

		private function deadWeapon(evt : Event) : void {
			var obj : IWeapon = evt.target as IWeapon;
			obj.removeEventListener(CustomEvent.DEAD, deadWeapon);
			removeChild(DisplayObject(obj));
			destructWeapon(obj);
		}

		private function deadVehicle(evt : Event) : void {
			var obj : IVehicle = evt.target as IVehicle;
			obj.removeEventListener(CustomEvent.DEAD, deadVehicle);
			removeChild(DisplayObject(obj));
			destructVehicle(obj);
		}
		
		private function destructBullet(obj : IBullet) : void {
			trace("Destruct IBullet");
			m_displayBullets.splice(m_displayBullets.indexOf(obj), 1);
			obj.destructor();
			obj = null;
		}
		
		private function destructVehicle(obj : IVehicle) : void {
			trace("Destruct IVehicle");
			m_displayVehicles.splice(m_displayVehicles.indexOf(obj), 1);
			obj.destructor();
			obj = null;
		}
		
		private function destructWeapon(obj : IWeapon) : void {
			trace("Destruct IWeapon");
			m_displayWeapons.splice(m_displayWeapons.indexOf(obj), 1);
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
			addChildAt(m_map.mapBitmap, 0);

			position(m_player.stdVehicle);
			addChild(m_player.stdVehicle);
			surveyVehicle(m_player.decoVehicle);
			addChild(m_player.stdWeapon);
						
			stage.addEventListener(KeyboardEvent.KEY_DOWN, catchKeyEventDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, catchKeyEventUp);

			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, catchMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, catchMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP, catchMouseEvent);
			
			test();	
		}
		
		private function catchMouseEvent(evt : MouseEvent) : void {
			switch(evt.type) {
				case MouseEvent.MOUSE_MOVE :
					m_player.decoWeapon.aim(stage.mouseX, stage.mouseY);
					break;
				case MouseEvent.MOUSE_DOWN :
					m_player.stdWeapon.addEventListener(CustomEvent.SHOOT, addBullet);
					m_displayWeapons.push(m_player.stdWeapon);				
					break;
				case MouseEvent.MOUSE_UP :
					m_displayWeapons.splice(m_displayWeapons.indexOf(m_player.stdWeapon), 1);
					m_player.stdWeapon.removeEventListener(CustomEvent.SHOOT, addBullet);
					break;
			}
		}
		
		private function loop(evt : Event) : void {
			for each (var vehicle : IVehicle in m_displayVehicles) {
				vehicle.loop();
				
				/*for each (var collBullet : IBullet in m_displayBullets) {
					trace(vehicle);
					if (collBullet.hitTestObject(vehicle as DisplayObject)) {
						trace("collision\n--------");
						trace(vehicle.looseLife(collBullet.damage));
						
					}
				}*/
				
				if (vehicle.x < -vehicle.width || vehicle.y < -vehicle.height
					|| vehicle.x > stage.stageWidth + vehicle.width
					|| vehicle.y > stage.stageHeight + vehicle.height) {
					destructVehicle(vehicle);
				}
			}
			for each (var bullet : IBullet in m_displayBullets) {
				bullet.loop();
				if (bullet.x < -bullet.width || bullet.y < -bullet.height
					|| bullet.x > stage.stageWidth + bullet.width
					|| bullet.y > stage.stageHeight + bullet.height) {
					destructBullet(bullet);
				}
			}
			for each (var weapon : IWeapon in m_displayWeapons) {
				weapon.loop();
				if (weapon.x < -weapon.width || weapon.y < -weapon.height
					|| weapon.x > stage.stageWidth + weapon.width
					|| weapon.y > stage.stageHeight + weapon.height) {
					destructWeapon(weapon);
				}
				//trace("\n");
			}
			m_player.kart.loop();
			m_map.kartZone(m_player.kart);
		}
	}
}