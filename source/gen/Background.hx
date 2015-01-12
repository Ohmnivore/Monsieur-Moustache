package gen;

import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Background
{
	static private var colors:Array<Int> = [0xff877085, 0xff748770, 0xff878370, 0xff877770];
	
	static public function getRandColor():Int
	{
		return FlxRandom.getObject(colors);
	}
}