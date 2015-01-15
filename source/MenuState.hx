package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import inp.DragNRelease;
import ui.*;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends PlayState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.load("images/uiCursor.png", 2, 5);
		FlxG.scaleMode = new RatioScaleMode();
		
		p.visible = false;
		p.stretchSpr.visible = false;
		
		hud.clear();
		
		var play:BtnPlay = new BtnPlay(FlxG.height / 6.0, launch);
		var credits:BtnWeb = new BtnWeb(FlxG.height / 6.0 + 42.0, showCredits);
		var title:Title = new Title(FlxG.height / 6.0 + 42.0 + 52);
		
		Tween.tweenToRight(play);
		Tween.tweenToLeft(credits);
		Tween.tweenToRight(title);
		
		hud.add(play);
		hud.add(credits);
		hud.add(title);
		
		var mute:BtnToggle = new BtnToggle(1, 1, doMute);
		mute.pressed = loadMute();
		hud.add(mute);
		hud.add(mute.click);
		var muteDescr:UIText = new UIText(mute.x + mute.width, 3, "Mute", 8, 100);
		muteDescr.alignment = "left";
		hud.add(muteDescr);
		
		#if desktop
		var fScreen:BtnToggle = new BtnToggle(FlxG.width - 19, 1, doFullScreen);
		fScreen.pressed = loadFullScreen();
		hud.add(fScreen);
		hud.add(fScreen.click);
		var fScreenDescr:UIText = new UIText(fScreen.x - 54, 3, "Fullscreen", 8, 100);
		fScreenDescr.alignment = "left";
		hud.add(fScreenDescr);
		#end
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
	public function setHudVisible(Visible:Bool):Void
	{
		hud.visible = Visible;
		hud.active = Visible;
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