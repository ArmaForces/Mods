#include "script_component.hpp"
/*
 * Author: veteran29
 * Adds back to game save/load handlers
 *
 * Arguments:
 * 0: Player saving callback, player object passed as _this, executed on server <CODE>
 * 1: Player loading callback, player object and data passed as _this, executed locally on player machine <CODE>
 *
 * Return Value:
 * Save handler id <NUMBER>
 *
 * Example:
 * [
 *     {_this getVariable ["ACE_hasEarPlugsIn", false]},
 *     {(_this select 0) setVariable ["ACE_hasEarPlugsIn", (_this select 1), true]}
 * ] call afm_back_to_game_fnc_addHandler
 *
 * Public: No
 */

if (!isServer) exitWith {-1};

params [
    ["_fnc_save", {}, [{}]],
    ["_fnc_load", {}, [{}]]
];

LOG_2("Adding new saveHandler - %1, %2",_fnc_save,_fnc_load);

GVAR(saveHandlers) pushBack [_fnc_save, _fnc_load] // return
