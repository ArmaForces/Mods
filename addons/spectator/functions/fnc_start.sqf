#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function starts spectator for given player
 *
 * Arguments:
 * 0: player unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call afm_spectator_fnc_start
 *
 * Public: No
 */

params [["_player", player]];

if (!(local _player)) exitWith {[QGVAR(start), _this, _player] call CBA_fnc_targetEvent};

// Determine sides available for spectating
private _whitelistedSides = switch GVAR(sides) do {
    // Friendly sides spectator
    case 0: {player call BIS_fnc_friendlySides};
    // Player side spectator
    case 1: {[playerSide]};
    // All sides spectator
    case 2: {[WEST, INDEPENDENT, EAST]};
    default {player call BIS_fnc_friendlySides};
};

if (GVAR(civilianSide)) then {
    _whitelistedSides pushBack CIVILIAN;
};

// Start spectator
["Initialize", [player, _whitelistedSides, GVAR(allowAI), true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
