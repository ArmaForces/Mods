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

params ["_taskPosition", "_taskObject", "_taskMarker"];

if (_taskPosition isEqualTo [] && {_taskObject isEqualTo objNull && {_taskMarker isEqualTo ""}}) exitWith {objNull};

private _destination = objNull;

if (!(_taskMarker isEqualTo "")) then {
    private _markerPos = getMarkerPos _taskMarker;
    if (!(_markerPos isEqualTo [0, 0, 0])) exitWith {_destination = _markerPos};
    WARNING_1("Marker %1 does not exist!", _taskMarker);
};

if (_destination isEqualTo objNull && {!(_taskObject isEqualTo objNull)}) then {
    private _object = missionNamespace getVariable [_taskObject, objNull];
    if (!(_object isEqualTo objNull)) exitWith {_destination = _object};
    WARNING_1("Object %1 does not exist!", _taskObject);
};

if (_destination isEqualTo objNull && {!(_taskPosition isEqualTo [])}) then {
    if (count _taskPosition isEqualTo 3) exitWith {_destination = _taskPosition};
    WARNING_1("Position %1 is invalid!", _taskPosition);
};

_destination
