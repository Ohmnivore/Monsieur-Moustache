package ent;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Scientist extends FlxSprite
{
	private var isFlying:Bool = false;
	private var emitter:RocketTrail;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		loadGraphic("images/scientist.png", true, 18, 24);
		animation.add("idle", [0, 1], 2, true);
		animation.add("flying", [2, 3], 2, true);
		animation.play("idle");
		
		if (FlxRandom.chanceRoll())
		{
			flipX = true;
		}
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Reg.state.flood.y - y < FlxG.height / 3.0 && !isFlying)
		{
			FlxTween.linearMotion(this, x, y, x, y - FlxG.height * 2.0, 3.0, true,
				{ ease: FlxEase.expoIn, complete: onTweenEnd } );
			
			animation.play("flying");
			isFlying = true;
			
			emitter = new RocketTrail(this);
			Reg.state.behindPlayer.add(emitter);
		}
		
		//if (!isOnScreen() && acceleration.y == -100)
		//{
			//kill();
			//destroy();
		//}
	}
	
	private function onTweenEnd(T:FlxTween):Void
	{
		emitter.kill();
		emitter.destroy();
		
		kill();
		destroy();
	}
}

class RocketTrail extends FlxEmitter
{
	private var s:Scientist;
	
	public function new(S:Scientist)
	{
		super(0, 0);
		s = S;
		
		makeParticles("images/particleSmall.png", 20, 0, false, 0.2, false);
		
		setColor(0xffFFAE00, 0xff800800);
		setAlpha(0.75, 1.0, 0.0, 0.0);
		setXSpeed(-50, 50);
		setYSpeed(50, 250);
		setRotation(0, 0);
		
		start(false, 0.5, 0.1, 0, 0.5);
	}
	
	override public function update():Void 
	{
		super.update();
		
		x = s.x + s.width / 2.0;
		y = s.y + s.height;
	}
}