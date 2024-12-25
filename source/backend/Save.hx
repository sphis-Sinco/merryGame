package backend;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public var savedata:GameSave;

	public function nullcheck()
	{
		if (savedata.language == null)
			savedata.language = 'english';
	}
}

typedef GameSave =
{
	public var language:String;
}