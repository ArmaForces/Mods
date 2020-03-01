#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function reads task position from config.
 *
 * Arguments:
 * 0: Task config <CONFIG>
 *
 * Return Value:
 * 0: Task object or (marker) position <OBJECT/POSITION>
 *
 * Example:
 * [missionConfigFile >> "task1"] call afm_tasks_fnc_readPosition
 *
 * Public: No
 */

params ["_taskConfig"];

if (configName (_taskConfig >> "position") isEqualTo "") exitWith {
    // Position is not defined, check if marker exists, if no, then task won't be shown on the map
    if (configName (_taskConfig >> "marker") isEqualTo "") exitWith {objNull};
    private _marker = getText (_taskConfig >> "marker");
    getMarkerPos _marker;
};

// Position is defined, check whether it is marker, object or position array
if (isText (_taskConfig >> "position")) then {
    private _text = getText (_taskConfig >> "position");
    private _markerPos = getMarkerPos _text;
    // If such marker doesn't exists, it will return [0, 0, 0]
    if (!(_markerPos isEqualTo [0, 0, 0])) exitWith {_markerPos};
    private _object = missionNamespace getVariable [_text, objNull];
    if (_object isEqualTo objNull) exitWith {
        // Object does not exists, return [0, 0, 0] as standard BI fnc would do
        WARNING_2("Position %1 defined for task %2 does not exists!", _text, configName _taskConfig)
        [0, 0, 0]
    };
    _object
} else {
    getArray (_taskConfig >> "position")
};
