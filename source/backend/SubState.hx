package backend;

import flixel.FlxSubState;
import input.KeyChecker;

class SubState extends FlxSubState
{
    /**
		used to make sure input isn't accidentally being registered immediately
	**/
	public var INPUT_ON_START:Bool = false;

	override public function new() {
		ControlManager.resetControls();
		INPUT_ON_START = KeyChecker.getPressedKey(ANY);
		super();
	}
	override public function create() {super.create();}

	public function preCreate() {}
	public function postCreate() {}

	override public function update(elapsed:Float)
	{
		if (!INPUT_ON_START)
			ControlManager.updateControls();
		if (INPUT_ON_START)
			INPUT_ON_START = KeyChecker.getPressedKey(ANY);

		super.update(elapsed);
	}
}