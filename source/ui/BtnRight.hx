package ui;

import flixel.ui.FlxButton;

/**
 * ...
 * @author Ohmnivore
 */
class BtnRight extends FlxButton
{
	public function new(X:Float, Y:Float, OnClick:Void->Void) 
	{
		super(X, Y, "", OnClick);
		
		loadGraphic("images/uiRight.png", true, 18, 18);
		scrollFactor.set();
	}
}