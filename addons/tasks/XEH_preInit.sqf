#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(tasks) = call CBA_fnc_createNamespace;

if (isServer) then {
    // Load tasks from config
    {
        private _taskConfigName = configName _x;
        private _taskNamespace = [_x] call EFUNC(common,readConfigToNamespace);
        GVAR(tasks) setVariable [_taskConfigName, _taskNamespace];
    } forEach ("true" configClasses (missionConfigFile >> "CfgTasks"));

    {
        [_x, GVAR(tasks) getVariable _x] call FUNC(createTask);
    } forEach (allVariables GVAR(tasks));
};

ADDON = true;
