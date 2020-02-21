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

if (playerRespawnTime isEqualTo -1) exitWith {};

setPlayerRespawnTime (_newTime - playerRespawnTime max TIME_MINIMUM);
