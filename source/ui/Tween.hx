package ui;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class Tween
{
	public static function tweenAlpha(S:FlxSprite)
	{
		FlxTween.tween(S, { alpha:1 }, 0.3, { type:FlxTween.ONESHOT, ease:FlxEase.elasticOut } );
	}
	
	public static function tweenToRight(S:FlxSprite)
	{
		FlxTween.linearMotion(S, S.x - FlxG.width, S.y, S.x,
			S.y, 0.5, true, { type:FlxTween.ONESHOT, ease:FlxEase.elasticOut } );
		S.x -= FlxG.width;
	}
	
	public static function tweenToLeft(S:FlxSprite)
	{
		FlxTween.linearMotion(S, S.x + FlxG.width, S.y, S.x,
			S.y, 0.5, true, { type:FlxTween.ONESHOT, ease:FlxEase.elasticOut } );
		S.x += FlxG.width;
	}
	
	public static function tweenToBottom(S:FlxSprite)
	{
		FlxTween.linearMotion(S, S.x, S.y - FlxG.height, S.x,
			S.y, 1, true, { type:FlxTween.ONESHOT, ease:FlxEase.elasticOut } );
		S.y -= FlxG.height;
	}
	
	public static function tweenToTop(S:FlxSprite)
	{
		FlxTween.linearMotion(S, S.x, S.y + FlxG.height, S.x,
			S.y, 1, true, { type:FlxTween.ONESHOT, ease:FlxEase.elasticOut } );
		S.y += FlxG.height;
	}
}