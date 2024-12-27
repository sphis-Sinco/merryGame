package input;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

/** This file contains 6 functions related to checking if a key is pressed, was just pressed, or just released, with 2 varients, 1 for multiple keys, the base functions, and 1 got singular keys **/
class KeyChecker
{
	/**
		check if `key` is pressed using `getPressedKeys()`
		@param key The key to check
	**/
	public static function getPressedKey(key:FlxKey):Bool
		return getPressedKeys([key]);

	/**
		check if `key` just got pressed using `getJustPressedKeys()`
		@param key The key to check
	**/
	public static function getJustPressedKey(key:FlxKey):Bool
		return getJustPressedKeys([key]);

	/**
		check if `key` just got released using `getJustReleasedKeys()`
		@param key The key to check
	**/
	public static function getJustReleasedKey(key:FlxKey):Bool
		return getJustReleasedKeys([key]);

	/**
		check if any of the keys in `keys` is pressed
		@param keys List of Keys to check
	**/
	public static function getPressedKeys(keys:Array<FlxKey>):Bool
		return FlxG.keys.anyPressed(keys);

	/**
		check if any of the keys in `keys` just got pressed
		@param keys List of Keys to check
	**/
	public static function getJustPressedKeys(keys:Array<FlxKey>):Bool
		return FlxG.keys.anyJustPressed(keys);

	/**
		check if any of the keys in `keys` just got released
		@param keys List of Keys to check
	**/
	public static function getJustReleasedKeys(keys:Array<FlxKey>):Bool
		return FlxG.keys.anyJustReleased(keys);
}
