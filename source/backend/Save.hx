package backend;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public static function nullcheck(savedata:GameSave)
	{
		savedata.language ??= 'english';
		savedata.score ??= 0;
		savedata.highscore ??= 0;
	}
}

typedef GameSave =
{
	public var ?language:String;
	public var ?score:Null<Float>;
	public var ?highscore:Null<Float>;
}