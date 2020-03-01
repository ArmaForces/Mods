#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function creates task from given task namespace.
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

params ["_taskConfigName", "_taskNamespace"];

private _title = _taskNamespace getVariable ["title", ""];
private _description = _taskNamespace getVariable ["description", ""];
private _marker = _taskNamespace getVariable ["marker", ""];
private _position = [_taskNamespace getVariable ["position", objNull], _marker] call FUNC(readPosition);
private _icon = _taskNamespace getVariable ["icon", ""];
private _parentTask = _taskNamespace getVariable ["parentTask", ""];
private _owner = _taskNamespace getVariable ["owner", "true"];
private _initialState = _taskNamespace getVariable ["initialState", "CREATED"];
private _priority = _taskNamespace getVariable ["priority", -1];
private _createdShowNotification = if (_taskNamespace getVariable ["createdShowNotification", ""] isEqualTo "true") then {true} else {false};

private _taskID = if (_parentTask isEqualTo "") then {
    _taskConfigName
} else {
    [_taskConfigName, _parentTask];
};

// Array used for BIS_fnc_taskCreate
private _taskCreateArray = [_owner, _taskID, [_description, _title, _marker], _position, _initialState, _priority, _createdShowNotification, _icon];
_taskNamespace setVariable ["taskCreateArray", _taskCreateArray];

// Load show condition
private _conditionCodeShow = compile (_taskNamespace getVariable ["conditionCodeShow", "true"]);
if (call _conditionCodeShow) then {
    // Create task
    _taskCreateArray call BIS_fnc_taskCreate;
} else {
    // Create task when conditionShow is true
    [_conditionCodeShow, {_this call BIS_fnc_taskCreate}, _taskCreateArray] call CBA_fnc_waitUntilAndExecute;
};
