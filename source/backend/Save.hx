package backend;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public static function nullcheck(savedata:GameSave)
	{
		savedata.language ??= 'english';
		savedata.highscore ??= 0;
	}
}

typedef GameSave =
{
	public var ?language:String;
	public var ?highscore:Null<Float>;
}
