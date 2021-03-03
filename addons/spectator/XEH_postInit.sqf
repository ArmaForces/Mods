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

        if (SPECTATOR_KILLED_DELAY > (missionNamespace getVariable [QEGVAR(respawn,time), 1e10])) exitWith {};

        [{
            [QGVAR(start)] call CBA_fnc_localEvent;
        }, [], SPECTATOR_KILLED_DELAY] call CBA_fnc_waitAndExecute;
    }];

    player addEventHandler ["Respawn", {
        if (!GVAR(enabled)) exitWith {};
        WARNING("Player respawned!");
        [QGVAR(stop)] call CBA_fnc_localEvent;
    }];

    if (EGVAR(common,aceMedical)) then {
        ["ace_unconscious", {
            params ["_unit", "_active"];
            if (!GVAR(enabled) || {_unit isNotEqualTo player}) exitWith {};
            if (_active) then {
                [{!([player] call FUNC(canSpectate))}, {
                    // Do nothing as player can no longer be spectator, probably he's not unconscious anymore
                    LOG("Unconscious canSpectate 'false'");
                }, [], GVAR(unconsciousDelay), {
                    WARNING("Player unconscious!");
                    [QGVAR(start)] call CBA_fnc_localEvent;
                    // Disable ACE's disable user input
                    ["unconscious", false] call ACEFUNC(common,setDisableUserInputStatus);
                }] call CBA_fnc_waitUntilAndExecute;

                GVAR(unconsciousKilledEH) = player addEventHandler ["Killed", {
                    LOG("Unconscious killed EH");
                    player removeEventHandler ["Killed", _thisEventHandler];
                    [QGVAR(reloadLocal)] call CBA_fnc_localEvent;
                }];
            } else {
                WARNING("Player no longer unconscious!");

                player removeEventHandler ["Killed", GVAR(unconsciousKilledEH)];

                // Wait for display init to prevent race condition (BI uses spawn to show the display :| )
                [{
                    !isNull (uiNamespace getVariable "RscEGSpectator_display");
                }, {
                    [QGVAR(stop)] call CBA_fnc_localEvent;
                }, [], 3] call CBA_fnc_waitUntilAndExecute;
            };
        }] call CBA_fnc_addEventHandler;
    } else {
        // TODO: Handle vanilla unconscious state change
    };
};
