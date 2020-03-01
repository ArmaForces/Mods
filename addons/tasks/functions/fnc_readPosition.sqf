#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function reads task position from config.
 *
 * Arguments:
 * 0: Task object var (string)/position <STRING/ARRAY>
 * 1: Task marker
 *
 * Return Value:
 * 0: Task object or (marker) position <OBJECT/POSITION>
 *
 * Example:
 * None
 *
 * Public: No
 */

params ["_taskPosition", "_taskMarker"];

// If position attribute is empty but marker is supplied then get marker position
if (_taskPosition isEqualTo objNull) exitWith {
    if (_taskMarker isEqualTo "") exitWith {objNull};
    getMarkerPos _taskMarker
};

if (_taskPosition isEqualType "") exitWith {
    private _markerPos = getMarkerPos _taskPosition;
    if (!(_markerPos isEqualTo [0, 0, 0])) exitWith {_markerPos};
    private _object = missionNamespace getVariable [_taskPosition, objNull];
    if (_object isEqualTo objNull) exitWith {
        // Object does not exists, return [0, 0, 0] as standard BI fnc would do
        WARNING_1("Position %1 does not exists!", _taskPosition);
        [0, 0, 0]
    };
    _object
};

if (_taskPosition isEqualType []) exitWith {_taskPosition};

// Somehow neither "" nor [], just abort with warning
WARNING_2("Position %1 and/or marker %2 is invalid.", str _taskPosition, str _taskMarker);
objNull
