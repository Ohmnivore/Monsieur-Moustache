package gen;
import flixel.math.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Beautify
{
	static public var CRATE:Int = 8;
	static public var BARREL_BOT:Int = 9;
	static public var BARREL_TOP:Int = 10;
	static public var VENT:Int = 11;
	
	public static function getBeautiful(M:Array<Int>, Width:Int):Array<Int> 
	{
		var height:Int = cast M.length / Width;
		
		for (times in 0...2)
		{
		var iY:Int = 0;
		while (iY < height)
		{
			var iX:Int = 0;
			while (iX < Width)
			{
				var underTile:Int = getDataTile(M, iX, iY + 1, Width);
				var underTile2:Int = getDataTile(M, iX, iY + 2, Width);
				var leftTile:Int = getDataTile(M, iX - 1, iY, Width);
				var rightTile:Int = getDataTile(M, iX + 1, iY, Width);
				if (new FlxRandom().bool(40))
				{
					if (isSolid(underTile))
					{
						var toPlace:Int = getAny();
						
						setDataTile(M, Width, iX, iY, toPlace);
						if (toPlace == BARREL_BOT)
						{
							setDataTile(M, Width, iX, iY - 1, BARREL_TOP);
						}
					}
					else if (isCosmetic(underTile) || isSolid(underTile2) &&
						(isSolid(leftTile) || isCosmetic(leftTile) || isSolid(rightTile) || isCosmetic(rightTile)))
					{
						var toPlace:Int = VENT;
						
						setDataTile(M, Width, iX, iY, toPlace);
					}
				}
				
				iX++;
			}
			
			iY++;
		}
		}
		
		return M;
	}
	
	private static function setDataTile(Data:Array<Int>, Width:Int, X:Int, Y:Int, Value:Int):Bool
	{
		if (X <= Width - 1 && X >= 1 && getDataTile(Data, X, Y, Width) == 0)
		{
			Data[X + Y * Width] = Value;
			
			return true;
		}
		else
		{
			return false;
		}
	}
	
	private static function getDataTile(Data:Array<Int>, X:Int, Y:Int, Width:Int):Int
	{
		var i:Int = X + Y * Width;
		
		if (i < Data.length)
		{
			return Data[i];
		}
		
		return -1;
	}
	
	private static function isSolid(T:Int):Bool
	{
		if (T == Strip.CENTER_ALT_T || T == Strip.CENTER_T || T == Strip.LEFT_ALT_T ||
			T == Strip.LEFT_T || T == Strip.RIGHT_ALT_T || T == Strip.RIGHT_T || T == CRATE)
			return true;
		
		return false;
	}
	
	private static function isCosmetic(T:Int):Bool
	{
		if (T == VENT)
			return true;
		
		return false;
	}
	
	private static function getAny():Int
	{
		return new FlxRandom().getObject([CRATE, BARREL_BOT, VENT]);
	}
}