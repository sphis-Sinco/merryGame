package langhaxe;

using StringTools;

typedef LangHaxe =
{
	var name:String;
	var ?asset_suffix:String;
	var ?lang_ver:Float;
	var ?phrases:PhrasesJson;
}

typedef PhrasesJson =
{
	var ?yo_dude:String;
	var ?what_are_you_doing:String;
}

class PhraseManager
{
	public static var PHRASES_REQUIRING_FALLBACK:Array<String> = [];

	public static var languageList:LangHaxe = null;

	public static function init()
	{
		// Avoid loading the language file everytime getPhrase is called.
		try
		{
			languageList = Language.readLang(LanguageManager.LANGUAGE);
		}
		catch (e)
		{
			trace("Failed loading language: " + LanguageManager.LANGUAGE + " // " + e.message);
			languageList = Language.readLang("english"); // Use english.
			return;
		}
		trace("Language \"" + LanguageManager.LANGUAGE + "\" loaded.");
	}

	public static function getPhrase(phrase:Dynamic, ?fb:Dynamic = null):Dynamic
	{
		var json:PhrasesJson = languageList.phrases;
		var fallback:Dynamic = (fb != null ? fb : phrase);

		try
		{
			switch (Std.string(phrase).toLowerCase().replace(' ', '_'))
			{
				case 'yo_dude':
					return json.yo_dude;
				case 'what_are_you_doing':
					return json.what_are_you_doing;

				default:
					trace('[PHRASE MANAGER] Unknown phrase: "$phrase"');
			}
		}
		catch (e)
		{
			if (!PHRASES_REQUIRING_FALLBACK.contains(phrase))
			{
				trace('[PHRASE MANAGER] Phrase "$phrase" required fallback');
				PHRASES_REQUIRING_FALLBACK.push(phrase);
			}
			return fallback;
		}

		return fallback;
	}
}