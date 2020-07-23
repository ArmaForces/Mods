#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function shows teleport confirmation dialog to player
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

GVAR(savegameData) = _save;

[{!isNull(findDisplay 46)}, {
    createDialog QGVAR(teleportDialog);
}] call CBA_fnc_waitUntilAndExecute;

nil
