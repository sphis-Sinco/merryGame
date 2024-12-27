package states;

import flixel.text.FlxText;
import states.game.*;
import substate.PauseSubState;

class PlayState extends State
{
	public var GRAVITY:Float = 1.0;

	public var PLAYER_GRAVITY_TICKS:Float = 0;
	public var PLAYER_JUMP_MULTIPLIER:Float = 50;
	public var PLAYER_CAN_JUMP:Bool = false;

	public var CANDY_CANE_MOVEMENT_SPEED:Float = 4.0;
	public var CANDY_CANE_MOVEMENT_MODIFIER:Float = 0.01;

	public var SCORE:Null<Float> = 0.0;

	public static var PAUSED:Bool = false;
	public static var PAUSE_TIME:Float = 0.0;

	public var player:Player;

	public var candycane:CandyCane;

	public var scoreText:FlxText;

	override function preCreate() {
		super.preCreate();
		SCORE = 0;

		player = new Player(0,0);
		player.screenCenter();

		candycane = new CandyCane(0,0);
		candycane.screenCenter();
		candycane.y -= 64;
		candycane.x = FlxG.width + candycane.width;
		
		scoreText = new FlxText(10,10,0,"",16);
	}

	override public function create()
	{
		preCreate();

		add(player);
		add(candycane);
		add(scoreText);

		postCreate();

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (!PAUSED)
		{

			if (!ControlManager.JUMP_R)
				{
					player.y += GRAVITY * ((PLAYER_GRAVITY_TICKS / 10) + 1);
					PLAYER_GRAVITY_TICKS++;
		
					if (player.y >= (FlxG.height / 2)) {
						player.y = FlxG.height / 2;
						PLAYER_CAN_JUMP = true;
					}
		
				} else if (ControlManager.JUMP_R && PLAYER_CAN_JUMP) {
					PLAYER_GRAVITY_TICKS = -(1 * PLAYER_JUMP_MULTIPLIER);
					PLAYER_CAN_JUMP = false;
				}

		}

		if (SCORE > Preferences.savedata.highscore)
			Preferences.savedata.highscore = SCORE;

		scoreText.text = '${PhraseManager.getPhrase('score','score:')} $SCORE';

		candycane.x -= CANDY_CANE_MOVEMENT_SPEED;
		if (candycane.x < 0 - candycane.width && !PAUSED) {
			candycane.x = FlxG.width + candycane.width;
			CANDY_CANE_MOVEMENT_SPEED += CANDY_CANE_MOVEMENT_MODIFIER;
		}

		if (player.overlaps(candycane) && !PAUSED)
		{
			SCORE++;
			candycane.x = FlxG.width + candycane.width;
			CANDY_CANE_MOVEMENT_SPEED -= CANDY_CANE_MOVEMENT_MODIFIER;
		}

		if (ControlManager.UI_SELECT_R && !PAUSED && PAUSE_TIME < 1)
		{
			PAUSED = true;

			if (PAUSED) {
				openSubState(new PauseSubState());
				PAUSE_TIME = 1.0;
			}
		} else if (!PAUSED && PAUSE_TIME > 0) {
			PAUSE_TIME -= 0.1;
		}

		super.update(elapsed);
	}
}
