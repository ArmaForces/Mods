#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function enables respawn for local player.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call afm_respawn_fnc_enable
 *
 * Public: No
 */

// Restart counter where it stopped
setPlayerRespawnTime (GVAR(respawnTime) - GVAR(respawnTimeElapsed) max TIME_MINIMUM);
