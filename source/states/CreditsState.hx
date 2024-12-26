package states;

class CreditsState extends MenuState
{
    override public function preCreate()
        {
            options =[
                ['leave', () -> FlxG.switchState(new MenuState())]
            ];
            for (line in BackendAssets.readFile(BackendAssets.txt('credits')).split('\n'))
            {
                if (line.length > 2 || line != null) options.push([line, () -> {}]);
            }
    
            phrasePrefix = 'credits';
    
            super.preCreate();
        }
}