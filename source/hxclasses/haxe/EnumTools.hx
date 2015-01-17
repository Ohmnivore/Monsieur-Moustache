package haxe;

extern class EnumTools {
	static function createAll<T>(e : Enum<T>) : Array<T>;
	static function createByIndex<T>(e : Enum<T>, index : Int, ?params : Array<Dynamic>) : T;
	static function createByName<T>(e : Enum<T>, constr : String, ?params : Array<Dynamic>) : T;
	static function getConstructors<T>(e : Enum<T>) : Array<String>;
	static function getName<T>(e : Enum<T>) : String;
}
