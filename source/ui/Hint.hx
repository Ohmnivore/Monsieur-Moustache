package ui;

import flixel.FlxG;
import flixel.text.FlxText;

/**
 * ...
 * @author Ohmnivore
 */
class Hint extends FlxText
{
	public function new(Y:Float) 
	{
		super(0, Y, FlxG.width / 3, "Drag down, then release to jump.");
		
		color = 0xffE1FDFF;
		setBorderStyle(FlxText.BORDER_SHADOW, 0xff3E5154, 2, 2);
		alignment = "center";
	}
	
	override public function update():Void 
	{
		super.update();
		
		x = (FlxG.width - width) / 2.0;
		y -= 0.3;
		
		alpha -= 0.002;
		if (alpha <= 0)
		{
			kill();
			destroy();
		}
	}
}