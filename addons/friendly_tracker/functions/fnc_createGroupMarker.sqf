#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function creates BFT marker on group's position
 *
 * Arguments:
 * 0: Group to create marker for <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [group bob] call afm_friendly_tracker_fnc_createGroupMarker
 *
 * Public: No
 */

params ["_group"];

// Standard marker creation
private _groupName = groupId _group;
private _marker = format["group", _groupName];
createMarkerLocal [_marker, getPos leader _group];
_marker setMarkerTypeLocal ([_group] call FUNC(getGroupMarkerType));
_marker setMarkerSizeLocal [0.75, 0.75];
_marker setMarkerTextLocal _groupName;
GVAR(markers) pushBack [_marker, _group];

private _isPlayerGroup = _group isEqualTo group player;
// Determine marker color
switch (true) do {
    // Player's group is marked green
    case (_isPlayerGroup): {
        _marker setMarkerColorLocal "ColorGreen";
    };
    // Other groups are blue
    case (GVAR(showAllGroups)): {
        _marker setMarkerColorLocal "ColorWEST";
    };
    // Remove if no rule matched
    default {
        deleteMarkerLocal _marker;
    };
};
