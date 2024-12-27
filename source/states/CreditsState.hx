package states;

import flixel.text.FlxText;

class CreditsState extends MenuState
{
    override public function new() {
        super();
        TEXT_SIZE = 16;
        TEXT_PADDING = 24;
    }

    override public function preCreate()
        {
            options =[
                ['leave', () -> FlxG.switchState(new MenuState())]
            ];
            phrasePrefix = 'credits';

            var creditsFile:Array<String> = BackendAssets.readFile(BackendAssets.txt('credits')).split('\n');
            // trace(creditsFile.length);

            var index:Int = 0;
            for (credit in creditsFile)
            {
                var creditText:FlxText = new FlxText(10,(10+TEXT_PADDING) + (index * TEXT_PADDING), 0, credit, TEXT_SIZE);
                add(creditText);

                index++;
            }
    
            super.preCreate();
        }
}