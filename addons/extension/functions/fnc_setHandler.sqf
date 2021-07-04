#include "script_component.hpp"
/*
 * Author: veteran29
 * Set extension callback handler function.
 *
 * Arguments:
 * 0: Function name (specified by extension) <STRING>
 * 1: Callback handler, data sent by extension provided in _this <CODE>
 *
 * Return Value:
 * Handler was registered <BOOL>
 *
 * Example:
 * ["set_current_mission_id", {GVAR(currentMissionId) = _this}] call afm_extension_fnc_addHandler
 *
 * Public: Yes
 */

params [
    ["_function", "", [""]],
    ["_callback", {}, [{}]]
];

if (_function isEqualTo "") exitWith {
    ERROR("Function name not specified, handler not set!");
    false
};

if (_callback isEqualTo {}) exitWith {
    ERROR("Callback not specified, handler not set!");
    false
};

GVAR(handlers) set [_function, _callback];

true
