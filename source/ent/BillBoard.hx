package ent;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class BillBoard extends FlxSpriteGroup
{
	static private var phrases:Array<String>;
	
	private var back:FlxSprite;
	private var text:FlxText;
	
	public function new(Y:Float) 
	{
		super(0, Y);
		
		back = new FlxSprite(0, 0, "images/screen.png");
		back.x = (FlxG.width - back.width) / 2;
		add(back);
		
		var tOffset:Float = 8;
		text = new FlxText(back.x + tOffset, tOffset, back.width - 2 * tOffset,
			getPhrase());
		text.color = 0xffffffff;
		//text.alignment = "center";
		add(text);
	}
	
	static public function initPhrases():Void
	{
		phrases = [];
		
		phrases.push("Toilet clogged again, please evacuate the lab (NOW)!");
		phrases.push("Whoops... we forgot about the test subjects (AGAIN).");
		phrases.push("You know we're all going to be fired for this, right?");
		phrases.push("Management will not be pleased...");
		phrases.push("We can't destroy the place every three weeks, this has to stop!");
		phrases.push("Did any of you check the plumber's permit? Yesh, that's what I thought!");
	}
	
	static public function doDisplay():Bool
	{
		if (phrases.length > 0 && FlxRandom.chanceRoll(20))
			return true;
		
		return false;
	}
	
	private function getPhrase():String
	{
		var i:Int = FlxRandom.intRanged(0, phrases.length - 1);
		var ret:String = phrases[i];
		phrases.splice(i, 1);
		
		return ret;
	}
}