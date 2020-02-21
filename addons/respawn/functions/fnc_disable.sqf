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

GVAR(respawnTimeElapsed) = playerRespawnTime;
setPlayerRespawnTime TIME_DISABLED;
