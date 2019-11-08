#include "script_component.hpp"

[QGVAR(init), {
    call GVAR(init);
}] call CBA_fnc_addEventHandler;

[QGVAR(loop), {
    call GVAR(loop);
}] call CBA_fnc_addEventHandler;

[QGVAR(stop), {
    call GVAR(stop);
}] call CBA_fnc_addEventHandler;
