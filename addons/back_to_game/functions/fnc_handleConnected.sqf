#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function checks if player has disconnected before and allows him to teleport back
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 * 1: Player UID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, getPlayerUID player] call afm_back_to_game_fnc_handleConnected
 *
 * Public: No
 */

params ["_unit", "_uid"];

if (!isServer && {hasInterface}) exitWith {
    [QGVAR(handleConnected), _this] call CBA_fnc_serverEvent;

    nil
};

if ([_uid] call FUNC(hasDisconnected)) exitWith {
    INFO_1("%1 has disconnected previously, loading saved data.",name _unit);
    private _save = [_uid] call FUNC(getPlayerData);
    [QGVAR(handleTeleport), [_unit, _save], _unit] call CBA_fnc_targetEvent;

    nil
};

nil
