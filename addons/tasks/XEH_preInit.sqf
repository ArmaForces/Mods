#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(tasks) = call CBA_fnc_createNamespace;

if (isServer) then {
    // Load tasks from config
    {
        [_x] call FUNC(createTaskFromConfig);
    } forEach ("true" configClasses (missionConfigFile >> "CfgTasks"));
};

ADDON = true;
