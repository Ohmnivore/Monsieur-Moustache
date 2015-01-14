package ui;

import flixel.FlxG;
import flixel.ui.FlxButton;

/**
 * ...
 * @author Ohmnivore
 */
class BtnWeb extends FlxButton
{
	public function new(Y:Float, OnClick:Void->Void) 
	{
		super(0, Y, "", OnClick);
		loadGraphic("images/uiWeb.png", true, 64, 24);
		
		x = (FlxG.width - width) / 2.0;
		scrollFactor.set();
	}
}