#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function checks if given unit is unconscious/incapacitated
 *
 * Arguments:
 * 0: Unit to check <OBJECT>
 *
 * Return Value:
 * 0: Is unconscious <BOOL>
 *
 * Example:
 * [player] call afm_common_fnc_isUnconscious
 *
 * Public: No
 */

params ["_unit"];

lifeState _unit isEqualTo "INCAPACITATED" // return
