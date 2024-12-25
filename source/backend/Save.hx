package backend;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public var savedata:GameSave;

	public function nullcheck()
	{
		savedata.language ??= "english";
	}

	public static function save()
	{
		flush();
	}
}

typedef GameSave =
{
	public var language:String;
}