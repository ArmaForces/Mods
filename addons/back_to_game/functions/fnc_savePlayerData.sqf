#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function saves player "savegame"
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 * 1: Player UID <STRING>
 *
 * Return Value:
 * Savegame ID <NUMBER>
 *
 * Example:
 * [player, getPlayerUID player] call afm_back_to_game_fnc_savePlayerData
 *
 * Public: No
 */

params ["_unit", "_uid"];

// Delete saved info for player in case he could disconnected before
GVAR(disconnectedPlayers) deleteAt (GVAR(disconnectedPlayers) findIf {_uid == (_x select 0)});

// Save player's loadout, vehicle and position
private _loadout = getUnitLoadout _unit;
private _pos = getposATL _unit;
GVAR(disconnectedPlayers) pushBack [_uid, _loadout, vehicle _unit, _pos];
