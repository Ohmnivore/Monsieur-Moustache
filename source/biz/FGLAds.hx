package biz;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
	
/**
 * <p>The FGLAds object is used to show ads! It's very simple.</p> 
 * 
 * <ul>
 * <li> Copy <a href="http://flashgamedistribution.com/fglads/FGLAds.as">the FGLAds actionscript file</a> into your project. </li>
 * <li> Call the constructor and pass it the stage and your game ID. You can find your FGL Ads ID on the FGD or FGL website.</li>	  
 * <li> Add an event listener for the EVT_API_READY event. This fires when 
 * everything's ready to go. It should take less than a second.</li> 
 * <li> In the event handler, call FGLAds.api.showAdPopup(). By default, 
 * it will show a 300x250 ad popup in the center of the game. The user 
 * can close it after 3s.</li> 
 * </ul>
 * 
 * <p><b>Example:</b></p>
 * <p><code><pre>
 * function myInitFunction():void {
 *     FGLAds(stage, "FGL-EXAMPLE");
 *     FGLAds.api.addEventListener(EVT_API_READY, onAdsReady);
 * }
 * 
 * function onAdsReady(e:Event):void {
 *     FGLAds.api.showAdPopup();
 * }
 * </pre></code></p>
 * 
 * <p>That's it for now. We'll have more ad formats and more ways to load them soon!</p>
 * 
 */

 /**
 * ...
 * @author Ported to Haxe by Ohmnivore
 */
 
class FGLAds extends Sprite
{
	#if NEVER
	public static inline var version:String = "01";
	
	//singleton var
	static var _instance:FGLAds;
	
	//status vars
	private var _status:String = "Loading";
	private var _loaded:Bool = false;
	private var _stageWidth:Float = 550;
	private var _stageHeight:Float = 400;
	private var _inUse:Bool = false;
	
	//swf loading vars
	private var _referer:String = "";
	private var _loader:Loader = new Loader();
	private var _context:LoaderContext = new LoaderContext(true);
	private var _tmpSkin:Object = new Object();
	
	//live URL
	private var _clientURL:URLRequest = new URLRequest("http://ads.fgl.com/swf/FGLAds." + version + ".swf");
	
	//event handlers
	private var _evt_NetworkingError:Function = null;
	private var _evt_ApiReady:Function = null;
	private var _evt_AdLoaded:Function = null;
	private var _evt_AdShown:Function = null;
	private var _evt_AdClicked:Function = null;
	private var _evt_AdClosed:Function = null;
	private var _evt_AdUnavailable:Function = null;
	private var _evt_AdLoadingError:Function = null;
	
	//event types
	public static inline var EVT_NETWORKING_ERROR:String = "networking_error";
	public static inline var EVT_API_READY:String = "api_ready";
	public static inline var EVT_AD_LOADED:String = "ad_loaded";
	public static inline var EVT_AD_SHOWN:String = "ad_shown";
	public static inline var EVT_AD_CLOSED:String = "ad_closed";
	public static inline var EVT_AD_CLICKED:String = "ad_clicked";
	public static inline var EVT_AD_UNAVAILABLE:String = "ad_unavailable";
	public static inline var EVT_AD_LOADING_ERROR:String = "ad_loading_error";
	
	//ad formats
	public static inline var FORMAT_AUTO:String = "format_auto";
	public static inline var FORMAT_640x440:String = "640x440";
	public static inline var FORMAT_300x250:String = "300x250";
	public static inline var FORMAT_90x90:String = "90x90";
	
	//display objects
	private var _fglAds:Object;
	private var _stage:Stage;
	
	/**
	 * FGLAds constructor.<br />
	 * Important Note: You must only create one instance of the FGLAds object in your project.
	 * If you try to create a second instance, it will not initiate properly and a message will be
	 * logged to the output console (trace())
	 * 
	 * @param parent It is imperative that the parent object that you pass to the FGLAds constructor
	 * is either Sprite, MovieClip or Stage.
	 * @param gameID The game's ID, as issued on the FGL or FGD website.
	 * @param config reserved.
	 */
	
