package flash;

@:keep extern class Boot extends flash.display.MovieClip {
	function new() : Void;
	static var skip_constructor : Bool;
	static function __clear_trace() : Void;
	static function __instanceof(v : Dynamic, t : Dynamic) : Bool;
	static function __set_trace_color(rgb : UInt) : Void;
	static function __string_rec(v : Dynamic, str : String) : String;
	static function __trace(v : Dynamic, pos : haxe.PosInfos) : Void;
	static function enum_to_string(e : {tag : String, params : Array<Dynamic>}) : String;
	static function getTrace() : flash.text.TextField;
}
