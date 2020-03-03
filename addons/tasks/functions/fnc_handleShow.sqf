#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles showing task.
 * Prepares conditions/events required to show task.
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

// Load show code condition
private _conditionCodeShowValue = _taskNamespace getVariable ["conditionCodeShow", "true"];
private _conditionCodeShow = compile _conditionCodeShowValue;
private _conditionCodeEmpty = (_conditionCodeShowValue isEqualTo "true" || {_conditionCodeShowValue isEqualTo ""});

// Load show event condition
private _conditionEventShow = _taskNamespace getVariable ["conditionEventShow", ""];
private _conditionEventEmpty = _conditionEventShow isEqualTo "";

switch (true) do {
    // No event specified and no code condition
    case (_conditionEventEmpty && {_conditionCodeEmpty}): {
        // Create true WUAE (will always show task)
        [{true}, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnShow);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;
    };

    // No event specified and code condition is given
    case (_conditionEventEmpty && {!_conditionCodeEmpty}): {
        // Wait until code condition is true
        [_conditionCodeShow, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnShow);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;
    };

    // Event is specified and conditionCode is not filled
    case (!_conditionEventEmpty && {_conditionCodeEmpty}): {
        // Create EventHandler
        [_conditionEventShow, {
            private _taskNamespace = _thisArgs;
            [_taskNamespace] call FUNC(handleOnShow);
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        }, _taskNamespace] call CBA_fnc_addEventHandlerArgs;
    };

    // Event is specified and conditionCode is filled
    default {
        // Wait until code condition is true
        [_conditionCodeShow, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnShow);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

        // Create EventHandler
        [_conditionEventShow, {
            private _taskNamespace = _thisArgs;
            [_taskNamespace] call FUNC(handleOnShow);
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        }, _taskNamespace] call CBA_fnc_addEventHandlerArgs;
    };
};

nil
