#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function starts spectator for given player
 *
 * Arguments:
 * 0: player unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call afm_spectator_fnc_start
 *
 * Public: No
 */

params ["_player"];

if (!(local _player)) exitWith {[QGVAR(start), _this, _player] call CBA_fnc_targetEvent};

["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
