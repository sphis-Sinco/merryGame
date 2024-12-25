package states;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class MenuState extends State
{
	public static var options:Array<Dynamic> = [
		['play', () -> FlxG.switchState(new PlayState())],
		['settings', () -> FlxG.switchState(new SettingsState())],
		#if desktop ['exit', () -> Sys.exit(0)] #end
	];

	public static var optGrp:FlxTypedGroup<FlxText>;

	public var CURSEL:Int;

	override public function create()
	{
		optGrp = new FlxTypedGroup<FlxText>();
		add(optGrp);

		var index:Int = 0;
		for (opt in options)
		{
			var optionText:FlxText = new FlxText(10, 10 + (index * 48), 0, PhraseManager.getPhrase('menu_${opt[0]}', opt[0]), 32);
			optionText.ID = index;
			optGrp.add(optionText);

			index++;
		}

		updateText();

		super.create();
	}

	function updateText()
	{
		for (member in optGrp.members)
		{
			member.x = 10;
			member.color = FlxColor.WHITE;
			member.alpha = 0.5;

			if (member.ID == CURSEL)
			{
				member.x = 20;
				member.color = FlxColor.YELLOW;
				member.alpha = 1.0;
			}
		}
	}

	override public function update(elapsed:Float)
	{
		if (ControlManager.UI_UP_R || ControlManager.UI_DOWN_R){
			if (ControlManager.UI_UP_R)
				CURSEL--;
			if (ControlManager.UI_DOWN_R)
				CURSEL++;

			if (CURSEL < 0)
				CURSEL = 0;
			if (CURSEL >= options.length)
				CURSEL = options.length - 1;

			updateText();
		} else if (ControlManager.UI_SELECT_R ) {
            options[CURSEL][1]();
        }

		super.update(elapsed);
	}
}
