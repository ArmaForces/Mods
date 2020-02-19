#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(start), {
        _this call FUNC(start);
    }] call CBA_fnc_addEventHandler;
};
