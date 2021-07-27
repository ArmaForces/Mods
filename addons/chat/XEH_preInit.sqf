#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    missionNamespace setVariable [QGVAR(blockedChannels), [], true];
};

if (hasInterface) then {
    addMissionEventHandler ["HandleChatMessage", LINKFUNC(handleChat)];

    ["chat", {
        private _level = parseNumber (_this select 0);

        GVAR(blockedChannels) = switch (_level) do {
            case 2: {[]};
            case 1: {[CHANNEL_GLOBAL]};
            case 0: {[CHANNEL_GLOBAL, CHANNEL_SIDE]};
        };

        [{
            systemChat format ["Blocked channels - %1", GVAR(blockedChannels)];
        }] call CBA_fnc_execNextFrame;

    }, "adminLogged"] call CBA_fnc_registerChatCommand;
};

ADDON = true;
