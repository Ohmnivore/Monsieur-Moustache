package gen;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Strip
{
	public var x:Int;
	public var width:Int;
	public var maxX:Int;
	public var maxY:Int;
	
	public function new(CenterX:Int, Width:Int, MaxX:Int, MinX:Int) 
	{
		x = CenterX - Math.floor(Width / 2.0);
		width = Width;
		
		while (x < MinX)
			x++;
		
		var right:Bool = false;
		while (x + Width > MaxX)
		{
			right = true;
			x--;
		}
		
		if (Width % 2 == 0 && !right)
		{
			if (FlxRandom.chanceRoll())
			{
				x += 1;
			}
		}
	}
	
	public function getArr():Array<Int>
	{
		var ret:Array<Int> = [];
		
		var i:Int = 0;
		while ( i < width)
		{
			ret.push(x + i);
			
			i++;
		}
		
		return ret;
	}
}