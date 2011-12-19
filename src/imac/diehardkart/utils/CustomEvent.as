package imac.diehardkart.utils {
	import flash.events.Event;

	public class CustomEvent extends Event {
		
		public static const OUT_OF_STAGE : String = "out of stage"; //Evt when out of stage (out of bounds or dead)
		public static const EXPLOSION : String = "explosion"; //Evt when out of stage (out of bounds or dead)
		public static const DEAD : String = "dead"; //Evt when out of stage (out of bounds or dead)
		
		/* \brief Construct a new CustomEvent
		 * \params type a String describing the event
		 */
		public function CustomEvent(type : String) {
			super(type, false, false);
		}
	}
}
