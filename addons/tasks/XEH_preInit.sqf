#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(tasks) = call CBA_fnc_createNamespace;
GVAR(tasksArray) = [];

if (isServer) then {
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
