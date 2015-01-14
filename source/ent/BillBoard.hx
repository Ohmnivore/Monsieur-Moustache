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
		text.color = 0xff000000;
		add(text);
	}
	
	static public function initPhrases():Void
	{
		phrases = [];
		
		phrases.push("TOILET CLOGGED AGAIN, EVACUATE THE LAB IMMEDIATELY!");
		phrases.push("WHOOPS WE FORGOT ABOUT THE TEST SUBJECTS (AGAIN)");
		phrases.push("IT WASN'T MY FAULT I SWEAR");
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