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
		playSound("stretch");
	}
	static public function playJump():Void
	{
		playSound("jump", 0.2);
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
		var s:String = "sounds/" + Util.addExtension(S);
		
		FlxG.sound.play(s, Volume);
	}
}