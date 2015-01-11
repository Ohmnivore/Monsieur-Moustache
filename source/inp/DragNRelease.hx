package inp;
import flixel.FlxG;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Ohmnivore
 */
class DragNRelease
{
	public var pressed:Bool = false;
	
	public var startPoint:FlxPoint;
	public var endPoint:FlxPoint;
	
	public var onPressed:DragNRelease->Void;
	public var onReleased:DragNRelease->Void;
	
	public function new(OnPressed:DragNRelease->Void, OnReleased:DragNRelease->Void) 
	{
		onPressed = OnPressed;
		onReleased = OnReleased;
		
		startPoint = new FlxPoint();
		endPoint = new FlxPoint();
	}
	
	public function update():Void
	{
		if (FlxG.mouse.justPressed)
		{
			pressed = true;
			
			FlxG.mouse.getScreenPosition().copyTo(startPoint);
			
			if (onPressed != null)
				onPressed(this);
		}
		
		if (FlxG.mouse.justReleased)
		{
			pressed = false;
			
			if (onReleased != null)
				onReleased(this);
		}
		
		if (FlxG.mouse.pressed)
		{
			FlxG.mouse.getScreenPosition().copyTo(endPoint);
		}
	}
}