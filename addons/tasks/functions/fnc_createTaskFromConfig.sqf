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

private _title = getText (_x >> "title");
private _description = getText (_x >> "description");
private _marker = getText (_x >> "marker");
private _icon = getText (_x >> "icon");
private _parentTask = getText (_x >> "parentTask");
private _taskID = if (_parentTask isEqualTo "") then {
    configName _x
} else {
    [configName _x, _parentTask];
};
private _position = [_x] call FUNC(readPosition);
private _owner = getArray (_x >> "owner");
private _initialState = getArray (_x >> "initialState");
private _priority = if (configName (_x >> "priority") isEqualTo "") then {-1} else {getNumber (_x >> "priority")};
private _createdShowNotification = if (getText (_x >> "createdShowNotification") isEqualTo "true") then {true} else {false};

// Create task
[_owner, _taskID, [_description, _title, _marker], _position, _initialState, _priority, _createdShowNotification, _icon] call BIS_fnc_taskCreate;
