package imac.diehardkart.utils {
	import imac.diehardkart.decorable.bullet.IBullet;
	import flash.events.Event;

	public class CustomEvent extends Event {
		// Evt when out of stage (out of bounds or dead)
		public static const OUT_OF_STAGE : String = "out of stage";
		 // Evt when out of stage (out of bounds or dead)
		public static const EXPLOSION : String = "explosion";
		 // Evt when out of stage (out of bounds or dead)
		public static const DEAD : String = "dead";
		 // Evt when out of stage (out of bounds or dead)
		public static const LOADED : String = "loadé";
		 // Evt when shooting bullet
		public static const SHOOT : String = "tire une bullet";

		private var m_linked : IBullet;
		
		/* \brief Construct a new CustomEvent
		 * \params type a String describing the event
		 */
		public function CustomEvent(type : String, linked : IBullet = null) {
			super(type, false, false);
			m_linked = linked;
		}
	}
}
