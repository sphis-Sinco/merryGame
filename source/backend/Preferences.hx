package backend;

import haxe.Json;
import haxe.Timer;

class Preferences
{
	public static var savedata:GameSave;

	public static var SAVE_PATH:String = BackendAssets.json('save');

	public static function initPrefs()
	{
		trace('Initalizing Preferences');
		Timer.measure(() ->
		{
			try {
				savedata = Json.parse(BackendAssets.readFile(SAVE_PATH));
			} catch(e) {
				trace(e);
				savedata = null;
			}
			
			savedata ??= {};

			Save.nullcheck(savedata);

			PhraseManager.init();

			save();
			trace('Preferences Initalizing Time');
		});
	}

	public static function save()
	{
		Timer.measure(() -> {
			if (!BackendAssets.pathExists(SAVE_PATH)) BackendAssets.makePath(SAVE_PATH);

			BackendAssets.saveToFile(SAVE_PATH, Json.stringify(savedata));
			trace('Saving Time');
		});
	}
}