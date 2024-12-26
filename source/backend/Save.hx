package backend;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public static function nullcheck(savedata:GameSave)
	{
		if (savedata.language == null)
			savedata.language = 'english';
		if (savedata.score == null)
			savedata.score = 0;
		if (savedata.highscore == null)
			savedata.highscore = 0;
	}
}

typedef GameSave =
{
	public var ?language:String;
	public var ?score:Null<Float>;
	public var ?highscore:Null<Float>;
}