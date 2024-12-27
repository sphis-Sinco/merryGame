package states;

class InitState extends State
{

    override public function new() {
        super();   
    }
    
    override function create() {
        super.create();

        #if !hl
        Initalizer.scan();
        #end

        FlxG.switchState(new MenuState());
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}