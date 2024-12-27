package substate;

import flixel.text.FlxText;
import flixel.tweens.FlxTween;

class PauseSubState extends SubState
{
	public var blackscreen:FlxSprite;
	public var pauseText:FlxText;

	public static var PAUSE_RETURNING_TO_MAINMENU:Bool = true;

	public static var TWEEN_TIME:Float = 0.1;

	override function preCreate()
	{
		super.preCreate();

		blackscreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackscreen.alpha = 0;

		pauseText = new FlxText(0, 0, 0, PhraseManager.getPhrase('paused'), 64);
		pauseText.screenCenter(X);
		pauseText.alpha = 0;
		pauseText.y = 10;
	}

	override function create()
	{
		super.create();

		preCreate();

		add(blackscreen);
		add(pauseText);

		FlxTween.tween(blackscreen, {alpha: 0.75}, TWEEN_TIME);
		FlxTween.tween(pauseText, {alpha: 1}, TWEEN_TIME);
		// FlxTween.tween(pauseText, {y: 10}, TWEEN_TIME * 2);

		postCreate();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (ControlManager.UI_SELECT_R && PlayState.PAUSED)
		{
			PlayState.PAUSED = false;

			if (!PlayState.PAUSED)
				tweenOut(() -> {
					
				});
		}
		else if (ControlManager.UI_BACK_R && PlayState.PAUSED)
		{
			PAUSE_RETURNING_TO_MAINMENU = true;
			if (PlayState.PAUSED)
			{
				FlxG.switchState(new MenuState());
				PlayState.PAUSED = false;
			}
		}
	}

	function tweenOut(?additionalfunc:Dynamic)
	{
		FlxTween.tween(pauseText, {alpha: 0}, TWEEN_TIME);
		FlxTween.tween(blackscreen, {alpha: 0}, TWEEN_TIME, {
			onComplete: _tween ->
			{
				additionalfunc();
				close();
			}
		});
	}
}
