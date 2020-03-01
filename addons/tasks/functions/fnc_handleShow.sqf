#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles showing task.
 * Prepares conditions/events required to show task.
 *
 * Arguments:
 * 0: Task namespace <CBA_NAMESPACE>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

params ["_taskNamespace"];

// Load show condition
private _conditionCodeShow = compile (_taskNamespace getVariable ["conditionCodeShow", "true"]);

[_conditionCodeShow, {
        params ["_taskNamespace"];
        (_taskNamespace getVariable "taskCreateArray") call BIS_fnc_taskCreate;
        [_taskNamespace] call FUNC(handleOnShow);
}, _taskNamespace] call CBA_fnc_waitUntilAndExecute;
