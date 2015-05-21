package ui;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.text.FlxText.FlxTextBorderStyle;

/**
 * ...
 * @author Ohmnivore
 */
class Title extends FlxText
{
	public static var TITLE:String = "Monsieur Moustache";
	
	public function new(Y:Float) 
	{
		super(0, Y, FlxG.width - 2, TITLE, 16);
		alignment = "center";
		
		x = (FlxG.width - width) / 2.0;
		scrollFactor.set();
		
		color = 0xffE1FDFF;
		setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff3E5154, 2, 2);
	}
}