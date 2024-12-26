package states.settings;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class LanguageMenu extends MenuState
{
	override public function preCreate()
	{
		options =[
			['leave', () -> FlxG.switchState(new SettingsState())]
		];
        for (file in BackendAssets.readDirectory(BackendAssets.getAssetPath(Language.LANGUAGE_FOLDER)))
        {
			var trimmedFile = file.replace('.${Language.LANGUAGE_FILE_EXTENSION}', '');
            options.push([trimmedFile, () -> changeLang(trimmedFile)]);
        }

		phrasePrefix = 'language';

		super.preCreate();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function changeLang(newlang:String)
	{
		trace('Changing lang to $newlang');
		Preferences.savedata.language = newlang;
		Preferences.save();
		PhraseManager.init();
		FlxG.switchState(new LanguageMenu(CURSEL));

		return null;
	}
}
