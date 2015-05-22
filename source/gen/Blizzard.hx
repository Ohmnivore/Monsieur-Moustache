package gen;

import ent.Flood;
import ent.Player;
import flixel.addons.display.FlxStarField.FlxStarField2D;
import flixel.FlxG;
import flixel.math.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class Blizzard extends FlxStarField2D
{
	private var p:Player;
	private var f:Flood;
	private var speedY:Float;
	
	public function new(Width:Float, Height:Float, P:Player, F:Flood) 
	{
		super( 0, 0, cast Width / 2 + 32, cast Height / 2 + 36, new FlxRandom().int(25, 60));
		
		p = P;
		f = F;
		
		scale.y = 2;
		scale.x = 2;
		scrollFactor.set();
		bgColor = 0x00000000;
		starVelocityOffset.x = new FlxRandom().float( -0.3, 0.3);
		setStarSpeed(new FlxRandom().int(50, 150), new FlxRandom().int(350, 450));
		speedY = new FlxRandom().float(0.2, 0.9);
		alpha = 0.7;
	}
	
	override public function update(elapsed:Float):Void 
	{
		starVelocityOffset.y = -speedY - p.velocity.y * 0.004;
		
		//var floodHeight:Float = FlxG.camera.height - (f.y - FlxG.camera.scroll.y);
		//if (floodHeight > 0)
		//{
			//floodHeight = 0;
		//}
		//height = (FlxG.height - floodHeight) / 1.8;
		
		super.update(elapsed);
	}
}