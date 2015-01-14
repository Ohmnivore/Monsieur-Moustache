package ui;

import flixel.FlxG;
import flixel.text.FlxText;

/**
 * ...
 * @author Ohmnivore
 */
class UIText extends FlxText
{
	public function new(X:Float, Y:Float, Text:String, Size:Int = 8, Width:Float = 0) 
	{
		if (Width == 0)
			Width = FlxG.width - 2;
		
		super(X, Y, Width, Text, Size);
		
		scrollFactor.set();
		
		color = 0xffE1FDFF;
		setBorderStyle(FlxText.BORDER_SHADOW, 0xff3E5154, 2, 2);
		alignment = "center";
	}
}