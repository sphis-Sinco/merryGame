package backend;

class Assets
{
	public static var EXISTING_PATHS:Array<String> = [];

	public static function getPath(path:String)
	{
		if (EXISTING_PATHS.contains(path) || pathExists(path))
			return '$path';
		else
			return '';
	}

	public static function getAssetPath(path:String)
		return getPath('assets/$path');

	public static function getDataPath(path:String)
		return getAssetPath('data/$path');

	public static function txt(file:String)
		return getDataPath('$file.txt');

	public static function json(file:String)
		return getDataPath('$file.json');

	public static function image(file:String)
		return getAssetPath('images/$file.png');

	public static function sound(file:String)
		return getAssetPath('sounds/$file.wav');

	public static function track(file:String)
		return getAssetPath('music/$file.wav');

	public static function pathExists(path:String)
	{
		var exists:Bool = false;

		#if sys
		exists = sys.FileSystem.exists(path);
		#end

		if (!EXISTING_PATHS.contains(path))
		{
			switch (exists)
			{
				case true:
					trace('checked path: "$path" exists.');
				default:
					trace('checked path: "$path" does not exist.');
			}

			EXISTING_PATHS.push(path);
		}

		return exists;
	}

	public static function makePath(path:String, ?content:String = '')
	{
		#if sys
		try
		{
			sys.io.File.saveContent(path, content);
		}
		catch (e)
		{
			trace(e);
		}
		#end
	}

	public static function readFile(path:String)
	{
		#if sys
		if (pathExists(path))
			return sys.io.File.getContent(path);
		#end

		return '';
	}

	public static function saveToFile(path:String, content:String)
	{
		#if sys
		if (pathExists(path))
			sys.io.File.saveContent(path, content);
		#end
	}

	public static function readDirectory(directory:String)
	{
		#if sys
		if (pathExists(directory))
			return sys.FileSystem.readDirectory(directory);
		#end

		return [];
	}
}
