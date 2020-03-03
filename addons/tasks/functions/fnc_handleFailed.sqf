#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles failing task.
 * Prepares conditions/events required to fail task.
 *
 * Arguments:
 * 0: Task namespace <CBA_NAMESPACE>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_taskNamespace"];

// Load failed condition
private _conditionCodeFailed = compile (_taskNamespace getVariable ["conditionCodeFailed", "true"]);

[_conditionCodeFailed, {
        private _taskNamespace = _this;
        [_taskNamespace] call FUNC(handleOnFailed);
}, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

// Load failed event condition
private _conditionEventFailed = _taskNamespace getVariable ["conditionEventFailed", ""];

// No events specified
if (_conditionEventFailed isEqualTo "") exitWith {nil};

[_conditionEventFailed, {
    private _taskNamespace = _thisArgs;
    [_taskNamespace] call FUNC(handleOnFailed);
    // Remove EH so it can be triggered only once for given task.
    [_thisType, _thisId] call CBA_fnc_removeEventHandler;
}, _taskNamespace] call CBA_fnc_addEventHandlerArgs;

nil
