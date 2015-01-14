package ui;

import flixel.FlxSubState;
import flixel.FlxG;
import score.Score;
import social.Twitter;

/**
 * ...
 * @author Ohmnivore
 */
class GameOverMenu extends FlxSubState
{
	override public function create():Void 
	{
		super.create();
		
		if (Score.s > Score.sBest)
		{
			add(new UIText(0, 1, "New highscore of " + Score.s + "m!"));
		}
		else
		{
			add(new UIText(0, 6, "Score: " + Score.s + "m"));
			add(new UIText(0, 16, "Highscore: " + Score.sBest + "m"));
		}
		Score.saveScore();
		
		add(new BtnPlay(FlxG.height / 6.0, launch));
		add(new BtnTweet(FlxG.height / 6.0 + 42.0, tweet));
		add(new BtnBack(FlxG.height / 6.0 + 68.0, backToMenu));
	}
	
	override public function update():Void 
	{
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
			launch();
		
		super.update();
	}
	
	private function launch():Void
	{
		FlxG.switchState(new PlayState());
	}
	private function tweet():Void
	{
		Util.blip();
		
		Twitter.tweetScore(Score.s);
	}
	private function backToMenu():Void
	{
		Util.blip();
		
		FlxG.switchState(new MenuState());
	}
}