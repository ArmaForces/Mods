#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function checks if given player should see spectator camera
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call afm_spectator_fnc_canSpectate
 *
 * Public: No
 */

params [["_player", player]];

// TODO: Check if is conscious (ACE or vanilla)
private _conscious = false;

!(alive player) || {!_conscious}
