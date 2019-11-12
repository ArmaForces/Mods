#include "script_component.hpp"

[QGVAR(init), {
    call FUNC(init);
}] call CBA_fnc_addEventHandler;

[QGVAR(loop), {
    call FUNC(loop);
}] call CBA_fnc_addEventHandler;

[QGVAR(stop), {
    call FUNC(stop);
}] call CBA_fnc_addEventHandler;
