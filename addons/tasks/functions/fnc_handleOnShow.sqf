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

// Check if task was shown already
if (_taskNamespace getVariable ["shown", false]) exitWith {};
_taskNamespace setVariable ["shown", true];

// Create task
(_taskNamespace getVariable "taskCreateArray") call BIS_fnc_taskCreate;

private _taskConfigName = _taskNamespace getVariable "taskConfigName";
[QGVAR(taskCreated), [_taskConfigName]] call CBA_fnc_globalEvent;

// Call onShowCode
call compile (_taskNamespace getVariable ["onShowCode", ""]);

// Raise onShowEvents
{
    [_x] call CBA_fnc_serverEvent;
} forEach (_taskNamespace getVariable ["onShowEvents", []]);

// Prepare Success and Failed handling
[_taskNamespace, "Success", FUNC(handleOnFinished)] call FUNC(handleFinish);
[_taskNamespace, "Failed", FUNC(handleOnFinished)] call FUNC(handleFinish);
[_taskNamespace, "Canceled", FUNC(handleOnFinished)] call FUNC(handleFinish);
