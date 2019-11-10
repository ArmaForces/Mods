#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function returns apropriate marker for given vehicle.
 *
 * Arguments:
 * 0: Vehicle to find marker for <OBJECT>
 *
 * Return Value:
 * 0: Marker type <STRING>
 *
 * Example:
 * [vehicle bob] call afm_friendly_tracker_fnc_getVehicleMarkerType
 *
 * Public: No
 */

params ["_vehicle"];


// Use cached marker type if possible
private _type = _vehicle getVariable [QGVAR(markerType), ""];
if !(_type isEqualTo "") exitWith {_type};

private _side = side driver _vehicle;

private _prefix = ["b", "o", "n"] select ((["WEST", "EAST", "GUER"] find str _side) max 0);

switch (true) do {
    case (_vehicle isKindOf "Air"): {
        _type = ["plane", "air"] select (_vehicle isKindOf "Helicopter");
    };
    case (_vehicle isKindOf "Land"): {
        if (_vehicle isKindOf "Tank") exitWith {
            if (getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "transportSoldier") > 0) then {
                _type = "mech_inf";
            } else {
                _type = "armor";
            };
        };
        _type = "motor_inf";
    };
    case (_vehicle isKindOf "Ship"): {
        _type = "naval";
    };
    default {
        _type = "unknown";
    };
};

_type = format ["%1_%2", _prefix, _type];

_vehicle setVariable [QGVAR(markerType), _type];

_type
