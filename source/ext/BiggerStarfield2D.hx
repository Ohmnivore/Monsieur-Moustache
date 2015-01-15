package ext;

import flixel.addons.display.FlxStarField.FlxStarField2D;

/**
 * ...
 * @author Ohmnivore
 */
class BiggerStarfield2D extends FlxStarField2D
{
	public function new(X:Int = 0, Y:Int = 0, Width:Int = 0, Height:Int = 0, StarAmount:Int = 300) 
	{
		super(X, Y, Width, Height, StarAmount);
	}
}