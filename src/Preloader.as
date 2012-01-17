package {
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class Preloader extends MovieClip {
		private var m_firstEnterFrame : Boolean;
		private	var m_preloaderBackground : Shape; 
		private var m_preloaderPercent : Shape;
		
		public function Preloader() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stop();
		}
		
		public function start() : void {
			m_firstEnterFrame = true;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			start();
		}
		
		private function onEnterFrame(event : Event) : void {
			if (m_firstEnterFrame) {
				m_firstEnterFrame = false;
				if (root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal) {
					dispose();
					run();
				} else {
					beginLoading();
				}
				return;
			}

			if (root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal) {
				dispose();
				run();
			} else {
				var percent : Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				updateLoading(percent);
			}
		}
		
		// this function may never be called if the load is instant
		private function updateLoading(a_percent : Number) : void {
			m_preloaderPercent.scaleX = a_percent;
		}
		
		// this function may never be called if the load is instant
		private function beginLoading() : void {
			m_preloaderBackground = new Shape();
			m_preloaderBackground.graphics.beginFill(0x333333);
			m_preloaderBackground.graphics.lineStyle(2,0x000000);
			m_preloaderBackground.graphics.drawRect(0,0,200,20);
			m_preloaderBackground.graphics.endFill();
			
			m_preloaderPercent = new Shape();
			m_preloaderPercent.graphics.beginFill(0xFFFFFFF);
			m_preloaderPercent.graphics.drawRect(0,0,200,20);
			m_preloaderPercent.graphics.endFill();

			addChild(m_preloaderBackground);
			addChild(m_preloaderPercent);
			m_preloaderBackground.x = m_preloaderBackground.y = 10;
			m_preloaderPercent.x = m_preloaderPercent.y = 10;
			m_preloaderPercent.scaleX = 0;
		}
		
		
		private function dispose() : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			if (m_preloaderBackground) {
				removeChild(m_preloaderBackground);
			}
			if (m_preloaderPercent) {
				removeChild(m_preloaderPercent);
			}
			m_preloaderBackground = null;
			m_preloaderPercent = null;
		}
		private function run() : void {
			nextFrame();
			var main : Main = new Main();
			stage.addChildAt(main, 0);
		}
	}
}