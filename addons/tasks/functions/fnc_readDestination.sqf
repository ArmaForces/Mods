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
 * Public: No
 */

params ["_taskPosition", "_taskObject", "_taskMarker"];

if (_taskPosition isEqualTo [] && {_taskObject isEqualTo "" && {_taskMarker isEqualTo ""}}) exitWith {objNull};

private _destination = objNull;

if (_taskMarker isNotEqualTo "") then {
    private _markerPos = getMarkerPos _taskMarker;
    if (_markerPos isNotEqualTo [0, 0, 0]) exitWith {_destination = _markerPos};
    WARNING_1("Marker %1 does not exist!", _taskMarker);
};

// destination can contain an array, isNull can't be used
if (_destination isEqualTo objNull && {_taskObject isNotEqualTo ""}) then {
    private _object = missionNamespace getVariable [_taskObject, objNull];
    if (!isNull _object) exitWith {_destination = _object};
    WARNING_1("Object %1 does not exist!", _taskObject);
};

// destination can contain an array, isNull can't be used
if (_destination isEqualTo objNull && {_taskPosition isNotEqualTo []}) then {
    private _coordinatesCount = count _taskPosition;
    if (_coordinatesCount isEqualTo 3) exitWith {_destination = _taskPosition};
    if (_coordinatesCount isEqualTo 2) exitWith {_destination = _taskPosition; _destination pushBack 0};
    WARNING_1("Position %1 is invalid!", _taskPosition);
};

_destination
