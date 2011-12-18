package imac.diehardkart.vehicle {
	import flash.display.MovieClip;
	import flash.events.Event;
	import imac.diehardkart.vehicle.Vehicle;

	public class StandardVehicle extends MovieClip implements Vehicle {
		// Constants (can be set in another file, for the designers for example)
		// Explosion Event
		public static const EXPLOSION : String = "explosion";
		// Names for tags in the timeline
		public static const INIT_FRAME : String = "initialisation";
		public static const EXPLOSION_FRAME : String = "explosion";
		public static const EXPLOSION_DONE_FRAME : String = "explosion_done";
		
		// Movement Rate
		private var ctr_framesSinceLastMove:uint = 0;
		private var _framesTilMove:uint;
		
		// @todo : Make sure types are correct.
		
		// current life of vehicle
		private var _life : Number;
		// for making vehicle more or less destroyable
		private var _coeffLifeLost : Number;
		// speed (in percents)
		private var _speed : Number;
		// explosion damages : life 
		private var _maxDamages : Number;
		// explosion range
		private var _explosionRange : Number;
		// coordinates of the translation vector, normed
		private var _directionX : Number;
		private var _directionY : Number;
		
		// Constructor
		public function StandardVehicle(direc_x:Number = null, direc_y:Number = null, maxDamages:Number = 10, explosionRange:Number = 20, coeffLifeLost:Number = 1, speed:Number = 100, life:Number = 100, framesTilMove:uint = 10) : void {
			if (direc_x && direc_y)
				this.setDirection(direc_x, direc_y);
			_speed = speed;
			_life = life;
			_coeffLifeLost = coeffLifeLost;
			_maxDamages = maxDamages;
			_explosionRange = explosionRange;
			_framesTilMove = framesTilMove;
			
			// managing memory consumption
			addEventListener(Event.ADDED_TO_STAGE, _add);
			addEventListener(Event.REMOVED_FROM_STAGE, _remove);
		}
		
		// Constructor using a XML config file
		public function StandardVehicle(config:XML) : void {
			var direc_x : Number = 1; // config.direction.x;
			var direc_y : Number = 1; // config.direction.y;
			
			_life = 100; // config.life;
			_speed = 100; // config.speed;
			_coeffLifeLost = 1; // config.coeffLifeLost;
			_maxDamages = 10; // config.maxDamages;
			_explosionRange = 20; // config.explosionRange;
			_framesTilMove = framesTilMove; // config.framesTilMove;
			
			if (direc_x && direc_y)
				this.setDirection(direc_x, direc_y);
			
			_framesSinceLastMove = 0;
			// managing memory consumption
			addEventListener(Event.ADDED_TO_STAGE, _add);
			addEventListener(Event.REMOVED_FROM_STAGE, _remove);
		}
		
		// Setting listeners
		private function _add(evt:Event) : void {
			this.gotoAndPlay(Vehicle.INIT_FRAME);
			this.removeEventListener(Event.ADDED_TO_STAGE, _add);
			this.addEventListener(Event.ENTER_FRAME, _action);
		}
		
		// Removing listeners
		private function _remove(evt:Event) : void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, _remove);
		}
		
		// update at each frame
		private function _action(evt:Event) : void {
			++ctr_framesSinceLastMove;
			if(ctr_framesSinceLastMove == _framesTilMove) {
				_move();
				ctr_framesSinceLastMove = 0;
			}
			if (_life <= 0) {
				this.explode();
			}
			
			// @todo : VERY NOT SURE. Where is the vehicle = null ???
			if (currentFrameLabel = Vehicle.EXPLOSION_DONE_FRAME)
				this.parent.removeChild(this);
		}
		
		// every vehicle is moving
		private function _move(evt:Event) : void {
			if (_directionX && _directionY) {
				this.x = this.x + (_directionX * speed) / 100;
				this.y = this.y + (_directionY * speed) / 100;
			}
		}
		
		// setting the normed translation vector
		public function setDirection(direc_x:Number, direc_y:Number) : void {
			var norm: Number = Math.sqrt(direc_x * direc_x + direc_y * direc_y);
			_directionX = (norm == 0) ? 0 : direc_x / norm;
			_directionY = (norm == 0) ? 0 : direc_y / norm;
		}
		
		// Explosion
		public function explode() : void {
			this.gotoAndPlay(Vehicle.EXPLOSION_FRAME);
			this.dispatchEvent(new Event(Vehicle.EXPLOSION));
		}
		
		// Loose life
		public function looseLife(damages:int) : void {
			_life = _life - damages * _coeffLifeLost;
		}
	}
}