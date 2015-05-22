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
	private var _elapsed:Float = 0;
	
	public function new() 
	{
		super(-24, Reg.state.p.y + FlxG.height / 2);
		
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
		frameHolder.update(_elapsed);
		
		Spr.makeGraphic(FlxG.width + 48, FlxG.height, 0xff4B8473, true);
		Spr.alpha = 0.7;
		
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
			
			frameHolder.update(_elapsed);
			
			iX += 16;
		}
	}
	
	override public function draw():Void 
	{
		//if (y - Reg.state.p.y > maxDistance)
			//y = Reg.state.p.y + maxDistance;
		
		super.draw();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (firstJump)
			velocity.y = -2 * elapsed * 48;
		else
			velocity.y = -speed * elapsed * 48;
		
		if (y - Reg.state.p.y > maxDistance)
		{
			y = Math.ceil(Reg.state.p.y) + maxDistance;
			velocity.y = 0;
		}
		
		super.update(elapsed);
		
		if (Reg.state.p.y > y + 8)
		{
			firstJump = false;
			velocity.y = -speed * elapsed * 48;
			
			Reg.state.p.onDeath();
		}
		
		//Animation
		_elapsed += FlxG.elapsed;
		if (_elapsed > 1.0 / 6.0)
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
			
			_elapsed = 0;
		}
	}
}