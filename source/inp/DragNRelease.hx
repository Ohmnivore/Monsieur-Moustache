package inp;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.util.FlxVector;

/**
 * ...
 * @author Ohmnivore
 */
class DragNRelease
{
	private static var MAXDRAG:Float = 40.0;
	
	public var pressed:Bool = false;
	
	public var startPoint:FlxPoint;
	public var endPoint:FlxPoint;
	public var delta:FlxVector;
	
	public var onPressed:DragNRelease->Void;
	public var onReleased:DragNRelease-> Void;
	
	public function new(OnPressed:DragNRelease->Void, OnReleased:DragNRelease->Void) 
	{
		onPressed = OnPressed;
		onReleased = OnReleased;
		
		startPoint = new FlxPoint();
		endPoint = new FlxPoint();
		delta = new FlxVector();
	}
	
	public function update():Void
	{
		#if mobile
		if (FlxG.touches.justStarted().length > 0)
		{
			pressed = true;
			
			FlxG.touches.getFirst().getScreenPosition().copyTo(startPoint);
			
			if (onPressed != null)
				onPressed(this);
		}
		
		if (FlxG.touches.justReleased().length > 0)
		{
			pressed = false;
			
			if (onReleased != null)
				onReleased(this);
		}
		
		if (pressed)
		{
			FlxG.touches.getFirst().getScreenPosition().copyTo(endPoint);
			delta.x = endPoint.x - startPoint.x;
			delta.y = endPoint.y - startPoint.y;
			
			if (delta.length > MAXDRAG)
			{
				delta = delta.normalize();
				delta = delta.scale(MAXDRAG);
			}
		}
		#else
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
			delta.x = endPoint.x - startPoint.x;
			delta.y = endPoint.y - startPoint.y;
			
			if (delta.length > MAXDRAG)
			{
				delta = delta.normalize();
				delta = delta.scale(MAXDRAG);
			}
		}
		#end
	}
}