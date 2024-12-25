package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		Preferences.initPrefs();
		PhraseManager.init();

		addChild(new FlxGame(0, 0, PlayState));
	}
}
