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
private _conditionCodeFinishValue = _taskNamespace getVariable [format ["conditionCode%1", _finishType], "true"];
private _conditionCodeFinish = compile _conditionCodeFinishValue;
private _conditionCodeEmpty = (_conditionCodeFinishValue isEqualTo "true" || {_conditionCodeFinishValue isEqualTo ""});

// Load event condition
private _conditionEventsFinish = _taskNamespace getVariable [format ["conditionEvents%1", _finishType], []];
private _conditionEventsEmpty = _conditionEventsFinish isEqualTo [];

if (!_conditionEventsEmpty) then {
    // Create EventHandler for all events
    {
        [_x, {
            _thisArgs params ["_taskNamespace", "_finishType", "_callbackFunction"];
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
            // Increase counter how many events already fired
            private _counterVariable = format ["condition%1EventsFired", _finishType];
            private _currentEventsFired = _taskNamespace getVariable [_counterVariable, 0];
            INC(_currentEventsFired);
            _taskNamespace setVariable [_counterVariable, _currentEventsFired];
            // Check if events requirements are met
            if (_currentEventsFired < (_taskNamespace getVariable [format ["conditionEvents%1Required", _finishType], 1])) exitWith {};
            // Run callback
            [_taskNamespace, _finishType] call _callbackFunction;
        }, [_taskNamespace, _finishType, _callbackFunction]] call CBA_fnc_addEventHandlerArgs;
    } forEach _conditionEventsFinish;
};

if (!_conditionCodeEmpty) then {
    // Wait until code condition is true
    [_conditionCodeFinish, {
        params ["_taskNamespace", "_finishType", "_callbackFunction"];
        [_taskNamespace, _finishType] call _callbackFunction;
    }, [_taskNamespace, _finishType, _callbackFunction]] call CBA_fnc_waitUntilAndExecute;
};

nil
