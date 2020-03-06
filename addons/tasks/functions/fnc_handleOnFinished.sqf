#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function changes task state to SUCCEEDED
 * and handles raising onSuccessEvents for given task.
 *
 * Arguments:
 * 0: Task namespace <CBA_NAMESPACE>
 * 1: Finish type "Success"/"Failed"/"Canceled" <STRING>
 * 2: Force new task state? <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_taskNamespace", "_finishType", ["_force", false]];

private _taskConfigName = _taskNamespace getVariable "taskConfigName";

// Check if task was finished already or we force state change
if (!_force && {(_taskConfigName call BIS_fnc_taskState) in FINISHED_TASK_STATES}) exitWith {nil};

private _newTaskState = switch (_finishType) do {
    case "Success": {"SUCCEEDED"};
    case "Failed": {"FAILED"};
    case "Canceled": {"CANCELED"};
};

// Set task state
[_taskConfigName, _newTaskState] call BIS_fnc_taskSetState;

[QGVAR(taskStateChanged), [_taskConfigName, _newTaskState]] call CBA_fnc_globalEvent;

// Call code
call compile (_taskNamespace getVariable [format ["on%1Code", _finishType], ""]);

// Raise events
{
    [_x] call CBA_fnc_serverEvent;
} forEach (_taskNamespace getVariable [format ["on%1Events", _finishType], []]);
