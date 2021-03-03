#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function shows given task and runs appropriate onShow handler.
 *
 * Arguments:
 * 0: Task to show <CBA_NAMESPACE/STRING>
 *
 * Return Value:
 * 0: Is task successfully showed? <BOOL>
 *
 * Example:
 * ["KnockHorse"] call afm_tasks_fnc_showTask
 *
 * Public: Yes
 */

params ["_taskNamespace"];

if (_taskNamespace isEqualType "") then {
    _taskNamespace = GVAR(tasks) getOrDefault [_taskNamespace, objNull];
};

if (isNull _taskNamespace) exitWith {
    WARNING("No task specified!");
    false
};

[_taskNamespace] call FUNC(handleOnShow);
true
