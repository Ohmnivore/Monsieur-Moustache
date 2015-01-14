package ui;

import flixel.FlxG;
import flixel.FlxSubState;

/**
 * ...
 * @author Ohmnivore
 */
class CreditsMenu extends FlxSubState
{
	private static var DEVPAGE:String = "http://ohmnivore.elementfx.com/press/index.php";
	private static var BUCHPAGE:String = "http://opengameart.org/users/buch";
	
	override public function create():Void 
	{
		super.create();
		
		var devs:UIText = new UIText(1, 1, "Made by 4AM Games");
		var devLink:BtnMedium = new BtnMedium(devs.y + devs.height + 1, "Visit", visitDevs);
		var buch1:UIText = new UIText(1, devLink.y + devLink.height + 6, "UI graphics and liquid",
			8, FlxG.width - 2);
		var buch2:UIText = new UIText(1, buch1.y + buch1.height + 1, "animation drawn by Buch",
			8, FlxG.width - 2);
		var buchLink:BtnMedium = new BtnMedium(buch2.y + buch2.height + 1, "Visit", visitBuch);
		
		var back = new BtnBack(buchLink.y + buchLink.height * 2.0, close);
		
		add(devs);
		add(devLink);
		add(buch1);
		add(buch2);
		add(buchLink);
		add(back);
	}
	
	private function visitDevs():Void
	{
		Util.blip();
		
		FlxG.openURL(DEVPAGE);
	}
	private function visitBuch():Void
	{
		Util.blip();
		
		FlxG.openURL(BUCHPAGE);
	}
	
	override public function close():Void 
	{
		Util.blip();
		
		var p:MenuState = cast _parentState;
		p.setHudVisible(true);
		
		super.close();
	}
}