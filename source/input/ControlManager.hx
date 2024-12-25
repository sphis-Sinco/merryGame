package input;

import flixel.input.keyboard.FlxKey;

/** This file contains many variables and functions in regards to control management **/
class ControlManager
{
	/**
		Map of keybinds.
	**/
	public static var KEYBINDS:Map<String, Array<FlxKey>> = [
		// ui keys
		'ui_up' => [UP, W],
		'ui_down' => [DOWN, S],
		'ui_select' => [ENTER],
		'ui_back' => [ESCAPE],
		// gameplay keys
		'move_left' => [LEFT, A],
		'move_right' => [RIGHT, D],
		'jump' => [SPACE]
	];

	/* Menu Keybinds */
	public static var UI_UP_P:Bool;
	public static var UI_DOWN_P:Bool;
	public static var UI_SELECT_P:Bool;
	public static var UI_BACK_P:Bool;
	public static var UI_UP_R:Bool;
	public static var UI_DOWN_R:Bool;
	public static var UI_SELECT_R:Bool;
	public static var UI_BACK_R:Bool;

	/* Gameplay Keybinds */
	public static var MOVE_LEFT_R:Bool;
	public static var MOVE_LEFT_P:Bool;
	public static var MOVE_RIGHT_R:Bool;
	public static var MOVE_RIGHT_P:Bool;
	public static var JUMP_R:Bool;
	public static var JUMP_P:Bool;

	/**
	 * Function to reset the variables for controls
	**/
	public static function resetControls()
	{
		UI_UP_P = false;
		UI_UP_R = false;
		UI_DOWN_P = false;
		UI_DOWN_R = false;
		UI_SELECT_P = false;
		UI_SELECT_R = false;
		UI_BACK_P = false;
		UI_BACK_R = false;

		MOVE_LEFT_R = false;
		MOVE_LEFT_P = false;
		MOVE_RIGHT_R = false;
		MOVE_RIGHT_P = false;
		JUMP_R = false;
		JUMP_P = false;
	}

	/**
	 * Function to update the variables for controls
	**/
	public static function updateControls()
	{
		UI_UP_P = KeyChecker.getPressedKeys(KEYBINDS.get('ui_up'));
		UI_UP_R = KeyChecker.getJustReleasedKeys(KEYBINDS.get('ui_up'));
		UI_DOWN_P = KeyChecker.getPressedKeys(KEYBINDS.get('ui_down'));
		UI_DOWN_R = KeyChecker.getJustReleasedKeys(KEYBINDS.get('ui_down'));
		UI_SELECT_P = KeyChecker.getPressedKeys(KEYBINDS.get('ui_select'));
		UI_SELECT_R = KeyChecker.getJustReleasedKeys(KEYBINDS.get('ui_select'));
		UI_BACK_P = KeyChecker.getPressedKeys(KEYBINDS.get('ui_back'));
		UI_BACK_R = KeyChecker.getJustReleasedKeys(KEYBINDS.get('ui_back'));

		MOVE_LEFT_R = KeyChecker.getJustReleasedKeys(KEYBINDS.get('move_left'));
		MOVE_LEFT_P = KeyChecker.getPressedKeys(KEYBINDS.get('move_left'));
		MOVE_RIGHT_R = KeyChecker.getJustReleasedKeys(KEYBINDS.get('move_right'));
		MOVE_RIGHT_P = KeyChecker.getPressedKeys(KEYBINDS.get('move_right'));
		JUMP_R = KeyChecker.getJustReleasedKeys(KEYBINDS.get('jump'));
		JUMP_P = KeyChecker.getPressedKeys(KEYBINDS.get('jump'));
	}
}