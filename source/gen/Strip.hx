package gen;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Strip
{
	static public var LEFT_T:Int = 2;
	static public var CENTER_T:Int = 3;
	static public var RIGHT_T:Int = 4;
	static public var LEFT_ALT_T:Int = 5;
	static public var CENTER_ALT_T:Int = 6;
	static public var RIGHT_ALT_T:Int = 7;
	static public var NORMAL:Int = 0;
	static public var ALT:Int = 1;
	
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
	
	static public function getVerboseArr(Width:Int):Array<Int>
	{
		var ret:Array<Int> = [];
		
		var i:Int = 0;
		//var d:Array<Int> = getArr();
		var style:Int = NORMAL;
		if (FlxRandom.chanceRoll(90))
				style = ALT;
		while (i < Width)
		{
			var rightTile:Int = RIGHT_T;
			var normalTile:Int = LEFT_T;
			if (FlxRandom.chanceRoll(20))
				normalTile = CENTER_T;
			
			if (style == ALT)
			{
				rightTile = RIGHT_ALT_T;
				normalTile = LEFT_ALT_T;
				if (FlxRandom.chanceRoll(40))
					normalTile = CENTER_ALT_T;
			}
			
			var toSet:Int = normalTile;
			if (i == Width - 1)
				toSet = rightTile;
			
			ret.push(toSet);
			
			i++;
		}
		
		return ret;
	}
}