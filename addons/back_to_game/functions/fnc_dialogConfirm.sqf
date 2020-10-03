#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function prepares player for teleportation back to his position before he disconnected and restores his loadout.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call afm_back_to_game_fnc_dialogConfirm
 *
 * Public: No
 */

INFO("Teleportation confirmed!");

player allowDamage false;
[{player allowDamage true}, [], 5] call CBA_fnc_waitAndExecute;
player playAction "PlayerProne";
// wait for ACRE init if present
[{!EGVAR(common,acre) || {[] call acre_api_fnc_isInitialized}}, {
    player setUnitLoadout (GVAR(savegameData) select 0);
}] call CBA_fnc_waitUntilAndExecute;

private _oldGroup = GVAR(savegameData) select 1;
if ((group player isNotEqualTo _oldGroup) && {!isNull _oldGroup}) then {
    // Join player back to group
    [player] join _oldGroup;
};

// execute custom save handlers
{
    _x params ["_fnc_load", "_data"];
    [player, _data] call _fnc_load;
} forEach (GVAR(savegameData) select 4);

[QGVAR(teleportPlayer), GVAR(savegameData)] call CBA_fnc_localEvent;

nil
