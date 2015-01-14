package ui;

import flixel.text.FlxText;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class Title extends FlxText
{
	public static var TITLE:String = "Elasticate";
	
	public function new(Y:Float) 
	{
		super(0, Y, 0, TITLE, 16);
		
		x = (FlxG.width - width) / 2.0;
		scrollFactor.set();
		
		color = 0xffE1FDFF;
		setBorderStyle(FlxText.BORDER_SHADOW, 0xff3E5154, 2, 2);
	}
}