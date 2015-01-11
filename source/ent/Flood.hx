package ent;
import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author Ohmnivore
 */
class Flood extends FlxSprite
{
	public var maxDistance:Float = 80;
	public var speed:Float = 5;
	
	public function new() 
	{
		super( -8, Reg.state.p.y + FlxG.height / 2);
		
		makeGraphic(FlxG.width + 16, FlxG.height, 0x6600ff77, true);
	}
	
	override public function update():Void 
	{
		velocity.y = -speed;
		
		if (y - Reg.state.p.y > maxDistance)
			y = Reg.state.p.y + maxDistance;
		
		super.update();
		
		if (Reg.state.p.y > y)
			FlxG.switchState(new PlayState());
	}
}