#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle change of current foreground display/main display going to background.
 *
 * Arguments:
 * 0: Main display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_display"];
TRACE_1("onUnload",_display);

terminate (uiNamespace getVariable [QGVAR(loop), scriptNull]);
uiNamespace setVariable [QGVAR(extEh), -1];
