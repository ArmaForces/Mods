#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Reads title and description from given task namespace.
 *
 * Arguments:
 * 0: Task config name <STRING>
 * 1: Task namespace <CBA_NAMESPACE>
 *
 * Return Value:
 * 0: Mission Title <STRING>
 * 1: Mission Description <STRING>
 *
 * Example:
 * None
 *
 * Public: No
 */

params ["_taskConfigName", "_taskNamespace"];

private _component = _taskNamespace getVariable ["taskComponent", ""];

if (_component isNotEqualTo "") then {
    [
        _taskNamespace getVariable ["title", format [DEFAULT_TITLE_FORMAT_WITH_COMPONENT, _component, _taskConfigName]],
        _taskNamespace getVariable ["description", format [DEFAULT_DESCRIPTION_FORMAT_WITH_COMPONENT, _component, _taskConfigName]]
    ]
} else {
    [
        _taskNamespace getVariable ["title", format [DEFAULT_TITLE_FORMAT, _taskConfigName]],
        _taskNamespace getVariable ["description", format [DEFAULT_DESCRIPTION_FORMAT, _taskConfigName]]
    ]
};
