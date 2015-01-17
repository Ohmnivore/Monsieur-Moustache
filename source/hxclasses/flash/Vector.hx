package flash;

@:require(flash10) extern class Vector<T> {
	var fixed : Bool;
	var length : Int;
	function new(length : Null<UInt> = 0, fixed : Null<Bool> = false) : Void;
	function concat(?a : Vector<T>) : Vector<T>;
	function indexOf(x : T, from : Null<Int> = 0) : Int;
	function join(sep : String) : String;
	function lastIndexOf(x : T, from : Null<Int> = 0) : Int;
	function pop() : Null<T>;
	function push(x : T) : Int;
	function reverse() : Void;
	function shift() : Null<T>;
	function slice(pos : Null<Int> = 0, end : Null<Int> = 0) : Vector<T>;
	function sort(f : T -> T -> Int) : Void;
	function splice(pos : Int, len : Int) : Vector<T>;
	function toString() : String;
	function unshift(x : T) : Void;
	static function convert<T,U>(v : Vector<T>) : Vector<U>;
	static function ofArray<T>(v : Array<T>) : Vector<T>;
}
