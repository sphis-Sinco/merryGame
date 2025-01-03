package states;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import substate.PauseSubState;

class MenuState extends State
{
	public var options:Array<Dynamic> = [
		['play', () -> FlxG.switchState(new PlayState())],
		['credits', () -> FlxG.switchState(new CreditsState())],
		['settings', () -> FlxG.switchState(new SettingsState())],
		#if desktop ['exit', () -> Sys.exit(0)] #end
	];

	public var phrasePrefix:String = 'menu';

	public var optGrp:FlxTypedGroup<FlxText>;

	public var CURSEL:Int = 0;

	public var TEXT_SIZE:Int = 32;
	public var TEXT_PADDING:Float = 48;

	override public function new(selected:Int = 0)
	{
		super();

		CURSEL = selected;
	}

	override public function create()
	{
		preCreate();

		optGrp = new FlxTypedGroup<FlxText>();
		add(optGrp);

		var index:Int = 0;
		for (opt in options)
		{
			var optionText:FlxText = new FlxText(10, 10 + (index * (48)), 0, PhraseManager.getPhrase('${phrasePrefix}_${opt[0]}', opt[0]), TEXT_SIZE);
			optionText.ID = index;
			optGrp.add(optionText);

			index++;
		}

		postCreate();
		updateText();

		super.create();
	}

	function updateText()
	{
		for (member in optGrp.members)
		{
			member.x = (member.ID == CURSEL ? 20 : 10);
			member.color = (member.ID == CURSEL ? FlxColor.YELLOW : FlxColor.WHITE);
			member.alpha = (member.ID == CURSEL ? 1 : 0.5);
		}
	}

	override public function update(elapsed:Float)
	{
		if (ControlManager.UI_UP_R || ControlManager.UI_DOWN_R)
		{
			if (ControlManager.UI_UP_R)
				CURSEL--;
			if (ControlManager.UI_DOWN_R)
				CURSEL++;

			if (CURSEL < 0)
				CURSEL = 0;
			else if (CURSEL >= options.length)
				CURSEL = options.length - 1;
			else
				FlxG.sound.play(BackendAssets.sound('menu/Scroll'), 1);

			updateText();
		}
		else if (ControlManager.UI_SELECT_R)
		{
			try
			{
				var soundPath:String = BackendAssets.sound('menu/'+(Std.string(options[CURSEL][0]).toLowerCase() == 'leave' ? 'Leave' : 'Select'));
				
				FlxG.sound.play(soundPath, 1);
				options[CURSEL][1]();
			}
			catch (e)
			{
				trace(e);
			}
		}

		super.update(elapsed);
	}
}
