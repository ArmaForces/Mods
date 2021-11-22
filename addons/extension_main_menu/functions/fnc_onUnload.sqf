#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
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
