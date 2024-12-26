package langhaxe;

using StringTools;

typedef LangHaxe =
{
	var name:String;
	var ?asset_suffix:String;
	var ?lang_ver:Float;
	var ?phrases:haxe.DynamicAccess<String>;
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

	public static function getPhrase(phrase:Dynamic, ?fallbackparam:Dynamic = null):Dynamic
	{
		var json:haxe.DynamicAccess<String> = languageList.phrases;
		var fallback:Dynamic = (fallbackparam != null ? fallbackparam : phrase);
		var returnValue:Dynamic;
        var grabPhrase:Dynamic;

        switch(Std.string(phrase).toLowerCase().replace(' ', '_'))
        {
            case "language_leave":
                grabPhrase = 'options_leave';

            default:
                grabPhrase = Std.string(phrase).toLowerCase().replace(' ', '_');
        }

		try
		{
			returnValue = json.get(grabPhrase);
		}
		catch (e)
		{
			if (!PHRASES_REQUIRING_FALLBACK.contains(phrase))
			{
				trace('[PHRASE MANAGER] Phrase "$phrase" required fallback');
				PHRASES_REQUIRING_FALLBACK.push(phrase);
			}
			returnValue = fallback;
		}

		return returnValue;
	}
}