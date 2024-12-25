package backend;

import input.KeyChecker;

class State extends FlxState
{
	/**
		used to make sure input isn't accidentally being registered immediately
	**/
	public var INPUT_ON_START:Bool = false;

	override public function new() {super();}
	override public function create() {super.create();}

	override public function update(elapsed:Float)
	{
		if (!INPUT_ON_START)
			ControlManager.updateControls();
		if (INPUT_ON_START)
			INPUT_ON_START = KeyChecker.getJustReleasedKey(ANY);

		super.update(elapsed);
	}
}
