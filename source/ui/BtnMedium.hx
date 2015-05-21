package ui;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextBorderStyle;

/**
 * ...
 * @author Ohmnivore
 */
class BtnMedium extends FlxButton
{
	public function new(Y:Float, Text:String, OnClick:Void->Void) 
	{
		super(0, Y, "", OnClick);
		loadGraphic("images/uiMediumBtn.png", true, 64, 24);
		
		x = (FlxG.width - width) / 2.0;
		scrollFactor.set();
		
		label.color = 0xffE1FDFF;
		label.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff3E5154, 2, 2);
		
		text = Text;
		label.offset.x = 1;
		label.offset.y = -2;
	}
}