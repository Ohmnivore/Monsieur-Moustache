package gen;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Platform
{
	static public function getNew(Start:FlxPoint, MaxY:Float, MaxX:Float, Grav:Float, S:GenSettings):FlxPoint
	{
		MaxX = FlxRandom.floatRanged(MaxX * S.minVelX, MaxX * S.maxVelX);
		Grav = FlxRandom.floatRanged(Grav * S.minGrav, Grav * S.maxGrav);
		
		if (FlxRandom.chanceRoll())
		{
			MaxX = -MaxX;
		}
		
		var secondZero:Float = inverseAfterSummit(0, 0, MaxY, Grav);
		var t:Float = FlxRandom.floatRanged(secondZero * S.minTime, secondZero * S.maxTime);
		
		var ypos:Float = (Grav * Math.pow(t, 2.0)) / 2.0 + MaxY * t + Start.y;
		var xpos:Float = MaxX * t + Start.x;
		
		return new FlxPoint(xpos, ypos);
	}
	
	static private function inverseAfterSummit(Y:Float, StartY:Float, MaxY:Float, Grav:Float):Float
	{
		return (Math.pow((2.0 * Grav * Y) - (2.0 * Grav * StartY) + Math.pow(MaxY, 2.0), 0.5) - MaxY) / Grav;
	}
}