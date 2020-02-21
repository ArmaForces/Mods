#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function adjusts new remaining respawn time with respect to current elapsed time.
 *
 * Arguments:
 * 0: New respawn time delay <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [30] call afm_respawn_fnc_adjustTimeLocal
 *
 * Public: No
 */

params ["_newTime"];

if (playerRespawnTime isEqualTo -1) exitWith {};

// Calculate current elapsed time and adjust new respawn time
private _elapsedTime = GVAR(oldTime) - playerRespawnTime;
setPlayerRespawnTime (_newTime - _elapsedTime max TIME_MINIMUM);

// Save for further adjustments
GVAR(oldTime) = _newTime;
