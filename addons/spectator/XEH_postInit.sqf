#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(start), {
        _this call FUNC(start);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(stop), {
        _this call FUNC(stop);
    }] call CBA_fnc_addEventHandler;

    // State change event handlers to detect dying, respawning  and unconscious state change
    player addEventHandler ["Killed", {
        if (!GVAR(enabled)) exitWith {};
        [QGVAR(start)] call CBA_fnc_localEvent;
    }];

    player addEventHandler ["Respawn", {
        if (!GVAR(enabled)) exitWith {};
        [QGVAR(stop)] call CBA_fnc_localEvent;
    }];

    if (EGVAR(common,aceMedical)) then {
        ["ace_unconscious", {
            params ["_unit", "_active"];
            if (!(local _unit)) exitWith {};
            if (_active) then {
                [QGVAR(start)] call CBA_fnc_localEvent;
            } else {
                [QGVAR(stop)] call CBA_fnc_localEvent;
            };
        }] call CBA_fnc_addEventHandler;
    } else {
        // TODO: Handle vanilla unconscious state change
    };
};
