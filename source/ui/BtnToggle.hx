package ui;

import flixel.addons.ui.FlxClickArea;
import flixel.FlxSprite;

/**
 * ...
 * @author Ohmnivore
 */
class BtnToggle extends FlxSprite
{
	public var call:Bool->Void;
	public var pressed:Bool = false;
	public var playing:String;
	public var click:FlxClickArea;
	
	public function new(X:Float, Y:Float, Callback:Bool->Void = null) 
	{
		super(X, Y);
		scrollFactor.set();
		call = Callback;
		loadGraphic("images/uiToggle.png", true, 18, 18);
		
		animation.add("off", [1], 30, false);
		animation.add("on", [0], 30, false);
		animation.play("off", true);
		click = new FlxClickArea(0, 0, 18, 18, toggle);
		click.scrollFactor.set();
	}
	
	private function toggle():Void
	{
		pressed = !pressed;
		
		if (call != null)
			call(pressed);
	}
	
	override public function update():Void 
	{
		if (pressed && playing != "on")
		{
			animation.play("on");
			playing = "on";
		}
		if (!pressed && playing != "off")
		{
			animation.play("off");
			playing = "off";
		}
		
		super.update();
	}
}