package backend;

import flixel.FlxG;
import haxe.Timer;

class Preferences
{
	public static var savefile:Save;
	public static var savedata:GameSave;

	public static function initPrefs()
	{
		Timer.measure(() ->
		{
			savefile.nullcheck();

			savedata.language ??= savefile.savedata.language;

			save();
		});
	}

	public static function save()
	{
		savefile.flush();
	}
}