#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function disables respawn for local player.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call afm_respawn_fnc_disable
 *
 * Public: No
 */

// Save current elapsed time for possible further respawn restart
GVAR(timeElapsed) = playerRespawnTime;

setPlayerRespawnTime TIME_DISABLED;
