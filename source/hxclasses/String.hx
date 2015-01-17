extern class String {
	var length(default,null) : Int;
	function new(string : String) : Void;
	function charAt(index : Int) : String;
	function charCodeAt(index : Int) : Null<Int>;
	function indexOf(str : String, startIndex : Null<Int> = 0) : Int;
	function lastIndexOf(str : String, startIndex : Null<Int> = 0) : Int;
	function split(delimiter : String) : Array<String>;
	function substr(pos : Int, len : Null<Int> = 0) : String;
	function substring(startIndex : Int, endIndex : Null<Int> = 0) : String;
	function toLowerCase() : String;
	function toString() : String;
	function toUpperCase() : String;
	static function fromCharCode(code : Int) : String;
}
