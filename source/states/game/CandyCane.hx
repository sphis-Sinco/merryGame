package states.game;

class CandyCane extends FlxSprite
{
    override public function new(X:Float = 0.0, Y:Float = 0.0) {
        super(X,Y);

        makeGraphic(32, 64, FlxColor.RED);
    }
}