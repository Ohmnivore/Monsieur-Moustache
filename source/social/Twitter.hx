package social;

import flixel.FlxG;
import ui.Title;

/**
 * ...
 * @author Ohmnivore
 */
class Twitter
{
	static private var USERNAME:String = "4_AM_Games";
	
	static public function tweetScore(S:Int):Void
	{
		var url:String = "https://twitter.com/intent/tweet?";
		url += getText(S);
		url += getVia();
		url += getHashtag();
		
		FlxG.openURL(url);
	}
	
	static private function getText(S:Int):String
	{
		var ret:String = "text=Awesome new highscore of " + S + " meters!";
		
		return ret.split(" ").join("+");
	}
	static private function getVia():String
	{
		return "&via=" + USERNAME;
	}
	static private function getHashtag():String
	{
		return "&hashtags=" + Title.TITLE.toLowerCase();
	}
}