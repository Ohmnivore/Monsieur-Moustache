package sfx;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Music
{
	static private var available:Array<String> = ["ChibiNinja"];
	static private var curTrack:String = null;
	
	static public function play():Void
	{
		var m:String = selectTrack();
		var s:FlxSound = FlxG.sound.play(m, 1, false, true, play);
		s.persist = true;
	}
	
	static private function selectTrack():String
	{
		var ret:String;
		
		if (available.length == 1)
		{
			ret = available[0];
		}
		else
		{
			var selected:String = curTrack;
			
			while (selected == curTrack)
			{
				selected = FlxRandom.getObject(available);
			}
			
			ret = selected;
		}
		
		curTrack = ret;
		
		ret = "music/" + Util.addExtension(ret);
		
		return ret;
	}
}