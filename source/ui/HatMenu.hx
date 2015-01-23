package ui;

import ent.Hat;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import score.Score;
import score.ScoreBestText;

/**
 * ...
 * @author Ohmnivore
 */
class HatMenu extends FlxSubState
{
	private var hat:Hat;
	private var p:FlxSprite;
	private var name:UIText;
	private var cost:UIText;
	private var confirm:BtnMedium;
	private var hatIndex:Int = 0;
	
	private static var hatFiles:Array<String> = [
		"topHat",
		"wildWest",
		"tricorn",
		"revolutionary",
		"charlie",
		"disco",
		"criminal",
		"goldHat"
		];
	private static var hatNames:Array<String> = [
		"Gentleman's top hat",
		"Wild West",
		"Arr matey!",
		"People's hat",
		"Charlie's hat",
		"Bad taste",
		"Under the table authority",
		"Life achievement"
		];
	#if mobile
	private static var hatCosts:Array<Int> = [
		0,
		50,
		80,
		150,
		200,
		250,
		300,
		500
		];
	#else
	private static var hatCosts:Array<Int> = [
		0,
		50,
		100,
		200,
		400,
		800,
		1000,
		1200
		];
	#end
	
	public static function hasNewHat(OldS:Int, NewS:Int):Bool
	{
		var i:Int = 0;
		
		while (i < hatCosts.length)
		{
			if (OldS < hatCosts[i] && NewS >= hatCosts[i])
				return true;
			
			i++;
		}
		
		return false;
	}
	
	override public function create():Void 
	{
		super.create();
		
		Score.loadScore();
		add(new ScoreBestText());
		
		p = new FlxSprite();
		p.loadGraphic("images/kman4.png", true, 12, 24, true);
		p.animation.add("idle", [0, 1], 2, true);
		p.animation.play("idle");
		p.scrollFactor.set();
		p.width = 8;
		p.offset.x = 2;
		FlxSpriteUtil.screenCenter(p, true, true);
		add(p);
		
		var right:BtnRight = new BtnRight(FlxG.width - 19, 0, showNext);
		FlxSpriteUtil.screenCenter(right, false, true);
		add(right);
		
		var left:BtnLeft = new BtnLeft(1, 0, showPrevious);
		FlxSpriteUtil.screenCenter(left, false, true);
		add(left);
		
		displayHat(hatIndex);
		
		var back = new BtnBack(confirm.y + confirm.height * 2.0, close);
		add(back);
		
		Tween.tweenToRight(p);
		Tween.tweenToRight(right);
		Tween.tweenToLeft(left);
		Tween.tweenToRight(back);
	}
	
	private function displayHat(I:Int):Void
	{
		setHat(hatFiles[I]);
		setName(hatNames[I]);
		setCost(hatCosts[I]);
		setConfirm(hatCosts[I]);
	}
	private function setHat(Name:String):Void
	{
		if (hat != null)
		{
			remove(hat);
			hat.kill();
			hat.destroy();
		}
		
		hat = new Hat(Name, p);
		hat.scrollFactor.set();
		add(hat);
	}
	private function setName(Name:String):Void
	{
		if (name != null)
		{
			remove(name);
			name.kill();
			name.destroy();
		}
		
		name = new UIText(0, p.y - 24, Name);
		add(name);
		Tween.tweenToRight(name);
	}
	private function setCost(Cost:Int):Void
	{
		if (cost != null)
		{
			remove(cost);
			cost.kill();
			cost.destroy();
		}
		
		cost = new UIText(0, p.y - 14, "Highscore required: " + Cost + "m");
		add(cost);
		Tween.tweenToLeft(cost);
	}
	private function setConfirm(Cost:Int):Void
	{
		if (confirm != null)
		{
			remove(confirm);
			confirm.kill();
			confirm.destroy();
		}
		
		if (Cost <= Score.sBest)
		{
			confirm = new BtnMedium(p.y + p.height + 2, "Equip", equipHat);
			add(confirm);
			Tween.tweenToRight(confirm);
		}
	}
	
	private function equipHat():Void
	{
		FlxG.save.bind("Elasticate");
		FlxG.save.data.hat = hatFiles[hatIndex];
		
		FlxG.save.close();
		
		var notif:UIText = new UIText(0, FlxG.height / 2.0, "Hat equipped!");
		add(notif);
		Tween.tweenToBottom(notif);
		FlxTween.tween(notif, { alpha: 0.0 }, 4.0, { complete:
		function(T:FlxTween) { notif.kill(); notif.kill(); }
		} );
	}
	
	private function showNext():Void
	{
		hatIndex++;
		if (hatIndex >= hatNames.length)
		{
			hatIndex = 0;
		}
		
		displayHat(hatIndex);
	}
	private function showPrevious():Void
	{
		hatIndex--;
		if (hatIndex < 0)
		{
			hatIndex = hatNames.length - 1;
		}
		
		displayHat(hatIndex);
	}
	
	override public function close():Void 
	{
		Util.blip();
		
		var p:MenuState = cast _parentState;
		p.setHudVisible(true);
		
		super.close();
	}
}