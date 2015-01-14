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
	private var p:Player;
	
	public function new(P:Player) 
	{
		super(0, 1, 0);
		
		p = P;
		
		scrollFactor.set();
		Score.setTextStyle(this);
	}
	
	override public function update():Void 
	{
		x = FlxG.width - width - 1;
		text = "Best Score: " + Score.sBest + "m";
		
		super.update();
	}
}