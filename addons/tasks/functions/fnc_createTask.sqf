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
private _object = _taskNamespace getVariable ["object", ""];
private _position = _taskNamespace getVariable ["position", []];
private _destination = [_position, _object, _marker] call FUNC(readDestination);
private _icon = _taskNamespace getVariable ["icon", ""];
private _parentTask = _taskNamespace getVariable ["parentTask", ""];
private _owners = _taskNamespace getVariable ["owners", ["true"]];
private _ownersProcessed = [_owners] call FUNC(readOwners);
private _initialState = _taskNamespace getVariable ["initialState", "CREATED"];
private _priority = _taskNamespace getVariable ["priority", -1];
private _createdShowNotification = _taskNamespace getVariable ["createdShowNotification", ""] == "true";

private _taskID = if (_parentTask isEqualTo "") then {
    _taskConfigName
} else {
    [_taskConfigName, _parentTask];
};

// Array used for BIS_fnc_taskCreate
private _taskCreateArray = [_ownersProcessed, _taskID, [_description, _title, _marker], _destination, _initialState, _priority, _createdShowNotification, _icon];
_taskNamespace setVariable ["taskCreateArray", _taskCreateArray];

// Handle task showing (and creation)
[_taskNamespace] call FUNC(handleShow);
