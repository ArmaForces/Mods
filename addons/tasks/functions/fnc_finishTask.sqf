#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function finishes given task and runs appropriate onFinished handler.
 *
 * Arguments:
 * 0: Task to finish <CBA_NAMESPACE/STRING>
 * 1: Finish type ("Success"/"Failed"/"Canceled" default "Success") <STRING>
 * 2: Force new task state? (default false) <BOOL>
 *
 * Return Value:
 * 0: Is task successfully finished? <BOOL>
 *
 * Example:
 * ["KnockHorse", "Canceled"] call afm_tasks_fnc_finishTask
 *
 * Public: Yes
 */

params ["_taskNamespace", ["_finishType", "Success"], ["_force", false]];

if (_taskNamespace isEqualType "") then {
    _taskNamespace = GVAR(tasks) getVariable [_taskNamespace, objNull];
};

if (isNull _taskNamespace) exitWith {
    WARNING("No task specified!");
    false
};

[_taskNamespace, _finishType, _force] call FUNC(handleOnFinished);
true
