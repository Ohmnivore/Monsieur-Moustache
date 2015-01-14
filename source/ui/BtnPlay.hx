package ui;

import flixel.FlxG;
import flixel.ui.FlxButton;

/**
 * ...
 * @author Ohmnivore
 */
class BtnPlay extends FlxButton
{
	public function new(Y:Float, OnClick:Void->Void) 
	{
		super(0, Y, "", OnClick);
		loadGraphic("images/uiPlay.png", true, 80, 40);
		
		x = (FlxG.width - width) / 2.0;
		scrollFactor.set();
	}
}