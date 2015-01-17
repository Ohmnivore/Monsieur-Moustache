extern class Array<T> {
	var length(default,null) : Int;
	function new() : Void;
	function concat(a : Array<T>) : Array<T>;
	function copy() : Array<T>;
	function filter(f : T -> Bool) : Array<T>;
	function indexOf(x : T, fromIndex : Null<Int> = 0) : Int;
	function insert(pos : Int, x : T) : Void;
	function iterator() : Iterator<T>;
	function join(sep : String) : String;
	function lastIndexOf(x : T, fromIndex : Null<Int> = 0) : Int;
	function map<S>(f : T -> S) : Array<S>;
	function pop() : Null<T>;
	function push(x : T) : Int;
	function remove(x : T) : Bool;
	function reverse() : Void;
	function shift() : Null<T>;
	function slice(pos : Int, end : Null<Int> = 0) : Array<T>;
	function sort(f : T -> T -> Int) : Void;
	function splice(pos : Int, len : Int) : Array<T>;
	function toString() : String;
	function unshift(x : T) : Void;
}
