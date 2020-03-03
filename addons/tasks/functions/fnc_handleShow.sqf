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

// Load show condition
private _conditionCodeShow = compile (_taskNamespace getVariable ["conditionCodeShow", "true"]);

[_conditionCodeShow, {
        private _taskNamespace = _this;
        [_taskNamespace] call FUNC(handleOnShow);
}, _taskNamespace] call CBA_fnc_waitUntilAndExecute;

// Load show event condition
private _conditionEventShow = _taskNamespace getVariable ["conditionEventShow", ""];

// No events specified
if (_conditionEventShow isEqualTo "") exitWith {nil};

[_conditionEventShow, {
    private _taskNamespace = _thisArgs;
    [_taskNamespace] call FUNC(handleOnShow);
    // Remove EH so it can be triggered only once for given task.
    [_thisType, _thisId] call CBA_fnc_removeEventHandler;
}, _taskNamespace] call CBA_fnc_addEventHandlerArgs;

nil
