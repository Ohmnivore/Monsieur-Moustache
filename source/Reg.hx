package;

import flixel.util.FlxSave;

#if android
import score.Board;
#end

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var state:PlayState;
	public static var lowQual:Bool;
	
	#if android
	public static var board:Board;
	#end
	public static var googleAvailable:Bool = false;
}