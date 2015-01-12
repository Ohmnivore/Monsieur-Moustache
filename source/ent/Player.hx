package ent;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Ohmnivore
 */
class Player extends FlxSprite
{
	public static var GRAV:Float = 400;
	public static var JUMPVEL:Float = 200;
	public static var XVEL:Float = 200;
	
	public static var ARM_COLOR:Int = 0xffFFD08A;
	
	public var stretchDest:FlxPoint;
	public var stretch:Bool = false;
	public var stretchSpr:StretchSprite;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		loadGraphic("images/kman.png", true, 16, 16, true);
		
		animation.add("idle", [0, 1], 2, true);
		animation.add("stretch", [8], 30, false);
		animation.play("idle");
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		
		allowCollisions = FlxObject.DOWN;
		
		acceleration.y = GRAV;
		
		height = 8;
		offset.y = frameHeight - 8;
		width = 8;
		offset.x = frameHeight - 12;
		
		stretchDest = new FlxPoint();
		stretchSpr = new StretchSprite(this);
	}
	
	public function onCollide(M:FlxTilemap, P:Player):Void
	{
		velocity.x = 0;
		
		animation.play("idle");
	}
	
	override public function update():Void 
	{
		if (velocity.x > 0)
			facing = FlxObject.RIGHT;
		if (velocity.x < 0)
			facing = FlxObject.LEFT;
		
		if (stretch)
		{
			animation.play("stretch", true);
			
			var mid:FlxPoint = getMidpoint();
			stretchSpr.start.copyFrom(mid);
			stretchSpr.end.x = stretchDest.x;
			stretchSpr.end.y = stretchDest.y;
		}
		else
		{
			animation.play("idle");
		}
		
		super.update();
	}
}

class StretchSprite extends FlxSprite
{
	public static var TRANSPARENT:Int = 0x00000000;
	
	public var p:Player;
	public var start:FlxPoint;
	public var end:FlxPoint;
	
	private var ARMSTYLE:LineStyle;
	private var FISTSTYLE:FillStyle;
	private var DRAWSTYLE:DrawStyle;
	private var hack:Float = 0;
	
	public function new(P:Player)
	{
		super(0, 0);
		p = P;
		makeGraphic(FlxG.width, FlxG.height, TRANSPARENT, true);
		scrollFactor.set();
		
		start = new FlxPoint();
		end = new FlxPoint();
		
		ARMSTYLE = { thickness: 1, pixelHinting:false, color: Player.ARM_COLOR };
		FISTSTYLE = { hasFill:true, color: Player.ARM_COLOR };
		DRAWSTYLE = { smoothing: false };
	}
	
	override public function update():Void 
	{
		if (p.stretch)
		{
			alpha = 1.0;
			
			resetFrame();
			start.y -= FlxG.camera.scroll.y;
			if (p.facing == FlxObject.RIGHT)
				hack = -1;
			else
				hack = 0;
			end.x /= 2;
			end.y /= 2;
			
			drawArms();
			drawFists();
			
			//setFrame();
		}
		else
		{
			alpha = 0;
		}
		
		super.update();
	}
	
	private function resetFrame():Void
	{
		x = 0;
		y = 0;
		width = FlxG.width;
		height = FlxG.height;
		
		FlxSpriteUtil.fill(this, TRANSPARENT);
	}
	
	private function drawArms():Void
	{
		FlxSpriteUtil.drawLine(this, start.x - p.width / 2 + 2 + hack, start.y - 2,
			start.x + end.x - 6, start.y + end.y,
			ARMSTYLE, DRAWSTYLE);
		
		FlxSpriteUtil.drawLine(this, start.x + p.width / 2 - 2 + hack, start.y - 2,
			start.x + end.x + 6, start.y + end.y,
			ARMSTYLE, DRAWSTYLE);
	}
	private function drawFists():Void
	{
		FlxSpriteUtil.drawRect(this, start.x + end.x - 6 - 1, start.y + end.y - 1,
			2, 2,
			Player.ARM_COLOR, ARMSTYLE, FISTSTYLE, DRAWSTYLE);
		
		FlxSpriteUtil.drawRect(this, start.x + end.x + 6 - 1, start.y + end.y - 1,
			2, 2,
			Player.ARM_COLOR, ARMSTYLE, FISTSTYLE, DRAWSTYLE);
	}
}