package ui;

import flixel.ui.FlxButton;

/**
 * ...
 * @author Ohmnivore
 */
class BtnLeft extends FlxButton
{
	public function new(X:Float, Y:Float, OnClick:Void->Void) 
	{
		super(X, Y, "", OnClick);
		
		loadGraphic("images/uiLeft.png", true, 18, 18);
		scrollFactor.set();
	}
}