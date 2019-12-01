#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function assigns (or unassigns) given unit as Zeus.
 *
 * Arguments:
 * 0: Unit to assign as Zeus <OBJECT>
 * 1: Assign as Zeus <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call afm_curator_fnc_assignZeus
 *
 * Public: No
 */

params ["_unit", ["_isZeus", true]];

if (_isZeus) then {
    [QGVAR(zeusAssign), [_unit]] call CBA_fnc_serverEvent;
} else {
    [QGVAR(zeusUnassign), [_unit]] call CBA_fnc_serverEvent;
};
