#include "script_component.hpp"
/*
 * Author: veteran29
 * Lowers unit weapon
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call afm_main_fnc_lowerWeapon
 *
 * Public: Yes
 */
params [
    ["_unit", objNull, [objNull]]
];

[QGVAR(lowerWeapon), _unit, _unit] call CBA_fnc_targetEvent;

nil

