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

// Load success code condition
private _conditionCodeSuccessValue = _taskNamespace getVariable ["conditionCodeSuccess", "true"];
private _conditionCodeSuccess = compile _conditionCodeSuccessValue;

// Load success event condition
private _conditionEventSuccess = _taskNamespace getVariable ["conditionEventSuccess", ""];

switch (true) do {
    // No event specified
    case (_conditionEventSuccess isEqualTo ""): {
        // Wait until code condition is true
        [_conditionCodeSuccess, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnSuccess);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;
    };

    // Event is specified and conditionCode is not filled
    case (!(_conditionEventSuccess isEqualTo "") && {_conditionCodeSuccessValue isEqualTo "true"}): {
        // Create EventHandler
        [_conditionEventSuccess, {
            private _taskNamespace = _thisArgs;
            [_taskNamespace] call FUNC(handleOnSuccess);
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        }, _taskNamespace] call CBA_fnc_addEventHandlerArgs;
    };

    // Event is specified and conditionCode is filled
    default {
        // Wait until code condition is true
        [_conditionCodeSuccess, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnSuccess);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

        // Create EventHandler
        [_conditionEventSuccess, {
            private _taskNamespace = _thisArgs;
            [_taskNamespace] call FUNC(handleOnSuccess);
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        }, _taskNamespace] call CBA_fnc_addEventHandlerArgs;
    };
};

nil
