package score;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Ohmnivore
 */
class ScoreIndicator extends FlxSpriteGroup
{
	private var mark:FlxSprite;
	private var score:FlxText;
	
	public function new(S:Int)
	{
		super(0, Score.getY(S));
		
		score = new FlxText(0, -12, 0, S + "m");
		score.color = 0xffff0000;
		score.alpha = 0.8;
		add(score);
		
		mark = new FlxSprite(0, -2);
		mark.makeGraphic(cast score.width + 4, 4, 0xffff0000, true);
		mark.alpha = 0.8;
		add(mark);
	}
}