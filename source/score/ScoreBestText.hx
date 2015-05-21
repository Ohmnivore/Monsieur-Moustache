package score ;

import ent.Player;
import flixel.FlxG;
import flixel.text.FlxText;

/**
 * ...
 * @author Ohmnivore
 */
class ScoreBestText extends FlxText
{
	public function new() 
	{
		super(0, 1, 0);
		
		scrollFactor.set();
		Score.setTextStyle(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		x = FlxG.width - width - 1;
		text = "Best Score: " + Score.sBest + "m";
		
		super.update(elapsed);
	}
}