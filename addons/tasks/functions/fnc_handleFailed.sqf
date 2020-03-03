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

// Load failed code condition
private _conditionCodeFailedValue = _taskNamespace getVariable ["conditionCodeFailed", "true"];
private _conditionCodeFailed = compile _conditionCodeFailedValue;
private _conditionCodeEmpty = (_conditionCodeFailedValue isEqualTo "true" || {_conditionCodeFailedValue isEqualTo ""});

// Load failed event condition
private _conditionEventFailed = _taskNamespace getVariable ["conditionEventFailed", ""];
private _conditionEventEmpty = _conditionEventFailed isEqualTo "";

switch (true) do {
    // No event specified and no code condition
    case (_conditionEventEmpty && {_conditionCodeEmpty}): {
        // Do nothing
    };

    // No event specified and code condition is given
    case (_conditionEventEmpty && {!_conditionCodeEmpty}): {
        // Wait until code condition is true
        [_conditionCodeFailed, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnFailed);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;
    };

    // Event is specified and conditionCode is not filled
    case (!_conditionEventEmpty && {_conditionCodeEmpty}): {
        // Create EventHandler
        [_conditionEventFailed, {
            private _taskNamespace = _thisArgs;
            [_taskNamespace] call FUNC(handleOnFailed);
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        }, _taskNamespace] call CBA_fnc_addEventHandlerArgs;
    };

    // Event is specified and conditionCode is filled
    default {
        // Wait until code condition is true
        [_conditionCodeFailed, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnFailed);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

        // Create EventHandler
        [_conditionEventFailed, {
            private _taskNamespace = _thisArgs;
            [_taskNamespace] call FUNC(handleOnFailed);
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        }, _taskNamespace] call CBA_fnc_addEventHandlerArgs;
    };
};

nil
