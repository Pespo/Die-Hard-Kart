package imac.diehardkart.decorable {

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public interface IDecorator {
		function get view() : MovieClip;
		function set view(v : MovieClip) : void;
		function loop() : void;
		function rotate(angle : Number) : void;
		function set speed(s : Number) : void;
		function get speed() : Number;
		function get x() : Number;
		function get y() : Number;
		function set x(x : Number) : void;
		function set y(y : Number) : void;
		function get height() : Number;
		function get width() : Number;
		function get dx() : Number;
		function get dy() : Number;
		function get rotation() : Number;
		function set rotation(r : Number) : void;
		function setOrientation(dx : Number, dy : Number) : void;
		function hitTestObject(obj : DisplayObject) : Boolean;
		function destructor() : void;
		function addChild(child : DisplayObject) : DisplayObject;
		function addEventListener(type  : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void;
		function removeEventListener(type  : String, listener : Function, useCapture : Boolean = false) : void;
	}
}
