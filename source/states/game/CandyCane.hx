package states.game;

import flixel.math.FlxRandom;

class CandyCane extends FlxSprite
{
	var candyCaneAssets:Array<String> = [];

	override public function new(X:Float = 0.0, Y:Float = 0.0)
	{
		super(X, Y);

		candyCaneAssets = BackendAssets.readDirectory(BackendAssets.getAssetPath('images/candy canes'));
		reloadGraphic();
	}

	public function reloadGraphic()
	{
		var random:FlxRandom = new FlxRandom();
		var assetpath:String = BackendAssets.image('candy canes/' + candyCaneAssets[random.int(0, candyCaneAssets.length - 1)].replace('.png', ''));

		loadGraphic(assetpath);

		updateHitbox();
	}
}
