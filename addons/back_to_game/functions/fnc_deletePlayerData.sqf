#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function deletes player "savegame".
 *
 * Arguments:
 * 0: Player UID <STRING>
 *
 * Return Value:
 * 0: Old "savegame" <ARRAY>
 *  0: UID <STRING>
 *  1: Player loadout <ARRAY>
 *  2: Player vehicle <OBJECT>
 *  3: Destination <POSITION>
 *
 * Example:
 * [getPlayerUID player] call afm_back_to_game_fnc_deletePlayerData
 *
 * Public: No
 */

params ["_uid"];

GVAR(disconnectedPlayers) deleteAt (GVAR(disconnectedPlayers) findIf {_uid == (_x select 0)});
