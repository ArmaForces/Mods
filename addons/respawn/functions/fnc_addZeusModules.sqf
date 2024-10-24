#include "script_component.hpp"
/*
 * Author: veteran29
 * Adds custom modules to Zeus via Zeus Enhanced framework.
 *
 * Public: No
 */

if (isNil "zen_custom_modules_fnc_register") exitWith {};

LOG("Adding ZEN modules");

[ELSTRING(Main,Category), "Respawn players", {
    private _deadPlayers = allPlayers select {!alive _x};
    [
        "Respawn players",
        [
            ["OWNERS", "Who to respawn", [[], [], [], 0]]
        ],
        {
            (_this#0) params ["_selections"];
            _selections params ["_sides", "_groups", "_players"];

            _players = flatten [
                allPlayers select {side group _x in _sides},
                flatten (_groups apply {units _x}),
                _players
            ];
            _players = (_players arrayIntersect _players) select {isPlayer _x && !alive _x};

            INFO_1("Respawning players via Zeus: %1",_players);

            format ["Respawning %1 players", count _players] call CBA_fnc_notify;
            [QGVAR(force), nil, _players] call CBA_fnc_targetEvent;
        }
    ] call zen_dialog_fnc_create;
}, getText (configFile >> "CfgVehicles" >> QGVAR(moduleRespawn) >> "portrait")] call zen_custom_modules_fnc_register;
