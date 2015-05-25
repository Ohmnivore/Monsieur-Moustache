package score;
import ru.zzzzzzerg.linden.GooglePlay;

/**
 * ...
 * @author Ohmnivore
 */
class Board
{
	public static inline var APP_ID:String = "723250102717";
	public static inline var BOARD_ID:String = "CgkIvYPDqIYVEAIQBg";
	public var gp:GooglePlay;
	
	public function new(GP:GooglePlay) 
	{
		gp = GP;
	}
	
	public function setScore(score:Int):Void
	{
		if (gp.games.isSignedIn())
		{
			gp.games.submitScore(BOARD_ID, score);
		}
	}
	
	public function viewScores():Void
	{
		gp.games.connect();
		gp.games.showLeaderboard(BOARD_ID);
	}
}