package haxe;

extern class EnumValueTools {
	static function equals<T>(a : T, b : T) : Bool;
	static function getIndex(e : EnumValue) : Int;
	static function getName(e : EnumValue) : String;
	static function getParameters(e : EnumValue) : Array<Dynamic>;
}
