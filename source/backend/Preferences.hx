package backend;

import haxe.Json;
import haxe.Timer;

class Preferences
{
	public static var savedata:GameSave;

	public static var SAVE_PATH:String = BackendAssets.json('save');

	public static function initPrefs()
	{
		Timer.measure(() ->
		{
			try {
				savedata = Json.parse(Assets.getText(SAVE_PATH));
			} catch(e) {
				trace(e);
				savedata = null;
			}
			
			if (savedata == null)
				savedata = {
					language: "english"
				}

			PhraseManager.init();

			save();
		});
	}

	public static function save()
	{
		Timer.measure(() -> {
			if (!BackendAssets.pathExists(SAVE_PATH)) BackendAssets.makePath(SAVE_PATH);

			BackendAssets.saveToFile(SAVE_PATH, Json.stringify(savedata));
		});
	}
}