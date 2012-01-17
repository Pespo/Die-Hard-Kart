package {
	import imac.diehardkart.Game;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite {
		private static var m_game : Game;
		
		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
			m_game = new Game();
		}
		
		private function addedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addChild(m_game);
		}
	}
}