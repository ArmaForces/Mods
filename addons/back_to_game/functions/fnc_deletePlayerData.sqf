#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function deletes player "savegame".
 *
 * Arguments:
 * 0: Player UID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [getPlayerUID player] call afm_back_to_game_fnc_deletePlayerData
 *
 * Public: No
 */

params ["_uid"];

GVAR(disconnectedPlayers) deleteAt _uid;
INFO_1("Deleted data for %1 UID.",_uid);

nil
