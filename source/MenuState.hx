package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
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
		var muteDescr:UIText = new UIText(mute.x + mute.width + 1, 3, "Mute", 8, 100);
		muteDescr.alignment = "left";
		hud.add(muteDescr);
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