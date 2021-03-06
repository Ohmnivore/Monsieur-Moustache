package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.system.scaleModes.RatioScaleMode;
import sfx.Music;
#if (flash && ADS)
import FGLAds;
#end
#if (android && ADS)
import admob.AD;
#end
#if android
import ru.zzzzzzerg.linden.GooglePlay;
import ru.zzzzzzerg.linden.play.*;
import score.Board;
#end

class Main extends Sprite 
{
	var gameWidth:Int = 160; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 240; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = MenuState; // The FlxState the game starts with.
	#if flash
	var zoom:Float = 2;
	#else
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	#end
	var framerate:Int = 48; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	
	// You can pretty much ignore everything from here on - your code should go in your states.
	
	public static function main():Void
	{	
		Lib.current.addChild(new Main());
	}
	
	public function new() 
	{
		super();
		
		if (stage != null) 
		{
			init();
		}
		else 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(?E:Event):Void 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		setupGame();
		#if !TRAILER
		Music.play();
		#end
		FlxG.scaleMode = new RatioScaleMode();
		
		#if (flash && ADS)
		var ads = new FGLAds(stage, "FGL-20030008");
		ads.addEventListener(FGLAds.EVT_API_READY,
		function (e:Event):Void 
		{
			ads.showAdPopup(); 
		});
		#end
		
		#if (android && ADS)
		{
			AD.init("ca-app-pub-3957994598949973/3248342041", AD.LEFT, AD.BOTTOM, AD.BANNER_LANDSCAPE, false); //false
			AD.show();
		}
		#end
		
		#if android
		var g:GooglePlay = new GooglePlay(new GooglePlayHandler(this));
		Reg.googleAvailable = g.isAvailable();
		
		if (Reg.googleAvailable)
		{
			if (MenuState.loadGPlay())
				g.games.connect();
			else
				if (g.games.isSignedIn())
					g.games.connect();
		}
		Reg.board = new Board(g);
		#end
	}
	
	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
	}
}

#if android
class GooglePlayHandler extends ConnectionHandler
{
  var _m : Main;

  public function new(m : Main)
  {
    super();
    _m = m;
  }

  override public function onWarning(msg : String, where : String)
  {
    trace(["Warning", msg, where]);
  }

  override public function onError(what : String, code : Int, where : String)
  {
    trace(["Error", what, code, where]);
  }

  override public function onException(msg : String, where : String)
  {
    trace(["Exception", msg, where]);
  }
}
#end