#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles completing task.
 * Prepares conditions/events required to complete task.
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

// Load success condition
private _conditionCodeSuccess = compile (_taskNamespace getVariable ["conditionCodeSuccess", "true"]);

[_conditionCodeSuccess, {
        private _taskNamespace = _this;
        [_taskNamespace] call FUNC(handleOnSuccess);
}, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

// Load success event condition
private _conditionEventSuccess = compile (_taskNamespace getVariable ["conditionCodeSuccess", ""]);

// No events specified
if (_conditionEventSuccess isEqualTo "") exitWith {nil};

[_conditionEventSuccess, {
    private _taskNamespace = _thisArgs;
    [_taskNamespace] call FUNC(handleOnSuccess);
    // Remove EH so it can be triggered only once for given task.
    [_thisType, _thisId] call CBA_fnc_removeEventHandler;
}, _taskNamespace] call CBA_fnc_addEventHandlerArgs;

nil
