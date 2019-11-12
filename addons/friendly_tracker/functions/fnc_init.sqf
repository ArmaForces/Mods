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

if (!hasInterface || {GVAR(running)}) exitWith {};

LOG("Starting FriendlyTracker");

GVAR(running) = true;

[QGVAR(loop)] call CBA_fnc_localEvent;

nil
