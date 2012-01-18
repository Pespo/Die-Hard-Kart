package imac.diehardkart.decorable.vehicle {
	import imac.diehardkart.decorable.IDecorator;
	
	public interface IVehicle extends IDecorator {

		function looseLife(damage : Number) : Number;
	}
}