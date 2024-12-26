package states.game;

class Player extends FlxSprite
{
    override public function new(X:Float = 0.0, Y:Float = 0.0) {
        super(X,Y);

        makeGraphic(48, 64, FlxColor.GREEN);
    }
}