package flash.geom;

extern class ColorTransform {
	var alphaMultiplier : Float;
	var alphaOffset : Float;
	var blueMultiplier : Float;
	var blueOffset : Float;
	var color : UInt;
	var greenMultiplier : Float;
	var greenOffset : Float;
	var redMultiplier : Float;
	var redOffset : Float;
	function new(redMultiplier : Float = 0, greenMultiplier : Float = 0, blueMultiplier : Float = 0, alphaMultiplier : Float = 0, redOffset : Float = 0, greenOffset : Float = 0, blueOffset : Float = 0, alphaOffset : Float = 0) : Void;
	function concat(second : ColorTransform) : Void;
	function toString() : String;
}
