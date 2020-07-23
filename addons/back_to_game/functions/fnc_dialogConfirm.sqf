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
player setUnitLoadout (GVAR(savegameData) select 0);

[QGVAR(teleportPlayer), GVAR(savegameData)] call CBA_fnc_localEvent;

nil
