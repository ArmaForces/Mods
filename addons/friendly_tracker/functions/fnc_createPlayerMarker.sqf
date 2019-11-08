#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function creates BFT marker on unit's position
 *
 * Arguments:
 * 0: Unit to create marker for <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call afm_friendly_tracker_fnc_createPlayerMarker
 *
 * Public: No
 */

params ["_unit"];

// Standard marker creation
private _marker = format["player_%1", getPlayerUID _unit];
createMarkerLocal [_marker, getPos _unit];
_marker setMarkerTypeLocal "mil_dot";
_marker setMarkerSizeLocal [0.5, 0.5];
GVAR(markers) pushBack [_marker, _unit];

private _isPlayerGroup = group _unit isEqualTo group player;
// Determine marker color
switch (true) do {
    // Player (local) is yellow
    case (_unit isEqualTo player): {
        _marker setMarkerColorLocal "ColorYellow";
    };
    // If enabled, unconscious are orange
    case (GVAR(showUnconc) && (_unit getVariable ["ACE_isUnconscious", false]) && {_isPlayerGroup || {GVAR(showAllGroups)}}): {
        _marker setmarkercolorlocal "ColorOrange";
    };
    // Player's group is marked green
    case (_isPlayerGroup): {
        _marker setMarkerColorLocal "ColorGreen";
    };
    // Other players are blue
    case (GVAR(showAllGroups)): {
        _marker setMarkerColorLocal "ColorWEST";
    };
    // Remove if no rule matched
    default {
        deleteMarkerLocal _marker;
    };
};
