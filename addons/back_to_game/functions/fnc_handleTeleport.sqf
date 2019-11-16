#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function teleports player back to his position before he disconnected and restores his loadout.
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 * 1: "Savegame" <ARRAY>
 *  0: Player loadout <ARRAY>
 *  1: Player vehicle <OBJECT>
 *  2: Destination <POSITION>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [getPlayerUID player, getUnitLoadout player, vehicle player, getPos player]] call afm_back_to_game_fnc_handleTeleport
 *
 * Public: No
 */

params ["_unit", "_save"];

if !(local _unit) exitWith {
    [QGVAR(handleTeleport), _this, _unit] call CBA_fnc_targetEvent;
};

// Create telport dialog and wait for it to be closed
createDialog QGVAR(teleportDialog);
[{isNull findDisplay 11}, {
    if (GVAR(teleport)) then {
        // Prepare to teleportation
        player allowDamage false;
        [{player allowDamage true}, [], 5] call CBA_fnc_waitAndExecute;
        player playAction "PlayerProne";
        player setUnitLoadout (_this select 1);

        [QGVAR(teleportPlayer), _this] call CBA_fnc_localEvent;
    };
}, _save] call CBA_fnc_waitUntilAndExecute;
