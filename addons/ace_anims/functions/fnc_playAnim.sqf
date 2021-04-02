#include "script_component.hpp"
/*
 * Author: veteran29
 * Play animation... TODO description
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Animation name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_player, "Acts_millerCamp_A"] call afm_ace_anims_fnc_playAnim
 *
 * Public: No
 */

params ["_player", "_anim"];

[_player, _anim] remoteExec ["switchMove", 0];

[findDisplay 46, "KeyDown", {
	params ["", "_key"];
	_thisArgs params ["_player"];
	systemChat str _this; // TODO remove
	if !(_key in actionKeys "MoveForward") exitWith {};

	[_player, ""] remoteExec ["switchMove", 0];
	findDisplay 46 displayRemoveEventHandler ["KeyDown", _thisID];

}, [_player]] call CBA_fnc_addBISEventHandler;


nil

