package substate;

import flixel.tweens.FlxTween;

class PauseSubState extends SubState
{
	public var blackscreen:FlxSprite;

	var TWEEN_TIME:Float = 0.1;

	override function preCreate()
	{
		super.preCreate();

		blackscreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackscreen.alpha = 0;
	}

	override function create()
	{
		super.create();

		preCreate();

		add(blackscreen);

		FlxTween.tween(blackscreen, {alpha: 0.75}, TWEEN_TIME);

		postCreate();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (ControlManager.UI_SELECT_R && PlayState.PAUSED)
		{
			PlayState.PAUSED = false;

			if (!PlayState.PAUSED)
			{
				FlxTween.tween(blackscreen, {alpha: 0}, TWEEN_TIME, {
					onComplete: _tween ->
					{
						close();
					}
				});
			}
		}
	}
}
