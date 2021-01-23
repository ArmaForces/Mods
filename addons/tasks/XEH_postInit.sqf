#include "script_component.hpp"

if (isServer) then {
    {
        [_x getVariable "taskConfigName", _x] call FUNC(createTask);
    } forEach GVAR(tasksArray);

    GVAR(tasksArray) = nil;
};
