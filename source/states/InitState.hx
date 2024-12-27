package states;

import haxe.Timer;

using StringTools;

class InitState extends State
{
	override public function new()
	{
		super();
	}

	override function create()
	{
		super.create();

        #if PRELOAD
        Timer.measure(() ->
		{
			BackendAssets.checkDirectory('assets');
            trace('Preload Time');
		});
		#end

		Preferences.initPrefs();

		FlxG.switchState(new MenuState());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
