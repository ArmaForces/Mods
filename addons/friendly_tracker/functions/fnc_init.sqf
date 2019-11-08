#include "script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
 * Handles initialization of BFT loop
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call afm_friendly_tracker_fnc_init
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

if (isNil(QGVAR(running))) then {GVAR(running) = false};

[{!GVAR(running)}, {
	GVAR(running) = true;

	LOG("Starting FriendlyTracker");

	GVAR(markers) = [];

    [QGVAR(loop)] call CBA_fnc_localEvent;
}, [], GVAR(refreshRate) + 1, {}] call CBA_fnc_waitUntilAndExecute;
