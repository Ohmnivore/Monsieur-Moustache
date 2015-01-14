package sfx;

/**
 * ...
 * @author Ohmnivore
 */
class Util
{
	static public function addExtension(S:String):String 
	{
		#if web
		S += ".mp3";
		#else
		S += ".ogg";
		#end
		
		return S;
	}
}