	public function FGLAds(parent:Dynamic, gameID:String, config:Object = null):Void
	{
		if(_instance == null) {
			_instance = this;
		} else {
			trace("FGLAds: Instance Error: The FGLAds class is a singleton and should only be constructed once. Use FGLAds.api to access it after it has been constructed.");
			return;
		}

		var m_override:URLRequest = checkConfig(config, 'swf_url', URLRequest);
		if(m_override != null) {
			trace("FGLAds: Overriding default SWF address");
			_clientURL = m_override;
		}
		
		_storedGameID = gameID;
		
		Security.allowDomain("*");
		Security.allowInsecureDomain("*");
		_context.applicationDomain = ApplicationDomain.currentDomain;
		
		//download client library
		_status = "Downloading";
		try {
			_loader.load(_clientURL, _context);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadingError);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadingComplete);
		} catch(e:Error) {
			_status = "Failed";
			trace("FGLAds: SecurityError: cannot load client library");
			_loader = null;
			dispatchEvent(new Event(EVT_NETWORKING_ERROR));
		}
		
		addEventListener(Event.ADDED_TO_STAGE, setupStage);
		if(Std.is(parent, Sprite) || Std.is(parent, MovieClip) || Std.is(parent, Stage))
		{
			parent.addChild(this);
		} else {
			trace("FGLAds: Incompatible parent! Parent must be a Sprite, MovieClip, or Stage");
		}				
	}
	
	/**
	 * The api variable allows you to access your instance of FGL Ads from anywhere in your code.<br />
	 * After constructing the FGLAds object, one of the easiest ways of accessing the API functionality
	 * is by using FGLAds.api.
	 * 
	 * You can access all of the functions that you need by using FGLAds.api, and because it
	 * is static, it can be accessed anywhere from within your code.
	 * 
	 * You MUST initiate one instance of the FGLAds class using the code provided from the website
	 * before trying to access this api variable. If the FGLAds object has not been initiated then
	 * this variable will return null.
	 */		
	public static function getApi():FGLAds	{
		if(_instance == null) {
			trace("FGLAds: Instance Error: Attempted to get instance before construction.");
			return null;
		}
		return _instance;
	}
	
	/**
	 * Displays an ad popup that appears over the current swf and lowers the lights.
	 * @param format the format of the ad to request, use one of the FORMAT_ constants.
	 * @param delay how long before they can close the ad
	 * @param timeout how long before the ad closes itself
	 */
	
	public function showAdPopup(format:String = FGLAds.FORMAT_AUTO, delay:Number = 3000, timeout:Number = 0):Void {
		if(_loaded == false) return;
		_fglAds.showAdPopup(format, delay, timeout);
	}
	
	/**
	 * The status variable allows you to determine the current
	 * status of the API. This can be any of the following:
	 * <ul>
	 * <li>Loading</li>
	 * <li>Downloading</li>
	 * <li>Ready</li>
	 * <li>Failed</li>
	 * </ul>
	 */
	public function getStatus():String {
		return _status;
	}		
	
	/**
	 * Returns true if the API has been initialised by the constructor. If this returns false, you need to
	 * call new FGLAds(stage) - passing the stage or root displayobject in. 
	 */
	public static function getApiLoaded():Bool {
		return _instance != null;
	}
	
	/**
	 * Disable the API. This will stop FGLAds from processing any requests. Use enable() to re-enable the API.
	 */
	public function disable():Void {
		if(_status == "Ready"){
			_status = "Disabled";
			_loaded = false;
		}
	}		
	
	/**
	 * Re-enables the API if it's been disabled using the disable() function.
	 */
	public function enable():Void {
		if(_status == "Disabled"){
			_status = "Ready";
			_loaded = true;
		}
	}
	
	/**
	 * setStyle should be used to set the global theme settings. The acceptable values for <b>name</b> are:
	 * <ul>
	 * 	<li>backgroundColor</li>
	 * 	<li>backgroundAlpha</li>
	 * 	<li>borderColor</li>
	 *	<li>borderWidth</li>
	 * 	<li>cornerRadius</li>
	 * 	<li>foregroundColor</li>
	 * 	<li>foregroundAlpha</li>
	 * 	<li>middlegroundColor</li>
	 * 	<li>middlegroundAlpha</li>
	 *  <li>dropShadowColor</li>
	 *  <li>dropShadowAlpha</li>
	 * 	<li>fadeColor</li>
	 *  <li>fadeAlpha</li>
	 * </ul> 
	 */
	
	public function setStyle(name:String, value:Dynamic):Void {
		if(_loaded == false){
			_tmpSkin[name] = value;
			return;
		}
		var o:Object = new Object();
		o[name] = value;
		_fglAds.setSkin(o);
	}
	
	// Event handling...
	public var onNetworkingError(get, set):Int;
	/** @private */ public function set_onNetworkingError(func:Function):Void { _evt_NetworkingError = func; }
	/** @private */ public function get_onNetworkingError():Function {return _evt_NetworkingError;}
	private function e_onNetworkingError(e:Event):Void {
		if(_evt_NetworkingError != null) _evt_NetworkingError();
		dispatchEvent(e);
	}
	
	/** @private */ public function set onApiReady(func:Function):void { _evt_ApiReady = func; }
	/** @private */ public function get onApiReady():Function {return _evt_ApiReady;}
	private function e_onApiReady(e:Event):Void {
		if(_evt_ApiReady != null) _evt_ApiReady();
		dispatchEvent(e);
	}
	
	/** @private */ public function set onAdLoaded(func:Function):void { _evt_AdLoaded = func; }
	/** @private */ public function get onAdLoaded():Function {return _evt_AdLoaded;}
	private function e_onAdLoaded(e:Event):Void {
		if(_evt_AdLoaded != null) _evt_AdLoaded();
		dispatchEvent(e);
	}
	/** @private */ public function set onAdShown(func:Function):void { _evt_AdShown = func; }
	/** @private */ public function get onAdShown():Function {return _evt_AdShown;}
	private function e_onAdShown(e:Event):Void {
		if(_evt_AdShown != null) _evt_AdShown();
		dispatchEvent(e);
	}
	/** @private */ public function set onAdClicked(func:Function):void { _evt_AdClicked = func; }
	/** @private */ public function get onAdClicked():Function {return _evt_AdClicked;}
	private function e_onAdClicked(e:Event):Void {
		if(_evt_AdClicked != null) _evt_AdClicked();
		dispatchEvent(e);
	}
	/** @private */ public function set onAdClosed(func:Function):void { _evt_AdClosed = func; }
	/** @private */ public function get onAdClosed():Function {return _evt_AdClosed;}
	private function e_onAdClosed(e:Event):Void {
		if(_evt_AdClosed != null) _evt_AdClosed();
		dispatchEvent(e);
	}
	/** @private */ public function set onAdUnavailable(func:Function):void { _evt_AdUnavailable = func; }
	/** @private */ public function get onAdUnavailable():Function {return _evt_AdUnavailable;}
	private function e_onAdUnavailable(e:Event):Void {
		if(_evt_AdUnavailable != null) _evt_AdUnavailable();
		dispatchEvent(e);
	}
	
	/** @private */ public function set onAdLoadingError(func:Function):void { _evt_AdLoadingError = func; }
	/** @private */ public function get onAdLoadingError():Function {return _evt_AdLoadingError;}
	private function e_onAdLoadingError(e:Event):Void {
		if(_evt_AdLoadingError != null) _evt_AdLoadingError();
		dispatchEvent(e);
	}
	
	
	/* Internal Functions */
	private function checkConfig(config:Object, name:String, type:Class):* {
		if(config && config.hasOwnProperty(name)){
			try {
				return new type(config[name]);
			} catch(e:Error) {
				trace("FGLAds: couldn't process "+ name +" configuration parameter: " + e.message);
			}
		}		
	}		
	
	private function resizeStage(e:Event):Void {
		if(_loaded == false) return;
		_stageWidth = _stage.stageWidth;
		_stageHeight = _stage.stageHeight;
		_fglAds.componentWidth = _stageWidth;
		_fglAds.componentHeight = _stageHeight;
	}
	
	private function setupStage(e:Event):Void {
		if(stage == null) return;
		_stage = stage;
		_stage.addEventListener(Event.RESIZE, resizeStage);
		_stageWidth = stage.stageWidth;
		_stageHeight = stage.stageHeight;
		if(root != null) {
			_referer = root.loaderInfo.loaderURL;
		}
		if(_loaded){
			_fglAds.componentWidth = _stageWidth;
			_fglAds.componentHeight = _stageHeight;
			_stage.addChild(_fglAds as Sprite);
		}
	}
	
	private function onLoadingComplete(e:Event):Void {
		_status = "Ready";
		_loaded = true;
		_fglAds = _loader.content as Object;
		_fglAds.componentWidth = _stageWidth;
		_fglAds.componentHeight = _stageHeight;
		_fglAds.setSkin(_tmpSkin);
		
		_fglAds.addEventListener(EVT_NETWORKING_ERROR, e_onNetworkingError);
		_fglAds.addEventListener(EVT_API_READY, e_onApiReady);
		_fglAds.addEventListener(EVT_AD_LOADED, e_onAdLoaded);
		_fglAds.addEventListener(EVT_AD_SHOWN, e_onAdShown);
		_fglAds.addEventListener(EVT_AD_CLICKED, e_onAdClicked);
		_fglAds.addEventListener(EVT_AD_CLOSED, e_onAdClosed);
		_fglAds.addEventListener(EVT_AD_UNAVAILABLE, e_onAdUnavailable);			
		_fglAds.addEventListener(EVT_AD_LOADING_ERROR, e_onAdLoadingError);
		
		if(_stage != null){
			_stage.addChild(_fglAds as Sprite);
		}
		
		if(root != null){
			_referer = root.loaderInfo.loaderURL
		}
		
		_fglAds.init(_stage, _referer, _storedGameID);
	}
	
	private function onLoadingError(e:IOErrorEvent):Void {
		_loaded = false;
		_status = "Failed";
		trace("FGLAds: Failed to load client SWF: " + e.toString());			
		dispatchEvent(new Event(EVT_NETWORKING_ERROR));
	}
	
	private var _storedGameID:String = "";
	#end
}