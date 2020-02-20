#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function disables spectator functionality.
 *
 * Arguments:
 * 0: Enable spectator <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [0] call afm_spectator_fnc_disable
 *
 * Public: No
 */

params ["_enabled"];

[QGVAR(stop)] call CBA_fnc_globalEvent;
