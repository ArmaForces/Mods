#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function toggles grass forcing enabled/disabled.
 *
 * Arguments:
 * 0: Grass forcing enabled <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call afm_grass_fnc_toggle
 *
 * Public: No
 */

params ["_enabled"];

if (!hasInterface) exitWith {};

if (_enabled) then {
    call FUNC(loop);
};

nil
