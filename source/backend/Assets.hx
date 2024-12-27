package backend;

class Assets
{
	public static var EXISTING_PATHS:Array<String> = [];

	public static function getPath(path:String)
	{
		if (EXISTING_PATHS.contains(path) || pathExists(path))
			return '$path';
		
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

		if (path == '')
			return exists;

		if (!EXISTING_PATHS.contains(path))
		{
			trace('checked path: "$path" ${exists ? 'exists' : 'does not exist'}.');

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

	public static function checkDirectory(directory:String)
	{
		
		for (path in BackendAssets.readDirectory(BackendAssets.getPath('$directory')))
			{
				BackendAssets.pathExists(BackendAssets.getPath('$directory/' + path));

				if (!path.contains('.'))
				{
					for (item in BackendAssets.readDirectory(BackendAssets.getPath('$directory/' + path)))
					{
						BackendAssets.pathExists(BackendAssets.getPath('$directory/$path/' + item));

						if (!item.contains('.'))
						{
							checkDirectory(BackendAssets.getPath('$directory/$path/' + item));
						}
					}
				}
			}
	}
}
