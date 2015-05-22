package gen;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Platform
{
	static public function getNew(Start:FlxPoint, MaxY:Float, MaxX:Float, Grav:Float, S:GenSettings):FlxPoint
	{
		MaxX = new FlxRandom().float(MaxX * S.minVelX, MaxX * S.maxVelX);
		Grav = new FlxRandom().float(Grav * S.minGrav, Grav * S.maxGrav);
		
		if (new FlxRandom().bool())
		{
			MaxX = -MaxX;
		}
		
		var secondZero:Float = inverseAfterSummit(0, 0, MaxY, Grav);
		var t:Float = new FlxRandom().float(secondZero * S.minTime, secondZero * S.maxTime);
		
		var ypos:Float = (Grav * Math.pow(t, 2.0)) / 2.0 + MaxY * t + Start.y;
		var xpos:Float = MaxX * t + Start.x;
		
		return new FlxPoint(xpos, ypos);
	}
	
	static private function inverseAfterSummit(Y:Float, StartY:Float, MaxY:Float, Grav:Float):Float
	{
		return (Math.pow((2.0 * Grav * Y) - (2.0 * Grav * StartY) + Math.pow(MaxY, 2.0), 0.5) - MaxY) / Grav;
	}
}