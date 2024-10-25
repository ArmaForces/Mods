#include "script_component.hpp"
/*
 * Author: veteran29
 * Adds custom modules to Zeus via Zeus Enhanced framework.
 *
 * Public: No
 */

if (isNil "zen_custom_modules_fnc_register" || !isMultiplayer) exitWith {};

LOG("Adding ZEN modules");

private _iconRespawn = getText (configFile >> "CfgVehicles" >> QGVAR(moduleRespawn) >> "portrait");

[ELSTRING(Main,Category), LSTRING(ModuleRespawn_ZEN_Sides_DisplayName), {
    [
        LSTRING(ModuleRespawn_ZEN_Sides_DisplayName),
        [
            [
                "SIDES",
                LSTRING(ModuleRespawn_ZEN_Sides_AttributeSides_DisplayName),
                [],
                false
            ]
        ],
        {
            params ["_dialogValues"];
            _dialogValues params ["_sides"];
            TRACE_1("",_dialogValues);

            private _players = allPlayers select {side group _x in _sides && !alive _x};

            format [LLSTRING(ModuleRespawn_Notification_RespawningMany), count _players] call CBA_fnc_notify;
            [QGVAR(force), nil, _players] call CBA_fnc_targetEvent;
        }
    ] call zen_dialog_fnc_create;
}, _iconRespawn] call zen_custom_modules_fnc_register;

[ELSTRING(Main,Category), LSTRING(ModuleRespawn_ZEN_Player_DisplayName), {
    private _deadPlayers = allPlayers select {!alive _x};
    private _deadPlayersNames = _deadPlayers apply {format ["%1 (%2)", name _x, side group _x]};

    if (_deadPlayers isEqualTo []) exitWith {
        [objNull, LLSTRING(ModuleRespawn_Notification_NoDead)] call BIS_fnc_showCuratorFeedbackMessage;
    };

    [
        LSTRING(ModuleRespawn_ZEN_Player_DisplayName),
        [
            [
                "LIST",
                LSTRING(ModuleRespawn_ZEN_Player_AttributeDead_DisplayName),
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

            format [LLSTRING(ModuleRespawn_Notification_RespawningSingle), name _selected] call CBA_fnc_notify;

            [QGVAR(force), nil, _selected] call CBA_fnc_targetEvent;
        },
        {},
        _deadPlayers
    ] call zen_dialog_fnc_create;
}, _iconRespawn] call zen_custom_modules_fnc_register;
