package score ;

import ent.Player;
import flixel.FlxG;
import flixel.text.FlxText;

/**
 * ...
 * @author Ohmnivore
 */
class ScoreText extends FlxText
{
	private var p:Player;
	
	public function new(P:Player) 
	{
		super(0, 0, 0);
		p = P;
		
		scrollFactor.set();
		Score.setTextStyle(this);
		
		y = 1 + 1 + 8;
	}
	
	override public function update():Void 
	{
		x = FlxG.width - width - 1;
		text = "Score: " + Score.getScore(p) + "m";
		
		super.update();
	}
}