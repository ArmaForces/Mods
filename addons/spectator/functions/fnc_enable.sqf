#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function enables spectator functionality.
 *
 * Arguments:
 * 0: Enable spectator <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [1] call afm_spectator_fnc_enable
 *
 * Public: No
 */

params ["_enabled"];

{
    [QGVAR(start), [_x], _x] call CBA_fnc_targetEvent;
} forEach (allPlayers select {[_x] call FUNC(canSpectate)});
