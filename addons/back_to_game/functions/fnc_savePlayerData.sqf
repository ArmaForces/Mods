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
 * None
 *
 * Example:
 * [player, getPlayerUID player] call afm_back_to_game_fnc_savePlayerData
 *
 * Public: No
 */

params ["_unit", "_uid"];

// Save player's loadout, vehicle and position
private _loadout = getUnitLoadout _unit;
private _pos = getPosATL _unit;
private _handlerData = GVAR(saveHandlers) apply {[_x select 1, _unit call (_x select 0)]};

// filter ACRE2 radios
if (EGVAR(common,acre)) then {
    _loadout = [_loadout] call acre_api_fnc_filterUnitLoadout;
};

GVAR(disconnectedPlayers) set [_uid, [_loadout, group _unit, vehicle _unit, _pos, _handlerData]];

INFO_2("%1 UID: %2 disconnected, saved data.",name _unit,_uid);

nil
