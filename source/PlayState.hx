package;

import ent.BillBoard;
import ent.Flood;
import ent.Hat;
import ent.Player;
import ent.Scientist;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxVector;
import gen.Background;
import gen.Blizzard;
import gen.GenTilemap;
import gen.Platform;
import inp.DragNRelease;
import flixel.group.FlxTypedGroup;
import score.ScoreBestText;
import score.Score;
import score.ScoreIndicator;
import score.ScoreText;
import sfx.Sound;
import ui.Hint;
import ui.Util;
#if (android && ADS)
import admob.AD;
#end

//import pgr.dconsole.DC;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var p:Player;
	public var hat:Hat;
	public var cMap:FlxTypedGroup<GenTilemap>;
	public var drag:DragNRelease;
	public var canJump:Bool = false;
	public var flood:Flood;
	
	public var backGround:FlxGroup;
	public var behindPlayer:FlxGroup;
	public var hud:FlxGroup;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		#if (android && ADS)
		AD.hide();
		#end
		
		FlxG.scaleMode = new RatioScaleMode();
		
		super.create();
		BillBoard.initPhrases();
		Score.loadScore();
		Reg.state = this;
		persistentUpdate = true;
		Util.blip();
		
		backGround = new FlxGroup();
		add(backGround);
		cMap = new FlxTypedGroup();
		add(cMap);
		behindPlayer = new FlxGroup();
		add(behindPlayer);
		
		var firstMap:GenTilemap = new GenTilemap(0, true);
		cMap.add(firstMap);
		
		FlxG.camera.bgColor = Background.getRandColor();
		FlxG.camera.scroll.x = 0;
		
		p = new Player(firstMap.first.x - 4, firstMap.first.y - 32);
		add(p.stretchSpr);
		add(p);
		hat = new Hat(getHat(), p);
		add(hat);
		
		//var sc:Scientist = new Scientist(firstMap.first.x - 9, firstMap.first.y - 18);
		//behindPlayer.add(sc);
		
		drag = new DragNRelease(onPressed, onReleased);
		
		flood = new Flood();
		flood.speed = firstMap.settings.floodSpeed;
		if (!Reg.lowQual)
		{
			add(new Blizzard(FlxG.width, FlxG.height, p, flood));
		}
		add(flood);
		
		hud = new FlxGroup();
		add(hud);
		
		hud.add(new Hint(FlxG.height * 1.7));
		hud.add(new ScoreBestText());
		hud.add(new ScoreText(p));
		if (Score.sBest != 0)
			hud.add(new ScoreIndicator(Score.sBest));
		
		//DC.init();
	}
	
	private function getHat():String
	{
		FlxG.save.bind("Elasticate");
		
		var ret:String = "topHat";
		
		if (FlxG.save.data.hat != null)
		{
			ret = cast FlxG.save.data.hat;
		}
		
		FlxG.save.close();
		
		return ret;
	}
	
	private function onPressed(D:DragNRelease):Void
	{
		if (p.alive)
			Sound.playStretch();
	}
	
	private function onReleased(D:DragNRelease):Void
	{
		if (canJump && p.alive)
		{
			//if (p.velocity.y < 0)
				//p.velocity.y = D.delta.y * Player.JUMPVEL / 40.0;
			//else
				p.velocity.y = -D.delta.y * Player.JUMPVEL / 40.0;
			p.velocity.x = -D.delta.x * Player.XVEL / 40.0;
			
			flood.firstJump = false;
			
			p.onJump();
			
			Sound.playJump();
		}
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		canJump = false;
		
		#if !FLX_NO_DEBUG
		if (FlxG.keys.pressed.W)
		{
			p.acceleration.y = 0;
			p.velocity.y -= 5;
		}
		if (FlxG.keys.pressed.S)
		{
			p.acceleration.y = Player.GRAV;
			p.velocity.y = 0;
		}
		if (FlxG.keys.justPressed.Q)
		{
			FlxG.save.bind("Elasticate");
			FlxG.save.erase();
		}
		#end
		
		var highest:GenTilemap = cMap.getFirstExisting();
		//DC.beginProfile("Collide");
		for (map in cMap.members)
		{
			if (p.y + FlxG.height / 2 < map.y)
			{
				remove(map, true);
				map.kill();
				map.destroy();
				map = null;
			}
			else
			{
				if (map.velocity != null)
				{
					updateMap(map);
					
					if (map.y < highest.y)
						highest = map;
				}
			}
		}
		//DC.endProfile("Collide");
		if (highest != null)
		{
			if (p.y - FlxG.height / 1.5 <= highest.y)
			{
				addNewMap(highest);
			}
		}
		if (p.alive)
		{
			if (p.stretch)
			{
				FlxG.camera.scroll.y += (p.y - (FlxG.camera.scroll.y + FlxG.height * 0.6 - drag.delta.y * 0.8)) * 0.05;
				//FlxG.camera.scroll.x += (p.x - (FlxG.camera.scroll.x + FlxG.width / 2.0 + drag.delta.x)) * 0.04;
			}
			else
			{
				FlxG.camera.scroll.y += (p.y - (FlxG.camera.scroll.y + FlxG.height * 0.6)) * 0.04;
				//FlxG.camera.scroll.x += (FlxG.width / 2.0 - (FlxG.camera.scroll.x + FlxG.width / 2.0)) * 0.04;
			}
		}
		else
		{
			FlxG.camera.scroll.y += (p.y - (FlxG.camera.scroll.y + FlxG.height * 0.80)) * 0.04;
		}
		
		drag.update();
		if (drag.pressed && p.alive)
		{
			p.stretch = true;
			p.stretchDest.x = drag.delta.x;
			p.stretchDest.y = drag.delta.y;
		}
		else
		{
			p.stretch = false;
		}
		
		super.update();
	}
	private function addNewMap(Highest:GenTilemap):Void
	{
		var n:GenTilemap = new GenTilemap(Highest.y - FlxG.height * 2, false, GenTilemap.lastPl);
		flood.speed = n.settings.floodSpeed;
		n.update();
		
		cMap.add(n);
		
		if (!Reg.lowQual)
		{
			if (BillBoard.doDisplay())
			{
				var bill:BillBoard = new BillBoard(n.y + n.height - 150);
				backGround.add(bill);
			}
		}
	}
	
	private function updateMap(M:GenTilemap):Void
	{
		if (p.overlaps(M, true))
		{
			canJump = true;
		}
		if (FlxG.collide(M, p, p.onCollide))
		{
			canJump = true;
		}
	}
}