#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function returns player "savegame"
 *
 * Arguments:
 * 0: Player UID <STRING>
 *
 * Return Value:
 * 0: "Savegame" <ARRAY>
 *  0: UID <STRING>
 *  1: Player loadout <ARRAY>
 *  2: Player vehicle <OBJECT>
 *  3: Destination <POSITION>
 *
 * Example:
 * [getPlayerUID player] call afm_back_to_game_fnc_getPlayerData
 *
 * Public: No
 */

params ["_uid"];

GVAR(disconnectedPlayers) select (GVAR(disconnectedPlayers) findIf {_uid == (_x select 0)})
