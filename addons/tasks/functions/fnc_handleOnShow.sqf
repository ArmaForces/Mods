#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles executing onShowCode and raising onShowEvents for given task
 *
 * Arguments:
 * 0: Task namespace <CBA_NAMESPACE>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_taskNamespace"];

// Call onShowCode
call compile (_taskNamespace getVariable ["onShowCode", ""]);

// Raise onShowEvents
{
    [_x] call CBA_fnc_serverEvent;
} forEach (_taskNamespace getVariable ["onShowEvents", []]);
