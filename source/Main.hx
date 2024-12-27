package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		Preferences.initPrefs();

		addChild(new FlxGame(0, 0, InitState));
	}
}
