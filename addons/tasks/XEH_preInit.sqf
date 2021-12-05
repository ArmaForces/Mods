#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {

    GVAR(tasks) = createHashMap;
    GVAR(tasksArray) = [];

    private _cfgTasks = missionConfigFile >> "CfgTasks";
    private _tag = getTextRaw (_cfgTasks >> "tag");

    // Load tasks from config
    {
        private _taskConfigName = configName _x;
        private _taskNamespace = [_x] call EFUNC(common,readConfigToNamespace);
        _taskNamespace setVariable ["taskConfigName", _taskConfigName];
        _taskNamespace setVariable ["taskGlobalTag", _tag];

        GVAR(tasks) set [_taskConfigName, _taskNamespace];
        GVAR(tasksArray) pushBack _taskNamespace;
    } forEach ("true" configClasses _cfgTasks);
};

ADDON = true;
