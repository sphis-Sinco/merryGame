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
	var ?menu_play:String;
	var ?menu_settings:String;
	var ?menu_exit:String;

	var ?options_leave:String;
	var ?options_language_menu:String;

	var ?language_english:String;
	var ?language_italian:String;
	var ?language_portuguese:String;
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
			languageList = Language.readLang(Preferences.savedata.language);
		}
		catch (e)
		{
			trace("Failed loading language: " + Preferences.savedata.language + " // " + e.message);
			languageList = Language.readLang("english"); // Use english.
			return;
		}
		trace("Language \"" + Preferences.savedata.language + "\" loaded.");
	}

	public static function getPhrase(phrase:Dynamic, ?fb:Dynamic = null):Dynamic
	{
		var json:PhrasesJson = languageList.phrases;
		var fallback:Dynamic = (fb != null ? fb : phrase);

		try
		{
			switch (Std.string(phrase).toLowerCase().replace(' ', '_'))
			{
				case 'menu_play': return json.menu_play;
				case 'menu_settings': return json.menu_settings;
				case 'menu_exit': return json.menu_exit;
				case 'options_leave' | 'language_leave': return json.options_leave;
				case 'options_language_menu': return json.options_language_menu;
				case 'language_english': return json.language_english;
				case 'language_italian': return json.language_italian;
				case 'language_portuguese': return json.language_portuguese;
				default: trace('[PHRASE MANAGER] Unknown phrase: "$phrase"');
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