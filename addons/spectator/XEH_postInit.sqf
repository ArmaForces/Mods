#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(start), {
        _this call FUNC(start);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(stop), {
        _this call FUNC(stop);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(reloadLocal), {
        _this call FUNC(reloadLocal);
    }] call CBA_fnc_addEventHandler;

    // State change event handlers to detect dying, respawning  and unconscious state change
    player addEventHandler ["Killed", {
        if (!GVAR(enabled)) exitWith {};
        WARNING("Player killed!");
        [QGVAR(start)] call CBA_fnc_localEvent;
    }];

    player addEventHandler ["Respawn", {
        if (!GVAR(enabled)) exitWith {};
        WARNING("Player respawned!");
        [QGVAR(stop)] call CBA_fnc_localEvent;
    }];

    if (EGVAR(common,aceMedical)) then {
        ["ace_unconscious", {
            params ["_unit", "_active"];
            if (!GVAR(enabled) || {!(_unit isEqualTo player)}) exitWith {};
            if (_active) then {
                [{!([player] call FUNC(canSpectate))}, {
                    // Do nothing as player can no longer be spectator, probably he's not unconscious anymore
                }, [], GVAR(unconsciousDelay), {
                    WARNING("Player unconscious!");
                    [QGVAR(start)] call CBA_fnc_localEvent;
                    // Disable ACE's disable user input
                    ["unconscious", false] call ACEFUNC(common,setDisableUserInputStatus);
                }] call CBA_fnc_waitUntilAndExecute;
            } else {
                if (!alive _unit) exitWith {
                    // Player died, we need to reload his spectator for new params
                    [QGVAR(reloadLocal)] call CBA_fnc_localEvent;
                };
                WARNING("Player no longer unconscious!");
                [QGVAR(stop)] call CBA_fnc_localEvent;
            };
        }] call CBA_fnc_addEventHandler;
    } else {
        // TODO: Handle vanilla unconscious state change
    };
};
