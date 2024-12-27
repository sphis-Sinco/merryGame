package states.settings;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

using StringTools;

class ControlsMenu extends MenuState
{
    var prompt:FlxSprite = new FlxSprite(0,0);
    var promptText:FlxText = new FlxText(0,0,0, "Changing Keybind", 16);

	override public function preCreate()
	{
		options = [['leave', () -> FlxG.switchState(new SettingsState())]];

        var index:Int = 0;
        for (key in ControlManager.KEYBINDS.keys())
            {
                var keybindName = key;

                options.push([keybindName, () -> changeKeybind(keybindName)]);
                index++;
            }

		phrasePrefix = 'controls';

        prompt.makeGraphic(Std.int(FlxG.width / 2), Std.int(FlxG.height / 2), FlxColor.YELLOW);

        promptText.alignment = CENTER;

		super.preCreate();
	}
    
    override function postCreate() {
        super.postCreate();

        prompt.visible = false;
        prompt.screenCenter();
        add(prompt);

        promptText.visible = false;
        promptText.screenCenter();
        add(promptText);
    }

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

        if (switching_keybind)
        {
            if (CURSEL != remembered_selection) CURSEL = remembered_selection;
            
            var keyPressed:Int = FlxG.keys.firstJustReleased();
            if (keyPressed > -1)
            {
                if (!ControlManager.UI_BACK_R) {
                    ControlManager.KEYBINDS.get(keybind_to_switch)[0] = keyPressed;

                    trace(ControlManager.KEYBINDS.get(keybind_to_switch)[0].toString());
                }

                switching_keybind = false;
                prompt.visible = false;
                promptText.visible = false;
            }
        }
	}

    public var switching_keybind:Bool = false;
    public var remembered_selection:Int = 0;
    public var keybind_to_switch:String = '';

	public function changeKeybind(keybind:String)
	{
		if (!switching_keybind)
        {
            prompt.visible = true;

            promptText.visible = true;
            promptText.text = PhraseManager.getPhrase("controls_Changing Keybind","Changing Keybind")
                +": "
                +keybind
                +"\n"
                +PhraseManager.getPhrase("controls_current key","current key")
                +": "
                +ControlManager.KEYBINDS.get(keybind)[0].toString()
                +"\n\n"
                +PhraseManager.getPhrase("controls_Press","Press")
                +" "
                +ControlManager.KEYBINDS.get('ui_back')[0].toString()
                +" "
                +PhraseManager.getPhrase("controls_to cancel","to cancel");
            promptText.screenCenter();

            switching_keybind = true;
            remembered_selection = CURSEL;
            keybind_to_switch = keybind;
        }
	}
}
