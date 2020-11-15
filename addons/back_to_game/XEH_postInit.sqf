#include "script_component.hpp"

[QGVAR(handleConnected), {_this call FUNC(handleConnected)}] call CBA_fnc_addEventHandler;
[QGVAR(handleTeleport), {_this call FUNC(handleTeleport)}] call CBA_fnc_addEventHandler;
[QGVAR(teleportPlayer), {_this call FUNC(teleportPlayer)}] call CBA_fnc_addEventHandler;

if (isServer) then {
    addMissionEventHandler ["HandleDisconnect", {
        params ["_unit", "_id", "_uid", "_name"];
        if !GVAR(enableAddon) exitWith {};
        [_unit, _uid] call FUNC(handleDisconnected);
        // To prevent AI transfer to server
        false
    }];
};

if (hasInterface) then {
    [{
        if !GVAR(enableAddon) exitWith {};
        [QGVAR(handleConnected), [player, getPlayerUID player]] call CBA_fnc_serverEvent;
    }] call EFUNC(common,runAfterSettingsInit);
};
