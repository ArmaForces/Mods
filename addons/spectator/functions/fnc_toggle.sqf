#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function toggles spectator enabled/disabled.
 *
 * Arguments:
 * 0: Spectator enabled <BOOL>
 *
 * Return Value:
 * 0: New spectator state <BOOL>
 *
 * Example:
 * [true] call afm_spectator_fnc_toggle
 *
 * Public: No
 */

params ["_enabled"];

if (!isServer) exitWith {};

if (_enabled) then {
    _this call FUNC(enable)
} else {
    _this call FUNC(disable)
};
