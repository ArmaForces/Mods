#include "script_component.hpp"
/*
 * Author: Diwako
 * Stops ACRE radio gesture
 *
 * Arguments:
 * 0: Unit to stop the gesture of <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

if !(_unit getVariable [QGVAR(onRadio), false]) exitWith {};

_unit playActionNow "acre_radio_stop";
_unit setVariable [QGVAR(onRadio), nil];

nil
