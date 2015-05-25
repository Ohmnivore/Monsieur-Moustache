package ent;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitterExt;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.util.FlxSpriteUtil;
import score.Score;
import sfx.Sound;
import social.Twitter;
import ui.GameOverMenu;
#if !web
import util.ArtifactFix;
#end
import ui.HatMenu;
import ui.UIText;
import flixel.tweens.FlxTween;
import ui.Tween;

/**
 * ...
 * @author Ohmnivore
 */
class Player extends FlxSprite
{
	public static var GRAV:Float = 400;
	//public static var JUMPVEL:Float = 200;
	public static var JUMPVEL:Float = 280;
	public static var XVEL:Float = 200;
	
	public static var FIST_COLOR:Int = 0xffFFD08A;
	public static var ARM_COLOR:Int = 0xff21302E;
	
	public var stretchDest:FlxPoint;
	public var stretch:Bool = false;
	public var stretchSpr:StretchSprite;
	public var stretchHack:Int = 0;
	
	private var touchBuffer:Bool = false;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		//loadGraphic("images/kman.png", true, 16, 16, true);
		//loadGraphic("images/kman3.png", true, 12, 24, true);
		#if web
		loadGraphic("images/kman4.png", true, 12, 24, true);
		#else
		loadGraphic(ArtifactFix.artefactFix("images/kman4.png", 12, 24), true, 12, 24, true);
		#end
		
		//animation.add("idle", [0, 1], 2, true);
		//animation.add("stretch", [8], 30, false);
		//animation.add("dead", [9], 30, false);
		animation.add("idle", [0, 1], 2, true);
		animation.add("stretch", [2], 30, false);
		animation.add("dead", [3], 30, false);
		animation.play("idle");
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		
		allowCollisions = FlxObject.DOWN;
		
		acceleration.y = GRAV;
		
		height = 8;
		offset.y = frameHeight - 8;
		width = 8;
		offset.x = 2;
		
		stretchDest = new FlxPoint();
		stretchSpr = new StretchSprite(this);
	}
	
	public function onJump():Void
	{
		if (!Reg.lowQual)
		{
			Reg.state.behindPlayer.add(new JumpDust(x + width / 2.0, y + height));
		}
		touchBuffer = false;
	}
	
	public function onCollide(M:FlxTilemap, P:Player):Void
	{
		if (alive)
		{
			velocity.x = 0;
			
			animation.play("idle");
		}
		
		if (!touchBuffer)
		{
			if (!Reg.lowQual)
			{
				Reg.state.behindPlayer.add(new JumpDust(x + width / 2.0, y + height));
			}
			touchBuffer = true;
		}
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
			stretchHack++;
			stretchSpr.start.copyFrom(mid);
			stretchSpr.end.x = stretchDest.x;
			stretchSpr.end.y = stretchDest.y;
		}
		else
		{
			animation.play("idle");
			
			stretchHack = 0;
		}
		
		if (stretch && stretchHack > 1)
			stretchSpr.alpha = 1.0;
		else
			stretchSpr.alpha = 0.0;
		
		if (!alive)
			onDeath();
		
		super.update();
	}
	
	public function onDeath():Void
	{
		if (alive)
		{
			FlxG.camera.shake(0.01, 0.3, recenterCam);
			
			Reg.state.add(new DeathEmitter(this));
			
			//Score.saveScore();
			
			if (Score.s > Score.sBest)
				Sound.playHighscore();
			else
				Sound.playDeath();
			
			Reg.state.hud.clear();
			Reg.state.openSubState(new GameOverMenu());
			y = Reg.state.flood.y + 7;
			
			if (HatMenu.hasNewHat(Score.sBest, Score.s))
			{
				var notif:UIText = new UIText(0, 20, "New hat unlocked!");
				Reg.state.hud.add(notif);
				Tween.tweenToTop(notif);
			}
		}
		
		alive = false;
		animation.play("dead", true);
		acceleration.y = 0;
		velocity.x = 0;
		velocity.y = -Reg.state.flood.speed;
		stretch = false;
	}
	
	private function recenterCam():Void
	{
		FlxG.camera.scroll.x = 0;
	}
}

