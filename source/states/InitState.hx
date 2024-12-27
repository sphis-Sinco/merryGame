package states;

import polymod.Polymod;

class InitState extends State
{

    override public function new() {
        super();   
    }
    
    override function create() {
        super.create();

        Polymod.scan({
            modRoot: "mods/"
        });

        FlxG.switchState(new MenuState());
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}