package ent;

import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author Ohmnivore
 */
class Hat extends FlxSprite
{
	private var p:FlxSprite;
	
	public function new(Name:String, P:FlxSprite = null) 
	{
		super(0, 0, "images/hats/" + Name + ".png");
		p = P;
		
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (p != null)
			followPlayer();
		
		super.update(elapsed);
	}
	
	private function followPlayer():Void
	{
		x = p.x - 4.0;
		y = p.y - p.offset.y;
		
		facing = p.facing;
		
		if (p.animation.curAnim != null)
		{
			if (p.animation.curAnim.name == "idle" && p.animation.curAnim.curFrame == 1)
				y += 1.0;
		}
		if (Std.is(p, Player))
		{
			if (Reflect.field(p, "stretch") == true)
				y += 3.0;
		}
	}
}