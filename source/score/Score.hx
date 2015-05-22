package score ;

import ent.Player;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextBorderStyle;

/**
 * ...
 * @author Ohmnivore
 */
class Score
{
	static public var s:Int = 0;
	static public var sBest:Int = 0;
	
	static public function getScore(P:Player):Int
	{
		if (P.alive)
			s = Std.int(( -P.y + FlxG.height * 2.0) / 9.0);
		
		return s;
	}
	static public function getY(S:Int):Float
	{
		return -S * 9.0 + FlxG.height * 2.0;
	}
	
	static public function setTextStyle(T:FlxText):Void
	{
		T.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff000000);
	}
	
	static public function saveScore():Void
	{
		FlxG.save.bind("Elasticate");
		var overwrite:Bool = false;
		if (FlxG.save.data.score == null)
		{
			overwrite = true;
		}
		else
		{
			if (FlxG.save.data.score < s)
			{
				overwrite = true;
			}
		}
		
		if (overwrite)
		{
			FlxG.save.data.score = s;
		}
		
		FlxG.save.close();
	}
	
	static public function loadScore():Void
	{
		FlxG.save.bind("Elasticate");
		if (FlxG.save.data.score != null)
		{
			sBest = FlxG.save.data.score;
		}
		
		FlxG.save.close();
	}
}