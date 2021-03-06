extern class FGLAds extends flash.display.Sprite implements Dynamic {
	var onAdClicked : Dynamic;
	var onAdClosed : Dynamic;
	var onAdLoaded : Dynamic;
	var onAdLoadingError : Dynamic;
	var onAdShown : Dynamic;
	var onAdUnavailable : Dynamic;
	var onApiReady : Dynamic;
	var onNetworkingError : Dynamic;
	var status(default,never) : String;
	function new(p1 : Dynamic, p2 : String, ?p3 : Dynamic) : Void;
	function disable() : Void;
	function enable() : Void;
	function setStyle(p1 : String, p2 : Dynamic) : Void;
	function showAdPopup(?p1 : String, p2 : Float = 3000, p3 : Float = 0) : Void;
	static var EVT_AD_CLICKED : String;
	static var EVT_AD_CLOSED : String;
	static var EVT_AD_LOADED : String;
	static var EVT_AD_LOADING_ERROR : String;
	static var EVT_AD_SHOWN : String;
	static var EVT_AD_UNAVAILABLE : String;
	static var EVT_API_READY : String;
	static var EVT_NETWORKING_ERROR : String;
	static var FORMAT_300x250 : String;
	static var FORMAT_640x440 : String;
	static var FORMAT_90x90 : String;
	static var FORMAT_AUTO : String;
	static var api(default,never) : FGLAds;
	static var apiLoaded(default,never) : Bool;
	static var version : String;
}
