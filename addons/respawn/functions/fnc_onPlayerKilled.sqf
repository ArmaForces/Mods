#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles onPlayerKilled event.
 *
 * Arguments:
 * 0: Killed player <OBJECT>
 * 1: Killer <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, ted] call afm_respawn_fnc_onPlayerKilled
 *
 * Public: No
 */

params ["_oldUnit", "_killer"];

if (!GVAR(enabled)) exitWith {setPlayerRespawnTime TIME_DISABLED};

setPlayerRespawnTime GVAR(respawnTime);
