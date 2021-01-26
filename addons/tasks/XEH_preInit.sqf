#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {

    GVAR(tasks) = call CBA_fnc_createNamespace;
    GVAR(tasksArray) = [];

    // Load tasks from config
    {
        private _taskConfigName = configName _x;
        private _taskNamespace = [_x] call EFUNC(common,readConfigToNamespace);
        _taskNamespace setVariable ["taskConfigName", _taskConfigName];

        GVAR(tasks) setVariable [_taskConfigName, _taskNamespace];
        GVAR(tasksArray) pushBack _taskNamespace;
    } forEach ("true" configClasses (missionConfigFile >> "CfgTasks"));
};

ADDON = true;
