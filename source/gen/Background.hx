package gen;

import flixel.math.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Background
{
	//static private var colors:Array<Int> = [0xff877085, 0xff748770, 0xff878370, 0xff877770];
	//static private var colors:Array<Int> = [0xffC0A79F, 0xffC0BE9F, 0xffA8C09F, 0xffBD9FC0];
	static private var colors:Array<Int> = [0xffA48E87, 0xffA09E83, 0xff8CA083, 0xff9D83A0];
	
	static public function getRandColor():Int
	{
		return new FlxRandom().getObject(colors);
	}
}