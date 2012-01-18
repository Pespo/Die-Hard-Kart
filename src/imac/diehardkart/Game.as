package imac.diehardkart {

	import flash.utils.getDefinitionByName;
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
		private var m_displayEnnemyBullets : Vector.<IBullet>;
		private var m_displayPlayerBullets : Vector.<IBullet>;
		private var m_displayPlayerVehicles : Vector.<IVehicle>;
		private var m_displayEnnemyVehicles : Vector.<IVehicle>;
		private var m_displayEnnemyWeapons : Vector.<IWeapon>;
		private var m_displayPlayerWeapons : Vector.<IWeapon>;
		private var m_player : Player;
		private var m_map : Map;
		private var m_score : TextField;
		private var m_life : TextField;

		private var m_bulletXml : XMLList;
		private var m_levelXml : XMLList;
		private var m_shipXml : XMLList;
		private var m_weaponXml : XMLList;
		
		private function test() : void {
			
			var stve : StandardVehicle = new StandardVehicle(StandardVehicle.STANDARD_SKIN, PhysicalElement.STANDARD_SPEED, 100, 1);
			var bve : BlindVehicle = new BlindVehicle(stve);
			var b : StandardBullet = new StandardBullet();
			var w : StandardWeapon = new StandardWeapon(b);
			var ws : Vector.<IWeapon> = new Vector.<IWeapon>();
			ws.push(w);
			var ave : ArmedVehicle = new ArmedVehicle(stve, ws);
			
		
			
			position(stve);
			addChild(stve);
			surveyEnnemyVehicle(ave);
			addChild(w);
			surveyEnnemyWeapon(w);
		}
		
		private function init() : void {
			// parcourir le level
			for each (var level : XML in m_levelXml) {
				// setter les parametres du level
				for each (var ship : XML in level.ships..ship) {
					var current : XMLList = m_shipXml.(@id==ship.@id);
					var stdV : StandardVehicle = new StandardVehicle(current.skin);
					if ("decorator" in current) {
						for each (var decorator : XML in current..decorator.type) {
							trace(" - " + decorator);
							//var decoClass : Class = getDefinitionByName(decorator) as Class;
							//var decorator : decoClass = new decoClass(stdV);
						}
					}
					//trace(ship.@id);
					//Pour chaque ship loader ship
						// Pour chaque weapon
							//La bullet
				}
			}
		}
		
		public function Game(map:Map, bulletXml:XMLList, levelXml:XMLList, shipXml:XMLList, weaponXml:XMLList) {

			m_bulletXml = bulletXml;
			m_levelXml = levelXml;
			m_shipXml = shipXml;
			m_weaponXml = weaponXml;
			
			init();
			
			
			Rndm.seed = Math.floor(Math.random() * 1000 - 10 + 1) + 1;
			m_displayPlayerBullets = new Vector.<IBullet>();
			m_displayEnnemyBullets = new Vector.<IBullet>();
			m_displayEnnemyVehicles = new Vector.<IVehicle>();
			m_displayPlayerVehicles = new Vector.<IVehicle>();
			m_displayEnnemyWeapons = new Vector.<IWeapon>();
			m_displayPlayerWeapons = new Vector.<IWeapon>();
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
		private function surveyEnnemyBullet(obj :IBullet) : void {
			obj.addEventListener(CustomEvent.DEAD, deadBullet);
			m_displayEnnemyBullets.push(obj);
		}
		
		private function surveyPlayerBullet(obj :IBullet) : void {
			obj.addEventListener(CustomEvent.DEAD, deadBullet);
			m_displayPlayerBullets.push(obj);
		}
		
		private function surveyEnnemyWeapon(obj : IWeapon) : void {
			obj.addEventListener(CustomEvent.DEAD, deadWeapon);
			obj.addEventListener(CustomEvent.SHOOT, addEnnemyBullet);
			m_displayEnnemyWeapons.push(obj);
		}
		
		private function surveyPlayerWeapon(obj : IWeapon) : void {
			obj.addEventListener(CustomEvent.DEAD, deadWeapon);
			obj.addEventListener(CustomEvent.SHOOT, addPlayerBullet);
			m_displayPlayerWeapons.push(obj);
		}
		
		private function surveyEnnemyVehicle(obj : IVehicle) : void {
			obj.addEventListener(CustomEvent.DEAD, deadVehicle);
			m_displayEnnemyVehicles.push(obj);
		}
		
		private function surveyPlayerVehicle(obj : IVehicle) : void {
			obj.addEventListener(CustomEvent.DEAD, deadVehicle);
			m_displayPlayerVehicles.push(obj);
		}

		private function addEnnemyBullet(evt : CustomEvent):void {
			addChild(evt.target.bullet);
			surveyEnnemyBullet(evt.target.bullet);
		}
		
		private function addPlayerBullet(evt : CustomEvent):void {
			addChild(evt.target.bullet);
			surveyPlayerBullet(evt.target.bullet);
		}

		private function deadBullet(evt : Event) : void {
			var obj : IBullet = evt.target as IBullet;
			obj.removeEventListener(CustomEvent.DEAD, surveyEnnemyWeapon);
			obj.removeEventListener(CustomEvent.DEAD, surveyPlayerWeapon);
			obj.removeEventListener(CustomEvent.SHOOT, addEnnemyBullet);
			obj.removeEventListener(CustomEvent.SHOOT, addPlayerBullet);
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
			//trace("Destruct IBullet");
			m_displayPlayerBullets.splice(m_displayPlayerBullets.indexOf(obj), 1);
			m_displayEnnemyBullets.splice(m_displayEnnemyBullets.indexOf(obj), 1);
			obj.destructor();
			obj = null;
		}
		
		private function destructVehicle(obj : IVehicle) : void {
			//trace("Destruct IVehicle");
			m_displayPlayerVehicles.splice(m_displayPlayerVehicles.indexOf(obj), 1);
			m_displayEnnemyVehicles.splice(m_displayEnnemyVehicles.indexOf(obj), 1);
			obj.destructor();
			obj = null;
		}
		
		private function destructWeapon(obj : IWeapon) : void {
			//trace("Destruct IWeapon");
			m_displayPlayerWeapons.splice(m_displayPlayerWeapons.indexOf(obj), 1);
			m_displayEnnemyWeapons.splice(m_displayEnnemyWeapons.indexOf(obj), 1);
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
			surveyPlayerVehicle(m_player.decoVehicle);
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
					m_player.stdWeapon.addEventListener(CustomEvent.SHOOT, addPlayerBullet);
					m_displayPlayerWeapons.push(m_player.stdWeapon);				
					break;
				case MouseEvent.MOUSE_UP :
					m_displayPlayerWeapons.splice(m_displayPlayerWeapons.indexOf(m_player.stdWeapon), 1);
					m_player.stdWeapon.removeEventListener(CustomEvent.SHOOT, addPlayerBullet);
					break;
			}
		}
		
		private function loop(evt : Event) : void {
			for each (var eVehicle : IVehicle in m_displayEnnemyVehicles) {
				eVehicle.loop();
				
				for each (var pCollBullet : IBullet in m_displayPlayerBullets) {
					//trace(vehicle.x + " - " + vehicle.y + " / " + vehicle.width + " - " + vehicle.height);
					//trace(collBullet.x + " - " + collBullet.y + " / " + collBullet.width + " - " + collBullet.height);
					//trace(vehicle);
					if (eVehicle.hitTestObject(pCollBullet as DisplayObject)) {
						//trace("collision ennemy\n--------");
						trace(eVehicle.looseLife(pCollBullet.damage));
						pCollBullet.explode();
					}
				}
				
				if (eVehicle.x < -eVehicle.width || eVehicle.y < -eVehicle.height
					|| eVehicle.x > stage.stageWidth + eVehicle.width
					|| eVehicle.y > stage.stageHeight + eVehicle.height) {
					destructVehicle(eVehicle);
				}
			}
			
			for each (var pVehicle : IVehicle in m_displayPlayerVehicles) {
				pVehicle.loop();
				for each (var eCollBullet : IBullet in m_displayEnnemyBullets) {
					//trace(pVehicle.x + " - " + pVehicle.y + " / " + pVehicle.width + " - " + pVehicle.height);
					//trace(collBullet.x + " - " + collBullet.y + " / " + collBullet.width + " - " + collBullet.height);
					//trace(pVehicle);
					if (pVehicle.hitTestObject(eCollBullet as DisplayObject)) {
						//
						trace("collision player\n--------");
						trace(pVehicle.looseLife(eCollBullet.damage));
					}
				}
				
				if (pVehicle.x < -pVehicle.width || pVehicle.y < -pVehicle.height
					|| pVehicle.x > stage.stageWidth + pVehicle.width
					|| pVehicle.y > stage.stageHeight + pVehicle.height) {
					destructVehicle(pVehicle);
				}
			}
			
			for each (var eBullet : IBullet in m_displayEnnemyBullets) {
				eBullet.loop();
				if (eBullet.x < -eBullet.width || eBullet.y < -eBullet.height
					|| eBullet.x > stage.stageWidth + eBullet.width
					|| eBullet.y > stage.stageHeight + eBullet.height) {
					destructBullet(eBullet);
				}
			}
			
			for each (var pBullet : IBullet in m_displayPlayerBullets) {
				pBullet.loop();
				if (pBullet.x < -pBullet.width || pBullet.y < -pBullet.height
					|| pBullet.x > stage.stageWidth + pBullet.width
					|| pBullet.y > stage.stageHeight + pBullet.height) {
					destructBullet(pBullet);
				}
			}
			
			for each (var eWeapon : IWeapon in m_displayEnnemyWeapons) {
				eWeapon.loop();
				if (eWeapon.x < -eWeapon.width || eWeapon.y < -eWeapon.height
					|| eWeapon.x > stage.stageWidth + eWeapon.width
					|| eWeapon.y > stage.stageHeight + eWeapon.height) {
					destructWeapon(eWeapon);
				}
				//trace("\n");
			}
			
			for each (var pWeapon : IWeapon in m_displayPlayerWeapons) {
				pWeapon.loop();
				if (pWeapon.x < -pWeapon.width || pWeapon.y < -pWeapon.height
					|| pWeapon.x > stage.stageWidth + pWeapon.width
					|| pWeapon.y > stage.stageHeight + pWeapon.height) {
					destructWeapon(pWeapon);
				}
				//trace("\n");
			}
			m_player.kart.loop();
			m_map.kartZone(m_player.kart);
		}
	}
}