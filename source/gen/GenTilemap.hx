package gen;

import ent.Player;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
#if !web
import util.ArtifactFix;
#end

/**
 * ...
 * @author Ohmnivore
 */
class GenTilemap extends FlxTilemap
{
	static public var TILESIZE:Int = 8;
	
	public var first:FlxPoint;
	public static var lastPl:FlxPoint;
	public var settings:GenSettings;
	
	private var tempData:Array<Int> = [];
	
	public function new(Y:Float, Reset:Bool = false, LastPoint:FlxPoint = null) 
	{
		super();
		
		settings = new GenSettings(Reset);
		
		widthInTiles = cast FlxG.width / TILESIZE;
		heightInTiles = cast FlxG.height * 2 / TILESIZE;
		
		FlxG.worldBounds.set(0, Y - 16, FlxG.width, FlxG.height * 5);
		
		initData();
		loadTiles(LastPoint);
		tempData = Beautify.getBeautiful(tempData, widthInTiles);
		
		#if web
		loadMap(tempData, "images/tiles.png", TILESIZE, TILESIZE, FlxTilemap.OFF, 0, 1, 1);
		#else
		loadMap(tempData, ArtifactFix.artefactFix("images/tiles.png", TILESIZE, TILESIZE),
			TILESIZE, TILESIZE, FlxTilemap.OFF, 0, 1, 1);
		tileScaleHack = 1.03;
		#end
		
		setTileProperties(Beautify.BARREL_BOT, FlxObject.NONE);
		setTileProperties(Beautify.BARREL_TOP, FlxObject.NONE);
		setTileProperties(Beautify.CRATE, FlxObject.NONE);
		setTileProperties(Beautify.VENT, FlxObject.NONE);
		
		var iX:Int = 1;
		var iStr:String = "";
		for (iT in tempData)
		{
			iStr += iT;
			
			if (iX == widthInTiles)
			{
				iStr += "\n";
				
				iX = 0;
			}
			
			iX++;
		}
		//trace(iStr);
		
		x = 0;
		y = Y;
	}
	
	private function initData():Void
	{
		var iY:Int = 0;
		
		while (iY < heightInTiles)
		{
			var iX = 0;
			
			while (iX < widthInTiles)
			{
				tempData.push(0);
				
				iX++;
			}
			
			iY++;
		}
	}
	
	private function setDataTile(X:Int, Y:Int, Value:Int):Void
	{
		tempData[X + Y * widthInTiles] = Value;
	}
	
	private function setDataTileSoft(X:Int, Y:Int, Value:Int):Bool
	{
		if (X <= widthInTiles - 1 && X >= 1)
		{
			setDataTile(X, Y, Value);
			
			return true;
		}
		else
		{
			return false;
		}
	}
	
	private function loadTiles(LastPoint:FlxPoint = null):Void
	{
		var lastSpawn:FlxPoint = new FlxPoint();
		
		if (LastPoint == null)
		{
			lastSpawn = new FlxPoint(widthInTiles / 2, heightInTiles - 2);
			addPlatform(cast lastSpawn.x - 2, cast lastSpawn.y, widthInTiles - 2);
			first = new FlxPoint(lastSpawn.x * TILESIZE, lastSpawn.y * TILESIZE);
		}
		else
		{
			lastSpawn = Platform.getNew(new FlxPoint(LastPoint.x * TILESIZE, LastPoint.y * TILESIZE + heightInTiles * TILESIZE),
				-Player.JUMPVEL, Player.XVEL, Player.GRAV, settings);
			//lastSpawn.y += FlxG.height * 2.0;
			//addPlatform(cast lastSpawn.x / TILESIZE, cast lastSpawn.y / TILESIZE, widthInTiles - 2);
			first = new FlxPoint(lastSpawn.x / TILESIZE, lastSpawn.y / TILESIZE);
			lastSpawn.x /= TILESIZE;
			lastSpawn.y /= TILESIZE;
			
			if (lastSpawn.y > heightInTiles - 2)
			{
				y += (lastSpawn.y - (heightInTiles - 2)) * TILESIZE;
				
				lastSpawn.y = heightInTiles - 2;
			}
			
			addPlatform(cast lastSpawn.x, cast lastSpawn.y, widthInTiles - 2);
		}
		
		while (lastSpawn.y > 2)
		{
			var newSpawn:FlxPoint = Platform.getNew(new FlxPoint(lastSpawn.x * TILESIZE, lastSpawn.y * TILESIZE),
				-Player.JUMPVEL, Player.XVEL, Player.GRAV, settings);
			newSpawn.x /= TILESIZE;
			newSpawn.y /= TILESIZE;
			if (newSpawn.x > widthInTiles - 1)
				newSpawn.x = widthInTiles - 2;
			if (newSpawn.x < 1)
				newSpawn.x = 1;
			
			if (newSpawn.y > 2)
			{
				var w:Int = FlxRandom.intRanged(settings.minWidth, settings.maxWidth);
				if (w == 1)
					setDataTile(cast newSpawn.x, cast newSpawn.y, 1);
				else
				{
					addPlatform(cast newSpawn.x, cast newSpawn.y, w);
				}
				lastPl = newSpawn;
			}
			
			lastSpawn = newSpawn;
		}
	}
	
	private function addPlatform(X:Int, Y:Int, Width:Int):Void
	{
		var strip:Strip = new Strip(cast X, Width, widthInTiles - 1, 1);
		
		var dV:Array<Int> = Strip.getVerboseArr(strip.width);
		var i:Int = 0;
		var d:Array<Int> = strip.getArr();
		while (i < d.length)
		{
			setDataTile(d[i], Y, dV[i]);
			
			i++;
		}
	}
}