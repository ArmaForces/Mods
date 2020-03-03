#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function changes task state to SUCCEEDED
 * and handles raising onSuccessEvents for given task.
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

private _taskConfigName = _taskNamespace getVariable "taskConfigName";

// Check if task was finished already
if ((_taskConfigName call BIS_fnc_taskState) in FINISHED_TASK_STATES) exitWith {nil};

// Fail task
[_taskConfigName, "SUCCEEDED"] call BIS_fnc_taskSetState;

// Call onSuccessCode
call compile (_taskNamespace getVariable ["onSuccessCode", ""]);

// Raise onSuccessEvents
{
    [_x] call CBA_fnc_serverEvent;
} forEach (_taskNamespace getVariable ["onSuccessEvents", []]);
