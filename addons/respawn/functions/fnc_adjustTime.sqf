#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function raises adjustTimeLocal event on all clients.
 *
 * Arguments:
 * 0: New respawn time delay <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [30] call afm_respawn_fnc_adjustTime
 *
 * Public: No
 */

params ["_newTime"];

if (!isServer) exitWith {};

[QGVAR(adjustTimeLocal), _this] call CBA_fnc_globalEvent;

GVAR(oldTime) = _newTime;
