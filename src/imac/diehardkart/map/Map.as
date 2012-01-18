package imac.diehardkart.map {
	import imac.diehardkart.decorable.vehicle.Kart;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.EventDispatcher;
	
	public class Map extends EventDispatcher {
		private var m_mapUrl : String;
		private var m_mapUrlLoader : Loader;
		private var m_mapUrlRequest : URLRequest;
		private var m_mapBitmap : Bitmap;
		
		private var m_refMapUrl : String;
		private var m_refMapLoader : Loader;
		private var m_refMapUrlRequest : URLRequest;
		private var m_refMapBitmap : Bitmap;

		private var m_actualZone : String;
		private var m_mapCheckpoints : Number;
		private var m_mapLaps : Number;
		
		private var m_loaded : Number = 0;
		private const m_total : Number = 2;
		
		public function Map(path : String, refPath : String) {
			m_refMapUrl = refPath;
			m_refMapLoader = new Loader();
			m_refMapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, refMapLoaded);
			m_refMapUrlRequest = new URLRequest(m_refMapUrl);
			m_refMapLoader.load(m_refMapUrlRequest);
			
			m_mapUrl = path;
			m_mapUrlLoader = new Loader();
			m_mapUrlLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, mapLoaded);
			m_mapUrlRequest = new URLRequest(m_mapUrl);
			m_mapUrlLoader.load(m_mapUrlRequest);
			
			m_actualZone = "road";
		}

        private function refMapLoaded(evt : Event) : void {
			trace("Ref Map Loaded");
            m_refMapBitmap = Bitmap(evt.target.loader.content);
			if (++m_loaded >= m_total) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
        }
		
		private function mapLoaded(evt : Event) : void {
			trace("Map Loaded");
			m_mapBitmap = Bitmap(evt.target.loader.content);
			if (++m_loaded >= m_total) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function get refMapBitmap() : Bitmap {
			return m_refMapBitmap;
		}
		
		public function get mapBitmap() : Bitmap {
			//trace()
			return m_mapBitmap;
		}
		
		public function kartZone(kart : Kart) : void {
			//trace(m_actualZone);
			//trace(m_refMapBitmap.bitmapData.getPixel(kart.x , kart.y).toString(16));
			if (m_actualZone == "road" 
					&& (m_refMapBitmap.bitmapData.getPixel(kart.x , kart.y)).toString(16) == String("808080")) {
				roadToSand();
				//trace("roadToSand")
			}
			else if (m_actualZone == "sand" 
						&& (refMapBitmap.bitmapData.getPixel(kart.x, kart.y)).toString(16) == String("0")) {
				sandToRoad();
				//trace("sandToRoad")
			}
			else if ((m_actualZone == "road" || m_actualZone == "sand") 
						&& (refMapBitmap.bitmapData.getPixel(kart.x, kart.y)).toString(16) == String("ffff00")) {
				checkpointPassed();
				//trace("checkpointPassed")
			}
			else if ((m_actualZone == "road" || m_actualZone == "sand")
						&& (refMapBitmap.bitmapData.getPixel(kart.x, kart.y)).toString(16) == String("ff0000")) {
				startPassed();
				//trace("startPassed")
			}
			else if ((m_actualZone == "road" || m_actualZone == "sand")
						&& (refMapBitmap.bitmapData.getPixel(kart.x, kart.y)).toString(16) == String("ffffff")) {
				kartOut();
				//trace("kartOut")
			}
		}
		
		private function kartOut() : void {
			trace("loose");
		}
		
		private function checkpointPassed() : void {
			m_mapCheckpoints = 1;
		}
		
		private function startPassed() : void {
			if (m_mapLaps == 0 || m_mapCheckpoints == 1) {
				m_mapCheckpoints = 0;
				++m_mapLaps;
				trace(m_mapLaps);
			}
		}
		
		// Change to call to Class Kart to the right object kart
		private function roadToSand() : void {
			m_actualZone = "sand";
			Kart.MAX_SPEED = Kart.MAX_SPEED_ON_SAND;
		}
		
		// Change to call to Class Kart to the right object kart
		private function sandToRoad() : void {
			m_actualZone = "road";
			Kart.MAX_SPEED = Kart.MAX_SPEED_ON_ROAD;
		}
	}
}