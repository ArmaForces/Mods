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
private _conditionEventsShow = _taskNamespace getVariable ["conditionEventsShow", []];
private _conditionEventsEmpty = _conditionEventsShow isEqualTo [];

if (_conditionEventsEmpty && {_conditionCodeEmpty}) exitWith {
    // Show task
    [{
        private _taskNamespace = _this;
        [_taskNamespace] call FUNC(handleOnShow);
    }, _taskNamespace] call CBA_fnc_execNextFrame;
};

if (!_conditionCodeEmpty) then {
    // Wait until code condition is true
    [_conditionCodeShow, {
        private _taskNamespace = _this;
        [_taskNamespace] call FUNC(handleOnShow);
    }, _taskNamespace] call CBA_fnc_waitUntilAndExecute;
};

if (!_conditionEventsEmpty) then {
    // Create EventHandler for all events
    {
        [_x, {
            private _taskNamespace = _thisArgs;
            // Remove EH so it can be triggered only once for given task.
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
            // Increase counter how many events already fired
            private _currentEventsFired = _taskNamespace getVariable ["conditionShowEventsFired", 0];
            INC(_currentEventsFired);
            _taskNamespace setVariable ["conditionShowEventsFired", _currentEventsFired];
            // Check if events requirements are met
            if (_currentEventsFired < (_taskNamespace getVariable ["conditionEventsShowRequired", 1])) exitWith {};
            // Run onShow
            [_taskNamespace] call FUNC(handleOnShow);
        }, _taskNamespace] call CBA_fnc_addEventHandlerArgs;
    } forEach _conditionEventsShow;
};

nil
