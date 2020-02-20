#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(start), {
        _this call FUNC(start);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(stop), {
        _this call FUNC(stop);
    }] call CBA_fnc_addEventHandler;

    player addEventHandler ["Killed", {
        if (!GVAR(enabled)) exitWith {};
        [QGVAR(start)] call CBA_fnc_localEvent;
    }];

    player addEventHandler ["Respawn", {
        if (!GVAR(enabled)) exitWith {};
        [QGVAR(stop)] call CBA_fnc_localEvent;
    }];
};
