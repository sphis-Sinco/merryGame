package states;

import states.settings.*;

class SettingsState extends MenuState
{
	override public function preCreate()
	{
		options = [
			['leave', () -> FlxG.switchState(new MenuState())],
			['language menu', () -> FlxG.switchState(new LanguageMenu())]
		];

		phrasePrefix = 'options';

		super.preCreate();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
