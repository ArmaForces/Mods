#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles onPlayerRespawn event.
 *
 * Arguments:
 * 0: New player unit <OBJECT>
 * 1: Old player unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, ted] call afm_respawn_fnc_onPlayerRespawn
 *
 * Public: No
 */

params ["_newUnit", "_oldUnit"];

// Restore starting loadout
_newUnit setUnitLoadout GVAR(savedEquipment);

// Reset time elapsed counter
GVAR(respawnTimeElapsed) = 0;
