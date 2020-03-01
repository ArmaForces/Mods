#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function creates task from given task config.
 *
 * Arguments:
 * 0: Task config <CONFIG>
 *
 * Return Value:
 * None
 *
 * Example:
 * [missionConfigFile >> "task1"] call afm_tasks_fnc_createTaskFromConfig
 *
 * Public: No
 */

params ["_taskConfig"];

private _title = getText (_taskConfig >> "title");
private _description = getText (_taskConfig >> "description");
private _marker = getText (_taskConfig >> "marker");
private _icon = getText (_taskConfig >> "icon");
private _parentTask = getText (_taskConfig >> "parentTask");
private _taskID = if (_parentTask isEqualTo "") then {
    configName _taskConfig
} else {
    [configName _taskConfig, _parentTask];
};
private _position = [_taskConfig] call FUNC(readPosition);
private _owner = IF_PROPERTY_EXISTS((_taskConfig >> "owner"),getArray,"true");
private _initialState = IF_PROPERTY_EXISTS((_taskConfig >> "initialState"),getText,"CREATED");
private _priority = IF_PROPERTY_EXISTS((_taskConfig >> "priority"),getNumber,-1);
private _createdShowNotification = if (getText (_taskConfig >> "createdShowNotification") isEqualTo "true") then {true} else {false};

// Load show condition
private _conditionCodeShow = compile (IF_PROPERTY_EXISTS((_taskConfig >> "conditionCodeShow"),getText,"true"));
if (call _conditionCodeShow) then {
    // Create task
    [_owner, _taskID, [_description, _title, _marker], _position, _initialState, _priority, _createdShowNotification, _icon] call BIS_fnc_taskCreate;
} else {
    private _taskCreateArray = [_owner, _taskID, [_description, _title, _marker], _position, _initialState, _priority, _createdShowNotification, _icon];
    [_conditionCodeShow, {_this call BIS_fnc_taskCreate}, _taskCreateArray] call CBA_fnc_waitUntilAndExecute;
};
