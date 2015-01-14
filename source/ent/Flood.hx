package ent;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Ohmnivore
 */
class Flood extends FlxSpriteGroup
{
	public var maxDistance:Float = 80;
	public var speed:Float = 5;
	public var firstJump:Bool = true;
	
	private var frameHolder:FlxSprite;
	private var frameZero:FlxSprite;
	private var frameOne:FlxSprite;
	private var frameTwo:FlxSprite;
	
	private var frameId:Int = 0;
	private var elapsed:Float = 0;
	
	public function new() 
	{
		super(-32, Reg.state.p.y + FlxG.height / 2);
		
		createFrames();
		createFrameHolder();
		
		stampFrames("frame0", frameZero);
		stampFrames("frame1", frameOne);
		stampFrames("frame2", frameTwo);
	}
	
	private function createFrames():Void
	{
		frameZero = new FlxSprite();
		add(frameZero);
		
		frameOne = new FlxSprite();
		add(frameOne);
		
		frameTwo = new FlxSprite();
		add(frameTwo);
		
		frameOne.visible = false;
		frameTwo.visible = false;
	}
	
	private function createFrameHolder():Void
	{
		frameHolder = new FlxSprite();
		frameHolder.loadGraphic("images/flood.png", true, 16, 32, true);
		frameHolder.animation.add("frame0", [0], 30, false);
		frameHolder.animation.add("frame1", [1], 30, false);
		frameHolder.animation.add("frame2", [2], 30, false);
	}
	
	private function stampFrames(Frame:String, Spr:FlxSprite)
	{
		frameHolder.animation.play(Frame, true);
		frameHolder.update();
		
		Spr.makeGraphic(FlxG.width + 64, FlxG.height, 0xff20302E, true);
		Spr.alpha = 0.6;
		
		var iX:Int = 0;
		while (iX < width)
		{
			Spr.stamp(frameHolder, iX, 0);
			
			if (frameHolder.animation.name == "frame0")
				frameHolder.animation.play("frame1", true);
			else if (frameHolder.animation.name == "frame1")
				frameHolder.animation.play("frame2", true);
			else if (frameHolder.animation.name == "frame2")
				frameHolder.animation.play("frame0", true);
			
			frameHolder.update();
			
			iX += 16;
		}
	}
	
	override public function update():Void 
	{
		if (firstJump)
			velocity.y = -7;
		else
			velocity.y = -speed;
		
		if (y - Reg.state.p.y > maxDistance)
			y = Reg.state.p.y + maxDistance;
		
		super.update();
		
		if (Reg.state.p.y > y + 8)
		{
			Reg.state.p.onDeath();
			
			new FlxTimer(2.0, function(T:FlxTimer) { FlxG.switchState(new PlayState()); } );
		}
		
		//Animation
		elapsed += FlxG.elapsed;
		if (elapsed > 1.0 / 6.0)
		{
			frameId++;
			if (frameId > 2)
				frameId = 0;
			
			frameZero.visible = false;
			frameOne.visible = false;
			frameTwo.visible = false;
			
			if (frameId == 0)
				frameZero.visible = true;
			if (frameId == 1)
				frameOne.visible = true;
			if (frameId == 2)
				frameTwo.visible = true;
			
			elapsed = 0;
		}
	}
}