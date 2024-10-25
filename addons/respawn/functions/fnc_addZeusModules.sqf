#include "script_component.hpp"
/*
 * Author: veteran29
 * Adds custom modules to Zeus via Zeus Enhanced framework.
 *
 * Public: No
 */

if (isNil "zen_custom_modules_fnc_register" || !isMultiplayer) exitWith {};

LOG("Adding ZEN modules");

[ELSTRING(Main,Category), "Respawn side", {
    [
        "Respawn side",
        [
            [
                "SIDES",
                "Sides to respawn",
                [],
                false
            ]
        ],
        {
            params ["_dialogValues"];
            _dialogValues params ["_sides"];
            TRACE_1("",_dialogValues);

            private _players = allPlayers select {side group _x in _sides && !alive _x};

            format ["Respawning %1 players", count _players] call CBA_fnc_notify;
            [QGVAR(force), nil, _players] call CBA_fnc_targetEvent;
        }
    ] call zen_dialog_fnc_create;
}, getText (configFile >> "CfgVehicles" >> QGVAR(moduleRespawn) >> "portrait")] call zen_custom_modules_fnc_register;

[ELSTRING(Main,Category), "Respawn player", {
    private _deadPlayers = allPlayers select {!alive _x};
    private _deadPlayersNames = _deadPlayers apply {format ["%1 (%2)", name _x, side group _x]};
    [
        "Respawn player",
        [
            [
                "LIST",
                "Dead players:",
                [
                    _deadPlayers,
                    _deadPlayersNames,
                    0,
                    10
                ],
                true
            ]
        ],
        {
            params ["_dialogValues", "_deadPlayers"];
            _dialogValues params ["_selected"];
            TRACE_1("",_dialogValues);

            format ["Respawning %1", name _selected] call CBA_fnc_notify;

            [QGVAR(force), nil, _selected] call CBA_fnc_targetEvent;
        },
        {},
        _deadPlayers
    ] call zen_dialog_fnc_create;
}, getText (configFile >> "CfgVehicles" >> QGVAR(moduleRespawn) >> "portrait")] call zen_custom_modules_fnc_register;
