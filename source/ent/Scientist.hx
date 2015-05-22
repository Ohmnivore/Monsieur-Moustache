package ent;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxRandom;

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
		
		if (new FlxRandom().bool())
		{
			flipX = true;
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (Reg.state.flood.y - y < FlxG.height / 3.0 && !isFlying)
		{
			FlxTween.linearMotion(this, x, y, x, y - FlxG.height * 2.0, 1.75, true,
				{ ease: FlxEase.expoIn, onComplete: onTweenEnd } );
			
			animation.play("flying");
			isFlying = true;
			
			emitter = new RocketTrail(this);
			Reg.state.behindPlayer.add(emitter);
		}
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
		
		//makeParticles("images/particleSmall.png", 20, 0, false, 0.2, false);
		loadParticles("images/particleSmall.png", 20, 0, false, false);
		elasticity.set(0.2);
		
		//setColor(0xffFFAE00, 0xff800800);
		color.start.min = 0xffFFAE00;
		color.end.max = 0xff800800;
		
		//setAlpha(0.5, 0.75, 0.0, 0.0);
		alpha.set(0.5, 0.75, 0.0, 0.0);
		
		//setXSpeed(-50, 50);
		//setYSpeed(50, 250);
		
		//setRotation(0, 0);
		angularVelocity.set(0);
		
		//start(false, 0.5, 0.1, 0, 0.5);
		lifespan.max = lifespan.min + 0.5;
		frequency = 0.5;
		start(false, 0.1, 0);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		x = s.x + s.width / 2.0;
		y = s.y + s.height;
	}
}