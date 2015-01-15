package gen;

/**
 * ...
 * @author Ohmnivore
 */
class GenSettings
{
	static private var ind:Int = 0;
	
	public var floodSpeed:Float;
	
	public var minTime:Float;
	public var maxTime:Float;
	
	public var minWidth:Int;
	public var maxWidth:Int;
	
	public var minGrav:Float;
	public var maxGrav:Float;
	
	public var minVelX:Float;
	public var maxVelX:Float;
	
	private var diff:Float;
	private var diff2:Float;
	private var invDiff:Float;
	
	public function new(Reset:Bool = false)
	{
		if (Reset)
			ind = 0;
		
		getDiff();
		
		minTime = 0.33 - 0.10 * diff;
		maxTime = 0.67 + 0.05 * diff;
		
		minWidth = cast 2 + 2 * invDiff;
		maxWidth = cast 6 - 2 * diff;
		
		minGrav = 1.3 - 0.1 * diff;
		maxGrav = 1.3 - 0.16 * diff;
		
		minVelX = 0.1 + 0.2 * diff;
		maxVelX = 0.2 + 0.2 * diff;
		
		floodSpeed = 25.0 + 25.0 * diff2;
	}
	
	private function getDiff():Void
	{
		diff = Math.sqrt(ind) * 0.2;
		diff2 = Math.sqrt(ind) * 0.5;
		
		if (diff > 1.0)
			diff = 1.0;
		if (diff2 > 1.0)
			diff2 = 1.0;
		
		invDiff = 1.0 - diff;
		
		ind++;
	}
}