class DeathEmitter extends FlxEmitter
{
	private var p:Player;
	
	public function new(P:Player)
	{
		super(P.x + P.width / 2, P.y - 8);
		p = P;
		
		makeParticles("images/particle.png", 5, 0, false, 0, false);
		
		//setMotion(60, 1, 5, 60, 1, 10);
		setAlpha(0.8, 1.0, 0.4, 0.6);
		//setColor(Player.ARM_COLOR, 0xff6AD622);
		setColor(Player.ARM_COLOR, 0xff6AD622);
		setYSpeed( -5, 1);
		setXSpeed( -20, 20);
		
		start(true, 1, 0.1, 0, 1);
		for (m in members)
		{
			m.velocity.y += p.velocity.y;
		}
	}
	
	override public function update():Void 
	{
		super.update();
	}
}

class StretchSprite extends FlxSprite
{
	public static var TRANSPARENT:Int = 0x00000000;
	
	public var p:Player;
	public var start:FlxPoint;
	public var end:FlxPoint;
	
	private var _start:FlxPoint;
	private var _end:FlxPoint;
	private var ARMSTYLE:LineStyle;
	private var FISTLINESTYLE:LineStyle;
	private var FISTSTYLE:FillStyle;
	private var DRAWSTYLE:DrawStyle;
	
	public function new(P:Player)
	{
		super(0, 0);
		p = P;
		makeGraphic(FlxG.width, FlxG.height, TRANSPARENT, true);
		
		start = new FlxPoint();
		end = new FlxPoint();
		_start = new FlxPoint();
		_end = new FlxPoint();
		
		ARMSTYLE = { thickness: 1, pixelHinting:false, color: Player.ARM_COLOR };
		FISTLINESTYLE = { thickness: 1, pixelHinting:false, color: Player.FIST_COLOR };
		FISTSTYLE = { hasFill:true, color: Player.FIST_COLOR };
		DRAWSTYLE = { smoothing: false };
	}
	
	override public function update():Void 
	{
		if (p.stretch)
		{
			resetFrame();
			
			drawArms();
			drawFists();
		}
		
		super.update();
	}
	
	private function resetFrame():Void
	{
		end.x /= 2.0;
		end.y /= 2.0;
		
		x = 0;
		y = 0;
		x = (start.x < start.x + end.x)? start.x - 8 : start.x + end.x - 8;
		y = (start.y < start.y + end.y)? start.y - 8 : start.y + end.y - 8;
		width = Math.abs(end.x) + 16;
		height = Math.abs(end.y) + 16;
		
		_start.x = start.x - x;
		_start.y = start.y - y;
		_end.x = _start.x + end.x;
		_end.y = _start.y + end.y;
		
		FlxSpriteUtil.fill(this, TRANSPARENT);
	}
	
	private function drawArms():Void
	{
		FlxSpriteUtil.drawLine(this, _start.x - p.width / 2 + 2, _start.y - 2,
			_end.x - 6, _end.y,
			ARMSTYLE, DRAWSTYLE);
		
		FlxSpriteUtil.drawLine(this, _start.x + p.width / 2 - 2, _start.y - 2,
			_end.x + 6, _end.y,
			ARMSTYLE, DRAWSTYLE);
	}
	private function drawFists():Void
	{
		FlxSpriteUtil.drawRect(this, _end.x - 6 - 1, _end.y - 1,
			2, 2,
			Player.FIST_COLOR, FISTLINESTYLE, FISTSTYLE, DRAWSTYLE);
		
		FlxSpriteUtil.drawRect(this, _end.x + 6 - 1, _end.y - 1,
			2, 2,
			Player.FIST_COLOR, FISTLINESTYLE, FISTSTYLE, DRAWSTYLE);
	}
}

class JumpDust extends FlxEmitter
{
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		
		makeParticles("images/particleSmall.png", 10, 0, false, 0.2, false);
		
		setColor(0xffC4C4C4, 0xffA3A3A3);
		setAlpha(0.5, 0.75, 0.0, 0.0);
		setXSpeed(-30, 30);
		setYSpeed(-12, 0);
		setRotation(0, 0);
		
		start(true, 0.5, 0.1, 0, 0.5);
	}
}