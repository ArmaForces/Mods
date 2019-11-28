#include "script_component.hpp"
/*
 * Author: veteran29
 * onUnload handler for modal
 *
 * Arguments:
 * 0: Modal display <DISPLAY>
 * 1: Exit code     <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_display", "_exitCode"];

[_display, _exitCode] call (_display getVariable QGVAR(onClose));

nil
