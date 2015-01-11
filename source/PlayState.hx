package;

import ent.Flood;
import ent.Player;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxVector;
import gen.GenTilemap;
import gen.Platform;
import inp.DragNRelease;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var p:Player;
	public var cMap:GenTilemap;
	public var drag:DragNRelease;
	public var canJump:Bool = false;
	public var flood:Flood;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		Reg.state = this;
		
		cMap = new GenTilemap(0);
		add(cMap);
		
		FlxG.camera.bgColor = 0x44220022;
		FlxG.camera.scroll.x = 0;
		
		p = new Player(cMap.first.x - 4, cMap.first.y - 32);
		add(p);
		
		drag = new DragNRelease(null, onReleased);
		
		flood = new Flood();
		add(flood);
	}
	
	private function onReleased(D:DragNRelease):Void
	{
		if (canJump)
		{
			var v:FlxVector = new FlxVector();
			v.x = D.endPoint.x - D.startPoint.x;
			v.y = D.startPoint.y - D.endPoint.y;
			
			if (v.length > 40.0)
			{
				v = v.normalize();
				v = v.scale(40.0);
			}
			
			if (p.velocity.y < 0)
				p.velocity.y += v.y * Player.JUMPVEL / 40.0;
			else
				p.velocity.y = v.y * Player.JUMPVEL / 40.0;
			p.velocity.x = -v.x * Player.XVEL / 40.0;
		}
	}
	
	private function onOverlap(M:FlxTilemap, P:Player):Void
	{
		canJump = true;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		canJump = false;
		if (p.overlaps(cMap, true))
		{
			canJump = true;
		}
		FlxG.collide(cMap, p, p.onCollide);
		
		drag.update();
		
		super.update();
		
		if (FlxG.keys.pressed.W)
			FlxG.camera.scroll.y -= 4;
		
		//FlxG.camera.scroll.y -= (p.y - FlxG.camera.scroll.y + FlxG.height / 2) * 0.5;
		FlxG.camera.scroll.y = p.y - FlxG.height / 1.5;
	}	
}