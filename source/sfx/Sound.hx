package sfx;

import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class Sound
{
	static public function playStretch():Void
	{
		playSound("stretch", 0.45);
	}
	static public function playJump():Void
	{
		playSound("jump", 0.1);
	}
	static public function playDeath():Void
	{
		playSound("death");
	}
	static public function playHighscore():Void
	{
		playSound("highscore");
	}
	static public function playBlip():Void
	{
		playSound("blip");
	}
	
	static private function playSound(S:String, Volume:Float = 1.0):Void
	{
		#if !html5
		var s:String = "sounds/" + Util.addExtension(S);
		
		FlxG.sound.play(s, Volume);
		#end
	}
}