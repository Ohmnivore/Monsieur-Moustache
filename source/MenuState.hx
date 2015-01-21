package;

import biz.SiteLock;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import inp.DragNRelease;
import social.Facebook;
import ui.*;
#if (android && ADS)
import admob.AD;
#end

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends PlayState
{
	private var sponsor:BtnBig;
	private var play:BtnPlay;
	private var credits:BtnWeb;
	private var customize:BtnCustomize;
	private var title:Title;
	private var mute:BtnToggle;
	private var muteDescr:UIText;
	#if desktop
	private var fScreen:BtnToggle;
	private var fScreenDescr:UIText;
	#else
	private var lowQual:BtnToggle;
	private var lowQualDescr:UIText;
	#end
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		#if !mobile
		FlxG.mouse.load("images/uiCursor.png", 2, 5);
		#end
		FlxG.scaleMode = new RatioScaleMode();
		
		p.visible = false;
		p.stretchSpr.visible = false;
		hat.visible = false;
		
		hud.clear();
		
		#if flash
		if (SiteLock.shouldLock())
			doLock();
		else
			addBtns();
		#else
		addBtns();
		#end
		
		#if (android && ADS)
		AD.init("ca-app-pub-2673912333923494/3481995165", AD.LEFT, AD.BOTTOM, AD.BANNER_LANDSCAPE, false); //false
		AD.show();
		#end
	}
	
	private function doLock():Void
	{
		var warning:UIText = new UIText(0, FlxG.height / 6.0, "Please play the game on the", 8, 0);
		var warning2:UIText = new UIText(0, FlxG.height / 6.0 + 9, "publisher's official website, here:", 8, 0);
		
		var redirect:BtnMedium = new BtnMedium(0, "Visit", SiteLock.takeToSite);
		redirect.y = warning2.y + warning2.height + 1;
		
		hud.add(warning);
		hud.add(warning2);
		hud.add(redirect);
		
		Tween.tweenToRight(warning);
		Tween.tweenToRight(warning2);
		Tween.tweenToLeft(redirect);
	}
	
	private function addBtns():Void
	{
		sponsor = new BtnBig(FlxG.height / 6.0 - 12, "Sponsor", showSponsor);
		//play = new BtnPlay(FlxG.height / 6.0, launch);
		//credits = new BtnWeb(FlxG.height / 6.0 + 42.0, showCredits);
		//customize = new BtnCustomize(FlxG.height / 6.0 + 68.0, showCustomize);
		//title = new Title(FlxG.height / 6.0 + 84.0 + 24);
		
		play = new BtnPlay(FlxG.height / 6.0 + 30.0, launch);
		credits = new BtnWeb(FlxG.height / 6.0 + 72.0, showCredits);
		customize = new BtnCustomize(FlxG.height / 6.0 + 98.0, showCustomize);
		title = new Title(FlxG.height / 6.0 + 102.0 + 24);
		
		hud.add(sponsor);
		hud.add(play);
		hud.add(credits);
		hud.add(customize);
		hud.add(title);
		
		mute = new BtnToggle(1, 1, doMute);
		mute.pressed = loadMute();
		hud.add(mute);
		hud.add(mute.click);
		muteDescr = new UIText(mute.x + mute.width, 3, "Mute", 8, 100);
		muteDescr.alignment = "left";
		hud.add(muteDescr);
		
		#if desktop
		fScreen = new BtnToggle(FlxG.width - 19, 1, doFullScreen);
		fScreen.pressed = loadFullScreen();
		hud.add(fScreen);
		hud.add(fScreen.click);
		fScreenDescr = new UIText(fScreen.x - 54, 3, "Fullscreen", 8, 100);
		fScreenDescr.alignment = "left";
		hud.add(fScreenDescr);
		#else
		lowQual = new BtnToggle(FlxG.width - 19, 1, doQual);
		lowQual.pressed = loadQual();
		hud.add(lowQual);
		hud.add(lowQual.click);
		lowQualDescr = new UIText(lowQual.x - 69, 3, "Fast graphics", 8, 100);
		lowQualDescr.alignment = "left";
		hud.add(lowQualDescr);
		#end
		
		tweenBtns();
	}
	
	private function tweenBtns():Void
	{
		Tween.tweenToLeft(mute);
		Tween.tweenToLeft(muteDescr);
		#if desktop
		Tween.tweenToRight(fScreen);
		Tween.tweenToRight(fScreenDescr);
		#else
		Tween.tweenToRight(lowQual);
		Tween.tweenToRight(lowQualDescr);
		#end
		Tween.tweenToRight(sponsor);
		Tween.tweenToLeft(play);
		Tween.tweenToRight(credits);
		Tween.tweenToLeft(customize);
		Tween.tweenToRight(title);
	}
	
	private function doMute(Mute:Bool):Void
	{
		FlxG.sound.muted = Mute;
		
		FlxG.save.bind("Elasticate");
		FlxG.save.data.mute = Mute;
		FlxG.save.close();
	}
	private function loadMute():Bool
	{
		FlxG.save.bind("Elasticate");
		if (FlxG.save.data.mute == null)
		{
			FlxG.sound.muted = false;
			
			return false;
		}
		else
		{
			if (FlxG.save.data.mute == true)
			{
				FlxG.sound.muted = true;
				
				return true;
			}
		}
		FlxG.save.close();
		
		return false;
	}
	#if desktop
	private function doFullScreen(Full:Bool):Void
	{
		FlxG.fullscreen = Full;
		
		FlxG.save.bind("Elasticate");
		FlxG.save.data.fscreen = Full;
		FlxG.save.close();
	}
	private function loadFullScreen():Bool
	{
		FlxG.save.bind("Elasticate");
		if (FlxG.save.data.fscreen == null)
		{
			FlxG.fullscreen = false;
			
			return false;
		}
		else
		{
			if (FlxG.save.data.fscreen == true)
			{
				FlxG.fullscreen = true;
				
				return true;
			}
		}
		FlxG.save.close();
		
		return false;
	}
	#else
	private function doQual(LowQual:Bool):Void
	{
		Reg.lowQual = LowQual;
		
		FlxG.save.bind("Elasticate");
		FlxG.save.data.lowqual = LowQual;
		FlxG.save.close();
	}
	private function loadQual():Bool
	{
		FlxG.save.bind("Elasticate");
		if (FlxG.save.data.lowqual == null)
		{
			Reg.lowQual = false;
			
			return false;
		}
		else
		{
			if (FlxG.save.data.lowqual == true)
			{
				Reg.lowQual = true;
				
				return true;
			}
		}
		FlxG.save.close();
		
		return false;
	}
	#end
	
	private function launch():Void
	{
		FlxG.switchState(new PlayState());
	}
	private function showCredits():Void
	{
		Util.blip();
		
		setHudVisible(false);
		openSubState(new CreditsMenu());
	}
	private function showCustomize():Void
	{
		Util.blip();
		
		setHudVisible(false);
		openSubState(new HatMenu());
	}
	private function showSponsor():Void
	{
		Util.blip();
		
		FlxG.openURL("http://sponsor_for_monsieur_moustache.com/");
	}
	public function setHudVisible(Visible:Bool):Void
	{
		hud.visible = Visible;
		hud.active = Visible;
		
		if (Visible)
			tweenBtns();
	}
	
	override public function update():Void 
	{
		p.velocity.y = -30;
		
		super.update();
	}
	
	override function onPressed(D:DragNRelease):Void 
	{
		
	}
	override function onReleased(D:DragNRelease):Void 
	{
		
	}
}