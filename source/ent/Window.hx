package ent;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Ohmnivore
 */
class Window extends FlxSprite
{
	public function new(Y:Float)
	{
		super(0, Y, "images/window.png");
		
		FlxSpriteUtil.screenCenter(this, true, false);
	}
}