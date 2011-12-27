package imac.diehardkart.map {

	import imac.diehardkart.vehicle.ControlledVehicle;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLRequest;
	import imac.diehardkart.utils.CustomEvent;
	import flash.events.EventDispatcher;
	
	
	
	/**
	 * ...
	 * @author kimo
	 */
	public class Map extends EventDispatcher {
		public static var STAGE : Stage;
		
		private var m_mapUrl : String;
		private var m_mapLoader : Loader;
		private var m_mapUrlRequest : URLRequest;
		
		private var m_refMapUrl : String;
		private var m_refMapLoader : Loader;
		private var m_refMapUrlRequest : URLRequest;
		private var m_refMapBitmap : Bitmap;
		
		public function Map(stage:Stage) {
			STAGE = stage;
			
			m_refMapUrl = "../res/maps/refMapTest.gif";
			m_refMapLoader = new Loader();
			m_refMapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, refMapLoaded);
			m_refMapUrlRequest = new URLRequest(m_refMapUrl);
			m_refMapLoader.load(m_refMapUrlRequest);
			
			m_mapUrl = "../res/maps/mapTest.png";
			m_mapLoader = new Loader();
			m_mapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, mapLoaded);
			m_mapUrlRequest = new URLRequest(m_mapUrl);
			m_mapLoader.load(m_mapUrlRequest);
		}

        private function refMapLoaded(evt:Event) : void {
            m_refMapBitmap = Bitmap(evt.target.loader.content);
			dispatchEvent(new CustomEvent(CustomEvent.LOADED));
        }
		
		private function mapLoaded(evt:Event) : void {
			STAGE.addChildAt(m_mapLoader, 0);
			dispatchEvent(new CustomEvent(CustomEvent.LOADED));
		}
		
		public function get refMapBitmap() : Bitmap {
			return m_refMapBitmap;
		}
	}
}