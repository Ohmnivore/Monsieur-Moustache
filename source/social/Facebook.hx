package social;

import flixel.FlxG;
import ui.Title;

/**
 * ...
 * @author Ohmnivore
 */
class Facebook
{
	static private var APPID:String = "1535775853359478";
	static private var LINK:String = "https://www.facebook.com/4amgames";
	
	static public function shareScore(S:Int):Void
	{
		var url:String = "https://www.facebook.com/dialog/feed?";
		url += getAppID();
		url += getDisplay();
		url += getDescription(S);
		url += getLink();
		url += getRedirect();
		url += "&picture=http://fouramgames.com/misc/iconFacebook.png";
		
		FlxG.openURL(url);
	}
	
	static private function getText(S:Int):String
	{
		var ret:String = "text=Awesome new highscore of " + S + " meters!";
		
		return ret.split(" ").join("+");
	}
	static private function getAppID():String
	{
		return "app_id=" + APPID;
	}
	static private function getDisplay():String
	{
		return "&display=page";
	}
	static private function getLink():String
	{
		return "&link=" + LINK;
	}
	static private function getRedirect():String
	{
		return "&redirect_uri=http://fouramgames.com/";
	}
	static private function getDescription(S:Int):String
	{
		return "&description=New highscore of " + S + "m!";
	}
}