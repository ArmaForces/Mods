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
private _conditionEventSuccess = _taskNamespace getVariable [format ["conditionEvent%1", _finishType], ""];
private _conditionEventEmpty = _conditionEventSuccess isEqualTo "";

switch (true) do {
    // No event specified and no code condition
    case (_conditionEventEmpty && {_conditionCodeEmpty}): {
        // Do nothing
    };

    // No event specified and code condition is given
    case (_conditionEventEmpty && {!_conditionCodeEmpty}): {
        // Wait until code condition is true
        [_conditionCodeSuccess, {
            params ["_taskNamespace", "_callbackFunction"];
            [_taskNamespace] call _callbackFunction;
        }, [_taskNamespace, _callbackFunction]] call CBA_fnc_waitUntilAndExecute;
    };

    // Event is specified and conditionCode is not filled
    case (!_conditionEventEmpty && {_conditionCodeEmpty}): {
        // Create EventHandler
        [_conditionEventSuccess, {
            _thisArgs params ["_taskNamespace", "_callbackFunction"];
            [_taskNamespace] call _callbackFunction;
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        }, [_taskNamespace, _callbackFunction]] call CBA_fnc_addEventHandlerArgs;
    };

    // Event is specified and conditionCode is filled
    default {
        // Wait until code condition is true
        [_conditionCodeSuccess, {
            params ["_taskNamespace", "_callbackFunction"];
            [_taskNamespace] call _callbackFunction;
        }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

        // Create EventHandler
        [_conditionEventSuccess, {
            _thisArgs params ["_taskNamespace", "_callbackFunction"];
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        }, _taskNamespace] call CBA_fnc_addEventHandlerArgs;
    };
};

nil
