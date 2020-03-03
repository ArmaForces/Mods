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
private _conditionEventsShow = _taskNamespace getVariable ["conditionEventsShow", ""];
private _conditionEventsEmpty = _conditionEventsShow isEqualTo "";

switch (true) do {
    // No event specified and no code condition
    case (_conditionEventsEmpty && {_conditionCodeEmpty}): {
        // Create true WUAE (will always show task)
        [{true}, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnShow);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;
    };

    // No event specified and code condition is given
    case (_conditionEventsEmpty && {!_conditionCodeEmpty}): {
        // Wait until code condition is true
        [_conditionCodeShow, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnShow);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;
    };

    // Events is specified and conditionCode is not filled
    case (!_conditionEventsEmpty && {_conditionCodeEmpty}): {
        // Create EventHandler for all events
        {
            [_x, {
                private _taskNamespace = _thisArgs;
                [_taskNamespace] call FUNC(handleOnShow);
                // Remove EH so it can be triggered only once for given task.
                [_thisType, _thisId] call CBA_fnc_removeEventsHandler;
            }, _taskNamespace] call CBA_fnc_addEventsHandlerArgs;
        } forEach _conditionEventsShow;
    };

    // Events is specified and conditionCode is filled
    default {
        // Wait until code condition is true
        [_conditionCodeShow, {
            private _taskNamespace = _this;
            [_taskNamespace] call FUNC(handleOnShow);
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

        // Create EventHandler for all events
        {
            [_x, {
                private _taskNamespace = _thisArgs;
                [_taskNamespace] call FUNC(handleOnShow);
                // Remove EH so it can be triggered only once for given task.
                [_thisType, _thisId] call CBA_fnc_removeEventsHandler;
            }, _taskNamespace] call CBA_fnc_addEventsHandlerArgs;
        } forEach _conditionEventsShow;
    };
};

nil
