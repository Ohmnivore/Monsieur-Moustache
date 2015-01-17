package biz;

import openfl.events.Event;

/**
 * ...
 * @author Ohmnivore
 */
class MonsieurMoustacheAds
{
	#if NEVER
	private static var ads:FGLAds;
	
	static public function __init__():Void
	{
		ads = new FGLAds(stage, "FGL-20030008");
		ads.addEventListener(FGLAds.EVT_API_READY, showStartupAd);
	}

	static private function showStartupAd(e:Event):Void
	{
		ads.showAdPopup();
	}
	#end
}