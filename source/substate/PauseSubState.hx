package substate;

class PauseSubState extends SubState
{
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (ControlManager.UI_SELECT_R && PlayState.PAUSED)
		{
			PlayState.PAUSED = false;

			if (!PlayState.PAUSED) {
				close();
                trace('unpausing');
            }
		}
	}
}
