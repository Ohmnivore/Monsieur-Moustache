package sfx;

import flixel.FlxG;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Music
{
	static private var available:Array<String> = ["Jumpshot"];
	static private var curTrack:String = null;
	
	static public function play():Void
	{
		FlxG.sound.playMusic(selectTrack(), 1, false);
		FlxG.sound.music.onComplete = play;
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