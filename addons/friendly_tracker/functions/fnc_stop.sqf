#include "script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
 * Handles termination of BFT
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: Success <BOOL>
 *
 * Example:
 * [] call afm_friendly_tracker_fnc_stop
 *
 * Public: No
 */

if (!GVAR(running)) exitWith {false};

LOG("Stopping FriendlyTracker");

// Remove all markers
{
    deleteMarkerLocal (_x select 0);
} foreach GVAR(markers);

GVAR(running) = false;

true
