package biz;

import flixel.FlxG;

/**
 * A FlxState which can be used for the game's menu.
 */
class SiteLock
{
	private static var siteLockEnabled:Bool = false;
	private static var allowedDomains:Array<String> = ["https://www.fgl.com/",
		"https://www.flashgamelicense.com/",
		"http://fouramgames.com/"];
	private static var redirectURL:String = "https://www.fgl.com/";
	private static var allowOffline:Bool = true;
	
	static public function takeToSite():Void
	{
		FlxG.openURL(redirectURL, "_self");
	}
	
	static public function shouldLock():Bool
	{
		if (!siteLockEnabled)
			return false;
		
		if (allowOffline)
		{
			if (FlxG.stage.loaderInfo.url.substr(0, 4) == "file")
				return false;
		}
		
		var isOkay:Bool = false;
		
		for (url in allowedDomains)
		{
			var firstInd:Int = FlxG.stage.loaderInfo.url.indexOf(url);
			var lastInd:Int = FlxG.stage.loaderInfo.url.lastIndexOf(url);
			
			if (firstInd >= 0 && firstInd == lastInd)
			{
				isOkay = true;
			}
		}
		
		return !isOkay;
	}
}