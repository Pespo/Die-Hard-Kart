package imac.diehardkart.map {
	import flash.display.Sprite;
	import flash.display.Stage;

	import maps.TestMap.Sand;
	import maps.TestMap.Road;
	
	
	/**
	 * ...
	 * @author kimo
	 */
	public class Map extends Sprite {
		public static var STAGE : Stage;
		private var road : Road;
		private var sand : Sand;
		
		public function Map(stage:Stage) {
			STAGE = stage;
			road = new Road();
			road.x = STAGE.stageWidth / 2;
			road.y = STAGE.stageHeight / 2;
			sand = new Sand();
			sand.x = STAGE.stageWidth / 2;
			sand.y = STAGE.stageHeight / 2;
			STAGE.addChildAt(sand, 0);
			STAGE.addChildAt(road, 1);
		}
	}
}