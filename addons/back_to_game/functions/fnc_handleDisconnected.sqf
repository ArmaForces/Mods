#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles Disconnected event.
 * Saves player data and removes his body if he was alive.
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 * 1: Player UID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, getPlayerUID player] call afm_back_to_game_fnc_handleDisconnected
 *
 * Public: No
 */

params ["_unit", "_uid"];

if (!isServer && {hasInterface}) exitWith {
    [QGVAR(handleDisconnected), _this] call CBA_fnc_serverEvent;

    nil
};

[_unit, _uid] call FUNC(savePlayerData);

if (GVAR(removeBody) && {alive _unit}) then {
    INFO_1("Removing body of %1",name _unit);
    deleteVehicle _unit;
};

nil
