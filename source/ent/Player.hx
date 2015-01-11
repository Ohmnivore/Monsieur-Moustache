package ent;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author Ohmnivore
 */
class Player extends FlxSprite
{
	public static var GRAV:Float = 400;
	public static var JUMPVEL:Float = 200;
	public static var XVEL:Float = 200;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		makeGraphic(16, 16, 0xffff0000, true);
		
		allowCollisions = FlxObject.DOWN;
		
		acceleration.y = GRAV;
		
		height = 4;
		offset.y = frameHeight - 4;
	}
	
	public function onCollide(M:FlxTilemap, P:Player):Void
	{
		velocity.x = 0;
	}
}