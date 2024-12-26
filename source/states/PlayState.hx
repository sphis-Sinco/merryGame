package states;

import flixel.text.FlxText;
import states.game.*;

class PlayState extends State
{
	public var GRAVITY:Float = 1.0;

	public var PLAYER_GRAVITY_TICKS:Float = 0;
	public var PLAYER_JUMP_MULTIPLIER:Float = 50;
	public var PLAYER_CAN_JUMP:Bool = false;

	public var CANDY_CANE_MOVEMENT_SPEED:Float = 4.0;

	public var SCORE:Null<Float> = 0.0;

	public var player:Player;

	public var candycane:CandyCane;

	public var scoreText:FlxText;

	override public function create()
	{
		SCORE = 0;

		player = new Player(0,0);
		player.screenCenter();
		add(player);

		candycane = new CandyCane(0,0);
		candycane.screenCenter();
		candycane.y -= 64;
		candycane.x = FlxG.width + candycane.width;
		add(candycane);

		scoreText = new FlxText(10,10,0,"",16);
		add(scoreText);

		super.create();
	}

	override public function update(elapsed:Float)
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

		if (SCORE > Preferences.savedata.highscore)
			Preferences.savedata.highscore = SCORE;

		scoreText.text = '${PhraseManager.getPhrase('score','score:')} $SCORE';

		candycane.x -= CANDY_CANE_MOVEMENT_SPEED;
		if (candycane.x < 0 - candycane.width)
			candycane.x = FlxG.width + candycane.width;

		if (player.overlaps(candycane))
		{
			SCORE++;
			candycane.x = FlxG.width + candycane.width;
		}

		super.update(elapsed);
	}
}
