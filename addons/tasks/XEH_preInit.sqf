#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

if (isServer) then {
    // Load tasks from config
    {
        [_x] call FUNC(createTaskFromConfig);
    } forEach ("true" configClasses (missionConfigFile >> "CfgTasks"));
};

ADDON = true;
