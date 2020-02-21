#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function toggles respawn enabled/disabled
 *
 * Arguments:
 * 0: Desired respawn state <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call afm_respawn_fnc_toggle
 *
 * Public: No
 */

params ["_enabled"];

if (!isServer) exitWith {};

// Setting hasn't change
if (GVAR(enabled) isEqualTo _enabled) exitWith {};

if (_enabled) then {
    [QGVAR(enable)] call CBA_fnc_remoteEvent;
} else {
    [QGVAR(disable)] call CBA_fnc_remoteEvent;
};

nil
