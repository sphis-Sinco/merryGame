package states;

import states.game.*;

class PlayState extends State
{
	public var GRAVITY:Float = 1.0;

	public var PLAYER_GRAVITY_TICKS:Float = 0;
	public var PLAYER_JUMP_MULTIPLIER:Float = 45;
	public var PLAYER_CAN_JUMP:Bool = false;

	public var player:Player;

	override public function create()
	{
		player = new Player(0,0);
		player.screenCenter();
		add(player);

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

		super.update(elapsed);
	}
}
