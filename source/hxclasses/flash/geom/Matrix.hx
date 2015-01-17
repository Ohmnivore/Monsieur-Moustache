package flash.geom;

extern class Matrix {
	var a : Float;
	var b : Float;
	var c : Float;
	var d : Float;
	var tx : Float;
	var ty : Float;
	function new(a : Float = 0, b : Float = 0, c : Float = 0, d : Float = 0, tx : Float = 0, ty : Float = 0) : Void;
	function clone() : Matrix;
	function concat(m : Matrix) : Void;
	function createBox(scaleX : Float, scaleY : Float, rotation : Float = 0, tx : Float = 0, ty : Float = 0) : Void;
	function createGradientBox(width : Float, height : Float, rotation : Float = 0, tx : Float = 0, ty : Float = 0) : Void;
	function deltaTransformPoint(point : Point) : Point;
	function identity() : Void;
	function invert() : Void;
	function rotate(angle : Float) : Void;
	function scale(sx : Float, sy : Float) : Void;
	function toString() : String;
	function transformPoint(point : Point) : Point;
	function translate(dx : Float, dy : Float) : Void;
}
