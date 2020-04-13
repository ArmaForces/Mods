#include "script_component.hpp"

if (isServer) then {
    {
        [_x, GVAR(tasks) getVariable _x] call FUNC(createTask);
    } forEach (allVariables GVAR(tasks));
};
