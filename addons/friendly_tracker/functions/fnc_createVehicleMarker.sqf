/*
 * Author: 3Mydlo3
 * Function creates BFT marker on vehicle's position
 *
 * Arguments:
 * 0: Vehicle to create marker for <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [car] call afm_friendly_tracker_fnc_createVehiclerMarker
 *
 * Public: No
 */

params ["_vehicle"];

// Create marker name for given vehicle
private _marker = format ["vehicle_%1", str _vehicle];

// Check if such marker exists already, if it does, exit
if !(getMarkerPos _marker isEqualTo [0, 0, 0]) exitWith {};

// Standard marker creation
createMarkerLocal [_marker, getPos _vehicle];
_marker setMarkerTypeLocal "mil_dot"; // Todo: use NATO markers maybe
_marker setMarkerSizeLocal [0.9, 0.9];
GVAR(markers) pushBack [_marker, _vehicle];

private _isPlayerGroup = group driver _vehicle isEqualTo group player || {group commander _vehicle isEqualTo group player};

// Determine marker color
switch (true) do {
    // Player's vehicle (local) is yellow
    case (_vehicle isEqualTo objectParent player): {
        _marker setMarkerColorLocal "ColorYellow";
    };
    // Player group's vehicle is marked green
    case (_isPlayerGroup): {
        _marker setMarkerColorLocal "ColorGreen";
    };
    // Destroyed vehicles are black
    case (!alive _vehicle): {
        _marker setMarkerColorLocal "ColorBlack";
        _marker setMarkerAlphaLocal 0.8;
    };
    // Empty vehicles are grey
    case (count crew _vehicle isEqualTo 0): {
        _marker setMarkerColorLocal "ColorBlack";
        _marker setMarkerAlphaLocal 0.5;
    };
    // Other vehicles are blue
    case (GVAR(showAllGroups)): {
        _marker setMarkerColorLocal "ColorWEST";
    };
    // Remove if no rule matched
    default {
        deleteMarkerLocal _marker;
    };
};
