package gen;

import ent.Player;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Ohmnivore
 */
class GenTilemap extends FlxTilemap
{
	static public var TILESIZE:Int = 8;
	
	public var first:FlxPoint;
	
	private var settings:GenSettings;
	private var tempData:Array<Int> = [];
	
	public function new(Y:Float) 
	{
		super();
		
		settings = new GenSettings();
		
		widthInTiles = cast FlxG.width / TILESIZE;
		heightInTiles = cast FlxG.height * 2 / TILESIZE;
		
		FlxG.worldBounds.set(0, Y - 2.5 * FlxG.height, FlxG.width, FlxG.height * 5);
		
		initData();
		loadTiles();
		loadMap(tempData, GraphicAuto, TILESIZE, TILESIZE, FlxTilemap.AUTO, 0, 1, 1);
		
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
		trace(iStr);
		
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
	
	private function loadTiles():Void
	{
		var lastSpawn:FlxPoint = new FlxPoint(widthInTiles / 2, heightInTiles - 2);
		setDataTile(cast lastSpawn.x, cast lastSpawn.y, 1);
		first = new FlxPoint(lastSpawn.x * TILESIZE, lastSpawn.y * TILESIZE);
		
		while (lastSpawn.y > 3)
		{
			var newSpawn:FlxPoint = Platform.getNew(new FlxPoint(lastSpawn.x * TILESIZE, lastSpawn.y * TILESIZE),
				-Player.JUMPVEL, Player.XVEL, Player.GRAV, settings);
			newSpawn.x /= TILESIZE;
			newSpawn.y /= TILESIZE;
			if (newSpawn.x > widthInTiles - 1)
				newSpawn.x = widthInTiles - 2;
			if (newSpawn.x < 1)
				newSpawn.x = 1;
			
			var w:Int = FlxRandom.intRanged(settings.minWidth, settings.maxWidth);
			if (w == 1)
				setDataTile(cast newSpawn.x, cast newSpawn.y, 1);
			else
			{
				var strip:Strip = new Strip(cast newSpawn.x, w, widthInTiles - 1, 1);
				trace(strip.getArr());
				for (i in strip.getArr())
				{
					setDataTile(i, cast newSpawn.y, 1);
				}
			}
			
			lastSpawn = newSpawn;
		}
	}
}