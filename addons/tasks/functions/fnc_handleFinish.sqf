#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles completing task.
 * Prepares conditions/events required to complete task.
 *
 * Arguments:
 * 0: Task namespace <CBA_NAMESPACE>
 * 1: Task finish type "Success"/"Failed"/"Canceled" <STRING>
 * 2: Callback function "handleOnXXX" <CODE>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_taskNamespace", "_finishType", "_callbackFunction"];

// Load code condition
private _conditionCodeSuccessValue = _taskNamespace getVariable [format ["conditionCode%1", _finishType], "true"];
private _conditionCodeSuccess = compile _conditionCodeSuccessValue;
private _conditionCodeEmpty = (_conditionCodeSuccessValue isEqualTo "true" || {_conditionCodeSuccessValue isEqualTo ""});

// Load event condition
private _conditionEventsSuccess = _taskNamespace getVariable [format ["conditionEvents%1", _finishType], []];
private _conditionEventsEmpty = _conditionEventsSuccess isEqualTo [];

switch (true) do {
    // No event specified and no code condition
    case (_conditionEventsEmpty && {_conditionCodeEmpty}): {
        // Do nothing
    };

    // No event specified and code condition is given
    case (_conditionEventsEmpty && {!_conditionCodeEmpty}): {
        // Wait until code condition is true
        [_conditionCodeSuccess, {
            params ["_taskNamespace", "_callbackFunction"];
            [_taskNamespace] call _callbackFunction;
        }, [_taskNamespace, _callbackFunction]] call CBA_fnc_waitUntilAndExecute;
    };

    // Events is specified and conditionCode is not filled
    case (!_conditionEventsEmpty && {_conditionCodeEmpty}): {
        // Create EventHandler for all events
        {
            [_x, {
                _thisArgs params ["_taskNamespace", "_callbackFunction"];
                [_taskNamespace] call _callbackFunction;
                // Remove EH so it can be triggered only once for given task.
                [_thisType, _thisId] call CBA_fnc_removeEventsHandler;
            }, [_taskNamespace, _callbackFunction]] call CBA_fnc_addEventsHandlerArgs;
        } forEach _conditionEventsSuccess;
    };

    // Events is specified and conditionCode is filled
    default {
        // Wait until code condition is true
        [_conditionCodeSuccess, {
            params ["_taskNamespace", "_callbackFunction"];
            [_taskNamespace] call _callbackFunction;
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

        // Create EventHandler for all events
        {
            [_x, {
                _thisArgs params ["_taskNamespace", "_callbackFunction"];
                // Remove EH so it can be triggered only once for given task.
                [_thisType, _thisId] call CBA_fnc_removeEventsHandler;
            }, _taskNamespace] call CBA_fnc_addEventsHandlerArgs;
        } forEach _conditionEventsSuccess;
    };
};

nil
