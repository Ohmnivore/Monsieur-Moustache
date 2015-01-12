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
import gen.Background;
import gen.Blizzard;
import gen.GenTilemap;
import gen.Platform;
import inp.DragNRelease;
import flixel.group.FlxTypedGroup;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var p:Player;
	public var cMap:FlxTypedGroup<GenTilemap>;
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
		
		cMap = new FlxTypedGroup();
		add(cMap);
		var firstMap:GenTilemap = new GenTilemap(0);
		cMap.add(firstMap);
		
		FlxG.camera.bgColor = Background.getRandColor();
		FlxG.camera.scroll.x = 0;
		
		p = new Player(firstMap.first.x - 4, firstMap.first.y - 32);
		add(p);
		add(p.stretchSpr);
		
		drag = new DragNRelease(onPressed, onReleased);
		
		flood = new Flood();
		add(new Blizzard(FlxG.width, FlxG.height, p, flood));
		add(flood);
	}
	
	private function onPressed(D:DragNRelease):Void
	{
		
	}
	
	private function onReleased(D:DragNRelease):Void
	{
		if (canJump)
		{
			if (p.velocity.y < 0)
				p.velocity.y -= D.delta.y * Player.JUMPVEL / 40.0;
			else
				p.velocity.y = -D.delta.y * Player.JUMPVEL / 40.0;
			p.velocity.x = -D.delta.x * Player.XVEL / 40.0;
		}
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
		
		//drag.update();
		//super.update();
		
		if (FlxG.keys.pressed.W)
		{
			p.acceleration.y = 0;
			p.velocity.y -= 5;
		}
		if (FlxG.keys.pressed.S)
		{
			p.acceleration.y = Player.GRAV;
			p.velocity.y = 0;
		}
		
		var highest:GenTilemap = cMap.getFirstExisting();
		for (map in cMap.members)
		{
			if (p.y + FlxG.height / 2 < map.y)
			{
				remove(map, true);
				map.kill();
				map.destroy();
				map = null;
			}
			
			if (map != null)
			{
				updateMap(map);
				
				if (map.y < highest.y)
					highest = map;
			}
		}
		if (highest != null)
		{
			if (p.y - FlxG.height / 2 <= highest.y)
			{
				cMap.add(new GenTilemap(highest.y - FlxG.height * 2));
			}
		}
		FlxG.camera.scroll.y += (p.y - (FlxG.camera.scroll.y + FlxG.height * 0.6)) * 0.04;
		
		drag.update();
		if (drag.pressed)
		{
			p.stretch = true;
			p.stretchDest.x = drag.delta.x;
			p.stretchDest.y = drag.delta.y;
		}
		else
		{
			p.stretch = false;
		}
		
		super.update();
	}
	
	private function updateMap(M:GenTilemap):Void
	{
		if (p.overlaps(M, true))
		{
			canJump = true;
		}
		if (FlxG.collide(M, p, p.onCollide))
		{
			canJump = true;
		}
	}
}