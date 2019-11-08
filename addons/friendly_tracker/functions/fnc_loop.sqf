#include "script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
 * BFT loop
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call afm_friendly_tracker_fnc_loop
 *
 * Public: No
 */

// Check if BFT is disabled
if (!GVAR(enabled)) exitWith {
    [QGVAR(stop)] call CBA_fnc_localEvent;
};

// Remove all markers
{
    deleteMarkerLocal (_x select 0);
} foreach GVAR(markers);

private _playerSide = side player;

// If GPS mode is enabled and player (local) does not have GPS/UAV terminal we break and schedule next loop
if (GVAR(GPS) && {![player] call FUNC(hasTracker)}) exitWith {
    [FUNC(loop), [], GVAR(refreshRate)] call CBA_fnc_waitAndExecute;
};

// Create marker for every player in game
{
    if (side _x isEqualTo _playerSide) then {
        // If GPS mode is enabled and player does not have GPS/UAV terminal we skip him and go to the next one
        if (GVAR(GPS) && {![player] call FUNC(hasTracker)}) exitWith {};

        private _isPlayerGroup = group _x isEqualTo group player;
        private _marker = format["player_%1", getPlayerUID _x];
        createMarkerLocal [_marker, getPos _x];
        _marker setMarkerTypeLocal "mil_dot";
        GVAR(markers) pushBack [_marker, _x];
        // Check if player is not in vehicle
        if (isNull objectParent _x) then {
            _marker setMarkerSizeLocal [0.5, 0.5];
        } else {
            _marker setMarkerSizeLocal [0.75, 0.75];
        };
        // Determine marker color
        switch (true) do {
            // Player (local) is yellow
            case (_x isEqualTo player): {
                _marker setMarkerColorLocal "ColorYellow";
            };
            // If enabled, unconscious are orange
            case (GVAR(showUnconc) && (_x getVariable ["ACE_isUnconscious", false]) && {_isPlayerGroup || {GVAR(showAllGroups)}}): {
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
    };
} foreach AllPlayers;

// Schedule next loop
[FUNC(loop), [], GVAR(refreshRate)] call CBA_fnc_waitAndExecute;
