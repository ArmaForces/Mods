#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function checks if player was disconnected and can be teleported back to game.
 *
 * Arguments:
 * 0: Player UID <STRING>
 *
 * Return Value:
 * Check result <BOOL>
 *
 * Example:
 * [getPlayerUID player] call afm_back_to_game_fnc_hasDisconnected
 *
 * Public: No
 */

params ["_uid"];

!isNil {[_uid] call FUNC(getPlayerData)}
